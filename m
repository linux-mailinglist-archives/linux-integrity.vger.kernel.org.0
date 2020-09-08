Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA78261D23
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbgIHTc7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730959AbgIHP6F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD8C06135B;
        Tue,  8 Sep 2020 05:35:15 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id o20so1610753ook.1;
        Tue, 08 Sep 2020 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B8krLLGJl/FrBTPsIPEOiXMh9NVPKW4gVDQh9+/ltKg=;
        b=Bci32BjkSFTIodqWnoNug5Kd9qPwvhpLOs1moRMHzwnDX9h4pJFZI8rXwjwA+NaUVJ
         ismAInSMCoJbONjUWn4EYQvneQsthRXE0mrj2MHLP6TcwtjhO2/wW9F1PE330GJ/GTfV
         bgI2ouQKhpLuoNTqlWuEGrVYPKJ7OH/RYEJKVH8EGt++3CwVVDIXGslZ4Yo5HTWb3/yB
         qE9j6TGRVGP0Cyk/NANnj3tczK+UJRkpxaGvDfdkwskNXCyWUMlkc+wZbAf+a9iS1vyH
         Vc4LOQeMVv3ZEq4qN3qqc/ntRjRyfXrY4ox6Rg4ooiMgH/TmjP40yJf84jzjc4l7N9dr
         BcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B8krLLGJl/FrBTPsIPEOiXMh9NVPKW4gVDQh9+/ltKg=;
        b=emidhKUWsD6yvNKMYwiSTcB9jue9cxzh2mD3ewYFtVGzXSxix9oQxVWPo+JSPGFP1j
         dfy3497tpzVWBQcLBXUFdVDUQ6C8CZvz5+lNXkkAaNBfcNUlxC/OtSy/uBrUicyzmyd/
         bCeVqG9OzPfXl3i0gcvY8K8Hxdc8OIVwhJDSmfFNwn0O6FT3MOT9Zw+FMI928KRvFfk3
         kWntwGHzN4c08K2xg5HuK17Qu7PRe4YSXYHNrfVdP6Nvfz/AcVQ8G5AK6t3nq9xIxYRN
         C5Ix7wW+VMR2M3PCKtYLuTLNRgK69+o+XRXESXhrbo/h5yg9+UEZzfr0vbXAToMEm3iC
         eDqA==
X-Gm-Message-State: AOAM533nX1LxUk6XpuLd9noVheL7BjKghfLeVdfrBXjX0DlAAmUod/Iq
        kuDtdcRNS3x/l++h81tCI6M8CxvzNaYJqxeaPKg=
X-Google-Smtp-Source: ABdhPJzkgeDiRZ+a0yn/5ylF8CMXw37unFL76QeFV7KTsMQYy0lZCnLhLMPLYDdGGHuy6EZoeuE/xZIUjsBbXbq/99Q=
X-Received: by 2002:a4a:d0ad:: with SMTP id t13mr18503020oor.58.1599568513251;
 Tue, 08 Sep 2020 05:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com> <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Swgi2Jewzja8MRiVdYn8H1-OkDy5BR7Vv4A4LaLWZ+Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 08:35:02 -0400
Message-ID: <CAEjxPJ4woNFU+FvmP72sjcfxotrjS4VFWL5ECS9ensKYUpF84Q@mail.gmail.com>
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

