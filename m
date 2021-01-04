Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966512EA0D6
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 00:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbhADXb3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 18:31:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37454 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbhADXb3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 18:31:29 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1A58120B7192;
        Mon,  4 Jan 2021 15:30:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A58120B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609803046;
        bh=ciyRF8ztYZLvsI06NwUYXq6asYcrdgHazc91Umb4Pl4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZhmE01FCeU4crsNS8TLxkrNqkRRAtO1/Q9l2dBM0Qy3FZZjOriL0DH4tH/dSfDh2W
         p0Zrr5ceQQIlavPo3HYjK1b0JzncD9eqadmLdwXYg3Gcrk+wULPnGpHxhdjAWyEliR
         m8C+ghVhW1WMxsT24ayH6cryQxJJwhTGX5RaFUIc=
Subject: Re: [PATCH v9 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Paul Moore <paul@paul-moore.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2dce2244-adbd-df2a-e890-271bbcc8f9f2@linux.microsoft.com>
Date:   Mon, 4 Jan 2021 15:30:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSao7DGtskbDMax8hN+PhQr8homFXUGjm+c7NtEUCtKhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/23/20 1:10 PM, Paul Moore wrote:

Hi Paul,

> ...
> 
>> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
>> index 4d8e0e8adf0b..83d512116341 100644
>> --- a/security/selinux/Makefile
>> +++ b/security/selinux/Makefile
>> @@ -16,6 +16,8 @@ selinux-$(CONFIG_NETLABEL) += netlabel.o
>>
>>   selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
>>
>> +selinux-$(CONFIG_IMA) += measure.o
> 
> Naming things is hard, I get that, but I would prefer if we just
> called this file "ima.c" or something similar.  The name "measure.c"
> implies a level of abstraction or general use which simply doesn't
> exist here.  Let's help make it a bit more obvious what should belong
> in this file.
Agreed - I will rename the file to ima.c

> 
>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>> index 3cc8bab31ea8..18ee65c98446 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>> @@ -229,7 +229,8 @@ void selinux_policy_cancel(struct selinux_state *state,
>>                          struct selinux_policy *policy);
>>   int security_read_policy(struct selinux_state *state,
>>                           void **data, size_t *len);
>> -
>> +int security_read_policy_kernel(struct selinux_state *state,
>> +                               void **data, size_t *len);
>>   int security_policycap_supported(struct selinux_state *state,
>>                                   unsigned int req_cap);
>>
>> @@ -446,4 +447,12 @@ extern void ebitmap_cache_init(void);
>>   extern void hashtab_cache_init(void);
>>   extern int security_sidtab_hash_stats(struct selinux_state *state, char *page);
>>
>> +#ifdef CONFIG_IMA
>> +extern void selinux_measure_state(struct selinux_state *selinux_state);
>> +#else
>> +static inline void selinux_measure_state(struct selinux_state *selinux_state)
>> +{
>> +}
>> +#endif
> 
> If you are going to put the SELinux/IMA function(s) into a separate
> source file, please put the function declarations into a separate
> header file too.  For example, look at
> security/selinux/include/{netif,netnode,netport,etc.}.h.

I will create a new header file "security/selinux/include/ima.h" and 
move the function declarations for IMA functions to that header.

> 
>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>> new file mode 100644
>> index 000000000000..b7e24358e11d
>> --- /dev/null
>> +++ b/security/selinux/measure.c
>> @@ -0,0 +1,79 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Measure SELinux state using IMA subsystem.
>> + */
>> +#include <linux/vmalloc.h>
>> +#include <linux/ktime.h>
>> +#include <linux/ima.h>
>> +#include "security.h"
>> +
>> +/*
>> + * This function creates a unique name by appending the timestamp to
>> + * the given string. This string is passed as "event_name" to the IMA
>> + * hook to measure the given SELinux data.
>> + *
>> + * The data provided by SELinux to the IMA subsystem for measuring may have
>> + * already been measured (for instance the same state existed earlier).
>> + * But for SELinux the current data represents a state change and hence
>> + * needs to be measured again. To enable this, pass a unique "event_name"
>> + * to the IMA hook so that IMA subsystem will always measure the given data.
>> + *
>> + * For example,
>> + * At time T0 SELinux data to be measured is "foo". IMA measures it.
>> + * At time T1 the data is changed to "bar". IMA measures it.
>> + * At time T2 the data is changed to "foo" again. IMA will not measure it
>> + * (since it was already measured) unless the event_name, for instance,
>> + * is different in this call.
>> + */
>> +static char *selinux_event_name(const char *name_prefix)
>> +{
>> +       struct timespec64 cur_time;
>> +
>> +       ktime_get_real_ts64(&cur_time);
>> +       return kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix,
>> +                        cur_time.tv_sec, cur_time.tv_nsec);
>> +}
> 
> Why is this a separate function?  It's three lines long and only
> called from selinux_measure_state().  Do you ever see the SELinux/IMA
> code in this file expanding to the point where this function is nice
> from a reuse standpoint?

