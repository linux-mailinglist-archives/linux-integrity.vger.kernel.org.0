Return-Path: <linux-integrity+bounces-4217-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D49D9F19
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 23:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26192B21646
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469541ABED8;
	Tue, 26 Nov 2024 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLucftdK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yuAIGwqr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PY8oOG4A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RoVvTDjm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAB8831
	for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732658976; cv=none; b=d3qpMoMx8Fg/32IjB8Aj9DDtPMhLUDqMz4BeYd1BL7Y7xV0LPY4byxuB7Bt3Np3ZL+evifrKIwXOWxX5qT0WxqzSetAMkI7dPaPgH1savcXd12liSbQMGziFypSfJYm+cu2J6hVdcjNhdg1eRPpujMvMUkJqqd8ruIIkEamMjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732658976; c=relaxed/simple;
	bh=O/GNn7QD6LYlMeZo+CVzkG0vSlh1tnZzccrzqMmF6lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX1WXJAldlAAstebhRONx7VIjrLOYmrGkChXgR4muZM5K4Yt0O831V2V8g5m3b/01WoBG2htb9Nj9qOcMu1vZIy9PCzshcJV35QBx3n6exJPJbILHdKKkq1tAFTWMYodv1NQDvEwy3PwcuiAmB2DTXQoicaWTxuY9YYAW2QdwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hLucftdK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yuAIGwqr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PY8oOG4A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RoVvTDjm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D924021177;
	Tue, 26 Nov 2024 22:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732658972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
	b=hLucftdKUqntAognT/Bi04UpUgtStsETay5H1fvWPHsTfOZy0CldxAa9bfhbc9fXBwtq/+
	mexKaZ/g+6vUn+zMRS2VYOYkR7wD9LP77Viq08sqzIDNwvHo5nDDCsMSSdGBrrPlId2TGm
	2Ywh4RooSu7hK0r0hVe1+e9UMjwc4RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732658972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
	b=yuAIGwqrK4OWkml7+6VeHKiFMukBADzUFhIbhtVwFiIXpB6++SOvt8l73H2a9rmxnDaUyi
	c3fvGjYOt4vV64BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PY8oOG4A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RoVvTDjm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732658971;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
	b=PY8oOG4A8C9kRHtD35hXHBqLWMOUOAg6K/vtTyLFKQ+D6RXNUErreSaaGi6+TN31ltxWMu
	Js8dwUCFErPKSp7iGveXyvAz6sEKprzlcxA14NGBi685kF/1mH89ayFV75aJoXYl/R8X/k
	SgxO6/q6I6eb8zZQfJqnr4Lbp0aFyJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732658971;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
	b=RoVvTDjm8icfuXH33/VMFSmbFnv5WOZFqsd2bntKx7u078BDRC7MiUjfnX7IGNIvwxkJJL
	ufAzbiE0Bso6HBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC2BB13890;
	Tue, 26 Nov 2024 22:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nh5gLBtHRmfIBQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 22:09:31 +0000
Date: Tue, 26 Nov 2024 23:09:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
Message-ID: <20241126220930.GA135981@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-3-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126173830.98960-3-pvorel@suse.cz>
X-Rspamd-Queue-Id: D924021177
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Mimi, all,

...
> +load_ima_policy()
> +{
> +	local policy="$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> +
> +	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$policy" -a -f "$policy" ]; then
> +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=1 to load policy for this test"
> +		return
> +	fi
> +
> +	if [ -z "$policy" -o ! -f "$policy" ]; then
> +		tst_res TINFO "no policy for this test"
FYI here needs to be a flag to not warn in the cleanup about needed reboot.

> +		return
> +	fi
> +
> +	tst_res TINFO "trying to load '$policy' policy:"
> +	cat $policy
> +	if ! check_policy_writable; then
> +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
> +		return
> +	fi
> +
> +	cat "$policy" 2> log > $IMA_POLICY
> +	if grep -q "Device or resource busy" log; then
> +		tst_brk TBROK "Loading policy failed"
Also here.

diff, which should solve it.

Kind regards,
Petr

+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -175,6 +175,7 @@ load_ima_policy()
 
 	if [ -z "$policy" -o ! -f "$policy" ]; then
 		tst_res TINFO "no policy for this test"
+		LTP_IMA_LOAD_POLICY=
 		return
 	fi
 
@@ -182,6 +183,7 @@ load_ima_policy()
 	cat $policy
 	if ! check_policy_writable; then
 		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
+		LTP_IMA_LOAD_POLICY=
 		return
 	fi
 

