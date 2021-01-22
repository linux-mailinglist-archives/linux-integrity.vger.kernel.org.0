Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD5300ED3
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jan 2021 22:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhAVVXc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jan 2021 16:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbhAVVWx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jan 2021 16:22:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C10DC06174A
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jan 2021 13:22:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r12so9630794ejb.9
        for <linux-integrity@vger.kernel.org>; Fri, 22 Jan 2021 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZpwXDPRrMrG5nsJXK8HMrl7bi6IV+vRYsbaXoE2tqY=;
        b=lZuPRHZEXAezgQ76taZ/agsBU25kwwcY9lyg2EtyfvoJHVOZ3vvVR3eR4EeKx90h6K
         zn2dr/C2AnSzZ2+G1xGa0swpRwTAqdbeK6u73WfulF44/+0f8HENjJi8B0BTh01d10xo
         OVhypm+yLlM2In+CsxdH28fPom7hs2S8V35SeL9edEX7LHZSXDd9t39FcJvMkE3KE06b
         V8Ie59p8ccJgfKkLyZICpwTQUSS6IsttXPqwUsFFKFZQh9mZHmsD2Bb67K2BgASC5YfB
         khnumZMq+sMrMW+7tY2pThKqogMGfb51Yve0DdfM25NtkyIbSBSseoNt8HwouhmjKHAP
         Le8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZpwXDPRrMrG5nsJXK8HMrl7bi6IV+vRYsbaXoE2tqY=;
        b=TxNOQWnxFzfyZh0Wk0Du3Iqmc3FPke7VcnOWb9iZmkgsa2/aOYV/c4Yi48yvUkWblE
         PPW2o30k9PU4MeZJDWQ9jsUABmuydEiC7YVmEU2z24XinnRG0SzdnAkzbrIYhtGQAnLT
         SL2gge9BcrAlgOQqIO0/tJFKTNfRpfvDycOM+IDgUWVOAkDKfKqg6pWbSBEavXexVHnP
         1iCmva/RShxjuqu2EVmJpviHLdkz50hcHbAjb1KpIIrrvaic2XxMPcq0VC3f+D6ekJtD
         QCLVtI4VBh02NyUTCoEuq4Dd2RyyQ+OQUl2YSEB5GVJPJ1ZYUIJuO3nRkzhtWWH3aIbs
         CnMw==
X-Gm-Message-State: AOAM533F6LO6gnjILCK6CdeMWKVcGU6bT8NnuuUTva1b8EsoHPIQYr35
        3Im/HWu4l1+uguo7e66/yCdN7yq8FzG+HBIQxL79
X-Google-Smtp-Source: ABdhPJxeM0w+zCva5SzWNsJdr60Poc+lbb+f+yqTkMpHZLu9kUx1HlkP0Jlm0bnhywXbrJ5OXJG3H3V3f4+ehob+NUw=
X-Received: by 2002:a17:907:932:: with SMTP id au18mr4188903ejc.91.1611350531019;
 Fri, 22 Jan 2021 13:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20210121200150.2448-1-nramas@linux.microsoft.com>
