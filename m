Return-Path: <linux-integrity+bounces-5539-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F5A77E2D
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Apr 2025 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809933ADC3C
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Apr 2025 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0512054FF;
	Tue,  1 Apr 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azwhk30s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0992054E9;
	Tue,  1 Apr 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518911; cv=none; b=TKjgauL8Rg539dAucTOZyRiOR2z+9E4hNlWz9iuiHxF5zVt21SHPPtrXJr9q9jqZOYlv0xOm4MZkgtc6GLyH3Q78yrqHcBwtZrvV3NPhq240RNJo//8lMHu7uhBFmsNDbNfiibgVrosrzl6/lqUxdXyMUtBdU6kv3W64CHdXDGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518911; c=relaxed/simple;
	bh=ovuHyCNZ5pYCTecY/TRJO813kVc7yQWXtMoCFCqHpZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGMABGfMPwgiHYSHK87NhqfzJnIP9yXrw5Qi3HXgCZVlGtmAEY5A1ocT/1EMk1TXrAgodZAKtMdm2Jq/kL6NGkrWwXGsZNu+6KxxKh2zw4cr5ioLzwG2nHm9KzUsUCUejt843/dAeULjfisrsxJx0I6w0f1tRzfs6L/2Z8aIqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azwhk30s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB585C4CEE8;
	Tue,  1 Apr 2025 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743518910;
	bh=ovuHyCNZ5pYCTecY/TRJO813kVc7yQWXtMoCFCqHpZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Azwhk30suSFQ0KUGLMfweF1TaqgDnCAedCLeqEQfXm8qQx/T8QVqa/PAJo45zpYdX
	 9FAbCHDMmxUp9NzPNnoC3byz2JeqdzUpHR/V2v8XQJbc/7PeHvF3EunLbKG/HW7bMZ
	 OxUZ2FHRLfeWnyspMlck28gPlsUqhDewaaZQUMmtLAIw5p0ZjMwa+bwxHPlMvy6cxo
	 CgDjqyCIfCs9BfeF3gowweMmFpGLlJk3fzWv5+yM5GUya7OrNuYL3g5L4FcOo6yCcv
	 ojsEwd2fvaH2xYJwClzO06DQPTWslYN9RNkl8755LgUFmh/rORgnH52Mt40Teio4ZJ
	 YQZmA0JBecUOQ==
Date: Tue, 1 Apr 2025 17:48:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	linux-coco@lists.linux.dev, Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
	Dionna Glaze <dionnaglaze@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <Z-v8ucw5LVhQTPjl@kernel.org>
References: <20250331103900.92701-1-sgarzare@redhat.com>
 <20250331103900.92701-4-sgarzare@redhat.com>
 <Z-rSMi2uCvShLbLS@kernel.org>
 <lzcasqfgrdoicwqnvecqppy4ikhcv7rqxc6huvlzyltvb6cgdj@wclvoes5g4yq>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lzcasqfgrdoicwqnvecqppy4ikhcv7rqxc6huvlzyltvb6cgdj@wclvoes5g4yq>

