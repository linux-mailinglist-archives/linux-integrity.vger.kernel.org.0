Return-Path: <linux-integrity+bounces-4920-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D1A3D384
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 09:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834A93BE559
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 08:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B9E1EC013;
	Thu, 20 Feb 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LsBUPQnE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L/BEZCbb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LsBUPQnE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L/BEZCbb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4211EB1A3
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040952; cv=none; b=h6KpNTwkBlEenFYb5P+KWQxmSUK/f9Hwm+M3KHHK0v3Wfq83Wv4jL2c5bK6aH/Jh24eXk3sfk2YJOvI5N4xfx02LHXen7varuckZM+33xzmTuNlXkMLPGFNsYDIkPFEkWrXEL5Ohb/aCRNfMr1ukY5xnJtCFL96dppydQPCd6UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040952; c=relaxed/simple;
	bh=qjC/srhwwIvVHn6AB2jCGVtmxBvwIO3qB4lRbyVen5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur/I9aetVhDQYj8logn+LSBTBT9gt/+DGE9SJYRpxQQGTX2HZnv1WzVrMMschFCuuRyr124iKED78EMm7qna1vnbcB/A1defCNVVVedbKWcSPDTy4GeZS7j9msbq8V3pfj6CRwZ2S2oX2gmwN2gYlfKJSna4euNl4kXzrL3+IIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LsBUPQnE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L/BEZCbb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LsBUPQnE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L/BEZCbb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 332202119B;
	Thu, 20 Feb 2025 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740040949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzqB6tpikG3GpnR1rHDcQdf722/ZsNniFG8RGVvkBQ8=;
	b=LsBUPQnEp2nOTZ84jcuR9jDP/v8SKz7OAuXBWXFrvU/MSYoLQtH4a7HTcvdDYL31XLNzE8
	61tGoNYR+zfQMhIBHN8TsANvqZdcUJ6hpac4sl3rfW3EFignUgczAQg2YVsj8sJK28ed9u
	UH4Ew+AFARvbNZV4PafXxMIgu/N2t8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740040949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzqB6tpikG3GpnR1rHDcQdf722/ZsNniFG8RGVvkBQ8=;
	b=L/BEZCbbF4PV/YYG5vsbjbWgsVy/vSssG4USTZeUlzOMHEl8p2TXfvxZB8mJg2OkRQEzPz
	VyZlw4R5yRKAgMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740040949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzqB6tpikG3GpnR1rHDcQdf722/ZsNniFG8RGVvkBQ8=;
	b=LsBUPQnEp2nOTZ84jcuR9jDP/v8SKz7OAuXBWXFrvU/MSYoLQtH4a7HTcvdDYL31XLNzE8
	61tGoNYR+zfQMhIBHN8TsANvqZdcUJ6hpac4sl3rfW3EFignUgczAQg2YVsj8sJK28ed9u
	UH4Ew+AFARvbNZV4PafXxMIgu/N2t8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740040949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzqB6tpikG3GpnR1rHDcQdf722/ZsNniFG8RGVvkBQ8=;
	b=L/BEZCbbF4PV/YYG5vsbjbWgsVy/vSssG4USTZeUlzOMHEl8p2TXfvxZB8mJg2OkRQEzPz
	VyZlw4R5yRKAgMDw==
Date: Thu, 20 Feb 2025 09:42:28 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z7bq9H2KZARM90A4@kitsune.suse.cz>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

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

Thanks for looking into this

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

What would be the priv->timeout_min and priv->timeout_max here?

Note that there are timeouts that are 200ms, and are overblown by 2s.

If the 200ms timeout relies on the sleep during the wait for the timeout
being much longer than the timeout itself then the timeout is arguably
bogus regardless of this change helping.

Thanks

Michal

>  		status = chip->ops->status(chip);
>  		if ((status & mask) == mask)
>  			return 0;
> -		usleep_range(priv->timeout_min,
> -			     priv->timeout_max);
>  	} while (time_before(jiffies, stop));
>  	return -ETIME;
>  }

