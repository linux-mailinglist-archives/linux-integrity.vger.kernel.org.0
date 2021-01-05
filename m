Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94B2EB3DF
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbhAEUCY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 15:02:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42512 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbhAEUCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 15:02:24 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9F2CD20B7192;
        Tue,  5 Jan 2021 12:01:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9F2CD20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609876902;
        bh=LuRYEduYvChRlbzYC2/Eci+VKHXFbnYPuBfxG634eaQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TwYWhJvlcWoHRYd9W5LEwt3SQudk1NOJKu3h3jzY4vxnGtFA3U5SwOKklcDLLfL6Z
         wE/D5gnAyWnmFrSKBDPHWHmYzxAmhFp7OWsuDOyW0Ebj6zxRnaF3QwUgVouwISIHnU
         1gMzF07z/r449EeB/l2yooL63ZybLGL9t9v/hLLY=
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
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <9afab02b-4b02-485d-cca2-bdf8b1cf87e7@linux.microsoft.com>
Date:   Tue, 5 Jan 2021 12:01:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5ae72a76664ce7011d3041689efbfe1a2c67d44f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-12-24 5:04 a.m., Mimi Zohar wrote:
> On Sat, 2020-12-12 at 10:02 -0800, Tushar Sugandhi wrote:
>> IMA provides capabilities to measure file data, and in-memory buffer
> 
> No need for the comma here.
> 
> Up to this patch set, all the patches refer to "buffer data", not "in-
> memory buffer data".  This patch introduces the concept of measuring
> "in-memory buffer data".   Please remove "in-memory" above.
> 
Will update the description accordingly.
>> data. However, various data structures, policies, and states
> 
> Here and everywhere else, there are two blanks after a period.
> 
I checked this patch file in multiple text editors, but couldn’t find
any instance of period followed by two spaces. I will double check again 
all the patches for multiple spaces, and remove them if any.

>> stored in kernel memory also impact the integrity of the system.
>> Several kernel subsystems contain such integrity critical data. These
>> kernel subsystems help protect the integrity of a device. Currently,
> 
> ^integrity of the system.
> 
Will do.
>> IMA does not provide a generic function for kernel subsystems to measure
>> their integrity critical data.
> 
> The emphasis should not be on "kernel subsystems".  Simplify to "for
> measuring kernel integrity critical data".
> 
Will do.
>>   
>> Define a new IMA hook - ima_measure_critical_data to measure kernel
>> integrity critical data.
> 
> Either "ima_measure_critical_data" is between hyphens or without any
> hyphens.  If not hyphenated, then you could say "named
> ima_measure_critical_data", but "named" isn't necessary.  Or reverse "a
> new IMA hook" and "ima_measure_critical_data", adding comma's like:
> Define ima_measure_critical_data, a new IMA hook, to ...
> 
> Any of the above options work, just not a single hyphen.
> 
Thanks for the suggestion.
I will use “Define ima_measure_critical_data, a new IMA hook, to ...”

>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> ---
> 
> <snip>
> 
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 0f8409d77602..dff4bce4fb09 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -922,6 +922,40 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>>   	fdput(f);
>>   }
>>   
>> +/**
>> + * ima_measure_critical_data - measure kernel integrity critical data
>> + * @event_name: event name to be used for the buffer entry
> 
> Why future tense?   
I simply used the description from p_b_m()
* @eventname: event name to be used for the buffer entry.

By "buffer entry" do you mean a record in the IMA
> measurement list?
> 
Yes, a record in the IMA measurement list.
Will remove the future tense and reword it to something like:

  * @event_name: event name for the buffer measurement entry
-or-
  * @event_name: event name for the record in the IMA measurement list

>> + * @buf: pointer to buffer containing data to measure
> 
> ^pointer to buffer data
> 
will do.
>> + * @buf_len: length of buffer(in bytes)
> 
> ^length of buffer data (in bytes)
> 
will do.
>> + * @measure_buf_hash: measure buffer hash
> 
> As requested in 2/8, please abbreviate the boolean name to "hash".
> Refer to section "4) Naming" in Documentation/process/coding-style.rst
> for variable naming conventions.
> 
> ^@hash: measure buffer data hash
> 
Sounds good. Will do.
>> + *
>> + * Measure the kernel subsystem data, critical to the integrity of the kernel,
>> + * into the IMA log and extend the @pcr.
>> + *
>> + * Use @event_name to describe the state/buffer data change.
>> + * Examples of critical data (@buf) could be various data structures,
>> + * policies, and states stored in kernel memory that can impact the integrity
>> + * of the system.
>> + *
>> + * If @measure_buf_hash is set to true - measure hash of the buffer data,
>> + * else measure the buffer data itself.
>> + * @measure_buf_hash can be used to save space, if the data being measured
>> + * is too large.
>> + *
>> + * The data (@buf) can only be measured, not appraised.
> 
> The "/**" is the start of kernel-doc.  Have you seen anywhere else in
My impression was the hooks in ima_main.c e.g. ima_file_free()
ima_file_mmap() required the double-asterisk ("/**"), and internal
functions like ima_rdwr_violation_check() require a single-asterisk
("/*")

kernel-doc.rst suggest the double-asterisk ("/**") for function comment
as well.

Function documentation
----------------------

The general format of a function and function-like macro kernel-doc 
comment is::

   /**
    * function_name() - Brief description of function.

Please let me know if you still want me to remove the double-asterisk
("/**") here.

> the kernel using the @<variable name> in the longer function
> description?  Have you seen this style of longer   function
> description?  Refer to Documentation/doc-guide/kernel-doc.rst and other
> code for examples.
> 
Thanks. I will remove the prefix "@" from <variable name> in the longer 
function description.

>> + */
>> +void ima_measure_critical_data(const char *event_name,
>> +			       const void *buf, int buf_len,
> 
> As "buf_len" should always be >= 0, it should not be defined as a
> signed variable.
> 
Good point. I will switch to either size_t or unsigned int.

>> +			       bool measure_buf_hash)
>> +{
>> +	if (!event_name || !buf || !buf_len)
>> +		return;
>> +
>> +	process_buffer_measurement(NULL, buf, buf_len, event_name,
>> +				   CRITICAL_DATA, 0, NULL,
>> +				   measure_buf_hash);
> 
> ^hash
> 
Will do.
> thanks,
> 
> Mimi
> 
Thanks,
Tushar
>> +}
>> +
>>   static int __init init_ima(void)
>>   {
>>   	int error;
> 
