Return-Path: <linux-integrity+bounces-6520-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F54AE877A
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 17:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE3A1BC2946
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E026A0A7;
	Wed, 25 Jun 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1rWhMDm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95F26980C;
	Wed, 25 Jun 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864091; cv=none; b=Ke0iAPFIfyWRxAUCK38KoPhULCcMIdFokRJn/f9BbOgxPEBPQn4f+jhLUvB0JUdgWQYqmDC7rBfJYBDVCgloZMedjZYS5BUeri0spzprJjmH0yw1wWq+eJ7vCYRjSp+P2907Tn2KMe30lmJt/lG2G7m1R6BzqxfqtGriJe93baM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864091; c=relaxed/simple;
	bh=2gBptdzqxqqhgORGmH4ar6orPA4C1xLI0BROKOAbAXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvfLHZonMGITqZFhB9kSQ2BJqeHkZaDummr6TS05oaEZcowfQgZ2rMAP+DU7+PZqUnwW5Q8mlPZmpG+KvcI24CXlx17US0/+/tRZTPsAse9PIM1M+wximsSeitBkXuZIiGX8C155YIwQfPyMIU1g7ix+fv92aAkMoxlipP3XnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1rWhMDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D85C4CEEA;
	Wed, 25 Jun 2025 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750864091;
	bh=2gBptdzqxqqhgORGmH4ar6orPA4C1xLI0BROKOAbAXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1rWhMDmtU7pLN+ccNfJuhEK6e5nNYS1fqurneQ5iWjVcl7LJp8AhWo1AbsSBYP/Z
	 alaPl520BQs1yqudvJdaANJeTJlJEoA8VhUE9OLs0irB1mhcbkxDt8O53vJNrVUa6t
	 3VRVyIKCiQyrovz7ApexspI1f3uLTFGYF6fd/p0GaQE/F3Tjm31tzma3OA0uAk0iG1
	 09TOSfa7jDn1DhSt/CrIPICqXqiP02PXTRjanePiTxpMiV2Br7FYAyBRpLJxIfOHaz
	 qAViaEpgY8YGy+I5iQjFyrONfOw7qeZVWzGC8if1BwUyvEAGcR587AC9/7jrDgolhV
	 pHe+0hwHNuz3Q==
Date: Wed, 25 Jun 2025 18:08:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Naveen N Rao <naveen@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH v6 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Message-ID: <aFwQ129i_HYzG3aY@kernel.org>
References: <20250620130810.99069-1-sgarzare@redhat.com>
 <20250620130810.99069-5-sgarzare@redhat.com>
 <aFvlaY0BNjaGxU1D@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvlaY0BNjaGxU1D@kernel.org>

On Wed, Jun 25, 2025 at 03:02:54PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 20, 2025 at 03:08:10PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > This driver does not support interrupts, and receiving the response is
> > synchronous with sending the command.
> > 
> > Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
> > ->send() already fills the provided buffer with a response, and ->recv()
> > is not implemented.
> > 
> > Keep using the same pre-allocated buffer to avoid having to allocate
> > it for each command. We need the buffer to have the header required by
> > the SVSM protocol and the command contiguous in memory.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v5:
> > - changed order and parameter names to match tpm_try_transmit() [Jarkko]
> > v4:
> > - reworked commit description [Jarkko]
> > ---
> >  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
> >  1 file changed, 11 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > index 0847cbf450b4..f5ba0f64850b 100644
> > --- a/drivers/char/tpm/tpm_svsm.c
> > +++ b/drivers/char/tpm/tpm_svsm.c
> > @@ -26,37 +26,31 @@ struct tpm_svsm_priv {
> >  };
> >  
> >  static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> > -			 size_t len)
> > +			 size_t cmd_len)
> >  {
> >  	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> >  	int ret;
> >  
> > -	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
> > +	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, cmd_len);
> >  	if (ret)
> >  		return ret;
> >  
> >  	/*
> >  	 * The SVSM call uses the same buffer for the command and for the
> > -	 * response, so after this call, the buffer will contain the response
> > -	 * that can be used by .recv() op.
> > +	 * response, so after this call, the buffer will contain the response.
> > +	 *
> > +	 * Note: we have to use an internal buffer because the device in SVSM
> > +	 * expects the svsm_vtpm header + data to be physically contiguous.
> >  	 */
> > -	return snp_svsm_vtpm_send_command(priv->buffer);
> > -}
> > -
> > -static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > -{
> > -	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > +	ret = snp_svsm_vtpm_send_command(priv->buffer);
> > +	if (ret)
> > +		return ret;
> >  
> > -	/*
> > -	 * The internal buffer contains the response after we send the command
> > -	 * to SVSM.
> > -	 */
> > -	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
> >  }
> >  
> >  static struct tpm_class_ops tpm_chip_ops = {
> >  	.flags = TPM_OPS_AUTO_STARTUP,
> > -	.recv = tpm_svsm_recv,
> >  	.send = tpm_svsm_send,
> >  };
> >  
> > @@ -85,6 +79,7 @@ static int __init tpm_svsm_probe(struct platform_device *pdev)
> >  
> >  	dev_set_drvdata(&chip->dev, priv);
> >  
> > +	chip->flags |= TPM_CHIP_FLAG_SYNC;
> >  	err = tpm2_probe(chip);
> >  	if (err)
> >  		return err;
> > -- 
> > 2.49.0
> > 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied.

BR, Jarkko

