Return-Path: <linux-integrity+bounces-3664-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD88197E747
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934F828179F
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C290757FC;
	Mon, 23 Sep 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ1h8hrB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191857C8D;
	Mon, 23 Sep 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078952; cv=none; b=PBeFWLqoYuJbsY4CEpHkye7kzg38gGQpiriJAktKsP/Arkq552DmpA/3DHzrdao1hhjHfIh+JtKY6PnVeATjGVqHG+zTgjH7T3Njo79CF0HiAajCA4ffE4zzfDzvdmf14eYpcN2m4g6wp06lUwpBhvTQozeFREeTyAGLtS0OGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078952; c=relaxed/simple;
	bh=DYWLGiSguvRc6xsFH1RfLd076LVfSqGEyDRLDQnSE9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=REjOAcO7R3sLVWYYTFznMVM41qUJpakDd7zThkY1spVuvv6eV43xZ3a5cVmIreYy7uw+fEBJI8TigAYFybTqd/Cgj7F22b6H2rd5+zNdTjpwzFuH8i06bx4Yp5EVAOsjaWxM/+bz4+AGKU4U5VftFguOww4dXwhiAG9ZqOT90E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ1h8hrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BECC4CEC5;
	Mon, 23 Sep 2024 08:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727078952;
	bh=DYWLGiSguvRc6xsFH1RfLd076LVfSqGEyDRLDQnSE9E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dZ1h8hrBWeRdecGm3tqMf30z9XtvjMXl/lkCONoHwUDCMsGfqGvSy6cisF7XyTLWQ
	 uvjt+M5hPox5xj7b9y5CjGdPfgWGZkG30cPvHQClAnlgdfoG/fHfT+MggisxsgWCFB
	 upi++BGCQm6OrZRJbbUvxRjKSDLQaXnGsJaiD3RNSIX2IwMLM5KK89PEt1SAT7Nu51
	 dEEJFSqN98WXjLq1wIlHDq98wVmSlqf9OCkQaYgKJ76sf/OXzFgWd/uGp6J3LIyWNO
	 HgrRczCPkGa8/rcbe4+tCLWFjdEpnIK9rawokvMXLm4q8tJKnChNmt7YhW0B7qMr3P
	 pBBWyzyRpz+5Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 11:09:08 +0300
Message-Id: <D4DIE3OQ1GK8.39HBF384Z74Z5@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, "Guangwu Zhang" <guazhang@redhat.com>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <D4DICMSZJXCG.8X4SU03FPJ4X@kernel.org>
In-Reply-To: <D4DICMSZJXCG.8X4SU03FPJ4X@kernel.org>

On Mon Sep 23, 2024 at 11:07 AM EEST, Jarkko Sakkinen wrote:
> On Mon Sep 23, 2024 at 10:52 AM EEST, Jarkko Sakkinen wrote:
> > On Mon Sep 23, 2024 at 9:05 AM EEST, Herbert Xu wrote:
> > > Dear TPM maintainers:
> >
> > There's really only just me (for past 10 years). Maybe that should be
> > updatred.
> >
> > >
> > > Please have a look at the tpm hwrng driver because it appears to
> > > be returning a length longer than the buffer length that we gave
> > > it.  In particular, tpm2 appears to be the culprit (though I didn't
> > > really check tpm1 at all so it could also be buggy).
> > >
> > > The following patch hopefully should confirm that this is indeed
> > > caused by TPM and not some other HWRNG driver.
> >
> >
> >
> >
> > >
> > > ---8<---
> > > If a buggy driver returns a length that is longer than the size
> > > of the buffer provided to it, then this may lead to a buffer overread
> > > in the caller.
> > >
> > > Stop this by adding a check for it in the hwrng core.
> > >
> > > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > >
> > > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/c=
ore.c
> > > index 57c51efa5613..018316f54621 100644
> > > --- a/drivers/char/hw_random/core.c
> > > +++ b/drivers/char/hw_random/core.c
> > > @@ -181,8 +181,15 @@ static inline int rng_get_data(struct hwrng *rng=
, u8 *buffer, size_t size,
> > >  	int present;
> > > =20
> > >  	BUG_ON(!mutex_is_locked(&reading_mutex));
> > > -	if (rng->read)
> > > -		return rng->read(rng, (void *)buffer, size, wait);
> > > +	if (rng->read) {
> > > +		int err;
> > > +
> > > +		err =3D rng->read(rng, buffer, size, wait);
> > > +		if (WARN_ON_ONCE(err > 0 && err > size))
> >
> > Are you sure you want to use WARN_ON_ONCE here instead of
> > pr_warn_once()? I.e. is it worth of taking down the whole
> > kernel?
>
> I looked at tpm2_get_random() and it is pretty inefficient (not same
> as saying it has a bug). I'd love to reimplement it.
>
> We would be better of it would pull random let's say with 256 byte
> or 512 byte chunks and cache that internal to tpm_chip. Then the
> requests would be served from that pre-fetched pool and not do
> round-trip to TPM every single time.
>
> This would improve overall kernel performance given the reduced
> number of wait states. I wonder if anyone knows what would be a
> good fetch size that will work on most TPM2 chips?

Herbert, I'm going to go to gym but I could help you to debug the
issue you're seeing with a patch from tpm2_get_random(). We need
to fix that one first ofc (as you never should build on top of
broken code). Once back from gym and grocery shopping I'll bake
a debugging patch.

BR, Jarkko

