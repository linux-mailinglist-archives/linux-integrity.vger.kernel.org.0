Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD049C4AB
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 08:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiAZHlt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 02:41:49 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32121 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiAZHls (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 02:41:48 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JkFvs29zrz8wdR;
        Wed, 26 Jan 2022 15:38:49 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 15:41:46 +0800
Message-ID: <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
Date:   Wed, 26 Jan 2022 15:41:45 +0800
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
 <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
 <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/1/26 12:37, Mimi Zohar wrote:
> On Wed, 2022-01-26 at 10:28 +0800, Guozihua (Scott) wrote:
>>
>> On 2022/1/26 9:07, Mimi Zohar wrote:
>>> On Tue, 2022-01-25 at 17:02 +0800, GUO Zihua wrote:
>>>> From: Guo Zihua <guozihua@huawei.com>
>>>>
>>>> Commandline parameter ima_hash= and ima_template= has order requirement
>>>> for them to work correctly together. Namely ima_hash= must be
>>>> specified after ima_template=, otherwise ima_template= will be ignored.
>>>>
>>>> The reason is that when handling ima_hash=, ima template would be set to
>>>> the default value if it has not been initialized already, and that value
>>>> cannot be changed afterwards by ima_template=.
>>>>
>>>> This patch adds this limitation to the documentation.
>>>>
>>>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>> Signed-off-by: Guo Zihua <guozihua@huawei.com>
>>>
>>> This issue should be limited to the original "ima" template format,
>>> which only supports hash algorithms of 20 bytes or less.  The "ima_ng"
>>> template has been the default since larger digests and templates were
>>> upstreamed back in Linux 3.13[1]. Do you really still have kernels
>>> built with the original "ima" template?
>>>
>>> [1] Refer to commit 4286587dccd4 ("ima: add Kconfig default measurement
>>> list template").
>>
>> Hi Mimi,
>>
>> The issue is that if ima_hash is specified before ima_template,
>> ima_template will not work. Built-in default only affects which template
>> will be loaded eventually.
>>
>> For example, if the built-in default template is ima-ng and user would
>> like to change it to ima-sig with sha512 by specifying "ima_hash=sha512
>> ima_template=ima-sig" in command line, the result will be ima-ng with
>> sha512, not ima-sig with sha512.
> 
> Ok.  Once the template name is set, ima_template_setup() doesn't allow
> it to be reset.  This was probably done to set the template name to the
> first occurance of "ima_template=" on the boot command line.  This
> concern could be addressed by defining a static local variable in
> ima_template_setup().
> 
> So either documenting the ordering requirement, as you've done, or
> allowing the template_name to be reset are fine.
> 
> thanks,
> 
> Mimi
> 
> .

The main issue lies in ima_template_desc_current called by hash_setup, 
which does not just read ima_template global variable, but also tries to 
set it if that hasn't been done already. Causing ima_template_setup to quit.

-- 
Best
GUO Zihua
