Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9774BD3EB
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 03:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbiBUCoI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 21:44:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344030AbiBUCoH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 21:44:07 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59D25EA0;
        Sun, 20 Feb 2022 18:43:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V5-OM3N_1645411419;
Received: from 30.240.98.212(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V5-OM3N_1645411419)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Feb 2022 10:43:40 +0800
Message-ID: <17d1a498-6b27-c61b-787d-667abbbb955b@linux.alibaba.com>
Date:   Mon, 21 Feb 2022 10:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] KEYS: asymmetric: enforce SM2 signature use pkey algo
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Biggers <ebiggers@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20220201003414.55380-1-ebiggers@kernel.org>
 <20220207114327.7929-1-tianjia.zhang@linux.alibaba.com>
 <YhLvtVT89tAjGnqw@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YhLvtVT89tAjGnqw@kernel.org>
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

Hi Jarkko,

On 2/21/22 9:49 AM, Jarkko Sakkinen wrote:
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
> 
> Why not simply fail when sig->hash_algo != "sm3"?
> 
> BR, Jarkko

This series of Eric's patch 2/2 has done this check.

Best regards,
Tianjia
