Return-Path: <linux-integrity+bounces-4765-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BDA2F306
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 17:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0B3167760
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279D2580CD;
	Mon, 10 Feb 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="OhiVzOSv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AEE2580D2
	for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204313; cv=none; b=TGXgXdWl+TqC9vgJflH6ZQ+FGf95XSOJ98T9vkSRd3TvS8rd/1Ta070fLox3BaDGFrDWTvwxD/Nf+X197bBP7eRVixSmhxHcbrqFknhdlNuTq2OCPNfLAzQzKDC+v7A4FOgo3NN3Ggh3L/VMkOfdvyoOPrbHz0D6nuKcQL1RbNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204313; c=relaxed/simple;
	bh=zsmUPWlGlrf7GDvnyD96lECDCFrUt2SctWcAXQleX3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9abIka6r9MXOqCBJwTZ32GBQcx/jHZ/a3fNLGQ/tkdpnhWJRSf6XlwcofWiUdqhPPOa2unT+A3ra2MO+Tsqe6spplxzBWrwB2Pd4j4W99d/owCD+OzbQ0kb9XLHyu0KWCQJ7/AHC6T2i/3dNIXtC9H7BPT6OnSgvSYdQ41dV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=OhiVzOSv; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XDdwWAAseJUcHKWBeKTsVDSZpfQYAMOpIv0hGNGCvP4=; b=OhiVzOSvpiFJzVYZ5dL1xCXaXi
	kSclBPs/iZGGnv7jxKc2HrqSPIPXZRM4EvXaTf/mOtHDgelW+lAv/HNfYAIC77dUvO5ii/sQpdfDp
	uNl8LAh+4mvqTVNsc/NNKyvLrLwsfaybJvXz+KUdswX/Wr4k6J6ykjFGvMBIvMrbCt3A/4VVu7mp4
	DDWPGnB19tgb44typfzNS9MGmSKFvy8fUkrDJJNYJFeTL5fnt3RddyysK+XitwQyaEvVShfNlUhav
	eB4DGlsIqmtqSFt75QShy98pTLHF0uFHdex8l3ZNT/imxsTkT7/hfRBrqJxFrPtwfQQRV4aiPJvzr
	jNjus6GA==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1thWUO-001rwU-15;
	Mon, 10 Feb 2025 16:18:28 +0000
Date: Mon, 10 Feb 2025 16:18:28 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6om1DIcDW3b0fAh@earth.li>
References: <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6e-w2YT6hFOyFiP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6e-w2YT6hFOyFiP@kernel.org>

On Sat, Feb 08, 2025 at 10:29:55PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 07, 2025 at 09:26:16AM +0000, Jonathan McDowell wrote:
> > > The whole arithmetic with timeout_a/b/c is mostly gibberish and could
> > > be replaced with a single "max" constant without issues (just set it
> > > large enough).
> > > 
> > > They could be all be replaced with let's say 3s timeout in a constant.
> > 
> > This appears to have come up before:
> > 
> > https://lore.kernel.org/linux-integrity/358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com/
> > 
> > That patch was deemed overly complex and it was suggested to split it
> > up; I can't find any indication that was ever done which I guess is why
> > the discussion died off.
> 
> Looking back I suggest splitting timeouts and durations into separate
> patches:
> 
> https://lore.kernel.org/linux-integrity/20190312145553.GB6682@linux.intel.com/

Yup, that seems to be where it all died out from what I could find.

> > So just to clarify, this more recent patch is working around a situation
> > where the status register gets stuck and needs a complete retry of the
> > command send - it's an Infineon errata, not something that would be
> > fixed with a longer timeout.
> 
> Hmm... please shout if I ignore something but if we could -ERESTARTSYS
> semantics here that should ignite completely new transmit flow, wouldn't
> it?

Who then handles the ERESTARTSYS though? Part of the issues we've seen
is the failure happens in a context save or load, which is all within
the kernel rather than directly under the control of userspace. I'm
guessing the HMAC changes are likely to hit similar problems. I think
some level of timeout improvement in tpm_transmit is appropriate, if we
can work out what it should be.

Likewise for the Infineon errata I think an internal retry makes sense,
because it could happen for a number of internally generated kernel
reasons as well as a userspace sent command.

J.

-- 
How I wish, how I wish you were here.

