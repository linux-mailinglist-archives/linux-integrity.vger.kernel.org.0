Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9092618DB
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgIHR6r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgIHQMO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE4C061385;
        Tue,  8 Sep 2020 05:29:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so6994908ota.10;
        Tue, 08 Sep 2020 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fZHagmsPoaN3dfpaMIS6LHX3fvwlejq5mDI6zTR/iOo=;
        b=Am0P4t7mHMARUpo3k6pBwG7sBs8ZIHBcLfM13uFw+hldnbRLZp3TY7oJJ2CIW1+cIn
         CbXxjXU+yXGzC+XM7Ex6qgTi5zwQ9CjDG12jU5ceaZna20Rs9Gl0s+E5FJUIooCz7Pel
         XoFE1185F5cBvrb1qoyz3C1Sd6WMZvVtKFAvuh11iEpfHfHkQTPvMNUEbgSwrcVWKfYs
         +yX4mBJlAo7BcpfSrJ8D2QLd5P+i0dleUj3iDOIVhK1A8f1DDjkB+e2J+Hh+i0mBnD+l
         plL+QTRWPzhwUPr1rOc77CuIWnCkxoHLnnkzwAiu3HpevxDwYO2uHX6tcNpTICxPtfdX
         DC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fZHagmsPoaN3dfpaMIS6LHX3fvwlejq5mDI6zTR/iOo=;
        b=V3dlk6bhRtIbAaJJMx21aQ7iNKYoBN8Qlxf1BCuYQwqunq4z837LXV859ZSVxoB4e3
         pd53XAxcoI+sjHirtOS1gGZPoA8Cezl/70+z+sa57FHJut7ceouXoEcRJ1XRWMILS+N3
         VutieNDZHw300zYHrJVP+iYSJX95qXWq+bl3+rpDfHW8rKfANVDI1Qs3eNFkaRsXsF7F
         4/gJqDHWS0f3HThhWUJizhZXbmMUscIDJS4rimDL8rqzh5acOvSBlCbA1rxuiuIhWmMu
         Mlx6UZKhTTMpHAsXf3Z5hyFuszbNcllotfOQylcdrA4wjLhRyP/EzAWPfhvNthUMv5OW
         Gw1A==
X-Gm-Message-State: AOAM532p3cEm60946zgILSetv0wTN9szlsW5g37NQWcRn+bKJwUO3Knc
        srz7hUjCOjGH7XjwX62dTddgZzgAcSo0pXprflw=
X-Google-Smtp-Source: ABdhPJzPzLrSGFB6n46kcHxrUu7fJvn2jX5PE5gWuzgLhSpcFs85Ww7KdeAp2jDridKFVCvUlUfFTDgWQ2tYQBzYCfY=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr16851445otn.89.1599568139206;
 Tue, 08 Sep 2020 05:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com>
In-Reply-To: <20200907213855.3572-1-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 08:28:48 -0400
Message-ID: <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 7, 2020 at 5:39 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> Critical data structures of security modules are currently not measured.
> Therefore an attestation service, for instance, would not be able to
> attest whether the security modules are always operating with the policie=
s
> and configuration that the system administrator had setup. The policies
> and configuration for the security modules could be tampered with by
> rogue user mode agents or modified through some inadvertent actions on
> the system. Measuring such critical data would enable an attestation
> service to reliably assess the security configuration of the system.
>
> SELinux configuration and policy are some of the critical data for this
> security module that needs to be measured. This measurement can be used
> by an attestation service, for instance, to verify if the configuration
> and policies have been setup correctly and that they haven't been tampere=
d
> with at runtime.
>
> Measure SELinux configuration, policy capabilities settings, and the hash
> of the loaded policy by calling the IMA hook ima_measure_critical_data().
> Since the size of the loaded policy can be quite large, hash of the polic=
y
> is measured instead of the entire policy to avoid bloating the IMA log.
>
> Enable early boot measurement for SELinux in IMA since SELinux
> initializes its state and policy before custom IMA policy is loaded.
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
>
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
>
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
>
> This patch is based on commit 66ccd2560aff ("selinux: simplify away secur=
ity_policydb_len()")
> in "next" branch in https://git.kernel.org/pub/scm/linux/kernel/git/pcmoo=
re/selinux.git
>
> This patch is dependent on the following patch series and must be
> applied in the given order:
>         https://patchwork.kernel.org/patch/11709527/
>         https://patchwork.kernel.org/patch/11730193/
>         https://patchwork.kernel.org/patch/11730757/
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 953314d145bb..9bf0f65d720b 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -324,8 +324,7 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
>
>  config IMA_QUEUE_EARLY_BOOT_DATA
>         bool
> -       depends on IMA_MEASURE_ASYMMETRIC_KEYS
> -       depends on SYSTEM_TRUSTED_KEYRING
> +       depends on (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING=
) || SECURITY_SELINUX
>         default y

I don't see why this is necessary or desirable.  We should avoid
leaking dependencies on a single security module into other
subsystems.
It might not yet fully support other security modules but we shouldn't
preclude adding that in the future.
Up to the IMA maintainer but I would recommend dropping this part.

> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index cbdd3c7aff8b..c971ec09d855 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -209,6 +209,11 @@ static inline bool selinux_policycap_genfs_seclabel_=
symlinks(void)
>         return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLIN=
KS];
>  }
>
> +static inline bool selinux_checkreqprot(const struct selinux_state *stat=
e)
> +{
> +       return READ_ONCE(state->checkreqprot);
> +}
> +

