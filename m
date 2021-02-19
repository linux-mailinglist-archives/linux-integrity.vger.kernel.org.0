Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406EA31FA73
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 15:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhBSORx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 09:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhBSORw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 09:17:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D2AC64E46;
        Fri, 19 Feb 2021 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613744231;
        bh=/+2b2FPgpVlufmh4ou91Mqrxg25dANUoad9GzuPY3QM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hpkdWLkXS4r9zMnMbRgfiAqJUL/KX6NZRfDUz5f24bqhOJAvuNQpG2eR3cqSV4FPP
         X0+GeMRwnTShjEsTP3+zqR1wrAXn1CNjRGFjK1/zI+wJc3UGOX54Pxat+7NKkWxuUS
         Ms2w+MsTo3JMUtRhZll9QYsSTorsSO7MOoT4l6DTGTRc+sYLiO3suZYOmK8ktSRz4i
         9JcuWqm6WZwELL56dxvs54v7F9+UGjNl4nvuy4AlHsgCi18iFryaiBbHaiVK3VuDq1
         xl8uf2dwcNNrgMNtZ5NpC7Z6bNyqdcSZa24H9G5LXRygMG+ZcaDbgvb5Omvc7rUKIY
         Yr4w6lIhJdMAQ==
Received: by mail-ed1-f53.google.com with SMTP id c6so10310845ede.0;
        Fri, 19 Feb 2021 06:17:11 -0800 (PST)
X-Gm-Message-State: AOAM530L6OwA0vnSAU//a6Ie5eEQigsoEdLrARfX6ECwk5NnYyi8IBEn
        km2zkVhTAvLb1Ozkk4/wfXHuDD3NrkAlnwuZvA==
X-Google-Smtp-Source: ABdhPJy5YMi65AggF+97f34pmKOko3c6auf7j3NtKv4xgM4ETK+XS7z2sblhE2YkPD2nLGwZdf6zqpXv2RkL4KtPM0Y=
X-Received: by 2002:aa7:c7c8:: with SMTP id o8mr9390177eds.137.1613744229946;
 Fri, 19 Feb 2021 06:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20210218223305.2044-1-nramas@linux.microsoft.com>
 <c6490f6a126a2f10e3e3445b51ea552a26f896a9.camel@linux.ibm.com>
 <8b8c0b70-c7ab-33f3-b66c-9ea03388497b@linux.microsoft.com>
 <87k0r4yi4s.fsf@manicouagan.localdomain> <3ca0aa87-ca83-8024-4067-c2382a360db9@linux.microsoft.com>
In-Reply-To: <3ca0aa87-ca83-8024-4067-c2382a360db9@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 19 Feb 2021 08:16:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJiRV5xShOgso0PH2pFhv-yozay58i1uGQC0dJCVxkJPA@mail.gmail.com>
Message-ID: <CAL_JsqJiRV5xShOgso0PH2pFhv-yozay58i1uGQC0dJCVxkJPA@mail.gmail.com>
Subject: Re: [PATCH] of: error: 'const struct kimage' has no member named 'arch'
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 18, 2021 at 8:53 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 2/18/21 5:13 PM, Thiago Jung Bauermann wrote:
> >
> > Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> >
> >> On 2/18/21 4:07 PM, Mimi Zohar wrote:
> >>
> >> Hi Mimi,
> >>
> >>> On Thu, 2021-02-18 at 14:33 -0800, Lakshmi Ramasubramanian wrote:
> >>>> of_kexec_alloc_and_setup_fdt() defined in drivers/of/kexec.c builds
> >>>> a new device tree object that includes architecture specific data
> >>>> for kexec system call.  This should be defined only if the architecture
> >>>> being built defines kexec architecture structure "struct kimage_arch".
> >>>>
> >>>> Define a new boolean config OF_KEXEC that is enabled if
> >>>> CONFIG_KEXEC_FILE and CONFIG_OF_FLATTREE are enabled, and
> >>>> the architecture is arm64 or powerpc64.  Build drivers/of/kexec.c
> >>>> if CONFIG_OF_KEXEC is enabled.
> >>>>
> >>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >>>> Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>> ---
> >>>>    drivers/of/Kconfig  | 6 ++++++
> >>>>    drivers/of/Makefile | 7 +------
> >>>>    2 files changed, 7 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> >>>> index 18450437d5d5..f2e8fa54862a 100644
> >>>> --- a/drivers/of/Kconfig
> >>>> +++ b/drivers/of/Kconfig
> >>>> @@ -100,4 +100,10 @@ config OF_DMA_DEFAULT_COHERENT
> >>>>            # arches should select this if DMA is coherent by default for OF devices
> >>>>            bool
> >>>>    +config OF_KEXEC
> >>>> +  bool
> >>>> +  depends on KEXEC_FILE
> >>>> +  depends on OF_FLATTREE
> >>>> +  default y if ARM64 || PPC64
> >>>> +
> >>>>    endif # OF
> >>>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> >>>> index c13b982084a3..287579dd1695 100644
> >>>> --- a/drivers/of/Makefile
> >>>> +++ b/drivers/of/Makefile
> >>>> @@ -13,11 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
> >>>>    obj-$(CONFIG_OF_RESOLVE)  += resolver.o
> >>>>    obj-$(CONFIG_OF_OVERLAY) += overlay.o
> >>>>    obj-$(CONFIG_OF_NUMA) += of_numa.o
> >>>> -
> >>>> -ifdef CONFIG_KEXEC_FILE
> >>>> -ifdef CONFIG_OF_FLATTREE
> >>>> -obj-y     += kexec.o
> >>>> -endif
> >>>> -endif
> >>>> +obj-$(CONFIG_OF_KEXEC) += kexec.o
> >>>>      obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> >>> Is it possible to reuse CONFIG_HAVE_IMA_KEXEC here?
> >>>
> >>
> >> For ppc64 CONFIG_HAVE_IMA_KEXEC is selected when CONFIG_KEXEC_FILE is enabled.
> >> So I don't see a problem in reusing CONFIG_HAVE_IMA_KEXEC for ppc.
> >>
> >> But for arm64, CONFIG_HAVE_IMA_KEXEC is enabled in the final patch in the patch
> >> set (the one for carrying forward IMA log across kexec for arm64). arm64 calls
> >> of_kexec_alloc_and_setup_fdt() prior to enabling CONFIG_HAVE_IMA_KEXEC and hence
> >> breaks the build for arm64.
> >
> > One problem is that I believe that this patch won't placate the robot,
> > because IIUC it generates config files at random and this change still
> > allows hppa and s390 to enable CONFIG_OF_KEXEC.
>
> I enabled CONFIG_OF_KEXEC for s390. With my patch applied,
> CONFIG_OF_KEXEC is removed. So I think the robot enabling this config
> would not be a problem.
>
> >
> > Perhaps a new CONFIG_HAVE_KIMAGE_ARCH option? Not having that option
> > would still allow building kexec.o, but would be used inside kexec.c to
> > avoid accessing kimage.arch members.
> >
>
> I think this is a good idea - a new CONFIG_HAVE_KIMAGE_ARCH, which will
> be selected by arm64 and ppc for now. I tried this, and it fixes the
> build issue.
>
> Although, the name for the new config can be misleading since PARISC,
> for instance, also defines "struct kimage_arch". Perhaps,
> CONFIG_HAVE_ELF_KIMAGE_ARCH since of_kexec_alloc_and_setup_fdt() is
> accessing ELF specific fields in "struct kimage_arch"?
>
> Rob/Mimi - please let us know which approach you think is better.

I'd just move the fields to kimage.

Rob
