Return-Path: <linux-integrity+bounces-5339-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17180A6A959
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C8B1882061
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3941DED47;
	Thu, 20 Mar 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKK0fLAF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB38175D53;
	Thu, 20 Mar 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482621; cv=none; b=gd4fs037bGMGOUr4uZXYFkKmMQwioe8/rqgDoOjDmLcqF2LAZIZiSath2sKL5EmUZ8C3dGdMYWvNhRCAKAIY/MawVwVV0dvHxKoQgnKvD0y8kT36w6RZwhiBRcZh8o482WJSlCxk1tt+lqj4uXOkxOuU024KRtpSHCsUI6WDvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482621; c=relaxed/simple;
	bh=8WMPvIwTcmodJ0F+KEYR4NnukKC0AnVoSMyBtyzEsDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbJxLk2v/9ooB5pr3Y/yC2pGb3Nr+0d6LeWY02sta9i1M3Z/UglbgomhLlBOYj0wJek5dV5Yu4CExgOuOkcsc2LqOTvQhQFkWYnGk8Hw6zXi0Qay3llNHbZ6JDXLPQ4uQL4zlGPQZBJKAff6Ialk///d4gGsm2Yl46WDdLu+tYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKK0fLAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F25AC4CEDD;
	Thu, 20 Mar 2025 14:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742482620;
	bh=8WMPvIwTcmodJ0F+KEYR4NnukKC0AnVoSMyBtyzEsDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKK0fLAFfnPC6hFkPlaxVRDfEQ1EPY1DgMgAnvpOWsn0e1kaBs3TwHwzJ1G70YfGs
	 MXfF1w24dzZhEpOv/Pym+lAX2hHtjsv/eTD2BkObhpAYVRHEKGsF24uj9vfpvtZ6Rm
	 KK9cR6yeSjkwhaV9vSpkU1ymvEX0X14036mDv3j++XCGbhN45Ut5T2mrNdbYz4uPZ/
	 +k9qGzHindlfrQCWXXnOtxrplcn3mOhEuWIp1YNH+DA2sznHhL6AmIoGCBE72D/CBT
	 aZlvlZUGppN8UyQbS2G9SejcHCpwpKUclpD5WsqbkTqSa9WhjDghhNI0wfR7gPhnEZ
	 HyMa9JbpU5iTA==
Date: Thu, 20 Mar 2025 16:56:56 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <Z9wsuBJPxIhvLN9x@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
 <Z9gm9iWhk5Zs2NvI@kernel.org>
 <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>

On Tue, Mar 18, 2025 at 11:38:54AM +0100, Stefano Garzarella wrote:
> On Mon, Mar 17, 2025 at 03:43:18PM +0200, Jarkko Sakkinen wrote:
> >On Fri, Mar 14, 2025 at 11:48:11AM -0500, Tom Lendacky wrote:
> >> On 3/11/25 04:42, Stefano Garzarella wrote:
> >> > Add driver for the vTPM defined by the AMD SVSM spec [1].
> >> >
> >> > The specification defines a protocol that a SEV-SNP guest OS can use to
> >> > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> >> > in the guest context, but at a more privileged level (VMPL0).
> >> >
> >> > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> >> > to verify that the device is actually emulated by the platform and to
> >> > send commands and receive responses.
> >> >
> >> > The device cannot be hot-plugged/unplugged as it is emulated by the
> >> > platform, so we can use module_platform_driver_probe(). The probe
> >> > function will only check whether in the current runtime configuration,
> >> > SVSM is present and provides a vTPM.
> >> >
> >> > This device does not support interrupts and sends responses to commands
> >> > synchronously. In order to have .recv() called just after .send() in
> >> > tpm_try_transmit(), the .status() callback returns 0, and both
> >> > .req_complete_mask and .req_complete_val are set to 0.
> >> >
> >> > [1] "Secure VM Service Module for SEV-SNP Guests"
> >> >     Publication # 58019 Revision: 1.00
> >> >
> >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > ---
> >> > v3:
> >> > - removed send_recv() ops and followed the ftpm driver implementing .status,
> >> >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> >> > - removed link to the spec because those URLs are unstable [Borislav]
> >> > ---
> >> >  drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
> >> >  drivers/char/tpm/Kconfig    |  10 +++
> >> >  drivers/char/tpm/Makefile   |   1 +
> >> >  3 files changed, 159 insertions(+)
> >> >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> >> >
> >> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> >> > new file mode 100644
> >> > index 000000000000..5540d0227eed
> >> > --- /dev/null
> >> > +++ b/drivers/char/tpm/tpm_svsm.c
> >> > @@ -0,0 +1,148 @@
> >> > +// SPDX-License-Identifier: GPL-2.0-only
> >> > +/*
> >> > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> >> > + *
> >> > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> >> > + *
> >> > + * The specification defines a protocol that a SEV-SNP guest OS can use to
> >> > + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> >> > + * in the guest context, but at a more privileged level (usually VMPL0).
> >> > + *
> >> > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> >> > + *     Publication # 58019 Revision: 1.00
> >> > + */
> >> > +
> >> > +#include <asm/sev.h>
> >>
> >> Typically the "asm" includes are after the "linux" includes and separated
> >> from each other by a blank line.
> 
> Yep, I already fixed it in v4, since I found that issue while
> backporting this patch to CentOS 9.
> 
> >>
> >> > +#include <linux/module.h>
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/platform_device.h>
> >> > +#include <linux/svsm_vtpm.h>
> >> > +
> >> > +#include "tpm.h"
> >> > +
> >> > +struct tpm_svsm_priv {
> >> > +  u8 buffer[SVSM_VTPM_MAX_BUFFER];
> >> > +  u8 locality;
> >> > +};
> >>
> >> I'm wondering if the buffer shouldn't be a pointer to a page of memory
> >> that is a page allocation. This ensures it is always page-aligned in case
> >> the tpm_svsm_priv structure is ever modified.
> 
> @Tom Should that buffer really page aligned?
> 
> I couldn't find anything in the specification. IIRC edk2 also doesn't
> allocate it aligned, and the code in SVSM already handles the case when
> this is not aligned.
> 
> So if it is to be aligned to the pages, we should reinforce it in SVSM
> (spec/code) and also fix edk2.
> 
> Or was yours a suggestion for performance/optimization?
> 
> >>
> >> As it is, the kmalloc() allocation will be page-aligned because of the
> >> size, but it might be safer, dunno, your call.
> >
> >This was good catch. There's actually two issues here:
> >
> >1. SVSM_VTPM_MAX_BUFFER is same as page size.
> >2. SVSM_VTPM_MAX_BUFFER is IMHO defined in wrong patch 2/4.
> 
> I put it in patch 2 because IIUC it should be part of the SVSM
> specification (the size, not the alignment).
> 
> >
> >So this constant would be needed, it should be appeneded in this patch,
> >not in 2/4 because it has direct effect on implementation of the driver.
> >
> >I'd personally support the idea of removing this constant altogether
> >and use alloc_page() (i.e., same as you suggested).
> 
> Do you think it's necessary, even though alignment is not required?
> (I'm still not clear if it's a requirement, see above)

If the question is whether I would NAK based on using kzalloc(). Likely
not but still using page allocator would be more lean :-)

> 
> >
> >kmalloc() does do the "right thing here but it is still extra
> >unnecessary layer of random stuff on top...
> 
> Yes, if it has to be aligned I completely agree. I would like to use
> devm_ functions to keep the driver simple. Do you think
> devm_get_free_pages() might be a good alternative to alloc_page()?

Yes, I think it could be used here.

> 
> Thanks,
> Stefano
> 

BR, Jarkko

