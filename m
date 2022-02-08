Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66BF4AD6CD
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Feb 2022 12:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiBHL3r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Feb 2022 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355553AbiBHJps (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 04:45:48 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BD7C03FEC0;
        Tue,  8 Feb 2022 01:45:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V3vxzfq_1644313541;
Received: from 30.240.99.213(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V3vxzfq_1644313541)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Feb 2022 17:45:42 +0800
Message-ID: <8ca7c447-3fd6-612b-f903-3111eaddf6e6@linux.alibaba.com>
Date:   Tue, 8 Feb 2022 17:45:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] KEYS: asymmetric: enforce SM2 signature use pkey algo
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20220201003414.55380-1-ebiggers@kernel.org>
 <20220207114327.7929-1-tianjia.zhang@linux.alibaba.com>
 <YgIBKeFkiKtD1unK@sol.localdomain>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YgIBKeFkiKtD1unK@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On 2/8/22 1:35 PM, Eric Biggers wrote:
> On Mon, Feb 07, 2022 at 07:43:27PM +0800, Tianjia Zhang wrote:
>> The signature verification of SM2 needs to add the Za value and
>> recalculate sig->digest, which requires the detection of the pkey_algo
>> in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
>> field in sig is attacker-controlled and should be use pkey->pkey_algo
>> instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
>> will also cause signature verification failure.
>>
>> The software_key_determine_akcipher() already forces the algorithms
>> are matched, so the SM3 algorithm is enforced in the SM2 signature,
>> although this has been checked, we still avoid using any algorithm
>> information in the signature as input.
>>
>> Reported-by: Eric Biggers <ebiggers@google.com>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> Can you add a Fixes tag?
> 

Thanks, the v2 patch with Fixes tag added has been appended to your
v2 series.

>> ---
>>   crypto/asymmetric_keys/public_key.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
>> index a603ee8afdb8..ea9a5501f87e 100644
>> --- a/crypto/asymmetric_keys/public_key.c
>> +++ b/crypto/asymmetric_keys/public_key.c
>> @@ -309,7 +309,8 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
>>   	if (ret)
>>   		return ret;
>>   
>> -	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
>> +	/* SM2 signatures always use the SM3 hash algorithm */
>> +	tfm = crypto_alloc_shash("sm3", 0, 0);
>>   	if (IS_ERR(tfm))
>>   		return PTR_ERR(tfm);
>>   
>> @@ -414,8 +415,7 @@ int public_key_verify_signature(const struct public_key *pkey,
>>   	if (ret)
>>   		goto error_free_key;
>>   
>> -	if (sig->pkey_algo && strcmp(sig->pkey_algo, "sm2") == 0 &&
>> -	    sig->data_size) {
>> +	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
>>   		ret = cert_sig_digest_update(sig, tfm);
>>   		if (ret)
>>   			goto error_free_key;
>> -- 
> 
> This is an improvement, but do you also have a plan to address the problem where
> the code allows the "Za" hash step to be skipped?  The definitions of SM2 that I
> could find require that step.  So, it is unclear that the algorithm with that
> step skipped is still SM2, and how its security relates to that of the SM2
> algorithm as actually defined.
> 
> - Eric
The design of this Za has indeed brought us a lot of trouble, which
makes the two separate steps of calculating the hash and signature
forced to be coupled together. At present, it is a better way to design
skipping Za as an option. I will try to do this, which of course also
includes application layer libraries, like openssl.

Best regards,
Tianjia