In-Reply-To: <20210121200150.2448-1-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 16:21:59 -0500
Message-ID: <CAHC9VhT13nhaHY3kJZ6ni4rjUffSG-hD5vOfK-q2KfsVFOtaCg@mail.gmail.com>
Subject: Re: [PATCH] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 21, 2021 at 3:02 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> SELinux stores the configuration state and the policy capabilities
> in kernel memory.  Changes to this data at runtime would have an impact
> on the security guarantees provided by SELinux.  Measuring SELinux
> configuration state and policy capabilities through IMA subsystem
> provides a tamper-resistant way for an attestation service to remotely
> validate the runtime state.
>
> Measure the configuration state and policy capabilities by calling
> the IMA hook ima_measure_critical_data().
>
> To enable SELinux data measurement, the following steps are required:
>
>  1, Add "ima_policy=critical_data" to the kernel command line arguments
>     to enable measuring SELinux data at boot time.
>     For example,
>       BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc3+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
>
>  2, Add the following rule to /etc/ima/ima-policy
>        measure func=CRITICAL_DATA label=selinux
>
> Sample measurement of SELinux state and policy capabilities:
>
> 10 2122...65d8 ima-buf sha256:13c2...1292 selinux-state 696e...303b
>
> To verify the measurement check the following:
>
> Execute the following command to extract the measured data
> from the IMA log for SELinux configuration (selinux-state).
>
>   grep "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6 | xxd -r -p
>
> The output should be a list of key-value pairs. For example,
>  initialized=1;enabled=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;
>
> To verify the measured data with the current SELinux state:
>
>  => enabled should be set to 1 if /sys/fs/selinux folder exists,
>     0 otherwise
>
> For other entries, compare the integer value in the files
>  => /sys/fs/selinux/enforce
>  => /sys/fs/selinux/checkreqprot
> And, each of the policy capabilities files under
>  => /sys/fs/selinux/policy_capabilities
>
> Note that the actual verification would be against an expected state
> and done on a system other than the measured system, typically
> requiring "initialized=1; enabled=1;enforcing=1;checkreqprot=0;" for
> a secure state and then whatever policy capabilities are actually set
> in the expected policy (which can be extracted from the policy itself
> via seinfo, for example).
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is based on
> commit e58bb688f2e4 "Merge branch 'measure-critical-data' into next-integrity"
> in "next-integrity-testing" branch
>
>  security/selinux/hooks.c     |  5 +++
>  security/selinux/ima.c       | 68 ++++++++++++++++++++++++++++++++++++
>  security/selinux/selinuxfs.c | 10 ++++++
>  3 files changed, 83 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 644b17ec9e63..879a0d90615d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -103,6 +103,7 @@
>  #include "netlabel.h"
>  #include "audit.h"
>  #include "avc_ss.h"
> +#include "ima.h"
>
>  struct selinux_state selinux_state;
>
> @@ -7407,6 +7408,10 @@ int selinux_disable(struct selinux_state *state)
>
>         selinux_mark_disabled(state);
>
> +       mutex_lock(&state->policy_mutex);
> +       selinux_ima_measure_state(state);
> +       mutex_unlock(&state->policy_mutex);

I'm not sure if this affects your decision to include this action in
the measurements, but this function is hopefully going away in the not
too distant future as we do away with support for disabling SELinux at
runtime.

FWIW, I'm not sure it's overly useful anyway; you only get here if you
never had any SELinux policy/state configured and you decide to
disable SELinux instead of loading a policy.  However, I've got no
objection to this code.

> diff --git a/security/selinux/ima.c b/security/selinux/ima.c
> index 03715893ff97..e65d462d2d30 100644
> --- a/security/selinux/ima.c
> +++ b/security/selinux/ima.c
> @@ -12,6 +12,60 @@
>  #include "security.h"
>  #include "ima.h"
>
> +/*
> + * read_selinux_state - Read selinux configuration settings
> + *
> + * @state_str: Return the configuration settings.
> + * @state_str_len: Size of the configuration settings string
> + * @state: selinux_state
> + *
> + * Return 0 on success, error code on failure
> + */

Yes, naming is hard, but let's try to be a bit more consistent within
a single file.  The existing function is prefixed with "selinux_ima_"
perhaps we can do something similar here?
"selinux_ima_collect_state()" or something similar perhaps?

Perhaps instead of returning zero on success you could return the
length of the generated string?  It's not a big deal, but it saves an
argument for whatever that is worth these days.  I also might pass the
state as the first argument and the generated string pointer as the
second argument, but that is pretty nit-picky.

