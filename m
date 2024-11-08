Return-Path: <linux-integrity+bounces-4077-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D78C89C191A
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 10:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CEDB20A87
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993B1E0B76;
	Fri,  8 Nov 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiw0Nk2m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrrjDT8U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiw0Nk2m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FrrjDT8U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBB1DED5A
	for <linux-integrity@vger.kernel.org>; Fri,  8 Nov 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058111; cv=none; b=E2kX6fmM86QN3ACJ0f0B2KkJe/iIdhkhL7hhXWdqKppowkzksw44RkvhLNJj37C52xAVjlI21YHOLp5vlSgrt98e59iQlJE4bL1bpiALN4dfRsrK2Ldfz+h1fhHPp6HNZ4abPfFEHII2FKEfRKG1SiNGatbqxdAoZ/1r67Mw6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058111; c=relaxed/simple;
	bh=UgqC21m4ZfGUFX97hJI693BWwW7MG+X1S9jLaado5qo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy6F0nT9/vYZBBRQCqqQdXLxZcuRKCaS8ql7SI6UnY070B5ad0uF2OCY+wVdqqD78Z9p2jyiill2ynM03oH1MZOkZB14lDGh8Pk+McIWLCMPrsCz5SnFHlHsUiyxfn+jmbbldAdWx9/OJO1v6bSHK8+RC2W4cdBwSDKfs7v8itU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiw0Nk2m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FrrjDT8U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiw0Nk2m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FrrjDT8U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 571D91FE17;
	Fri,  8 Nov 2024 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731058107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htljB6dA946sKG358dHD1P89XMUE5jhBzgXvxUdehMg=;
	b=qiw0Nk2mPAGwpJZzo0gUUTJa1knlaZi3ZjXM3YSx1KrOtnZj/6401sP2xK+G+/Gru68xmg
	E7tCKnEMNERYOnBN8I1i2mJWhjxQvuyw3crgTGWPPvuwDuk/HqcUXGfnJG6by8f09aBhmi
	/dJjBAiCpdVkr2M3Wrg6Mt8+9fNfJGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731058107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htljB6dA946sKG358dHD1P89XMUE5jhBzgXvxUdehMg=;
	b=FrrjDT8UL97eU1KgJXlvzqasAI/8jMBiKaWi1oZoSVPdd5sNWWXsI5Qd1hmdZRXRzuy+YB
	YPEOte066R6jNhAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qiw0Nk2m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FrrjDT8U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731058107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htljB6dA946sKG358dHD1P89XMUE5jhBzgXvxUdehMg=;
	b=qiw0Nk2mPAGwpJZzo0gUUTJa1knlaZi3ZjXM3YSx1KrOtnZj/6401sP2xK+G+/Gru68xmg
	E7tCKnEMNERYOnBN8I1i2mJWhjxQvuyw3crgTGWPPvuwDuk/HqcUXGfnJG6by8f09aBhmi
	/dJjBAiCpdVkr2M3Wrg6Mt8+9fNfJGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731058107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htljB6dA946sKG358dHD1P89XMUE5jhBzgXvxUdehMg=;
	b=FrrjDT8UL97eU1KgJXlvzqasAI/8jMBiKaWi1oZoSVPdd5sNWWXsI5Qd1hmdZRXRzuy+YB
	YPEOte066R6jNhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15C541394A;
	Fri,  8 Nov 2024 09:28:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uQwQBLvZLWeQIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Nov 2024 09:28:27 +0000
