Return-Path: <linux-integrity+bounces-8092-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D68ACC89AA
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 494B83123C1B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866A340285;
	Wed, 17 Dec 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a+i2JoLz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JgsRy1M2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KT8gk5mA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ATQNsNPp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F669350D40
	for <linux-integrity@vger.kernel.org>; Wed, 17 Dec 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986400; cv=none; b=OS+FWeKKtrxbVsX6z2IiM8gtlczoe3Yyg6CUKDgVjLhvmAm9L0yepoNpCs6IyaoWYYvRcJVklBEC7WzDl6QR3o0hQPagSyixRPZ7nSyxlSQSDKza5hsRLB0ZokTJYQKEhtSAnVoMM1SKNG/qR+Z5THsRJbm2xhtG6TN/dJqMMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986400; c=relaxed/simple;
	bh=4znfgqeyEQpJ11jVUZ7ry/ac/5UWlTA2ZtXSlPQ3UTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctBFru8b8mOOpOvrSpteUiXYCUfd4wHZHIsFEok+EuJvUmM1bCZLXrk2u6u1BTHmwzXux418JHQB+3A9G8R8lC3D0SfxafpzLyJ8eHJO0yge+dCWk6xeI8rksNbE2GisNYHasIquxDaaxW3iJTAUQuD/LztFL3L/dUqV6HL0n7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a+i2JoLz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JgsRy1M2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KT8gk5mA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ATQNsNPp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31DA633686;
	Wed, 17 Dec 2025 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765986397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
	b=a+i2JoLztiFCJaRiuUl29R7w7UelOmIePq5WagRmkt2XRgf9Gsuw89AImDkj2FDY0RkVQK
	T9TRFkjzKrgEIWi3d3Fquz3/j0mT6PfAlK0dIGNRw1hRWa76eRyTrcA82wHGeGCO1QnU5I
	0f30mW1Xm4BnSRJo+Rr5mswnUuF9Gww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765986397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
	b=JgsRy1M2r3o3ROCqqCPNZKTdryRXCLsFMm76xQQh8qbVg5WCY4EJiESLiJfSCS9IUmasVv
	nOtphHpIWOfWstDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KT8gk5mA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ATQNsNPp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765986396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
	b=KT8gk5mA/bfhPQ059BU8oZYJdbdYiA0bEvoXJzzwgsob8EdMZL5/yMBfjHCt6PRcJ9C6b8
	5GHYyyDOwrl0O1gO238n5lWMjeK9KfIAXwmPf2rOWQKyFrxmmXXDWc6NvYyQkKagqyrooX
	DiYrTTMD9GaB+CcDZeikhBhdVoHHBBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765986396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
	b=ATQNsNPpcobfkQy2gXDi8BinwbqcAkAelK1tefZnGUY97Si6XLaAQKxQDewEDeAn+x+dHu
	SQYkJm3oFIDZXGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 207333EA63;
	Wed, 17 Dec 2025 15:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dDw2BVzQQmmmVAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 17 Dec 2025 15:46:36 +0000
Date: Wed, 17 Dec 2025 16:47:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>, Li Wang <liwang@redhat.com>
Subject: Re: [PATCH v4 2/4] tst_test.sh: Add TST_USR_{G,U}ID variables
Message-ID: <aULQlhbHltLTbdG4@yuki.lan>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-3-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209185557.20598-3-pvorel@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 31DA633686
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Hi!
> Add TST_USR_{G,U}ID variables with the default values from tst_runas.c.
> 
> These can be used as a default values for tests which use tst_runas and
> need to know UID/GID for other commands.
> 
> It will be used in LTP IMA tests.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_runas.c | 1 +
>  testcases/lib/tst_test.sh | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/lib/tst_runas.c b/testcases/lib/tst_runas.c
> index e8d5d8dd9d..e937828273 100644
> --- a/testcases/lib/tst_runas.c
> +++ b/testcases/lib/tst_runas.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
>   */
>  
> +/* update also tst_test.sh */
>  #define LTP_USR_UID 65534
>  #define LTP_USR_GID 65534
>  
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 4be10a4f94..26e6a86dcb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -17,6 +17,10 @@ export TST_ITERATIONS=1
>  export TST_TMPDIR_RHOST=0
>  export TST_LIB_LOADED=1
>  
> +# see testcases/lib/tst_runas.c
> +export TST_USR_UID="${LTP_USR_UID:-65534}"
> +export TST_USR_GID="${LTP_USR_GID:-65534}"

Do we need this? We already have the default values in the C code...

>  . tst_ansi_color.sh
>  . tst_security.sh
>  
> @@ -689,7 +693,7 @@ tst_run()
>  			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
>  			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
>  			SKIP_FILESYSTEMS|SKIP_IN_LOCKDOWN|SKIP_IN_SECUREBOOT);;
> -			DEVICE_SIZE);;
> +			DEVICE_SIZE|USR_UID|USR_GID);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

