Return-Path: <linux-integrity+bounces-4579-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8FFA14F5F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 13:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55633188AC93
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191581FF1BA;
	Fri, 17 Jan 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P9aS0sJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cBgFScN1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P9aS0sJE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cBgFScN1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE51FF1B2;
	Fri, 17 Jan 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117679; cv=none; b=SLKy1FRo9Hqyp8mbrxosU0yRdXXHDP9SKJHOF3FiUysCtoGuDGGFYGIsgo3xxf/l5LJeMRIcuAApUTZ/Hhkjys1+F8sjnA6UC2E/gr7br4nXXwhYc+/WuHS6jZWHL7Ur9s/GCdUAmPYd9VOtQ/lg6Qtji+RXCfW7bcLuIUhvOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117679; c=relaxed/simple;
	bh=YgN/kVZUCYxbqA9hxRcV8XwsGS0ecqzNUDyYe8q92jw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1Jsa0Hvw3bcvqSInzPP2m2EVtdATDqtgUXrC2MmPI3ayAauLcAjalaOxWig9OEFyxjr3h1cjOJR9QPSTDzbNOv+43hznfcKHk6Jted/7fXNhVnUEat4ZY3cl3xktBWk0tGOWaHZxNmZfBYYete/whziR3lSnhArlgfErO8MydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P9aS0sJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cBgFScN1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P9aS0sJE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cBgFScN1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19BD021175;
	Fri, 17 Jan 2025 12:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737117675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmVzdJYE/Fh+arWkO2e/FTFlqv6WD/FLeWeFkS/wLTA=;
	b=P9aS0sJEabaIkoDCgEtF6DCeOCyk7eUzoGPC9WdmneVF48za8zMtei8tciQqGAw1IlHdhS
	lm+4s7Dhx4jGGNAxsoUi2oGez8Lv5FqVb6LlfnMwyXMKUje5TOwdKGy5thqqfimlvI1ary
	PMJWsDVN7mm2PFJ0HJojQlFAbqFW2QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737117675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmVzdJYE/Fh+arWkO2e/FTFlqv6WD/FLeWeFkS/wLTA=;
	b=cBgFScN1TzeClM196UvV1olEh5ggnSmcwMEsl0//2rlTiGTuCjB9vsjDwxf8OFOvKe+1mU
	+W8V2HafAT5D6ACg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737117675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmVzdJYE/Fh+arWkO2e/FTFlqv6WD/FLeWeFkS/wLTA=;
	b=P9aS0sJEabaIkoDCgEtF6DCeOCyk7eUzoGPC9WdmneVF48za8zMtei8tciQqGAw1IlHdhS
	lm+4s7Dhx4jGGNAxsoUi2oGez8Lv5FqVb6LlfnMwyXMKUje5TOwdKGy5thqqfimlvI1ary
	PMJWsDVN7mm2PFJ0HJojQlFAbqFW2QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737117675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmVzdJYE/Fh+arWkO2e/FTFlqv6WD/FLeWeFkS/wLTA=;
	b=cBgFScN1TzeClM196UvV1olEh5ggnSmcwMEsl0//2rlTiGTuCjB9vsjDwxf8OFOvKe+1mU
	+W8V2HafAT5D6ACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC83D13332;
	Fri, 17 Jan 2025 12:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zpShKOpPimc7egAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Jan 2025 12:41:14 +0000
Date: Fri, 17 Jan 2025 13:41:14 +0100
Message-ID: <87cyglsjdh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Stefan Berger <stefanb@us.ibm.com>,
	Reiner Sailer <sailer@us.ibm.com>,
	Seiji Munetoh <munetoh@jp.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] tpm: Map the ACPI provided event log
In-Reply-To: <20250115224315.482487-1-jarkko@kernel.org>
References: <20250115224315.482487-1-jarkko@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca,gmail.com,us.ibm.com,jp.ibm.com,osdl.org,kernel.org,hpe.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Wed, 15 Jan 2025 23:42:56 +0100,
Jarkko Sakkinen wrote:
> 
> The following failure was reported:
> 
> [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
> [   10.848132][    T1] ------------[ cut here ]------------
> [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> [   10.862827][    T1] Modules linked in:
> [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
> [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0
> 
> Above shows that ACPI pointed a 16 MiB buffer for the log events because
> RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> bug with kvmalloc() and devm_add_action_or_reset().
> 
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: stable@vger.kernel.org # v2.6.16+
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Reported-by: Andy Liang <andy.liang@hpe.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

One of my previous review comments overlooked?
The subject line still doesn't match with the actual code change.

I guess "Map the ACPI provided event log" is meant for another patch,
not for this fix.


thanks,

Takashi

