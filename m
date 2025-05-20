Return-Path: <linux-integrity+bounces-6262-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66EDABE46B
	for <lists+linux-integrity@lfdr.de>; Tue, 20 May 2025 22:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4031BC3F3D
	for <lists+linux-integrity@lfdr.de>; Tue, 20 May 2025 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054528A73D;
	Tue, 20 May 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLhb1sSF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA728A72E;
	Tue, 20 May 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771373; cv=none; b=NESBOY/2sHOi56MfdhuQSFWrYJS/LXDkejjCH2EClHLyRes6Gk3QiQqdo0yR1SOs7Po0coCmAD8e4aog2KcWQnrTqKBOWD1QrKk68nKSWXXSv4CTDBkiVffbziKkCYkwsZ9s+OW7wyNEjopozzkbZ64aZq6Ywb5cdFbyjTVBjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771373; c=relaxed/simple;
	bh=ipb1eCljeIm2r5OkPhtSsa9n7gXb96lo1YYOTFP6ZPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGQBPm2HTv0rFEGY8GFlmHjbb+iIsFwSKlz+RvMohBKE8tSgoGBEXPZY92V5ib4J4LFMmYcFMAHh+xhOH2VH/zog4tJ4z10zNzXOVC+VR4+BW5KGtSpw/7kVgUWbjE4l6neuDNKxJY+edlTkn4ybVALGC8mY4cLnmNRU2B9CgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLhb1sSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C612C4CEE9;
	Tue, 20 May 2025 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747771373;
	bh=ipb1eCljeIm2r5OkPhtSsa9n7gXb96lo1YYOTFP6ZPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLhb1sSFzls6z4ybonOCIe75fqv5xXE/hup5qinNdeuHoGd8MuPuOzlXXBO9wl/8f
	 Hh/5LQiTqGwYS7l+HT2NlPKflmOHvkwjZ0E0l5Od8hav8x2u5jTo3wpcu7ms4/xc8Y
	 rrirDQSHOhDouqRY0ThHP5RPBaQ99RqtIViakrmmw02J0NkyR08Sqgl9x/m34+E38W
	 ZtLIDsqOJnIEBm9GODFUfpIF0vIBoM6iZNmT7UjcN56ul0EMvOWaMJMq97TVUMWCgO
	 0AQBNZE275z5UeHLQoyyLzjlXlZvZnkzB+CbngW8H3F5wxFd4Ym1OcUtaqnMUqD9nA
	 ZQO3bRsWqj1Uw==
Date: Tue, 20 May 2025 23:02:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-integrity@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Message-ID: <aCzf6aoJAC-IdS_n@kernel.org>
References: <20250514134630.137621-1-sgarzare@redhat.com>
 <20250514134630.137621-5-sgarzare@redhat.com>
 <aCVHQ-LRqHeEVEAW@kernel.org>
 <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5AsNY5mQPd=qajW1seFYHSYpB0Fa1iuR_f2QavtoB6sA@mail.gmail.com>

On Tue, May 20, 2025 at 06:06:50PM +0200, Stefano Garzarella wrote:
> On Thu, 15 May 2025 at 03:45, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, May 14, 2025 at 03:46:30PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > This driver does not support interrupts, and receiving the response is
> > > synchronous with sending the command.
> > >
> > > Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
> > > ->send() already fills the provided buffer with a response, and ->recv()
> > > is not implemented.
> > >
> > > Keep using the same pre-allocated buffer to avoid having to allocate
> > > it for each command. We need the buffer to have the header required by
> > > the SVSM protocol and the command contiguous in memory.
> > >
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v5:
> > > - changed order and parameter names to match tpm_try_transmit() [Jarkko]
> > > v4:
> > > - reworked commit description [Jarkko]
> > > ---
> > >  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
> > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > > index 0847cbf450b4..f5ba0f64850b 100644
> > > --- a/drivers/char/tpm/tpm_svsm.c
> > > +++ b/drivers/char/tpm/tpm_svsm.c
> > > @@ -26,37 +26,31 @@ struct tpm_svsm_priv {
> > >  };
> > >
> > >  static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> > > -                      size_t len)
> > > +                      size_t cmd_len)
> > >  {
> > >       struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > >       int ret;
> > >
> > > -     ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
> > > +     ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, cmd_len);
> > >       if (ret)
> > >               return ret;
> > >
> > >       /*
> > >        * The SVSM call uses the same buffer for the command and for the
> > > -      * response, so after this call, the buffer will contain the response
> > > -      * that can be used by .recv() op.
> > > +      * response, so after this call, the buffer will contain the response.
> > > +      *
> > > +      * Note: we have to use an internal buffer because the device in SVSM
> > > +      * expects the svsm_vtpm header + data to be physically contiguous.
> > >        */
> > > -     return snp_svsm_vtpm_send_command(priv->buffer);
> > > -}
> > > -
> > > -static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > > -{
> > > -     struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > > +     ret = snp_svsm_vtpm_send_command(priv->buffer);
> > > +     if (ret)
> > > +             return ret;
> > >
> > > -     /*
> > > -      * The internal buffer contains the response after we send the command
> > > -      * to SVSM.
> > > -      */
> > > -     return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > > +     return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
> > >  }
> > >
> > >  static struct tpm_class_ops tpm_chip_ops = {
> > >       .flags = TPM_OPS_AUTO_STARTUP,
> > > -     .recv = tpm_svsm_recv,
> > >       .send = tpm_svsm_send,
> > >  };
> > >
> > > @@ -85,6 +79,7 @@ static int __init tpm_svsm_probe(struct platform_device *pdev)
> > >
> > >       dev_set_drvdata(&chip->dev, priv);
> > >
> > > +     chip->flags |= TPM_CHIP_FLAG_SYNC;
> > >       err = tpm2_probe(chip);
> > >       if (err)
> > >               return err;
> > > --
> > > 2.49.0
> > >
> > >
> >
> > I can pick this for 6.16.
> 
> Great, thanks!

Can you rebase this on top of my next branch and send one more version
of the series (fake ancestor crap)?

> 
> Stefano
> 

BR, Jarkko

