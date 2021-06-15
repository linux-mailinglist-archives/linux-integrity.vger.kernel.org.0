Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B543A7DFF
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 14:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOMUR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 08:20:17 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:33345 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFOMUQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 08:20:16 -0400
Received: by mail-vs1-f45.google.com with SMTP id j8so4772614vsd.0;
        Tue, 15 Jun 2021 05:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrlwSWatHznx383NLiMm7Z2IuN1e5i6noGzyC8CFebk=;
        b=JXgz3Hk+7sIEaidPVL0SjP1aAxZguujDNAUK4cz9GPtzwTgirq8WWB3HoXQhkSYGkB
         QOd9ExbCf3xlkp/alTx6m9LayVnrDGHGP7L2aI8qPwTYtew+pjUCQRvBwKRR7xL1zfYa
         1Wtj+oFR79fULkbH6/2E6ANthEXHa1a7oeG7D6esCAXgT0MbLjWOPDDVSfeRJTfKAq22
         O/7DZIjIn/1luKveEk2JbOX4/O2YTg1NY+GvBApFTiYiO2oM9SOWjw8FqROIVFW7k/tH
         73EsJW8PpaC88s6oAAcWPw/C0euP014L7eEZjMedipVBhIE2AGzKVtK3Ud1UrewlNoYl
         0f5Q==
X-Gm-Message-State: AOAM530ruPR+f+h2nkXM7AH1VpzbH9kXv46gJ8JtRkrWWNMng0IhbR+6
        HvYvu7P4J1SD26nrRjnH0CVDZOL/18/qbNTBbLM=
X-Google-Smtp-Source: ABdhPJyWLBtsARFbraykVxhSly+mYdsijjLf5u4llpgj1CcBtHFQinLCCrvpCrriX7X558sqTXYumrMOgaLjD7ZGGnM=
X-Received: by 2002:a05:6102:2011:: with SMTP id p17mr4770704vsr.40.1623759490847;
 Tue, 15 Jun 2021 05:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210221174930.27324-1-nramas@linux.microsoft.com> <20210221174930.27324-6-nramas@linux.microsoft.com>
In-Reply-To: <20210221174930.27324-6-nramas@linux.microsoft.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Jun 2021 14:17:59 +0200
Message-ID: <CAMuHMdVSuNS4edh-zM0_sbC0i1AAjQ9Y0n_8Mjz=3CALkW4pgg@mail.gmail.com>
Subject: Re: [PATCH v19 05/13] of: Add a common kexec FDT setup function
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Rob Herring <robh@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, dmitry.kasatkin@gmail.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi and Rob,

On Sun, Feb 21, 2021 at 6:52 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> From: Rob Herring <robh@kernel.org>
>
> Both arm64 and powerpc do essentially the same FDT /chosen setup for
> kexec.  The differences are either omissions that arm64 should have
> or additional properties that will be ignored.  The setup code can be
> combined and shared by both powerpc and arm64.
>
> The differences relative to the arm64 version:
>  - If /chosen doesn't exist, it will be created (should never happen).
>  - Any old dtb and initrd reserved memory will be released.
>  - The new initrd and elfcorehdr are marked reserved.
>  - "linux,booted-from-kexec" is set.
>
> The differences relative to the powerpc version:
>  - "kaslr-seed" and "rng-seed" may be set.
>  - "linux,elfcorehdr" is set.
>  - Any existing "linux,usable-memory-range" is removed.
>
> Combine the code for setting up the /chosen node in the FDT and updating
> the memory reservation for kexec, for powerpc and arm64, in
> of_kexec_alloc_and_setup_fdt() and move it to "drivers/of/kexec.c".
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

> --- /dev/null
> +++ b/drivers/of/kexec.c

> +/*
> + * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
> + *
> + * @image:             kexec image being loaded.
> + * @initrd_load_addr:  Address where the next initrd will be loaded.
> + * @initrd_len:                Size of the next initrd, or 0 if there will be none.
> + * @cmdline:           Command line for the next kernel, or NULL if there will
> + *                     be none.
> + * @extra_fdt_size:    Additional size for the new FDT buffer.
> + *
> + * Return: fdt on success, or NULL errno on error.
> + */
> +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> +                                  unsigned long initrd_load_addr,
> +                                  unsigned long initrd_len,
> +                                  const char *cmdline, size_t extra_fdt_size)
> +{

> +       /* Did we boot using an initrd? */
> +       prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
> +       if (prop) {
> +               u64 tmp_start, tmp_end, tmp_size;
> +
> +               tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
> +
> +               prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
> +               if (!prop) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));

Some kernel code assumes "linux,initrd-{start,end}" are 64-bit,
other code assumes 32-bit.
linux/Documentation/arm/uefi.rst says 64-bit,
dt-schema/schemas/chosen.yaml says 32-bit.

> +
> +               /*
> +                * kexec reserves exact initrd size, while firmware may
> +                * reserve a multiple of PAGE_SIZE, so check for both.
> +                */
> +               tmp_size = tmp_end - tmp_start;
> +               ret = fdt_find_and_del_mem_rsv(fdt, tmp_start, tmp_size);
> +               if (ret == -ENOENT)
> +                       ret = fdt_find_and_del_mem_rsv(fdt, tmp_start,
> +                                                      round_up(tmp_size, PAGE_SIZE));
> +               if (ret == -EINVAL)
> +                       goto out;
> +       }
> +
> +       /* add initrd-* */
> +       if (initrd_load_addr) {
> +               ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_START,
> +                                     initrd_load_addr);
> +               if (ret)
> +                       goto out;
> +
> +               ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_END,
> +                                     initrd_load_addr + initrd_len);
> +               if (ret)
> +                       goto out;
> +
> +               ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
> +               if (ret)
> +                       goto out;
> +
> +       } else {
> +               ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_START);
> +               if (ret && (ret != -FDT_ERR_NOTFOUND))
> +                       goto out;
> +
> +               ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_END);
> +               if (ret && (ret != -FDT_ERR_NOTFOUND))
> +                       goto out;
> +       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
