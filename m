Return-Path: <linux-integrity+bounces-4667-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C9A221A4
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1063A3788
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D81D1DF268;
	Wed, 29 Jan 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMbLAl6q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oLQWFuEG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMbLAl6q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oLQWFuEG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622DD183CCA
	for <linux-integrity@vger.kernel.org>; Wed, 29 Jan 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167638; cv=none; b=Ub14z3cNymFwBpJX+/9UWQQhixjTmqrmb+XzjdM08Bvs4s1bz82VgWudzJPpjwpbKkvxEh2Slci3oIOA8Zg+b1SHyHKofPd3jqIyqtdtFxD19zqdvCfKuK2Y1NA5Dolf79xRmN6SP7RrytGgGhlXkB3VMYuqWopSR4pCzdBTsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167638; c=relaxed/simple;
	bh=J9VQxlyVYIUU+Tg3oyRRQKJvK7dtpFpAfY8dQ6tTiRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbFyQ/1Wmzx5+E2rKt4P4ZzWBr95dScloSrMCR0zzt/tSgO4KDdKzKuby5xFaD8EJl4S52PjINejX1lBoSkvSLE0jx//IAQJk7xCQEairDxFjyMvucDUSns7CUDsH5m/xBeC4DNuOMxT3LiIzCG7Gh5klDK9U74oT5gPaPPR/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMbLAl6q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oLQWFuEG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMbLAl6q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oLQWFuEG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B18F210F9;
	Wed, 29 Jan 2025 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738167634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef+xNogFwvcLIat6rR/7A3m3526D0lmFFOI/HTLki9g=;
	b=oMbLAl6qwwuVP1MbykvdxekcwaKZOlUhU53blhJPnjdYKabPc7ualbdEPghttOGjsvJtP4
	albvAfy5mR+Y6SSGz0cxdLV1j0rxS6MiBz5IXQo8PH81H3feIncjCGTzxcml+aHs8SKpsD
	3JyED4A7sv9ZszM8rqspLnUFh4giY2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738167634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef+xNogFwvcLIat6rR/7A3m3526D0lmFFOI/HTLki9g=;
	b=oLQWFuEGeiqOlzdkN7BCQwtghJt3Kmbks0j+TyCimmInYu5HdcDA9CAgVb9p1GpHdvoyBC
	zgOSgBvspjQD+WAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738167634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef+xNogFwvcLIat6rR/7A3m3526D0lmFFOI/HTLki9g=;
	b=oMbLAl6qwwuVP1MbykvdxekcwaKZOlUhU53blhJPnjdYKabPc7ualbdEPghttOGjsvJtP4
	albvAfy5mR+Y6SSGz0cxdLV1j0rxS6MiBz5IXQo8PH81H3feIncjCGTzxcml+aHs8SKpsD
	3JyED4A7sv9ZszM8rqspLnUFh4giY2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738167634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef+xNogFwvcLIat6rR/7A3m3526D0lmFFOI/HTLki9g=;
	b=oLQWFuEGeiqOlzdkN7BCQwtghJt3Kmbks0j+TyCimmInYu5HdcDA9CAgVb9p1GpHdvoyBC
	zgOSgBvspjQD+WAg==
Date: Wed, 29 Jan 2025 17:20:33 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z5pVUd0jpzmbtc0u@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5pRKcZKc3FUzP8Q@earth.li>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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

On Wed, Jan 29, 2025 at 04:02:49PM +0000, Jonathan McDowell wrote:
> On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
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
> So. We see what look like similar timeouts in our fleet, but I haven't
> managed to produce a reliable test case that gives me any confidence
> about what the cause is.
> 
> https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/
> 
> for my previous post about this.

I see that's basically the same as the test patch I used:


The time it takes for the TPM to become ready can exceed timeout_b

Jan 28 07:09:21 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
Jan 28 07:09:21 localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)
---
 drivers/char/tpm/tpm_tis_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..c7a794a448af 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -432,19 +432,29 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	u32 ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 	int rc, status, burstcnt;
 	size_t count = 0;
 	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
+	unsigned long start, timed_out;
 
 	status = tpm_tis_status(chip);
 	if ((status & TPM_STS_COMMAND_READY) == 0) {
 		tpm_tis_ready(chip);
+		timed_out = 0; start = jiffies;
+retry_ready:
 		if (wait_for_tpm_stat
 		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
 		     &priv->int_queue, false) < 0) {
+			if (timed_out++ < 5) {
+				dev_err(&chip->dev, "%s: %u: ready: Timed out (%u of %u ms)\n", __func__, ordinal, jiffies_to_msecs(jiffies - start), jiffies_to_msecs(chip->timeout_b));
+				goto retry_ready;
+			}
 			rc = -ETIME;
 			goto out_err;
 		}
+		if (timed_out)
+			dev_err(&chip->dev, "%s: %u: ready: Took (%u of %u ms)\n", __func__, ordinal, jiffies_to_msecs(jiffies - start), jiffies_to_msecs(chip->timeout_b));
 	}
 
 	while (count < len - 1) {


> 
> > With some instrumentation it was determined that the problem happens
> > here:
> 
> > static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
> > {
> > 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> > 	int rc, status, burstcnt;
> > 	size_t count = 0;
> > 	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
> > 
> > 	status = tpm_tis_status(chip);
> > 	if ((status & TPM_STS_COMMAND_READY) == 0) {
> > 		tpm_tis_ready(chip);
> > 		if (wait_for_tpm_stat
> > 		    (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
> > 		     &priv->int_queue, false) < 0) {
> > >>>			rc = -ETIME;
> > 			goto out_err;
> > 		}
> > 	}
> 
> > localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Timed out (2236 of 2000 ms)
> > localhost kernel: tpm tpm0: tpm_tis_send_data: 353: ready: Took (2236 of 2000 ms)
> 
> Can you track down the actual command that's taking the time? Though I
> guess that's the previous command rather than the one that hits the
> timeout.

Yes, 353 is supposed to be the command but it's likely the previous one
that is causing the problem.

I suppose this could be expanded to use a static variable to also save
the last command.

Thanks

Michal

