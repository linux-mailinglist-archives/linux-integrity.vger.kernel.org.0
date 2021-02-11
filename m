Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBB53184FC
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 06:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhBKFki (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 00:40:38 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52510 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229648AbhBKFkh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 00:40:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UOP5WBN_1613021994;
Received: from 30.27.210.10(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOP5WBN_1613021994)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Feb 2021 13:39:54 +0800
Subject: Re: [PATCH ima-evm-utils] ima-evm-utils: ima_sign supports SM2 and
 SM3 algorithm combination
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210131032721.79050-1-tianjia.zhang@linux.alibaba.com>
 <20210131174845.gbvqd5l5o2tibpbf@altlinux.org>
 <20210131175623.pbtdmeyvyeoenk3j@altlinux.org>
 <20210131185225.jemxbsyweq4vm7ex@altlinux.org>
 <02410651-5405-d80c-8ae5-b86c435f66b4@linux.alibaba.com>
 <20210201123131.vr2s6v7qp7booz3c@altlinux.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <1f5a7aa9-f765-bb8f-2beb-a04660300f12@linux.alibaba.com>
Date:   Thu, 11 Feb 2021 13:39:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201123131.vr2s6v7qp7booz3c@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2/1/21 8:31 PM, Vitaly Chikunov wrote:
> On Mon, Feb 01, 2021 at 05:10:59PM +0800, Tianjia Zhang wrote:
>>
>>
>> On 2/1/21 2:52 AM, Vitaly Chikunov wrote:
>>> Tianjia,
>>>
>>> On Sun, Jan 31, 2021 at 08:56:23PM +0300, Vitaly Chikunov wrote:
>>>> On Sun, Jan 31, 2021 at 08:48:46PM +0300, Vitaly Chikunov wrote:
>>>>> On Sun, Jan 31, 2021 at 11:27:21AM +0800, Tianjia Zhang wrote:
>>>>>> The combination of SM2 and SM3 algorithms has been implemented in the
>>>>>> kernel. At present, the ima-evm-utils signature tool does not support
>>>>>> this combination of algorithms. This is because SM2 sign require a
>>>>>> USERID, which requires the use of a higher-level sign functions of
>>>>>> OpenSSL. this patch use the EVP_DigestSign series of functions to
>>>>>> sign to support various signature algorithm combinations.
>>>>>>
>>>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>>>> ---
>>>>>>    src/libimaevm.c | 37 +++++++++++++++++++++++++++++++------
>>>>>>    1 file changed, 31 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>>>>>> index fa6c278..89b9b88 100644
>>>>>> --- a/src/libimaevm.c
>>>>>> +++ b/src/libimaevm.c
>>>>>> @@ -891,6 +891,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>>>>>>    	EVP_PKEY *pkey;
>>>>>>    	char name[20];
>>>>>>    	EVP_PKEY_CTX *ctx = NULL;
>>>>>> +	EVP_MD_CTX *mctx = NULL;
>>>>>>    	const EVP_MD *md;
>>>>>>    	size_t sigsize;
>>>>>>    	const char *st;
>>>>>> @@ -932,24 +933,47 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>>>>>>    		return -1;
>>>>>>    	}
>>>>>> +#if OPENSSL_VERSION_NUMBER < 0x30000000
>>>>>
>>>>> Perhaps, this check is not needed at all if it isn't enabled for new
>>>>> openssl?
>>>>>
>>>>>
>>>>>> +	/*
>>>>>> +	 * SM2 and SM3 should go together. If SM3 hash algorithm and EC private
>>>>>> +	 * key are used at the same time, check whether it is SM2 private key.
>>>>>> +	 */
>>>>>> +	if (hdr->hash_algo == PKEY_HASH_SM3_256 && EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
>>>>>> +		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
>>>>>> +		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
>>>>>> +		if (curve == NID_sm2)
>>>
>>> Also, this patch does not compile on openssl 1.1.0 because
>>> NID_sm2 and EVP_PKEY_SM2 are not defined.
>>>
>>
>> OPENSSL 1.1.0 version does not support SM2, the macro detection of
>> OPENSSL_VERSION should be added here.
> 
> Or just #ifdef EVP_PKEY_SM2.
> 
>>
>>>>>> +			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
>>>>>> +	}
>>>>>> +#endif
>>>>>> +
>>>>>>    	calc_keyid_v2(&keyid, name, pkey);
>>>>>>    	hdr->keyid = keyid;
>>>>>>    	st = "EVP_PKEY_CTX_new";
>>>>>>    	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
>>>>>>    		goto err;
>>>>>> -	st = "EVP_PKEY_sign_init";
>>>>>> -	if (!EVP_PKEY_sign_init(ctx))
>>>>>> +	st = "EVP_MD_CTX_new";
>>>>>> +	if (!(mctx = EVP_MD_CTX_new()))
>>>>>>    		goto err;
>>>>>> +	if (EVP_PKEY_id(pkey) == EVP_PKEY_SM2) {
>>>>>> +		st = "EVP_PKEY_CTX_set1_id";
>>>>>> +		/* Set SM2 default userid */
>>>>>> +		if (!EVP_PKEY_CTX_set1_id(ctx, "1234567812345678", 16))
>>>>>
>>>>> You cannot call EVP_PKEY_CTX_set1_id for EVP_PKEY_sign's ctx?
>>>>> I don't really get the API change. Can you explain more this
>>>>> requirement?
>>>>
>>>> EVP_PKEY_sign should be able to sign with any algo, unless there is
>>>> openssl bug. Is there bug preventing SM2 signing with EVP_PKEY_sign?
>>>>
>> The SM2 signature is different from the conventional signature algorithm.
>> For example, to sign a message, not the hash signature of the message, but
>> the hash signature after adding the message to ZA. The ZA value includes the
>> SM3 hash of the following data, including some parameters and public keys of
>> ECC, and the USERID passed in by the user.
>> it also specified in
>> https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02.
> 
> I didn't read the RFC draft yet, but I believe EVP_PKEY_sign should be
> able to sign with any padding scheme (that's why we call
> EVP_PKEY_CTX_set_signature_md, for example, to tell how to encode
> proper padding). Maybe you should ask OpenSSL people for suggestions?
> 
> Thanks,
> 

Thanks for your suggestion, I got some information and will do it in the 
next version of patch.

Best regards,
Tianjia
