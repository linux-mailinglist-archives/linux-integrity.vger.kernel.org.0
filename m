Return-Path: <linux-integrity+bounces-5292-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5DA65183
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 14:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E53A7C30
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA023E22B;
	Mon, 17 Mar 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPzZCMPo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265F8F5E;
	Mon, 17 Mar 2025 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219002; cv=none; b=c4GaHQBVY/wEC2PvcYNBT7LfzTewUavkyWXWAdQtx7PoDY9Pgd7d2TnTljgayaqb+LHE6SCoIyJRz0qIh14tcJ5p1Rt9KUEtYxBXJRqU5k/o/+V5VetcYkxevfI6QYnejU7/GLbHiIQMIGvYhZFBfXlxLjRD91i1NqF3F/4MhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219002; c=relaxed/simple;
	bh=KcLfpDFlHF4CuFkvzWAVtDEGynkNVW0lSPNM2If/EqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJrG5mDJFL+b4q5wrP+NvRAPQ8qLLB12n7FRq15383iSbnyu9ky9gDEqMiIQnrZSH89AC6Rpz0prgMZ7g2b+KitnXiyVihQPpHjOfxDkGk5+ql/5/Br5zyFtsubTVWy0ROV/BBDZLRtQFTpkxl+U7NWsl6YAQDzraHVZ21O4LqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPzZCMPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7114C4CEE3;
	Mon, 17 Mar 2025 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742219002;
	bh=KcLfpDFlHF4CuFkvzWAVtDEGynkNVW0lSPNM2If/EqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPzZCMPoONlouXorORgBcubM0hCBWp9aOaZlINFiQv7j6KhbCGnqxO2sxsbc6iH46
	 iNeKNHJUxRcHchgTpzPyyaC5Bkjx21fYXMPRAAM87t2JI2q+Lkxb3jTvNv38u6W16Y
	 1q/2LMVPbjbt/tT1yg3klvquyGqbVeYNSumrGYiexrtq9KU4LgWogzrWa8hyDHN/H+
	 scda8atE0lAx7Mj3651Rbjru97j3kxoP3BawUXTxkJKpeOC+FWqvfYTMGWDpVCnE2v
	 zUZnhfdK1QfG4v9mchF8yF2WZB1KszYVYQJD93JTIuBFlPgeE5zJB+lw6kkg5cKJiu
	 CQfbgRLfo+aXw==
Date: Mon, 17 Mar 2025 15:43:18 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <Z9gm9iWhk5Zs2NvI@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>

On Fri, Mar 14, 2025 at 11:48:11AM -0500, Tom Lendacky wrote:
> On 3/11/25 04:42, Stefano Garzarella wrote:
> > Add driver for the vTPM defined by the AMD SVSM spec [1].
> > 
> > The specification defines a protocol that a SEV-SNP guest OS can use to
> > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > in the guest context, but at a more privileged level (VMPL0).
> > 
> > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > to verify that the device is actually emulated by the platform and to
> > send commands and receive responses.
> > 
> > The device cannot be hot-plugged/unplugged as it is emulated by the
> > platform, so we can use module_platform_driver_probe(). The probe
> > function will only check whether in the current runtime configuration,
> > SVSM is present and provides a vTPM.
> > 
> > This device does not support interrupts and sends responses to commands
> > synchronously. In order to have .recv() called just after .send() in
> > tpm_try_transmit(), the .status() callback returns 0, and both
> > .req_complete_mask and .req_complete_val are set to 0.
> > 
> > [1] "Secure VM Service Module for SEV-SNP Guests"
> >     Publication # 58019 Revision: 1.00
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3:
> > - removed send_recv() ops and followed the ftpm driver implementing .status,
> >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > - removed link to the spec because those URLs are unstable [Borislav]
> > ---
> >  drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
> >  drivers/char/tpm/Kconfig    |  10 +++
> >  drivers/char/tpm/Makefile   |   1 +
> >  3 files changed, 159 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> > 
> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > new file mode 100644
> > index 000000000000..5540d0227eed
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_svsm.c
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > + *
> > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > + *
> > + * The specification defines a protocol that a SEV-SNP guest OS can use to
> > + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > + * in the guest context, but at a more privileged level (usually VMPL0).
> > + *
> > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > + *     Publication # 58019 Revision: 1.00
> > + */
> > +
> > +#include <asm/sev.h>
> 
> Typically the "asm" includes are after the "linux" includes and separated
> from each other by a blank line.
> 
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/svsm_vtpm.h>
> > +
> > +#include "tpm.h"
> > +
> > +struct tpm_svsm_priv {
> > +	u8 buffer[SVSM_VTPM_MAX_BUFFER];
> > +	u8 locality;
> > +};
> 
> I'm wondering if the buffer shouldn't be a pointer to a page of memory
> that is a page allocation. This ensures it is always page-aligned in case
> the tpm_svsm_priv structure is ever modified.
> 
> As it is, the kmalloc() allocation will be page-aligned because of the
> size, but it might be safer, dunno, your call.

This was good catch. There's actually two issues here:

1. SVSM_VTPM_MAX_BUFFER is same as page size.
2. SVSM_VTPM_MAX_BUFFER is IMHO defined in wrong patch 2/4.

So this constant would be needed, it should be appeneded in this patch,
not in 2/4 because it has direct effect on implementation of the driver.

I'd personally support the idea of removing this constant altogether
and use alloc_page() (i.e., same as you suggested).

kmalloc() does do the "right thing here but it is still extra
unnecessary layer of random stuff on top...

> 
> Thanks,

BR, Jarkko

