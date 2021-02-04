Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9693100CD
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Feb 2021 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhBDXhR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 18:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhBDXhL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 18:37:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61CA464FA8;
        Thu,  4 Feb 2021 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612481789;
        bh=7OrFkXLdbalgz/5cOchaHpPT+jU0NC7Afg58VcdimLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YPPg5EW6JOGrAT/q879L8vMHpxyT4uq+HoPwYvl6aYLvdimUUOvA5QdePEHRQTFdH
         iYfZkMeDy3zy9OQyNvg+AR+tPjBv17eIYlyggyCFQdC5pTZDND8Q2kuiCBRqF4gGyZ
         /Cf9dw/uvuv9WPsJuPPrKot1KCtQdLZQn6b10t4VnHSkrSBokfTGY5JRY4MoWrqlmA
         Ovcug+2UnEXOUf7f0/3+vE2XwiTeHSAeF8yQuJRPCNiC4RIY9XjsqfgVfwX0GbgGvs
         NxNgO4+8h91dtOrMjLiXvdiuEBUnnf7ykZqeKMCnebJH7WvyOSX6i3hYNfxlGrW9xE
         albP0Hyrl/xKQ==
Received: by mail-ed1-f50.google.com with SMTP id q2so6538717edi.4;
        Thu, 04 Feb 2021 15:36:29 -0800 (PST)
X-Gm-Message-State: AOAM53128uYzQRjiyPKfi4KTWnjXQY3fK0Ok1U8ULv+nWQbuL1QZxuSE
        DKn04kA7d9/8CkiuOXnUivza5gD/2bKXXTbnNQ==
X-Google-Smtp-Source: ABdhPJzWK8wJn36hLSpK9iOpXVcox6WUtcY6/t/Jy1iBcWMJ3SJzMDymbX5SVz2+/MxNKxrxQkf7IBA2h30D8+lykeQ=
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr1339104ejb.525.1612481787108;
 Thu, 04 Feb 2021 15:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20210204164135.29856-1-nramas@linux.microsoft.com>
 <20210204164135.29856-12-nramas@linux.microsoft.com> <CAL_JsqK1Pb9nAeL84EP2U3MQgpBsm+E_0QXmzbigWXnS245WPQ@mail.gmail.com>
 <503d42ba-89bf-4ad9-9d4c-acb625580f77@linux.microsoft.com>
In-Reply-To: <503d42ba-89bf-4ad9-9d4c-acb625580f77@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Feb 2021 17:36:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKY9fxOowW=sBVm9s8j=3RWA7Jn9Ft9Edyx5qy5Yvykmw@mail.gmail.com>
Message-ID: <CAL_JsqKY9fxOowW=sBVm9s8j=3RWA7Jn9Ft9Edyx5qy5Yvykmw@mail.gmail.com>
Subject: Re: [PATCH v16 11/12] powerpc: Use OF alloc and free for FDT
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
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
        Bhupesh Sharma <bhsharma@redhat.com>,
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

On Thu, Feb 4, 2021 at 5:23 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 2/4/21 11:26 AM, Rob Herring wrote:
> > On Thu, Feb 4, 2021 at 10:42 AM Lakshmi Ramasubramanian
> > <nramas@linux.microsoft.com> wrote:
> >>
> >> of_alloc_and_init_fdt() and of_free_fdt() have been defined in
> >> drivers/of/kexec.c to allocate and free memory for FDT.
> >>
> >> Use of_alloc_and_init_fdt() and of_free_fdt() to allocate and
> >> initialize the FDT, and to free the FDT respectively.
> >>
> >> powerpc sets the FDT address in image_loader_data field in
> >> "struct kimage" and the memory is freed in
> >> kimage_file_post_load_cleanup().  This cleanup function uses kfree()
> >> to free the memory. But since of_alloc_and_init_fdt() uses kvmalloc()
> >> for allocation, the buffer needs to be freed using kvfree().
> >
> > You could just change the kexec core to call kvfree() instead.
>
> >
> >> Define "fdt" field in "struct kimage_arch" for powerpc to store
> >> the address of FDT, and free the memory in powerpc specific
> >> arch_kimage_file_post_load_cleanup().
> >
> > However, given all the other buffers have an explicit field in kimage
> > or kimage_arch, changing powerpc is to match arm64 is better IMO.
>
> Just to be clear:
> I'll leave this as is - free FDT buffer in powerpc's
> arch_kimage_file_post_load_cleanup() to match arm64 behavior.

Yes.

> Will not change "kexec core" to call kvfree() - doing that change would
> require changing all architectures to use kvmalloc() for
> image_loader_data allocation.

Actually, no. AIUI, kvfree() can be used whether you used kvmalloc,
vmalloc, or kmalloc for the alloc.

