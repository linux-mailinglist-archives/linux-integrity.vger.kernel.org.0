Return-Path: <linux-integrity+bounces-7377-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84096BBDDA2
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1DD94E659E
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C687215198;
	Mon,  6 Oct 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsPAJ7ys";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s2opiChT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsPAJ7ys";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s2opiChT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43426A1B5
	for <linux-integrity@vger.kernel.org>; Mon,  6 Oct 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749703; cv=none; b=lhBqwJPsXWMeRSttljVxAKCMeJO2S7YzWSpPHbe9gm7s2C53IoQsvxzbf9dC0Eb1y5lk+U2jau7j1j+wnWppi4k2RgPlLYFrMPJqt42vmADOKeZgGcr364AoNqgMfOMJMb6ErAg/y4BS0OgkjlDJ62ONCo7dlHaQi6NLpFBch+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749703; c=relaxed/simple;
	bh=kSHZR+8eHcwQaQePDD7YJvibHE/CHfX8kxKHGkZkZYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JChHdfnpfI7C21lCWETFINzC93P9bzZM8ktAxhW/3kAy5l0Fo5js3PLjWykAc7F0dM3lh2xTbFarsu2hI2+iPgLqCQ0nQr10KST6p/EppVpyghWa1AgcBxjSGlrcU0nDBhqaaSubjC4wNCOPeJj6dqk+RLVocpyRfIZ5Voc+UWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsPAJ7ys; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s2opiChT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsPAJ7ys; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s2opiChT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CABDE336CB;
	Mon,  6 Oct 2025 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759749699;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
	b=zsPAJ7ysgftxFD33BPMJjUutYtNIRQWe1FiEB80FTLLpKApy9Kk4/lL0d027UbydOTkQu3
	826Q11gXkaiD/L7yka9ozoJdOP+o7gT/xijeJOycdtpXIc9JCCnGsBh8bBaDmkq4suQUo8
	6iq8iSRDp4Mn+CbkfF5jp3T7UXZ22d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759749699;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
	b=s2opiChTsn53RkQRlWMHYj3ya3B6hNEOOtu6I2rP74lDdGVQNQNJp2ASPaaROdpK2JL4nt
	N5C2OpqE8kwnN/AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759749699;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
	b=zsPAJ7ysgftxFD33BPMJjUutYtNIRQWe1FiEB80FTLLpKApy9Kk4/lL0d027UbydOTkQu3
	826Q11gXkaiD/L7yka9ozoJdOP+o7gT/xijeJOycdtpXIc9JCCnGsBh8bBaDmkq4suQUo8
	6iq8iSRDp4Mn+CbkfF5jp3T7UXZ22d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759749699;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q+ErtI1CqcRYiqakYhtu7G5T/Fz9F3egPOIRxFohdCY=;
	b=s2opiChTsn53RkQRlWMHYj3ya3B6hNEOOtu6I2rP74lDdGVQNQNJp2ASPaaROdpK2JL4nt
	N5C2OpqE8kwnN/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E216913700;
	Mon,  6 Oct 2025 11:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n00aKkKm42gJYgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 06 Oct 2025 11:21:38 +0000
Date: Mon, 6 Oct 2025 13:21:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
Message-ID: <20251006112136.GA82874@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
 <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.50

Hi Andrea,

> Hi!

> On Thu Oct 2, 2025 at 10:36 AM CEST, Petr Vorel wrote:
> > This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLICY=y
> > (disabled by default in mainline, therefore disabled for some distros,
> > e.g. openSUSE Tumbleweed), if SUT reboots.

> > The downside is creating user account 4x instead just once.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  runtest/ima                                   |  5 +-
> >  .../integrity/ima/tests/ima_conditionals.sh   | 67 ++++++++++++-------
> >  2 files changed, 47 insertions(+), 25 deletions(-)

> > diff --git a/runtest/ima b/runtest/ima
> > index 01942eefa3..c8d0c6801e 100644
> > --- a/runtest/ima
> > +++ b/runtest/ima
> > @@ -6,5 +6,8 @@ ima_violations ima_violations.sh
> >  ima_keys ima_keys.sh
> >  ima_kexec ima_kexec.sh
> >  ima_selinux ima_selinux.sh
> > -ima_conditionals ima_conditionals.sh
> > +ima_conditionals_uid ima_conditionals.sh -r uid
> > +ima_conditionals_fowner ima_conditionals.sh -r fowner
> > +ima_conditionals_gid ima_conditionals.sh -r gid
> > +ima_conditionals_fgroup ima_conditionals.sh -r fgroup

> Why not using multiple test cases inside the test?

That would not help. I hoped I explained the reason well in the commit message
but obviously I didn't.

verify_measurement() writes into /sys/kernel/security/ima/policy which on
kernels without CONFIG_IMA_WRITE_POLICY requires SUT reboot. Because LTP does
not support any reboot, this needs to be handled after test finishes. That's why
I separated the tests. This helps to cover more than the first test case out of
four.

Kind regards,
Petr

