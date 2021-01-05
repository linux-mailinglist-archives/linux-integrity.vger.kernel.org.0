Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893B12EB412
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbhAEUUd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 15:20:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44770 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbhAEUUd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 15:20:33 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4EC8F20B7192;
        Tue,  5 Jan 2021 12:19:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EC8F20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609877991;
        bh=IKyEACqURz7aiA8WwbIBs+p508b8dbFdLA2jOKEi53M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rqpMMFLsOgOvteqTCOiHYA1bQJXpwvIhvboD9bb7s+fsUMt3wSRimeXRbQ8W0HU6d
         Q2QiCdk1oTpLhur7BLjHbmYqTi8oWIhV40fXVrDIQc6BlOuG/KtkoEcMq4cH3iUDFT
         f+6MckHEUPThbhv5uf9Hug/0elLi8IA242CXQ8Ls=
Subject: Re: [PATCH v9 3/8] IMA: define a hook to measure kernel integrity
 critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-4-tusharsu@linux.microsoft.com>
 <5ae72a76664ce7011d3041689efbfe1a2c67d44f.camel@linux.ibm.com>
 <9afab02b-4b02-485d-cca2-bdf8b1cf87e7@linux.microsoft.com>
 <3b5dd02fab216746409ccede82f51382539824d3.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <4907940a-ed56-3fa7-67bf-b75d238efacb@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 12:19:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3b5dd02fab216746409ccede82f51382539824d3.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2021-01-05 12:16 p.m., Mimi Zohar wrote:
> On Tue, 2021-01-05 at 12:01 -0800, Tushar Sugandhi wrote:
>>
>>>> data. However, various data structures, policies, and states
>>>
>>> Here and everywhere else, there are two blanks after a period.
>>>
>> I checked this patch file in multiple text editors, but couldn’t find
>> any instance of period followed by two spaces. I will double check again
>> all the patches for multiple spaces, and remove them if any.
> 
> There should be two blanks after a period, not one blank.
> 
> <snip>
> 
>>>> + *
>>>> + * Measure the kernel subsystem data, critical to the integrity of the kernel,
>>>> + * into the IMA log and extend the @pcr.
>>>> + *
>>>> + * Use @event_name to describe the state/buffer data change.
>>>> + * Examples of critical data (@buf) could be various data structures,
>>>> + * policies, and states stored in kernel memory that can impact the integrity
>>>> + * of the system.
>>>> + *
>>>> + * If @measure_buf_hash is set to true - measure hash of the buffer data,
>>>> + * else measure the buffer data itself.
>>>> + * @measure_buf_hash can be used to save space, if the data being measured
>>>> + * is too large.
>>>> + *
>>>> + * The data (@buf) can only be measured, not appraised.
>>>
>>> The "/**" is the start of kernel-doc.  Have you seen anywhere else in
>> My impression was the hooks in ima_main.c e.g. ima_file_free()
>> ima_file_mmap() required the double-asterisk ("/**"), and internal
>> functions like ima_rdwr_violation_check() require a single-asterisk
>> ("/*")
>>
>> kernel-doc.rst suggest the double-asterisk ("/**") for function comment
>> as well.
>>
>> Function documentation
>> ----------------------
>>
>> The general format of a function and function-like macro kernel-doc
>> comment is::
>>
>>     /**
>>      * function_name() - Brief description of function.
>>
>> Please let me know if you still want me to remove the double-asterisk
>> ("/**") here.
> 
> Yes, of course this needs to be kernel-doc and requires "/**"
> 
Thanks for confirming.
>>
>>> the kernel using the @<variable name> in the longer function
>>> description?  Have you seen this style of longer   function
>>> description?  Refer to Documentation/doc-guide/kernel-doc.rst and other
>>> code for examples.
>>>
>> Thanks. I will remove the prefix "@" from <variable name> in the longer
>> function description.
> 
> Removing the @<variable name> isn't sufficient.  Please look at other
> examples of longer function definitions before reposting.
> 
Yes. Agreed. I will go as per the guidance in kernel-doc.rst

Thanks again,
Tushar


> thanks,
> 
> Mimi
> 
