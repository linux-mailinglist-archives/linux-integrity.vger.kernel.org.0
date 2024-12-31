Return-Path: <linux-integrity+bounces-4500-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3DB9FEE5F
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87B3161BCA
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB7318C00B;
	Tue, 31 Dec 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BiR0tBPp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4bbRXhwM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BiR0tBPp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4bbRXhwM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2918B482
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735637611; cv=none; b=n0T8lk5XwSbcN5TrFn8WzsfylxfPh8mCytM0ZY75LRwdxwNP+DKoW+o8YFhZJLYGYB9yxAWakFWxQ2VEzByM+W93kAAjP2fkDXTOO0O/itbxkOE7IjJ3j+658lAWNawfqh2ftiGOGkLz+g/tWChWofSRUwBZoB96sd36zVkN05Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735637611; c=relaxed/simple;
	bh=8gHuW3y1ub7Ig8JZM9MeZeVCoVczjOJpTZrvlRR+dLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX8mWx/3nYUY2ORTIh2RFkOiAgnJGmg74QnpTlaE6vPNPXNj6kXTQcszeQwXf7Jk4GbZg5P/fTbucC6AKRy/Doyd+6BLLgsfZtbTwVVzuHbtU6on/nRgGUUdxcQxPijmPng4YXECkTNNJ3DlYYsA2lEaQaC+BiodfzMEx9eTX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BiR0tBPp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4bbRXhwM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BiR0tBPp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4bbRXhwM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C99021106;
	Tue, 31 Dec 2024 09:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735637604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ8f3jsVCHp1a3X8exZV6d5r4cc2VgsAmuR57XVeeZM=;
	b=BiR0tBPpU7XnJcL0j2WbPKcWPsdI1sIsQVnkVhl41b5fiqEOxWWblBiRP5RsgQyiEdyJIK
	BmMDZUNow/f1fe41KSF8DVCmmFH/Sg1ZHinatdp1gfHCG+UHu56+VABp15ihIlZIpePi4l
	kHDbkTBntA+l3uiyPx4w4rHLglJtcX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735637604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ8f3jsVCHp1a3X8exZV6d5r4cc2VgsAmuR57XVeeZM=;
	b=4bbRXhwMYzbTt+ew/W0Nuv6ml41uuq5L5lu1pylbRi3E917nvUdq9uv0p6TYQr1Ifba/pD
	qrB1oAkK0x05W9CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BiR0tBPp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4bbRXhwM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735637604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ8f3jsVCHp1a3X8exZV6d5r4cc2VgsAmuR57XVeeZM=;
	b=BiR0tBPpU7XnJcL0j2WbPKcWPsdI1sIsQVnkVhl41b5fiqEOxWWblBiRP5RsgQyiEdyJIK
	BmMDZUNow/f1fe41KSF8DVCmmFH/Sg1ZHinatdp1gfHCG+UHu56+VABp15ihIlZIpePi4l
	kHDbkTBntA+l3uiyPx4w4rHLglJtcX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735637604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ8f3jsVCHp1a3X8exZV6d5r4cc2VgsAmuR57XVeeZM=;
	b=4bbRXhwMYzbTt+ew/W0Nuv6ml41uuq5L5lu1pylbRi3E917nvUdq9uv0p6TYQr1Ifba/pD
	qrB1oAkK0x05W9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E607413A30;
	Tue, 31 Dec 2024 09:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QqkfN2O6c2cLCwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 09:33:23 +0000
Date: Tue, 31 Dec 2024 10:33:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima: limit the builtin 'tcb' dont_measure tmpfs policy
 rule
Message-ID: <20241231093318.GA36475@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241230142333.1309623-1-zohar@linux.ibm.com>
 <20241230142333.1309623-2-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230142333.1309623-2-zohar@linux.ibm.com>
X-Rspamd-Queue-Id: 0C99021106
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_EQ_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Mimi,

> With a custom policy similar to the builtin IMA 'tcb' policy [1], arch
> specific policy, and a kexec boot command line measurement policy rule,
> the kexec boot command line is not measured due to the dont_measure
> tmpfs rule.

> Limit the builtin 'tcb' dont_measure tmpfs policy rule to just the
> "func=FILE_CHECK" hook.  Depending on the end users security threat
> model, a custom policy might not even include this dont_measure tmpfs
> rule.

> Note: as a result of this policy rule change, other measurements might
> also be included in the IMA-measurement list that previously weren't
> included.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> [1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_policy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 21a8e54c383f..23bbe2c405f0 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -148,7 +148,8 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
>  	{.action = DONT_MEASURE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
> -	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
> +	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .func = FILE_CHECK,
> +	 .flags = IMA_FSMAGIC | IMA_FUNC},
>  	{.action = DONT_MEASURE, .fsmagic = DEVPTS_SUPER_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
>  	{.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},

