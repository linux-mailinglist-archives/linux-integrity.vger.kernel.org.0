Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFFE27BC8E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 07:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgI2FvF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 01:51:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34454 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgI2FvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 01:51:05 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4B58220B7178;
        Mon, 28 Sep 2020 22:51:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B58220B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601358662;
        bh=44m6rVhJghsWNI0el9CqVeQHZrvUjP1SHXQD4RCvnlw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JVyyAChZkCOaTjZqKK0zCoxaNAsvWPZCC3XILwQNlaQ4hhnY4cxfA+IRYgNQCcLFz
         F8xV1FU3uKZpBNHBqBEoohIe2onQNftAvv0OZVLv2ECxeYl51Kr1X1s5A1sW75TfFj
         yK13oGJ8tlS+1glpFGWAeBJM/AJKUNNNfUOqCJs0=
Subject: Re: [PATCH 1/1] selinux: Measure state and hash of policy using IMA
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200926164000.2926-1-nramas@linux.microsoft.com>
 <20200926164000.2926-2-nramas@linux.microsoft.com>
 <CAEjxPJ6yiFFG-NPapdPu68WdDKYCmyi222qFg_6+wG9Btya3gQ@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <260542b6-eac9-1588-2930-e9127c116393@linux.microsoft.com>
Date:   Mon, 28 Sep 2020 22:50:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6yiFFG-NPapdPu68WdDKYCmyi222qFg_6+wG9Btya3gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/28/20 9:29 AM, Stephen Smalley wrote:
> On Sat, Sep 26, 2020 at 12:40 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>>
>> Critical data structures of security modules are currently not measured.
>> Therefore an attestation service, for instance, would not be able to
>> attest whether the security modules are always operating with the policies
>> and configurations that the system administrator had setup. The policies
>> and configurations for the security modules could be tampered by rogue
>> user mode agents or modified through some inadvertent actions on
>> the system. Measuring such critical data would enable an attestation
>> service to reliably assess the security configuration of the system.
>>
>> SELinux configuration and policy are some of the critical data for this
>> security module that need to be measured. This measurement can be used
>> by an attestation service, for instance, to verify if the configurations
>> and policies have been setup correctly and that they haven't been
>> tampered at run-time.
>>
>> Measure SELinux configurations, policy capabilities settings, and
>> the hash of the loaded policy by calling the IMA hook
>> ima_measure_critical_data(). Since the size of the loaded policy can
>> be large (several MB), measure the hash of the policy instead of
>> the entire policy to avoid bloating the IMA log entry.
>>
>> Add "selinux" to the list of supported data sources maintained by IMA
>> to enable measuring SELinux data.
> 
> Please provide an example /etc/ima/ima-policy snippet for enabling
> this support, e.g.
> measure func=CRITICAL_DATA data_sources=selinux template=ima-buf
Will do.

> 
>> Since SELinux calls the IMA hook to measure data before
>> a custom IMA policy is loaded, enable queuing if CONFIG_SECURITY_SELINUX
>> is enabled, to defer processing SELinux data until a custom IMA policy
>> is loaded.
>>
>> Sample measurement of SELinux state and hash of the policy:
>>
>> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
>> 10 9e81...0857 ima-buf sha256:4941...68fc selinux-policy-hash-1597335667:462051628 8d1d...1834
>>
>> To verify the measurement check the following:
>>
>> Execute the following command to extract the measured data
>> from the IMA log for SELinux configuration (selinux-state).
>>
>>    grep -m 1 "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | cut -d' ' -f 6 | xxd -r -p
> 
> NB This will only extract the first such record, which will always be
> prior to policy load (initialized=0) so that won't be terribly useful.
> For real verification, they would want to check all such records or at
> least the last/latest one (depending on their goal).
Will update to fetch the latest measurement entry for selinux state.

I have posted a patch that adds test in LTP to validate selinux 
measurement made by IMA. That test extracts the latest selinux 
measurement entry from the IMA log and validates. The link to that patch 
is https://patchwork.kernel.org/patch/11804587/

