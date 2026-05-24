Return-Path: <linux-integrity+bounces-9655-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v+VSNMOIE2plDAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9655-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 01:24:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 346865C4C52
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 01:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C7CA3006B2C
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 23:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291473B6C08;
	Sun, 24 May 2026 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+pTm8kY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA103B6BFE;
	Sun, 24 May 2026 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779665085; cv=none; b=pGXztA/50WUpTh8BPZ/lW0TcIoBVSyPBx+6rhh53hUHZdFs/49ATYD9vYSbauBN844ita05Xd6L7BFJQKX1P040HR1+jfmNN4ITUW7Q+oWVPJ3sPPNvzOm+D8HpxUMobu+ttiQ1VdhGd5ZIYCX6iSfGW6msDuN87dzVUhqptv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779665085; c=relaxed/simple;
	bh=vsU83orYzsdlCl+47VfF/lLvOW2ArMbBG5O7Ni5vvqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSQTA3lqM6kfjLpqkVyrM/RfBO4+Q9+h+VBaiEhpQ9iFOoFjhdocHT8WyCKuFLKJrIC4eBwUsNC7Di1dmluOSsWoHK7bGOI35sel5H4o0cJqXIkILCkN3T7ZInEKA35fCh0GCXbvxVwf0NI6NfwP/nfj0rz4ZFuzdm6NWJbIDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+pTm8kY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3E3741F000E9;
	Sun, 24 May 2026 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779665082;
	bh=+u8pjGW4BXsHdcbyJdFGfXH/MZL4H7i+cQqLtgYJeMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A+pTm8kY0ywOka1UFYVz6mE6CVtT/t9I0I6HeqjjsLvjWF/DX0AGEBtbBWIVrV6/i
	 yM7x5VDHlfVK8MPkSW7fakSJ8ixTirMyCCdCZ6dpOh9tFC8MB6o4YVLazl4h0tvV+r
	 HkIVdgi3W2PCbv//ZjYIATPXphT0D5ZqaJtELOz/cuzt6nl/o7ALP2w+qlX4lkkoy0
	 F2Af77t9zgDqUa801RqtN1bnHYpsmckyWi37t04XGlwSLxvDEHpPYPUaAK6hnAlC6B
	 T8y2Uh+jioZoYZAeHrxu6ckiJQecqjVjClM+dLZNbslCdJipM8ymjc+G38QW6U+jS9
	 4YAdDML6vWzJQ==
Date: Mon, 25 May 2026 02:24:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	noodles@fb.com, James.Bottomley@hansenpartnership.com,
	kernel-team@meta.com
Subject: Re: [PATCH] tpm: cap tpm_buf_append() at TPM_BUFSIZE, not PAGE_SIZE
Message-ID: <ahOItgfj4k-NLAPa@kernel.org>
References: <20260524-tpm-v1-1-2420a5977da6@debian.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524-tpm-v1-1-2420a5977da6@debian.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,fb.com,hansenpartnership.com,meta.com];
	TAGGED_FROM(0.00)[bounces-9655-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 346865C4C52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 10:01:17AM -0400, Breno Leitao wrote:
> tpm_buf_append() guards against overflow of the underlying buffer by
> comparing the running length against PAGE_SIZE. Every other site in the
> TPM core uses TPM_BUFSIZE (4096) as the protocol-level cap on TPM
> command and response sizes.
> 
> On 4K-page kernels PAGE_SIZE == TPM_BUFSIZE, so the two caps coincide
> and the inconsistency is invisible. On kernels with a larger base page
> size, e.g. CONFIG_ARM64_64K_PAGES=y or 16K pages, PAGE_SIZE exceeds
> TPM_BUFSIZE.
> 
> This is a latent bug rather than user-visible bug, given most of the
> cases PAGE_SIZE = 4096. The mismatch is still worth fixing because
> future callers (e.g. the proposed TPM_BUFSIZE increase to 8 KiB, and the
> Secure Launch tpm_buf rework) rely on the overflow flag being
> authoritative.
> 
> Use TPM_BUFSIZE instead of PAGE_SIZE so the append-time check
> matches the transmit-time cap on every page size.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: a74f8b36352e ("tpm: introduce tpm_buf")
> ---

There is no bug w/o a sympton of some sort. Not sure what the problem is here.

>  drivers/char/tpm/tpm-buf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index dc882fc9fa9e..8da5de0f7159 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -7,6 +7,8 @@
>  #include <linux/module.h>
>  #include <linux/tpm.h>
>  
> +#include "tpm.h"
> +
>  /**
>   * tpm_buf_init() - Allocate and initialize a TPM command
>   * @buf:	A &tpm_buf
> @@ -108,7 +110,7 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>  	if (buf->flags & TPM_BUF_OVERFLOW)
>  		return;
>  
> -	if ((buf->length + new_length) > PAGE_SIZE) {
> +	if ((buf->length + new_length) > TPM_BUFSIZE) {
>  		WARN(1, "tpm_buf: write overflow\n");
>  		buf->flags |= TPM_BUF_OVERFLOW;
>  		return;
> 
> ---
> base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
> change-id: 20260524-tpm-402b8478fec9
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

BR, Jarkko

