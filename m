Return-Path: <linux-integrity+bounces-4743-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45780A2C006
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 10:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8797A02CF
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4EA185B5F;
	Fri,  7 Feb 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Nn7qHr5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Aox7tjCu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Nn7qHr5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Aox7tjCu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C8192D77
	for <linux-integrity@vger.kernel.org>; Fri,  7 Feb 2025 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922306; cv=none; b=VK+UCrIQls5fZ+fXZ2Zqd3UGBzXetBp8n2Wd7+mNBsfYmjB78Xd1qvZMqAzOUmqwuokFofzaG1FOmOEBjVmWXxrBADrRu7HzmXh3zj7IyrE3RL2ojc2SVFxnT1Xl+fhpWc8TCpIrMxweddCMUW5ijBGPobEfKbsUzjR7oPS8APQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922306; c=relaxed/simple;
	bh=AItD+4aEAikeWvTjvEUDPzLMSGEUUOjjbuSJSNXr59w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2JiLuMGkfojsLNlBw0d7JlBtL5n4IoEAXOiKc3t8s6B8tl80nlD/oODijFNPnJeKTsZbZ42Ud2EJbrViZOCTiSjFEnI3Ay4PpHxneRfqpX89OQb46ayp0by0h2qehtx9djvmceF89XEpBJdyCOO2N5h6nW/PtI10FRcLvrpiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Nn7qHr5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Aox7tjCu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Nn7qHr5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Aox7tjCu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC17A1F443;
	Fri,  7 Feb 2025 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738922296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3S/T5AoRz2hsnRgMuIqWQOCxbA4KeIe2nc0Y27NseE=;
	b=2Nn7qHr5c6n5tIfVn3wTzSdViTZdU27QnDLg7ZCJ+1LzqyIDJfbL3rnRr5/YHIgRep92p0
	PGW7OMGk2ljma6H5RNuN5YuT/RHuezgRd25Rp+okcm1AjfmbGtqVnbzi4tbiKbr59mA7MN
	CKcc7rkeE7dusHamY3wwQwuNdgjmlxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738922296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3S/T5AoRz2hsnRgMuIqWQOCxbA4KeIe2nc0Y27NseE=;
	b=Aox7tjCuUDSZSxfDxuqXpns1p4rrqBh9MpaUXhT08rSLP8x1+IwCd0akHdX+uaUjQdB+pN
	In23d8J96+i8J6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738922296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3S/T5AoRz2hsnRgMuIqWQOCxbA4KeIe2nc0Y27NseE=;
	b=2Nn7qHr5c6n5tIfVn3wTzSdViTZdU27QnDLg7ZCJ+1LzqyIDJfbL3rnRr5/YHIgRep92p0
	PGW7OMGk2ljma6H5RNuN5YuT/RHuezgRd25Rp+okcm1AjfmbGtqVnbzi4tbiKbr59mA7MN
	CKcc7rkeE7dusHamY3wwQwuNdgjmlxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738922296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3S/T5AoRz2hsnRgMuIqWQOCxbA4KeIe2nc0Y27NseE=;
	b=Aox7tjCuUDSZSxfDxuqXpns1p4rrqBh9MpaUXhT08rSLP8x1+IwCd0akHdX+uaUjQdB+pN
	In23d8J96+i8J6BA==
Date: Fri, 7 Feb 2025 10:58:15 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jonathan McDowell <noodles@earth.li>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z6XZN3U5nmb6qu9u@kitsune.suse.cz>
References: <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz>
 <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6XVAEfLIVDuwSLn@kitsune.suse.cz>
 <Z6XWoWAy66P97pAU@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6XWoWAy66P97pAU@earth.li>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 07, 2025 at 09:47:13AM +0000, Jonathan McDowell wrote:
> On Fri, Feb 07, 2025 at 10:40:16AM +0100, Michal Suchánek wrote:
> > On Fri, Feb 07, 2025 at 09:26:16AM +0000, Jonathan McDowell wrote:
> > > So just to clarify, this more recent patch is working around a situation
> > > where the status register gets stuck and needs a complete retry of the
> > > command send - it's an Infineon errata, not something that would be
> > > fixed with a longer timeout.
> > > 
> > > We see what looks like Michal's issue with timeouts as well, I just
> > > haven't made the step of instrumenting it all the way he has.
> > 
> > And I haven't seen the issue that needs re-sending the command so far.
> 
> Your SLB9672 is on the latest firmware, which I believe fixes the
> problem.
> 
> > Maybe it happens even less frequently than the excessive processing
> > time.
> > 
> > Fully restarting the syscall would fix both issues but manual restart of
> > the userspace task reportedly did not work so I have my doubts that
> > this method with returning from the syscall would be effective.
> 
> Hmmm. I wonder if e3aaebcbb7c6b403416f442d1de70d437ce313a7 (tpm: Clean
> up TPM space after command failure) would help the userspace restart

It's backported to the frankenkernel already so it would not help this
particular case.

Unfortunately, it's not clear what the userspace task does, and why it
would not complete after the first failure.

Would need to come up with some way of tracing it.

Thanks

Michal

