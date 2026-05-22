Return-Path: <linux-integrity+bounces-9640-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKHCLeFTEGodWQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9640-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 15:02:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138D5B4B45
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 107653078AE9
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C625B097;
	Fri, 22 May 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boBeDR9c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8A21FF21;
	Fri, 22 May 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454508; cv=none; b=mCfV9unbyQs49nrNEEkYjexcyoDnXAtDot50aiLWWXW1iRmIqwzB4vPGmWVF7SIcIXvvIBAgcFwUA5xLjts75uDefEPcBV9mjvdG/CjlA1retiOnXzcVKqAsaRtKXVpPEFOJThZpk5bA9OxmIkuCKfdUm3JX7AroYMEPkn++19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454508; c=relaxed/simple;
	bh=vdogcFKe646uv74QOnnhuq88OgXuUjsrBQQ+pF9YdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVPPNfNISLJNKrUR97WkFYiPPrlEHwbm39xE3WZ4d7xwguZXvJ4QIgKUklWyoKZDGDlfb29ryjn/hia8bRIaGN0PH8xONkXUlQkCCK+4arP/HSyR9VMHlRBMPcklF17/MAjy3wa0mMgoCDMg1HtYYbm4I3DdraE0oV8IHqhCmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boBeDR9c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4D53A1F000E9;
	Fri, 22 May 2026 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454506;
	bh=1kR6KRiD18b/U/Z4QqDvzelqLFSukmINagpU64hRBwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=boBeDR9crAs/mgfv3iBsCeTiB78+De/nNCs7f3I01tDVOeCeaDWT6Fm4jasWHY5eN
	 RNHd2s1DmMXZn0Lj/nGsk8izs8P2ps7Kh/HHIgMb1fI+rhVh5Ek0KCsUkV2bN7/sn7
	 nGav7fZIVaIyXfjZe0XruW19nlk+N0IOemIyaA8FWgOEi3vI7M21lqeP2g20wBLNmz
	 cbBg1+3JQHnXC8ECsHQJksrxgDzkZXwuBH+yBOXKoXkoa/SJkabm41XmF9FH+lW0Pp
	 Tdv5zL3ilWLj1iKLFJc10ty4OJPqEqrexKsHz5NQACzeRE8UUBXhEl+hqvxm3atpBw
	 uiwZA3soZHKWg==
Date: Fri, 22 May 2026 15:55:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Harald Hoyer <harald@redhat.com>, stable@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: fix event_size output in
 tpm1_binary_bios_measurements_show
Message-ID: <ahBSJ-hVcVHEWTeZ@kernel.org>
References: <20260522094440.583766-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522094440.583766-2-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9640-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8138D5B4B45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:44:38AM +0200, Thorsten Blum wrote:
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
> Split one byte later to write the full endian-converted header first,
> followed by the variable-length event->event_data.
> 
> Fixes: 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Minimal fix without using seq_write()
> - v1: https://lore.kernel.org/lkml/20260521093639.162095-3-thorsten.blum@linux.dev/
> ---
>  drivers/char/tpm/eventlog/tpm1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index e7913b2853d5..0397e3361020 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -236,12 +236,12 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
>  
>  	temp_ptr = (char *) &temp_event;
>  
> -	for (i = 0; i < (sizeof(struct tcpa_event) - 1) ; i++)
> +	for (i = 0; i < sizeof(struct tcpa_event); i++)
>  		seq_putc(m, temp_ptr[i]);
>  
>  	temp_ptr = (char *) v;
>  
> -	for (i = (sizeof(struct tcpa_event) - 1);
> +	for (i = sizeof(struct tcpa_event);
>  	     i < (sizeof(struct tcpa_event) + temp_event.event_size); i++)
>  		seq_putc(m, temp_ptr[i]);
>  

This was really good catch, thank you. I'll apply in a minute.

BR, Jarkko

