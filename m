Return-Path: <linux-integrity+bounces-4074-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F69C17CF
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 09:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A82843ED
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6411DD861;
	Fri,  8 Nov 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GDzBmlBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2igt2uaZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GDzBmlBg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2igt2uaZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825C1CBE89
	for <linux-integrity@vger.kernel.org>; Fri,  8 Nov 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054142; cv=none; b=fIQPtNPsMOTO+SsdZY82NrNvSgYOS0yTp7Yxel7PAvcxZhSLkMgM8SebFYtmKdel8+gD9nnd2nkWQABFqJvqqUmvZezZBNjlwTyl3qoi9+xInqqyw4a/a/ZzHZlALGljCmllyOe1u5JQ2IWfa5eBsHvINoLP2gCReWyqTEWHGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054142; c=relaxed/simple;
	bh=f6EoFzHRpCMkEuXIjPRhDKjjeZQbSKQ65bGXAVW6/vw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIj91Xa/WxlB+yETW78C0ZJQpaPHXwsFLfFFvz95SWr/EHKpOcL+nVswIlC2kxpOw3ZYrKUaK8y/t6MtbxQ6ok3HqcAG20VculFOkH9BQV93X9zakJvrtUjCmQqkQpEx0FDcIuYfJmp1AAbtn8FWlpiBBT27JI5TrldcmCFzrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GDzBmlBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2igt2uaZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GDzBmlBg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2igt2uaZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01C491FE05;
	Fri,  8 Nov 2024 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731054139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JD92u0ApEqPQXZLX5XdEaWojoMpzbZHbQYqn6h7qTJs=;
	b=GDzBmlBgXKUYnfva+vcwFmPS0M/XKoxmOU8oL5mXnr6A4dciXf+1PcAnDBTRIgiwk0EpfQ
	4cRm98cqQsNAl1b04iSva76+L4+wMcch561lZMKRU06DOLd/YoEecdsROUowLUtdOBYgty
	z6hypSScExo4uivvQ9WlbruWa0Osdio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731054139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JD92u0ApEqPQXZLX5XdEaWojoMpzbZHbQYqn6h7qTJs=;
	b=2igt2uaZhfmjo2bRiaOXgnbnRbBTMWSkmnY5PPlbP4wRRUTrjtyXG2O3vVD1L53UWVUBSH
	5H9jufzxni2qFNAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731054139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JD92u0ApEqPQXZLX5XdEaWojoMpzbZHbQYqn6h7qTJs=;
	b=GDzBmlBgXKUYnfva+vcwFmPS0M/XKoxmOU8oL5mXnr6A4dciXf+1PcAnDBTRIgiwk0EpfQ
	4cRm98cqQsNAl1b04iSva76+L4+wMcch561lZMKRU06DOLd/YoEecdsROUowLUtdOBYgty
	z6hypSScExo4uivvQ9WlbruWa0Osdio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731054139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JD92u0ApEqPQXZLX5XdEaWojoMpzbZHbQYqn6h7qTJs=;
	b=2igt2uaZhfmjo2bRiaOXgnbnRbBTMWSkmnY5PPlbP4wRRUTrjtyXG2O3vVD1L53UWVUBSH
	5H9jufzxni2qFNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC64613967;
	Fri,  8 Nov 2024 08:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q8/WLDrKLWeqDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Nov 2024 08:22:18 +0000
Date: Fri, 08 Nov 2024 09:22:18 +0100
Message-ID: <877c9egmo5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Paul Menzel" <pmenzel@molgen.mpg.de>,
	"Takashi Iwai" <tiwai@suse.de>,
	"Peter Huewe" <peterhuewe@gmx.de>,
	"Jason Gunthorpe" <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>,
	"Andy Liang" <andy.liang@hpe.com>,
	<jenifer.golmitz@hpe.com>
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
In-Reply-To: <D5G8LOUJ8VSU.929AI8NDTZKI@kernel.org>
References: <20241107112054.28448-1-tiwai@suse.de>
	<87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
	<D5G8LOUJ8VSU.929AI8NDTZKI@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[molgen.mpg.de,suse.de,gmx.de,ziepe.ca,vger.kernel.org,hpe.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 07 Nov 2024 21:42:50 +0100,
Jarkko Sakkinen wrote:
> 
> On Thu Nov 7, 2024 at 2:17 PM EET, Paul Menzel wrote:
> > Dear Takashi,
> >
> >
> > Thank you for the patch.
> >
> > Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> > > The TPM2 ACPI table may request a large size for the event log, and it
> > > may be over the max size of kmalloc().  When this happens, the driver
> >
> > What is kmalloc()¢s maximum size?
> 
> For reference: https://elixir.bootlin.com/linux/v6.11.6/source/include/linux/slab.h#L367
> 
> So it would be 1UL << 22 i.e. 4 MB at least. Not sure if MAX_PAGE_ORDER
> is larger than 10 on x86-64.

Ah thanks, it has been changed.


Takashi

