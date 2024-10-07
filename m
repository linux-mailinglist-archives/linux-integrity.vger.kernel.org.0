Return-Path: <linux-integrity+bounces-3746-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F336993B64
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Oct 2024 01:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170F9B230F8
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 23:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13218C928;
	Mon,  7 Oct 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl/r0Dhq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662954317E;
	Mon,  7 Oct 2024 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344827; cv=none; b=il6+dpLE95HAdQkfHDgBvVxNF8kSYKGvKh8zqWRDXZcZ2rcBrV3Fruq7DdKLh/fgAZMmMCXZKffFjyJy8dOaU+2uPv/UgNBJQIPO2mMSaz20Snucq0fKJyMZYSRaVIaRtmEy/uAefkRKwMvVy441zDf4XV00MBq4pBv/RAVr2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344827; c=relaxed/simple;
	bh=foSoZhXso5EiCokUPPe1i4CzRXCfgAb99KTFLC0QAFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TyhboWjGrgmxQeTQwqLlDOY2zk2kk3xxUS5thx8hM1WjShlL5gOx+kY6Re99BKKmU/WEP7rNVf5Sz2Eb9qPERdtJ+WesPV0xlacIH0N6AiBxcR1VdvSzg5iizYwrRJKE69XEHH+u6OL6v6pxGFjttQEduGIY/QfDdMDwuGJ7XYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl/r0Dhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87899C4CEC6;
	Mon,  7 Oct 2024 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344827;
	bh=foSoZhXso5EiCokUPPe1i4CzRXCfgAb99KTFLC0QAFw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Cl/r0Dhqalm5NxG7M2m+FEXs6XL6VGk/5S7rHJfUygtuNM7HYRVrNuh1+TIqvXL1X
	 6y8bQnq/HZNFDzZP0F9LSGiwfc/mb8LDkLw6Ruu8TNsb4oW89qGTznPuPWSLsePIpQ
	 jwTrLAMbeTWWyNr6TmFNVKWnC6i1k3aoSBdlzD7ZzxoKjGct9z6Xb8jMxEZfNt4YPM
	 FRg1KlokU9WH8i4UzoJUxvYzcbv5wOMEsMX+83ko+r7enLCNyBLJZ/cTCKOfjKwcqY
	 2RU7Mhs00qGxwZuRg0yiQ1UFuQeMKxKeiRSiU8WW7hhWGoZEGzj4thawJCGuMT+u5t
	 spi37MosuiU3w==
Message-ID: <007fba97e174e28dd4fe3cfae1f0e09d510f6d87.camel@kernel.org>
Subject: Re: [PATCH v5 1/5] tpm: Return on tpm2_create_null_primary() failure
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com, 
 mapengyu@gmail.com, stable@vger.kernel.org, Mimi Zohar
 <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,  "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe
 <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 08 Oct 2024 02:47:02 +0300
In-Reply-To: <69c893e7-6b87-4daa-80db-44d1120e80fe@linux.ibm.com>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <20240921120811.1264985-2-jarkko@kernel.org>
	 <69c893e7-6b87-4daa-80db-44d1120e80fe@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-03 at 10:57 -0400, Stefan Berger wrote:
>=20
>=20
> On 9/21/24 8:08 AM, Jarkko Sakkinen wrote:
> > tpm2_sessions_init() does not ignores the result of
>=20
> s/ignores/ignore
>=20
> > tpm2_create_null_primary(). Address this by returning -ENODEV to
> > the
> > caller.
>=20
> I am not sure why mapping all errors to -ENODEV resolves the fact
> that=20
> tpm2_sessions_init() does not ignore the result of=20
> tpm2_create_null_primary(). I think what you want is to return -
> ENODEV=20
> from tpm2_auto_startup.

Fair point.

>=20
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v6.10+
> > Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - Do not print klog messages on error, as tpm2_save_context()
> > already
> > =C2=A0=C2=A0 takes care of this.
> > v4:
> > - Fixed up stable version.
> > v3:
> > - Handle TPM and POSIX error separately and return -ENODEV always
> > back
> > =C2=A0=C2=A0 to the caller.
> > v2:
> > - Refined the commit message.
> > ---
> > =C2=A0 drivers/char/tpm/tpm2-sessions.c | 5 +++--
> > =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm2-sessions.c
> > b/drivers/char/tpm/tpm2-sessions.c
> > index d3521aadd43e..0f09ac33ae99 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -1338,7 +1338,8 @@ static int tpm2_create_null_primary(struct
> > tpm_chip *chip)
> > =C2=A0=C2=A0		tpm2_flush_context(chip, null_key);
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	return rc;
> > +	/* Map all errors to -ENODEV: */
> > +	return rc ? -ENODEV : rc;
>=20
> return rc ? -ENODEV : 0;
>=20
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /**
> > @@ -1354,7 +1355,7 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> > =C2=A0=20
> > =C2=A0=C2=A0	rc =3D tpm2_create_null_primary(chip);
> > =C2=A0=C2=A0	if (rc)
> > -		dev_err(&chip->dev, "TPM: security failed (NULL
> > seed derivation): %d\n", rc);
> > +		return rc;
> > =C2=A0=20
> > =C2=A0=C2=A0	chip->auth =3D kmalloc(sizeof(*chip->auth), GFP_KERNEL);
> > =C2=A0=C2=A0	if (!chip->auth)

Thanks!


BR, Jarkko