Earlier I had two measurements - one for SELinux configuration/state and 
another for SELinux policy. selinux_event_name() was used to generate 
event name for each of them.

In this patch set I have included only one measurement - for SELinux 
policy. I plan to add "SELinux configuration/state" measurement in a 
separate patch - I can reuse selinux_event_name() in that patch.

Also, I think the comment in the function header for 
selinux_event_name() is useful.

I prefer to have a separate function, if that's fine by you.

> 
> Also, I assume you are not concerned about someone circumventing the
> IMA measurements by manipulating the time?  In most systems I would
> expect the time to be a protected entity, but with many systems
> getting their time from remote systems I thought it was worth
> mentioning.
I am using time function to generate a unique name for the IMA 
measurement event, such as, "selinux-policy-hash-1609790281:860232824". 
This is to ensure that state changes in SELinux data are always measured.

If you think time manipulation can be an issue, please let me know a 
better way to generate unique event names.

> 
>> +/*
>> + * selinux_measure_state - Measure hash of the SELinux policy
>> + *
>> + * @state: selinux state struct
>> + *
>> + * NOTE: This function must be called with policy_mutex held.
>> + */
>> +void selinux_measure_state(struct selinux_state *state)
> 
> Similar to the name of this source file, let's make it clear this is
> for IMA.  How about calling this selinux_ima_measure_state() or
> similar?
Sure - I will change the function name to selinux_ima_measure_state().

> 
>> +{
>> +       void *policy = NULL;
>> +       char *policy_event_name = NULL;
>> +       size_t policy_len;
>> +       int rc = 0;
>> +       bool initialized = selinux_initialized(state);
> 
> Why bother with the initialized variable?  Unless I'm missing
> something it is only used once in the code below.
You are right - I will remove "initialized" variable and directly get 
the state using selinux_initialized().

> 
>> +       /*
>> +        * Measure SELinux policy only after initialization is completed.
>> +        */
>> +       if (!initialized)
>> +               goto out;
>> +
>> +       policy_event_name = selinux_event_name("selinux-policy-hash");
>> +       if (!policy_event_name) {
>> +               pr_err("SELinux: %s: event name for policy not allocated.\n",
>> +                      __func__);
>> +               rc = -ENOMEM;
> 
> This function doesn't return an error code, why bother with setting
> the rc variable here?
Yes - it is not necessary. I will remove the line.

> 
>> +               goto out;
>> +       }
>> +
>> +       rc = security_read_policy_kernel(state, &policy, &policy_len);
>> +       if (rc) {
>> +               pr_err("SELinux: %s: failed to read policy %d.\n", __func__, rc);
>> +               goto out;
>> +       }
>> +
>> +       ima_measure_critical_data("selinux", policy_event_name,
>> +                                 policy, policy_len, true);
>> +
>> +       vfree(policy);
>> +
>> +out:
>> +       kfree(policy_event_name);
>> +}
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 9704c8a32303..dfa2e00894ae 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -2180,6 +2180,7 @@ static void selinux_notify_policy_change(struct selinux_state *state,
>>          selinux_status_update_policyload(state, seqno);
>>          selinux_netlbl_cache_invalidate();
>>          selinux_xfrm_notify_policyload();
>> +       selinux_measure_state(state);
>>   }
>>
>>   void selinux_policy_commit(struct selinux_state *state,
>> @@ -3875,8 +3876,33 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>>   }
>>   #endif /* CONFIG_NETLABEL */
>>
>> +/**
>> + * security_read_selinux_policy - read the policy.
>> + * @policy: SELinux policy
>> + * @data: binary policy data
>> + * @len: length of data in bytes
>> + *
>> + */
>> +static int security_read_selinux_policy(struct selinux_policy *policy,
>> +                                       void *data, size_t *len)
> 
> Let's just call this "security_read_policy()".
There is another function in this file with the name security_read_policy().

