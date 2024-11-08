Return-Path: <linux-integrity+bounces-4073-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB499C17D1
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 09:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFFCB23F29
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2461DDA31;
	Fri,  8 Nov 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m5JNaSkg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqJQLcyp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m5JNaSkg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PqJQLcyp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF71DD55B
	for <linux-integrity@vger.kernel.org>; Fri,  8 Nov 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054106; cv=none; b=V1PKNwcQV0aLh4HgoWH+ccT8BlTfteDmo9MMPuSWWLU2hpdmUn5WRQ9t4Y7O8/SOtkA6aMzmmxMS13qyijmcg5dE9sqVzXjn4d7uaYe/kENWrktES4luahp9V4pq2dgvR8Uw/tSaI7UyMpqw3Y1Sr3lk/tPJkxMCAEy6qwmygpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054106; c=relaxed/simple;
	bh=Gq+p3Yam90qSqZxLTKpjpK2oBuit1ODz9k5zFC3zJ14=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+x4tS81bhrCGk8rCK1QRrdZcD1mz5618+TLdeAdyYqsV/HwMHDhZQ+6ogdGTzFgoySoqxg7xbHRQSnUDxdU7ZoGgo+Op3AZacu7X0RvycAa0dS85BSAjfHBZNtuE1Us8+gWuQC4J7ZZv5P9N8kYDRKlsKb6DicsIdnDH9nGaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m5JNaSkg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PqJQLcyp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m5JNaSkg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PqJQLcyp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 284CA1FE05;
	Fri,  8 Nov 2024 08:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731054102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJ9cyvW1tggPRMCPjbrt9QXMdy7UIbF6zE+1gn9Wpg=;
	b=m5JNaSkgXU4TsnK8yVNm+k3aN1DUyAqlg/9mhz/H3zqyjjgBx3AJNpQbAZAVhe2Bxz/2+9
	fvAsKbqrm35pNpiwFOwaAGxE/D6Fo+cp7ovRCfbmKJQ/bIpssgMMEjU8L9LyFCblLwYPjV
	34LK3cRoYzfx3hfK0t0DB40SbqDa/rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731054102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJ9cyvW1tggPRMCPjbrt9QXMdy7UIbF6zE+1gn9Wpg=;
	b=PqJQLcypOoXQARl6e/zqlnU+dbIjUHwzVa5eTaZ9C0rg9vg9NxajVoMbp58TyX1nlLMlYk
	mnXOj550D/Hs3bCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m5JNaSkg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PqJQLcyp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731054102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJ9cyvW1tggPRMCPjbrt9QXMdy7UIbF6zE+1gn9Wpg=;
	b=m5JNaSkgXU4TsnK8yVNm+k3aN1DUyAqlg/9mhz/H3zqyjjgBx3AJNpQbAZAVhe2Bxz/2+9
	fvAsKbqrm35pNpiwFOwaAGxE/D6Fo+cp7ovRCfbmKJQ/bIpssgMMEjU8L9LyFCblLwYPjV
	34LK3cRoYzfx3hfK0t0DB40SbqDa/rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731054102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJ9cyvW1tggPRMCPjbrt9QXMdy7UIbF6zE+1gn9Wpg=;
	b=PqJQLcypOoXQARl6e/zqlnU+dbIjUHwzVa5eTaZ9C0rg9vg9NxajVoMbp58TyX1nlLMlYk
	mnXOj550D/Hs3bCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E81E613967;
	Fri,  8 Nov 2024 08:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bn1wNxXKLWeGDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Nov 2024 08:21:41 +0000
Date: Fri, 08 Nov 2024 09:21:41 +0100
Message-ID: <878qtugmp6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Peter Huewe" <peterhuewe@gmx.de>,
	"Jason Gunthorpe" <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>,
	"Andy Liang" <andy.liang@hpe.com>,
	<jenifer.golmitz@hpe.com>
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
In-Reply-To: <D5G8MT5N7M3M.3PW6KDINE6GEF@kernel.org>
References: <20241107112054.28448-1-tiwai@suse.de>
	<D5G8DXQ15SFC.SDV9NC2LH1CF@kernel.org>
	<D5G8MT5N7M3M.3PW6KDINE6GEF@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 284CA1FE05
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,ziepe.ca,vger.kernel.org,hpe.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 07 Nov 2024 21:44:17 +0100,
Jarkko Sakkinen wrote:
> 
> On Thu Nov 7, 2024 at 10:32 PM EET, Jarkko Sakkinen wrote:
> > >
> > > This patch replaces the devm_kmalloc() call with kvmalloc() to allow
> > > larger sizes.  Since there is no devm variant for kvmalloc(), now it's
> > > managed manually via devres_alloc() and devres_add().
> > >
> > > Reported-and-tested-by: Andy Liang <andy.liang@hpe.com>
> > > Cc: jenifer.golmitz@hpe.com
> > > Link: https://bugzilla.suse.com/show_bug.cgi?id=1232421
> >
> > "You are not authorized to access bug #1232421. To see this bug, you must
> > first log in to an account with the appropriate permissions."
> >
> > Please remove  this link as it gives no information without login
> > access, *or* make it available w/o acocunt, *or* repost a bug to the
> > kernel bugzilla.
> >
> > I've been cursing SUSE accounts for over a year now. Never been able
> > to successfully get either to the bugzilla or forums (still I get
> > some weekly spam about the forums). And no, no interest to recall
> > or figure out this problem.
> 
> Just a personal recommendation but I'd create a bug to kernel bugzilla
> and link that to the SUSE bug, and call it a day ;-) It would be the
> least friction approach.

Andy, care to open a new entry on bugzilla.kernel.org?


thanks,

Takashi

