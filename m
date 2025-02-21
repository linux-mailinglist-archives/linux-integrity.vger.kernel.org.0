Return-Path: <linux-integrity+bounces-4960-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE42EA3F4A8
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 13:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CADE3BB11B
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77D20B7E0;
	Fri, 21 Feb 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="w9myXRtd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3920B7EC
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141895; cv=none; b=LFLlV/TQAmGBcqERCoh6j0qneLkTzZXrhlV1cSKnX1aug0JMvYSlCbRZVzF3E3A2c/JvTIJUtCAN1hb6vgXr5xCpttsS6xJT/hgzoeTW9fKL5SExeCwJRt0PG1tIg0pa4JSTcJqcP8KF4xkORP5PhLYkl8nnHGB6PTsgy7wU6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141895; c=relaxed/simple;
	bh=YH3DfKyZQmBGQaHjbZkUgpuEgzUH9t2yIxIuNTEqccM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuTDtFU2X9+XhxDvL8w5lMocnocgc3kZUppv4kSNzLsuHtDa0zEKop6UDSGf/BwkjuSTZri8kktxStzx/gHKvJhe93nJ6FSEIdb8Giv/AhsJ7DUgBgShcQPFFt2FY6IOuK9F7Uf8SWkAPVM2T6/ReWdjaQDFZfju7+nLhWcYOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=w9myXRtd; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ITIH1z7VdJORrZcahTK1+yysYF1lf8Xm+JOKcdRGQzE=; b=w9myXRtdhYqm62BM7mBl7PpeZX
	PHwJiFppW500FrvJSHH9BJ2QqgmfzjP4XqkG5VMZ5ORZhyTIolpRfHeCO834CQjDuD3/1479v7AkW
	fxbi8B6UpXwSfPwOJSWIhpvsX8JOPbtX4w6rEDmp/zI+Jtm2olQplIJC/QX/4D26ZIChzOweHuBY3
	FobZwYBtmFUKH8scLDcE1uR/UURkRVwUAD+rYD3qx5QtOGRWAkl3vCgjLJMg7P409iABPEXcPc/D7
	EF4tfTaPaM4oZNLpuN9Po6kfw1RTIPkM50SUf20NXhnEpl6uoO9TW5MbWET7Xc9sPTKUJYWamY0tY
	VyUtnrMQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tlSOb-00Dqhq-3A;
	Fri, 21 Feb 2025 12:44:46 +0000
Date: Fri, 21 Feb 2025 12:44:45 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z7h1PYOcqK2lHvLq@earth.li>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z7ZbWcLK0Iajd_D9@earth.li>
 <Z7bq9H2KZARM90A4@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7bq9H2KZARM90A4@kitsune.suse.cz>

On Thu, Feb 20, 2025 at 09:42:28AM +0100, Michal Suchánek wrote:
> On Wed, Feb 19, 2025 at 10:29:45PM +0000, Jonathan McDowell wrote:
> > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> > > Hello,
> > > 
> > > there is a problem report that booting a specific type of system about
> > > 0.1% of the time encrypted volume (using a PCR to release the key) fails
> > > to unlock because of TPM operation timeout.
> > > 
> > > Minimizing the test case failed so far.
> > > 
> > > For example, booting into text mode as opposed to graphical desktop
> > > makes the problem unreproducible.
> > > 
> > > The test is done with a frankenkernel that has TPM drivers about on par
> > > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > > reproducible, either.
> > > 
> > > However, given the problem takes up to a day to reproduce I do not have
> > > much confidence in the negative results.
> > 
> > Michal, can you possibly try the below and see if it helps out? There
> > seems to be a timing bug introduced in 6.4+ that I think might be
> > related, and matches up with some of our internal metrics that showed an
> > increase in timeouts in 6.4 onwards.
> 
> Thanks for looking into this

No problem. It's something we've seen in our fleet and I've been trying
to get to the bottom of, so having some additional data from someone
else is really helpful.

> > commit 79041fba797d0fe907e227012767f56dd93fac32
> > Author: Jonathan McDowell <noodles@meta.com>
> > Date:   Wed Feb 19 16:20:44 2025 -0600
> > 
> >     tpm, tpm_tis: Fix timeout handling when waiting for TPM status
> >     
> >     The change to only use interrupts to handle supported status changes,
> >     then switch to polling for the rest, inverted the status test and sleep
> >     such that we can end up sleeping beyond our timeout and not actually
> >     checking the status. This can result in spurious TPM timeouts,
> >     especially on a more loaded system. Fix by switching the order back so
> >     we sleep *then* check. We've done a up front check when we enter the
> >     function so this won't cause an additional delay when the status is
> >     already what we're looking for.
> >     
> >     Cc: stable@vger.kernel.org # v6.4+
> >     Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
> >     Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index fdef214b9f6b..167d71747666 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -114,11 +114,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> >  		return 0;
> >  	/* process status changes without irq support */
> >  	do {
> > +		usleep_range(priv->timeout_min,
> > +			     priv->timeout_max);
> 
> What would be the priv->timeout_min and priv->timeout_max here?
> 
> Note that there are timeouts that are 200ms, and are overblown by 2s.
> 
> If the 200ms timeout relies on the sleep during the wait for the timeout
> being much longer than the timeout itself then the timeout is arguably
> bogus regardless of this change helping.

Ah, I thought your major issue was the 2s timeout that was only slightly
exceeded.

However in my initial tracing I've seen wait_for_tpm_stat take much
longer than the timeout that's passed in, which is what caused me to go
and investigate this code path and note it had been changed in 6.4. It
seems like a bug either way, but I've been at the TCG meeting this week
and not had time to do further instrumentation and confirmation. Given
you seem to have a more reliable reproducer I thought it might be easy
enough for you to see if it made any difference.

J.

-- 
Why do I get the feeling I'm going to regret this?

