Return-Path: <linux-integrity+bounces-4590-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F92A15BE3
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 09:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D297C3A5D60
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84417557C;
	Sat, 18 Jan 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="akDkK/6Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F63cTdNg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jC0I36Rq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BP9GwlPZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB918755C;
	Sat, 18 Jan 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737187800; cv=none; b=pdSYQAXAGzMdRlqeIU57LYudHk0zLyMQIAH69DnFyQCbyWUijL8jFehbra5mSCI/4MCHcglc5BR4F1GS2Y4RJtSIOCP+p3px/h51cm0NejF9IpdDcHVPvXPtA7jMgEjFLSx1PbBNR0VcdbPYz2mQ06JuSdXOWe80KzVC/t+URKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737187800; c=relaxed/simple;
	bh=/PwI819s7MAs8b0UkBEP+hP8yB4jiZUIkHX1srR18pU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvOb7/MCy2V3UuvfIIJYsP6UGiM6DBpmXQEuOn/ApHGGRZBQlPhfRzcb6qpAy/Dz10a/ZtmgmkguebHCKWFGxAR1ZtKO96CpXYD2JfM3y8xBavJDZpPug//xvqijveIzMN80FJZrs8w5ZnJp6fcWWEUa/hy+BNwQezhUQzB+fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=akDkK/6Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F63cTdNg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jC0I36Rq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BP9GwlPZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C826B1F37C;
	Sat, 18 Jan 2025 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737187796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGNDBQ2g3QKXJPlPEoy4i5y1A3UQsqJSzOITIfq7is=;
	b=akDkK/6Yxh0b2GNTeNwFcsX4TGPaRfJ5RCuMrBC5ZeH9uhOSbytbR0i1VKHHPVoIThhZBr
	5DhuOJrQ1OJWBSEyaqwGlmhcjfBJuxSG5VYkELzBQCCvAEhaN75I/ft7EfD7iKlMzyIUtK
	1eoRs3nhYMDZmPWG6w8G+sdQisqbuHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737187796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGNDBQ2g3QKXJPlPEoy4i5y1A3UQsqJSzOITIfq7is=;
	b=F63cTdNg5ejNH7AmwMkn1x1eKWZRGHH4V8Ly1u6fZ51yHMkyGsvytSF+xP6jGzNK1Bkihw
	V56l8Sb1X+Gg4IAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jC0I36Rq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BP9GwlPZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737187795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGNDBQ2g3QKXJPlPEoy4i5y1A3UQsqJSzOITIfq7is=;
	b=jC0I36RqWK6xnoDIX6knNPLw5L2ZQOnSfdGCpFyHdfkLHsPAWTWrp1nCbSl4BkIqJ+aGTB
	4nZH4gCsgJF94zlD7x+D9NYRFlrtqnvNkdzAiJg+tppK4V54UQFgpaLF1O+Fg+KyO5r7lE
	a852wDjn8mkE1DxKdYGWf4XfgOxM8Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737187795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfGNDBQ2g3QKXJPlPEoy4i5y1A3UQsqJSzOITIfq7is=;
	b=BP9GwlPZEdBrb27dNnEIBnhThoRUmrCN5twfFnDJxigAMoXevCMCbfqGcXQC3FNhhphT31
	gS8G/Hz21o2lxsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 656061373B;
	Sat, 18 Jan 2025 08:09:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k5SCF9Nhi2cEVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 18 Jan 2025 08:09:55 +0000
Date: Sat, 18 Jan 2025 09:09:54 +0100
Message-ID: <87v7ucr19p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	<linux-integrity@vger.kernel.org>,
	"Peter Huewe" <peterhuewe@gmx.de>,
	"Jason Gunthorpe" <jgg@ziepe.ca>,
	"Colin Ian King"
 <colin.i.king@gmail.com>,
	"Stefan Berger" <stefanb@us.ibm.com>,
	"Reiner Sailer" <sailer@us.ibm.com>,
	"Seiji Munetoh" <munetoh@jp.ibm.com>,
	"Andrew Morton" <akpm@osdl.org>,
	"Kylene Jo Hall" <kjhall@us.ibm.com>,
	"Ard Biesheuvel" <ardb@kernel.org>,
	<stable@vger.kernel.org>,
	"Andy Liang"
 <andy.liang@hpe.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] tpm: Map the ACPI provided event log
In-Reply-To: <D74SJ1CDKZRF.A6XC66V9UT1U@kernel.org>
References: <20250115224315.482487-1-jarkko@kernel.org>
	<87cyglsjdh.wl-tiwai@suse.de>
	<D74DJJTER7IQ.3KT9ECIRLN0JW@kernel.org>
	<878qr9shga.wl-tiwai@suse.de>
	<D74SJ1CDKZRF.A6XC66V9UT1U@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C826B1F37C
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,gmx.de,ziepe.ca,gmail.com,us.ibm.com,jp.ibm.com,osdl.org,kernel.org,hpe.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 18 Jan 2025 01:59:41 +0100,
Jarkko Sakkinen wrote:
> 
> On Fri Jan 17, 2025 at 3:22 PM EET, Takashi Iwai wrote:
> > On Fri, 17 Jan 2025 14:15:05 +0100,
> > Jarkko Sakkinen wrote:
> > > 
> > > On Fri Jan 17, 2025 at 2:41 PM EET, Takashi Iwai wrote:
> > > > On Wed, 15 Jan 2025 23:42:56 +0100,
> > > > Jarkko Sakkinen wrote:
> > > > > 
> > > > > The following failure was reported:
> > > > > 
> > > > > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
> > > > > [   10.848132][    T1] ------------[ cut here ]------------
> > > > > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> > > > > [   10.862827][    T1] Modules linked in:
> > > > > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> > > > > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> > > > > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > > > > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> > > > > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > > > > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
> > > > > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0
> > > > > 
> > > > > Above shows that ACPI pointed a 16 MiB buffer for the log events because
> > > > > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> > > > > bug with kvmalloc() and devm_add_action_or_reset().
> > > > > 
> > > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > Cc: stable@vger.kernel.org # v2.6.16+
> > > > > Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> > > > > Reported-by: Andy Liang <andy.liang@hpe.com>
> > > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > >
> > > > One of my previous review comments overlooked?
> > > > The subject line still doesn't match with the actual code change.
> > > 
> > > True, thanks for catching this.
> > > 
> > > >
> > > > I guess "Map the ACPI provided event log" is meant for another patch,
> > > > not for this fix.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/
> > > 
> > > I edited also the description a bit. Does this make more sense to you
> > > now? (also denote any additonal possible tags)
> >
> > Yes, looks good.  Thanks!
> 
> Can I add your reviewd-by? Just asking so that tags will be what is
> expected.

Sure!

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

