Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A822606EE
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 00:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgIGWcc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgIGWcb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 18:32:31 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F393C061573;
        Mon,  7 Sep 2020 15:32:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a65so13287560otc.8;
        Mon, 07 Sep 2020 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SSBsABurBTaJlix9WRMaGS9qOSk/fDmwyNLZ018o2GE=;
        b=cpl+dwPKLTo5K/wLy+LwcB3EG0XcfQTMi47Ahqcq+blt/HE+MXXf5MDcnc76jtQL9u
         TO78WVd7w+mm1v97gvyHLWUS7tRPcwPgm+zrUwQ5XPhC2G0Mm3ptg4vRZzsyV4CdR2YI
         kmoazwyQPo6JssFM2xaVNSMBKiH+KNAnGGlONe+hsTTm+R/WKNmPuWzz/g0RQgIDGF3e
         aEsiUOo9Va/XBW9cBIENDFUaAGIkBZ/zL3bDdYLNxY6pQzOw1jXW84n8cRu6JytwWC3e
         aE72uoDE9vd4rNEu3z03IyGbMuIjvWT0a4s7ReBJnSsIBk6HWGhSrvaAIFcqVMIwPav5
         Gd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SSBsABurBTaJlix9WRMaGS9qOSk/fDmwyNLZ018o2GE=;
        b=G/Sk8lzlxzRtnQ5DYLKr/bjq0DAmREgb97yAmJPyOLQ6Jfgol+ZpSk6wQFVFrboYv9
         CKtiK2AQLng72PXgKhJJIt9ujKGbwpQ+6Zt316XUpy2PBPN97SzyjV0FAo8R7VUGxQgr
         lE5VVVFg5Qhy4VPig6cAIOP7GDIUAJYYLgM1fXahQFJeypXLxwI1Cg7P3+BrOuMU1nbu
         JQmCAY4MGjgDscBh5JafVnnJ6I8MSLjJx/pFXPHVkvGGVJWMPf3+xmiVS9Zi5UzYsmzD
         q4puMQr6TQeDcjsbnlq/6aeGvxk/X5v+d+c1pbxsTQknt7usGCEJEBwZf9tFnRuTQfK0
         miiA==
X-Gm-Message-State: AOAM531BWzeINSHOwd9ClQHkpJDUdzKQGRnaf7GpFGH9PZPwCnzIoQgr
        QlU8BMX1byYSivEWYQRqWzpKs7Bwjj6bmvBJqHA=
X-Google-Smtp-Source: ABdhPJz74VcXi1cwh9+WOlsVSrO6zUKdBwfLGyeDlIfpAepoIuLWWH+eHJPcQh6Gl6wZsLOJJpRF9dRLcvMlh96I1sw=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr15979909otb.162.1599517949078;
 Mon, 07 Sep 2020 15:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200907213855.3572-1-nramas@linux.microsoft.com>
In-Reply-To: <20200907213855.3572-1-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 7 Sep 2020 18:32:16 -0400
Message-ID: <CAEjxPJ5C64AmmVKuuPmtbfnY06w49ziryRAnARurWxpQumzfow@mail.gmail.com>
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
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declarat=
ion of function 'vfree'
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declarat=
ion of function 'crypto_alloc_shash'
> Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security=
_read_selinux_policy' was not declared. Should it be static?

Not sure these Reported-by lines are useful since they were just on
submitted versions of the patch not on an actual merged commit.

> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..caf9107937d9
> --- /dev/null
> +++ b/security/selinux/measure.c
<snip>
> +void selinux_measure_state(struct selinux_state *state, bool policy_mute=
x_held)
> +{
<snip>
> +
> +       if (!policy_mutex_held)
> +               mutex_lock(&state->policy_mutex);
> +
> +       rc =3D security_read_policy_kernel(state, &policy, &policy_len);
> +
> +       if (!policy_mutex_held)
> +               mutex_unlock(&state->policy_mutex);

This kind of conditional taking of a mutex is generally frowned upon
in my experience.
You should likely just always take the mutex in the callers of
selinux_measure_state() instead.
In some cases, it may be the caller of the caller.  Arguably selinuxfs
could be taking it around all state modifying operations (e.g.
enforce, checkreqprot) not just policy modifying ones although it
isn't strictly for that purpose.
