Return-Path: <linux-integrity+bounces-3825-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B636199FB49
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2024 00:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BD61C21BDC
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8411B0F0F;
	Tue, 15 Oct 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrrekJPW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A721E3A7;
	Tue, 15 Oct 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030943; cv=none; b=UGb4dB4lFfY9/qpE2k7v1ORRW+6x+rZkrU1UksNqgTMaPZzutvBbm6vSrGzqJcdakLtTJ9y+fUUuXQvVppFlWHsFgLFBpI3iH+4LptvqdhcV3TcmciZFIxzb5Wl84Nbkn6TTp0bragBEoo6pd1gkJ0FbJL4K4eilDAl0sT9CFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030943; c=relaxed/simple;
	bh=MqROk6YiTzTKr8OCAw+4XexydexhAVUg7ZMIG1b65C0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=edVFumSogJVjI+nAV4HW6zn/GqaHI/4s2qY5nHlb0ed3Ice4dIlicb1WDSPbtzH4lJyOOi64YGzpPF8S1QasloSNV2hkzCgwx3IBlGPdDZyc5+5fusmWl3YJkFmTRn7pxeq92pJWZDkNdfjKMQiChfzoDwx3mdV+anNKCo8h0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrrekJPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74879C4CEC6;
	Tue, 15 Oct 2024 22:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729030942;
	bh=MqROk6YiTzTKr8OCAw+4XexydexhAVUg7ZMIG1b65C0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BrrekJPW1u5fZxEozOw7RtkxN67hwQ9ET/sf+sss57ND6gSnsEip1T4DXrCOg0Rne
	 GFFahu7ocXCaKv1csTuoMrjIfbmfUPf7gU0aJxd5QRkz51dtokK9UjQsHWlrmhHwk/
	 zKBsE9fwY0LGXqWdiPSLB/CHhiQZ/ReY47CCA8fOYnovRLyEFnggFr7TC1TYpIDAGK
	 im4OYOYRQLcvwLFh83zUWvVUL6zjtK9fHLDj6tAnCEZGuOQi60aYIVTqdRE9HnMrEh
	 upoqwnwRq1PnPFT+jT4JQTF/yxL9Nr3WlcoLL1sWFaO0braD2xStwUcDdQ5hZuxGzD
	 fGTVkKGkQMeuQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 01:22:18 +0300
Message-Id: <D4WQBBTDU1Z4.3GRA9MGONWI1P@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Set TPM_OPS_AUTO_STARTUP flag on driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241014141643.3101129-1-stefanb@linux.ibm.com>
 <D4WOWALWYOES.Q12TQS9P30TH@kernel.org>
In-Reply-To: <D4WOWALWYOES.Q12TQS9P30TH@kernel.org>

On Wed Oct 16, 2024 at 12:15 AM EEST, Jarkko Sakkinen wrote:
> On Mon Oct 14, 2024 at 5:16 PM EEST, Stefan Berger wrote:
> > Set the TPM_OPS_AUTO_STARTUP on the driver so that the ibmvtpm driver n=
ow
> > uses tpm2_auto_startup and tpm1_auto_startup like many other drivers do=
.
> > Remove tpm_get_timeouts, tpm2_get_cc_attrs_tbl, and tpm2_sessions_init
> > calls from it since these will all be called in tpm2_auto_startup and
> > tpm1_auto_startup.
> >
> > The exporting of the tpm2_session_init symbol was only necessary while =
the
> > ibmvtpm driver was calling this function. Since this is not the case
> > anymore, remove this symbol from being exported.
> >
> > What is new for the ibmvtpm driver is that now tpm2_do_selftest and
> > tpm1_do_selftest will be called that send commands to the TPM to perfor=
m
> > or continue its selftest. However, the firmware should already have sen=
t
> > these commands so that the TPM will not do much work at this time.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  drivers/char/tpm/tpm2-sessions.c |  1 -
> >  drivers/char/tpm/tpm_ibmvtpm.c   | 15 +--------------
> >  2 files changed, 1 insertion(+), 15 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-s=
essions.c
> > index 511c67061728..b1a0a37f14d7 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -1362,5 +1362,4 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> > =20
> >  	return rc;
> >  }
> > -EXPORT_SYMBOL(tpm2_sessions_init);
> >  #endif /* CONFIG_TCG_TPM2_HMAC */
> > diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmv=
tpm.c
> > index 1e5b107d1f3b..76d048f63d55 100644
> > --- a/drivers/char/tpm/tpm_ibmvtpm.c
> > +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> > @@ -450,6 +450,7 @@ static bool tpm_ibmvtpm_req_canceled(struct tpm_chi=
p *chip, u8 status)
> >  }
> > =20
> >  static const struct tpm_class_ops tpm_ibmvtpm =3D {
> > +	.flags =3D TPM_OPS_AUTO_STARTUP,
> >  	.recv =3D tpm_ibmvtpm_recv,
> >  	.send =3D tpm_ibmvtpm_send,
> >  	.cancel =3D tpm_ibmvtpm_cancel,
> > @@ -690,20 +691,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_d=
ev,
> >  	if (!strcmp(id->compat, "IBM,vtpm20"))
> >  		chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> > =20
> > -	rc =3D tpm_get_timeouts(chip);
> > -	if (rc)
> > -		goto init_irq_cleanup;
> > -
> > -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > -		rc =3D tpm2_get_cc_attrs_tbl(chip);
> > -		if (rc)
> > -			goto init_irq_cleanup;
> > -
> > -		rc =3D tpm2_sessions_init(chip);
> > -		if (rc)
> > -			goto init_irq_cleanup;
> > -	}
> > -
> >  	return tpm_chip_register(chip);
> >  init_irq_cleanup:
> >  	do {
>
> Not much to say about this ;-)
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Also applied to master. I think that it is better to gather all TPM
bus protection fixes there and send a single pull request for v6.12 with
all the content. So this would include my fixes for AMD issue, this
patch and Mimi's patch.

And also perhaps a few more would squeeze in before that time. E.g.
tpm2_get_random() would be one such place, which could be heavily
optimized by pooling the implementation with couple of thresholds
(lo and hi), and then filling the pool with fixed size requests
from the TPM, i.e.

1: Going below lo: start filling the pool
2. Going above hi: stop filling the pool

perhaps using workqueue. Hwrng would never trigger any TPM command
but instead would be served from the pool what's left there. That
pool could be even something like struct tpm_random_pool with pool
and the tresholds, thus allowing different callers to have their
own.

Sorry, just using this space to document the design to lore :-)

BR, Jarkko

