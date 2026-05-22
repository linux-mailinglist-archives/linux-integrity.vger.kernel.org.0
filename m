Return-Path: <linux-integrity+bounces-9630-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENawBKajD2ocOQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9630-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 02:30:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB05AD70A
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84B2E300B454
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C40212548;
	Fri, 22 May 2026 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tiq0LxJs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48F2264D9;
	Fri, 22 May 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409825; cv=none; b=ZuYJ8+ETmaTFoXicOLEMfXK5stqSQGglGOsElR4VtHhE2n4uSFyC1cHpAdB5h/8Fg8f/AU77OYWMRTgfoY9oEN4wNv2ibo0LDi6aQlwZFreQT5M0izvIZInQwoubM2To74TR+bEyiBMLhxkidx6NwQ5SpM+8bnxIo2LaiSfdA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409825; c=relaxed/simple;
	bh=S0c6Iuqh1hXfmjDedEAPgBoAYh+0QIkzzFkgvMvIWXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJmPrHxn+Ba0hKQnyoYA30PHENBaQkvXCy2LYtHs0E9vqWF8OK+I9A8f9RD7rB50UM0GlDhTn+4DV60y48jTd5Bve7g0cCWdxs2do8l3LTepJ0w6dt72IYCY9XvPOhHFNZ131wLlF4vYOwX9hAfpSQmEcaEB2541heAs4hzOobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tiq0LxJs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B11501F000E9;
	Fri, 22 May 2026 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779409824;
	bh=NJ+iWzlXjpdNPB1b1MIoNMQEZk5H4WM89517DwKxXLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tiq0LxJsSyL3IUm398LOnTZB+scTsQswtX1QX2r5o6vipTX6NckH1y3d5rIyT9v5O
	 4d/h3921MgHiZJMjUHmzb+9BNpOSdrg488dSR3DGUTMlV0tXdgPOfqWRdxV0qoe459
	 zE4QhF2zCiE7VEd0lFUMluIxp/TK2yRYTodY402vyE1E3dErRNqnpcQKaY2QKLtnL+
	 IxoSxvmsIQDqVVAR76TlZQ7zyzf64hcMJi/28OCPuVUt3nRqHmWUxaJjrpVBQ6a1ek
	 fNWtd2pG4xjcAFjxGPOTyA7FNjLwWfCf4jtrY2b/qbBWierW71mqpfw9+qWFuBUoUt
	 J+KT0030o09Uw==
Date: Fri, 22 May 2026 03:30:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Harald Hoyer <harald@redhat.com>, stable@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: fix event_size output in
 tpm1_binary_bios_measurements_show
Message-ID: <ag-jnBZl2rtx1Pjn@kernel.org>
References: <20260521093639.162095-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521093639.162095-3-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9630-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: ADAB05AD70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:36:39AM +0200, Thorsten Blum wrote:
> Commit 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
> split the output to write the endian-converted event header first and
> then the variable-length event data.
> 
> However, the split was at sizeof(struct tcpa_event) - 1, even though
> event_data was a zero-length array, and later a flexible array member,
> both of which already excluded the event data.
> 
> Therefore, the current code writes the first three bytes of event_size
> from the endian-converted header and then the last byte from the raw
> header, which can emit a corrupted event_size on PPC64, where
> do_endian_conversion() maps to be32_to_cpu().
> 
> Use seq_write() to write the full endian-converted header, followed by
> the variable-length event->event_data.
> 
> Drop the obvious comment while at it.
> 
> Fixes: 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/char/tpm/eventlog/tpm1.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Got it, I think you're probably right.

> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index e7913b2853d5..291720e89d91 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -224,29 +224,17 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
>  {
>  	struct tcpa_event *event = v;
>  	struct tcpa_event temp_event;
> -	char *temp_ptr;
> -	int i;
>  
>  	memcpy(&temp_event, event, sizeof(struct tcpa_event));
>  
> -	/* convert raw integers for endianness */

spurious change

>  	temp_event.pcr_index = do_endian_conversion(event->pcr_index);
>  	temp_event.event_type = do_endian_conversion(event->event_type);
>  	temp_event.event_size = do_endian_conversion(event->event_size);
>  
> -	temp_ptr = (char *) &temp_event;
> -
> -	for (i = 0; i < (sizeof(struct tcpa_event) - 1) ; i++)
> -		seq_putc(m, temp_ptr[i]);

Why changing condition does not fix the bug? This could be just +-1 line
change.

> -
> -	temp_ptr = (char *) v;
> -
> -	for (i = (sizeof(struct tcpa_event) - 1);
> -	     i < (sizeof(struct tcpa_event) + temp_event.event_size); i++)
> -		seq_putc(m, temp_ptr[i]);
> +	seq_write(m, &temp_event, sizeof(temp_event));
> +	seq_write(m, event->event_data, temp_event.event_size);
>  
>  	return 0;
> -
>  }
>  
>  static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)

BR, Jarkko

