Return-Path: <linux-integrity+bounces-3737-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025B9906D4
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2024 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D8F28A151
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796412216A0;
	Fri,  4 Oct 2024 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="cHYsIzSu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D392216A4;
	Fri,  4 Oct 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053267; cv=none; b=nj6nZi6lhri53bMBBOuNky4lFL4ihIg7dUJIZdHUlCi0Lf2tb8kWiBYReeMYMDojKdlbMkdO5c5kNiKuPpcgFdtEu3+Nk8t6OJOHAjw2FoM2/hgw+v/y0I1/DXHnXHnjVB7J4DLsFTwUWhO4FbQBiBiRkwdeVOTyrr27klozqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053267; c=relaxed/simple;
	bh=7hor2qzuwGEvWmi49euvC9tyFA066oo3GcrVIH/aZzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/zcLPWDV5253Mo2l1mmH1QLH7ExzlkXZL+D+iGJUngLBN+AuwuaAPfHgVBy4ejvmDRfXDGA81XQmo3agXcdi3TPk+qh6+t2GOBG30Yf9If9cklf93gDMPaVJAcB/y8uL0tHiVCFK1xvrDeA632jJkKZ3aLEMG75GB/QuH0rf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=cHYsIzSu; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v38cgu6X66MW8fCyAaX1OVN2xawi1fHqr+/1/Zs1Dsg=; b=cHYsIzSu20boL9RlvEdCz/ThpT
	mKZkIjXPTgLG3u0523FoSmZAwbG6Mf2Ri9COErAl9nfk69bT07E0W7NtlxrTRDAO9SbqK8OH5owFJ
	7HcJPMthEMClII9pQfCxPJ6iDWuW8R+TOIB7LnnUwr/15ZBBbc+mtvMtQ/EU1yQPhUtaH4azZj/HJ
	K1fwuZRQEKR0XiE1TiMjXgooWAg0IkZWVT6zPmMwLn+yXePD34QdaL8AN/j4t7zj6Dut6TMq/HVJM
	dCw5GIPGWKEv9r+WyTo+80gpMv94uGt76TIBHNSYqUCWF8gTeJoM8SLAJPGUKyk4VhBMUGXJ9DZtU
	kIO7XZ9w==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1swjaZ-00FBA9-0P;
	Fri, 04 Oct 2024 15:47:27 +0100
Date: Fri, 4 Oct 2024 15:47:27 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tpm: Workaround failed command reception on Infineon
 devices
Message-ID: <Zv___74cyROxZSic@earth.li>
References: <Zv1810ZfEBEhybmg@earth.li>
 <Zv19Cc-oTOzv8wVO@earth.li>
 <3c9a6d63-f892-4809-b48d-5fecc3817ad9@linux.ibm.com>
 <979629af-e224-4308-a9a1-c66a60003d2d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979629af-e224-4308-a9a1-c66a60003d2d@linux.ibm.com>

On Thu, Oct 03, 2024 at 06:25:14PM -0400, Stefan Berger wrote:
> On 10/3/24 5:59 PM, Stefan Berger wrote:
> > On 10/2/24 1:04 PM, Jonathan McDowell wrote:
> > > (I'm still in the process of testing this to confirm it fixes the
> > > errata I've seen, but I wanted to send it out for comments to make sure
> > > it's a reasonable approach.)
> > > 
> > > Some Infineon devices have a issue where the status register will get
> > > stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
> > 
> > Did you tell Infineon about it? Maybe they should have a look at their
> > firmware.

I'm in contact with Infineon, and have their errata under NDA.

> > What are the TPMs in your fleet doing? I heared that some TPMs
> > pre-create keys in the background once users requested a few. I would
> > try to create a few primary keys with different combination of key flags
> 
> Actually make this child keys of primary keys:
> 
> > tsscreateprimary
> Handle 80000000
> > while :; do time tsscreate -hp 80000000 -si  -opem pubkey.pem ; cat
> pubkey.pem; done
> 
> This should give a different key every time and maybe key creation time goes
> up at some point...

We're doing a TPM2_CC_CREATE, but as part of a "seal" operation for some
data, rather than full asymmetric key creation. So I don't think this is
likely to be the cause, but it's given me the idea to see if we are
seeing a spike on a particular command - maybe there's something that's
close to the edge on timings that is occasionally going over. Playing
around with bpftrace seems to give useful data so I'll need to
investigate if I can deploy that to do some monitoring.

Our monitoring is running hourly and does the following TPM2
operations (including the in kernel context switching):

TPM2_CC_SELF_TEST
TPM2_CC_GET_CAPABILITY
TPM2_CC_READ_PUBLIC
TPM2_CC_READ_PUBLIC
TPM2_CC_CREATE
TPM2_CC_LOAD
TPM2_CC_CONTEXT_SAVE
TPM2_CC_FLUSH_CONTEXT
TPM2_CC_CONTEXT_LOAD
TPM2_CC_UNSEAL
TPM2_CC_CONTEXT_SAVE
TPM2_CC_FLUSH_CONTEXT
TPM2_CC_CONTEXT_LOAD
TPM2_CC_FLUSH_CONTEXT
TPM2_CC_CONTEXT_SAVE
TPM2_CC_READ_CLOCK
TPM2_CC_GET_CAPABILITY
TPM2_CC_GET_CAPABILITY
TPM2_CC_GET_CAPABILITY
TPM2_CC_GET_CAPABILITY
TPM2_CC_GET_CAPABILITY
TPM2_CC_GET_CAPABILITY
TPM2_CC_READ_PUBLIC

J.

-- 
If I, um, err. Yeah, it probably rounds down. -- Simon Huggins

