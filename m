Return-Path: <linux-integrity+bounces-5469-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC85A73153
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE7C7A2EB7
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A052135D0;
	Thu, 27 Mar 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGbzb3zt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96F2135B4;
	Thu, 27 Mar 2025 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076656; cv=none; b=svJrhBlyo4+PBY6nfIZbZ5OuhNVanWsvR1Wd1960ctdtHDK6cTG0x9wh5jFzkGoUXDPLQGMm8ZCQh5fd7nGxb7vLxL28qraMMbGc58kPsZNVRuQRJ9aSNcII0d1huULGYwom7YNe3wOidNZGxu3ByLRTvwO6R2Z92CzGnHzHZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076656; c=relaxed/simple;
	bh=Y4Xik1GGOFQh/VoyDLCOE93ndDPztNlPuZPrfLzQsrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGB+frLBRfpdc9WaPKAiVMg995R1FXCW537Wy6/e/tLb9Zjm0C6j6w+cKxyHklkj+0A0Q9bRyWlp/Gibm3g98LQFELT54suPO2a1QRWyMI6qae/kpAKVjJIc4oQuUdz1Uwcu15zTLDkrwMLq47h/SJbInEkM39eErlzU0h0SqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGbzb3zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BE1C4CEEB;
	Thu, 27 Mar 2025 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743076655;
	bh=Y4Xik1GGOFQh/VoyDLCOE93ndDPztNlPuZPrfLzQsrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGbzb3zth14xJcYBX74UubLYdf+nSYwH94Y56T0N8/Jnj0moHVyq9QaEtqflDyuNz
	 ATThqgN6MrzjbEunxw/raTLq4aUMJO9ldMTA9wEI8Ug56O2T792RbMdE5Q0JVkXntD
	 SgCk73TTY8yp6+YR9ZsqP6IpaDQMdYm2d8f5+ZvJqk1T3NwALnOL/5YNNLJM4D+aNW
	 aaV2182AKKYIH+1BohcxIHQCU1Izy53t+djZ3azZPHOjMzoV3h24YD5S546h+KheCu
	 7neHLw73NFfaw5uAEv0OdZl+EnL/539B1r1kNGBnId1D08FXmAVwqSPo7XE6+q9Own
	 zriQk+BwOUrqQ==
Date: Thu, 27 Mar 2025 13:57:31 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <Z-U9KxQYA6vj1DZT@kernel.org>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-4-sgarzare@redhat.com>
 <Z-RV7T7Bwt3Auopx@kernel.org>
 <x3nkctmpbwkldm5aawfpqrw3b5lej5kxuxam7gb2w6nhgzy7kr@gd3mfnigyg6q>
 <Z-U8UxEdt9Jit9GA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-U8UxEdt9Jit9GA@kernel.org>