> 
>> The output should be the list of key-value pairs. For example,
>>   initialized=1;enabled=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;
>>
>> To verify the measured data with the current SELinux state:
>>
>>   => enabled should be set to 1 if /sys/fs/selinux folder exists,
>>      0 otherwise
>>
>> For other entries, compare the integer value in the files
>>   => /sys/fs/selinux/enforce
>>   => /sys/fs/selinux/checkreqprot
>> And, each of the policy capabilities files under
>>   => /sys/fs/selinux/policy_capabilities
> 
> To be clear, actual verification would be against an expected state
> and done on a system other than the measured system, typically
> requiring "initialized=1; enabled=1;enforcing=1;checkreqprot=0;" for a
> secure state and then whatever policy capabilities are actually set in
> the expected policy (which can be extracted from the policy itself via
> seinfo or the like).
Agreed. The measurement of selinux state done by IMA would ideally be 
validated by a remote attestation service against expected state.

> 
>> For selinux-policy-hash, the hash of SELinux policy is included
>> in the IMA log entry.
>>
>> To verify the measured data with the current SELinux policy run
>> the following commands and verify the output hash values match.
>>
>>    sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
>>
>>    grep -m 1 "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | cut -d' ' -f 6
> 
> As above, this will only extract the first policy load, whereas for
> real verification they will want to check either all of them or at
> least the latest/last one.  For actual verification, they would need
> to load the expected policy into an identical kernel on a
> pristine/known-safe system and run the sha256sum
> /sys/kernel/selinux/policy there to get the expected hash.

The test patch, for adding a test for validating selinux measurement, 
extracts the latest entry for selinux policy measurement and validates
against the policy read from /sys/kernel/selinux/policy.

This is just to validate that the selinux policy was measured correctly 
by selinux & IMA.

Similar to selinux state verification, a remote attestation service 
should validate the policy hash against an expected hash to validate 
that the policy set by the administrator hasn't been tampered with.

> 
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> ---
> 
>> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
>> new file mode 100644
>> index 000000000000..b29baaa271f0
>> --- /dev/null
>> +++ b/security/selinux/measure.c
>> @@ -0,0 +1,154 @@
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
>> +       char *event_name = NULL;
>> +       struct timespec64 cur_time;
>> +
>> +       ktime_get_real_ts64(&cur_time);
>> +       event_name = kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix,
>> +                              cur_time.tv_sec, cur_time.tv_nsec);
>> +       if (!event_name) {
>> +               pr_err("%s: event name not allocated.\n", __func__);
>> +               return NULL;
>> +       }
>> +
>> +       return event_name;
>> +}
>> +
>> +static int read_selinux_state(char **state_str, int *state_str_len,
>> +                             struct selinux_state *state)
>> +{
>> +       char *buf, *str_fmt = "%s=%d;";
>> +       int i, buf_len, curr;
>> +       bool initialized = selinux_initialized(state);
>> +       bool enabled = !selinux_disabled(state);
>> +       bool enforcing = enforcing_enabled(state);
>> +       bool checkreqprot = checkreqprot_get(state);
>> +
>> +       buf_len = snprintf(NULL, 0, str_fmt, "initialized", initialized);
>> +       buf_len += snprintf(NULL, 0, str_fmt, "enabled", enabled);
>> +       buf_len += snprintf(NULL, 0, str_fmt, "enforcing", enforcing);
>> +       buf_len += snprintf(NULL, 0, str_fmt, "checkreqprot", checkreqprot);
>> +
>> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
>> +               buf_len += snprintf(NULL, 0, str_fmt,
>> +                                   selinux_policycap_names[i],
>> +                                   state->policycap[i]);
>> +       }
>> +       ++buf_len;
>> +
>> +       buf = kzalloc(buf_len, GFP_KERNEL);
>> +       if (!buf)
>> +               return -ENOMEM;
>> +
>> +       curr = snprintf(buf, buf_len, str_fmt,
>> +                       "initialized", initialized);
>> +       curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
>> +                        "enabled", enabled);
>> +       curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
>> +                        "enforcing", enforcing);
>> +       curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
>> +                        "checkreqprot", checkreqprot);
> 
> Wondering if we should be using scnprintf() when writing to the buffer
> instead of snprintf() to ensure it returns the actual length written.
> Technically shouldn't be an issue since we just computed the length
> above and allocated to that size but might be less prone to error in
> the future.
Agreed - will change it to scnprintf().

