Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0E4F6592
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiDFQa6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiDFQah (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 12:30:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6A41FD2C;
        Tue,  5 Apr 2022 18:48:21 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KY6pd6wRQz1HBSF;
        Wed,  6 Apr 2022 09:47:53 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 09:48:19 +0800
Message-ID: <84ba6fb8-45e1-461b-1aa3-c97f065cbe60@huawei.com>
Date:   Wed, 6 Apr 2022 09:48:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ima: remove template "ima" as the compiled default
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
CC:     <dmitry.kasatkin@gmail.com>, <roberto.sassu@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiujianfeng@huawei.com>,
        <wangweiyang2@huawei.com>
References: <20220321074737.138002-1-guozihua@huawei.com>
 <5c3565f5a46f5728873c9aedd634699ba171fe98.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <5c3565f5a46f5728873c9aedd634699ba171fe98.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/4/5 4:22, Mimi Zohar wrote:
> Hi Guo,
> 
> The Subject line above sounds like the default template is currently
> "ima", which it isn't.   Perhaps "ima: remove the IMA_TEMPLATE Kconfig
> option" is more accurate.
> 
> On Mon, 2022-03-21 at 15:47 +0800, GUO Zihua wrote:
>> Template "ima" is a legacy template which limits the hash algorithm to
>> either sha1 or md5. None of them should be considered "strong" these
>> days. Besides, allowing template "ima" as the compiled default would
>> also cause the following issue: the cmdline option "ima_hash=" must be
>> behind "ima_template=", otherwise "ima_hash=" might be rejected.
>>
> 
> True "ima" is a legacy template, but the purpose of removing the
> IMA_TEMPLATE from the Kconfig is to address the remaining boot command
> line ordering issue not previously addressed.  This is reasonable
> because the "ima" template is limited to SHA1 and MD5.  If someone
> still needs to use the "ima" template, "ima_template=ima" could still
> be specified on the boot command line.
> 
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
>> With template "ima" removed from the compiled default, we ensure that the
>> default tempalte would at least be "ima-ng" which allows for basically
>> any hash algorithm.
>>
>> This change would not break the algorithm compatibility checking for
>> IMA.
>>
>> Fixes: 4286587dccd43 ("ima: add Kconfig default measurement list template")
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>> ---
>>   security/integrity/ima/Kconfig | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index f3a9cc201c8c..9513df2ac19e 100644
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
> 
> The IMA_TEMPLATE definition is removed, but leaves a few references to
> it.

Thank you very much for the detailed review Mimi! I'll fix these right now.

-- 
Best
GUO Zihua
