Return-Path: <linux-integrity+bounces-4670-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D296DA222ED
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176FE18841BC
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF451DFE31;
	Wed, 29 Jan 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jyinDufo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PEid9Lzj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jyinDufo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PEid9Lzj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D01E0DE2
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171513; cv=none; b=B406pmRB6iaoJIOrRFGRlBLoQgwE+HcfnARY3Y7No/fyouD5iT/W7O+HCuTXgY90agFwtbbr8JKFWA4IeJcbElB8yxHgGqBi8KvzLghNgVhlr/rAeYJGJtgfnvzspYXgQv22HORK1eykpNg3bCiKvG0h1okzwCp0oC+JH4nEG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171513; c=relaxed/simple;
	bh=MsZkvATezkndO5aKavRTTOyxrHAHCt3egfJYVQaeLMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiqoBjcX63nooy5sXRJiHkV7yGqk99NNl7mFMpblxNvSQ3rdTppr8EOWBYdRJ4AXxksrTBUd8xy0mp3lOrtEIC+SdFXQdYTvsKpaKI7SQkrYqV66G00jADPgn32BK1Gji7kjsYM/WskAFxCql6Ew0v+GlWIiVt6ErZ0CTbU/J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jyinDufo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PEid9Lzj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jyinDufo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PEid9Lzj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B00721101;
	Wed, 29 Jan 2025 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738171509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Fb2X38Lms6ziRsUgXHFTHgO4J5DfvcBzx/eucQglI=;
	b=jyinDufo/HnAQ6ECKcaj44kfXkC9+CbLiAzJm4MMsNpeSP4+chimI+zdPHxSf8Ih7t9u/9
	YI+NThvnFEc4pxxDVMXdRMvh2R7hCQYfmeFMdlHX+rrOxJCra6q3QRjNUSIS5uvIPSEre3
	GZ3Q5ewh52xdv80mwO1AloUOOTq0Bn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738171509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Fb2X38Lms6ziRsUgXHFTHgO4J5DfvcBzx/eucQglI=;
	b=PEid9LzjOhXDQjqNKc+R4e8lHQEQoaNH3KYbunaqBjgfl2poxdvBLxYkBUpAkpYKiw+6J2
	9LYst10KLcF7U0AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738171509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Fb2X38Lms6ziRsUgXHFTHgO4J5DfvcBzx/eucQglI=;
	b=jyinDufo/HnAQ6ECKcaj44kfXkC9+CbLiAzJm4MMsNpeSP4+chimI+zdPHxSf8Ih7t9u/9
	YI+NThvnFEc4pxxDVMXdRMvh2R7hCQYfmeFMdlHX+rrOxJCra6q3QRjNUSIS5uvIPSEre3
	GZ3Q5ewh52xdv80mwO1AloUOOTq0Bn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738171509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Fb2X38Lms6ziRsUgXHFTHgO4J5DfvcBzx/eucQglI=;
	b=PEid9LzjOhXDQjqNKc+R4e8lHQEQoaNH3KYbunaqBjgfl2poxdvBLxYkBUpAkpYKiw+6J2
	9LYst10KLcF7U0AQ==
Date: Wed, 29 Jan 2025 18:25:07 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z5pkc8nAfMm2Ox0U@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
 <Z5pVUd0jpzmbtc0u@kitsune.suse.cz>
 <Z5ph-ntScQo2QgSC@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5ph-ntScQo2QgSC@earth.li>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Jan 29, 2025 at 05:14:34PM +0000, Jonathan McDowell wrote:
> On Wed, Jan 29, 2025 at 05:20:33PM +0100, Michal Suchánek wrote:
> > On Wed, Jan 29, 2025 at 04:02:49PM +0000, Jonathan McDowell wrote:
> > > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
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
> > > So. We see what look like similar timeouts in our fleet, but I haven't
> > > managed to produce a reliable test case that gives me any confidence
> > > about what the cause is.
> > > 
> > > https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/
> > > 
> > > for my previous post about this.
> > 
> > I see that's basically the same as the test patch I used:
> > 
> > The time it takes for the TPM to become ready can exceed timeout_b
> > 
> > Jan 28 07:09:21 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
> > Jan 28 07:09:21 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)
> 
> Does it always complete immediately after the retry? Have you tried a
> longer value (eg timeout_b * 2) and confirmed that makes the issue go
> away?

No idea. I Initially put 10000 retries there and given it succeeded in
120% of the original timeout I cut the retries to 5 and promoted it to
'production ready' workaround.

I have only this one result with the patch applied available so far.

> 
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> > index fdef214b9f6b..c7a794a448af 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -432,19 +432,29 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> >  static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> >  {
> >  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > +	u32 ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> >  	int rc, status, burstcnt;
> >  	size_t count = 0;
> >  	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
> > +	unsigned long start, timed_out;
> >  
> >  	status = tpm_tis_status(chip);
> >  	if ((status & TPM_STS_COMMAND_READY) == 0) {
> >  		tpm_tis_ready(chip);
> > +		timed_out = 0; start = jiffies;
> > +retry_ready:
> >  		if (wait_for_tpm_stat
> >  		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> >  		     &priv->int_queue, false) < 0) {
> > +			if (timed_out++ < 5) {
> > +				dev_err(&chip->dev, "%s: %u: ready: Timed out (%u of %u ms)\n", __func__, ordinal, jiffies_to_msecs(jiffies - start), jiffies_to_msecs(chip->timeout_b));
> > +				goto retry_ready;
> > +			}
> >  			rc = -ETIME;
> >  			goto out_err;
> >  		}
> > +		if (timed_out)
> > +			dev_err(&chip->dev, "%s: %u: ready: Took (%u of %u ms)\n", __func__, ordinal, jiffies_to_msecs(jiffies - start), jiffies_to_msecs(chip->timeout_b));
> >  	}
> >  
> >  	while (count < len - 1) {
> > 
> > 
> > > 
> > > > With some instrumentation it was determined that the problem happens
> > > > here:
> > > 
> > > > static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> > > > {
> > > > 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > > > 	int rc, status, burstcnt;
> > > > 	size_t count = 0;
> > > > 	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
> > > > 
> > > > 	status = tpm_tis_status(chip);
> > > > 	if ((status & TPM_STS_COMMAND_READY) == 0) {
> > > > 		tpm_tis_ready(chip);
> > > > 		if (wait_for_tpm_stat
> > > > 		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> > > > 		     &priv->int_queue, false) < 0) {
> > > > >>>			rc = -ETIME;
> > > > 			goto out_err;
> > > > 		}
> > > > 	}
> > > 
> > > > localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
> > > > localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)
> > > 
> > > Can you track down the actual command that's taking the time? Though I
> > > guess that's the previous command rather than the one that hits the
> > > timeout.
> > 
> > Yes, 353 is supposed to be the command but it's likely the previous one
> > that is causing the problem.
> 
> So TPM2_CC_CONTEXT_LOAD. I'm assuming you're using /dev/tpmrm0, so
> that's the start of a fresh "load context, execute command, save
> context" cycle. I'd expect the previous command to be the
> TPM2_CC_CONTEXT_SAVE from the previous cycle.

That would agree with your previous result of not getting the problem
when using /dev/tpm0 instead.

Thanks

Michal

