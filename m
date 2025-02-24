Return-Path: <linux-integrity+bounces-4979-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDD9A41FDF
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 14:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703E11897EB6
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Feb 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9462571CF;
	Mon, 24 Feb 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DOHR4tR5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LQkJXmk9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DOHR4tR5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LQkJXmk9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1623BCF1
	for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402260; cv=none; b=a7PCOOChzy9V8skN1ydhtzY7ZThoUTrcfZpJbWgdPdZqHAdTuB2r8BJnh/uY7OG4johdzloS3LXvYv5GhgFRubghMPN2yCdTco5A/xxMrtGJXiU0x/vi2rob6JbcUEk6PzQYZJEiXTb/HlCIqszK0D8MXfHP3aXN/WMHHU/i6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402260; c=relaxed/simple;
	bh=fTW5hIxZH5YHwcB1JdRZ95L54P59EkD+vI0g5WmVwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/rDqPTiWobBAkLYlh/XmSJDhzbTnfy+49prLcXG9H8lv4GzBDq1qbrfEAfaqkgu2IIZ5OTrWgHBCiuVFZB9PHPLndvbkaNqWsH3f76uhiIa75UXl00leItzQQGOTwUpunhRUtF9N64rGk2cKzVp0E1D7b2uSYhR6BuDFVGECmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DOHR4tR5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LQkJXmk9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DOHR4tR5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LQkJXmk9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8940721160;
	Mon, 24 Feb 2025 13:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740402254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myw9BRrgcFmFM3jNrSTL3JEoldx1RAedZntnQy7o7kM=;
	b=DOHR4tR5/rWLwZRL1oNJ/7PFou/Anw6+05fhbkPdOmRXKJFQIMjykM4WHoJ2SdOjeAxB46
	Apz0HtpJDBiN+dMwVFMhe6vYhxuRDavJ6YoWXzs9H+79tpwCs2FrxxGJ52xD/72MSqthKs
	QwFQisCKu0U2fTQYVkEvJ7hYaYrLj4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740402254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myw9BRrgcFmFM3jNrSTL3JEoldx1RAedZntnQy7o7kM=;
	b=LQkJXmk9zL090SaXrsEwV68rncqRe2A4/h3dzf9359rKniEX5dnZUnJA4vzdf1egX0YTdw
	KOft0QYZgeTki0Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740402254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myw9BRrgcFmFM3jNrSTL3JEoldx1RAedZntnQy7o7kM=;
	b=DOHR4tR5/rWLwZRL1oNJ/7PFou/Anw6+05fhbkPdOmRXKJFQIMjykM4WHoJ2SdOjeAxB46
	Apz0HtpJDBiN+dMwVFMhe6vYhxuRDavJ6YoWXzs9H+79tpwCs2FrxxGJ52xD/72MSqthKs
	QwFQisCKu0U2fTQYVkEvJ7hYaYrLj4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740402254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Myw9BRrgcFmFM3jNrSTL3JEoldx1RAedZntnQy7o7kM=;
	b=LQkJXmk9zL090SaXrsEwV68rncqRe2A4/h3dzf9359rKniEX5dnZUnJA4vzdf1egX0YTdw
	KOft0QYZgeTki0Bg==
Date: Mon, 24 Feb 2025 14:04:13 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z7xuTRrJqeSDH4hR@kitsune.suse.cz>
References: <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6e-w2YT6hFOyFiP@kernel.org>
 <Z6om1DIcDW3b0fAh@earth.li>
 <D7OY20MS7TAI.3N7Z569U7SH0N@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7OY20MS7TAI.3N7Z569U7SH0N@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
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

On Mon, Feb 10, 2025 at 07:32:53PM +0200, Jarkko Sakkinen wrote:
> On Mon Feb 10, 2025 at 6:18 PM EET, Jonathan McDowell wrote:
> > Who then handles the ERESTARTSYS though? Part of the issues we've seen
> > is the failure happens in a context save or load, which is all within
> > the kernel rather than directly under the control of userspace. I'm
> > guessing the HMAC changes are likely to hit similar problems. I think
> > some level of timeout improvement in tpm_transmit is appropriate, if we
> > can work out what it should be.
> 
> Right I get what you mean, not all transmits initiate from syscalls
> And obviously this can happen without hmac too with tpmrm0.
> 
> Hmm... so I'm open for a patch that radically simplifies the state
> change timeouts, i.e. sort of part of that old patch.

There is also another aspect to this:

What happens when the context save/load result is dropped on the floor?

There was other call that can take a very long time: get random number.
And while dropping a random number that took a long time ito fabricate
on the floor is wasteful it does not cause any real problem.

With the context save/load, however, the context state gets
desynchronized between TPM and kernel when the result of the call is
ignored.

If the kernel cannot correct the state by examining return value from
later calls the TPM can effectively become defunct because the kernel
will call the wrong context operation, it will return unexpected value
which the kernel interprets as failure, and no operation can be
performed.

Thanks

Michal

