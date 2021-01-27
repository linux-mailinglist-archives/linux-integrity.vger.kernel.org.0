Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D784306379
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 19:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhA0SoL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 13:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232828AbhA0SoK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 13:44:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B141601FB;
        Wed, 27 Jan 2021 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611773008;
        bh=GZ0Dc/tE/vX/hQMmkRpmanBmWtj6NrDessKfg0CzNQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq9cayECysR7wC0JyvXib4KeHkGCaDldIGwVp3rDHBgGkQ1LymJfYzNCHYTWnOteh
         D/a4R7QdG6BOOOf3X8N/DYX4m5Ylj8hR8GIRpKFTInswxgi9aim5djfTEopswbiYBh
         5cA3sd60j8+bOtwsXdyKysCNG6+ZDeOICgWE8vnTanfwhOSE9JVUDFtyd3gYWECdt5
         uJ23zMZoj7kUW4bL5vIrmLcZeFPgxo+vAXyEmEU1WFwVLyjQQDigv+6af5vmTVauJf
         vhk8QGF8ckom1KSdAuAF9nbs/lM+XOOP1TzBNrf9cDTNKAeVMosfDtKRDoEL8tGPUi
         Tv/6eJXRVeqfg==
Date:   Wed, 27 Jan 2021 18:43:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
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
Subject: Re: [PATCH v15 09/10] arm64: Call kmalloc() to allocate DTB buffer
Message-ID: <20210127184319.GA676@willie-the-truck>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-10-nramas@linux.microsoft.com>
 <20210127165208.GA358@willie-the-truck>
 <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3330793-6054-6e59-b727-44bf8e5653cd@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 09:59:38AM -0800, Lakshmi Ramasubramanian wrote:
> On 1/27/21 8:52 AM, Will Deacon wrote:
> 
> Hi Will,
> 
> > On Fri, Jan 15, 2021 at 09:30:16AM -0800, Lakshmi Ramasubramanian wrote:
> > > create_dtb() function allocates kernel virtual memory for
> > > the device tree blob (DTB).  This is not consistent with other
> > > architectures, such as powerpc, which calls kmalloc() for allocating
> > > memory for the DTB.
> > > 
> > > Call kmalloc() to allocate memory for the DTB, and kfree() to free
> > > the allocated memory.
> > > 
> > > Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> > > Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > ---
> > >   arch/arm64/kernel/machine_kexec_file.c | 12 +++++++-----
> > >   1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> > > index 7de9c47dee7c..51c40143d6fa 100644
> > > --- a/arch/arm64/kernel/machine_kexec_file.c
> > > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > > @@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
> > >   int arch_kimage_file_post_load_cleanup(struct kimage *image)
> > >   {
> > > -	vfree(image->arch.dtb);
> > > +	kfree(image->arch.dtb);
> > >   	image->arch.dtb = NULL;
> > >   	vfree(image->arch.elf_headers);
> > > @@ -59,19 +59,21 @@ static int create_dtb(struct kimage *image,
> > >   			+ cmdline_len + DTB_EXTRA_SPACE;
> > >   	for (;;) {
> > > -		buf = vmalloc(buf_size);
> > > +		buf = kmalloc(buf_size, GFP_KERNEL);
> > 
> > Is there a functional need for this patch? I build the 'dtbs' target just
> > now and sdm845-db845c.dtb is approaching 100K, which feels quite large
> > for kmalloc().
> 
> Changing the allocation from vmalloc() to kmalloc() would help us further
> consolidate the DTB setup code for powerpc and arm64.

Ok, but at the risk of allocation failure. Can powerpc use vmalloc()
instead?

Will
