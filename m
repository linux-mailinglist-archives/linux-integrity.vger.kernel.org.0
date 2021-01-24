Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6D301DD1
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Jan 2021 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbhAXRFZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 Jan 2021 12:05:25 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45846 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbhAXRFY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Jan 2021 12:05:24 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 59C4020B7192;
        Sun, 24 Jan 2021 09:04:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59C4020B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1611507881;
        bh=jcB5R+Z7AHCeSKNHbj/OIxNmhum9d165W8I2w6xnYAI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JEKrZpP0OmFSwu4PabCWXgM4f5bJBFm/qlr0x5IxxwklrUJGtUay6ucsezODWuEby
         P932IxeOttRV5WbwbUKra9ZzB4KkVUB7vOLm/LZ5DyfxJyJvHIqhxBvJZDyNAhD+RA
         4EldaKwnsRwwnc/uU982cDJkDLwmnAG7umROxO8Y=
Subject: Re: [PATCH] selinux: measure state and policy capabilities
To:     Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210121200150.2448-1-nramas@linux.microsoft.com>
 <CAHC9VhT13nhaHY3kJZ6ni4rjUffSG-hD5vOfK-q2KfsVFOtaCg@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c61e3ea5-7412-7e39-4d71-945f906d68a3@linux.microsoft.com>
Date:   Sun, 24 Jan 2021 09:04:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT13nhaHY3kJZ6ni4rjUffSG-hD5vOfK-q2KfsVFOtaCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/22/21 1:21 PM, Paul Moore wrote:

Hi Paul,

Thanks for reviewing the changes.

...

>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> ---
>> This patch is based on
>> commit e58bb688f2e4 "Merge branch 'measure-critical-data' into next-integrity"
>> in "next-integrity-testing" branch
>>
>>   security/selinux/hooks.c     |  5 +++
>>   security/selinux/ima.c       | 68 ++++++++++++++++++++++++++++++++++++
>>   security/selinux/selinuxfs.c | 10 ++++++
>>   3 files changed, 83 insertions(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 644b17ec9e63..879a0d90615d 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -103,6 +103,7 @@
>>   #include "netlabel.h"
>>   #include "audit.h"
>>   #include "avc_ss.h"
>> +#include "ima.h"
>>
>>   struct selinux_state selinux_state;
>>
>> @@ -7407,6 +7408,10 @@ int selinux_disable(struct selinux_state *state)
>>
>>          selinux_mark_disabled(state);
>>
>> +       mutex_lock(&state->policy_mutex);
>> +       selinux_ima_measure_state(state);
>> +       mutex_unlock(&state->policy_mutex);
> 
> I'm not sure if this affects your decision to include this action in
> the measurements, but this function is hopefully going away in the not
> too distant future as we do away with support for disabling SELinux at
> runtime.
> 
> FWIW, I'm not sure it's overly useful anyway; you only get here if you
> never had any SELinux policy/state configured and you decide to
> disable SELinux instead of loading a policy.  However, I've got no
> objection to this code.
If support for disabling SELinux at runtime will be removed, then I 
don't see a reason to trigger a measurement here. I'll remove this 
measurement.

> 
>> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
>> index 03715893ff97..e65d462d2d30 100644
>> --- a/security/selinux/ima.c
>> +++ b/security/selinux/ima.c
>> @@ -12,6 +12,60 @@
>>   #include "security.h"
>>   #include "ima.h"
>>
>> +/*
>> + * read_selinux_state - Read selinux configuration settings
>> + *
>> + * @state_str: Return the configuration settings.
>> + * @state_str_len: Size of the configuration settings string
>> + * @state: selinux_state
>> + *
>> + * Return 0 on success, error code on failure
>> + */
> 
> Yes, naming is hard, but let's try to be a bit more consistent within
> a single file.  The existing function is prefixed with "selinux_ima_"
> perhaps we can do something similar here?
> "selinux_ima_collect_state()" or something similar perhaps?

Sure - will rename the function to "selinux_ima_collect_state()"

> 
> Perhaps instead of returning zero on success you could return the
> length of the generated string?  It's not a big deal, but it saves an
> argument for whatever that is worth these days.  I also might pass the
> state as the first argument and the generated string pointer as the
> second argument, but that is pretty nit-picky.
Sure - will make this change.

> 
>> +static int read_selinux_state(char **state_str, int *state_str_len,
>> +                             struct selinux_state *state)
>> +{
>> +       char *buf;
>> +       int i, buf_len, curr;
>> +       bool initialized = selinux_initialized(state);
>> +       bool enabled = !selinux_disabled(state);
>> +       bool enforcing = enforcing_enabled(state);
>> +       bool checkreqprot = checkreqprot_get(state);
>> +
>> +       buf_len = snprintf(NULL, 0, "%s=%d;%s=%d;%s=%d;%s=%d;",
>> +                          "initialized", initialized,
>> +                          "enabled", enabled,
>> +                          "enforcing", enforcing,
>> +                          "checkreqprot", checkreqprot);
>> +
>> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
>> +               buf_len += snprintf(NULL, 0, "%s=%d;",
>> +                                   selinux_policycap_names[i],
>> +                                   state->policycap[i]);
>> +       }
>> +       ++buf_len;
> 
> With all of the variables you are measuring being booleans, it seems
> like using snprintf() is a bit overkill, no?  What about a series of
> strlen() calls with additional constants for the booleans and extra
> bits?  For example:
> 
>    buf_len = 1; // '\0';
>    buf_len += strlen("foo") + 3; // "foo=0;"
>    buf_len += strlen("bar") + 3; // "bar=0;"
> 
> Not that it matters a lot here, but the above must be more efficient
> than calling snprintf().

You are right - using strlen/strcat would be more efficient here. But I 
feel it is safer to use snprintf() rather than computing the length of 
each measured entity and concatenating it to the destination buffer.

I'll try strlen/strcat approach.

> 
>> +       buf = kzalloc(buf_len, GFP_KERNEL);
>> +       if (!buf)
>> +               return -ENOMEM;
>> +
>> +       curr = scnprintf(buf, buf_len, "%s=%d;%s=%d;%s=%d;%s=%d;",
>> +                        "initialized", initialized,
>> +                        "enabled", enabled,
>> +                        "enforcing", enforcing,
>> +                        "checkreqprot", checkreqprot);
>> +
>> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
>> +               curr += scnprintf((buf + curr), (buf_len - curr), "%s=%d;",
>> +                                 selinux_policycap_names[i],
>> +                                 state->policycap[i]);
>> +       }
> 
> Similarly, you could probably replace all of this with
> strcat()/strlcat() calls since you don't have to render an integer
> into a string.
Sure - I'll give this a try.

