Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F849DAC4
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 07:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiA0Gfv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 01:35:51 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17817 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiA0Gfv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 01:35:51 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JkrR82PsVz9sXf;
        Thu, 27 Jan 2022 14:34:28 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 14:35:48 +0800
Message-ID: <df7fffa1-2068-cb0c-e43e-141ccd125b39@huawei.com>
Date:   Thu, 27 Jan 2022 14:35:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>,
        Xiujianfeng <xiujianfeng@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20220125090237.120357-1-guozihua@huawei.com>
 <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
 <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
 <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
 <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
 <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
 <173fffb6cde54ae4ac7676d18a84c79f@huawei.com>
 <6f0890f135b61c41d81b03bf084ebab1b3e551e1.camel@linux.ibm.com>
 <220a8c9f3ab34f2183c0a88941c145d0@huawei.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <220a8c9f3ab34f2183c0a88941c145d0@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/1/26 22:43, Roberto Sassu wrote:
>> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
>> Sent: Wednesday, January 26, 2022 3:35 PM
>> On Wed, 2022-01-26 at 13:24 +0000, Roberto Sassu wrote:
>>>> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
>>>> Sent: Wednesday, January 26, 2022 1:48 PM
>>>> On Wed, 2022-01-26 at 15:41 +0800, Guozihua (Scott) wrote:
>>>>>
>>>>>
>>>>> The main issue lies in ima_template_desc_current called by hash_setup,
>>>>> which does not just read ima_template global variable, but also tries to
>>>>> set it if that hasn't been done already. Causing ima_template_setup to quit.
>>>>
>>>> Right, which calls ima_init_template_list().  So part of the solution
>>>> could be to conditionally call ima_init_template_list()
>>>> in ima_template_setup().
>>>>
>>>> -       if (ima_template)
>>>> -               return 1;
>>>> -
>>>> -       ima_init_template_list();
>>>> +       if (!ima_template
>>>> +               ima_init_template_list();
>>>>
>>>> Roberto, what do you think?
>>>
>>> Hi Mimi
>>>
>>> I think we wanted to prevent to set a digest algorithm
>>> incompatible with the chosen template.
>>>
>>> If we have in the kernel command line:
>>>
>>> ima_template=ima ima_hash=sha256
>>>
>>> ima_hash_algo would be set to HASH_ALGO_SHA1 despite
>>> the user choice and the template would be set to 'ima'.
>>>
>>> In the opposite case:
>>>
>>> ima_hash=sha256 ima_template=ima
>>>
>>> if the default template is 'ima', then ima_hash_algo would be
>>> set to HASH_ALGO_SHA1. Otherwise, it would be
>>> HASH_ALGO_SHA256. If we allow the template to be set after
>>> the digest algorithm is evaluated, the template selection will
>>> be rejected if the algorithm is incompatible with the template.
>>
>> The only time that would occur is in the unlikely case that the
>> template is being set to "ima".   That sounds reasonable.  In fact we
>> should consider preventing the template format being set to "ima".
> 
> Ok.
> 
>>> I'm trying to remember why we still have the digest recalculation
>>> in ima_eventdigest_init(). Maybe the only possibility is if we
>>> set the template from the policy?
>>
>> The recalculation was relatively recently added in commit 6cc7c266e5b4
>> ("ima: Call ima_calc_boot_aggregate() in ima_eventdigest_init()").
> 
> There is also recalculation for the file digest:
> 
>          hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
>              ima_hash_algo : HASH_ALGO_SHA1;
>          result = ima_calc_file_hash(event_data->file, &hash.hdr);
> 
> I understood that Jonathan already applied the patch. If it is possible
> to make a new patch according to your suggestion, I would ask Zihua
> to do that.
Hi Mimi and Roberto,

I understand that the solution proposed here is to decommission template 
"ima" and potentially removing related algo checks altogether?

-- 
Best
GUO Zihua
