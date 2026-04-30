Return-Path: <linux-integrity+bounces-9389-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIibACce82kvxQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9389-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 11:17:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB149FBBF
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E544301456A
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F0D34D4E2;
	Thu, 30 Apr 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vU86OTEt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/grSMBln";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y4b6Z+pu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l9qM9ohM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AB374E6C
	for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540597; cv=none; b=aRPRrTAozUvWDJgxXW66wk412tVyYMQIh2gh0GIqa/gwkbGMn8eQjAfL+59EC+TbhcD2DdvlMaaERNNdO8sgIBRe+hWaGZBQ8+5ZQwsUhbNn2N502oPVBKWDf9/T+1qBIbfxTVzCx+bLLqn6XoY3sq5rcI9fUNcKj+kHdrcnYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540597; c=relaxed/simple;
	bh=Vx/m/P3JqYFqB9KlqDDg0ySCIRtnBk6fdQgzKjYLRgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvYozrk9WZs0BVfS8xVbx1QC05FvsmT7mGVvlTeaCftxdRofHgmJerj3oYFKyXy5AHS/2LUvtfnK8GUVq2eG5HURA0jogNmXKQ7Ah2Gb+27rqCP5kvLJhB+SdKfH6bucVJ+PDFgrrQ9QAERXt+xPRVOhHMyrqwEzbySyiIO3ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vU86OTEt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/grSMBln; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y4b6Z+pu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l9qM9ohM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E971A5BD5D;
	Thu, 30 Apr 2026 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777540595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
	b=vU86OTEt4cbH6f3QTwZk4ohOsTrFDl5WRn2JQZry+pCxSKNQ2beY0rZDJ3HOUJWdTvCDga
	Px2dic7FCLaIxDlYpPx1jfrrlvVYJU67emaUDT9W5uBJ+1b3HM1ut9wJ/wWD9DSeVawKOD
	U2hnC3kk0cHV6OZ6vCe9S3WJB2nMeXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777540595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
	b=/grSMBlngeTf8D69mmAyPz8jzJZh1xmh2MsLMM6UsBw8Smgd2VA0QHF9o4XXPWn7ypjyzt
	drbZVNulF7LnpcDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777540594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
	b=y4b6Z+puf1d7Jl6BvHgLBoyclud3t81Z8gFPScg4TKunsTnY2gM1byQRu+RjBm1V9ByIJH
	VeWkrmKKiv7IpSbUt2XmhD+fDWH4IM2Pflb6+fkPHu2+jvgtCyrp/a+PDavZ7aHgSWb4nU
	jrSDw4pVA+eU+W7A6wosVSTGKFS20Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777540594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgCCe1R7DGN14yeRLGu9vS3iBbqDao+6RAiTQBwuw7U=;
	b=l9qM9ohMt+eQkDCZiTnJNd58naxtLiV9/M/rK5jczg3q8nmK3qJ5t6ijndM5/trDH/B9zb
	+ZFvNm9ZntUkBzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D80DE593B0;
	Thu, 30 Apr 2026 09:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EuLJM/Id82m8NgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 30 Apr 2026 09:16:34 +0000
Date: Thu, 30 Apr 2026 11:16:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Avinesh Kumar <avinesh.kumar@suse.com>,
	Wei Gao <wegao@suse.com>, Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima_violations.sh: ima_mmap.c: Replace sleep with
 checkpoints
Message-ID: <afMd82ykYhNz9Msy@yuki.lan>
References: <20260428161034.947614-1-pvorel@suse.cz>
 <20260428161034.947614-2-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428161034.947614-2-pvorel@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 46FB149FBBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9389-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrubis@suse.cz,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ima_violations.sh:url,suse.cz:dkim,suse.cz:email]

Hi!
> Using checkpoints is a proper way in LTP new API [1] to avoid races and
> waste of time.  It reduces 3 sec sleep in ima_mmap.c and 1 sec sleep in
> ima_violations.sh with just checkpoints.
> 
> NOTE: tst_reinit() is really needed instead of .needs_checkpoints = 1
> as documented in Shell-Test-API.asciidoc.
> 
> [1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
> 
> Fixes: 0e4cbf753f ("security/ima: Rewrite tests into new API + fixes")
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/src/ima_mmap.c     | 7 ++++---
>  .../kernel/security/integrity/ima/tests/ima_violations.sh  | 6 +++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> index 8596809ef4..09b22fd4f4 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> @@ -9,7 +9,6 @@
>  
>  #include "tst_test.h"
>  
> -#define SLEEP_AFTER_CLOSE 3
>  #define MMAPSIZE 1024
>  
>  static char *filename;
> @@ -35,8 +34,10 @@ static void run(void)
>  	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  	SAFE_CLOSE(fd);
>  
> -	tst_res(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
> -	sleep(SLEEP_AFTER_CLOSE);
> +	tst_reinit();
> +	TST_CHECKPOINT_WAIT(0);
> +	/* keep running until ima_violations.sh open and close file */
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
>  	tst_res(TPASS, "test completed");
>  }

C helpers that call tst_reinit() should implement main(). These are not
complete tests, just helpers. The main problem is that if you add
tst_reinit() to a source that defines tst_test structure you are
initializing the test library for a second time, which overwrites the
some of the already initialized variables.

We probably want:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26f6510a0..971a184f2 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -196,6 +196,9 @@ void tst_reinit(void)
        size_t size = getpagesize();
        int fd;

+       if (ipc)
+               tst_brk(TBROK, "Test library already initialized!");
+
        if (!path)
                tst_brk(TBROK, IPC_ENV_VAR" is not defined");


So that this kind of mistake is caught early.

-- 
Cyril Hrubis
chrubis@suse.cz

