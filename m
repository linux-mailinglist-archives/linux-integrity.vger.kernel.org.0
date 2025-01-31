Return-Path: <linux-integrity+bounces-4677-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41FDA23E1C
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA13188A12A
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2171C174A;
	Fri, 31 Jan 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1hwAYynK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uku4A+2+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1hwAYynK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uku4A+2+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F841C4A24
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328562; cv=none; b=ZnkPF2vIlAi0UNG8U2sjQdQZcDi0nbB2Q86BCBCHaO9OtxCyBf6iYKqLWa1hN9+VLD55wFKjVY4s1ltkj//nQK7L65N0rren7GZw5ebx12z/qh+Dk7gueqBA0EzFM9E7nvxPUF9EU2wE26e3v4lpSviVYqZHqytqsWE8d+0UEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328562; c=relaxed/simple;
	bh=Nt18X2cICHKaBPXC61PcQo2hbxd9zBuCZZJsi20C3HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHU9E6Dwq/7Efh64XbZgoVV5dmJ0i2FsP3GF+3/ZGhCZlaUE4v6XIpY52x3RDQBaM2HjzLbjWEmQapXWYru3nUrwQ5HjdAPeAeD3YvojF6LaLj4Lo1BgBX1xY/tCZOZuHtd6p/cR+VncSPOd3f9lRKhYAIOJEwd7tNn9Nao/C+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1hwAYynK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uku4A+2+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1hwAYynK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uku4A+2+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7F1621167;
	Fri, 31 Jan 2025 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738328558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAFfjv5GHldSfYyTW02k1rzv9HNvwYLgIhNmhlRFtv8=;
	b=1hwAYynKdTSOuiXpDd8YzQxiEnztoqVKexdJoMY8iIRe4arrRJTn0Hzf7HZiRN/3clbgXa
	elxkH0HR0q9obAWaSWxoq0x1Qqpp7d+QUA/0IB2wphBgVwpnDqRvLB/PYnABvR7sHNWOCq
	wopFg5K11rnxT3plmtLuATht7Yy/vN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738328558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAFfjv5GHldSfYyTW02k1rzv9HNvwYLgIhNmhlRFtv8=;
	b=Uku4A+2+LY7rdFDDRxZ0VLuuMufOjPL8tvn0oVM5/AmFVRG9koTzbPGdPtvhahG7PJXftn
	lQt9JOyUXAx2gcDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738328558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAFfjv5GHldSfYyTW02k1rzv9HNvwYLgIhNmhlRFtv8=;
	b=1hwAYynKdTSOuiXpDd8YzQxiEnztoqVKexdJoMY8iIRe4arrRJTn0Hzf7HZiRN/3clbgXa
	elxkH0HR0q9obAWaSWxoq0x1Qqpp7d+QUA/0IB2wphBgVwpnDqRvLB/PYnABvR7sHNWOCq
	wopFg5K11rnxT3plmtLuATht7Yy/vN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738328558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAFfjv5GHldSfYyTW02k1rzv9HNvwYLgIhNmhlRFtv8=;
	b=Uku4A+2+LY7rdFDDRxZ0VLuuMufOjPL8tvn0oVM5/AmFVRG9koTzbPGdPtvhahG7PJXftn
	lQt9JOyUXAx2gcDg==
Date: Fri, 31 Jan 2025 14:02:37 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz>
 <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org>
 <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, Jan 31, 2025 at 12:25:21PM +0200, Jarkko Sakkinen wrote:
> On Fri Jan 31, 2025 at 10:35 AM EET, Michal Suchánek wrote:
> > Hello,
> >
> > On Fri, Jan 31, 2025 at 01:31:01AM +0200, Jarkko Sakkinen wrote:
> > > On Wed Jan 29, 2025 at 6:02 PM EET, Jonathan McDowell wrote:
> > > > On Wed, Jan 29, 2025 at 04:27:15PM +0100, Michal Suchánek wrote:
> > > > > there is a problem report that booting a specific type of system about
> > > > > 0.1% of the time encrypted volume (using a PCR to release the key) fails
> > > > > to unlock because of TPM operation timeout.
> > > > > 
> > > > > Minimizing the test case failed so far.
> > > > > 
> > > > > For example, booting into text mode as opposed to graphical desktop
> > > > > makes the problem unreproducible.
> > > > > 
> > > > > The test is done with a frankenkernel that has TPM drivers about on par
> > > > > with Linux 6.4 but using actual Linux 6.4 the problem is not
> > > > > reproducible, either.
> > > > > 
> > > > > However, given the problem takes up to a day to reproduce I do not have
> > > > > much confidence in the negative results.
> > > >
> > > > So. We see what look like similar timeouts in our fleet, but I haven't
> > > > managed to produce a reliable test case that gives me any confidence
> > > > about what the cause is.
> > > >
> > > > https://lore.kernel.org/linux-integrity/Zv1810ZfEBEhybmg@earth.li/
> > > >
> > > > for my previous post about this.
> > > 
> > > Ugh, this was my first week at new job, sorry.
> > > 
> > > 2000 ms is like a spec value, which can be a bad idea. Please look at
> > > Table 18.
> > > 
> > > My guess is that GUI makes more stuff happening in the system, which
> > > could make latencies more shaky.
> > > 
> > > The most trivial candidate would be:
> > > 
> > > 	status = tpm_tis_status(chip);
> > > 	if ((status & TPM_STS_COMMAND_READY) == 0) {
> > > 		tpm_tis_ready(chip);
> > > 		if (wait_for_tpm_stat
> > > 		    (chip, TPM_STS_COMMAND_READY, TPM_TIS_TIMEOUT_MAX /* e.g. 2250 ms */,
> >
> > 2250 is more than the measured 2226 but I have no idea if that's random
> > or in some way deterministic.
> 
> Your text vs GUI at least gives evidence of stochasticity while not a
> full-fledged proof. You can expect e.g. more IRQs happening when you
> run a GUI. I did not engineer that number. You could e.g. double the
> original number. The whole framework for timeout_b is ridiculous (if
> it is because of me it does not change that fact).

It looks like the timeout_b is used exclusively as the ready timeout *),
with various sources of the value depending on chip type.

Then increasing it should not cause any problem other than the kernel
waiting longer when the TPM chip is really stuck.

* There is one instance of use of timeout_b for TPM_STS_VALID in
st33zp24_pm_resume.

> Or perhaps we could consider even  wait_event_interruptible() inside
> wait_for_tpm_stat(), since it is interruptible.

It seems to be already interruptible, at least the implementation in
tpm_tis_core. There is another one in xenfront, and a few more
wait_for_stat() without _tpm_ in the middle.

Thanks

Michal

