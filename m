Return-Path: <linux-integrity+bounces-9769-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hGwBGVpAJmrhTwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9769-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 06:08:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B03286528C8
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 06:08:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LKEWJIWH;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9769-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9769-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B387D3026F2D
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 04:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B17223328;
	Mon,  8 Jun 2026 04:06:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C0248881;
	Mon,  8 Jun 2026 04:06:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780891610; cv=none; b=H5ej6+4O9uORt94dbcjuYxEccGT4igrUyh1ls6aSPf45RyNGq2WHf/kO3+TAAITrbY7gSBROrH9hbxf5uKoAzGtZvuTGBSVTMebVQCipuc1w3Kf52kvHnwulVRAuh+dKnIi9gS66r3HRAfX7xHmovqsp9xIC+NTR/+AVNEVkYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780891610; c=relaxed/simple;
	bh=nphKq6GM0FKKZ/762pKGnPnd2KrCVKcJBACQx7CGEPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4dYEbsTEhCg6Xh0wSro1On/MCmsH9NIQ/Oet2tGt2RD6qgZqoQg2kGiUaJGl5scd6ZKyITWr30aMQ9+eTSbh0nvdEEVQyFOAnKhb+94Xy0LuwvBw5IhyCq0AEWOpJ/s4QQ8BKvaVY50k4OD+GH5ZjXnr2DXwYvxeRTob6lnbKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKEWJIWH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8E0591F00893;
	Mon,  8 Jun 2026 04:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780891609;
	bh=DcpvChp7/wlm15D/34wMdWBkYgW5+87WVabH6cfdJ+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LKEWJIWHp0f13PQlkoAinp0ApgoNC13jix4VQHORTYZQzwUGqSnu87um+omU4LNuU
	 mKsMwEGR6HLT8/H1esDkB8/66RInBTImHWSKrJMB22ELPrWGUpo1ohQbGoVFzNpqDJ
	 mFy0S2B6NYFt3S37L60SuPJkFzwZf6RvLtkx9xPbsqpbvhqyI7Oz4NU0MFUt0Muc2A
	 0Gz4yKNdcMoJxnDCIrAqyvQ9u8Yx4JcUSZj5waZWR6eIGvSut/G+//XgxLaLdWW1g3
	 LV/7GfVWT0tgG9cM+2l5m2Lf8Wtts7pLg06fwZRhOsbW+zVg4ANgmBfz7dSEmXv5c/
	 leq4bR0kPy71w==
Date: Mon, 8 Jun 2026 07:06:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ZongYao.Chen@linux.alibaba.com
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nayna Jain <nayna@linux.vnet.ibm.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: eventlog: tpm2: allow event log entries ending at
 the log boundary
Message-ID: <aiY_1doMftc_2WRp@kernel.org>
References: <20260604025356.3436943-1-ZongYao.Chen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604025356.3436943-1-ZongYao.Chen@linux.alibaba.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,linux.vnet.ibm.com,linux.alibaba.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9769-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ZongYao.Chen@linux.alibaba.com,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:nayna@linux.vnet.ibm.com,m:tianjia.zhang@linux.alibaba.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B03286528C8

On Thu, Jun 04, 2026 at 10:53:47AM +0800, ZongYao.Chen@linux.alibaba.com wrote:
> From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> 
> The TPM2 firmware event log buffer is a half-open range:
> [bios_event_log, bios_event_log_end). An entry ending exactly at
> bios_event_log_end is still inside the buffer; only an entry extending
> past that address is malformed.
> 
> The TPM2 seq_file iterator did not handle this boundary consistently.
> The TCG_EfiSpecIdEvent header had to satisfy "addr + size < limit".
> Later events were rejected when "addr + size >= limit". Firmware that
> packs the final measurement tightly at the end of the log can therefore
> lose that measurement. If it is the first measurement after the spec ID
> header, binary_bios_measurements shows only the header.
> 
> This has been observed on bare-metal systems whose UEFI enables the SM3
> PCR bank, but the bug is not SM3-specific. Any tightly packed TPM2 log
> whose final event ends at bios_event_log_end can hit it.
> 
> Accept entries that end exactly at the log boundary by rejecting only
> "addr + size > limit". An accepted boundary entry has its last byte at
> limit - 1, so this does not allow reading past the buffer. Keep
> zero-length entries rejected.
> 
> Also treat addr >= limit as EOF in tpm2_bios_measurements_start().
> After seq_file restarts from a later position, start() can scan past a
> valid final entry and leave addr equal to bios_event_log_end. That
> address is the end marker, not another event header.
> 
> Leave the "marker >= limit" check in tpm2_bios_measurements_next()
> unchanged. There, marker is already the start of the next event, so
> "marker == limit" means EOF.

This is the most unclear bug description I've read for a long
time. Please explain what's the problem in simple teerms and
how this solves this. Mixing up pseudo-code and text does not
help.

> 
> Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
> Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> ---
>  drivers/char/tpm/eventlog/tpm2.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index 37a05800980c..6b65d872e43a 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -54,31 +54,38 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>  	size = struct_size(event_header, event, event_header->event_size);
>  
>  	if (*pos == 0) {
> -		if (addr + size < limit) {
> -			if ((event_header->event_type == 0) &&
> -			    (event_header->event_size == 0))
> -				return NULL;
> -			return SEQ_START_TOKEN;
> -		}
> +		if (addr + size > limit)
> +			return NULL;
> +		if (event_header->event_type == 0 &&
> +		    event_header->event_size == 0)
> +			return NULL;
> +		return SEQ_START_TOKEN;

This looks unnecessary turnover. Please rethink. We should be minizing
the diff for bug fixes, not the other way around.

>  	}
>  
>  	if (*pos > 0) {
>  		addr += size;
> +		if (addr >= limit)
> +			return NULL;
>  		event = addr;
>  		size = calc_tpm2_event_size(event, event_header);
> -		if ((addr + size >=  limit) || (size == 0))
> +		if ((addr + size > limit) || size == 0)
>  			return NULL;
>  	}
>  
>  	for (i = 0; i < (*pos - 1); i++) {
> +		if (addr >= limit)
> +			return NULL;
>  		event = addr;
>  		size = calc_tpm2_event_size(event, event_header);
>  
> -		if ((addr + size >= limit) || (size == 0))
> +		if ((addr + size > limit) || size == 0)
>  			return NULL;
>  		addr += size;
>  	}
>  
> +	if (addr >= limit)
> +		return NULL;
> +
>  	return addr;
>  }
>  
> @@ -115,7 +122,7 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
>  	event = v;
>  
>  	event_size = calc_tpm2_event_size(event, event_header);
> -	if (((v + event_size) >= limit) || (event_size == 0))
> +	if (((v + event_size) > limit) || event_size == 0)
>  		return NULL;
>  
>  	return v;
> -- 
> 2.47.3
> 

BR, Jarkko

