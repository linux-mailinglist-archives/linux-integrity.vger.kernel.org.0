Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8630A41F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 10:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhBAJMG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 04:12:06 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51441 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232629AbhBAJLy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 04:11:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNXo6W-_1612170659;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UNXo6W-_1612170659)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 17:10:59 +0800
Subject: Re: [PATCH ima-evm-utils] ima-evm-utils: ima_sign supports SM2 and
 SM3 algorithm combination
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210131032721.79050-1-tianjia.zhang@linux.alibaba.com>
 <20210131174845.gbvqd5l5o2tibpbf@altlinux.org>
 <20210131175623.pbtdmeyvyeoenk3j@altlinux.org>
 <20210131185225.jemxbsyweq4vm7ex@altlinux.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <02410651-5405-d80c-8ae5-b86c435f66b4@linux.alibaba.com>
Date:   Mon, 1 Feb 2021 17:10:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210131185225.jemxbsyweq4vm7ex@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2/1/21 2:52 AM, Vitaly Chikunov wrote:
> Tianjia,
> 
> On Sun, Jan 31, 2021 at 08:56:23PM +0300, Vitaly Chikunov wrote:
>> On Sun, Jan 31, 2021 at 08:48:46PM +0300, Vitaly Chikunov wrote:
>>> On Sun, Jan 31, 2021 at 11:27:21AM +0800, Tianjia Zhang wrote:
>>>> The combination of SM2 and SM3 algorithms has been implemented in the
>>>> kernel. At present, the ima-evm-utils signature tool does not support
>>>> this combination of algorithms. This is because SM2 sign require a
>>>> USERID, which requires the use of a higher-level sign functions of
>>>> OpenSSL. this patch use the EVP_DigestSign series of functions to
>>>> sign to support various signature algorithm combinations.
>>>>
>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>> ---
>>>>   src/libimaevm.c | 37 +++++++++++++++++++++++++++++++------
>>>>   1 file changed, 31 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>>>> index fa6c278..89b9b88 100644
>>>> --- a/src/libimaevm.c
>>>> +++ b/src/libimaevm.c
>>>> @@ -891,6 +891,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>>>>   	EVP_PKEY *pkey;
>>>>   	char name[20];
>>>>   	EVP_PKEY_CTX *ctx = NULL;
>>>> +	EVP_MD_CTX *mctx = NULL;
>>>>   	const EVP_MD *md;
>>>>   	size_t sigsize;
>>>>   	const char *st;
>>>> @@ -932,24 +933,47 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>>>>   		return -1;
>>>>   	}
>>>>   
>>>> +#if OPENSSL_VERSION_NUMBER < 0x30000000
>>>
>>> Perhaps, this check is not needed at all if it isn't enabled for new
>>> openssl?
>>>
>>>
>>>> +	/*
>>>> +	 * SM2 and SM3 should go together. If SM3 hash algorithm and EC private
>>>> +	 * key are used at the same time, check whether it is SM2 private key.
>>>> +	 */
>>>> +	if (hdr->hash_algo == PKEY_HASH_SM3_256 && EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
>>>> +		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
>>>> +		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
>>>> +		if (curve == NID_sm2)
> 
> Also, this patch does not compile on openssl 1.1.0 because
> NID_sm2 and EVP_PKEY_SM2 are not defined.
> 

OPENSSL 1.1.0 version does not support SM2, the macro detection of 
OPENSSL_VERSION should be added here.

>>>> +			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
>>>> +	}
>>>> +#endif
>>>> +
>>>>   	calc_keyid_v2(&keyid, name, pkey);
>>>>   	hdr->keyid = keyid;
>>>>   
>>>>   	st = "EVP_PKEY_CTX_new";
>>>>   	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
>>>>   		goto err;
>>>> -	st = "EVP_PKEY_sign_init";
>>>> -	if (!EVP_PKEY_sign_init(ctx))
>>>> +	st = "EVP_MD_CTX_new";
>>>> +	if (!(mctx = EVP_MD_CTX_new()))
>>>>   		goto err;
>>>> +	if (EVP_PKEY_id(pkey) == EVP_PKEY_SM2) {
>>>> +		st = "EVP_PKEY_CTX_set1_id";
>>>> +		/* Set SM2 default userid */
>>>> +		if (!EVP_PKEY_CTX_set1_id(ctx, "1234567812345678", 16))
>>>
>>> You cannot call EVP_PKEY_CTX_set1_id for EVP_PKEY_sign's ctx?
>>> I don't really get the API change. Can you explain more this
>>> requirement?
>>
>> EVP_PKEY_sign should be able to sign with any algo, unless there is
>> openssl bug. Is there bug preventing SM2 signing with EVP_PKEY_sign?
>>
The SM2 signature is different from the conventional signature 
algorithm. For example, to sign a message, not the hash signature of the 
message, but the hash signature after adding the message to ZA. The ZA 
value includes the SM3 hash of the following data, including some 
parameters and public keys of ECC, and the USERID passed in by the user.
it also specified in
https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02.

It seems that there is no good way. I can only add the calculation of 
the ZA value when calculating the file hash.

>>>> +			goto err;
>>>> +	}
>>>> +	EVP_MD_CTX_set_pkey_ctx(mctx, ctx);
>>>>   	st = "EVP_get_digestbyname";
>>>>   	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
>>>>   		goto err;
>>>> -	st = "EVP_PKEY_CTX_set_signature_md";
>>>> -	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
>>>> +	st = "EVP_DigestSignInit";
>>>> +	if (!EVP_DigestSignInit(mctx, NULL, md, NULL, pkey))
>>>> +		goto err;
>>>> +	st = "EVP_DigestSignUpdate";
>>>> +	if (!EVP_DigestSignUpdate(mctx, hash, size))
>>>>   		goto err;
>>>> -	st = "EVP_PKEY_sign";
>>>> +	st = "EVP_DigestSignFinal";
>>>>   	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
>>>> -	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
> 
> Also, this conversion to EVP_DigestSign is incorrect, because
> EVP_PKEY_sign does not hash the data (and expected to work over a ready
> digest, see man EVP_PKEY_sign). While EVP_DigestSignFinal does hash the
> data.
> 
> You should really try to run `make check` before sending patches.
> 
> Thanks,
> 

This is indeed a problem, thanks for pointing it out. Or to add ZA, I 
ignored this, maybe I should implement a version that does not support 
ZA first. Or do you have any better suggestions?

Thanks for your reply.

Best regards,
Tianjia

>>>> +	if (!EVP_DigestSignFinal(mctx, hdr->sig, &sigsize))
>>>>   		goto err;
>>>>   	len = (int)sigsize;
>>>>   
>>>> @@ -964,6 +988,7 @@ err:
>>>>   			ERR_reason_error_string(ERR_peek_error()), st);
>>>>   		output_openssl_errors();
>>>>   	}
>>>> +	EVP_MD_CTX_free(mctx);
>>>>   	EVP_PKEY_CTX_free(ctx);
>>>>   	EVP_PKEY_free(pkey);
>>>>   	return len;
>>>> -- 
>>>> 2.19.1.3.ge56e4f7
