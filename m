Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810203067A0
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 00:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhA0XPx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 18:15:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhA0XO3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 18:14:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1951460C3D;
        Wed, 27 Jan 2021 23:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611789225;
        bh=OG86KZQjlQK/iphbVSEABQExPs4plghOMLe7bxUvZQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiXR4SPij5BE91XtvMKGChI7asIK50gRj/Z4Lxm/glG9RzkAxpyJspZLwbwys9nps
         tI03uwRMyhgEkIxQcuiaPm3ZgMz4bBEtPlvi3IDzC5wDtZcL2A4lAoqMpt1g+UosSA
         wLTOZ9jePGGUbsufEsqPvQnmsgTqhAr99x2RSYgByv1mkkpm6EkRbk8bv1XdG7HMqN
         lKxGdoLkSbt4X+NuVD6ceY/nb7J2Ff7mFQj2a1j/FnikHzR6RurcOQhNhtq5tlslBa
         gfuiakBGS5QnzkiMepjRh+mx4bTXDq7IRbBz/yUbE4efmesD8ZExJtOZR2bk1CpbeT
         4NEmBQoS+pSdw==
Date:   Wed, 27 Jan 2021 23:13:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 10/10] arm64: Add IMA log information in kimage used
 for kexec
Message-ID: <20210127231334.GB1016@willie-the-truck>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-11-nramas@linux.microsoft.com>
 <20210127165424.GB358@willie-the-truck>
 <dec23eb8-0b27-3227-d1ef-f759338a7f9f@linux.microsoft.com>
 <20210127180230.GA593@willie-the-truck>
 <8a573f84-732a-3591-8751-f7b08edaa01d@linux.microsoft.com>
 <6343ab2eec390ab7582beea04f8006af095850c8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6343ab2eec390ab7582beea04f8006af095850c8.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 01:31:02PM -0500, Mimi Zohar wrote:
> On Wed, 2021-01-27 at 10:24 -0800, Lakshmi Ramasubramanian wrote:
> > On 1/27/21 10:02 AM, Will Deacon wrote:
> > > On Wed, Jan 27, 2021 at 09:56:53AM -0800, Lakshmi Ramasubramanian wrote:
> > >> On 1/27/21 8:54 AM, Will Deacon wrote:
> > >>> On Fri, Jan 15, 2021 at 09:30:17AM -0800, Lakshmi Ramasubramanian wrote:
> > >>>> Address and size of the buffer containing the IMA measurement log need
> > >>>> to be passed from the current kernel to the next kernel on kexec.
> > >>>>
> > >>>> Add address and size fields to "struct kimage_arch" for ARM64 platform
> > >>>> to hold the address and size of the IMA measurement log buffer.
> > >>>>
> > >>>> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC, if CONFIG_IMA
> > >>>> is enabled, to indicate that the IMA measurement log information is
> > >>>> present in the device tree for ARM64.
> > >>>>
> > >>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> > >>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> > >>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > >>>> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > >>>> ---
> > >>>>    arch/arm64/Kconfig             | 1 +
> > >>>>    arch/arm64/include/asm/kexec.h | 5 +++++
> > >>>>    2 files changed, 6 insertions(+)
> > >>>>
> > >>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > >>>> index 1d466addb078..ea7f7fe3dccd 100644
> > >>>> --- a/arch/arm64/Kconfig
> > >>>> +++ b/arch/arm64/Kconfig
> > >>>> @@ -1094,6 +1094,7 @@ config KEXEC
> > >>>>    config KEXEC_FILE
> > >>>>    	bool "kexec file based system call"
> > >>>>    	select KEXEC_CORE
> > >>>> +	select HAVE_IMA_KEXEC if IMA
> > >>>>    	help
> > >>>>    	  This is new version of kexec system call. This system call is
> > >>>>    	  file based and takes file descriptors as system call argument
> > >>>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > >>>> index d24b527e8c00..2bd19ccb6c43 100644
> > >>>> --- a/arch/arm64/include/asm/kexec.h
> > >>>> +++ b/arch/arm64/include/asm/kexec.h
> > >>>> @@ -100,6 +100,11 @@ struct kimage_arch {
> > >>>>    	void *elf_headers;
> > >>>>    	unsigned long elf_headers_mem;
> > >>>>    	unsigned long elf_headers_sz;
> > >>>> +
> > >>>> +#ifdef CONFIG_IMA_KEXEC
> > >>>> +	phys_addr_t ima_buffer_addr;
> > >>>> +	size_t ima_buffer_size;
> > >>>> +#endif
> > >>>
> > >>> Why do these need to be in the arch structure instead of 'struct kimage'?
> > >>>
> > >>
> > >> Currently, only powerpc and, with this patch set, arm64 have support for
> > >> carrying forward IMA measurement list across kexec system call. The above
> > >> fields are used for tracking IMA measurement list.
> > >>
> > >> Do you see a reason to move these fields to "struct kimage"?
> > > 
> > > If they're gated on CONFIG_IMA_KEXEC, then it seems harmless for them to
> > > be added to the shared structure. Or are you saying that there are
> > > architectures which have CONFIG_IMA_KEXEC but do not want these fields?
> > > 
> > 
> > As far as I know, there are no other architectures that define 
> > CONFIG_IMA_KEXEC, but do not use these fields.
> 
> Yes, CONFIG_IMA_KEXEC enables "carrying the IMA measurement list across
> a soft boot".   The only arch that currently carries the IMA
> measurement across kexec is powerpc.

Ok, in which case this sounds like it should be in the shared structure, no?

Will
