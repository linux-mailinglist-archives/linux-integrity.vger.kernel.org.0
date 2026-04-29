Return-Path: <linux-integrity+bounces-9357-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COf1FQLz8WmElwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9357-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 14:01:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BC493D1C
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 14:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C5E3020017
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C237CCA4E;
	Wed, 29 Apr 2026 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S4bxcTXk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pntH6DiL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hs9bTTM+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ofV+Aeos"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2D347537
	for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464040; cv=none; b=uXF+UN8SoN6qVf97+yGnG6vFdNmSpCUg8AXQwr3/MOQ88GeTiGGlTkFDzC/w5veFmbCN86ph9YCXrI0tRgUg+Sghhum0/jIrBYs7WWGVJpAJjtMNUIpBq8O16pkv5HoVB6Lep4eb5darI28RwTyxhsVAUD+qFIxz0WD+tDAB4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464040; c=relaxed/simple;
	bh=6tDh1rYve6ly3TzICi4AKBNqN29jjnHr3whf8jRuAQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou254mUdBqO7K5vuuGs/yeWUKIjROFucTR9xl3lFSVLkfQvJl+tBEPdsouV+GFeUrhboEkW8NmFHF1IEPOCjSSgMVTpIrToqYM5C2fc6ycpoGyQgLQm+qjvLLb5rhJt+OedFeLEfVmXwGpKl/CBA6+mBn28UIKtqXaaDXEq/QWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S4bxcTXk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pntH6DiL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hs9bTTM+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ofV+Aeos; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E7EF6A867;
	Wed, 29 Apr 2026 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777464033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
	b=S4bxcTXkTgAqqcQffMVUAX3MYKoAVvZfjvMOTMGQ+i/ljppJcvcpUX74X0jqYyPMsnymbA
	JozxN3SD7B2WQZ5IIlrkVrOMH1fE88BaD7uJ2SN5oEYuXU56NobfPq34hcYNBmi3nNfJPq
	AChX+rkMPTRhyx13k3uXXZiE1xdpkpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777464033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
	b=pntH6DiL1Mkaw+Qxa4D7DUpArIFmxz8THH60znML88ku7ZhQ+OMwa+7PgFCv0Wmn5Hoxxi
	R0wgKHxrL8A/JgDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777464032;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
	b=hs9bTTM+pWfhR9P5C2FJ31keLCe+MRPoSkYEuzFTFGSInwm8tJ/xN7DzvoFWMn6OLwDmCd
	ANKtq1krbw26d/A1oxkxUC1NLL2IUg+uTlovqMdPO/6P3j/zwqFAXwquTVbeNDRu2z2l0/
	wPfnilFFWpNj88gfJxsVLw9lrUpMWC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777464032;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tz2WAb/fW8M+Pe6f3LjxvCxoJDHXETTFeISIiiEJgvA=;
	b=ofV+AeoslEjK1UBWhzW/t0/m/X3y+UsjP/j80WebTSk1KlhrQqDEvbL7j/8mIuUBH/1esW
	E7XNGKWBVn7gQSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60697593B0;
	Wed, 29 Apr 2026 12:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /B3bFODy8WlcTwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 29 Apr 2026 12:00:32 +0000
Date: Wed, 29 Apr 2026 14:00:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Cc: ltp@lists.linux.it, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [LTP] [PATCH 2/2] ima_violations.sh: ima_mmap.c: Replace sleep
 with checkpoints
Message-ID: <20260429120030.GA993265@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260428161034.947614-1-pvorel@suse.cz>
 <20260428161034.947614-2-pvorel@suse.cz>
 <209b0327-64b4-4a58-9ee1-19ec693c8105@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <209b0327-64b4-4a58-9ee1-19ec693c8105@suse.cz>
X-Spam-Flag: NO
X-Spam-Score: -7.50
X-Spam-Level: 
X-Rspamd-Queue-Id: DB3BC493D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9357-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ima_violations.sh:url,suse.cz:email,suse.cz:dkim,suse.cz:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[pvorel@suse.cz];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]

Hi Martin, all,

> Hi,
> for both patches:

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks for review, patchset merged.

Kind regards,
Petr

> On 4/28/26 18:10, Petr Vorel wrote:
> > Using checkpoints is a proper way in LTP new API [1] to avoid races and
> > waste of time.  It reduces 3 sec sleep in ima_mmap.c and 1 sec sleep in
> > ima_violations.sh with just checkpoints.

> > NOTE: tst_reinit() is really needed instead of .needs_checkpoints = 1
> > as documented in Shell-Test-API.asciidoc.

> > [1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests

> > Fixes: 0e4cbf753f ("security/ima: Rewrite tests into new API + fixes")
> > Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/kernel/security/integrity/ima/src/ima_mmap.c     | 7 ++++---
> >   .../kernel/security/integrity/ima/tests/ima_violations.sh  | 6 +++++-
> >   2 files changed, 9 insertions(+), 4 deletions(-)

> > diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> > index 8596809ef4..09b22fd4f4 100644
> > --- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> > +++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
> > @@ -9,7 +9,6 @@
> >   #include "tst_test.h"
> > -#define SLEEP_AFTER_CLOSE 3
> >   #define MMAPSIZE 1024
> >   static char *filename;
> > @@ -35,8 +34,10 @@ static void run(void)
> >   	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> >   	SAFE_CLOSE(fd);
> > -	tst_res(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
> > -	sleep(SLEEP_AFTER_CLOSE);
> > +	tst_reinit();
> > +	TST_CHECKPOINT_WAIT(0);
> > +	/* keep running until ima_violations.sh open and close file */
> > +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> >   	tst_res(TPASS, "test completed");
> >   }
> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > index 0c03c30786..d7dcd077b4 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> > @@ -8,6 +8,7 @@
> >   # test[4-6] test 6.15 commit 5b3cd801155f ("ima: limit the number of open-writers integrity violations")
> >   # test[7-8] test 6.15 commit a414016218ca ("ima: limit the number of ToMToU integrity violations")
> > +TST_NEEDS_CHECKPOINTS=1
> >   TST_SETUP="setup"
> >   TST_CLEANUP="cleanup"
> >   TST_CNT=8
> > @@ -171,12 +172,15 @@ test3()
> >   	ima_mmap -f $FILE &
> >   	pid=$!
> > +
> >   	# wait for violations appear in logs
> > -	tst_sleep 1s
> > +	TST_CHECKPOINT_WAKE_AND_WAIT 0
> >   	open_file_read
> >   	close_file_read
> > +	TST_CHECKPOINT_WAKE 0
> > +
> >   	validate $num_violations $count $search
> >   	# wait for ima_mmap to exit, so we can umount

