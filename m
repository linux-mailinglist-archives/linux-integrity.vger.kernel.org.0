Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAD27D472
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 19:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgI2R0u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2R0u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 13:26:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B3C061755;
        Tue, 29 Sep 2020 10:26:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so4674334ljp.13;
        Tue, 29 Sep 2020 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhk3MbInaaF/6croUvi+/zraDixQnx7wCrXOslWTtys=;
        b=n4MkOq3UvJP9m0yc5Rtex4KtclxrWnItxqOpn6tZJzlS3ahY9sxrZ99wx/IIjkLyvA
         K0GqFxQHjcFt79Rjzd/Zm9P8+hgfC0QYVVFBS3iB5TCojtSzbQJOyd0rGk4g2xAykhL1
         Mpwh64dBzCzV9r1Za8avYcsDcrmErdyZmkPZ9kEoUIO8LDElIUZB0ATuZbnGDNr+fYQS
         fMRGTlsGFAmcXPGzIlYRJpjM9y6G5KnSBPq844V0njnx82hXnbevNRGQZz0ZkAWsenvR
         bKCofziWQTxGJfxBozUMNCYve9GC3OKOVWJ2cqK5v8FXJ+cKBVDwL7pzd68pvgwRMTG2
         wnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhk3MbInaaF/6croUvi+/zraDixQnx7wCrXOslWTtys=;
        b=WfRKpf+xKr1jnku10q+LWizcTjobYgzqxwg/MsSTHoORCKk8U4zB7RTf4RSA17I1mC
         6j907yyP/WpxcHxSU4oDDKJxMGaOhWSZAdbXQMlXOKr03tBVdm87wT7UDrwpQNpBrhgg
         XN+QUXfiwFPiHupYV1lQoxDSPwar+sqKD29xFAzkz0VYIoACQC9f5lbcZUlU4S1RMH/w
         NMIsQ0jOvMDfN0Tp75Ei02S4lft5jjHJI67km4uinwl4uhL4iqXtss58V0PQWRaHVSS7
         aJaUBcxh0Af83tHbS/+Y41C/MaT9GUWyN9Npb5SFdpVekU/bPFMvZIqDrignIfeITfWO
         sKcQ==
X-Gm-Message-State: AOAM533e6CaU0nhZ/epOu1jmf6pUGOji4zQrTtOK2XQig8Ln9l2iknLI
        FG4Igp8uYV8x0FEHqyLnasICk9Q7fz6lHn9Owgg=
X-Google-Smtp-Source: ABdhPJwxqnsM76aGzSU8gOeBJXlMS/Kp47YaHZhDo+51LyfyeEh9/7V3IF/bZW3wgT6Vd6jz1IR+rbVD/zCvPQOIjpY=
X-Received: by 2002:a2e:8988:: with SMTP id c8mr1422707lji.433.1601400406761;
 Tue, 29 Sep 2020 10:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com> <1600959521-24158-4-git-send-email-ross.philipson@oracle.com>
In-Reply-To: <1600959521-24158-4-git-send-email-ross.philipson@oracle.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Tue, 29 Sep 2020 13:26:34 -0400
Message-ID: <CAKf6xpt=G_SJTGikXpQ36pfpSfXQZf0Upn9qTkf-F+mrY2SRDA@mail.gmail.com>
Subject: Re: [PATCH 03/13] x86: Add early SHA support for Secure Launch early measurements
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     open list <linux-kernel@vger.kernel.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Daniel Smith <dpsmith@apertussolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 24, 2020 at 11:00 AM Ross Philipson
<ross.philipson@oracle.com> wrote:
>
> The SHA algorithms are necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
>
> The SHA code here has its origins in the code from the main kernel. That
> code could not be pulled directly into the setup portion of the compressed
> kernel because of other dependencies it pulls in. The result is this is a
> modified copy of that code that still leverages the core SHA algorithms.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/boot/compressed/Makefile       |   4 +
>  arch/x86/boot/compressed/early_sha1.c   | 104 ++++++++++++++++
>  arch/x86/boot/compressed/early_sha1.h   |  17 +++
>  arch/x86/boot/compressed/early_sha256.c |   6 +
>  arch/x86/boot/compressed/early_sha512.c |   6 +
>  include/linux/sha512.h                  |  21 ++++
>  lib/sha1.c                              |   4 +
>  lib/sha512.c                            | 209 ++++++++++++++++++++++++++++++++
>  8 files changed, 371 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/early_sha1.c
>  create mode 100644 arch/x86/boot/compressed/early_sha1.h
>  create mode 100644 arch/x86/boot/compressed/early_sha256.c
>  create mode 100644 arch/x86/boot/compressed/early_sha512.c
>  create mode 100644 include/linux/sha512.h
>  create mode 100644 lib/sha512.c
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index ff7894f..0fd84b9 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -96,6 +96,10 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA256) += $(obj)/early_sha256.o
> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA512) += $(obj)/early_sha512.o
> +
>  # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
>  # can place it anywhere in memory and it will still run. However, since
>  # it is executed as-is without any ELF relocation processing performed
> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
> new file mode 100644
> index 0000000..198c46d
> --- /dev/null
> +++ b/arch/x86/boot/compressed/early_sha1.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + * Copyright (c) 2020 Apertus Solutions, LLC.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/string.h>
> +#include <asm/boot.h>
> +#include <asm/unaligned.h>
> +
> +#include "early_sha1.h"
> +
> +#define SHA1_DISABLE_EXPORT
> +#include "../../../../lib/sha1.c"
> +
> +/* The SHA1 implementation in lib/sha1.c was written to get the workspace
> + * buffer as a parameter. This wrapper function provides a container
> + * around a temporary workspace that is cleared after the transform completes.
> + */
> +static void __sha_transform(u32 *digest, const char *data)
> +{
> +       u32 ws[SHA1_WORKSPACE_WORDS];
> +
> +       sha1_transform(digest, data, ws);
> +
> +       memset(ws, 0, sizeof(ws));
> +       /*
> +        * As this is cryptographic code, prevent the memset 0 from being
> +        * optimized out potentially leaving secrets in memory.
> +        */
> +       wmb();

You can use memzero_explicit instead of open coding it.

Regards,
Jason
