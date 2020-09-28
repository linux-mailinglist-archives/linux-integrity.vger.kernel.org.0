Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBBE27B1E1
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgI1Q34 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgI1Q34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 12:29:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E6C061755;
        Mon, 28 Sep 2020 09:29:56 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t76so1958042oif.7;
        Mon, 28 Sep 2020 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H9fjIlOuHL1yezLBOCE86p3JhBU5CVGs2swVYHMhn/s=;
        b=h2lg8eZBgVB41/Zvqwt7fAPcFdmG524iFOaVjIPs3AouyE1gyj2MWrnQYgh/KK+jmh
         +zHxA8z81ldmCHvrd7O3vjjQ9OToQazjK8CY8Vq+NDCAoj7pqadFx4ko8JIjQwZ+2Y3Z
         iJf5pCF9WQ6p2pvCqzafsRwPOGl+NstuQ3pmRpGNwOqke++ZifP5d/RWt8Fl4XfLbQx8
         dWAtznnvaN+QuvRBYzxqOnBfj9ZEzOqXoTVS7Ma3BWG70yrEXGMEEeVJzNG9OmmpCQIb
         pNRXSXadAIiv0DuHVG9puQ6jrstvmYIYmCuTOLyItNddiKa6NW9hCQ7/chTh/lvv1XZO
         V23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H9fjIlOuHL1yezLBOCE86p3JhBU5CVGs2swVYHMhn/s=;
        b=BEy80KRUy1y+sv51hl+yesFMbC+y2WZIaFGSqBtfkE2V6u7ReWrFiq/oDToFnmML8C
         hfSUjBOPlRiXc9kPiKMv8VtK/iYteMD5TjVtActbgvoJr5ItwOdiIGk9npp13OFtsLVi
         XeZu02YRMAatCVOkImRNzldIxWrolUhSYrXE0cZfkMQAMyInc4UoLT0in+gwgBNcn4/2
         7H6RBSQ8eP14QV+LZrAlTvGOU5qn/pv0zG9kCOW2B2vGrzWUGweZao8ECQIvW9sdlIQu
         8n3+HwzDEC4t+IX8oqiSce4/Fwi3Yai1Y/R896cEnKcOpNS0Gr3CoQk5A0ZR4Yk8ENA4
         5YGA==
X-Gm-Message-State: AOAM531Y5BQNCGaIr2pxH3cLbX1wnoNgTLUX0qskDUL4TyYflJIvyIhr
        92Z1lXmKYp/oX96c7th1eus95BMaqLa1dD+DyB8=
X-Google-Smtp-Source: ABdhPJyIGxACVOwxwL8djl51ggWN+Wa8/kdiiaVJbUETJ5Nny85Dx4UG8n3qXwCQqFFyn5pUd0sxWl5QKfkUbwOWAOM=
X-Received: by 2002:a05:6808:56f:: with SMTP id j15mr1412696oig.140.1601310593699;
 Mon, 28 Sep 2020 09:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200926164000.2926-1-nramas@linux.microsoft.com> <20200926164000.2926-2-nramas@linux.microsoft.com>
In-Reply-To: <20200926164000.2926-2-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 28 Sep 2020 12:29:42 -0400
Message-ID: <CAEjxPJ6yiFFG-NPapdPu68WdDKYCmyi222qFg_6+wG9Btya3gQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Sep 26, 2020 at 12:40 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> Critical data structures of security modules are currently not measured.
> Therefore an attestation service, for instance, would not be able to
> attest whether the security modules are always operating with the policie=
s
> and configurations that the system administrator had setup. The policies
> and configurations for the security modules could be tampered by rogue
> user mode agents or modified through some inadvertent actions on
> the system. Measuring such critical data would enable an attestation
> service to reliably assess the security configuration of the system.
>
> SELinux configuration and policy are some of the critical data for this
> security module that need to be measured. This measurement can be used
> by an attestation service, for instance, to verify if the configurations
> and policies have been setup correctly and that they haven't been
> tampered at run-time.
>
> Measure SELinux configurations, policy capabilities settings, and
> the hash of the loaded policy by calling the IMA hook
> ima_measure_critical_data(). Since the size of the loaded policy can
> be large (several MB), measure the hash of the policy instead of
> the entire policy to avoid bloating the IMA log entry.
>
> Add "selinux" to the list of supported data sources maintained by IMA
> to enable measuring SELinux data.

Please provide an example /etc/ima/ima-policy snippet for enabling
this support, e.g.
measure func=3DCRITICAL_DATA data_sources=3Dselinux template=3Dima-buf

