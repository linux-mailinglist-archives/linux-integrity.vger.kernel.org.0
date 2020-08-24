Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5AB24FF68
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHXOAV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXOAS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 10:00:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89841C061573;
        Mon, 24 Aug 2020 07:00:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j18so3454733oig.5;
        Mon, 24 Aug 2020 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a8tt+CMGp7q/HOS53VXK8umX/MA6yVJ2CpHA9QlQNUw=;
        b=j8uvweukLv7148MhKVNormlhapYg2r0+5kfglczLY9e1LRAzzw1ydGewupqwmMvSU9
         0SjUkT2GcExDoXKcNevn7vGcs0xGz2h1N4tCpeSa0iXNchm6UQrqjss8wj8iqknBoa+S
         4MyIoD7O1E/7jGZ1HXXTiSnTZI3z75OxzfwbLWooVh5tkB9F7CVR106kj2K77Gh7i9XF
         R4rRhqAGQvSFYzETpRYZQRJ6IgM/bI2fHoUXs2zfGtW/xvFSxFiN3NLS1+UM9fAiOcBA
         a11bZrRB4MWND2aPR8LFcTFIthLCJPUkn3jleIrczBllIiwRIWw7tpwZbx1P6n/krn/Q
         xt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a8tt+CMGp7q/HOS53VXK8umX/MA6yVJ2CpHA9QlQNUw=;
        b=kGZk87T8Cc1h4YPI6UyNdqulXpbOOc2kfJZ6cKMhnOY9uVN7+9/13q6oQ1BY6K+A3k
         U+js+qnbrND0F0whi1XLTmcZ9T0hfP9VWKdcH5EclQI0NfNN/iqWBjTL+jmVT8qJw3Th
         l2g7tanKvTwyWf6cTTaQdtFRVewtNGvYcpUABZsCLnKVey1RgEBlYE9aiuIeat3W7WKV
         LDqz1OMGPAimTaMErloh+R6j02f5Sn8f5ApSWQ+QaaDyxPzf7l6r31tBXsPdof44zkEm
         LF5N0pzTGHRTVUq33IP5yd05JkpaQavTtGKYek61aSx3KACgzH03tkaefPA+bApL/BR3
         Ih4Q==
X-Gm-Message-State: AOAM531IaKNpScUfaFa9kdFKZDZA0d0j7NeoZWfqKRTKB/+Y1hLdAqZy
        MJFcJxSrMl/guOYlsyFGwGOYoz/S7eB3kE2CqG8=
X-Google-Smtp-Source: ABdhPJzSCgmgjsf4aPA4dULiOZlq9CD+b2wfdzyohpAoZ/AbfGHUt43p6iguzyk+upLrdXl8pepvjautteI5JHkkAOQ=
X-Received: by 2002:a54:4817:: with SMTP id j23mr3170930oij.140.1598277617933;
 Mon, 24 Aug 2020 07:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
In-Reply-To: <20200822010018.19453-1-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 10:00:07 -0400
Message-ID: <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, sashal@kernel.org,
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

On Fri, Aug 21, 2020 at 9:00 PM Lakshmi Ramasubramanian
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
> This patch is dependent on the following patch series:
>         https://patchwork.kernel.org/patch/11709527/
>         https://patchwork.kernel.org/patch/11730193/
>         https://patchwork.kernel.org/patch/11730757/
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declarat=
ion of function 'vfree'
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declarat=
ion of function 'crypto_alloc_shash'
> Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security=
_read_selinux_policy' was not declared. Should it be static?
> ---

> +int security_read_policy_kernel(struct selinux_state *state,
> +                               void **data, size_t *len)
> +{
> +       int rc;
> +
> +       rc =3D security_read_policy_len(state, len);
> +       if (rc)
> +               return rc;
> +
> +       *data =3D vmalloc(*len);
> +       if (!*data)
> +               return -ENOMEM;
>
> +       return security_read_selinux_policy(state, data, len);
>  }

See the discussion here:
https://lore.kernel.org/selinux/20200824113015.1375857-1-omosnace@redhat.co=
m/T/#t

In order for this to be safe, you need to ensure that all callers of
security_read_policy_kernel() have taken fsi->mutex in selinuxfs and
any use of security_read_policy_len() occurs while holding the mutex.
Otherwise, the length can change between security_read_policy_len()
and security_read_selinux_policy() if policy is reloaded.
