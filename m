Return-Path: <linux-integrity+bounces-5183-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D762A56EF3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE631894F71
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863223FC4C;
	Fri,  7 Mar 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="kVmqko+g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE923F417;
	Fri,  7 Mar 2025 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368344; cv=none; b=WBqYKqsz+1SsccNJ4+ju49vbKE9ly84Ayzu+pRNHVHBV8UIbBD8jzYM1mgI4qS6FxTEQdy8ll4YI+s+4oOd/h18JaTVNpTQchjkefvo8CK6by8uHuhPHK9mCmXKWR6QrCq04NOND4WB5qbIX9EhfsLgx4kAgxKdytAcQhiOq9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368344; c=relaxed/simple;
	bh=4TgqF5PzG5rwyF22hpvCrDenfnUV2QW4nW9vZ1D2b3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJw3SY+hXjWHCdgIis5lPTljjmrzHgFrITftcTe7WpjeG11W9UwHPywWKDz6iArhhi2FBQyRuu2BAvp1QW9KUHjC3CydrgGuYqM3yC20JtPts2C6Yjrz8ZvhxBh1QiyG40PFuDrbStfbT65gbvHM86C+1ZjcrH10QMqT8cC+gWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=kVmqko+g; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5tYAA/tNDFjXTBXcriqcTjPLPjUcxEBzzh5F4yIZ5zo=; b=kVmqko+gWV+JaGa7kdCAPkR1K/
	0Mj9urIZB+ept71ZijGadczjSabubefPcjNDoXcOC9Tfp8LK+qOp9FwaoDMktkD0KDN3Iunw09NEV
	7dBjpepM+KQ6D4cYGNofT5vmtfvSMViQk/Gi69IbpT3QTht6bdABBGWu2+vjlzmFfm0v8dFOAvg5U
	MX5CuQq0MfbrFNY4DRyhC8uicfqXe7/FTIVpWPEIKfbiJY5QRj5x/6b1uuFo2yp50W9JFvK4JPC5T
	2fKGuT+Ih/4T9IMJ/5SgEeYW4c7pETO7GnePLtvpnxUKIsL10xjkxoiZZyaNVkbE5x7zvuZ+R/4ez
	Fh7UKETA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tqbS4-00DF1v-0u;
	Fri, 07 Mar 2025 17:25:36 +0000
Date: Fri, 7 Mar 2025 17:25:36 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Drop warning when an auth session is active
Message-ID: <Z8ssEDPIyOguNBXb@earth.li>
References: <Z8m8G0RfiRyYGH_t@earth.li>
 <Z8oV9lJ4hsHualcP@kernel.org>
 <Z8rQ7Mxf_G6227HP@earth.li>
 <Z8sgcquTyx1ICvS_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sgcquTyx1ICvS_@kernel.org>

On Fri, Mar 07, 2025 at 06:36:02PM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 07, 2025 at 10:56:44AM +0000, Jonathan McDowell wrote:
> > Auth sessions are lazily flushed since commit df745e25098dc ("tpm:
> > Lazily flush the auth session"), so it's expected that we might try to
> > start a new session when one is still active.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > ---
> >  drivers/char/tpm/tpm2-sessions.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index b70165b588ec..2d2c192ebb14 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -982,7 +982,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
> >  	int rc;
> >  
> >  	if (chip->auth) {
> > -		dev_warn_once(&chip->dev, "auth session is active\n");
> >  		return 0;
> >  	}
> 
> OK so curly faces should be also removed but I can adjust this
> (if you don't mind), so we save all of us from trouble of
> going through additional review round?

Doh! Shoulda caught that. Feel free to do the fix up.

J.

-- 
   "Why? - because it's f***ing    |  .''`.  Debian GNU/Linux Developer
     there!" -- Edmund Hilary      | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