How about changing the above function name to "read_selinux_policy()" 
since this is a local/static function.

> 
>> +{
>> +       int rc;
>> +       struct policy_file fp;
>> +
>> +       fp.data = data;
>> +       fp.len = *len;
>> +
>> +       rc = policydb_write(&policy->policydb, &fp);
>> +       if (rc)
>> +               return rc;
>> +
>> +       *len = (unsigned long)fp.data - (unsigned long)data;
>> +       return 0;
>> +}
>> +
>>   /**
>>    * security_read_policy - read the policy.
>> + * @state: selinux_state
>>    * @data: binary policy data
>>    * @len: length of data in bytes
>>    *
>> @@ -3885,8 +3911,6 @@ int security_read_policy(struct selinux_state *state,
>>                           void **data, size_t *len)
>>   {
>>          struct selinux_policy *policy;
>> -       int rc;
>> -       struct policy_file fp;
>>
>>          policy = rcu_dereference_protected(
>>                          state->policy, lockdep_is_held(&state->policy_mutex));
>> @@ -3898,14 +3922,43 @@ int security_read_policy(struct selinux_state *state,
>>          if (!*data)> --
>> 2.17.1
>>
> 
>>                  return -ENOMEM;
>>
>> -       fp.data = *data;
>> -       fp.len = *len;
>> +       return security_read_selinux_policy(policy, *data, len);
>> +}
>>
>> -       rc = policydb_write(&policy->policydb, &fp);
>> -       if (rc)
>> -               return rc;
>> +/**
>> + * security_read_policy_kernel - read the policy.
>> + * @state: selinux_state
>> + * @data: binary policy data
>> + * @len: length of data in bytes
>> + *
>> + * Allocates kernel memory for reading SELinux policy.
>> + * This function is for internal use only and should not
>> + * be used for returning data to user space.
>> + *
>> + * This function must be called with policy_mutex held.
>> + */
>> +int security_read_policy_kernel(struct selinux_state *state,
>> +                               void **data, size_t *len)
> 
> Let's call this "security_read_state_kernel()".
Sure - I will rename the function.

> 
>> +{
>> +       struct selinux_policy *policy;
>> +       int rc = 0;
> 
> See below, the rc variable is not needed.
> 
>> -       *len = (unsigned long)fp.data - (unsigned long)*data;
>> -       return 0;
>> +       policy = rcu_dereference_protected(
>> +                       state->policy, lockdep_is_held(&state->policy_mutex));
>> +       if (!policy) {
>> +               rc = -EINVAL;
>> +               goto out;
> 
> Jumping to the out label is a little silly since it is just a return;
> do a "return -EINVAL;" here instead.
> 
>> +       }
>> +
>> +       *len = policy->policydb.len;
>> +       *data = vmalloc(*len);
>> +       if (!*data) {
>> +               rc = -ENOMEM;
>> +               goto out;
> 
> Same as above, "return -ENOMEM;" please.
> 
>> +       }
>>
>> +       rc = security_read_selinux_policy(policy, *data, len);
> 
> You should be able to do "return security_read_selinux_policy(...);" here.

I will remove the local variable "rc" and make the three changes you've 
stated above.

Thanks for reviewing the changes.

  -lakshmi

> 
>> +
>> +out:
>> +       return rc;
>>   }
> 

