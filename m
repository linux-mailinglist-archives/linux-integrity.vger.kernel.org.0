Return-Path: <linux-integrity+bounces-9921-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pJ11L3V/UmrNQQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9921-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 19:37:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A263742674
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 19:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UYmDMp2b;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9921-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9921-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27BD130157F8
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2026 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154FE352C4F;
	Sat, 11 Jul 2026 17:37:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6925393E;
	Sat, 11 Jul 2026 17:37:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783791473; cv=none; b=klFc+yWEZ17y0zVKUZI2TbAICHWpKbmtibcpt+rS7mpFeDEfO7RXGYxDlV8E1hR3hW/HFLZ+mt58/4FgE8DNgtSKM4hLnTGjKy1LdeiLxoTXD7Ajc2mqzoUOYYl3WRfss4dBLRPY9iCTV3IxpFJtiCFq5aMeDbqsSdnBRjLH6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783791473; c=relaxed/simple;
	bh=n0/EUOoOHqSAXfrX07L+kInmiHfaohwVQqSJk2mMY5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghvgCdtJG0xYLYMJ5oR5UTXlc6CL8YIhG+rmIcpCxNbp4gkJr7LTNrm2bSw/pByrmXMYPM7oPuJCT1qzMBIIR9k6+VWoD1ZeT7HJrI9F0Pm55W3DHufBojckJn8C2WRVQDC2wshPTx8rHhdenWT6aVZ6v2eNuBWLuaQa5Uep9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYmDMp2b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E88E41F000E9;
	Sat, 11 Jul 2026 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783791471;
	bh=imctzIE4E9ZAuGXTf6dnldu/7y/pOSeNFQ9iOKnUE1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UYmDMp2bpN8vE8NPugFK1T3X4mkmghfwypIv8UYq5Me5auG/cG29svUMCRMfvIunG
	 qjBgtln4a5STuTAbkvlASXcWaBB3Fqpeiv1pd7Rg49BYNgQsVsSoSjTr2a+CI5yAOe
	 lDYdVQ9r0Znj0uQv2l2cJ+A4DyqXkEu5f4OPFU+NnQB3LuHfvYftM1ZCwoT1ZLNkWV
	 WlMCdsVrm0WnA5/lnAg/5YS3pbyhZw5ir9oDNpKXhlhUZBbvLp5dKrhEUhslash4DK
	 Hft62JY34i6F0HHEJ0KI8GjEAdnhoEKqGPjElZ5TBYUhYTnEEeEcwKJiVT+gidc1t3
	 vU2qmWCZIAtmw==
Date: Sat, 11 Jul 2026 20:37:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Alper Ak <alperyasinak1@gmail.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] tpm: Remove redundant dev_err()
Message-ID: <alJ_a-xhLqndXy19@kernel.org>
References: <20260710105318.376496-1-panchuang@vivo.com>
 <20260710105318.376496-3-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710105318.376496-3-panchuang@vivo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-9921-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,redhat.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:sgarzare@redhat.com,m:alperyasinak1@gmail.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-integrity];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A263742674

On Fri, Jul 10, 2026 at 06:53:07PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied:  https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

> ---
>  drivers/char/tpm/st33zp24/st33zp24.c | 5 +----
>  drivers/char/tpm/tpm_i2c_nuvoton.c   | 2 --
>  drivers/char/tpm/tpm_tis_i2c_cr50.c  | 4 +---
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index e2b7451ea7cc..8d5179367eac 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -506,11 +506,8 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
>  		ret = devm_request_irq(dev, irq, tpm_ioserirq_handler,
>  				IRQF_TRIGGER_HIGH, "TPM SERIRQ management",
>  				chip);
> -		if (ret < 0) {
> -			dev_err(&chip->dev, "TPM SERIRQ signals %d not available\n",
> -				irq);
> +		if (ret < 0)
>  			goto _tpm_clean_answer;
> -		}
>  
>  		intmask |= TPM_INTF_CMD_READY_INT
>  			|  TPM_INTF_STS_VALID_INT
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index aa3673002f3a..c84afb29d548 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -576,8 +576,6 @@ static int i2c_nuvoton_probe(struct i2c_client *client)
>  				      dev_name(&chip->dev),
>  				      chip);
>  		if (rc) {
> -			dev_err(dev, "%s() Unable to request irq: %d for use\n",
> -				__func__, priv->irq);
>  			priv->irq = 0;
>  		} else {
>  			chip->flags |= TPM_CHIP_FLAG_IRQ;
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index b48cacacc066..7f828fae70d3 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -751,10 +751,8 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
>  				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
>  				      dev->driver->name, chip);
> -		if (rc < 0) {
> -			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
> +		if (rc < 0)
>  			return rc;
> -		}
>  
>  		priv->irq = client->irq;
>  	} else {
> -- 
> 2.34.1
> 

BR, Jarkko

