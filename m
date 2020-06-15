Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917391F95BD
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgFOL5x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOL5w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 07:57:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAF1C061A0E;
        Mon, 15 Jun 2020 04:57:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so12847158otr.12;
        Mon, 15 Jun 2020 04:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0P5cMrSEK9Tm95O2ZpUaePqKfNHRhXx34xpHo5o2b0=;
        b=KKFPDnATCQdpxcvazDRCJ3tBuYdMbW0n+oIVf0fs9pLhg/wgMURu233HP+aFWAS1Ih
         A1OalkKQ+Y1PAIySt0DwvE+F+zfgnD4gos6GJAc/UviDZ5paVOFA/rgLs6vA8u/2+J2V
         kxKkqkiP/WbeaHlLiyBy478xI3B1pE7T1xcF3SrY9blbcToMfQ/SyrU8mk8Vw0DMntRU
         FUbMcvrzcSjKGs7yCoRERxjRd3YXUcOl0fw+WTQ1y8wwVMg+B35eFu9ebYbjT8rnXl9T
         YJvTL48DMeWUD50QkGb0mcKa9Zg2k0WFtH9jUhjSxd7dNJihH4EWyYsNzac4fP58wBgP
         mshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0P5cMrSEK9Tm95O2ZpUaePqKfNHRhXx34xpHo5o2b0=;
        b=R4Df5u3Jma913mtN6DBX2Zr3XKHYGWHCv7K9CRfRDEx1saZO6XsVyPvyNp9G17HauA
         ljql7UUreUNc9IjL/2imAxkwaUm4WFeWXr2B+x6wkxRfmvyvlnCz31qzNAZB43r6LFSG
         ll22QWr4KdrkZUAaR5ze0/WyMMlAOnXBkuSe3rv4d0l0jEp14JsmqcaEXSwuLlquzzJ7
         jg1UeNLepcBthF352Ea3HAJJ+TjUBniuFCu9Api+DxOp9HaBswho7wd4ljUe7m5t4naX
         J046PL4B01Fo+jrVbuseupH5Lj/Miog8B093Z2K7nQYG3nrQIeAJEfsPIj5AOJzwhe5R
         3rAg==
X-Gm-Message-State: AOAM533jpgPRSFirJv+dmAE6uHVnN2TxvfxM7I2DDYdSp4HZCUEhOJPK
        7RF1eUJI9ql1z7lVanqv8h+NUp0QeVcaQMODdoI=
X-Google-Smtp-Source: ABdhPJxBjB4XUMkUcIuWL3AyOjaPgqG1u76xUXLhHBvL4oGeYWeh6wuuDxrN30yOveY+AWpOAJnqzjlcDW8oFHGXqp4=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr20045702otp.89.1592222271339;
 Mon, 15 Jun 2020 04:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200613024130.3356-1-nramas@linux.microsoft.com> <20200613024130.3356-5-nramas@linux.microsoft.com>
In-Reply-To: <20200613024130.3356-5-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 15 Jun 2020 07:57:40 -0400
Message-ID: <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
Subject: Re: [PATCH 4/5] LSM: Define SELinux function to measure security state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 12, 2020 at 10:42 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> SELinux needs to implement the interface function, security_state(), for
> the LSM to gather SELinux data for measuring. Define the security_state()
> function in SELinux.
>
> The security modules should be able to notify the LSM when there is
> a change in the module's data. Define a function namely
> security_state_change() in the LSM that the security modules
> can call to provide the updated data for measurement.
>
> Call security_state_change() function from SELinux to report data
> when SELinux's state is updated.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
> diff --git a/security/security.c b/security/security.c
> index a6e2d1cd95af..e7175db5a093 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -238,6 +238,11 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>         }
>  }
>
> +void security_state_change(char *lsm_name, void *state, int state_len)
> +{
> +       ima_lsm_state(lsm_name, state, state_len);
> +}
> +

What's the benefit of this trivial function instead of just calling
ima_lsm_state() directly?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7e954b555be6..bbc908a1fcd1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7225,6 +7225,47 @@ static __init int selinux_init(void)
>         return 0;
>  }
>
> +static int selinux_security_state(char **lsm_name, void **state,
> +                                 int *state_len)
> +{
> +       int rc = 0;
> +       char *new_state;
> +       static char *security_state_string = "enabled=%d;enforcing=%d";
> +
> +       *lsm_name = kstrdup("selinux", GFP_KERNEL);
> +       if (!*lsm_name)
> +               return -ENOMEM;
> +
> +       new_state = kzalloc(strlen(security_state_string) + 1, GFP_KERNEL);
> +       if (!new_state) {
> +               kfree(*lsm_name);
> +               *lsm_name = NULL;
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> +
> +       *state_len = sprintf(new_state, security_state_string,
> +                            !selinux_disabled(&selinux_state),
> +                            enforcing_enabled(&selinux_state));

I think I mentioned this on a previous version of these patches, but I
would recommend including more than just the enabled and enforcing
states in your measurement.  Other low-hanging fruit would be the
other selinux_state booleans (checkreqprot, initialized,
policycap[0..__POLICYDB_CAPABILITY_MAX]).  Going a bit further one
could take a hash of the loaded policy by using security_read_policy()
and then computing a hash using whatever hash ima prefers over the
returned data,len pair.  You likely also need to think about how to
allow future extensibility of the state in a backward-compatible
manner, so that future additions do not immediately break systems
relying on older measurements.