> 
>> +
>> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
>> +               curr += snprintf((buf + curr), (buf_len - curr), str_fmt,
>> +                                selinux_policycap_names[i],
>> +                                state->policycap[i]);
> 
> Ditto
Will use scnprintf here as well.

> 
>> +       }
>> +
>> +       *state_str = buf;
>> +       *state_str_len = curr;
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * selinux_measure_state - Measure SELinux state configuration and hash of
>> + *                        the SELinux policy.
>> + * @state: selinux state struct
>> + *
>> + * NOTE: This function must be called with policy_mutex held.
>> + */
>> +void selinux_measure_state(struct selinux_state *state)
>> +{
>> +       void *policy = NULL;
>> +       char *state_event_name = NULL;
>> +       char *policy_event_name = NULL;
>> +       char *state_str = NULL;
>> +       size_t policy_len;
>> +       int state_str_len, rc = 0;
>> +       bool initialized = selinux_initialized(state);
>> +
>> +       rc = read_selinux_state(&state_str, &state_str_len, state);
>> +       if (rc) {
>> +               pr_err("%s: Failed to read selinux state.\n", __func__);
>> +               return;
>> +       }
>> +
>> +       /*
>> +        * Get a unique string for measuring the current SELinux state.
>> +        */
>> +       state_event_name = selinux_event_name("selinux-state");
>> +       if (!state_event_name) {
>> +               pr_err("%s: Event name for state not allocated.\n",
>> +                      __func__);
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
> 
> Why get the event name after creating the state string?  If memory is
> under sufficient pressure to cause the event name allocation to fail,
> then we're going to fail on allocating the state string too and no
> point in doing the work in that case.
I will allocate event name and if that succeeds then read the state.

> 
>> +
>> +       ima_measure_critical_data(state_event_name, "selinux",
>> +                                 state_str, state_str_len, false);
>> +
>> +       /*
>> +        * Measure SELinux policy only after initialization is completed.
>> +        */
>> +       if (!initialized)
>> +               goto out;
>> +
>> +       rc = security_read_policy_kernel(state, &policy, &policy_len);
>> +       if (rc)
>> +               goto out;
>> +
>> +       policy_event_name = selinux_event_name("selinux-policy-hash");
>> +       if (!policy_event_name) {
>> +               pr_err("%s: Event name for policy not allocated.\n",
>> +                      __func__);
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
> 
> Ditto.
Will do the same here as well - allocate event name and if that succeeds 
then read the policy.

> 
>> +
>> +       ima_measure_critical_data(policy_event_name, "selinux",
>> +                                 policy, policy_len, true);
>> +
>> +out:
>> +       kfree(state_event_name);
>> +       kfree(policy_event_name);
>> +       kfree(state_str);
>> +       vfree(policy);
> 
> Can you free them in the reverse order in which they were allocated?
> And the vfree() likely can get moved before the out:
> label if you reverse the order in which the event name and policy get allocated.
> For some related discussion around error handling and freeing of
> things, see https://lore.kernel.org/selinux/20200825125130.GA304650@mwanda/
> and https://lore.kernel.org/selinux/20200826113148.GA393664@mwanda/.
Will do.

> 
>> +}
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index 4bde570d56a2..a4f1282f7178 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@ -182,6 +182,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>>                  selinux_status_update_setenforce(state, new_value);
>>                  if (!new_value)
>>                          call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>> +
>> +               mutex_lock(&state->policy_mutex);
>> +               selinux_measure_state(state);
>> +               mutex_unlock(&state->policy_mutex);
> 
> Side bar question for selinux maintainers: should we extend the scope
> of this mutex to cover the entire operation (or at least everything
> from reading the old value to setting the new value)?  It isn't
> strictly necessary but might be nicer.  Ditto for disable and
> checkreqprot, although both of those are being deprecated.
> 

thanks,
  -lakshmi
