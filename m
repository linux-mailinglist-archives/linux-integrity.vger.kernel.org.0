Return-Path: <linux-integrity+bounces-4057-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BE9C05F7
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 13:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D771F22CE3
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E586D20FA9B;
	Thu,  7 Nov 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wNAg25Qz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="va8P6Jhi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wNAg25Qz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="va8P6Jhi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882D1DBB37
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983105; cv=none; b=gi2/rZr+oQqeBVWpVeO2qXr4urdUqc5pYvch2Gk6mbSo8MpC710edu+jkr/TDh670PHUecCYqvkPpM4UagZn0deJ7F4qu6FFjOw8KBw4JEdRhSlzbBpyenGTekEetu8xzmTwdV2z86CjHs9HSfqnCfq3Aai6Rzv6GRfcsgg/TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983105; c=relaxed/simple;
	bh=GVEJe/Pa+0urrfYyJZd6pDtauclu8Y8ButtJkvTE3Ck=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeFSOtzCotT5kI4NWayeHrxEaM/L1IjdI0IM2DssQ/HEJlE+LsnG6bcmo6VkjIpoEHqeLr4piEzPvriNpWTOQCXXq0Bv85KqDivOhIVz1X8S+MtKShM+blj4A/V5j6dpyW876MqrElKEbisD9c2UvC2K8wseTwCKk/H64mwufDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wNAg25Qz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=va8P6Jhi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wNAg25Qz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=va8P6Jhi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35C8421C76;
	Thu,  7 Nov 2024 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730983102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujWYTmn4E6mlX795CL7gar8SkmcomwAfdjLDtAtSViw=;
	b=wNAg25QzzBbMHvcHVXGC6bW6RwZpXO/eNR8g1zhvvuletTd3kSMMDEnHbV6BKKaRv3NcXy
	VE6UNhva6FJDKmBSJXFqzNE6U5+A4bF9+tWHnswJUDxkKzl/JS5UT5GrKvDlcDyjU5Lr9M
	QjYQGju22ummDCMQyCewpewJmvQs2io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730983102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujWYTmn4E6mlX795CL7gar8SkmcomwAfdjLDtAtSViw=;
	b=va8P6Jhi+HVBOKZQg19u9x2V+15YOXyp9YRvoSLy1HUFxJB8hgM7NXEg+AzkXxuvVA5KAY
	uBkHATG+QR0m6KDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730983102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujWYTmn4E6mlX795CL7gar8SkmcomwAfdjLDtAtSViw=;
	b=wNAg25QzzBbMHvcHVXGC6bW6RwZpXO/eNR8g1zhvvuletTd3kSMMDEnHbV6BKKaRv3NcXy
	VE6UNhva6FJDKmBSJXFqzNE6U5+A4bF9+tWHnswJUDxkKzl/JS5UT5GrKvDlcDyjU5Lr9M
	QjYQGju22ummDCMQyCewpewJmvQs2io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730983102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujWYTmn4E6mlX795CL7gar8SkmcomwAfdjLDtAtSViw=;
	b=va8P6Jhi+HVBOKZQg19u9x2V+15YOXyp9YRvoSLy1HUFxJB8hgM7NXEg+AzkXxuvVA5KAY
	uBkHATG+QR0m6KDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE83B1394A;
	Thu,  7 Nov 2024 12:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qggPOb20LGfZNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 07 Nov 2024 12:38:21 +0000
Date: Thu, 07 Nov 2024 13:38:21 +0100
Message-ID: <878qtvi5he.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	jenifer.golmitz@hpe.com
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
In-Reply-To: <87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
References: <20241107112054.28448-1-tiwai@suse.de>
	<87f11490-06ab-43a5-8058-102722a3c3ba@molgen.mpg.de>
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
	BAYES_HAM(-3.00)[100.00%];
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
	FREEMAIL_CC(0.00)[suse.de,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,hpe.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:url]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 07 Nov 2024 13:17:33 +0100,
Paul Menzel wrote:
> 
> Dear Takashi,
> 
> 
> Thank you for the patch.
> 
> Am 07.11.24 um 12:18 schrieb Takashi Iwai:
> > The TPM2 ACPI table may request a large size for the event log, and it
> > may be over the max size of kmalloc().  When this happens, the driver
> 
> What is kmalloc()¢s maximum size?

128kB or so, IIRC.
And according Andy, the table can be over 4MB.

> > spews the kernel WARNING at the probe time, but the error is
> > eventually ignored in the caller side, and it results in the missing
> > TPM event log exposure.
> > 
> > This patch replaces the devm_kmalloc() call with kvmalloc() to allow
> > larger sizes.  Since there is no devm variant for kvmalloc(), now it's
> > managed manually via devres_alloc() and devres_add().
> 
> As the access to the bug report is restricted, are you at liberty to
> share the system you¢ve seen this on?

Likely yes, as it was reported to SLE15.  Sorry for that.

Basically the info provided there was almost what I put in the
description; the driver got the kernel WARNING and Andy tested my
patch.

If any further info is required, at best ask HPE people here in Cc.


thanks,

Takashi


> > Reported-and-tested-by: Andy Liang <andy.liang@hpe.com>
> > Cc: jenifer.golmitz@hpe.com
> > Link: https://bugzilla.suse.com/show_bug.cgi?id=1232421
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >   drivers/char/tpm/eventlog/acpi.c | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> > index 69533d0bfb51..56f7d73fa6bf 100644
> > --- a/drivers/char/tpm/eventlog/acpi.c
> > +++ b/drivers/char/tpm/eventlog/acpi.c
> > @@ -63,6 +63,13 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
> >   	return n == 0;
> >   }
> >   +static void bios_event_log_release(struct device *dev, void *res)
> > +{
> > +	void **logp = res;
> > +
> > +	kvfree(*logp);
> > +}
> > +
> >   /* read binary bios log */
> >   int tpm_read_log_acpi(struct tpm_chip *chip)
> >   {
> > @@ -71,6 +78,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> >   	void __iomem *virt;
> >   	u64 len, start;
> >   	struct tpm_bios_log *log;
> > +	void **logp;
> >   	struct acpi_table_tpm2 *tbl;
> >   	struct acpi_tpm2_phy *tpm2_phy;
> >   	int format;
> > @@ -136,9 +144,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> >   	}
> >     	/* malloc EventLog space */
> > -	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> > -	if (!log->bios_event_log)
> > +	logp = devres_alloc(bios_event_log_release, sizeof(*logp), GFP_KERNEL);
> > +	if (!logp)
> >   		return -ENOMEM;
> > +	devres_add(&chip->dev, logp);
> > +	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
> > +	if (!log->bios_event_log) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +	*logp = log->bios_event_log;
> >     	log->bios_event_log_end = log->bios_event_log + len;
> >   @@ -164,7 +179,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> >   	return format;
> >     err:
> > -	devm_kfree(&chip->dev, log->bios_event_log);
> > +	devres_release(&chip->dev, bios_event_log_release, NULL, NULL);
> >   	log->bios_event_log = NULL;
> >   	return ret;
> >   }
> 
> The diff looks good to me.
> 
> 
> Kind regards,
> 
> Paul