Since you are introducing this helper, you should also convert
existing reads of selinux_state.checkreqprot and
fsi->state->checkreqprot to use it, and writes to use WRITE_ONCE()
just like for enforcing and disabled.  The introduction of the helper
and conversion to use it could be done as a separate patch before this
one.

> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..caf9107937d9
> --- /dev/null
> +++ b/security/selinux/measure.c
<snip>
> +static int read_selinux_state(char **state_str, int *state_str_len,
> +                             struct selinux_state *state)
> +{
> +       char *buf, *str_fmt =3D "%s=3D%d;";
> +       int i, buf_len, curr;
<snip>
> +       for (i =3D 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +               buf_len +=3D snprintf(NULL, 0, str_fmt,
> +                                   selinux_policycap_names[i],
> +                                   state->policycap[i]);
> +       }

This will need to be converted to use
security_policycap_supported(state, i) rather than state->policycap[i]
since the latter is going to be removed by Ondrej's patches I think.

> +       for (i =3D 0; i < __POLICYDB_CAPABILITY_MAX; i++) {
> +               curr +=3D snprintf((buf + curr), (buf_len - curr), str_fm=
t,
> +                                selinux_policycap_names[i],
> +                                state->policycap[i]);

Ditto.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 45e9efa9bf5b..bb460954de03 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -176,6 +176,7 @@ static ssize_t sel_write_enforce(struct file *file, c=
onst char __user *buf,
>                         from_kuid(&init_user_ns, audit_get_loginuid(curre=
nt)),
>                         audit_get_sessionid(current));
>                 enforcing_set(state, new_value);
> +               selinux_measure_state(state, false);

I think we should move this to after the avc_ss_reset call so that we
don't introduce a potentially long delay between setting the enforcing
mode and flushing the AVC at least.  Potentially it could be moved to
the very end after selnl_notify_setenforce() too so that it doesn't
delay notifying userspace, but that's less crucial.

>                 if (new_value)
>                         avc_ss_reset(state->avc, 0);
>                 selnl_notify_setenforce(new_value);
> @@ -761,6 +762,8 @@ static ssize_t sel_write_checkreqprot(struct file *fi=
le, const char __user *buf,
>
>         fsi->state->checkreqprot =3D new_value ? 1 : 0;

This should switch to using WRITE_ONCE() or a helper that uses it.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 8dc111fbe23a..04a9c3d8c19b 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3874,6 +3875,30 @@ int security_netlbl_sid_to_secattr(struct selinux_=
state *state,
>  }
>  #endif /* CONFIG_NETLABEL */
>
> +/**
> + * security_read_selinux_policy - read the policy.
> + * @policy: SELinux policy
> + * @data: binary policy data
> + * @len: length of data in bytes
> + *
> + */
> +static int security_read_selinux_policy(struct selinux_policy *policy,
> +                                       void **data, size_t *len)
> +{

Since this only uses *data, why not just pass that here?

> +       int rc;
> +       struct policy_file fp;
> +
> +       fp.data =3D *data;
> +       fp.len =3D *len;
> +
> +       rc =3D policydb_write(&policy->policydb, &fp);
> +       if (rc)
> +               return rc;
> +
> +       *len =3D (unsigned long)fp.data - (unsigned long)*data;
> +       return 0;
> +}
> +
>  /**
>   * security_read_policy - read the policy.
>   * @data: binary policy data
