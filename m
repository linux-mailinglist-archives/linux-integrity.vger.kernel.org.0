Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5C391270
	for <lists+linux-integrity@lfdr.de>; Wed, 26 May 2021 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhEZIgK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 May 2021 04:36:10 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47750 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbhEZIgK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 May 2021 04:36:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ua9IOSJ_1622018077;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ua9IOSJ_1622018077)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 16:34:37 +0800
Subject: Re: [PATCH ima-evm-utils v2] ima-evm-utils: Support SM2 algorithm for
 sign and verify
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210211052241.91068-1-tianjia.zhang@linux.alibaba.com>
 <c4c8e4dc150440de6d6b97c8bb06cea367d98bad.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <610b0d3a-1fd0-cda5-2b86-bbfeb387361b@linux.alibaba.com>
Date:   Wed, 26 May 2021 16:34:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c4c8e4dc150440de6d6b97c8bb06cea367d98bad.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2/18/21 10:06 PM, Mimi Zohar wrote:
> Hi Tianjia,
> 
> On Thu, 2021-02-11 at 13:22 +0800, Tianjia Zhang wrote:
>> The combination of SM2 and SM3 algorithms has been implemented in the
>> kernel. At present, the ima-evm-utils signature tool does not support
>> this combination of algorithms. Because in the current version of
>> OpenSSL 1.1.1, the SM2 algorithm and the public key using the EC
>> algorithm share the same ID 'EVP_PKEY_EC', and the specific algorithm
>> can only be distinguished by the curve name used. This patch supports
>> this feature.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   src/libimaevm.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/src/libimaevm.c b/src/libimaevm.c
>> index fa6c278..589dd09 100644
>> --- a/src/libimaevm.c
>> +++ b/src/libimaevm.c
>> @@ -518,6 +518,16 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
>>   		return -1;
>>   	}
>>   
>> +#ifdef EVP_PKEY_SM2
>> +	/* If EC key are used, check whether it is SM2 key */
>> +	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
>> +		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
>> +		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
>> +		if (curve == NID_sm2)
>> +			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
>> +	}
>> +#endif
>> +
> 
> Suppose a file is signed on one system and verified on another.  What
> happens if EVP_PKEY_SM2 is defined on one system, but not the other?
> Since the signing/verifying code do exactly the same thing, a
> sign_verify test wouldn't detect the problem.   In anycase, please
> define a sign_verify test.
> 
> thanks,
> 
> Mimi
> 
> 

Sorry for the late reply.

This will cause verify to fail, I will add some sm2 tests in the next patch.

Best regards,
Tianjia
