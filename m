Return-Path: <linux-integrity+bounces-4207-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312449D9654
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 12:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B70167DFB
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E91CEEB6;
	Tue, 26 Nov 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="LpfjVInq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D41CEE8C;
	Tue, 26 Nov 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621365; cv=none; b=VXiQl1OimPfzfVnZcd06I0Neky66iLiE+PSXWJyvTGeFdjqRve2GIRmaVQaThSi4r4CYrV4bB8tyauAoQrSLU+7vsw6Q4noU9h4yYRgdxHG1+Moi1UNA0CtIZETi0yb45xsxXjcS/U7Ir6St0wEq/4GEaWZMsvC1KUJloDpwVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621365; c=relaxed/simple;
	bh=nZWGs2lMItOp5qiSx76l1ZQT4xO8bz5PZ0Yx4S9cOgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx9CLSVFNme669PB32nfhwa7B9IsZTuqLJwxojDSyFo/D40p2UmIIcpXPl2Fq523VL7ez2eNC21UoqCL1A86ljSXZ2LjUi/XAO/jaywJyZWWUwNwinGTe5SKPOLlasiwk2IsWSDvWLOD4qOzlujGAdHd5mX2hS7eZ5V2Dai9P+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=LpfjVInq; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1732621344; x=1733226144; i=christian@heusel.eu;
	bh=nZWGs2lMItOp5qiSx76l1ZQT4xO8bz5PZ0Yx4S9cOgg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LpfjVInqY/t13xAA4/HDdgITXrmnhfbP+3XsNud2Bx5Bz8NO+rAtVjwM8EAKwTC+
	 ouOe4UmJsQnZEnlyWIjaw40FOyQAhJjmOPm2H3wxOE19m+Nxk+qm+0ZygDTbyrGb8
	 PmcL6zeeCc5jKg+8anD8Ijikpq0Te9MPwSOqkuqTQ0LXaSHKGfmFaZw+y+I7YqBor
	 W9J3SNeZYEwRinOoDDnic9qAMkUE8YahDnC2Ooov+IZERlKmzvuy9cR5sT1zDlKGi
	 RGwa98zBKacdfGZkv/+/HJyvBESEBDINUihligBQazk+ri5SOeXa2D8OiSDgkeAi6
	 uaOG4z7l6N1H5ZZCWQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MElhb-1tVXHX0E4B-002Qsz; Tue, 26
 Nov 2024 12:42:24 +0100
Date: Tue, 26 Nov 2024 12:42:23 +0100
From: Christian Heusel <christian@heusel.eu>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones
 since 1b6d7f9eb150
Message-ID: <b3a01060-f59b-430d-afcc-48c5ec628bcb@heusel.eu>
References: <7d052744-4bfa-40bc-ba06-1b4c47a5eb87@heusel.eu>
 <D54YWMOV7KOO.2X0N035UHEFBD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eaev7d3urdeo2ifc"