Date: Fri, 08 Nov 2024 10:28:26 +0100
Message-ID: <87o72qf51h.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Liang, Andy (Linux Ecosystem Engineering)" <andy.liang@hpe.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Paul Menzel
	<pmenzel@molgen.mpg.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe
	<peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"Golmitz, Jenifer (Linux Ecosystem Engineering)" <jenifer.golmitz@hpe.com>
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
In-Reply-To: <PH7PR84MB19575D91A43C2D4C7C842038995D2@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
References: <20241107112054.28448-1-tiwai@suse.de>
	<87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
	<878qtvi5he.wl-tiwai@suse.de>
	<262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
	<92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
	<875xoygml3.wl-tiwai@suse.de>
	<PH7PR84MB19575D91A43C2D4C7C842038995D2@PH7PR84MB1957.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 571D91FE17
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,molgen.mpg.de,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,hpe.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 08 Nov 2024 09:48:38 +0100,
Liang, Andy (Linux Ecosystem Engineering) wrote:
> 
> 
> > On Thu, 07 Nov 2024 20:31:37 +0100,
> > Stefan Berger wrote:
> > > 
> > > 
> > > 
> > > On 11/7/24 2:06 PM, Stefan Berger wrote:
> > > > 
> > > > 
> > > > On 11/7/24 7:38 AM, Takashi Iwai wrote:
> > > >> On Thu, 07 Nov 2024 13:17:33 +0100, Paul Menzel wrote:
> >>  >>> 
> >>  >>> Dear Takashi,
> >>  >>> 
> >>  >>> 
> >>  >>> Thank you for the patch.
> >>  >>> 
> >>  >>> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> >>  >>>> The TPM2 ACPI table may request a large size for the event log, 
> >>  >>>> and it may be over the max size of kmalloc().  When this happens, 
> >>  >>>> the driver
> >>  >>> 
> >>  >>> What is kmalloc()¢s maximum size?
> >>  >> 
> >>  >> 128kB or so, IIRC.
> >>  >> And according Andy, the table can be over 4MB.
> >>  > 
> >>  > Can you copy the contents of the file on that machine and tell us 
> >>  > what size it has:
> >>  > 
> >>  > cp /sys/kernel/security/tpm0/binary_bios_measurements ./
> >>  
> >>  Actually, you may need to have the contents parsed by a user space 
> >>  tool since the driver does not detect where the actual end may be:
> >>  
> >>   tsseventextend -if ./binary_bios_measurements -sim -v
> >>  
> >>  This may give you a feeling for how much is in that file and then 
> >>  you'd have to truncate it into half for example and see whether it 
> >>  still parses the same. My point is that we haven't seen such 
> >>  excessive-sized logs so far and following the parsing above we may 
> >>  find something like this more useful than allocating possibly large 
> >>  amounts of memory that a buggy ACPI table indicates (+ notify
> >> manufacturer):
> >>  
> >>    if (len > MAX_TPM_LOG_SIZE) {
> >>        dev_err(&chip->dev, "Truncated excessive-sized TPM log of %d 
> >>  bytes\n", len);
> >>       len = MAX_TPM_LOG_SIZE;
> >>    }
> >>  
> >>  If you send me the log I'd look at it.
> 
> > It's rather a question Andy; could you check give the requested info?
> 
> 
> https://elixir.bootlin.com/linux/v6.8/source/arch/x86/include/asm/page_types.h#L10
> #define PAGE_SHIFT 12
> #define KMALLOC_SHIFT_MAX (MAX_PAGE_ORDER + PAGE_SHIFT)
>  
> https://elixir.bootlin.com/linux/v6.8/source/include/linux/mmzone.h#L30
> #define MAX_PAGE_ORDER 10
>  
> https://elixir.bootlin.com/linux/v6.8/source/include/linux/slab.h#L309
> #define KMALLOC_MAX_SIZE (1UL << KMALLOC_SHIFT_MAX)
> The max size  = (1UL <<  MAX_PAGE_ORDER + PAGE_SHIFT) = ( 1UL << (10 + 12)) = 2^22 =4,194,304 (4MB)
> 
> For the x86, the max size is 4MB. 

Thanks, it was already corrected by Jarkko :)
But what I meant was about the requests:

> cp /sys/kernel/security/tpm0/binary_bios_measurements ./

and

>   tsseventextend -if ./binary_bios_measurements -sim -v

mentioned in the above.  Could you provide the info?


thanks,

Takashi

