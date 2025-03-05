Return-Path: <linux-integrity+bounces-5111-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6706A4FE86
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 13:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684947A28E3
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 12:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CE230BC6;
	Wed,  5 Mar 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GYvNmeQ1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8rAoP5kk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GYvNmeQ1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8rAoP5kk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF61FCF4F
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177250; cv=none; b=Wsj1F1/lYKcl3/4/ylXmWg3kbd5bjdHW9SfsXorKK9esCF8uR2bGQfX9BA0dfiOcGdem9/QwAH5J74v3RjHulR7Z713+ZnRy7XJ/cakFj6kTE1vAAGg5trxVlK3989ioJB+96QZfDnWl68EnQdBfwE36QqfsugYiuYdRFFbt2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177250; c=relaxed/simple;
	bh=mVIto/5sXcVnxGV6qeHSfhLuK4tyAi0Y9yKN7vWUsW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+AKBtIGXrhicTIT42PmjZqaJmy52Z/jTigPKDLZxss4M3hggghKlyg8nCiDsDBltQ/CLcLXx/NWz/CGn3bXcjV93DMt5oYFDaxg9kED0aRIuqA0oNeyeGsVTiKiiheOhOChVWzk0O29+2J2qTXGUvOYTxV5DceQxO+i4gyV8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GYvNmeQ1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8rAoP5kk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GYvNmeQ1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8rAoP5kk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99E361F455;
	Wed,  5 Mar 2025 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741177246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5JY2uzQaJXY8PfSkV9Q03+ERxsQxwLcI23w1cGvCI0=;
	b=GYvNmeQ1aDkPl03KP2VsrS/Y6JRovBILnUL89pQkVOsLv86i4U3SPw3r/3wxM7yhjKDH9r
	QZSCEy8mjJ3IxbvraZQFCQcfwvTQ6ufMLcf/U8YWMdyCKkByDABTgbcruxCMTF0PGBkRly
	/hZ31KCdNmPpksjT6GAuEkMOgwvUhoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741177246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5JY2uzQaJXY8PfSkV9Q03+ERxsQxwLcI23w1cGvCI0=;
	b=8rAoP5kkWe2LOGD/vwk4datVTB8Yk5VvKjN5ASPUwOI0KG0r0yucAFQKlQ8cm+UBwtF6Y0
	Wlmcfh/9VQnyZtCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741177246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5JY2uzQaJXY8PfSkV9Q03+ERxsQxwLcI23w1cGvCI0=;
	b=GYvNmeQ1aDkPl03KP2VsrS/Y6JRovBILnUL89pQkVOsLv86i4U3SPw3r/3wxM7yhjKDH9r
	QZSCEy8mjJ3IxbvraZQFCQcfwvTQ6ufMLcf/U8YWMdyCKkByDABTgbcruxCMTF0PGBkRly
	/hZ31KCdNmPpksjT6GAuEkMOgwvUhoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741177246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5JY2uzQaJXY8PfSkV9Q03+ERxsQxwLcI23w1cGvCI0=;
	b=8rAoP5kkWe2LOGD/vwk4datVTB8Yk5VvKjN5ASPUwOI0KG0r0yucAFQKlQ8cm+UBwtF6Y0
	Wlmcfh/9VQnyZtCA==
Date: Wed, 5 Mar 2025 13:20:45 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org
Subject: Re: TPM operation times out (very rarely)
Message-ID: <Z8hBnRzD-M2pR-pw@kitsune.suse.cz>
References: <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz>
 <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org>
 <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6e-w2YT6hFOyFiP@kernel.org>
 <Z6om1DIcDW3b0fAh@earth.li>
 <D7OY20MS7TAI.3N7Z569U7SH0N@kernel.org>
 <Z7xuTRrJqeSDH4hR@kitsune.suse.cz>
 <Z8JtQ4qKSjKsJZ52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8JtQ4qKSjKsJZ52@kernel.org>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Mar 01, 2025 at 04:13:23AM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 24, 2025 at 02:04:13PM +0100, Michal Suchánek wrote:
> > On Mon, Feb 10, 2025 at 07:32:53PM +0200, Jarkko Sakkinen wrote:
> > > On Mon Feb 10, 2025 at 6:18 PM EET, Jonathan McDowell wrote:
> > > > Who then handles the ERESTARTSYS though? Part of the issues we've seen
> > > > is the failure happens in a context save or load, which is all within
> > > > the kernel rather than directly under the control of userspace. I'm
> > > > guessing the HMAC changes are likely to hit similar problems. I think
> > > > some level of timeout improvement in tpm_transmit is appropriate, if we
> > > > can work out what it should be.
> > > 
> > > Right I get what you mean, not all transmits initiate from syscalls
> > > And obviously this can happen without hmac too with tpmrm0.
> > > 
> > > Hmm... so I'm open for a patch that radically simplifies the state
> > > change timeouts, i.e. sort of part of that old patch.
> > 
> > There is also another aspect to this:
> > 
> > What happens when the context save/load result is dropped on the floor?
> 
> Trying to understand what are you meaning by this. Are you speaking
> about scenario where after the operation context operations fail
> inside kernel?

I am speaking about the scenario when the opration succeeds but the
kernel declares it a failure because it did not happen within the
timeout.

Thanks

Michal

