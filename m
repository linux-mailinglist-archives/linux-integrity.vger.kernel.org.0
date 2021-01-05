Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84A2EA4E0
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 06:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbhAEFZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 00:25:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50810 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbhAEFZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 00:25:42 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8F17520B7192;
        Mon,  4 Jan 2021 21:24:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F17520B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609824299;
        bh=/q6XJShOYkigDSKg8XB5CBj9RGfQRpKmxcZ9rBIUH7U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VBO+KwJvOST+yWMes4tjC5pJe30NQqWvbDJShENyh/wX+K2BrtfXps4o5Ztr+SXAU
         00k8Hshb0dl4LiPl1uQVQkM1dDU9ZB1Pu9EBpFRq0fRHQHtaxvK4vknhr7a7XGhyXn
         fxz3Gcg8UuYSyntY58WpkU7SRgjFsVb6cDw9en6c=
Subject: Re: [PATCH v9 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-9-tusharsu@linux.microsoft.com>
 <CAHC9VhSao7DGtskbDMax8hN+PhQr8homFXUGjm+c7NtEUCtKhg@mail.gmail.com>
 <2dce2244-adbd-df2a-e890-271bbcc8f9f2@linux.microsoft.com>
 <CAHC9VhQ8H+UCnLTJ4Mb=GHCdExGvVEB_+nbK+-keMVie-tnbnQ@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9d360a9e-5cf2-3d56-d510-8f3d9bd90bcf@linux.microsoft.com>
Date:   Mon, 4 Jan 2021 21:24:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQ8H+UCnLTJ4Mb=GHCdExGvVEB_+nbK+-keMVie-tnbnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/4/21 6:13 PM, Paul Moore wrote:
> On Mon, Jan 4, 2021 at 6:30 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>> On 12/23/20 1:10 PM, Paul Moore wrote:
>> Hi Paul,
> 
> Hello.
> 
>>>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>>>> new file mode 100644
>>>> index 000000000000..b7e24358e11d
>>>> --- /dev/null
>>>> +++ b/security/selinux/measure.c
>>>> @@ -0,0 +1,79 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Measure SELinux state using IMA subsystem.
>>>> + */
>>>> +#include <linux/vmalloc.h>
>>>> +#include <linux/ktime.h>
>>>> +#include <linux/ima.h>
>>>> +#include "security.h"
>>>> +
>>>> +/*
>>>> + * This function creates a unique name by appending the timestamp to
>>>> + * the given string. This string is passed as "event_name" to the IMA
>>>> + * hook to measure the given SELinux data.
>>>> + *
>>>> + * The data provided by SELinux to the IMA subsystem for measuring may have
>>>> + * already been measured (for instance the same state existed earlier).
>>>> + * But for SELinux the current data represents a state change and hence
>>>> + * needs to be measured again. To enable this, pass a unique "event_name"
>>>> + * to the IMA hook so that IMA subsystem will always measure the given data.
>>>> + *
>>>> + * For example,
>>>> + * At time T0 SELinux data to be measured is "foo". IMA measures it.
>>>> + * At time T1 the data is changed to "bar". IMA measures it.
>>>> + * At time T2 the data is changed to "foo" again. IMA will not measure it
>>>> + * (since it was already measured) unless the event_name, for instance,
>>>> + * is different in this call.
>>>> + */
>>>> +static char *selinux_event_name(const char *name_prefix)
>>>> +{
>>>> +       struct timespec64 cur_time;
>>>> +
>>>> +       ktime_get_real_ts64(&cur_time);
>>>> +       return kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix,
>>>> +                        cur_time.tv_sec, cur_time.tv_nsec);
>>>> +}
>>>
>>> Why is this a separate function?  It's three lines long and only
>>> called from selinux_measure_state().  Do you ever see the SELinux/IMA
>>> code in this file expanding to the point where this function is nice
>>> from a reuse standpoint?
>>
>> Earlier I had two measurements - one for SELinux configuration/state and
>> another for SELinux policy. selinux_event_name() was used to generate
>> event name for each of them.
>>
>> In this patch set I have included only one measurement - for SELinux
>> policy. I plan to add "SELinux configuration/state" measurement in a
>> separate patch - I can reuse selinux_event_name() in that patch.
> 
> I'm curious about this second measurement.  My apologies if you posted
> it previously, this patchset has gone through several iterations and
> simply can't recall all the different versions without digging through
> the list archives.
> 

