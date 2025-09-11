Return-Path: <linux-integrity+bounces-7054-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA2B53540
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D865620FA
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A9A338F55;
	Thu, 11 Sep 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Retvw+pJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87057338F27;
	Thu, 11 Sep 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600803; cv=none; b=nK4dP8yR7tMvwwUEMKtbs/Xu+PdORjpC7xhJMjBszbAo3ySUY7beZTXJKSBfc2MaadZnTliG2JvnZAMBqyGierMWH01mJMCONdYZFe/505dsH7J/Tftg9TsyhHToiGjomuBOMd0wuycOE/9PKSXuAtEILtxI0R0CXm7V1yffX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600803; c=relaxed/simple;
	bh=lnRsl96nMI9E4v3DQ/pjk8ucXdErNbdVIuuJ+55bhPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDD6+vvR8HNsbuaBVd76ZAOgZMW91quZn+SHHQJ6qlFa0xHXrRP9cG62jeuqJo2gW/v1MNCAGsO2XMkXldHKDAfdDMekJDuF0F255eUjrRfkRNEBBWGo/CIcC2/kNsOr+WoPO0JDPhsDJu2BBzzhmzrtcTBZZKVjifyuHWjpKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Retvw+pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E94C4CEF0;
	Thu, 11 Sep 2025 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757600803;
	bh=lnRsl96nMI9E4v3DQ/pjk8ucXdErNbdVIuuJ+55bhPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Retvw+pJ+CrqlqfCe0AVelzQ0n3uvOFUQNqUbhk2Eq6pBTPXg5C5//ERxardEsBBb
	 50jJEaewYwKSpQLEP7V2sRNSmQuMwUxrK/MkQLu12VMFRm+Wj2tjlY9UFzsmo+R/ty
	 MIhG8+N0dLOoKrQ7jD9a+Fl+m3qMBS2kY0jiNd3kXDeK6h5iEptVRSBKe+QWrucKnW
	 o30vim3qvqESuGrG3nNvhVmpR9MNsemB+fshZiXmT3qu+qEz1HhpKnTrLBqqXRJank
	 vTnY+MF7IcLy2mdqZ3f7UaGwXMveoaqrvTfQ7ZzH6JfK2fvsnBDMaFhXWe9siHbkpe
	 g0gia4+xaEVOQ==
Date: Thu, 11 Sep 2025 15:26:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: tpm: SLM9670 does not work on T1023
Message-ID: <644b0f0f-9e02-44fb-a0d4-f4018816e156@sirena.org.uk>
References: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JmIts2jpKcR2DYEP"
Content-Disposition: inline
In-Reply-To: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
X-Cookie: Your domestic life may be harmonious.


--JmIts2jpKcR2DYEP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 03:52:33PM +0200, Alexander Wilhelm wrote:

> However, the driver reads an incorrect vendor ID (0x1000000) and hangs du=
ring
> the startup sequence. A logic analyzer shows that the chip select line go=
es high
> immediately after transmitting 4 bytes, which, according to various forum
> discussions, does not comply with the TPM specification. Unfortunately, I
> haven't found a definitive solution to this issue.

That sounds like the controller is configured in word mode and is
bouncing chip select after every word it sends.  The Freescale
controllers are fond of implementing and using that, no idea about this
specific one.  I see there's some non-standard DT properties it has
which look like they're related to chip select modes but no idea what
they do.

> Could this be a bug in the `spi-fsl-espi` driver, or is it possibly a har=
dware
> limitation of the T1023? I've come across some suggestions that involve u=
sing a
> GPIO as an alternative chip select instead of the one provided by the SPI
> controller. Can anyone confirm whether this workaround is viable? I=E2=80=
=99d prefer to
> avoid a PCB redesign unless it's absolutely necessary.

Can you not pinmux the signal from the SoC to a GPIO instead of the SPI
controller?  It's fairly common to do that since controllers often have
regrettably limited or unhelpful chip select features so GPIOs are often
the better choice.  The controller does what it likes with the chip
select signal but it's not actually connected to anything and we do
everything in software.

I'd recommend contacting whoever looks after the relevant controller
driver, though it looks rather abandoned TBH.

--JmIts2jpKcR2DYEP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjC3B4ACgkQJNaLcl1U
h9AqVwgAhuZX1XfoLYOS0NGawkwPZIRBOt8mho3SyMC+M0JhWRnetSmnWgOYjr+4
cOfwrXH5o9UDVC9gnmZoOZfR6l4IfXE5L0rFYk6kIZebrT9YuaDDHnWt33h8QGRr
yOVPuIUBxtD1vslQP1/ayw7cc0nsdgyq3Rego6qhln7eQfS+VlTVFguR94mhyAxY
WyfzTooNQknNOd/YqsXiIfoXdytYF/tPnpHuV1ln4BIUGe95R08nmwIPT10gxxYm
xu4jHNOeFgEaQxb8eGCLkJi/Y2qv+o5Bb1FP8WE19NE0ZUAVKVlfUZw6P7uCWAnj
YcCibVFRYY8z3uzMM9ItByJW+l8RZg==
=3JyB
-----END PGP SIGNATURE-----

--JmIts2jpKcR2DYEP--

