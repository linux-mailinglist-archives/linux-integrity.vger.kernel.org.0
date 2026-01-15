Return-Path: <linux-integrity+bounces-8246-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1267D23313
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 09:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE7E31A17EA
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jan 2026 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1F334C0D;
	Thu, 15 Jan 2026 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Id/BXAZc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5404133344A
	for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465772; cv=none; b=ssqo7AU6sTPHVa87yqwJz5O54xVWlostPwZKR3I5Hz4YvM4CUt1J53ivVtHemjipS2uOciwDXzqEbfiObLUbyqde29UB5PedKVXCHFMVJSdBvQQDkg4rVePoZNYKqxpFBhFcHLEDybjmmodTZQplvaZ1YWMWHM1XxV+u7Ag7jsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465772; c=relaxed/simple;
	bh=D6FQbdplkH9Ohihp+bfGgbReLn+pDYodL58jS6U9Pyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFmaOiFHS8dwrfg1ixPOdUJsTYrvOe/5/B5jycCMqGiyAgjCEf9p+ojaJZfuyCjTU1yoBJKlAWeu8KL6ggb9gDTzMTm6WprG083LVSQu70j76ZD+vfY+UES+UnEFDo6JpxrUxWglLNoxpfBrnTS8RpUewon9qTZV/roO+BdBf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Id/BXAZc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so315991f8f.3
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jan 2026 00:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768465768; x=1769070568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hVJux1U093fRw4E+ZNUEKo3SXeN4KPatwjgOMvfD/U=;
        b=Id/BXAZcNMbCXgM/mV1Igfa3metO7Q/+e8/7VUcOxobpzGRB5QM9kKwO5NgmTHo4B0
         BDQcq7t7KRzI0ofDLb4cqTJveDPjsACfTXEfpD1SsuFi0FYk0+pw2sKMpJX0+XEMqXP4
         qIjyfLPqHJDcr+9wsVqNzED64NuCkcUH9kX21sTXY8FLb/EH/RpkuiCXcfjvlhk7a5Xb
         3NuTCkTKnNyIZiAg5ks5jeKmcqaaeDwaT3p28ZbaPNFVJDLKVoB/gjSu05OdPaT658QX
         4gYR9bsK+HqnYljUzOTjKOG/eRL1U/X85B9Zc8pI3VegYTdpXMt33HpYXWbM//UKiwPy
         OEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768465768; x=1769070568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hVJux1U093fRw4E+ZNUEKo3SXeN4KPatwjgOMvfD/U=;
        b=C8XTgnpCgDOrW4Gza+zrU/QgfpyaKHZEHL8xiPzH49LloY3Selx7Ilr9/73TC4jTe1
         2pgdZsLzdYiIytKv0/4M39DwZBqfj5YGN8Hf8WSipUCTSQLBM31Pex6wNdhff2AeljEc
         Atkxd8ATuUo25v5kCGcmskd8rqfH1ij/CjGqpdjhEX5qGeLlvUNLX6uFR5eXwxRPslGs
         4bL+0iL0jJFJlu3uQLD38TfWhDXNCda2FiiF5eR+xuPm/vX8c1wSAD0JqTHf7lGvqjvF
         027nWG0to403T4JrsFks/5biTWKfudwRPy/Qs/S/Xlq1CG8hoWTQEc2QkMDYe9VjEGm3
         RRCg==
X-Forwarded-Encrypted: i=1; AJvYcCWaPMNiBlk8dmRWSRKR69UVdXYxz+g2WdN/AXFM8Hc4rfSastEnna1H20Rvc4YyfBqCkgaek/nn9oEvIygyplI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSrujsCHECH19DK36YA1PBzTwQ47nR5xAX7+P8lasJIubpoLL
	LPwPFsH9E07fBFrPYcOq71IfATbExDYeFx8VybrEttbeKiX+yGCs36+xlhscW4bMPj8=
