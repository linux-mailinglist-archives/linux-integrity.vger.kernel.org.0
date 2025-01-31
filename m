Return-Path: <linux-integrity+bounces-4673-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C68F5A23AB9
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 09:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F97A3D5E
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC4EED8;
	Fri, 31 Jan 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0wq5yWCD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5UkbpJnD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w9YZ+z9I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m2OSBHAP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0E15667D
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312550; cv=none; b=BfeH4nneOqyCYHIYJxLujz0JnjOc6k+4oX1kbaSif4yMwA+7LckeW8uH7wPxN3JUnCfVEKTH1v7WxXhSnnSvXqXnzdWXJeVjQfX3zW3sdHGDCfzeCIVJmAL0AsIzr/nK25Lht1qBxvvsOV9dlxJM6l/k3sB30SGiy8jAozwJakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312550; c=relaxed/simple;
	bh=Ep1FHwa6FbBUbz72J+5xaiubmfF8qaN5UpydGBJdH5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad6azBTV2OCwqUmq6kYgqYp+2hBamPzXQ4BWOG/n/mIueMP6E+sF9Yg4bA8kRiDWm04lCkYtripw5y4FbPAIcenYtBuuyZsduul3QwH/HgDf5nwuEjnYl9H7bizyGMno/OrXGasKDeJzEsRHJBiC23ZHllSulSTEiFvbmSWnjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0wq5yWCD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5UkbpJnD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w9YZ+z9I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m2OSBHAP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDA662116C;
	Fri, 31 Jan 2025 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738312547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsSd+unac3H7b3HMEmS71hYlaPFrvtmwGibDMyi/MYA=;
	b=0wq5yWCDY+QgxSTlS/92/2TzYqIGuyrh6QaovB1aH64omEeWiXsRYyKrFxsLXpKWVZbpR+
	v0Rs/+EHYzqrMsJriunqdjS/2uHxeDatEKeMGPPlh+t5uz+sSfWX9M0CXWQnW8BBDBpbQN
	Uu9rTVTN9p3pMZ19o+66nwZT7jl9ep8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738312547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsSd+unac3H7b3HMEmS71hYlaPFrvtmwGibDMyi/MYA=;
	b=5UkbpJnDFue+UBSg3+hlSd4keGFbqFwB6uD5UD2uOiXGjouAe8vuDJyffVlf+7nkIYdOQn
	QuLH/5EztzIW3EBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738312546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsSd+unac3H7b3HMEmS71hYlaPFrvtmwGibDMyi/MYA=;
	b=w9YZ+z9ImOBBKOI3Aei+Sn4wPfwzOYal2CnADxVDkIXjmqKea/vrgIFYcrFatIsODIDnhA
	AEDmi2GHloccoaFqP0lXwDdbmVDcvTOqzMl2xxm+MSQLXoZsdzQE57OdT9gEBYims8fTmq
	TdL/NW/PdYixnGfgQMs5rR0xQs9ka9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738312546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsSd+unac3H7b3HMEmS71hYlaPFrvtmwGibDMyi/MYA=;
	b=m2OSBHAPMQOQpWdkjR0HXsAwet6MxkFGP87HGqqYF/dSi4uOKoqzsCkKhF6IYueIwsRrSs
	vIIvlEE1FCIlPsCg==
Date: Fri, 31 Jan 2025 09:35:45 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_WP_URI(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hello,

On Fri, Jan 31, 2025 at 01:31:01AM +0200, Jarkko Sakkinen wrote:
> On Wed Jan 29, 2025 at 6:02 PM EET, Jonathan McDowell wrote:
> > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
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
> > So. We see what look like similar timeouts in our fleet, but I haven't
> > managed to produce a reliable test case that gives me any confidence
> > about what the cause is.
> >
> > https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/
> >
> > for my previous post about this.
> 
> Ugh, this was my first week at new job, sorry.
> 
> 2000 ms is like a spec value, which can be a bad idea. Please look at
> Table 18.
> 
> My guess is that GUI makes more stuff happening in the system, which
> could make latencies more shaky.
> 
> The most trivial candidate would be:
> 
> 	status = tpm_tis_status(chip);
> 	if ((status & TPM_STS_COMMAND_READY) == 0) {
> 		tpm_tis_ready(chip);
> 		if (wait_for_tpm_stat
> 		    (chip, TPM_STS_COMMAND_READY, TPM_TIS_TIMEOUT_MAX /* e.g. 2250 ms */,

2250 is more than the measured 2226 but I have no idea if that's random
or in some way deterministic.

> 		     &priv->int_queue, false) < 0) {
> 		     	rc = -ETIME;
> 			goto out_err;
> 		}
> 	}
> 
> On the other hand, for me tpm_tis_send_main() looked initially weird:
> 
> 	for (try = 0; try < TPM_RETRY; try++) {
> 		rc = tpm_tis_send_data(chip, buf, len);
> 		if (rc >= 0)
> 			/* Data transfer done successfully */
> 			break;
> 		else if (rc != -EIO)
> 			/* Data transfer failed, not recoverable */
> 			return rc;
> 	}
> 
> I.e. no retry on -ETIME.
> 
> But I'd fixup instead tpm_common_write():
> 
> out:
> 	mutex_unlock(&priv->buffer_mutex);
> 
> 	if (ret == -ETIME)
> 		return -ERESTARTSYS;
> 
> 	return ret;
> }
> 
> It still can be interrupted by a signal this way. Retry loop would
> block too much.

Not sure if this would help. As was noted in the discussion so far if
the value is consumed by the kernel it will likely not retry in the
upper layer code.

Also restarting the userspace cryptsetup service reportedly did not help
addressing the problem which suggests that the consumer is indeed the
kernel, and it marked something as defunct and gave up on getting the
key from the TPM entirely.

Also the loop can already block for up to 2s. If blocking in the loop is
a problem then it should be addressed in that loop.

Thanks

Michal

> 
> Not sure if only the increase in timeout value would be enough or
> should the both sites be fixed up.
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p05p_r14_pub.pdf
> 
> BR, Jarkko

