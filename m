Return-Path: <linux-integrity+bounces-4977-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7404DA41EF4
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 13:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD6E423B6E
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 12:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074D221F12;
	Mon, 24 Feb 2025 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KwEf0HJ/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qnEcewtt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yiLhzZ/4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tPuIB6Fz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072F219300
	for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2025 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399713; cv=none; b=qVz9dvvpphzBgtiIIJhRBhciUEyPHqIlMp41Mp71r6WDurOXvW6AeeO5Hl9t2B6SoBbsoeHGj1SvjuM7Zz4y/ozHU9deBFaKfpDuA+0q4nox6WUelMP2/4vtWJtav3yGhu9JyvNrwv9ICQKfHiKu0xIukgTh0YLfzGy9M1rhBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399713; c=relaxed/simple;
	bh=Xg5w9NafeEyq9ldTTXzdAzBsXkf90j/KDGh5AUJkXGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6QKwd0L4mcNtZKt/EbErhH8IWCmnA5140ikH5wRqNyt+6Rtozt2S0orHPhbq0qnOtTDbFww03t7CCXkA5C4tNNpeNriUsIiYB9jKcViRPVFNsaOyu3NOAbk/nGLfmJG5v/HbKH7EiYRHYwL3ATIGmO3PsmgMzJx0/EmF7CfheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KwEf0HJ/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qnEcewtt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yiLhzZ/4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tPuIB6Fz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7CA52116F;
	Mon, 24 Feb 2025 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740399710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJY12wQIuxf4x7FmCt8Vgu0PjjqF37tRRGikflEPO2g=;
	b=KwEf0HJ/66wBiKK8A/cWDUwjhSttEQND6jDb3LH2d5m7iouLNKOYlReYyclDINEwwwlm1H
	s642tGoAGMHyjDN8XNAw0bTt55jazL1h5OSBkNqxz9+L8ZXUIHF3+9hqVfXiH9ZEtpGumn
	40R1gEvZiBUEa2rpfo9Vw1LWpud7zok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740399710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJY12wQIuxf4x7FmCt8Vgu0PjjqF37tRRGikflEPO2g=;
	b=qnEcewttxymOvSorwha8xfqlWOxQ5iHwTS8C9++dQXxvTz32JjP77/Mx1IIGvGqtJ+hj9/
	T2KA8iYcEFOa7/CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740399709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJY12wQIuxf4x7FmCt8Vgu0PjjqF37tRRGikflEPO2g=;
	b=yiLhzZ/42m8zD9duWzCi1WDwQu8Pi9fD4/3/AWZp/xxpacs3GyvcI30PaKhCX7M3iUnIKh
	1IoAlkRxi73+/2IdlEgn043ph5VnKEQ5MPBZl8Y29rvrWl7eo6JPKjhnNzbjp16hWjRlEp
	b1U+kZlX6n58JqVWS7ZcLJgQiiVqB8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740399709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJY12wQIuxf4x7FmCt8Vgu0PjjqF37tRRGikflEPO2g=;
	b=tPuIB6Fzqht0Z68TLPrRbYXHd6FHr1N+45z66VI4G1ufhVta5umoKOGE1i+3bR2hVV1Y19
	XW0eBtrvpxYPV6AA==
Date: Mon, 24 Feb 2025 13:21:48 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z7xkXAMy4vrUrQce@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z7ZbWcLK0Iajd_D9@earth.li>
 <Z7bq9H2KZARM90A4@kitsune.suse.cz>
 <Z7h1PYOcqK2lHvLq@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7h1PYOcqK2lHvLq@earth.li>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 21, 2025 at 12:44:45PM +0000, Jonathan McDowell wrote:
> On Thu, Feb 20, 2025 at 09:42:28AM +0100, Michal Suchánek wrote:
> > On Wed, Feb 19, 2025 at 10:29:45PM +0000, Jonathan McDowell wrote:
> > > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> > > > Hello,
> > > > 
> > > > there is a problem report that booting a specific type of system about
> > > > 0.1% of the time encrypted volume (using a PCR to release the key) fails
> > > > to unlock because of TPM operation timeout.
> > > > 
> > > > Minimizing the test case failed so far.
> > > > 
> > > > For example, booting into text mode as opposed to graphical desktop
> > > > makes the problem unreproducible.
> > > > 
> > > > The test is done with a frankenkernel that has TPM drivers about on par
> > > > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > > > reproducible, either.
> > > > 
> > > > However, given the problem takes up to a day to reproduce I do not have
> > > > much confidence in the negative results.
> > > 
> > > Michal, can you possibly try the below and see if it helps out? There
> > > seems to be a timing bug introduced in 6.4+ that I think might be
> > > related, and matches up with some of our internal metrics that showed an
> > > increase in timeouts in 6.4 onwards.
> > 
> > Thanks for looking into this
> 
> No problem. It's something we've seen in our fleet and I've been trying
> to get to the bottom of, so having some additional data from someone
> else is really helpful.
> 
> > > commit 79041fba797d0fe907e227012767f56dd93fac32
> > > Author: Jonathan McDowell <noodles@meta.com>
> > > Date:   Wed Feb 19 16:20:44 2025 -0600
> > > 
> > >     tpm, tpm_tis: Fix timeout handling when waiting for TPM status
> > >     
> > >     The change to only use interrupts to handle supported status changes,
> > >     then switch to polling for the rest, inverted the status test and sleep
> > >     such that we can end up sleeping beyond our timeout and not actually
> > >     checking the status. This can result in spurious TPM timeouts,
> > >     especially on a more loaded system. Fix by switching the order back so
> > >     we sleep *then* check. We've done a up front check when we enter the
> > >     function so this won't cause an additional delay when the status is
> > >     already what we're looking for.
> > >     
> > >     Cc: stable@vger.kernel.org # v6.4+
> > >     Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
> > >     Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > > 
> > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > > index fdef214b9f6b..167d71747666 100644
> > > --- a/drivers/char/tpm/tpm_tis_core.c
> > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > @@ -114,11 +114,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> > >  		return 0;
> > >  	/* process status changes without irq support */
> > >  	do {
> > > +		usleep_range(priv->timeout_min,
> > > +			     priv->timeout_max);
> > 
> > What would be the priv->timeout_min and priv->timeout_max here?
> > 
> > Note that there are timeouts that are 200ms, and are overblown by 2s.
> > 
> > If the 200ms timeout relies on the sleep during the wait for the timeout
> > being much longer than the timeout itself then the timeout is arguably
> > bogus regardless of this change helping.
> 
> Ah, I thought your major issue was the 2s timeout that was only slightly
> exceeded.
> 
> However in my initial tracing I've seen wait_for_tpm_stat take much
> longer than the timeout that's passed in, which is what caused me to go
> and investigate this code path and note it had been changed in 6.4. It
> seems like a bug either way, but I've been at the TCG meeting this week
> and not had time to do further instrumentation and confirmation. Given
> you seem to have a more reliable reproducer I thought it might be easy
> enough for you to see if it made any difference.

The problem is no longer reproducible, probably due to some other hcange
in the test environment. So much for reliable reproducer.

Yes, I think this is a bug either way and should be addressed although
the effect on this problem is minor at best.

Thanks

Michal

