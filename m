Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7F31A47F
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 19:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBLSZE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 13:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhBLSZE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 13:25:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97AE464E99;
        Fri, 12 Feb 2021 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613154261;
        bh=i59A6KsNy0tuBkPE86R7oS3fgQDlOUtW1mMckoQBugI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NXKvqHb7A+THftvgjtBzxKYyRmPhlWrhWAUE1s5olkMvcyXKGGTsUbOfZ/Kbq+/Sp
         IJG5euh/BxNwmvojFqLHCbfWwl/eufDrPGlA1sO3o+LM/6rHmoJi77jpQ09sP8oqMU
         C9N4a4tUCFv/uT1NVHbea95+IDU7HK3tWOVFICI6FDKfuSgnqHVRtePViDIhHnWQsR
         oJwo38HOo9JZILJUiayMoRBXl10oEW4BImwzUxAQDfHDhxeWAGhUuAew2Jccvfpm6r
         R5CPg6RWJYG7fQd2KJiupQkfysRO7DOsfVBVvW7jwV7fdJgZ6NtqfhaCy5a3CN48En
         HbQa2a3Z8isuQ==
Received: by mail-ej1-f47.google.com with SMTP id y9so629398ejp.10;
        Fri, 12 Feb 2021 10:24:21 -0800 (PST)
X-Gm-Message-State: AOAM533VFgDrRwAWYdRgPVEnnAmG7tODJUCAkDnfGAh8AWE5P3vt98pz
        2sY2pTn1ZqNnCQVJVPHb8ikqvL8RbeUOCqKx7A==
X-Google-Smtp-Source: ABdhPJyhoggp31g4RDWhw83ePzBTd54yx+b2MhgGQx4aizGlRuZj/as8C2cqI3V6hI+fnA4ZqS7VGuem7Oso5zN7Aec=
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr4076035ejb.525.1613154260106;
 Fri, 12 Feb 2021 10:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210209182200.30606-3-nramas@linux.microsoft.com> <87k0reozwh.fsf@manicouagan.localdomain>
 <8a3aa3d2-2eba-549a-9970-a2b0fe3586c9@linux.microsoft.com>
 <CAL_JsqJ3sDzjsJXtb6EzE77BL+PhUxDJYUngLTqcm0popd7Ajw@mail.gmail.com> <55685b61-dac0-2f24-f74a-939acf74a4f2@linux.microsoft.com>
In-Reply-To: <55685b61-dac0-2f24-f74a-939acf74a4f2@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Feb 2021 12:24:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKDCgtJngxqMCRdC9evEQpHnryEaMvfgYEh0Mcto6dLHA@mail.gmail.com>
Message-ID: <CAL_JsqKDCgtJngxqMCRdC9evEQpHnryEaMvfgYEh0Mcto6dLHA@mail.gmail.com>
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

On Fri, Feb 12, 2021 at 11:19 AM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 2/12/21 6:38 AM, Rob Herring wrote:
> > On Thu, Feb 11, 2021 at 7:17 PM Lakshmi Ramasubramanian
> > <nramas@linux.microsoft.com> wrote:
> >>
> >> On 2/11/21 5:09 PM, Thiago Jung Bauermann wrote:
> >>>
> >>> There's actually a complication that I just noticed and needs to be
> >>> addressed. More below.
> >>>
> >>
> >> <...>
> >>
> >>>> +
> >>>> +/*
> >>>> + * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
> >>>> + *
> >>>> + * @image:          kexec image being loaded.
> >>>> + * @initrd_load_addr:       Address where the next initrd will be loaded.
> >>>> + * @initrd_len:             Size of the next initrd, or 0 if there will be none.
> >>>> + * @cmdline:                Command line for the next kernel, or NULL if there will
> >>>> + *                  be none.
> >>>> + *
> >>>> + * Return: fdt on success, or NULL errno on error.
> >>>> + */
> >>>> +void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> >>>> +                               unsigned long initrd_load_addr,
> >>>> +                               unsigned long initrd_len,
> >>>> +                               const char *cmdline)
> >>>> +{
> >>>> +    void *fdt;
> >>>> +    int ret, chosen_node;
> >>>> +    const void *prop;
> >>>> +    unsigned long fdt_size;
> >>>> +
> >>>> +    fdt_size = fdt_totalsize(initial_boot_params) +
> >>>> +               (cmdline ? strlen(cmdline) : 0) +
> >>>> +               FDT_EXTRA_SPACE;
> >>>
> >>> Just adding 4 KB to initial_boot_params won't be enough for crash
> >>> kernels on ppc64. The current powerpc code doubles the size of
> >>> initial_boot_params (which is normally larger than 4 KB) and even that
> >>> isn't enough. A patch was added to powerpc/next today which uses a more
> >>> precise (but arch-specific) formula:
> >>>
> >>> https://lore.kernel.org/linuxppc-dev/161243826811.119001.14083048209224609814.stgit@hbathini/
> >>>
> >>> So I believe we need a hook here where architectures can provide their
> >>> own specific calculation for the size of the fdt. Perhaps a weakly
> >>> defined function providing a default implementation which an
> >>> arch-specific file can override (a la arch_kexec_kernel_image_load())?
> >>>
> >>> Then the powerpc specific hook would be the kexec_fdt_totalsize_ppc64()
> >>> function from the patch I linked above.
> >>>
> >>
> >> Do you think it'd better to add "fdt_size" parameter to
> >> of_kexec_alloc_and_setup_fdt() so that the caller can provide the
> >> desired FDT buffer size?
> >
> > Yes, I guess so. But please define the param as extra size, not total
> > size. The kernel command line size addition can be in the common code.
>
> Will do. Just to clarify -
>
> The common code will do:
>
> fdt_totalsize(initial_boot_params) + strlen(cmdline) + extra_fdt_size
>
> The caller will pass "extra_fdt_size"
> ARM64 => 4KB
> PPC64 => fdt_totalsize(initial_boot_params) - which will be updated when
> the patch Thiago had referred to is merged.

Yes, I'd leave the 4KB in there by default and arm64 use 0.

Rob