On Tue, Apr 01, 2025 at 11:08:49AM +0200, Stefano Garzarella wrote:
> On Mon, Mar 31, 2025 at 08:34:42PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Mar 31, 2025 at 12:38:56PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > Add driver for the vTPM defined by the AMD SVSM spec [1].
> > > 
> > > The specification defines a protocol that a SEV-SNP guest OS can use to
> > > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > > in the guest context, but at a more privileged level (VMPL0).
> > > 
> > > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > > to verify that the device is actually emulated by the platform and to
> > > send commands and receive responses.
> > > 
> > > The device cannot be hot-plugged/unplugged as it is emulated by the
> > > platform, so we can use module_platform_driver_probe(). The probe
> > > function will only check whether in the current runtime configuration,
> > > SVSM is present and provides a vTPM.
> > > 
> > > This device does not support interrupts and sends responses to commands
> > > synchronously. In order to have .recv() called just after .send() in
> > > tpm_try_transmit(), the .status() callback returns 0, and both
> > > .req_complete_mask and .req_complete_val are set to 0.
> > > 
> > > [1] "Secure VM Service Module for SEV-SNP Guests"
> > >     Publication # 58019 Revision: 1.00
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v5:
> > > - removed cancel/status/req_* ops after rebase on master that cotains
> > >   commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
> > > v4:
> > > - moved "asm" includes after the "linux" includes [Tom]
> > > - allocated buffer separately [Tom/Jarkko/Jason]
> > > v3:
> > > - removed send_recv() ops and followed the ftpm driver implementing .status,
> > >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > > - removed link to the spec because those URLs are unstable [Borislav]
> > > ---
> > >  drivers/char/tpm/tpm_svsm.c | 135 ++++++++++++++++++++++++++++++++++++
> > >  drivers/char/tpm/Kconfig    |  10 +++
> > >  drivers/char/tpm/Makefile   |   1 +
> > >  3 files changed, 146 insertions(+)
> > >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> > > 
> > > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > > new file mode 100644
> > > index 000000000000..04c532421ff2
> > > --- /dev/null
> > > +++ b/drivers/char/tpm/tpm_svsm.c
> > > @@ -0,0 +1,135 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > > + *
> > > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > > + *
> > > + * The specification defines a protocol that a SEV-SNP guest OS can use to
> > > + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > > + * in the guest context, but at a more privileged level (usually VMPL0).
> > > + *
> > > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > > + *     Publication # 58019 Revision: 1.00
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/tpm_svsm.h>
> > > +
> > > +#include <asm/sev.h>
> > > +
> > > +#include "tpm.h"
> > > +
> > > +struct tpm_svsm_priv {
> > > +	void *buffer;
> > > +	u8 locality;
> > > +};
> > > +
> > > +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> > > +{
> > > +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > > +	int ret;
> > > +
> > > +	ret = svsm_vtpm_cmd_request_fill(priv->buffer, priv->locality, buf, len);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * The SVSM call uses the same buffer for the command and for the
> > > +	 * response, so after this call, the buffer will contain the response
> > > +	 * that can be used by .recv() op.
> > > +	 */
> > > +	return snp_svsm_vtpm_send_command(priv->buffer);
> > > +}
> > > +
> > > +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > > +{
> > > +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > > +
> > > +	/*
> > > +	 * The internal buffer contains the response after we send the command
> > > +	 * to SVSM.
> > > +	 */
> > > +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > > +}
> > > +
> > > +static struct tpm_class_ops tpm_chip_ops = {
> > > +	.flags = TPM_OPS_AUTO_STARTUP,
> > > +	.recv = tpm_svsm_recv,
> > > +	.send = tpm_svsm_send,
> > > +};
> > > +
> > > +static int __init tpm_svsm_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct tpm_svsm_priv *priv;
> > > +	struct tpm_chip *chip;
> > > +	int err;
> > > +
> > > +	if (!snp_svsm_vtpm_probe())
> > > +		return -ENODEV;
> > > +
> > > +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	/*
> > > +	 * The maximum buffer supported is one page (see SVSM_VTPM_MAX_BUFFER
> > > +	 * in tpm_svsm.h).
> > > +	 */
> > > +	priv->buffer = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
> > > +	if (!priv->buffer)
> > > +		return -ENOMEM;
> > > +
> > > +	/*
> > > +	 * FIXME: before implementing locality we need to agree what it means
> > > +	 * for the SNP SVSM vTPM
> > > +	 */
> > > +	priv->locality = 0;
> > 
> > I don't think we want FIXME's to mainline. Instead, don't declare the
> > field at all if you don't use it. Just pass zero to *_request_fill().
> > 
> > Maybe "not have the field" is even a better reminder than a random fixme
> > comment?
> 
> Yeah, I had thought the same, but then I left it that way because it was
> there from the first RFC and I saw several FIXME in the codebase, but I
> agree with you, I'll remove the field completely in v6.
> 
> That said, `struct tpm_svsm_priv` with this change will only contain the
> pointer to the buffer, does it make sense to have that structure (maybe for
> the future it's easier to add new fields), or do I remove it and use
> dev_set_drvdata() to store the pointer to the buffer directly?

I'll put it like this: I would not NAK this for having a struct with
a single field. Either way works for me. 

> 
> Thanks,
> Stefano
> 

BR, Jarkko