X-Gm-Gg: AY/fxX6TkMWT6ihBQUK85dQpvO6uA29djQPWJGIJLSprHqoW9Do5WGpL+9FjZ1U/TUS
	HK32K399te+/aNg9oOgwpyDT2lFF2LufYK74yEVwQaqjEIbKB9XoZxBnRMAvaoMlKgQHwhnlWvp
	oYkHNRd25oan7U5JdnQleik7YUpCRx6Ekx16VL2+wu6e7hcPMcM80lsYlm2E8dbnGCteGW4vrAL
	T0NCNKbSwGszUdGdo+PX+ajMJM/WKJNMfsiYpHrhavYRVV0SB1aRMmj7ddxA9Njd7bpi+St91P7
	rHMRrQ8FDMBZBBf6JVhk8VXow8Ox8TslKzIQ8KvQ0S8jo7QC1daxyz68MJzcB8GHMNBiztjqpkH
	jTMXfKqikFz2Bt84ieNTL7MaEwd9VJjwEnAQpOvhRQH3p7wsqeRchG/4CbxOMpBrkCJJXejX8Q5
	69ol/JcPDCLjV9VJ2L8/qI3s3Fy+GdbUlDuB8GAHBqd7kGMK8aycSMyd0yNwFQmQABRmNKSTdy9
	v8=
X-Received: by 2002:a05:6000:2dc2:b0:430:ff41:5c92 with SMTP id ffacd0b85a97d-4342c548757mr6903156f8f.53.1768465767535;
        Thu, 15 Jan 2026 00:29:27 -0800 (PST)
Received: from localhost (p200300f65f20eb044d6ddd06d23e100b.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:4d6d:dd06:d23e:100b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-434af6b143fsm4390104f8f.25.2026.01.15.00.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:29:26 -0800 (PST)
Date: Thu, 15 Jan 2026 09:29:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
	linux-integrity@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
Message-ID: <yxbcy7rsteemywp4bcpvwuueqye64hhqxhgkvwj72oasd2ls5l@rqwpbumkzrdb>
References: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
 <CAHUa44G+2PWzOnj6smTR9vES06hrwry-SaSj-FcPJgVccNTSXg@mail.gmail.com>
 <aWe9EzWskkSB0Sv-@kernel.org>
 <CAHUa44Fjdskx_5+=gugCwfqBOnF8+Hs2=enauLOExafxo5K3=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="564eozisjgzfpj5c"
Content-Disposition: inline
In-Reply-To: <CAHUa44Fjdskx_5+=gugCwfqBOnF8+Hs2=enauLOExafxo5K3=w@mail.gmail.com>


--564eozisjgzfpj5c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
MIME-Version: 1.0

On Thu, Jan 15, 2026 at 09:06:35AM +0100, Jens Wiklander wrote:
> On Wed, Jan 14, 2026 at 4:58=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Wed, Jan 14, 2026 at 07:47:09AM +0100, Jens Wiklander wrote:
> > > On Tue, Jan 13, 2026 at 3:38=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > >
> > > > Recently ftpm_tee_probe() and ftpm_tee_remove() grew a suffix in th=
eir
> > > > function name but I failed to adapt the kernel doc when doing so. T=
his
> > > > change aligns the kernel doc to the actual function name (again).
> > > >
> > > > Fixes: 92fad96aea24 ("tpm/tpm_ftpm_tee: Make use of tee bus methods=
")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202601132105.9lgSsC4U=
-lkp@intel.com/
> > > > ---
> > > >  drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Looks good to me. Jarkko, OK, if I also take this patch via my tree?
> >
> > Works for me that way too with my r-by tag.
>=20
> Thanks, it's there now.

Stephen pointed out that I forgot to add my S-o-b[1]. So I hereby certify
that I created the patch and have the right to submit it under the GPL2.

With that I think it's technically ok that the commit doesn't have my
S-o-b. But if you are willing to rewrite the commit still, please add
it:

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Sorry for the mess,
Uwe

[1] https://lore.kernel.org/all/20260115075340.72b35a93@canb.auug.org.au/

--564eozisjgzfpj5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlopWMACgkQj4D7WH0S
/k4FYAf/ViLAyaafzRLkdckAe31CwzwbsAkCOwEO8/7YPIYkDNh7zJkroCesZlj7
qlkWuHVE34zbp4INgTbEp4I5o1duBNbHXdLbgvNOvC8PctBnY+0qUnOI48LUEvRa
Sycqnj75LeiGFKD5Ukd4JIb0RI28QGf0MHrv7oJ7qhg4Aik0pvkx2aubIV0+Spur
QTmLzgJTsDmRQo7GeJmtTfobSVrmLjlBB4pn0gr3PV1ff16TFGjoWf4EdjH8dYRk
/wqUCAn9zbMUyGsFVljc+xTBQnzEQWls38EI59NrmnJSHBM5OdYIIULtLn0Zns6G
R6/n0aJCUvzXd7JQfmjjE8u7aFlDKw==
=Wg8I
-----END PGP SIGNATURE-----

--564eozisjgzfpj5c--