> Since SELinux calls the IMA hook to measure data before
> a custom IMA policy is loaded, enable queuing if CONFIG_SECURITY_SELINUX
> is enabled, to defer processing SELinux data until a custom IMA policy
> is loaded.
>
> Sample measurement of SELinux state and hash of the policy:
>
> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899=
386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303=
b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d=
313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d3=
13b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162=
656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f73656=
36c6162656c5f73796d6c696e6b733d303
> 10 9e81...0857 ima-buf sha256:4941...68fc selinux-policy-hash-1597335667:=
462051628 8d1d...1834
>
> To verify the measurement check the following:
>
> Execute the following command to extract the measured data
> from the IMA log for SELinux configuration (selinux-state).
>
>   grep -m 1 "selinux-state" /sys/kernel/security/integrity/ima/ascii_runt=
ime_measurements | cut -d' ' -f 6 | xxd -r -p

NB This will only extract the first such record, which will always be
prior to policy load (initialized=3D0) so that won't be terribly useful.
For real verification, they would want to check all such records or at
least the last/latest one (depending on their goal).

> The output should be the list of key-value pairs. For example,
>  initialized=3D1;enabled=3D1;enforcing=3D0;checkreqprot=3D1;network_peer_=
controls=3D1;open_perms=3D1;extended_socket_class=3D1;always_check_network=
=3D0;cgroup_seclabel=3D1;nnp_nosuid_transition=3D1;genfs_seclabel_symlinks=
=3D0;
>
> To verify the measured data with the current SELinux state:
>
>  =3D> enabled should be set to 1 if /sys/fs/selinux folder exists,
>     0 otherwise
>
> For other entries, compare the integer value in the files
>  =3D> /sys/fs/selinux/enforce
>  =3D> /sys/fs/selinux/checkreqprot
> And, each of the policy capabilities files under
>  =3D> /sys/fs/selinux/policy_capabilities

To be clear, actual verification would be against an expected state
and done on a system other than the measured system, typically
requiring "initialized=3D1; enabled=3D1;enforcing=3D1;checkreqprot=3D0;" fo=
r a
secure state and then whatever policy capabilities are actually set in
the expected policy (which can be extracted from the policy itself via
seinfo or the like).

> For selinux-policy-hash, the hash of SELinux policy is included
> in the IMA log entry.
>
> To verify the measured data with the current SELinux policy run
> the following commands and verify the output hash values match.
>
>   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
>
>   grep -m 1 "selinux-policy-hash" /sys/kernel/security/integrity/ima/asci=
i_runtime_measurements | cut -d' ' -f 6

As above, this will only extract the first policy load, whereas for
real verification they will want to check either all of them or at
least the latest/last one.  For actual verification, they would need
to load the expected policy into an identical kernel on a
pristine/known-safe system and run the sha256sum
/sys/kernel/selinux/policy there to get the expected hash.

> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..b29baaa271f0
> --- /dev/null
> +++ b/security/selinux/measure.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Measure SELinux state using IMA subsystem.
> + */
> +#include <linux/vmalloc.h>
> +#include <linux/ktime.h>
> +#include <linux/ima.h>
> +#include "security.h"
> +
> +/*
> + * This function creates a unique name by appending the timestamp to
> + * the given string. This string is passed as "event_name" to the IMA
> + * hook to measure the given SELinux data.
> + *
> + * The data provided by SELinux to the IMA subsystem for measuring may h=
ave
> + * already been measured (for instance the same state existed earlier).
> + * But for SELinux the current data represents a state change and hence
> + * needs to be measured again. To enable this, pass a unique "event_name=
"
> + * to the IMA hook so that IMA subsystem will always measure the given d=
ata.
> + *
> + * For example,
> + * At time T0 SELinux data to be measured is "foo". IMA measures it.
> + * At time T1 the data is changed to "bar". IMA measures it.
> + * At time T2 the data is changed to "foo" again. IMA will not measure i=
t
> + * (since it was already measured) unless the event_name, for instance,
> + * is different in this call.
> + */
> +static char *selinux_event_name(const char *name_prefix)
> +{
> +       char *event_name =3D NULL;
> +       struct timespec64 cur_time;
> +
> +       ktime_get_real_ts64(&cur_time);
> +       event_name =3D kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix=
,
> +                              cur_time.tv_sec, cur_time.tv_nsec);
> +       if (!event_name) {
> +               pr_err("%s: event name not allocated.\n", __func__);
> +               return NULL;
> +       }
> +
> +       return event_name;
> +}
> +
> +static int read_selinux_state(char **state_str, int *state_str_len,
> +                             struct selinux_state *state)
> +{
> +       char *buf, *str_fmt =3D "%s=3D%d;";
> +       int i, buf_len, curr;
> +       bool initialized =3D selinux_initialized(state);
> +       bool enabled =3D !selinux_disabled(state);
> +       bool enforcing =3D enforcing_enabled(state);
> +       bool checkreqprot =3D checkreqprot_get(state);
> +
> +       buf_len =3D snprintf(NULL, 0, str_fmt, "initialized", initialized=
);
> +       buf_len +=3D snprintf(NULL, 0, str_fmt, "enabled", enabled);
> +       buf_len +=3D snprintf(NULL, 0, str_fmt, "enforcing", enforcing);
> +       buf_len +=3D snprintf(NULL, 0, str_fmt, "checkreqprot", checkreqp=
rot);
> +
> +       for (i =3D 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +               buf_len +=3D snprintf(NULL, 0, str_fmt,
> +                                   selinux_policycap_names[i],
> +                                   state->policycap[i]);
> +       }
> +       ++buf_len;
> +
> +       buf =3D kzalloc(buf_len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       curr =3D snprintf(buf, buf_len, str_fmt,
> +                       "initialized", initialized);
> +       curr +=3D snprintf((buf + curr), (buf_len - curr), str_fmt,
> +                        "enabled", enabled);
> +       curr +=3D snprintf((buf + curr), (buf_len - curr), str_fmt,
> +                        "enforcing", enforcing);
> +       curr +=3D snprintf((buf + curr), (buf_len - curr), str_fmt,
> +                        "checkreqprot", checkreqprot);

Wondering if we should be using scnprintf() when writing to the buffer
instead of snprintf() to ensure it returns the actual length written.
Technically shouldn't be an issue since we just computed the length
above and allocated to that size but might be less prone to error in
the future.

> +
> +       for (i =3D 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +               curr +=3D snprintf((buf + curr), (buf_len - curr), str_fm=
t,
> +                                selinux_policycap_names[i],
> +                                state->policycap[i]);

Ditto

> +       }
> +
> +       *state_str =3D buf;
> +       *state_str_len =3D curr;
> +
> +       return 0;
> +}
> +
> +/*
> + * selinux_measure_state - Measure SELinux state configuration and hash =
of
> + *                        the SELinux policy.
> + * @state: selinux state struct
> + *
> + * NOTE: This function must be called with policy_mutex held.
> + */
> +void selinux_measure_state(struct selinux_state *state)
> +{
> +       void *policy =3D NULL;
> +       char *state_event_name =3D NULL;
> +       char *policy_event_name =3D NULL;
> +       char *state_str =3D NULL;
> +       size_t policy_len;
> +       int state_str_len, rc =3D 0;
> +       bool initialized =3D selinux_initialized(state);
> +
> +       rc =3D read_selinux_state(&state_str, &state_str_len, state);
> +       if (rc) {
> +               pr_err("%s: Failed to read selinux state.\n", __func__);
> +               return;
> +       }
> +
> +       /*
> +        * Get a unique string for measuring the current SELinux state.
> +        */
> +       state_event_name =3D selinux_event_name("selinux-state");
> +       if (!state_event_name) {
> +               pr_err("%s: Event name for state not allocated.\n",
> +                      __func__);
> +               rc =3D -ENOMEM;
> +               goto out;
> +       }

Why get the event name after creating the state string?  If memory is
under sufficient pressure to cause the event name allocation to fail,
then we're going to fail on allocating the state string too and no
point in doing the work in that case.

> +
> +       ima_measure_critical_data(state_event_name, "selinux",
> +                                 state_str, state_str_len, false);
> +
> +       /*
> +        * Measure SELinux policy only after initialization is completed.
> +        */
> +       if (!initialized)
> +               goto out;
> +
> +       rc =3D security_read_policy_kernel(state, &policy, &policy_len);
> +       if (rc)
> +               goto out;
> +
> +       policy_event_name =3D selinux_event_name("selinux-policy-hash");
> +       if (!policy_event_name) {
> +               pr_err("%s: Event name for policy not allocated.\n",
> +                      __func__);
> +               rc =3D -ENOMEM;
> +               goto out;
> +       }

Ditto.

> +
> +       ima_measure_critical_data(policy_event_name, "selinux",
> +                                 policy, policy_len, true);
> +
> +out:
> +       kfree(state_event_name);
> +       kfree(policy_event_name);
> +       kfree(state_str);
> +       vfree(policy);

Can you free them in the reverse order in which they were allocated?
And the vfree() likely can get moved before the out:
label if you reverse the order in which the event name and policy get alloc=
ated.
For some related discussion around error handling and freeing of
things, see https://lore.kernel.org/selinux/20200825125130.GA304650@mwanda/
and https://lore.kernel.org/selinux/20200826113148.GA393664@mwanda/.

> +}
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 4bde570d56a2..a4f1282f7178 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -182,6 +182,10 @@ static ssize_t sel_write_enforce(struct file *file, =
const char __user *buf,
>                 selinux_status_update_setenforce(state, new_value);
>                 if (!new_value)
>                         call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NUL=
L);
> +
> +               mutex_lock(&state->policy_mutex);
> +               selinux_measure_state(state);
> +               mutex_unlock(&state->policy_mutex);

Side bar question for selinux maintainers: should we extend the scope
of this mutex to cover the entire operation (or at least everything
from reading the old value to setting the new value)?  It isn't
strictly necessary but might be nicer.  Ditto for disable and
checkreqprot, although both of those are being deprecated.