> 
>> +       *state_str = buf;
>> +       *state_str_len = curr;
>> +
>> +       return 0;
>> +}
>> +
>>   /*
>>    * selinux_ima_measure_state - Measure hash of the SELinux policy
>>    *
>> @@ -21,10 +75,24 @@
>>    */
>>   void selinux_ima_measure_state(struct selinux_state *state)
>>   {
>> +       char *state_str = NULL;
>> +       int state_str_len;
>>          void *policy = NULL;
>>          size_t policy_len;
>>          int rc = 0;
>>
>> +       rc = read_selinux_state(&state_str, &state_str_len, state);
>> +       if (rc) {
>> +               pr_err("SELinux: %s: failed to read state %d.\n",
>> +                       __func__, rc);
>> +               return;
>> +       }
>> +
>> +       ima_measure_critical_data("selinux", "selinux-state",
>> +                                 state_str, state_str_len, false);
>> +
>> +       kfree(state_str);
>> +
>>          /*
>>           * Measure SELinux policy only after initialization is completed.
>>           */
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index 4bde570d56a2..8b561e1c2caa 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@ -41,6 +41,7 @@
>>   #include "security.h"
>>   #include "objsec.h"
>>   #include "conditional.h"
>> +#include "ima.h"
>>
>>   enum sel_inos {
>>          SEL_ROOT_INO = 2,
>> @@ -182,6 +183,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>>                  selinux_status_update_setenforce(state, new_value);
>>                  if (!new_value)
>>                          call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>> +
>> +               mutex_lock(&state->policy_mutex);
>> +               selinux_ima_measure_state(state);
>> +               mutex_unlock(&state->policy_mutex);
>>          }
>>          length = count;
>>   out:
>> @@ -762,6 +767,11 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>>
>>          checkreqprot_set(fsi->state, (new_value ? 1 : 0));
>>          length = count;
>> +
>> +       mutex_lock(&fsi->state->policy_mutex);
>> +       selinux_ima_measure_state(fsi->state);
>> +       mutex_unlock(&fsi->state->policy_mutex);
>> +
> 
> The lock-measure-unlock pattern appears enough that I wonder if we
> should move the lock/unlock into selinux_ima_measure_state() and
> create a new function, selinux_ima_measure_state_unlocked(), to cover
> the existing case in selinux_notify_policy_change().  It would have
> the advantage of not requiring a pointless lock/unlock in the case
> where CONFIG_IMA=n.
> 

Agreed.

thanks,
  -lakshmi
