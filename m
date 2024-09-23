Return-Path: <linux-integrity+bounces-3663-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF497E730
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897C1280EFD
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8376B4AED1;
	Mon, 23 Sep 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVpSGMbN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C292328B6;
	Mon, 23 Sep 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078837; cv=none; b=QeZ4RFqBEZUNlsElzPqPiHpvPfz8OQ58zmS7E8heewvfEU0XkmjAas6YN5lBWk/o42QFg78SBbATG/TABsMwRbq8L6k48BQCMbCLyhG52jc296CFMHJMO8gfDdIuyRrK0cM8j37hzDWNjuG5+o56tiTXmN7VthTFDzS+oaLh8/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078837; c=relaxed/simple;
	bh=QeNolyRHDraIb9X7Pq/rexTGKTjuMtV9B0SKDDvWgtQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=K1IQyQmZI2MqZ1vhAp4lCBUIhZHyzDEUY2XkoInfYl3o0esZQVcwR5FDlOUQqcbzc4Gfjs+UdHOKJHaauYmGufhk6SbkZ5r9ARuVUPB2XbhdIIzDZruVWIHO+Xj9/WHe3HMAs8Pwso0HdKEcd2/NspFs3dNmaDBRnZvbux3vfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVpSGMbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DBC4CEC5;
	Mon, 23 Sep 2024 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727078837;
	bh=QeNolyRHDraIb9X7Pq/rexTGKTjuMtV9B0SKDDvWgtQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=OVpSGMbNtmIbP1gi6qPgbZcY6Oo3beYXEFIlY5/Md0g//eEA5nmmlGaIv2Su895Ql
	 acpv8B/7a5qEluLZP1MzwH49JqVln4dvH8V7yAtklCZYwl83fjtnpfDkOIThmhVZQF
	 5UE9jAexWiq2ZVsHJNlbI3Pf6C/PjAK3dDKFN/9ZC/+GXDAa4J3nJfoIpFCpHvOyCz
	 6sp9ANqC/CNyQGkbbgioEUu3MVeY0zW8irN3N1XRRqy50l271MQglAGopcCxyMywqx
	 /b0alId4C8uOAnGRAdYHOHYdLcTfn/Aepzv19oTaFZtMWD2x/CtKZVlmVCQYSOc90n
	 2TJ/m78mxQPCw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 11:07:13 +0300
Message-Id: <D4DICMSZJXCG.8X4SU03FPJ4X@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, "Guangwu Zhang" <guazhang@redhat.com>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
In-Reply-To: <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>

On Mon Sep 23, 2024 at 10:52 AM EEST, Jarkko Sakkinen wrote:
> On Mon Sep 23, 2024 at 9:05 AM EEST, Herbert Xu wrote:
> > Dear TPM maintainers:
>
> There's really only just me (for past 10 years). Maybe that should be
> updatred.
>
> >
> > Please have a look at the tpm hwrng driver because it appears to
> > be returning a length longer than the buffer length that we gave
> > it.  In particular, tpm2 appears to be the culprit (though I didn't
> > really check tpm1 at all so it could also be buggy).
> >
> > The following patch hopefully should confirm that this is indeed
> > caused by TPM and not some other HWRNG driver.
>
>
>
>
> >
> > ---8<---
> > If a buggy driver returns a length that is longer than the size
> > of the buffer provided to it, then this may lead to a buffer overread
> > in the caller.
> >
> > Stop this by adding a check for it in the hwrng core.
> >
> > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> >
> > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/cor=
e.c
> > index 57c51efa5613..018316f54621 100644
> > --- a/drivers/char/hw_random/core.c
> > +++ b/drivers/char/hw_random/core.c
> > @@ -181,8 +181,15 @@ static inline int rng_get_data(struct hwrng *rng, =
u8 *buffer, size_t size,
> >  	int present;
> > =20
> >  	BUG_ON(!mutex_is_locked(&reading_mutex));
> > -	if (rng->read)
> > -		return rng->read(rng, (void *)buffer, size, wait);
> > +	if (rng->read) {
> > +		int err;
> > +
> > +		err =3D rng->read(rng, buffer, size, wait);
> > +		if (WARN_ON_ONCE(err > 0 && err > size))
>
> Are you sure you want to use WARN_ON_ONCE here instead of
> pr_warn_once()? I.e. is it worth of taking down the whole
> kernel?

I looked at tpm2_get_random() and it is pretty inefficient (not same
as saying it has a bug). I'd love to reimplement it.

We would be better of it would pull random let's say with 256 byte
or 512 byte chunks and cache that internal to tpm_chip. Then the
requests would be served from that pre-fetched pool and not do
round-trip to TPM every single time.

This would improve overall kernel performance given the reduced
number of wait states. I wonder if anyone knows what would be a
good fetch size that will work on most TPM2 chips?

BR, Jarkko

