Return-Path: <linux-integrity+bounces-4581-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D42A1506B
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 14:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D41164B09
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A311FF60A;
	Fri, 17 Jan 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PCpQgCKP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NsGlBXML";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uAOWqiT6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GGqHApG/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB41FCCEE;
	Fri, 17 Jan 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120169; cv=none; b=LRGIcdGOssszPgr9L70UNta+7ugT9f6qSMIWbdBd/jWIxSXh9BMZAGVHW9u2pJC1YB9TY4WYyVS0WI9lDn/2hpkZcWACICzT6LzQaTuu9fuQ2VIlMuYnLGSiwO9ipWQXy7UW5tHgIHsqvXvz+oqq+onxNECO9y1aPLXeWDlqjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120169; c=relaxed/simple;
	bh=Hi6+UXzNjN1M7TKHAq6QV9LqViDoyf3NlUbmvmMGHig=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdlbrpFnffMkdTewtkZoHho9iABlxYbt5d4OuoT3iOx7goRWq/eux/yoKhy5xvxAXIV1CqycsFMdQ5L1J4bX12z7/KxAyJc0IctS/97pG249PcY5iBm0KN8ZDHKsY8tcfO3JVgBIeUA/FH3wB/JKLmFOYqMCHsSc9VB8upXX3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PCpQgCKP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NsGlBXML; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uAOWqiT6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GGqHApG/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9D851F38F;
	Fri, 17 Jan 2025 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737120166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hnx6LIBUeP6NEc/J9B3bi4AxvEmsHeIqCQoKy/mxHls=;
	b=PCpQgCKPSk8kfwgcFUGRS++iL7O0G3GgxXy+5+ijZ16Cf0V2nDkX67gtoo4lBktcopNC/s
	n8K/kX+gc+tr7B4+efMB9iEIRmRYDUMY+Nn3X2Vps48Qo2kygKZ5HRNCG0AizRSFe4t4BW
	3vvpBe2ouScDKGiLsaUyBubFswYg46g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737120166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hnx6LIBUeP6NEc/J9B3bi4AxvEmsHeIqCQoKy/mxHls=;
	b=NsGlBXML/VWm9LqhzYk4o2p0X6xRBBz6zcXVy7XhIhEGVxWsn/w+/nrW9piuoKM2kofKCo
	W/WlQMjEnKj8t1Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uAOWqiT6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="GGqHApG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737120165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hnx6LIBUeP6NEc/J9B3bi4AxvEmsHeIqCQoKy/mxHls=;
	b=uAOWqiT6VuluviNER/baCQ9kL8JlIfsLKZMt34nBR1F/xe9Djjj6n0BkM/YKfHf5VXtttn
	iK6wHvf+D4mJRT0CwMD3dgCH901vf7ES/x7AHYdtjTZwHJ1+2KFTyaFVVmBATVSKQP9F/P
	CIdB5np3/Pwm9vzyqAaSBUh2jf4hgPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737120165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hnx6LIBUeP6NEc/J9B3bi4AxvEmsHeIqCQoKy/mxHls=;
	b=GGqHApG/y9HsM8/lU4tLcLDtI4S4amY3zcnU1V2zXof/S4fvhG25qINJ+i5nN+xg4ySBT3
	q3LN1deVqRHrlLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88B4313A30;
	Fri, 17 Jan 2025 13:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QiEGIKVZimf+CQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Jan 2025 13:22:45 +0000
Date: Fri, 17 Jan 2025 14:22:45 +0100
Message-ID: <878qr9shga.wl-tiwai@suse.de>
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
In-Reply-To: <D74DJJTER7IQ.3KT9ECIRLN0JW@kernel.org>
References: <20250115224315.482487-1-jarkko@kernel.org>
	<87cyglsjdh.wl-tiwai@suse.de>
	<D74DJJTER7IQ.3KT9ECIRLN0JW@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E9D851F38F
X-Spam-Level: 
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,gmx.de,ziepe.ca,gmail.com,us.ibm.com,jp.ibm.com,osdl.org,kernel.org,hpe.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,hpe.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Fri, 17 Jan 2025 14:15:05 +0100,
Jarkko Sakkinen wrote:
> 
> On Fri Jan 17, 2025 at 2:41 PM EET, Takashi Iwai wrote:
> > On Wed, 15 Jan 2025 23:42:56 +0100,
> > Jarkko Sakkinen wrote:
> > > 
> > > The following failure was reported:
> > > 
> > > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
> > > [   10.848132][    T1] ------------[ cut here ]------------
> > > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> > > [   10.862827][    T1] Modules linked in:
> > > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> > > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> > > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> > > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
> > > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0
> > > 
> > > Above shows that ACPI pointed a 16 MiB buffer for the log events because
> > > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> > > bug with kvmalloc() and devm_add_action_or_reset().
> > > 
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: stable@vger.kernel.org # v2.6.16+
> > > Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> > > Reported-by: Andy Liang <andy.liang@hpe.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > One of my previous review comments overlooked?
> > The subject line still doesn't match with the actual code change.
> 
> True, thanks for catching this.
> 
> >
> > I guess "Map the ACPI provided event log" is meant for another patch,
> > not for this fix.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/
> 
> I edited also the description a bit. Does this make more sense to you
> now? (also denote any additonal possible tags)

Yes, looks good.  Thanks!


Takashi