On Tue, Sep 8, 2020 at 8:28 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 7, 2020 at 5:39 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > Critical data structures of security modules are currently not measured=
.
> > Therefore an attestation service, for instance, would not be able to
> > attest whether the security modules are always operating with the polic=
ies
> > and configuration that the system administrator had setup. The policies
> > and configuration for the security modules could be tampered with by
> > rogue user mode agents or modified through some inadvertent actions on
> > the system. Measuring such critical data would enable an attestation
> > service to reliably assess the security configuration of the system.
> >
> > SELinux configuration and policy are some of the critical data for this
> > security module that needs to be measured. This measurement can be used
> > by an attestation service, for instance, to verify if the configuration
> > and policies have been setup correctly and that they haven't been tampe=
red
> > with at runtime.
> >
> > Measure SELinux configuration, policy capabilities settings, and the ha=
sh
> > of the loaded policy by calling the IMA hook ima_measure_critical_data(=
).
> > Since the size of the loaded policy can be quite large, hash of the pol=
icy
> > is measured instead of the entire policy to avoid bloating the IMA log.
> >
> > Enable early boot measurement for SELinux in IMA since SELinux
> > initializes its state and policy before custom IMA policy is loaded.
> >
> > Sample measurement of SELinux state and hash of the policy:
> >
> > 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:2878=
99386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d3=
03b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c73=
3d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733=
d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c61=
62656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f736=
5636c6162656c5f73796d6c696e6b733d303
> > 10 9e81...0857 ima-buf sha256:4941...68fc selinux-policy-hash-159733566=
7:462051628 8d1d...1834
> >
> > To verify the measurement check the following:
> >
> > Execute the following command to extract the measured data
> > from the IMA log for SELinux configuration (selinux-state).
> >
> >   grep -m 1 "selinux-state" /sys/kernel/security/integrity/ima/ascii_ru=
ntime_measurements | cut -d' ' -f 6 | xxd -r -p
> >
> > The output should be the list of key-value pairs. For example,
> >  initialized=3D1;enabled=3D1;enforcing=3D0;checkreqprot=3D1;network_pee=
r_controls=3D1;open_perms=3D1;extended_socket_class=3D1;always_check_networ=
k=3D0;cgroup_seclabel=3D1;nnp_nosuid_transition=3D1;genfs_seclabel_symlinks=
=3D0;
> >
> > To verify the measured data with the current SELinux state:
> >
> >  =3D> enabled should be set to 1 if /sys/fs/selinux folder exists,
> >     0 otherwise
> >
> > For other entries, compare the integer value in the files
> >  =3D> /sys/fs/selinux/enforce
> >  =3D> /sys/fs/selinux/checkreqprot
> > And, each of the policy capabilities files under
> >  =3D> /sys/fs/selinux/policy_capabilities
> >
> > For selinux-policy-hash, the hash of SELinux policy is included
> > in the IMA log entry.
> >
> > To verify the measured data with the current SELinux policy run
> > the following commands and verify the output hash values match.
> >
> >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> >
> >   grep -m 1 "selinux-policy-hash" /sys/kernel/security/integrity/ima/as=
cii_runtime_measurements | cut -d' ' -f 6
> >
> > This patch is based on commit 66ccd2560aff ("selinux: simplify away sec=
urity_policydb_len()")
> > in "next" branch in https://git.kernel.org/pub/scm/linux/kernel/git/pcm=
oore/selinux.git
> >
> > This patch is dependent on the following patch series and must be
> > applied in the given order:
> >         https://patchwork.kernel.org/patch/11709527/
> >         https://patchwork.kernel.org/patch/11730193/
> >         https://patchwork.kernel.org/patch/11730757/
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kc=
onfig
> > index 953314d145bb..9bf0f65d720b 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -324,8 +324,7 @@ config IMA_MEASURE_ASYMMETRIC_KEYS
> >
> >  config IMA_QUEUE_EARLY_BOOT_DATA
> >         bool
> > -       depends on IMA_MEASURE_ASYMMETRIC_KEYS
> > -       depends on SYSTEM_TRUSTED_KEYRING
> > +       depends on (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRI=
NG) || SECURITY_SELINUX
> >         default y
>
> I don't see why this is necessary or desirable.  We should avoid
> leaking dependencies on a single security module into other
> subsystems.
> It might not yet fully support other security modules but we shouldn't
> preclude adding that in the future.
> Up to the IMA maintainer but I would recommend dropping this part.

Sorry, I misread this part; it doesn't make IMA depend on SELinux it
just allows enabling this early boot data feature if SELinux is
enabled since SELinux is a user of it.  Still, it seems unfortunate to
have to explicitly enumerate each consumer of this facility here
whenever a new one is introduced.  Is there a reason for doing so and
not just allowing it to be enabled as long as the things on which it
depends are enabled (i.e. not based on its consumers)?
