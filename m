Return-Path: <linux-integrity+bounces-9795-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wkTUIvrqL2oCJAUAu9opvQ
	(envelope-from <linux-integrity+bounces-9795-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:07:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAA685FA8
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 14:07:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ohXGazeL;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9795-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9795-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45931301629F
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2026 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334203E558A;
	Mon, 15 Jun 2026 12:03:45 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B0B3E51EB;
	Mon, 15 Jun 2026 12:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525025; cv=none; b=t7BFa2kSpT2LPbXaef3Vcazf9JH85d27nNhqIt+3uDtD1xkm+Hx4ZpTIAK3HjU60gClNRlSMit3bwIW00lXUnmf/9E5taW74UFEGv0nUcuLTLcBIGlnSenMCQ9kVDlM7uUY+lfJJ+GihMvjh2dLz4a08q2pjAGStnq6iHsvl0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525025; c=relaxed/simple;
	bh=lqfFkNbDQmrOC6uPqWShpBYFXKM9j3+Er+odvPFcJZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQhl0Vnk+h7OIeUo07E1AAOLn2a7Mz7nvLGiyw7ukEGPrVAAHXQRN0hoFXuVlq8ekPvHseZYSE6nCWBbnlt9M07W3uBzqauV2H5zHzXjIE23OA1N3hwiUtNiz5X3s5Q57CzWqRWTSZ81Pl2FsP3bvOFMlgC5kz7p42l0ZAsFSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohXGazeL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 10B7C1F000E9;
	Mon, 15 Jun 2026 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525023;
	bh=lauTaU/hwbI7xelp70CYTlNMJ9kOm8UZP4bhCl24enE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ohXGazeLe6Sn/FNoq58e51RKpK+E6dxlTE9V0BG/P9JqxKJ7++kDvzJOcUN7RZTZY
	 9eo0Mlw0LiEXf1trE52NWcpV6IgcHZxkO4Io+IniQQv6axLPNBcwx0Jzh148tkRsnr
	 besInMeNXWBKjCkR3LpH0Iib6HmhougIhXupAnxRyUeKUOQWExYhWA1+z2w4Wg2Nw3
	 1UrXFUTJbfwU0qVqjSjrHKZmLurQfN+bmSFML7PpBwiwMOx+1dfYEYHJsK5qf978PO
	 ugQ9cmrnOna7QNXybdS3MfI9K334nB9rWvZuzGbo0y9Rx8J/BA0zlc6rUYtcEDSFX4
	 DA3EZoJVoFyeQ==
Date: Mon, 15 Jun 2026 15:03:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Harald Hoyer <harald@redhat.com>, stable@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: fix event_size output in
 tpm1_binary_bios_measurements_show
Message-ID: <ai_qHCQXhCakDUHV@kernel.org>
References: <20260522094440.583766-2-thorsten.blum@linux.dev>
 <ahBSJ-hVcVHEWTeZ@kernel.org>
 <ainKo2YOGN0hxWwE@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainKo2YOGN0hxWwE@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9795-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:colin.i.king@gmail.com,m:harald@redhat.com,m:stable@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:coliniking@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBCAA685FA8

On Wed, Jun 10, 2026 at 10:35:47PM +0200, Thorsten Blum wrote:
> On Fri, May 22, 2026 at 03:55:03PM +0300, Jarkko Sakkinen wrote:
> > On Fri, May 22, 2026 at 11:44:38AM +0200, Thorsten Blum wrote:
> > > Commit 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
> > > split the output to write the endian-converted event header first and
> > > then the variable-length event data.
> > > 
> > > However, the split was at sizeof(struct tcpa_event) - 1, even though
> > > event_data was a zero-length array, and later a flexible array member,
> > > both of which already excluded the event data.
> > > 
> > > Therefore, the current code writes the first three bytes of event_size
> > > from the endian-converted header and then the last byte from the raw
> > > header, which can emit a corrupted event_size on PPC64, where
> > > do_endian_conversion() maps to be32_to_cpu().
> > > 
> > > Split one byte later to write the full endian-converted header first,
> > > followed by the variable-length event->event_data.
> > > 
> > > Fixes: 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > > Changes in v2:
> > > - Minimal fix without using seq_write()
> > > - v1: https://lore.kernel.org/lkml/20260521093639.162095-3-thorsten.blum@linux.dev/
> > > ---
> > >  drivers/char/tpm/eventlog/tpm1.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> > > index e7913b2853d5..0397e3361020 100644
> > > --- a/drivers/char/tpm/eventlog/tpm1.c
> > > +++ b/drivers/char/tpm/eventlog/tpm1.c
> > > @@ -236,12 +236,12 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
> > >  
> > >  	temp_ptr = (char *) &temp_event;
> > >  
> > > -	for (i = 0; i < (sizeof(struct tcpa_event) - 1) ; i++)
> > > +	for (i = 0; i < sizeof(struct tcpa_event); i++)
> > >  		seq_putc(m, temp_ptr[i]);
> > >  
> > >  	temp_ptr = (char *) v;
> > >  
> > > -	for (i = (sizeof(struct tcpa_event) - 1);
> > > +	for (i = sizeof(struct tcpa_event);
> > >  	     i < (sizeof(struct tcpa_event) + temp_event.event_size); i++)
> > >  		seq_putc(m, temp_ptr[i]);
> > >  
> > 
> > This was really good catch, thank you. I'll apply in a minute.
> 
> Has this already been applied somewhere?

My bad, and thanks for pingin! queued

> 
> Thanks,
> Thorsten

BR, Jarkko

