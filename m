Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367B23A8693
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFOQhR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 12:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFOQhQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 12:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 599536162F;
        Tue, 15 Jun 2021 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623774912;
        bh=KPwWGxmpg2+R/ZLS2IDl8iiCzE/7WD8JZk2bGE/QMts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nf0favd4DH8amnrkqvYZtkQsxecrIcgxrLVmUpQZ86PzvVVLINtyJ45MrWRej3GDG
         nAtaJHtv01DWFr6rjxS1G2jWitSV6AknO1SdAd2m0hpE+cNxGOTuUzg22mRf541gBn
         YjUyTpwlMQ6/eQFabXktOQ2tlvOF+15QyrTRQeCazzrEjOvDlHmQq4Kk1yOFqGpE48
         g4la3mowcBBeE6H6XXpUGXgf6RyAJJPM89VpBMmLCqM+TL092qGoy1zgkrdYAfAJZg
         3mJtr78hLntyDieS6N+tUK3Yern2ZiLzShW11po9rlaIvyPB51YoaorKUC7/Wsl7Gw
         VuFEEkKmmUtmg==
Received: by mail-lf1-f42.google.com with SMTP id r5so28066057lfr.5;
        Tue, 15 Jun 2021 09:35:12 -0700 (PDT)
X-Gm-Message-State: AOAM5312RAM0PWsZ1PQ9jyb2xxYvFJtxckMrbFXzwS01YX0UexGAkab1
        bZsnqNiKUdalEDTmMCfiOF6g09yEi6aamHsmAQ==
X-Google-Smtp-Source: ABdhPJzb1scuGBg1iwO9bred1d9KdCKkO1Pyyif8+6ImMU2HmLcKnkChTF+SHSnUN48zXPgPQaZ3dRPFNNA//lNpsiE=
X-Received: by 2002:a50:9345:: with SMTP id n5mr354653eda.289.1623774900181;
 Tue, 15 Jun 2021 09:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <20210221174930.27324-6-nramas@linux.microsoft.com> <CAMuHMdVSuNS4edh-zM0_sbC0i1AAjQ9Y0n_8Mjz=3CALkW4pgg@mail.gmail.com>
 <CAL_JsqJ2x7zbyP3fAacdfHOWjCVjg6XhraV2YkoBJdZ2jXAMEA@mail.gmail.com> <54efb4fce5aac7efbd0b1b3885e9098b1d4ea745.camel@linux.microsoft.com>
In-Reply-To: <54efb4fce5aac7efbd0b1b3885e9098b1d4ea745.camel@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Jun 2021 10:34:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJEucP043eViq0Y1kAeqWNTqP5fLjfjz7+ksYx7QP_V5w@mail.gmail.com>
Message-ID: <CAL_JsqJEucP043eViq0Y1kAeqWNTqP5fLjfjz7+ksYx7QP_V5w@mail.gmail.com>
Subject: Re: [PATCH v19 05/13] of: Add a common kexec FDT setup function
To:     nramas <nramas@linux.microsoft.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com,
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

On Tue, Jun 15, 2021 at 10:13 AM nramas <nramas@linux.microsoft.com> wrote:
>
> On Tue, 2021-06-15 at 08:01 -0600, Rob Herring wrote:
> > On Tue, Jun 15, 2021 at 6:18 AM Geert Uytterhoeven <
> > geert@linux-m68k.org> wrote:
> > >
> > > > +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> > > > +                                  unsigned long
> > > > initrd_load_addr,
> > > > +                                  unsigned long initrd_len,
> > > > +                                  const char *cmdline, size_t
> > > > extra_fdt_size)
> > > > +{
> > > > +       /* Did we boot using an initrd? */
> > > > +       prop = fdt_getprop(fdt, chosen_node, "linux,initrd-
> > > > start", NULL);
> > > > +       if (prop) {
> > > > +               u64 tmp_start, tmp_end, tmp_size;
> > > > +
> > > > +               tmp_start = fdt64_to_cpu(*((const fdt64_t *)
> > > > prop));
> > > > +
> > > > +               prop = fdt_getprop(fdt, chosen_node,
> > > > "linux,initrd-end", NULL);
> > > > +               if (!prop) {
> > > > +                       ret = -EINVAL;
> > > > +                       goto out;
> > > > +               }
> > > > +
> > > > +               tmp_end = fdt64_to_cpu(*((const fdt64_t *)
> > > > prop));
> > >
> > > Some kernel code assumes "linux,initrd-{start,end}" are 64-bit,
> > > other code assumes 32-bit.
> >
> > It can be either. The above code was a merge of arm64 and powerpc
> > both
> > of which use 64-bit and still only runs on those arches. It looks
> > like
> > some powerpc platforms may use 32-bit, but this would have been
> > broken
> > before.
> of_kexec_alloc_and_setup_fdt() is called from elf_64.c (in
> arch/powerpc/kexec) which is for 64-bit powerpc platform only.

64-bit PPC could be writing 32-bit property values. The architecture
size doesn't necessarily matter. And if the values came from the
bootloader, who knows what size it used.

This code is 32-bit powerpc only?:

arch/powerpc/boot/main.c-       /* Tell the kernel initrd address via
device tree */
arch/powerpc/boot/main.c:       setprop_val(chosen,
"linux,initrd-start", (u32)(initrd_addr));
arch/powerpc/boot/main.c-       setprop_val(chosen,
"linux,initrd-end", (u32)(initrd_addr+initrd_size));

Rob