> >> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >> Suggested-by: Rob Herring <robh@kernel.org>
> >> Suggested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> ---
> >>   arch/powerpc/include/asm/kexec.h  |  2 ++
> >>   arch/powerpc/kexec/elf_64.c       | 26 ++++++++++++++++----------
> >>   arch/powerpc/kexec/file_load_64.c |  3 +++
> >>   3 files changed, 21 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> >> index 2c0be93d239a..d7d13cac4d31 100644
> >> --- a/arch/powerpc/include/asm/kexec.h
> >> +++ b/arch/powerpc/include/asm/kexec.h
> >> @@ -111,6 +111,8 @@ struct kimage_arch {
> >>          unsigned long elf_headers_mem;
> >>          unsigned long elf_headers_sz;
> >>          void *elf_headers;
> >> +
> >> +       void *fdt;
> >>   };
> >>
> >>   char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> >> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> >> index d0e459bb2f05..51d2d8eb6c1b 100644
> >> --- a/arch/powerpc/kexec/elf_64.c
> >> +++ b/arch/powerpc/kexec/elf_64.c
> >> @@ -19,6 +19,7 @@
> >>   #include <linux/kexec.h>
> >>   #include <linux/libfdt.h>
> >>   #include <linux/module.h>
> >> +#include <linux/of.h>
> >>   #include <linux/of_fdt.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/types.h>
> >> @@ -32,7 +33,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
> >>          unsigned int fdt_size;
> >>          unsigned long kernel_load_addr;
> >>          unsigned long initrd_load_addr = 0, fdt_load_addr;
> >> -       void *fdt;
> >> +       void *fdt = NULL;
> >>          const void *slave_code;
> >>          struct elfhdr ehdr;
> >>          char *modified_cmdline = NULL;
> >> @@ -103,18 +104,12 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
> >>          }
> >>
> >>          fdt_size = fdt_totalsize(initial_boot_params) * 2;
> >> -       fdt = kmalloc(fdt_size, GFP_KERNEL);
> >> +       fdt = of_alloc_and_init_fdt(fdt_size);
> >>          if (!fdt) {
> >>                  pr_err("Not enough memory for the device tree.\n");
> >>                  ret = -ENOMEM;
> >>                  goto out;
> >>          }
> >> -       ret = fdt_open_into(initial_boot_params, fdt, fdt_size);
> >> -       if (ret < 0) {
> >> -               pr_err("Error setting up the new device tree.\n");
> >> -               ret = -EINVAL;
> >> -               goto out;
> >> -       }
> >>
> >>          ret = setup_new_fdt_ppc64(image, fdt, initrd_load_addr,
> >
> > The first thing this function does is call setup_new_fdt() which first
> > calls of_kexec_setup_new_fdt(). (Note, I really don't understand the
> > PPC code split. It looks like there's a 32-bit and 64-bit split, but
> > 32-bit looks broken to me. Nothing ever calls setup_new_fdt() except
> > setup_new_fdt_ppc64()). The arm64 version is calling
> > of_alloc_and_init_fdt() and then of_kexec_setup_new_fdt() directly.
> >
> > So we can just make of_alloc_and_init_fdt() also call
> > of_kexec_setup_new_fdt() (really, just tweak of_kexec_setup_new_fdt do
> > the alloc and copy).
> ok - will move fdt allocation into of_kexec_setup_new_fdt().
>
> I don't think the architecture needs to pick the
> > size either. It's doubtful that either one is that sensitive to the
> > amount of extra space.
> I am not clear about the above comment -
> are you saying the architectures don't need to pass FDT size to the
> alloc function?
>
> arm64 is adding command line string length and some extra space to the
> size computed from initial_boot_params for FDT Size:
>
>         buf_size = fdt_totalsize(initial_boot_params)
>                         + cmdline_len + DTB_EXTRA_SPACE;
>
> powerpc is just using twice the size computed from initial_boot_params
>
>         fdt_size = fdt_totalsize(initial_boot_params) * 2;
>
> I think it would be safe to let arm64 and powerpc pass the required FDT
> size, along with the other params to of_kexec_setup_new_fdt() - and in
> this function we allocate FDT and set it up.

It's pretty clear that someone just picked something that 'should be
enough'. The only thing I can guess for the difference is that arm
DT's tend to be a bit larger. So doubling the size would be even more
excessive. Either way, we're talking 10s kB to few 100kB. I'd go with
DTB_EXTRA_SPACE and we can bump it up if someone has problems.

Also, I would like for 'initial_boot_params' to be private ultimately,
so removing any references is helpful.

> And, for powerpc leave the remaining code in setup_new_fdt_ppc64().

Right.

Rob