Content-Disposition: inline
In-Reply-To: <D54YWMOV7KOO.2X0N035UHEFBD@kernel.org>
X-Provags-ID: V03:K1:fY0TFxl00akwpsKGVF1gMOkrqTHSP+O92p7nk1Ej9tMrSe6htr9
 Aua3m5vykN/Ie73rk5XeEQ1tvLltVdjeR5YH2pH4/q8VY8IVW0Q+E89VqBDMg8DJqZAzzUL
 TM3i8f9JHJycRxKoV4siX3JChLi5Chy0X0aL2JIzUd0rBaGja/Ek91TnmdLQBkh3B/iepoC
 J0IdN8wKkt+YjJf7hsOCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8wZXSklPUW4=;ES6jqhBtoMOMtB4EHfeEC9hVx0L
 z/WKe6JWjDH6OIKyuZYtkk0xjGWxJBYlqhUdhM2WmYcQfF8XSnb0Xjl4rp9NlkBXtnZ7pjQbB
 l5c0swe5ajmmFdhmgj1lTKSp1PnQEqVhixGcNe3toIMXzoJ0SOQCancv8SqB1t/l02rRIxUa1
 vs/Maw3FGcLO5SmP6DUpmiBi5yW8lUF8gGGa5dLRpYbcUfC5Cl0dqwRHYLSXWVD7NpUkHUJ1S
 ZUBu8uyLXATSDYmzEgRTkhrb5kQT0IlM53wWBtN+QjJ7VxhEXpFL3bMON2IG/NpBvKHdb0TZx
 CleRoUtFAuXhJtNYIojPD3PUMFWeqsDv4ukqSvbz+EvwmQ2+UoC5pRQ2L+RK73YKSGDa0n3Nl
 ySTobCwdd7WPbjzm48DfKs3M6sv3MCZg7o2/Zqmzff0M6LX6CGA2eqizmc+8L55rrLtJPze99
 GqPV0Izj4VwXOsSzJ053olKYG0/7RJtxamo/nA9hwv0Y9XYZviKC9VLgllwie58ZabfeH8zqc
 xmuHOAXf9+yu2Y+E8l4/5t/Hwl5xxQkYmqtuvNSG98N34/XTueysjN6JoosYidLamvXAh/7LW
 QecRBgt/Gj7Xh9I2aSjUnOcbpbe17//g1QY9tNUOZBjZX/jJfQ2U8SaXlP91P8zWxh9sf9XuU
 RHpghDwpvJsMvmpOXAIMbrvIZSDerihCkLhOrCynhVDSCG0Z2QcC+jgQ1ypvDLrhJM2HGTTeM
 iP5P7DtHXGqKVIDYBlqJYJvcVL0lr1uZ+7wCZOtk9wt9TzCddgNviedP+vgl5A3TDsGUK5fy/
 PjS4SV+AcCR/KHh1ir8Q6E9XTSH+dOofGevjX2CW7v+nav70y9JDwrce4nR+kH0T0C


--eaev7d3urdeo2ifc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones
 since 1b6d7f9eb150
MIME-Version: 1.0

On 24/10/25 05:47PM, Jarkko Sakkinen wrote:
> Yeah, this is on the list.
>=20
> See: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383#c5
>=20
> I had a fix for the AMD boot-time issue already over a month ago
> but unfortunately took time to get enough feedback.
>=20
> BR, Jarkko

I'm not sure if this is supposed to be fixed, but AFAIK we hoped that
the patchset that was mentioned in bugzilla also helped this issue.

The reporter said that the bug is still present in 6.12.1, so this might
need further poking =F0=9F=A4=94

Cheers,
Chris

--eaev7d3urdeo2ifc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmdFtB8ACgkQwEfU8yi1
JYV6XBAAmTuAUz74VeTWU1f8sqFejobrUE11Yqgi3n9/mzfOrEU6JLqkCgFm3Ztc
DAxknT1617vmv+RgLv21VdisBoq+u4QSUSua8MqCHZUWMe+huzbpjUUDMOPt1r4r
bbS4S6tQu4i294MC+qN86TtlHk9VN7VP16EtffLLXHZUxKp3ZgxvnX3XiOGksoCY
YdfKfWNYgXKrukM1/+azr4AMdAOTGmen2zILfIFdC1xIJ4IU+VlWZuC6usTpMRmG
KFlAug0I/Q2U9mjw3MfTFQ2g878h+AVMNwgfjRctIKt8t9raKwiXhiOj1yQu496G
XU/f1CCESOQHnAcrHVVu1h6qdQqB3qZA5vu4yRBj+1SgBVNn67NmyqY2jVvyzsRB
pteNr9b43xCj9F0WFVBAwPIpagRNtdZrG5EBU6c3NV55tx7ehJu88zk8+L/OeJHX
9A9V+j3gAgshPJfyvrmSprrP7xxJgIikQNE8SE6QCIae1nBYTr9pndQmOJPGdi2J
3vy9nsdt4X8XYM2AyOHPwJvrqfXFn8wTtLKhL+5rlq/KYF18qKEwnEaSXTU1+0B8
wjR4QEFauEDjmLFYGrnUYDcD4UpjDusY/8OriPZA9lROhVJLgoZrHIQj7ngmem34
8WyGgIAGGGGmo1aONLWw1DO3v622MDYPZ9z1vwJGgl70txhu6U8=
=D5Sp
-----END PGP SIGNATURE-----

--eaev7d3urdeo2ifc--