> +static int read_selinux_state(char **state_str, int *state_str_len,
> +                             struct selinux_state *state)
> +{
> +       char *buf;
> +       int i, buf_len, curr;
> +       bool initialized = selinux_initialized(state);
> +       bool enabled = !selinux_disabled(state);
> +       bool enforcing = enforcing_enabled(state);
> +       bool checkreqprot = checkreqprot_get(state);
> +
> +       buf_len = snprintf(NULL, 0, "%s=%d;%s=%d;%s=%d;%s=%d;",
> +                          "initialized", initialized,
> +                          "enabled", enabled,
> +                          "enforcing", enforcing,
> +                          "checkreqprot", checkreqprot);
> +
> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +               buf_len += snprintf(NULL, 0, "%s=%d;",
> +                                   selinux_policycap_names[i],
> +                                   state->policycap[i]);
> +       }
> +       ++buf_len;

With all of the variables you are measuring being booleans, it seems
like using snprintf() is a bit overkill, no?  What about a series of
strlen() calls with additional constants for the booleans and extra
bits?  For example:

  buf_len = 1; // '\0';
  buf_len += strlen("foo") + 3; // "foo=0;"
  buf_len += strlen("bar") + 3; // "bar=0;"

Not that it matters a lot here, but the above must be more efficient
than calling snprintf().

> +       buf = kzalloc(buf_len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       curr = scnprintf(buf, buf_len, "%s=%d;%s=%d;%s=%d;%s=%d;",
> +                        "initialized", initialized,
> +                        "enabled", enabled,
> +                        "enforcing", enforcing,
> +                        "checkreqprot", checkreqprot);
> +
> +       for (i = 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +               curr += scnprintf((buf + curr), (buf_len - curr), "%s=%d;",
> +                                 selinux_policycap_names[i],
> +                                 state->policycap[i]);
> +       }

Similarly, you could probably replace all of this with
strcat()/strlcat() calls since you don't have to render an integer
into a string.

> +       *state_str = buf;
> +       *state_str_len = curr;
> +
> +       return 0;
> +}
> +
>  /*
>   * selinux_ima_measure_state - Measure hash of the SELinux policy
>   *
> @@ -21,10 +75,24 @@
>   */
>  void selinux_ima_measure_state(struct selinux_state *state)
>  {
> +       char *state_str = NULL;
> +       int state_str_len;
>         void *policy = NULL;
>         size_t policy_len;
>         int rc = 0;
>
> +       rc = read_selinux_state(&state_str, &state_str_len, state);
> +       if (rc) {
> +               pr_err("SELinux: %s: failed to read state %d.\n",
> +                       __func__, rc);
> +               return;
> +       }
> +
> +       ima_measure_critical_data("selinux", "selinux-state",
> +                                 state_str, state_str_len, false);
> +
> +       kfree(state_str);
> +
>         /*
>          * Measure SELinux policy only after initialization is completed.
>          */
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 4bde570d56a2..8b561e1c2caa 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -41,6 +41,7 @@
>  #include "security.h"
>  #include "objsec.h"
>  #include "conditional.h"
> +#include "ima.h"
>
>  enum sel_inos {
>         SEL_ROOT_INO = 2,
> @@ -182,6 +183,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>                 selinux_status_update_setenforce(state, new_value);
>                 if (!new_value)
>                         call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +
> +               mutex_lock(&state->policy_mutex);
> +               selinux_ima_measure_state(state);
> +               mutex_unlock(&state->policy_mutex);
>         }
>         length = count;
>  out:
> @@ -762,6 +767,11 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>
>         checkreqprot_set(fsi->state, (new_value ? 1 : 0));
>         length = count;
> +
> +       mutex_lock(&fsi->state->policy_mutex);
> +       selinux_ima_measure_state(fsi->state);
> +       mutex_unlock(&fsi->state->policy_mutex);
> +

The lock-measure-unlock pattern appears enough that I wonder if we
should move the lock/unlock into selinux_ima_measure_state() and
create a new function, selinux_ima_measure_state_unlocked(), to cover
the existing case in selinux_notify_policy_change().  It would have
the advantage of not requiring a pointless lock/unlock in the case
where CONFIG_IMA=n.

-- 
paul moore
www.paul-moore.com
