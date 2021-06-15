Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FEA3A81A6
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFOOEG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 10:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhFOOEF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 10:04:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E26EF613F5;
        Tue, 15 Jun 2021 14:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623765720;
        bh=QlhAPeeyHHRjIGhNphYkDKi45QaQ5wrJVvOCJ5iwTZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rfpjv29R77uGBM9GpyweyP2mn6gvWGVSvO308lsxC06nt7DZixmwM+/1HVYX+4DvO
         MwqsUg6CAI/HB/Xg8d9KL6y5YnKIidcgnIzNPyvipMP/PsYTIcRbnhBzPcaw2YCruz
         FpiOnjAIoK7dYGKFuOnLSvZLNIqrAij0CEhDgX+m3AS5p/+qihR1rVKVWWeLyltBql
         uMvbNF7+FnpOmXJrx46WF6kAd25Ww7xeSEHEaloHSu4J8x+HdIAxzUliJrATrzXMpn
         +tLzcopXpl+0IFezIjCTDJnBO/1jaBY1A51ZjSAaWbqCl0nZNNACIgo+ElwtZI8t+B
         XbglZB58igmpA==
Received: by mail-wr1-f46.google.com with SMTP id o3so18474052wri.8;
        Tue, 15 Jun 2021 07:02:00 -0700 (PDT)
X-Gm-Message-State: AOAM530YXyJS+tbzk2+fN4hL2sZzcXuVBDugIIQoGoVvuMjQeKBKjYjS
        WZNN/VTLBicVzZqef+rNA3FKXd4nNVsTywbezw==
X-Google-Smtp-Source: ABdhPJxVqI8MHrcAWKd/OVKi4zXYd9o5Ej5sqMSK1SDKoChQIuRHCXHX7nfhLloiCMRd7u65oO394YM97kSgD621jRA=
X-Received: by 2002:a17:906:85d5:: with SMTP id i21mr20560813ejy.360.1623765708507;
 Tue, 15 Jun 2021 07:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210221174930.27324-1-nramas@linux.microsoft.com>
 <20210221174930.27324-6-nramas@linux.microsoft.com> <CAMuHMdVSuNS4edh-zM0_sbC0i1AAjQ9Y0n_8Mjz=3CALkW4pgg@mail.gmail.com>
In-Reply-To: <CAMuHMdVSuNS4edh-zM0_sbC0i1AAjQ9Y0n_8Mjz=3CALkW4pgg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Jun 2021 08:01:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2x7zbyP3fAacdfHOWjCVjg6XhraV2YkoBJdZ2jXAMEA@mail.gmail.com>
Message-ID: <CAL_JsqJ2x7zbyP3fAacdfHOWjCVjg6XhraV2YkoBJdZ2jXAMEA@mail.gmail.com>
Subject: Re: [PATCH v19 05/13] of: Add a common kexec FDT setup function
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
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

On Tue, Jun 15, 2021 at 6:18 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Lakshmi and Rob,
>
> On Sun, Feb 21, 2021 at 6:52 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> > From: Rob Herring <robh@kernel.org>
> >
> > Both arm64 and powerpc do essentially the same FDT /chosen setup for
> > kexec.  The differences are either omissions that arm64 should have
> > or additional properties that will be ignored.  The setup code can be
> > combined and shared by both powerpc and arm64.
> >
> > The differences relative to the arm64 version:
> >  - If /chosen doesn't exist, it will be created (should never happen).
> >  - Any old dtb and initrd reserved memory will be released.
> >  - The new initrd and elfcorehdr are marked reserved.
> >  - "linux,booted-from-kexec" is set.
> >
> > The differences relative to the powerpc version:
> >  - "kaslr-seed" and "rng-seed" may be set.
> >  - "linux,elfcorehdr" is set.
> >  - Any existing "linux,usable-memory-range" is removed.
> >
> > Combine the code for setting up the /chosen node in the FDT and updating
> > the memory reservation for kexec, for powerpc and arm64, in
> > of_kexec_alloc_and_setup_fdt() and move it to "drivers/of/kexec.c".
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>
> > --- /dev/null
> > +++ b/drivers/of/kexec.c
>
> > +/*
> > + * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
> > + *
> > + * @image:             kexec image being loaded.
> > + * @initrd_load_addr:  Address where the next initrd will be loaded.
> > + * @initrd_len:                Size of the next initrd, or 0 if there will be none.
> > + * @cmdline:           Command line for the next kernel, or NULL if there will
> > + *                     be none.
> > + * @extra_fdt_size:    Additional size for the new FDT buffer.
> > + *
> > + * Return: fdt on success, or NULL errno on error.
> > + */
> > +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> > +                                  unsigned long initrd_load_addr,
> > +                                  unsigned long initrd_len,
> > +                                  const char *cmdline, size_t extra_fdt_size)
> > +{
>
> > +       /* Did we boot using an initrd? */
> > +       prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
> > +       if (prop) {
> > +               u64 tmp_start, tmp_end, tmp_size;
> > +
> > +               tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
> > +
> > +               prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
> > +               if (!prop) {
> > +                       ret = -EINVAL;
> > +                       goto out;
> > +               }
> > +
> > +               tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
>
> Some kernel code assumes "linux,initrd-{start,end}" are 64-bit,
> other code assumes 32-bit.

It can be either. The above code was a merge of arm64 and powerpc both
of which use 64-bit and still only runs on those arches. It looks like
some powerpc platforms may use 32-bit, but this would have been broken
before.

The code in drivers/of/fdt.c handles either case. We should probably
refactor early_init_dt_check_for_initrd() and this function to use a
common routine.

> linux/Documentation/arm/uefi.rst says 64-bit,
> dt-schema/schemas/chosen.yaml says 32-bit.

We should fix that.

Rob
