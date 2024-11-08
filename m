Return-Path: <linux-integrity+bounces-4075-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC2C9C17D6
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 09:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89641C20E62
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Nov 2024 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735A1DD53C;
	Fri,  8 Nov 2024 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MOySbmjT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pJMJ/Tf9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MOySbmjT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pJMJ/Tf9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53571DB55C
	for <linux-integrity@vger.kernel.org>; Fri,  8 Nov 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054252; cv=none; b=e7SWBD34EdjV6/JnxwU29slFLiUD0fuba+cBfBD/ZFhVRI3IgDU/snzBTRZLRHgui1sVrg0d2eIYgzF0tLesCf251i5jinaye4xbuWUXmetCcB0hRL9UAjJu8vMX/UxRdC7qF2KaGZ1aTBSmrfBdaBn6vOFLokX+15L5EFAe9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054252; c=relaxed/simple;
	bh=jzMXZm5Z1wEQb3Czl9f7Fg4wv10MBcWbGg1nNmAIEbg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+KE8l6xLqw6oQvLA1I3motTnhfnlvYJaWUiXuJqniFo4yLof0KRjJwl2xu33slYeKywm2A6O5PZXFdrXXmtLEhMZ3aqn6DBCshEpcXGjSemkuCUNsxkB1ie8Hzb3ygQg/bj4N9/q13DfRDK9/c0jGrC0jkkytSvoZ3KkAHk2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MOySbmjT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pJMJ/Tf9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MOySbmjT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pJMJ/Tf9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4AC21FE05;
	Fri,  8 Nov 2024 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731054248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4l/icQ8f2Qg0KkTilVsnKksw3Q7mrCyyVE4nAp3y2o=;
	b=MOySbmjTD9l1OScQOmk7VxjT4EY2fMtsU+7ZXNJhMvpTykiwXqB9Y3LzZnnWzKU5r62QX6
	6hZJo8so70r8F5cAeBbX9pUY2EnzRc3YXNwmJk3f3aIFwGrED0uE0G/h/saBlEwBeY6Fkv
	9NWNRXLx2sYxgbyfCDuEgRR55A7fpuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731054248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4l/icQ8f2Qg0KkTilVsnKksw3Q7mrCyyVE4nAp3y2o=;
	b=pJMJ/Tf94mg8zcAHvAlCJdHXoXaKxrhOcVlG02TLLXSZR6f0MiVIAdd/Hqhg7mVRXtk7He
	ol86J/KNQmTgPdAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MOySbmjT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="pJMJ/Tf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731054248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4l/icQ8f2Qg0KkTilVsnKksw3Q7mrCyyVE4nAp3y2o=;
	b=MOySbmjTD9l1OScQOmk7VxjT4EY2fMtsU+7ZXNJhMvpTykiwXqB9Y3LzZnnWzKU5r62QX6
	6hZJo8so70r8F5cAeBbX9pUY2EnzRc3YXNwmJk3f3aIFwGrED0uE0G/h/saBlEwBeY6Fkv
	9NWNRXLx2sYxgbyfCDuEgRR55A7fpuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731054248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4l/icQ8f2Qg0KkTilVsnKksw3Q7mrCyyVE4nAp3y2o=;
	b=pJMJ/Tf94mg8zcAHvAlCJdHXoXaKxrhOcVlG02TLLXSZR6f0MiVIAdd/Hqhg7mVRXtk7He
	ol86J/KNQmTgPdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8771D13967;
	Fri,  8 Nov 2024 08:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QdnjH6jKLWdDDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 08 Nov 2024 08:24:08 +0000
Date: Fri, 08 Nov 2024 09:24:08 +0100
Message-ID: <875xoygml3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Liang <andy.liang@hpe.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
    Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	jenifer.golmitz@hpe.com
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
In-Reply-To: <92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
References: <20241107112054.28448-1-tiwai@suse.de>
	<87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
	<878qtvi5he.wl-tiwai@suse.de>
	<262eff2e-90c5-45db-81d7-30b1cc217ef4@linux.ibm.com>
	<92a9ca13-ead3-41f8-88fd-ab9540c0e9b3@linux.ibm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4AC21FE05
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	FREEMAIL_CC(0.00)[linux.ibm.com,suse.de,molgen.mpg.de,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,hpe.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 07 Nov 2024 20:31:37 +0100,
Stefan Berger wrote:
> 
> 
> 
> On 11/7/24 2:06 PM, Stefan Berger wrote:
> > 
> > 
> > On 11/7/24 7:38 AM, Takashi Iwai wrote:
> >> On Thu, 07 Nov 2024 13:17:33 +0100,
> >> Paul Menzel wrote:
> >>> 
> >>> Dear Takashi,
> >>> 
> >>> 
> >>> Thank you for the patch.
> >>> 
> >>> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> >>>> The TPM2 ACPI table may request a large size for the event log, and it
> >>>> may be over the max size of kmalloc().  When this happens, the driver
> >>> 
> >>> What is kmalloc()¢s maximum size?
> >> 
> >> 128kB or so, IIRC.
> >> And according Andy, the table can be over 4MB.
> > 
> > Can you copy the contents of the file on that machine and tell us
> > what size it has:
> > 
> > cp /sys/kernel/security/tpm0/binary_bios_measurements ./
> 
> Actually, you may need to have the contents parsed by a user space
> tool since the driver does not detect where the actual end may be:
> 
>  tsseventextend -if ./binary_bios_measurements -sim -v
> 
> This may give you a feeling for how much is in that file and then
> you'd have to truncate it into half for example and see whether it
> still parses the same. My point is that we haven't seen such
> excessive-sized logs so far and following the parsing above we may
> find something like this more useful than allocating possibly large
> amounts of memory that a buggy ACPI table indicates (+ notify
> manufacturer):
> 
>   if (len > MAX_TPM_LOG_SIZE) {
>       dev_err(&chip->dev, "Truncated excessive-sized TPM log of %d
> bytes\n", len);
>       len = MAX_TPM_LOG_SIZE;
>   }
> 
> If you send me the log I'd look at it.

It's rather a question Andy; could you check give the requested info?


thanks,

Takashi