The 2nd measurement is for SELinux state data such as "enforcing", 
"checkreqprot", policycap[__POLICYDB_CAPABILITY_MAX], etc.

> Is there a reason why the second measurement isn't included in this
> patch?  Or this patchset if it is too big to be a single patch?
> 

For illustrating the use of the new IMA hook, that my colleague Tushar 
has added for measuring kernel critical data, we have included only one 
SELinux measurement in this patch set - the measurement of SELinux 
policy. This also helped in keeping this patch smaller.

When this patch set is merged, I'll post a separate patch to add 
measurement of SELinux state data I have mentioned above.

>> Also, I think the comment in the function header for
>> selinux_event_name() is useful.
>>
>> I prefer to have a separate function, if that's fine by you.
> 
> Given just this patch I would prefer if you folded
> selinux_event_name() into selinux_measure_state().  However, I agree
> with you that the comments in the selinux_event_name() header block is
> useful, I would suggest moving those into the body of
> selinux_measure_state() directly above the calls to
> ktime_get_real_ts64() and kasprintf().

Sure - I will make that change.

> 
>>> Also, I assume you are not concerned about someone circumventing the
>>> IMA measurements by manipulating the time?  In most systems I would
>>> expect the time to be a protected entity, but with many systems
>>> getting their time from remote systems I thought it was worth
>>> mentioning.
>>
>> I am using time function to generate a unique name for the IMA
>> measurement event, such as, "selinux-policy-hash-1609790281:860232824".
>> This is to ensure that state changes in SELinux data are always measured.
>>
>> If you think time manipulation can be an issue, please let me know a
>> better way to generate unique event names.
> 
> Yes, I understand that you are using the time value as a way of
> ensuring you always have a different event name and hence a new
> measurement.  However, I was wondering if you would be okay if the
> time was adjusted such that an event name was duplicated and a
> measurement missed?  Is that a problem for you?  It seems like it
> might be an issue, but you and Mimi know IMA better than I do.

If the system time was adjusted such that the event name is duplicated, 
we could miss measurements - this is not okay.

For example:
  #1 Say, at time T1 SELinux state being measured is "foo" - IMA will 
measure it.
  #2 at time T2, the state changes to "bar" - IMA will measure it
  #3 at time T3, the state changes from "bar" to "foo" again. Unless the 
"event name" passed in the measurement call is different from what was 
passed in step #1, IMA will not measure it and hence we'll miss the 
state change.

If system time can be manipulated to return the same "timer tick" on 
every call to ktime_get_real_ts64(), we will lose measurement in Step #3 
above.

But given that we are using ktime_get_real_ts64() to get the timer tick, 
is it possible to manipulate the system time without compromising the 
overall functioning of the rest of the system? If yes, then it is an 
issue - I mean, there is a possibility of losing some measurements.

> 
>>>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>>>> index 9704c8a32303..dfa2e00894ae 100644
>>>> --- a/security/selinux/ss/services.c
>>>> +++ b/security/selinux/ss/services.c
>>>> @@ -3875,8 +3876,33 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>>>>    }
>>>>    #endif /* CONFIG_NETLABEL */
>>>>
>>>> +/**
>>>> + * security_read_selinux_policy - read the policy.
>>>> + * @policy: SELinux policy
>>>> + * @data: binary policy data
>>>> + * @len: length of data in bytes
>>>> + *
>>>> + */
>>>> +static int security_read_selinux_policy(struct selinux_policy *policy,
>>>> +                                       void *data, size_t *len)
>>>
>>> Let's just call this "security_read_policy()".
>> There is another function in this file with the name security_read_policy().
>>
>> How about changing the above function name to "read_selinux_policy()"
>> since this is a local/static function.
> 
> Ooops, sorry about that!  I'm not sure what I was thinking there :)
> 
> How about "__security_read_policy()"?
> 

Sure - I will change the function name to "__security_read_policy()".

thanks,
  -lakshmi

