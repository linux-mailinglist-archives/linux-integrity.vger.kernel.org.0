Return-Path: <linux-integrity+bounces-4742-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC17A2BFD7
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455DB3AABDF
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10621A23A9;
	Fri,  7 Feb 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="MGAkZ0O2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6032C8B
	for <linux-integrity@vger.kernel.org>; Fri,  7 Feb 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921638; cv=none; b=VDg3V+YA4e1PV7ifUYTK/yC6YsL8sAvVgHR02OxoQ0F4zejkjTKKkDwwJrsNyCGukbDtcwBys9Aydm4WNGWajyIYt/KpTRMwXtvXciExXYePPVXXs03OoYC6y7NHendutuMFR8Wpo/mWFXzUjZhk5LAnnmWGrATSpr7Jyx7L4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921638; c=relaxed/simple;
	bh=2X850YN/HWe1XCtG6cdNzfRbqN334XXBCNXZnnLXhHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdYOqhYcHnJAx6ZE85fpWOlwR1ZyyIcvh0gG0b6CzN/El4sdLCAHHpOV+wA7lXqLqlxZH6pUp/39MlNsADqZ1/w5wuG7GyzLPVufdKzFFyYQjEJsGkWtY3owxg0+PvnCe6+vdl5jpNCtBGJS3znNjCRe1I31wXQ0ZIJyfqtK7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=MGAkZ0O2; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yQpL1CjoQMk+cOczBZ964DqanMBDf/+4Bu/8ZJWctLg=; b=MGAkZ0O28AKA+D30K7E5QaRifU
	xyVX3v9bxGlLNiYj2ygnxHAkN47eLx0AsmXvt+66YRNVQyIpkukWetQJPKJTGHu7MqBb0QvikzEoj
	Y72y2/4E35bHM+Qo10ghIxZ5UuwkSo+shESSqkJrZX3XpviE+OsXYK86xPH7AInXFu4SlchPZlMrK
	EfdwSppuIrLvs3Pj+rGxYLjJ2aV5FYWlMV5qcXsfdSXUZnbu6WLR++kFxoHKsTJ0ZygbI7k54J4ma
	dt+bS8kK12F6AqLg0EMbZpW+hREJII2h9nOqopUfsRvXoRvtSdZrvII5f/BnmQGon2loPE9z7pmAC
	o3pVLPIg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tgKx7-004EHu-1E;
	Fri, 07 Feb 2025 09:47:13 +0000
Date: Fri, 7 Feb 2025 09:47:13 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6XWoWAy66P97pAU@earth.li>
References: <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
 <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6XVAEfLIVDuwSLn@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6XVAEfLIVDuwSLn@kitsune.suse.cz>

On Fri, Feb 07, 2025 at 10:40:16AM +0100, Michal Suchánek wrote:
> On Fri, Feb 07, 2025 at 09:26:16AM +0000, Jonathan McDowell wrote:
> > So just to clarify, this more recent patch is working around a situation
> > where the status register gets stuck and needs a complete retry of the
> > command send - it's an Infineon errata, not something that would be
> > fixed with a longer timeout.
> > 
> > We see what looks like Michal's issue with timeouts as well, I just
> > haven't made the step of instrumenting it all the way he has.
> 
> And I haven't seen the issue that needs re-sending the command so far.

Your SLB9672 is on the latest firmware, which I believe fixes the
problem.

> Maybe it happens even less frequently than the excessive processing
> time.
> 
> Fully restarting the syscall would fix both issues but manual restart of
> the userspace task reportedly did not work so I have my doubts that
> this method with returning from the syscall would be effective.

Hmmm. I wonder if e3aaebcbb7c6b403416f442d1de70d437ce313a7 (tpm: Clean
up TPM space after command failure) would help the userspace restart
work. We saw problems with the timeouts affecting the kernel doing the
cleanup of the transient handles, meaning we'd then run out of transient
slots in the TPM.

If you can reproduce the problem then

tpm2_getcap -T device:/dev/tpm0 handles-transient

will show if that is the case - if it doesn't output anything this isn't
what you're hitting.

J.

-- 
Inside every living person there's a dead person trying to get out.

