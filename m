Return-Path: <linux-integrity+bounces-4512-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E8FA00BFD
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81623A1702
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2025 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2351FA8F3;
	Fri,  3 Jan 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ir8R3mPP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HCEImjxV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WfUESWxM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5nkizrrR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA81F9EA4;
	Fri,  3 Jan 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921420; cv=none; b=goArBgpNWKokxXxEGojFwNKoqr6auUBcfKbq06sM+OKdqEcu/e4IvFsgPeOIHREjOt9MaF3R911Lp/V1/y0PlEncfMD7geCRoB+wgr+HOY4jU0G9LPVODfN1wcXq7uCpIHmV/fxnEf8m+CdI/JKFEJOwVRGZ5reHt5oPq+CtO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921420; c=relaxed/simple;
	bh=SC4fX0THYHOVWNw6azpsXuG+U+51NIkHveAC2pY9cmw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0aBwtxibV08/GZhyEi6ezikwj1nldZkiCwD/kp/dsBCXHeG5OsDmpLosYuIxN5ZlpcAvz+3E2sn1bsE23w6uE5keKbqrsZK3NwJIZtrUoxoqWdb9uTzsMbNziMwyxobfMhQ+Rqqj78zBjhOFmBRSanIfskUjOQgsG/D1Lz+T7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ir8R3mPP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HCEImjxV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WfUESWxM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5nkizrrR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBE281F38E;
	Fri,  3 Jan 2025 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735921417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lm5ITltHkS9tXpmpde4LKGXpCZi+xEonoaF7+jYvUg=;
	b=Ir8R3mPP3/9Pp/oLoWva768FHZBFSP5qMuv523U9WFk6jksvtN5noDplwsKoxcPowu5w88
	Rtc5BsLNEupwLwhYuwu7eIoZ84HFRDv++3AEHrRz7/tkZFUcyudrR6yRf4Boxh4zwaYSOd
	xzcq0f8JUhaUlfDwv7Y7VzjKdJVwucE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735921417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lm5ITltHkS9tXpmpde4LKGXpCZi+xEonoaF7+jYvUg=;
	b=HCEImjxV74cY88/7CMooP39+punaMzGgeN4ln/OsMvq3A3CFk2wnrkDwwcBM8KHQ0gNRWI
	V0AcGrm7bQbzshDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WfUESWxM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5nkizrrR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735921416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lm5ITltHkS9tXpmpde4LKGXpCZi+xEonoaF7+jYvUg=;
	b=WfUESWxMz99DGGtV2Gv8C4oDQdWXJW60da4fClzHU43J/ChTFbK6q5OeMHoEPfqKqH6Eiu
	B4UJ+uvzWN+0mtfPYCVTv0xuxuqPENkLMUsmjK5G3fkqm1L6iakKaooekeTLnt1OmkmZd3
	V55JOxmEMe1NzMGUY0jmZ6PV18PVa/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735921416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lm5ITltHkS9tXpmpde4LKGXpCZi+xEonoaF7+jYvUg=;
	b=5nkizrrRxlyYZJOn5/eVzhL7DbwSBaULMcDDNOkyLOYe1UKUEryYTt01J0rRQZpeqY1V0S
	z9yJVQ7Liw3smfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B743134E4;
	Fri,  3 Jan 2025 16:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9yMZFQgPeGfzegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 03 Jan 2025 16:23:36 +0000
Date: Fri, 03 Jan 2025 17:23:35 +0100
Message-ID: <87frlzzx14.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Stefan Berger <stefanb@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Seiji Munetoh <munetoh@jp.ibm.com>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	Reiner Sailer <sailer@us.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm: Map the ACPI provided event log
In-Reply-To: <20241227153911.28128-1-jarkko@kernel.org>
References: <20241227153911.28128-1-jarkko@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: CBE281F38E
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
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca,gmail.com,us.ibm.com,osdl.org,jp.ibm.com,kernel.org,hpe.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 27 Dec 2024 16:39:09 +0100,
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

It looks like that the subject doesn't match with the patch
description?

(snip)
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -63,6 +63,11 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
>  	return n == 0;
>  }
>  
> +static void tpm_bios_log_free(void *data)
> +{
> +	kvfree(data);
> +}
> +
>  /* read binary bios log */
>  int tpm_read_log_acpi(struct tpm_chip *chip)
>  {
> @@ -136,10 +141,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	}
>  
>  	/* malloc EventLog space */
> -	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> +	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
>  	if (!log->bios_event_log)
>  		return -ENOMEM;
>  
> +	ret = devm_add_action_or_reset(&chip->dev, tpm_bios_log_free, log->bios_event_log);
> +	if (ret) {
> +		log->bios_event_log = NULL;
> +		return ret;
> +	}
> +
>  	log->bios_event_log_end = log->bios_event_log + len;
>  
>  	virt = acpi_os_map_iomem(start, len);

I'm afraid that you forgot to correct the remaining devm_kfree() in
the error path of this function.

(I know it because I initially posted a similar fix in
   https://lore.kernel.org/all/20241107112054.28448-1-tiwai@suse.de/
 Your devm_add_action_or_reset() is a better choice, indeed, though
 :-)


thanks,

Takashi