On Thu, Mar 27, 2025 at 01:53:59PM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 27, 2025 at 11:03:07AM +0100, Stefano Garzarella wrote:
> > On Wed, Mar 26, 2025 at 09:30:53PM +0200, Jarkko Sakkinen wrote:
> > > On Mon, Mar 24, 2025 at 11:46:48AM +0100, Stefano Garzarella wrote:
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > 
> > > > Add driver for the vTPM defined by the AMD SVSM spec [1].
> > > > 
> > > > The specification defines a protocol that a SEV-SNP guest OS can use to
> > > > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > > > in the guest context, but at a more privileged level (VMPL0).
> > > > 
> > > > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > > > to verify that the device is actually emulated by the platform and to
> > > > send commands and receive responses.
> > > > 
> > > > The device cannot be hot-plugged/unplugged as it is emulated by the
> > > > platform, so we can use module_platform_driver_probe(). The probe
> > > > function will only check whether in the current runtime configuration,
> > > > SVSM is present and provides a vTPM.
> > > > 
> > > > This device does not support interrupts and sends responses to commands
> > > > synchronously. In order to have .recv() called just after .send() in
> > > > tpm_try_transmit(), the .status() callback returns 0, and both
> > > > .req_complete_mask and .req_complete_val are set to 0.
> > > > 
> > > > [1] "Secure VM Service Module for SEV-SNP Guests"
> > > >     Publication # 58019 Revision: 1.00
> > > > 
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > v4:
> > > > - moved "asm" includes after the "linux" includes [Tom]
> > > > - allocated buffer separately [Tom/Jarkko/Jason]
> > > > v3:
> > > > - removed send_recv() ops and followed the ftpm driver implementing .status,
> > > >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > > > - removed link to the spec because those URLs are unstable [Borislav]
> > > > ---
> > > >  drivers/char/tpm/tpm_svsm.c | 155 ++++++++++++++++++++++++++++++++++++
> > > >  drivers/char/tpm/Kconfig    |  10 +++
> > > >  drivers/char/tpm/Makefile   |   1 +
> > > >  3 files changed, 166 insertions(+)
> > > >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > > > new file mode 100644
> > > > index 000000000000..1281ff265927
> > > > --- /dev/null
> > > > +++ b/drivers/char/tpm/tpm_svsm.c
> > > > @@ -0,0 +1,155 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > > > + *
> > > > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > > > + *
> > > > + * The specification defines a protocol that a SEV-SNP guest OS can use to
> > > > + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > > > + * in the guest context, but at a more privileged level (usually VMPL0).
> > > > + *
> > > > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > > > + *     Publication # 58019 Revision: 1.00
> > > > + */
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/tpm_svsm.h>
> > > > +
> > > > +#include <asm/sev.h>
> > > > +
> > > > +#include "tpm.h"
> > > > +
> > > > +struct tpm_svsm_priv {
> > > > +	void *buffer;
> > > > +	u8 locality;
> > > > +};
> > > > +
> > > > +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> > > > +{
> > > > +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = svsm_vtpm_cmd_request_fill(priv->buffer, priv->locality, buf, len);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/*
> > > > +	 * The SVSM call uses the same buffer for the command and for the
> > > > +	 * response, so after this call, the buffer will contain the response
> > > > +	 * that can be used by .recv() op.
> > > > +	 */
> > > > +	return snp_svsm_vtpm_send_command(priv->buffer);
> > > > +}
> > > > +
> > > > +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > > > +{
> > > > +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > > > +
> > > > +	/*
> > > > +	 * The internal buffer contains the response after we send the command
> > > > +	 * to SVSM.
> > > > +	 */
> > > > +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > > > +}
> > > > +
> > > > +static void tpm_svsm_cancel(struct tpm_chip *chip)
> > > > +{
> > > > +	/* not supported */
> > > > +}
> > > > +
> > > > +static u8 tpm_svsm_status(struct tpm_chip *chip)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static bool tpm_svsm_req_canceled(struct tpm_chip *chip, u8 status)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static struct tpm_class_ops tpm_chip_ops = {
> > > > +	.flags = TPM_OPS_AUTO_STARTUP,
> > > > +	.recv = tpm_svsm_recv,
> > > > +	.send = tpm_svsm_send,
> > > > +	.cancel = tpm_svsm_cancel,
> > > > +	.status = tpm_svsm_status,
> > > > +	.req_complete_mask = 0,
> > > > +	.req_complete_val = 0,
> > > > +	.req_canceled = tpm_svsm_req_canceled,
> > > 
> > > If this was bundled with the patch set, this would short a lot:
> > > 
> > > https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u
> > > 
> > > So maybe for v5? Including this patch does not take send_recv()
> > > out of consideration, it is just smart thing to do in all cases.
> > > 
> > > It would be probably easiest to roll out my patch together with
> > > rest of the patch set.
> > 
> > Yeah, I agree. I'll include it in this series and adapt this patch on top of
> > it.
> 
> Yeah, and you could simplify to goal in the other patch set: it's about
> avoiding double-copy of a buffer.
> 
> It's a totally legit argument that we can measure. So in the end this
> will help out landing that too because it takes away the extra cruft
> and streamlines the goal.

... IMHO there is this unwritten law for upstreaming kernel features
that goes something like "further the goals are from white papers,
closer they are to mainline" ;-)

BR, Jarkkko

