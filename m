Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A5622622B
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 16:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgGTObq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTObq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 10:31:46 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A8AC061794;
        Mon, 20 Jul 2020 07:31:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so12288378oty.11;
        Mon, 20 Jul 2020 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q3g5qbdmC19gV+NnXyKNCgQ/rTdz9C9y5peqjUosD9s=;
        b=lT61+N1i6xbgCZrxUx/ahZydAhqURpCPx0Fyz8BDuoTYteem+4vYQJ6DI8J3UJkwiv
         YntOzmEQicJdm8cXoqEshZGmwh/TG4+Tmm0FhQJ+RkpNZBjY+zpxqeMx2Q8epR2kPkvD
         kZ697dtgohPa5PRrPc0kJCGpDoEQpDQC2CJKD4rz2lpdNpT404eJrdvtQ0vu1wMIXZxW
         y6OZV5SJM6hgbQRzwJe8EFKNURGCEuIAO0IUKVk5Wwh++HDagpJSIJK4oWicBYzFd+fq
         fCTF57QvxmZp1vasmMaXVc09PQbJ2W7KwEsSoGSvMpgmc2YC3YPsiYmjIinYqviy9stE
         rNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q3g5qbdmC19gV+NnXyKNCgQ/rTdz9C9y5peqjUosD9s=;
        b=p7WjOQ1G4YrLZNwMdqsyL0EYlMn75pwR7gLbeUJ1v6LbRLuJDZ4w6bZdKuAf6MIJAS
         PPoJI6d32PZpGJhFD1zPBbDp1VaH+m2GHLsaDgvIjR4RpGmvwG+glDgVdRqnqWlVqFOi
         Va90RXgDc4MTVfz2+8pZ93IvQIfu2RoRkiByHqwhU5cLN/q2nQDo+Cq26oFVtphe7x7u
         /cT3dMeSQf3TKna0fH8Fp9w3NMfKRVuaV0IwlQw5N72M52LfpvKIXcgtB3wCd2KFpvVV
         wWkjL9iImZH0INAl/yDSG5Ylw+uKmeuz3q32egZ2sfC915HAhuo1rezPjIxJ5sTPA8kr
         EJuQ==
X-Gm-Message-State: AOAM530EOpJLSublnUNLj6TOmDVUp3+n/hRXC6/jacVNxKt8WbqI9t97
        ipxE2vfjA40iQy5EHbHFmi4WAwUdRw8i88DAXVBd/A==
X-Google-Smtp-Source: ABdhPJzGd8HYBZ1g5Cuh4cWHg44hrn4tgLZQsYcHeteNz+04u3lDAyMzPQRrObfAyyJ3oc3PfxGOyaNlNfU6RmmZ6sM=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr20798184oto.135.1595255505584;
 Mon, 20 Jul 2020 07:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200717222819.26198-1-nramas@linux.microsoft.com> <20200717222819.26198-5-nramas@linux.microsoft.com>
In-Reply-To: <20200717222819.26198-5-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Jul 2020 10:31:34 -0400
Message-ID: <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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

