Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66392B10BE
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 22:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgKLV5Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 16:57:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54722 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKLV5Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 16:57:24 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id CBA5920C2872;
        Thu, 12 Nov 2020 13:57:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBA5920C2872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605218243;
        bh=PkdjkruNANX8wdTbYPq9U2AHzVXQRRmafd7bWjQQQ9Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pb5+ds9Y1dHnrmNkg9sdbhb7z8gLlGW/fGr6/SoubR2iPOSlWiXvd8Cuj8JRaXBJ+
         zCz4CA7hkVKQ/Jxg4W1xa03C7v0iARqYKG8lptnRBYBhctzmlh2naTTJrP/2HwfMVd
         WM5cawaRS7G50Pc3DbXOkRnm7IH9v2F2XoizC3WY=
Subject: Re: [PATCH v5 3/7] IMA: add hook to measure critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <20201101222626.6111-4-tusharsu@linux.microsoft.com>
 <1f83ec246cb6356c340b379ab00e43f0b5bba0ae.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <25622ca6-359d-fa97-c5e6-e314cba51306@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 13:57:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1f83ec246cb6356c340b379ab00e43f0b5bba0ae.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-11-06 5:24 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
>> Currently, IMA does not provide a generic function for kernel subsystems
>> to measure their critical data. Examples of critical data in this context
>> could be kernel in-memory r/o structures, hash of the memory structures,
>> or data that represents a linux kernel subsystem state change. The
>> critical data, if accidentally or maliciously altered, can compromise
>> the integrity of the system.
> 
> Start out with what IMA does do (e.g. measures files and more recently
> buffer data).  Afterwards continue with kernel integrity critical data
> should also be measured.  Please include a definition of kernel
> integrity critical data here, as well as in the cover letter.
> 
Yes, will do. I will also describe what kernel integrity critical data
is – by providing a definition, and not by example -  as you suggested.
(here and in the cover letter)

>>
>> A generic function provided by IMA to measure critical data would enable
>> various subsystems with easier and faster on-boarding to use IMA
>> infrastructure and would also avoid code duplication.
> 
> By definition LSM and IMA hooks are generic with callers in appropriate
> places in the kernel.   This paragraph is redundant.
> 
Sounds good. I will remove this paragraph.
>>
>> Add a new IMA func CRITICAL_DATA and a corresponding IMA hook
>> ima_measure_critical_data() to support measuring critical data for
>> various kernel subsystems.
> 
> Instead of using the word "add", it would be more appropriate to use
> the word "define".   Define a new IMA hook named
> ima_measure_critical_data to measure kernel integrity critical data.
> Please also update the Subject line as well.  "ima: define an IMA hook
> to measure kernel integrity critical data".
> 
Sounds good. Will do.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 4485d87c0aa5..6e1b11dcba53 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -921,6 +921,44 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>>   	fdput(f);
>>   }
>>   
>> +/**
>> + * ima_measure_critical_data - measure kernel subsystem data
>> + * critical to integrity of the kernel
> 
> Please change this to "measure kernel integrity critical data".
> 
*Question*
Thanks Mimi. Do you want us just to update the description, or do you
want us to update the function name too?

I believe you meant just description, but still want to clarify.

ima_measure_kernel_integrity_critical_data() would be too long.
Maybe ima_measure_integrity_critical_data()?

Or do you want us to keep the existing ima_measure_critical_data()?
Could you please let us know?

>> + * @event_data_source: name of the data source being measured;
>> + * typically it should be the name of the kernel subsystem that is sending
>> + * the data for measurement
> 
> Including "data_source" here isn't quite right.  "data source" should
> only be added in the first patch which uses it, not here.   When adding
> it please shorten the field description to "kernel data source".   The
> longer explanation can be included in the longer function description.
> 
*Question*
Do you mean the parameter @event_data_source should be removed from this
patch? And then later added in patch 7/7 – where SeLinux uses it?

But ima_measure_critical_data() calls process_buffer_measurement(), and
p_b_m() accepts it as part of the param @func_data.

What should we pass to p_b_m() @func_data in this patch, if we remove
@event_data_source from this patch?

>> + * @event_name: name of an event from the kernel subsystem that is sending
>> + * the data for measurement
> 
> As this is being passed to process_buffer_measurement(), this should be
> the same or similar to the existing definition.
> 
Ok. I will change this to @eventname to be consistemt with p_b_m().

>> + * @buf: pointer to buffer containing data to measure
>> + * @buf_len: length of buffer(in bytes)
>> + * @measure_buf_hash: if set to true - will measure hash of the buf,
>> + *                    instead of buf
> 
>   kernel doc requires a single line.  In this case, please shorten the
> argument definition to "measure buffer data or buffer data hash".   The
> details can be included in the longer function description.
> 
Sounds good. Will do.
>> + *
>> + * A given kernel subsystem (event_data_source) may send
>> + * data (buf) to be measured when the data or the subsystem state changes.
>> + * The state/data change can be described by event_name.
>> + * Examples of critical data (buf) could be kernel in-memory r/o structures,
>> + * hash of the memory structures, or data that represents subsystem
>> + * state change.
>> + * measure_buf_hash can be used to save space, if the data being measured
>> + * is too large.
>> + * The data (buf) can only be measured, not appraised.
>> + */
> 
> Please remove this longer function description, replacing it something
> more appropriate.  The subsequent patch that introduces the "data
> source" parameter would expand the description.
> 
> thanks,
> 
> Mimi
> 
*Question*
Hi Mimi, will do.
Do you want the data_source to be part of SeLinux patch? (patch 7/7 of
this series).
Or a separate patch before it?
~Tushar

>> +void ima_measure_critical_data(const char *event_data_source,
>> +			       const char *event_name,
>> +			       const void *buf, int buf_len,
>> +			       bool measure_buf_hash)
>> +{
>> +	if (!event_name || !event_data_source || !buf || !buf_len) {
>> +		pr_err("Invalid arguments passed to %s().\n", __func__);
>> +		return;
>> +	}
>> +
>> +	process_buffer_measurement(NULL, buf, buf_len, event_name,
>> +				   CRITICAL_DATA, 0, event_data_source,
>> +				   measure_buf_hash);
>> +}
>> +
>>   static int __init init_ima(void)
>>   {
>>   	int error;
