Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14211222B4D
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgGPSyS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPSyR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 14:54:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AC8C061755;
        Thu, 16 Jul 2020 11:54:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so5056875otc.3;
        Thu, 16 Jul 2020 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hh1P2ej3PSRq1WOldPof/pYHoI8ZC8oiK5qvMk9TyR0=;
        b=bB0GqtkF+m763mQ8H/zjdUE2tmoKXyBj5xknTJ2FjFNHnb9/9Idj5DCQUd2v4bl5lC
         e2kgL7T8sqTuXor8tyPCn6TNokY/9aPFtNuk2lPm6w7VpwJsa8Yjmk60VE73+9rin7jU
         POzPrc+m+Bv/pVWWrnKgXQQ7E+6KJ+6xhL453GVN4fiUl2ImlTtcJLG7XkcwZAJVe3mL
         Gpo+TBbB3DT5XNsVytw94iXWQ2H2pRk+CbxNpWQqh02pxoZ3cbSyNP2z6v8aWezPnOoJ
         VYViwIuNXNpzfnPOFyOhssvn/9urkUmCMMf/yBgnpeG918Y+JDevULC5dAL4kTrx3h6I
         KGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hh1P2ej3PSRq1WOldPof/pYHoI8ZC8oiK5qvMk9TyR0=;
        b=WMBW4F66SkOdz7OalaybCD59Zq+pAFUHfXkHIpvIvV1B+QTARR4Xb/LXSGbQCyQtJy
         trJWJ9ccY3fAyJFeCF6gOMqEt1eUa9y3XZK+AthBvx16o66yb9njnWKU68Uk2MHvbGvP
         BYgf+T4h2z7OTd+3WcRlHbNguk50rdThl9azZiKC/yAfRt42T6x6gFN/cli4/RcOBxBd
         YvAqnwffDpqbsQsZ/Z8gP4Tx9/7v6QJw0F3d41z8Rb1IHjbcQYjQSwQzk2DZTfBc2sdg
         gljzJAo5JrelganH9qrZS5Cn5T2inXAjg4aZ0J+amKBcK2AmV/omPbZRayaOXEt9NYOw
         RexQ==
X-Gm-Message-State: AOAM533FEBR0CWJgFDihIcVPSdY/XVkB1T47Fo0yfRNuo9dXOSoIcLTI
        GwEWmLgUkzRn+66KJF7qt5bla8FPp5GzF6x3mhrgiWfk
X-Google-Smtp-Source: ABdhPJz5CQk76FM+g6cXhnGWeCEydEOpfKBMJz3HmArpJ07d0bYKBDJdEk7sAkAQSMT2H2LdRmvDZteqI+fIukAa3hI=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr5552606otr.89.1594925656968;
 Thu, 16 Jul 2020 11:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200716174351.20128-1-nramas@linux.microsoft.com> <20200716174351.20128-5-nramas@linux.microsoft.com>
In-Reply-To: <20200716174351.20128-5-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 16 Jul 2020 14:54:06 -0400
Message-ID: <CAEjxPJ43eXK0xgrE=gDxZVg2SDTz4bkd7N4otjk-cvxf3fKL-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] LSM: Define SELinux function to measure security state
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

On Thu, Jul 16, 2020 at 1:44 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> SELinux configuration and policy are some of the critical data for this
> security module that needs to be measured. To enable this measurement
> SELinux needs to implement the interface function,
> security_measure_data(), that the LSM can call.
>
> Define the security_state() function in SELinux to measure SELinux
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
> The data for selinux-state in the above measurement is:
> enabled=3D1;enforcing=3D0;checkreqprot=3D1;network_peer_controls=3D1;open=
_perms=3D1;extended_socket_class=3D1;always_check_network=3D0;cgroup_seclab=
el=3D1;nnp_nosuid_transition=3D1;genfs_seclabel_symlinks=3D0;
>
> The data for selinux-policy-hash in the above measurement is
> the SHA256 hash of the SELinux policy.

Can you show an example of how to verify that the above measurement
matches a given state and policy, e.g. the sha256sum commands and
inputs to reproduce the same from an expected state and policy?

>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..27cbb309e926
> --- /dev/null
> +++ b/security/selinux/measure.c
> @@ -0,0 +1,158 @@
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
> +static char *selinux_state_string_fmt =3D
> +       "%s=3D%d;%s=3D%d;%s=3D%d;%s=3D%d;%s=3D%d;%s=3D%d;%s=3D%d;%s=3D%d;=
%s=3D%d;%s=3D%d;";
> +
> +void __init selinux_init_measurement(void)
> +{
> +       selinux_state_string_len =3D
> +       snprintf(NULL, 0, selinux_state_string_fmt,
> +       "enabled", 0,
> +       "enforcing", 0,
> +       "checkreqprot", 0,
> +       selinux_policycap_names[POLICYDB_CAPABILITY_NETPEER], 0,
> +       selinux_policycap_names[POLICYDB_CAPABILITY_OPENPERM], 0,
> +       selinux_policycap_names[POLICYDB_CAPABILITY_EXTSOCKCLASS], 0,
> +       selinux_policycap_names[POLICYDB_CAPABILITY_ALWAYSNETWORK], 0,
> +       selinux_policycap_names[POLICYDB_CAPABILITY_CGROUPSECLABEL], 0,
> +       selinux_policycap_names[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION=
], 0,
> +       selinux_policycap_names[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLIN=
KS],
> +       0);

I was thinking you'd dynamically construct the format string with a
for loop from 0 to POLICYDB_CAPABILITY_MAX
and likewise for the values so that we wouldn't have to patch this
code every time we add a new one.

> +
> +       if (selinux_state_string_len < 0)
> +               return;

How can this happen legitimately (i.e. as a result of something other
than a kernel bug)?

> +
> +       ++selinux_state_string_len;
> +
> +       selinux_state_string =3D kzalloc(selinux_state_string_len, GFP_KE=
RNEL);
> +       if (!selinux_state_string)
> +               selinux_state_string_len =3D 0;
> +}

Not sure about this error handling approach (silent, proceeding as if
the length was zero and then later failing with ENOMEM on every
attempt?). I'd be more inclined to panic/BUG here but I know Linus
doesn't like that.

> +       if (ret)
> +               pr_err("%s: error %d\n", __func__, ret);

This doesn't seem terribly useful as an error message; I'd be inclined
to drop it.
