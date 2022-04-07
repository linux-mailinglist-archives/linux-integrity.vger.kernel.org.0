Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10664F71FC
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 04:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiDGCUJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 22:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiDGCUH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 22:20:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB21830578;
        Wed,  6 Apr 2022 19:18:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYlNL0GsVzDqTS;
        Thu,  7 Apr 2022 10:15:46 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 10:18:05 +0800
Message-ID: <2760cfec-6866-5a7b-99c6-1831aae26c58@huawei.com>
Date:   Thu, 7 Apr 2022 10:18:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ima: remove the IMA_TEMPLATE Kconfig option
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
CC:     <dmitry.kasatkin@gmail.com>, <roberto.sassu@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220406061624.173584-1-guozihua@huawei.com>
 <35c38676a8b464a0fb7e4842de5108e08cb53380.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <35c38676a8b464a0fb7e4842de5108e08cb53380.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/4/6 20:08, Mimi Zohar wrote:
> On Wed, 2022-04-06 at 14:16 +0800, GUO Zihua wrote:
>> It is discovered thatO allowing template "ima" as the compiled default
>> would cause the following issue: the boot command line option
>> "ima_hash=" must be behind "ima_template=", otherwise "ima_hash=" might
>> be rejected.
> 
> The format of a proper patch description describes the current status,
> provides a succinct problem description, followed by the solution.
> 
> The original 'ima' measurement list template contains a hash, defined
> as 20 bytes, and a null terminated pathname, limited to 255
> characters.  Other measurement list templates permit both larger hashes
> and longer pathnames.  When the "ima" template is configured as the
> default, a new measurement list template (ima_template=) must be
> specified before specifying a larger hash algorithm (ima_hash=) on the
> boot command line.
> 
> To avoid this boot command line ordering issue, remove the legacy "ima"
> template configuration option, allowing it to still be specified on the
> boot command line.
> 
>>
>> The root cause of this issue is that during the processing of ima_hash,
>> we would try to check whether the hash algorithm is compatible with the
>> template. If the template is not set at the moment we do the check, we
>> check the algorithm against the compiled default template. If the
>> complied default template is "ima", then we reject any hash algorithm
>> other than sha1 and md5.
>>
>> For example, if the compiled default template is "ima", and the default
>> algorithm is sha1 (which is the current default). In the cmdline, we put
>> in "ima_hash=sha256 ima_template=ima-ng". The expected behavior would be
>> that ima starts with ima-ng as the template and sha256 as the hash
>> algorithm. However, during the processing of "ima_hash=",
>> "ima_template=" has not been processed yet, and hash_setup would check
>> the configured hash algorithm against the compiled default: ima, and
>> reject sha256. So at the end, the hash algorithm that is actually used
>> will be sha1.
>>
>> With template "ima" removed from the compiled default, we ensure that
>> the default tempalte would at least be "ima-ng" which allows for
>> basically any hash algorithm. Users who needs to use "ima" template
>> could still do it by specifying "ima_template=ima" in boot command line.
>>
>> This change would not break the algorithm compatibility checking for
>> IMA.
>>
>> Fixes: 4286587dccd43 ("ima: add Kconfig default measurement list template")
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>> ---
>>   security/integrity/ima/Kconfig | 22 +++++++++-------------
>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index f3a9cc201c8c..f392cac7a7d1 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -65,14 +65,11 @@ choice
>>   	help
>>   	  Select the default IMA measurement template.
>>   
>> -	  The original 'ima' measurement list template contains a
>> -	  hash, defined as 20 bytes, and a null terminated pathname,
>> -	  limited to 255 characters.  The 'ima-ng' measurement list
>> -	  template permits both larger hash digests and longer
>> -	  pathnames.
>> -
>> -	config IMA_TEMPLATE
>> -		bool "ima"
>> +	  The 'ima-ng' measurement list template permits various hash
>> +	  digests and long pathnames. The compiled default template
>> +	  can be overwritten using the kernel command line
>> +	  'ima_template=' option.
>> +
> 
> Other than perhaps changing "contains" to "contained", there's no
> reason for changing the text.  Adding an additional line is fine - The
> configured default template can be replaced by specifying
> "ima_template="  on the boot command line.
> 
>>   	config IMA_NG_TEMPLATE
>>   		bool "ima-ng (default)"
>>   	config IMA_SIG_TEMPLATE
>> @@ -82,7 +79,6 @@ endchoice
>>   config IMA_DEFAULT_TEMPLATE
>>   	string
>>   	depends on IMA
>> -	default "ima" if IMA_TEMPLATE
>>   	default "ima-ng" if IMA_NG_TEMPLATE
>>   	default "ima-sig" if IMA_SIG_TEMPLATE
>>   
>> @@ -102,19 +98,19 @@ choice
>>   
>>   	config IMA_DEFAULT_HASH_SHA256
>>   		bool "SHA256"
>> -		depends on CRYPTO_SHA256=y && !IMA_TEMPLATE
>> +		depends on CRYPTO_SHA256=y
>>   
>>   	config IMA_DEFAULT_HASH_SHA512
>>   		bool "SHA512"
>> -		depends on CRYPTO_SHA512=y && !IMA_TEMPLATE
>> +		depends on CRYPTO_SHA512=y
>>   
>>   	config IMA_DEFAULT_HASH_WP512
>>   		bool "WP512"
>> -		depends on CRYPTO_WP512=y && !IMA_TEMPLATE
>> +		depends on CRYPTO_WP512=y
>>   
>>   	config IMA_DEFAULT_HASH_SM3
>>   		bool "SM3"
>> -		depends on CRYPTO_SM3=y && !IMA_TEMPLATE
>> +		depends on CRYPTO_SM3=y
>>   endchoice
>>   
>>   config IMA_DEFAULT_HASH
> 
> 
> .

Thanks Mimi, will fix those.

-- 
Best
GUO Zihua
