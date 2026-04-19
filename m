Return-Path: <linux-integrity+bounces-9232-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD0wAzDG5GksZQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9232-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 14:10:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CEC423EA6
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF9B5300440C
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Apr 2026 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2085433B97B;
	Sun, 19 Apr 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8kNBHRN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13AE261B8D;
	Sun, 19 Apr 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600618; cv=none; b=Umfs4qPd2rKE8uMrQVIqeYuFp8esbQPdSTFGVOFwUqbeCw8tOPOlunbDIkULllJwJUAuLWeyCNq7LXska0aysLvDHvnWWNcDtw3epDNJYDJGWciFKTHMBUsT+8DM2c7/A2/T7GycXx6KHOirwppLeb4SqZ1pIGA+9Ca01PWvgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600618; c=relaxed/simple;
	bh=0EOXCzy7+wQkaVsu06fepbBVH6glV9JVmodPTQIkVcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp/mPJq1LnpNPkJRy+x5eJyISh3/Hk8TCKJrP9yst4yHzYnyfD9Y29rWR2ZvEJXg3WXiUK1EDqTZgHfeoPxiQQ+iG3b7FwzjNC+8Iawmnxz+2onSPgPvbl9CJOBQjkkCm8+bA1cVfTpGdd3otkD4RLbfvRKz8A++xb/IpJCeRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8kNBHRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F00C2BCAF;
	Sun, 19 Apr 2026 12:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776600617;
	bh=0EOXCzy7+wQkaVsu06fepbBVH6glV9JVmodPTQIkVcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8kNBHRNe9ZvhEgzZyWGHIliAlPSBKyj+LXNCmu2d8dSOJnijbC+hXhFHU46vYZZB
	 FhuGfytS2+H8smmk4sbHuJyxjv+TxkS+LN1Ol0VgToz4Bf61/D+ZhF0lqFed1+vY/J
	 wnhn93Hat3tAMIYfZxsXvWnqRtRZUPPYsYO7s9NEmTb7S73nOrq2nA8q1+11blpz82
	 u9k09oYL2DLE9ehjck/Nrm61JK0aRmojiewyH7cfBZ1WNDzuxQJsWzijidhlKLMrdq
	 GESZs87MGmkWoFZbudiT2cwUNyzykm60826vGTxRYH8QZJbUn639pewUswC0Tf3ITd
	 W0j5QEBa0QPaA==
Date: Sun, 19 Apr 2026 15:10:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: eventlog: remove unused structs
 tcg_algorithm_{size,info}
Message-ID: <aeTGJRthnFZ_wxlz@kernel.org>
References: <20260417105516.552735-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417105516.552735-3-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9232-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 03CEC423EA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 12:55:17PM +0200, Thorsten Blum wrote:
> Remove the unused structs tcg_algorithm_size and tcg_algorithm_info.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/linux/tpm_eventlog.h | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index aff8ea2fa98e..615bd0af5173 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -114,22 +114,6 @@ struct tcg_pcr_event2_head {
>  	struct tpm_digest digests[];
>  } __packed;
>  
> -struct tcg_algorithm_size {
> -	u16 algorithm_id;
> -	u16 algorithm_size;
> -};
> -
> -struct tcg_algorithm_info {
> -	u8 signature[16];
> -	u32 platform_class;
> -	u8 spec_version_minor;
> -	u8 spec_version_major;
> -	u8 spec_errata;
> -	u8 uintn_size;
> -	u32 number_of_algorithms;
> -	struct tcg_algorithm_size digest_sizes[];
> -};
> -
>  #ifndef TPM_MEMREMAP
>  static inline void *TPM_MEMREMAP(unsigned long start, size_t size)
>  {

NAK. If you are doing something useful here then it is fine.

The only feature that pure cleanup patches cause are potential merge
conflicts when backporting actual bug fixes.

BR, Jarkko