On Fri, Jul 17, 2020 at 6:28 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> SELinux configuration and policy are some of the critical data for this
> security module that needs to be measured. To enable this measurement
> SELinux needs to implement the interface function,
> security_measure_data(), that the LSM can call.
>
> Define the security_measure_data() function in SELinux to measure SELinux
> configuration and policy. Call this function to measure SELinux data
> when there is a change in the security module's state.
>
> Sample measurement of SELinux state and hash of the policy:
>
> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state 656e61626c65643d3=
13b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574706565723d31=
3b6f70656e7065726d3d313b657874736f636b636c6173733d313b616c776179736e6574776=
f726b3d303b6367726f75707365636c6162656c3d313b6e6e706e6f737569647472616e7369=
74696f6e3d313b67656e66737365636c6162656c73796d6c696e6b3d303b
> 10 f4a7...9408 ima-buf sha256:4941...68fc selinux-policy-hash 8d1d...1834
>
> To verify the measurement check the following:
>
> Execute the following command to extract the measured data
> from the IMA log for SELinux configuration (selinux-state).
>
>   cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | gre=
p -m 1 "selinux-state" | cut -d' ' -f 6 | xxd -r -p
>
> The output should be the list of key-value pairs. For example,
>  enabled=3D1;enforcing=3D0;checkreqprot=3D1;network_peer_controls=3D1;ope=
n_perms=3D1;extended_socket_class=3D1;always_check_network=3D0;cgroup_secla=
bel=3D1;nnp_nosuid_transition=3D1;genfs_seclabel_symlinks=3D0;
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
> The data for selinux-policy-hash is the SHA256 hash of SELinux policy.
>
> To verify the measured data with the current SELinux policy run
> the following commands and verify the output hash values match.
>
>   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
>
>   cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | gre=
p -m 1 "selinux-policy-hash" | cut -d' ' -f 6
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..659011637ae7
> --- /dev/null
> +++ b/security/selinux/measure.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Measure SELinux state using IMA subsystem.
> + */
> +#include <linux/ima.h>
> +#include "security.h"
> +
> +/* Pre-allocated buffer used for measuring state */
> +static char *selinux_state_string;
> +static size_t selinux_state_string_len;
> +static char *str_format =3D "%s=3D%d;";
> +static int selinux_state_count;
> +
> +void __init selinux_init_measurement(void)
> +{
> +       int i;
> +
> +       /*
> +        * enabled
> +        * enforcing
> +        * checkreqport

checkreqprot (spelling)

What about initialized?  Or do you consider that to be implicitly
true/1 else we wouldn't be taking a measurement?  Only caveat there is
that it provides one more means of disabling measurements (at the same
time as disabling enforcement) by setting it to false/0 via kernel
write flaw.

> +        * All policy capability flags
> +        */
> +       selinux_state_count =3D 3 + __POLICYDB_CAPABILITY_MAX;
> +
> +       selinux_state_string_len =3D snprintf(NULL, 0, str_format,
> +                                           "enabled", 0);
> +       selinux_state_string_len +=3D snprintf(NULL, 0, str_format,
> +                                            "enforcing", 0);
> +       selinux_state_string_len +=3D snprintf(NULL, 0, str_format,
> +                                            "checkreqprot", 0);
> +       for (i =3D 3; i < selinux_state_count; i++) {
> +               selinux_state_string_len +=3D
> +                       snprintf(NULL, 0, str_format,
> +                                selinux_policycap_names[i-3], 0);
> +       }

What's the benefit of this pattern versus just making the loop go from
0 to __POLICYDB_CAPABILITY_MAX and using selinux_policycap_names[i]?

> +void selinux_measure_state(struct selinux_state *selinux_state)
> +{
> +       void *policy =3D NULL;
> +       void *policy_hash =3D NULL;
> +       size_t curr, buflen;
> +       int i, policy_hash_len, rc =3D 0;
> +
> +       if (!selinux_initialized(selinux_state)) {
> +               pr_warn("%s: SELinux not yet initialized.\n", __func__);
> +               return;
> +       }

We could measure the global state variables before full SELinux
initialization (i.e. policy load).
Only the policy hash depends on having loaded the policy.

> +
> +       if (!selinux_state_string) {
> +               pr_warn("%s: Buffer for state not allocated.\n", __func__=
);
> +               return;
> +       }
> +
> +       curr =3D snprintf(selinux_state_string, selinux_state_string_len,
> +                       str_format, "enabled",
> +                       !selinux_disabled(selinux_state));
> +       curr +=3D snprintf((selinux_state_string + curr),
> +                        (selinux_state_string_len - curr),
> +                        str_format, "enforcing",
> +                        enforcing_enabled(selinux_state));
> +       curr +=3D snprintf((selinux_state_string + curr),
> +                        (selinux_state_string_len - curr),
> +                        str_format, "checkreqprot",
> +                        selinux_checkreqprot(selinux_state));
> +
> +       for (i =3D 3; i < selinux_state_count; i++) {
> +               curr +=3D snprintf((selinux_state_string + curr),
> +                                (selinux_state_string_len - curr),
> +                                str_format,
> +                                selinux_policycap_names[i - 3],
> +                                selinux_state->policycap[i - 3]);
> +       }

Same question here as for the previous loop; seems cleaner to go from
0 to __POLICYDB_CAPABILITY_MAX and use [i].

What public git tree / branch would you recommend trying to use your
patches against?  Didn't seem to apply to any of the obvious ones.
