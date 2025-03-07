Return-Path: <linux-integrity+bounces-5196-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EAAA5727B
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CF63B178B
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5551C84D8;
	Fri,  7 Mar 2025 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfp16tag"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F21A5BBA;
	Fri,  7 Mar 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376991; cv=none; b=kjzv+Io6SrhtjiulUSNt0Zl0K7JxB+xMqhWpD5x3zgFeCclYKFPFHzmzoI1oCY5fWG4+lrRgv9+LOuD48Y46XYIYkvUSsuIUCm/Y+ZkWVULuwXHnwtlTtfpUDj3xdz89SCnawqwg1+DukDN+1+nBJL3cBFw2XcSjTUsaREZZgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376991; c=relaxed/simple;
	bh=nP5n6UblbQnKHLRD95syV5EkYQ2SkPzW49xJJD5G9ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beeeRhRIlTuE6dc9m0Wtz9dHRni7U7nmEyWukF2kRk3Nd3yW2++mCfRoH8CrpJCZhf7Y6Uw59VpUDY0BeruXzmsB3638Qhjg7SwPNONEySnia7GG9d1U2cYQgSgdhFW2iMSnTldcTS+G4fyddFtKyfXkYp9uk5l06c1waEmzF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfp16tag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC04C4CEE7;
	Fri,  7 Mar 2025 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741376990;
	bh=nP5n6UblbQnKHLRD95syV5EkYQ2SkPzW49xJJD5G9ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfp16tag3NfVQ1EWjlwGOwHE671I2YDkPPXGd1IDGkGpXKXeKH9ppidmvuoIqd13R
	 VsEHC3scVXOWMJc491pW/gL7T9ciOEoB2vo7alhFtIfRX1C7CJrgbWKulRQjw8JMCS
	 fTvYQz5DHmputa89/ulUw5Yf6LKrXv6P08ryQyGrUxZDieL/zL9JUdBfk9InraUPUN
	 MEfREW9RVknV2dIWh+OxirjDTi3F11AN7r3Df3Be3DBYaVuxlP2wOYUP+0Nqs8mhUf
	 hVMLI9U66tRYQQaBInyTMK0Z3EivPSCozGxmEa7H2mSL+WD3vmITVW5MJpYR1hDQ10
	 rJpz+6TqCEhTA==
Date: Fri, 7 Mar 2025 21:49:44 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Drop warning when an auth session is active
Message-ID: <Z8tN2HVE6PImMFf4@kernel.org>
References: <Z8m8G0RfiRyYGH_t@earth.li>
 <Z8oV9lJ4hsHualcP@kernel.org>
 <Z8rQ7Mxf_G6227HP@earth.li>
 <Z8sgcquTyx1ICvS_@kernel.org>
 <Z8ssEDPIyOguNBXb@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ssEDPIyOguNBXb@earth.li>

On Fri, Mar 07, 2025 at 05:25:36PM +0000, Jonathan McDowell wrote:
> On Fri, Mar 07, 2025 at 06:36:02PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Mar 07, 2025 at 10:56:44AM +0000, Jonathan McDowell wrote:
> > > Auth sessions are lazily flushed since commit df745e25098dc ("tpm:
> > > Lazily flush the auth session"), so it's expected that we might try to
> > > start a new session when one is still active.
> > > 
> > > Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > > ---
> > >  drivers/char/tpm/tpm2-sessions.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > > index b70165b588ec..2d2c192ebb14 100644
> > > --- a/drivers/char/tpm/tpm2-sessions.c
> > > +++ b/drivers/char/tpm/tpm2-sessions.c
> > > @@ -982,7 +982,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
> > >  	int rc;
> > >  
> > >  	if (chip->auth) {
> > > -		dev_warn_once(&chip->dev, "auth session is active\n");
> > >  		return 0;
> > >  	}
> > 
> > OK so curly faces should be also removed but I can adjust this
> > (if you don't mind), so we save all of us from trouble of
> > going through additional review round?
> 
> Doh! Shoulda caught that. Feel free to do the fix up.

Sure np!

> J.

BR, Jarkko

