Return-Path: <linux-integrity+bounces-4499-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E79FED73
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 08:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95951882393
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 07:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1CC17C7CA;
	Tue, 31 Dec 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKL9OpAh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9R0Yq5cX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKL9OpAh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9R0Yq5cX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2D154C05
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735630132; cv=none; b=RmVELWIf7Gp+9vissgQtXSezYpUT+HGMh8U11M2CVCAA0mwRtELKRy0ip8lFLmAmwkGrUNu3+VgivLsFrvUrS/6o7mdAtKoPyl1IMncUOqfeF9580awntH3zI5CezgenZZY58lpan4IOFoqiqTE5CR9RupywshB440iKb9XluEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735630132; c=relaxed/simple;
	bh=i29pvTv0vNjjgePi8VXNGw1ZivTFnB+/M1dMJ0bUBoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+RVeNAMY7KwNViBZ4X+lzIQ0jFj/YFd5Z3cykZ/u03fbrc6NNDRQbZgyQ0CJFou9q4ICYXZvTTyJwFu6xubHTFA1TIZ24VhRxL1pg/XKLoLAD1W+rHWkdOVegNleREkujxN8+nsjs82FmdXfUlCA9T9M7EQjDfaSBS/a5t+B94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dKL9OpAh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9R0Yq5cX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dKL9OpAh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9R0Yq5cX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46C6F1F37C;
	Tue, 31 Dec 2024 07:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735630128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5WDqc2skZcRUC06TUQ5tS/XbjEIgKf598kHQY+2lwA=;
	b=dKL9OpAheIxrS6GHQ/NOMON/RJrS05j+BLjscjuNegyZZiyNqX8uoTvY0YKEe79dRf9qd+
	a4DEhY3ODnuEYBiejnJwOVYRN846P9wChLA0k8fDiD3adRm85wsv4O2HPZsOyvQNQEGjXM
	SqsAWxU9oyD7t3Q2KcZML6RK8MvfziM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735630128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5WDqc2skZcRUC06TUQ5tS/XbjEIgKf598kHQY+2lwA=;
	b=9R0Yq5cXlj7U3Crz70ss3MjzPgcJ7y6JZ7pi6JRoEoHqGzWtj25BUoFcJ1hiADxjEEpUzM
	V8YbX3zFIu1Wm+Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735630128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5WDqc2skZcRUC06TUQ5tS/XbjEIgKf598kHQY+2lwA=;
	b=dKL9OpAheIxrS6GHQ/NOMON/RJrS05j+BLjscjuNegyZZiyNqX8uoTvY0YKEe79dRf9qd+
	a4DEhY3ODnuEYBiejnJwOVYRN846P9wChLA0k8fDiD3adRm85wsv4O2HPZsOyvQNQEGjXM
	SqsAWxU9oyD7t3Q2KcZML6RK8MvfziM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735630128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5WDqc2skZcRUC06TUQ5tS/XbjEIgKf598kHQY+2lwA=;
	b=9R0Yq5cXlj7U3Crz70ss3MjzPgcJ7y6JZ7pi6JRoEoHqGzWtj25BUoFcJ1hiADxjEEpUzM
	V8YbX3zFIu1Wm+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEF2313A30;
	Tue, 31 Dec 2024 07:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GKrqNC+dc2dLcQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 07:28:47 +0000
Date: Tue, 31 Dec 2024 08:28:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima: ignore suffixed policy rule comments
Message-ID: <20241231072845.GA28758@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241230142333.1309623-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230142333.1309623-1-zohar@linux.ibm.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Mimi,

> Lines beginning with '#' in the IMA policy are comments and are ignored.
> Instead of placing the rule and comment on separate lines, allow the
> comment to be suffixed to the IMA policy rule.

+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 23bbe2c405f0..128fab897930 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1432,7 +1432,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		int token;
>  		unsigned long lnum;

> -		if (result < 0)
> +		if (result < 0 || *p == '#')  /* ignore suffixed comment */
>  			break;
>  		if ((*p == '\0') || (*p == ' ') || (*p == '\t'))
>  			continue;

