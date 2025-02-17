Return-Path: <linux-integrity+bounces-4846-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F795A38691
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 15:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E670A7A3117
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44221CC6E;
	Mon, 17 Feb 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p5J/3NL4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iDW3cZzd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WVpaqwGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yL5Tndyt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FB21D00A
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802936; cv=none; b=qmpQXHTmasY5PcthSMckivNzIRc6Uuba2HNoMffk80kufWSLddQ2hKcIXK8M0e4KRJt3Z/wRK610rkE0kZjB4vI0UMhQZoiqXgAdYaMej4VIVIr8OVWK6Yx5G5M9ka0fgROxyuEMGT5RB/yTGJ0a3Q1IYUw1VSG107UYP8TkxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802936; c=relaxed/simple;
	bh=HMCm0RJqs2yno8N3OQ3jjLN+OFLaPtEq0yPrNipTkCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urp0v+rj7iWkF2D0aAr5/V/yr5KlY9XIJUpjASLhYz43bIUnYB9L7yaEn74M+SbeMKTtv805GnTXCiHAivWMea6z1vJ/vMx3j4mYqjKJcsEij+s574+U3ltn5qyZSl9txY9EFVF9oRqKg4lzkB8MbOIYN3VLgsweF2gsPNwSvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p5J/3NL4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iDW3cZzd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WVpaqwGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yL5Tndyt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B82E721172;
	Mon, 17 Feb 2025 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739802933;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
	b=p5J/3NL4KxRExSu5gXw9fY5EhB69r+6uyAOv3qQe7EDPjk5ydAymqLhW8jf+zgtGff56DO
	t6YzJFn9m6cpK5jy8kabAr3G4Km7YuSasLy5CmbHOm0fADon/2UumYW9BXznOgh9m772ns
	c3X+QapQgRIqhJNbkIX78dNmbZAZdNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739802933;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
	b=iDW3cZzdBu3Ru0iJRxUyyiGtoGckCIsWvzLX1NsvMQ3aK7PM1XSv3snufF2HFfBstFsFMl
	SOdaXooVmDz9tLDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739802932;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
	b=WVpaqwGuBuD3c0X65i7vW7Kd14WqlbO+OIXCdXwjCFTsOYO2uASdUyKGOUmEVkIhYKY31j
	RU3rX1zsoGzwH+s/qH+fIfyKR4WUURcfl3I5urgydfzm4JgzGEw6iaZz26s2faFMtxqL62
	KDXy3XyOOIlUYNbaavG9eEfWFq4RHJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739802932;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=osH2yIRMon3beHg6dXYC4bmmZJF07X2KmM7uMOrspS0=;
	b=yL5TndytC1khoRo/jPtRiT8GsVKSJu46g2k5sbvYs2Yiq8hQxcGWG2Oe6O7Qc1l53QhnQJ
	3EAn/t7s46iaBPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972E6133F9;
	Mon, 17 Feb 2025 14:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CjBmIzRJs2eBJgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 14:35:32 +0000
Date: Mon, 17 Feb 2025 15:35:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH 1/2] tst_security.sh: Fix SELinux detection
Message-ID: <20250217143526.GA2402962@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250217130839.2392666-1-pvorel@suse.cz>
 <f8d6c3fd-7b1d-4d16-b034-a2b01f956870@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d6c3fd-7b1d-4d16-b034-a2b01f956870@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

Hi Andrea,

> Hi!

Thanks for your review, merged as a needed fix.

Kind regards,
Petr

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

> On 2/17/25 14:08, Petr Vorel wrote:
> > Some SLES15 versions create /selinux directory which fails the detection
> > if SELinux is actually not enabled. Therefore detect if directory
> > actually contains the 'enforce' file.

> > Also drop /selinux directory detection and detect only /sys/fs/selinux,
> > /sys/fs/selinux mount point was added in kernel 3.0 in commit
> > 7a627e3b9a2b ("SELINUX: add /sys/fs/selinux mount point to put selinuxfs")
> > 14 years is enough, kernel 3.0 is not even supported in current LTP and
> > we don't even support /selinux in C API (tst_security.c).

> > Fixes: e7b804df65 ("shell: Add tst_security.sh helper")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/lib/tst_security.sh | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)

> > diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
> > index 05640234ea..356c28fc73 100644
> > --- a/testcases/lib/tst_security.sh
> > +++ b/testcases/lib/tst_security.sh
> > @@ -127,8 +127,7 @@ tst_get_selinux_dir()
> >   {
> >   	local dir="/sys/fs/selinux"
> > -	[ -d "$dir" ] || dir="/selinux"
> > -	[ -d "$dir" ] && echo "$dir"
> > +	[ -f "$dir/enforce" ] && echo "$dir"
> >   }
> >   # Get SELinux enforce file path

