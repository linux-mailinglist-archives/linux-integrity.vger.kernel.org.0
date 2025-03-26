Return-Path: <linux-integrity+bounces-5452-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF91BA71F2C
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 20:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A185D3A1403
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4DD1F874C;
	Wed, 26 Mar 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZt6GmmD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A018DB19;
	Wed, 26 Mar 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017457; cv=none; b=nExYzr3QvgsxZkXW9DI34o3GvLfSuZlcoiiKhVaVt5IKYO2zYsNK8lYCF9kSyVDde8xtvhaDRF/P0we7ei6rCnaBJdyLLuJuPLtnIdPlq87/PFD01U+dOAomBinJl0uIthIjwlE44nV2IAouEcwb1+ik5iQwIX5EtrcvZDh8jUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017457; c=relaxed/simple;
	bh=VNW9lXc5EBY6l/hTKaknH37wMwRR8HG9Fk0CRpWFm6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUr1H57V3bRpps0ZCFzdSaxaCcATQ48MB+8mwbBsimiG02TSNaCd4rFRz/zCPoFY4mE/b6z59dmtvAePNdZEESz7xESIddjj2Qq4ENYpCqT6nf2zxdfgujllQssmwJpVm4N+/GQ7a4H7+AvCbet+QdpwLC2HB4amFL5uBumlo5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZt6GmmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59107C4CEE2;
	Wed, 26 Mar 2025 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743017456;
	bh=VNW9lXc5EBY6l/hTKaknH37wMwRR8HG9Fk0CRpWFm6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZt6GmmDOCuQ9F4229jQgqaz+emgV9SWecZcZ5wqDPHIbmMZ37G/EpWBgGci/1BmS
	 k2HrQ46NiyTy/bgkpa1FQtjfoLFTNjUCReWl2p2mBIxYVsaT0qv5I7SF1+rux1n5LA
	 hT+z2AHjIv05uy2RYUv/nzJ11lZ2m7yGpPm6vHBWVs97TKyNjIMmVO1pqLb5bc8v4e
	 VUgMcd7x6YIYq1Wa238Jx8sUhJrNl6rcm8hqXBm/vXay47KIW7FBfgaCpqxOfLOazl
	 8njRZ1JCd+mg6L+vG75KBPQQnerg5HR8SVbLiRfxWI3vpJytX585ug+e6qzurfKmww
	 a7h/BwQOtj5xQ==
Date: Wed, 26 Mar 2025 21:30:53 +0200
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
Message-ID: <Z-RV7T7Bwt3Auopx@kernel.org>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324104653.138663-4-sgarzare@redhat.com>

On Mon, Mar 24, 2025 at 11:46:48AM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add driver for the vTPM defined by the AMD SVSM spec [1].
> 
> The specification defines a protocol that a SEV-SNP guest OS can use to
> discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> in the guest context, but at a more privileged level (VMPL0).
> 
> The new tpm-svsm platform driver uses two functions exposed by x86/sev
> to verify that the device is actually emulated by the platform and to
> send commands and receive responses.
> 
> The device cannot be hot-plugged/unplugged as it is emulated by the
> platform, so we can use module_platform_driver_probe(). The probe
> function will only check whether in the current runtime configuration,
> SVSM is present and provides a vTPM.
> 
> This device does not support interrupts and sends responses to commands
> synchronously. In order to have .recv() called just after .send() in
> tpm_try_transmit(), the .status() callback returns 0, and both
> .req_complete_mask and .req_complete_val are set to 0.
> 
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4:
> - moved "asm" includes after the "linux" includes [Tom]
> - allocated buffer separately [Tom/Jarkko/Jason]
> v3:
> - removed send_recv() ops and followed the ftpm driver implementing .status,
>   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> - removed link to the spec because those URLs are unstable [Borislav]
> ---
>  drivers/char/tpm/tpm_svsm.c | 155 ++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/Kconfig    |  10 +++
>  drivers/char/tpm/Makefile   |   1 +
>  3 files changed, 166 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_svsm.c
> 
> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> new file mode 100644
> index 000000000000..1281ff265927
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_svsm.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> + *
> + * Driver for the vTPM defined by the AMD SVSM spec [1].
> + *
> + * The specification defines a protocol that a SEV-SNP guest OS can use to
> + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> + * in the guest context, but at a more privileged level (usually VMPL0).
> + *
> + * [1] "Secure VM Service Module for SEV-SNP Guests"
> + *     Publication # 58019 Revision: 1.00
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/tpm_svsm.h>
> +
> +#include <asm/sev.h>
> +
> +#include "tpm.h"
> +
> +struct tpm_svsm_priv {
> +	void *buffer;
> +	u8 locality;
> +};
> +
> +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> +	int ret;
> +
> +	ret = svsm_vtpm_cmd_request_fill(priv->buffer, priv->locality, buf, len);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The SVSM call uses the same buffer for the command and for the
> +	 * response, so after this call, the buffer will contain the response
> +	 * that can be used by .recv() op.
> +	 */
> +	return snp_svsm_vtpm_send_command(priv->buffer);
> +}
> +
> +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> +
> +	/*
> +	 * The internal buffer contains the response after we send the command
> +	 * to SVSM.
> +	 */
> +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> +}
> +
> +static void tpm_svsm_cancel(struct tpm_chip *chip)
> +{
> +	/* not supported */
> +}
> +
> +static u8 tpm_svsm_status(struct tpm_chip *chip)
> +{
> +	return 0;
> +}
> +
> +static bool tpm_svsm_req_canceled(struct tpm_chip *chip, u8 status)
> +{
> +	return false;
> +}
> +
> +static struct tpm_class_ops tpm_chip_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.recv = tpm_svsm_recv,
> +	.send = tpm_svsm_send,
> +	.cancel = tpm_svsm_cancel,
> +	.status = tpm_svsm_status,
> +	.req_complete_mask = 0,
> +	.req_complete_val = 0,
> +	.req_canceled = tpm_svsm_req_canceled,

If this was bundled with the patch set, this would short a lot:

https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u

So maybe for v5? Including this patch does not take send_recv()
out of consideration, it is just smart thing to do in all cases.

It would be probably easiest to roll out my patch together with
rest of the patch set.

BR, Jarkko

