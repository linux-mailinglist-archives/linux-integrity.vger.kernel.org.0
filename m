Return-Path: <linux-integrity+bounces-7056-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C611B536E7
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF551634A1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601234166F;
	Thu, 11 Sep 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2kbpKp/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0530FC18;
	Thu, 11 Sep 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603087; cv=none; b=J7Xnf7OFseBEThF5D/jhe++h3BW0oB8ntHzgrm7anlZ6chKhIsE7d61SD6emeAfJYWiMyPAQEzwX1ZapMD/0DEKpvFcTNb40JtQosp5EhJA5SEPQx23Vwi+CHXwV2HWidP7qbZwQcSuUVbf2hS7e4sQQUDMp4CFClEukGlxosdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603087; c=relaxed/simple;
	bh=tGj+7sCn6Ms4rMo4FZkinhM7syJUNjaxnGloHN3lGQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTIVW9bjpsEhYrARl8CknabN9XPyHcluj4bJnqyLxLh82CXOSf+RVPVnLL+PQ8XL97SQ7w7O8PzE2Z4w3Pw/27CfigPD6+5lGgkXaGZEScVMkdv/XYI8xmmuHdEP4MZH70u0ic45PruCEU9yIp3ogK7PnQPIQp50PyhZU7l+ATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2kbpKp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C909C4CEF8;
	Thu, 11 Sep 2025 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757603086;
	bh=tGj+7sCn6Ms4rMo4FZkinhM7syJUNjaxnGloHN3lGQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2kbpKp/qy68m1eu7LW3FL3+GEIBVTuKlUQeaCLxEVrZkrp1CUR7lNcLDBnC4DUEV
	 5xD4Y+X/5VHeEsQMOKcWbkyvtdu9/VRhvgLUmnVF2G8550FjjHJC/VCJRne4lFc5q0
	 IlulpsS8vYuOHmfRfZL+RE+vR2/RmB8pxA7prl8wCpjEYcDyU+DGZIRmJ61c8vnMco
	 4PV9SVNMmIdhgwdLQzLdqvcVaR769ai3kzWco/4EV4rJ5MZkDt1EBmfzklv7IEN7j1
	 OTKzLGGzb8lZHHjtGkTcW44Fnw5SkwbCIvkHVY0oGhTTJFpsC/EDFLV2qQdDhyo0NE
	 AM5TlbF4i0zlg==
Date: Thu, 11 Sep 2025 16:04:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: tpm: SLM9670 does not work on T1023
Message-ID: <3a03e665-59dc-4f6b-93a6-6d426a8d8c6f@sirena.org.uk>
References: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
 <644b0f0f-9e02-44fb-a0d4-f4018816e156@sirena.org.uk>
 <aMLh7MCsPNwOqTsG@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0tb3qOeitX2A7Owo"
Content-Disposition: inline
In-Reply-To: <aMLh7MCsPNwOqTsG@FUE-ALEWI-WINX>
X-Cookie: Your domestic life may be harmonious.


--0tb3qOeitX2A7Owo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 04:51:24PM +0200, Alexander Wilhelm wrote:
> On Thu, Sep 11, 2025 at 03:26:38PM +0100, Mark Brown wrote:

> > That sounds like the controller is configured in word mode and is
> > bouncing chip select after every word it sends.  The Freescale
> > controllers are fond of implementing and using that, no idea about this
> > specific one.  I see there's some non-standard DT properties it has
> > which look like they're related to chip select modes but no idea what
> > they do.

> Which DT properties are you referring to? I=E2=80=99ve only used the defa=
ult ones
> provided by the QorIQ DTS files in the kernel.

The various "fsl," ones the driver reads.  Though now I grep for docs
they seem timing related and irrelevant :/ .  You could also look at the
datasheet and see if you can fix the configuration in the driver for
this case, possibly there might be some performance overhead if it's
possible.

> > Can you not pinmux the signal from the SoC to a GPIO instead of the SPI
> > controller?  It's fairly common to do that since controllers often have
> > regrettably limited or unhelpful chip select features so GPIOs are often
> > the better choice.  The controller does what it likes with the chip
> > select signal but it's not actually connected to anything and we do
> > everything in software.

> The problem here is that RCW allows either both enabled SPI + CS or disab=
led SPI
> and CS-pins set to GPIO. Furthermore it is unfortunatelly connected, so I=
 cannot
> simple cut the path on PCB and need a more complicated re-design of it.

Oh, well - that's unfortunate pinmuxing.  Glad to see innovation!

> > I'd recommend contacting whoever looks after the relevant controller
> > driver, though it looks rather abandoned TBH.

> Hopefully, someone with experience in this kind of setup will respond via=
 the
> mailing list.

I'd try to explicitly CC people in TBH.

--0tb3qOeitX2A7Owo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjC5QkACgkQJNaLcl1U
h9An6wf7BVAuJqm1dPax0o+rrVuWIkZ6s/LuzFGGF+LDB8ROd+zrsli8fTfu0Hju
9DfO8YR0iaobQM7wVq62+tKp5RuYdQbeW7f9x+hgVh4HZTzZF3OenhDjYkMbwdDZ
Wzl2FbnVOmqx72jAEa7/lCltUkTTL+pKutaVFdj/ZnSmichdWrfYEIirWc9QXkd8
k7NcnE5b13i053Qq7K2XvhwDFBSNHdBaRm3nfZFD5uXRSJDb0ccfM0ansAcCOWZ/
1aS9NRn4vVKKZNnmF9l2zkAXMuM8rKFScDxlDfYvy4RRd8leTzvcMalUjpJSkGme
qI3+VKAKB5PV3B3adrq8VwnZjxhFgg==
=4ETe
-----END PGP SIGNATURE-----

--0tb3qOeitX2A7Owo--

