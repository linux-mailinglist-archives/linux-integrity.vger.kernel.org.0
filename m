Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1049C151
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 03:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiAZC2K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 21:28:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35870 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiAZC2K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 21:28:10 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jk70Q1cHvzcckc;
        Wed, 26 Jan 2022 10:27:18 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:28:07 +0800
Message-ID: <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
Date:   Wed, 26 Jan 2022 10:28:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <roberto.sassu@huawei.com>, <wangweiyang2@huawei.com>,
        <xiujianfeng@huawei.com>, <linux-integrity@vger.kernel.org>
References: <20220125090237.120357-1-guozihua@huawei.com>
 <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/1/26 9:07, Mimi Zohar wrote:
> On Tue, 2022-01-25 at 17:02 +0800, GUO Zihua wrote:
>> From: Guo Zihua <guozihua@huawei.com>
>>
>> Commandline parameter ima_hash= and ima_template= has order requirement
>> for them to work correctly together. Namely ima_hash= must be
>> specified after ima_template=, otherwise ima_template= will be ignored.
>>
>> The reason is that when handling ima_hash=, ima template would be set to
>> the default value if it has not been initialized already, and that value
>> cannot be changed afterwards by ima_template=.
>>
>> This patch adds this limitation to the documentation.
>>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Signed-off-by: Guo Zihua <guozihua@huawei.com>
> 
> This issue should be limited to the original "ima" template format,
> which only supports hash algorithms of 20 bytes or less.  The "ima_ng"
> template has been the default since larger digests and templates were
> upstreamed back in Linux 3.13[1]. Do you really still have kernels
> built with the original "ima" template?
> 
> [1] Refer to commit 4286587dccd4 ("ima: add Kconfig default measurement
> list template").
> 
> thanks,
> 
> Mimi

Hi Mimi,

The issue is that if ima_hash is specified before ima_template, 
ima_template will not work. Built-in default only affects which template 
will be loaded eventually.

For example, if the built-in default template is ima-ng and user would 
like to change it to ima-sig with sha512 by specifying "ima_hash=sha512 
ima_template=ima-sig" in command line, the result will be ima-ng with 
sha512, not ima-sig with sha512.

-- 
Best
GUO Zihua

> 
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index f5a27f067db9..1b5aa6ca65f8 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1843,6 +1843,10 @@
>>   			The list of supported hash algorithms is defined
>>   			in crypto/hash_info.h.
>>   
>> +			This parameter must be specified after ima_template=,
>> +			as it would set the default template and that cannot be
>> +			changed by ima_template= afterwards.
>> +
>>   	ima_policy=	[IMA]
>>   			The builtin policies to load during IMA setup.
>>   			Format: "tcb | appraise_tcb | secure_boot |
>> @@ -1879,6 +1883,9 @@
>>   			Formats: { "ima" | "ima-ng" | "ima-sig" }
>>   			Default: "ima-ng"
>>   
>> +			This parameter must be specified before ima_hash=.
>> +			Please refer to ima_hash= for further explanation.
>> +
>>   	ima_template_fmt=
>>   			[IMA] Define a custom template format.
>>   			Format: { "field1|...|fieldN" }
> 
> 
> .
