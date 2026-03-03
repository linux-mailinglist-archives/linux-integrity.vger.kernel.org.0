Return-Path: <linux-integrity+bounces-8878-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH8LMaNSp2lsgwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8878-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:29:07 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAD01F786B
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Mar 2026 22:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3522315BA0C
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2026 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14A3A5E9B;
	Tue,  3 Mar 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFM+J3nM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AC377ED7;
	Tue,  3 Mar 2026 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573214; cv=none; b=dB705FTUPEN47PR8dRL4N9LQrEx5NGKBcH4EKcZYn9AuPZM6V/0++bwGb+Fq0L/w5SgQ6PXbAjOnCHtXRdfp4hkzl/joTeMghkrao3afhzTVxnNdqm44hbr4jPaFuQrgx16Y4Ny/ABJHh0iVgSO2rK943QpLlEPvSTvUhQa7Nxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573214; c=relaxed/simple;
	bh=o8qtxAvcpI27fXxm+YDkyazulCEfeVWfNjp8JBioi+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwrKCBikAvIrl10ytWX0/tri0qnMvWUKjF81+6X5796EkH71tHmPR51m9xTjNwB2Ia2UyXLDDJSoPWv3iUM98EYopd3US0YcmlPK6KP4hdKixOet9pgQYdILeMHxwrOgXN0zqpC27sq+7zSQbjaifVZnDQK2VTedkKkGXeuWXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFM+J3nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD82C116C6;
	Tue,  3 Mar 2026 21:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573213;
	bh=o8qtxAvcpI27fXxm+YDkyazulCEfeVWfNjp8JBioi+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFM+J3nMaee3cMzTxWiyLn1yDX8TvzPu1+qxXPbRNEMs9mq56KljD7+GaaHLYtsdp
	 5ksDCK5WD+4yr93n0cB6ap+sj15CCVBZJeI7ITdnM45zBdXtZQaj517lyz8XP4L5i0
	 LeExIZv4uKOM6aMGeYvxFX7OOskXH/O7YFThl5UijKy/SUYpP7kU3YFh1OXiH+oK85
	 RGZ2Ag5wNAmSqv7W9B5V+CdTjiuiNLjirui/93B3UquUTLpaSEaAEV1I7EWPVmEP9M
	 nfzSCK/9D7DZ+Ghi6w0UCkQl+5axboIQmX+Dcns5zSZUGQwBNRw/olm0fLlFCZJalF
	 efGr6HO5wMeQw==
Date: Tue, 3 Mar 2026 23:26:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make tcpci_pm_ops variable static const
Message-ID: <aadSGbFHY7CT1G7B@kernel.org>
References: <20260216110458.160357-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216110458.160357-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Rspamd-Queue-Id: 3FAD01F786B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8878-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 12:04:59PM +0100, Krzysztof Kozlowski wrote:
> File-scope 'tcpci_pm_ops' is not used outside of this unit and is not
> modified anywhere, so make it static const to silence sparse warning:
> 
>   tcpci.c:1002:1: warning: symbol 'tcpci_pm_ops' was not declared. Should it be static?
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 3a77be7ebf4a..e00f668f8c84 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -21,7 +21,7 @@ static bool disable_pcr_integrity;
>  module_param(disable_pcr_integrity, bool, 0444);
>  MODULE_PARM_DESC(disable_pcr_integrity, "Disable integrity protection of TPM2_PCR_Extend");
>  
> -struct tpm2_hash tpm2_hash_map[] = {
> +static const struct tpm2_hash tpm2_hash_map[] = {
>  	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
>  	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
>  	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> -- 
> 2.51.0
> 

Applied.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

