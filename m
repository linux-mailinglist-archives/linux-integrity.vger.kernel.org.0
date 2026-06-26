Return-Path: <linux-integrity+bounces-9845-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tvf6MUOrPmoDKAkAu9opvQ
	(envelope-from <linux-integrity+bounces-9845-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 18:39:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F876CF2D1
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 18:39:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="O2qB/Spc";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9845-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9845-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C57530FA166
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD53FA5E5;
	Fri, 26 Jun 2026 16:31:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26914481B1;
	Fri, 26 Jun 2026 16:31:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491471; cv=none; b=qYrjrNR9DnxhX6fYT3XL4cutCHQZXCaEX0R/FieYfA0WsTxyZQ3yTg085CLt/GMDWMhXHUe8ISKLKNWqc3b9Y7kIZ9mu/b+XJityofyZZFAuOiI3pRfPcw24U0TPZctcBfllgTD4E4Eb/OQtl9XVsqYiwmCwTay78PCfsSQ4vHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491471; c=relaxed/simple;
	bh=1mX9S9uPaUq7GVEO+a3y3bUYYKPbnwa/8k7eNOuinDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyLlMIgM/Zp+M0+Pb8iwLlbzUsaJc0b0NUE7Fa0ltvJKwauKIDj4Q0TR/E2SSRQntUxkIRHhlvUnioTpducZFxe2v/QdwRMBU9/5PkiPvZrcsbZYu3uHNl/1u9beQuOXBkW/9X0+MWfS0TA1RhAZda+sl8iCnGcc/obf4xnoAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2qB/Spc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 426171F000E9;
	Fri, 26 Jun 2026 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491469;
	bh=KSUXXThL3kXhHXKekdycU/4DYWBl4hsTFRqara9qxKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2qB/SpcQauAkDXBD3F2tw7W4gP5dv09/dG7UA2uO5SikqV3sBDQqUpZNQVm8yQr+
	 FkEtNHC8nAcp/uuPQO6VgYxjiTJAr1kI3iBFLJPIxc+vUfPQSfUkjSTmomBimxjCdR
	 xCSyVOtiRr0C4cxo5Mbl9Cj6EYl6vlRL8vZf3Kle5zd1OfUH2eomCePfpBoGcZf3V7
	 I1HWDPOXdtslUaL1uR6ccbItpZchXJEzad6IIWAxLvIR8k00O/BJV+cf8A6n2QDEPz
	 TAnR2exSipqJ80BDjTJAv+8t7Lb8PuOQeJfdvTXcA8yKeSiqVIU8XMKtNfyut+Z+gd
	 l9p290BuHg5HA==
Date: Fri, 26 Jun 2026 19:31:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout
Message-ID: <aj6pSWaCs9yZ_nmY@kernel.org>
References: <20260626091653.54929-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626091653.54929-1-mhun512@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9845-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18F876CF2D1

On Fri, Jun 26, 2026 at 06:16:53PM +0900, Myeonghun Pak wrote:
> i2c_nuvoton_wait_for_stat() enables the IRQ before waiting for the
> interrupt handler to report a status change. If the wait times out, or is
> interrupted before the handler runs, the function returns without
> balancing the enable_irq() call.
> 
> Disable the IRQ before leaving the failed wait path. Also preserve an
> interrupted wait's original error code instead of converting it to
> -ETIMEDOUT inside the helper.
> 
> Fixes: 4c336e4b1556 ("tpm: Add support for the Nuvoton NPCT501 I2C TPM")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/char/tpm/tpm_i2c_nuvoton.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index d44903b..aa36730 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -182,8 +182,10 @@ static int i2c_nuvoton_wait_for_stat(struct tpm_chip *chip, u8 mask, u8 value,
>  						      timeout);
>  		if (rc > 0)
>  			return 0;
> -		/* At this point we know that the SINT pin is asserted, so we
> -		 * do not need to do i2c_nuvoton_check_status */
> +
> +		disable_irq(priv->irq);
> +		if (rc < 0)
> +			return rc;
>  	} else {
>  		unsigned long ten_msec, stop;
>  		bool status_valid;
> -- 
> 2.47.1

LGTM

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

