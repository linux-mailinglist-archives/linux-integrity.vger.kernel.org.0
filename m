Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA231A0C2
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 15:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhBLOjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 09:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhBLOjk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 09:39:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20B8B64E89;
        Fri, 12 Feb 2021 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613140739;
        bh=VM/hMIuNki+8AuFH8dta46Xcca/j9vD4S9PCcOVeQsI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FWRqGcPHxzqZvsn0B4Bf/KbzaCWzLCbuk0//h4yHfpml1nv4neMtG5cghJOLTOxMH
         EBfoSPv5L+/rsE3COCTObBf2LEMukyLAmuOc+TArWlww0/eJH1QCul1UCx46GHYC9A
         ygO0hJu9ZKn6RWKOGPy4aNWgzWRoxn69KdYstDfKoa6xs5ahXlgzqxPdf+jZ68nguQ
         5oYPxsmOyxg/1s9ihHwhWnHvryOYlvQJ0CK7BvtE8cP7wOfO6Zyr0bnaw1DUs6Wxie
         Gs5J6TLJQiygY5snl6c2GG/ETwGAVuDglFuMoZ1hIr6PooCRR0uF9usfdP5seblfmM
         wi90akPnC1zFQ==
Received: by mail-ej1-f45.google.com with SMTP id hs11so16053364ejc.1;
        Fri, 12 Feb 2021 06:38:59 -0800 (PST)
X-Gm-Message-State: AOAM530Jt4vu+dcfjxyY08NZNJywZeNM77LBFSbRvWeuceGLj/tnciDq
        EJFUiMPaaVl9cJFCKHGvY0lZKyVx1UMxVaLHOQ==
X-Google-Smtp-Source: ABdhPJyp97cOTRclyGLtgxr1S7Tfbgy5vaTapO/SGIdQUo2xoq5WzhpSlNLNcX2B2eKSVg8aUw9l8VEjxo7SWHZxgkw=
X-Received: by 2002:a17:906:1d44:: with SMTP id o4mr1930426ejh.130.1613140737428;
 Fri, 12 Feb 2021 06:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-3-nramas@linux.microsoft.com> <87k0reozwh.fsf@manicouagan.localdomain>
 <8a3aa3d2-2eba-549a-9970-a2b0fe3586c9@linux.microsoft.com>
In-Reply-To: <8a3aa3d2-2eba-549a-9970-a2b0fe3586c9@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Feb 2021 08:38:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ3sDzjsJXtb6EzE77BL+PhUxDJYUngLTqcm0popd7Ajw@mail.gmail.com>
Message-ID: <CAL_JsqJ3sDzjsJXtb6EzE77BL+PhUxDJYUngLTqcm0popd7Ajw@mail.gmail.com>
Subject: Re: [PATCH v17 02/10] of: Add a common kexec FDT setup function
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        vincenzo.frascino@arm.com, Mark Rutland <mark.rutland@arm.com>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 11, 2021 at 7:17 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 2/11/21 5:09 PM, Thiago Jung Bauermann wrote:
> >
> > There's actually a complication that I just noticed and needs to be
> > addressed. More below.
> >
>
> <...>
>
> >> +
> >> +/*
> >> + * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
> >> + *
> >> + * @image:          kexec image being loaded.
> >> + * @initrd_load_addr:       Address where the next initrd will be loaded.
> >> + * @initrd_len:             Size of the next initrd, or 0 if there will be none.
> >> + * @cmdline:                Command line for the next kernel, or NULL if there will
> >> + *                  be none.
> >> + *
> >> + * Return: fdt on success, or NULL errno on error.
> >> + */
> >> +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> >> +                               unsigned long initrd_load_addr,
> >> +                               unsigned long initrd_len,
> >> +                               const char *cmdline)
> >> +{
> >> +    void *fdt;
> >> +    int ret, chosen_node;
> >> +    const void *prop;
> >> +    unsigned long fdt_size;
> >> +
> >> +    fdt_size = fdt_totalsize(initial_boot_params) +
> >> +               (cmdline ? strlen(cmdline) : 0) +
> >> +               FDT_EXTRA_SPACE;
> >
> > Just adding 4 KB to initial_boot_params won't be enough for crash
> > kernels on ppc64. The current powerpc code doubles the size of
> > initial_boot_params (which is normally larger than 4 KB) and even that
> > isn't enough. A patch was added to powerpc/next today which uses a more
> > precise (but arch-specific) formula:
> >
> > https://lore.kernel.org/linuxppc-dev/161243826811.119001.14083048209224609814.stgit@hbathini/
> >
> > So I believe we need a hook here where architectures can provide their
> > own specific calculation for the size of the fdt. Perhaps a weakly
> > defined function providing a default implementation which an
> > arch-specific file can override (a la arch_kexec_kernel_image_load())?
> >
> > Then the powerpc specific hook would be the kexec_fdt_totalsize_ppc64()
> > function from the patch I linked above.
> >
>
> Do you think it'd better to add "fdt_size" parameter to
> of_kexec_alloc_and_setup_fdt() so that the caller can provide the
> desired FDT buffer size?

Yes, I guess so. But please define the param as extra size, not total
size. The kernel command line size addition can be in the common code.

The above change is also going to conflict, so I think this may have
to wait. Or I'll take the common and arm bits and powerpc can be
converted next cycle (or after the merge window).

Rob
