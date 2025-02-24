Return-Path: <linux-integrity+bounces-4978-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E3A41FBF
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 13:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5477AAC9C
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C1323BCEC;
	Mon, 24 Feb 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K8nDdlky";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9CBt95DT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K8nDdlky";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9CBt95DT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A510F2
	for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401821; cv=none; b=L5tIOUkxkAbEgyY/bfeUcVaC40LNB/8futp6ttNtXHfYABr4PrKlHnIFLFxyBP9Orh785PHH2d6X0uc5xw+ec5qUNy5SrizKSahvpMuv+Neko37y3XBz7FMiv611TlLGhtk91G0T0gVGegIwIp8btBrCAP0+aZ4pFAq4M0eSSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401821; c=relaxed/simple;
	bh=Qi+6IffEsW2XH37KmPVkJSyuPy7OscH3+qeBcOeVUlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaNtRB3X7BMgcBQXQmV+gtInXNuCHldtTO1kt+cJcyqbiw/vtbI8mMtdnhCezLaXWJbzXRjhNl8p1YAQTB1Nt812bEQWN8RkWUrz9LaYxdlt5PBFb7sBx70aIlSUKyos1GvrjY8YPyPGBARatQQYTLkyeguCpwC4f30TXqBRWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K8nDdlky; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9CBt95DT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K8nDdlky; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9CBt95DT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E4D71F385;
	Mon, 24 Feb 2025 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740401817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu+2kvg1XqrnBOsg4xOqB46UVAkwtYC/QfLw8kpYKXA=;
	b=K8nDdlkyQO8vbWtX0qXP5CIVx4GnGe2YcliIuCjS2i/kPu1bUzMbCQdwEMolHImRjz3wk1
	kwVtTVq58H7+5ro1B1pY+7JMKH/G6AkkfyXNQM87lokTazfqhFh2EmTYr67zStXn3fts+5
	/H1AOfwwoE6KDgcQORp7hVjUCY9hI3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740401817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu+2kvg1XqrnBOsg4xOqB46UVAkwtYC/QfLw8kpYKXA=;
	b=9CBt95DTNbZPjvQ0F76BtpIwWVGiTZxohL70x8LjcalFpJmM7F63i19ZCIuPKcKa7j8pPF
	XRLY2QJGXqTR9LBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740401817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu+2kvg1XqrnBOsg4xOqB46UVAkwtYC/QfLw8kpYKXA=;
	b=K8nDdlkyQO8vbWtX0qXP5CIVx4GnGe2YcliIuCjS2i/kPu1bUzMbCQdwEMolHImRjz3wk1
	kwVtTVq58H7+5ro1B1pY+7JMKH/G6AkkfyXNQM87lokTazfqhFh2EmTYr67zStXn3fts+5
	/H1AOfwwoE6KDgcQORp7hVjUCY9hI3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740401817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu+2kvg1XqrnBOsg4xOqB46UVAkwtYC/QfLw8kpYKXA=;
	b=9CBt95DTNbZPjvQ0F76BtpIwWVGiTZxohL70x8LjcalFpJmM7F63i19ZCIuPKcKa7j8pPF
	XRLY2QJGXqTR9LBA==
Date: Mon, 24 Feb 2025 13:56:56 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z7xsmNq0kEj0cHco@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z7ZbWcLK0Iajd_D9@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7ZbWcLK0Iajd_D9@earth.li>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 19, 2025 at 10:29:45PM +0000, Jonathan McDowell wrote:
> On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> > Hello,
> > 
> > there is a problem report that booting a specific type of system about
> > 0.1% of the time encrypted volume (using a PCR to release the key) fails
> > to unlock because of TPM operation timeout.
> > 
> > Minimizing the test case failed so far.
> > 
> > For example, booting into text mode as opposed to graphical desktop
> > makes the problem unreproducible.
> > 
> > The test is done with a frankenkernel that has TPM drivers about on par
> > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > reproducible, either.
> > 
> > However, given the problem takes up to a day to reproduce I do not have
> > much confidence in the negative results.
> 
> Michal, can you possibly try the below and see if it helps out? There
> seems to be a timing bug introduced in 6.4+ that I think might be
> related, and matches up with some of our internal metrics that showed an
> increase in timeouts in 6.4 onwards.
> 
> commit 79041fba797d0fe907e227012767f56dd93fac32
> Author: Jonathan McDowell <noodles@meta.com>
> Date:   Wed Feb 19 16:20:44 2025 -0600
> 
>     tpm, tpm_tis: Fix timeout handling when waiting for TPM status
>     
>     The change to only use interrupts to handle supported status changes,
>     then switch to polling for the rest, inverted the status test and sleep
>     such that we can end up sleeping beyond our timeout and not actually
>     checking the status. This can result in spurious TPM timeouts,
>     especially on a more loaded system. Fix by switching the order back so
>     we sleep *then* check. We've done a up front check when we enter the
>     function so this won't cause an additional delay when the status is
>     already what we're looking for.
>     
>     Cc: stable@vger.kernel.org # v6.4+
>     Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
>     Signed-off-by: Jonathan McDowell <noodles@meta.com>

Reviewed-by: Michal Suchánek <msuchanek@suse.de>

Thanks

> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..167d71747666 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -114,11 +114,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		return 0;
>  	/* process status changes without irq support */
>  	do {
> +		usleep_range(priv->timeout_min,
> +			     priv->timeout_max);
>  		status = chip->ops->status(chip);
>  		if ((status & mask) == mask)
>  			return 0;
> -		usleep_range(priv->timeout_min,
> -			     priv->timeout_max);
>  	} while (time_before(jiffies, stop));
>  	return -ETIME;
>  }

