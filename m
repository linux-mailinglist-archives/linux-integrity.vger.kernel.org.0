Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E96297970
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Oct 2020 00:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758397AbgJWWy5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Oct 2020 18:54:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758396AbgJWWy4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Oct 2020 18:54:56 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1DA2020B4905;
        Fri, 23 Oct 2020 15:54:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1DA2020B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603493695;
        bh=YGbAk5ZPXKS3MwP2MCJgwylXpPWtw4VBI3P7eYMsasE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=s6tiEEKrsgrcNdDHkHFy1PWBspDVW/Y/1tk/hV4xn8q1r2paxanTHW5GdrRUAhYri
         YE8qrkSUe2ntdDnjt/3egpgUPwmyVtdcNSLTmaUskpAyc41w7fnauhNrq1INwTZ/ey
         Rl+Dh3T26UOBLDK3UQYnKavKO+J8KBFeOShs02I0=
Subject: Re: [PATCH v4 5/6] IMA: add hook to measure critical data from kernel
 components
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
 <20200923192011.5293-6-tusharsu@linux.microsoft.com>
 <dc22359475f0c233abdb9257d1ca745d4be3f9af.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <016d20e1-bb8f-f1f5-c69b-6fd811126e0c@linux.microsoft.com>
Date:   Fri, 23 Oct 2020 15:54:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dc22359475f0c233abdb9257d1ca745d4be3f9af.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-10-22 3:35 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
>> Currently, IMA does not provide a generic function for kernel components
>> to measure their data. A generic function provided by IMA would
>> enable various parts of the kernel with easier and faster on-boarding to
>> use IMA infrastructure, would avoid code duplication, and consistent
>> usage of IMA policy option "data_sources:=" across the kernel.
>>
>> Add a new IMA func CRITICAL_DATA and a corresponding IMA hook
>> ima_measure_critical_data() to support measuring various critical kernel
>> components. Limit the measurement to the components that are specified
>> in the IMA policy - CRITICAL_DATA+data_sources.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Normally the new LSM or IMA hook is defined before defining a method of
> constraining that hook.  Please drop 2/6 (IMA: conditionally allow
> empty rule data) and reverse the order of 4/6 and 5/6.   That will
> allow each patch to update the Documentation appropriately, making the
> change self contained.
> 
Sure. I will drop 2/6, and reverse the order of 4/6 and 5/6.
>> ---
>>   Documentation/ABI/testing/ima_policy |  8 ++++++-
>>   include/linux/ima.h                  |  8 +++++++
>>   security/integrity/ima/ima.h         |  1 +
>>   security/integrity/ima/ima_api.c     |  2 +-
>>   security/integrity/ima/ima_main.c    | 26 +++++++++++++++++++++
>>   security/integrity/ima/ima_policy.c  | 34 ++++++++++++++++++++++++----
>>   6 files changed, 72 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
>> index a81cf79fb255..d33bb51309fc 100644
>> --- a/Documentation/ABI/testing/ima_policy
>> +++ b/Documentation/ABI/testing/ima_policy
>> @@ -29,7 +29,7 @@ Description:
>>   		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>>   				[FIRMWARE_CHECK]
>>   				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>> -				[KEXEC_CMDLINE] [KEY_CHECK]
>> +				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
>>   			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>>   			       [[^]MAY_EXEC]
>>   			fsmagic:= hex value
>> @@ -51,6 +51,8 @@ Description:
>>   			data_sources:= list of kernel components
>>   			(eg, selinux|apparmor|dm-crypt) that contain data critical
>>   			to the security of the kernel.
>> +			Only valid when action is "measure" and func is
>> +			CRITICAL_DATA.
>>   
>>   		default policy:
>>   			# PROC_SUPER_MAGIC
>> @@ -128,3 +130,7 @@ Description:
>>   		keys added to .builtin_trusted_keys or .ima keyring:
>>   
>>   			measure func=KEY_CHECK keyrings=.builtin_trusted_keys|.ima
>> +
>> +		Example of measure rule using CRITICAL_DATA to measure critical data
>> +
>> +			measure func=CRITICAL_DATA data_sources=selinux|apparmor|dm-crypt
> 
> 
> As data sources are added, the documentation example should be updated
> to reflect the new source.  Please do not include examples that don't
> yet exist.
> 
Makes sense. Will do.
> 
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 6888fc372abf..d55896f28790 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -867,6 +867,32 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>>   	fdput(f);
>>   }
>>   
>> +/**
>> + * ima_measure_critical_data - measure critical data
>> + * @event_name: name for the given data
>> + * @event_data_source: name of the event data source
>> + * @buf: pointer to buffer containing data to measure
>> + * @buf_len: length of buffer(in bytes)
>> + * @measure_buf_hash: if set to true - will measure hash of the buf,
>> + *                    instead of buf
>> + *
>> + * Buffers can only be measured, not appraised.
>> + */
> 
> Perhaps the reason for defining both the event_name and
> event_data_source will become clearer with an example.  At this point I
> can only guess as to why both are needed (e.g. perhaps a data source
> defines multiple events).
> 
Yes. Precisely. For example, in “dm-crypt” case: the data source is
“dm-crypt” and possible events are “add_target”, “post_suspend”,
"resume" etc. I will add a more detailed hook description as you
suggested below, and explain this point in it.
> While "Buffers can only be measured, not appraised" is true, it was cut
> & pasted from ima_kexec_cmdline.  Measuring the kexec boot cmdline is
> self describing.  Here, a larger, more detailed IMA hook description
> would be appropriate.
Will add. Thanks Mimi.
> 
> thanks,
> 
> Mimi
> 
