Return-Path: <linux-integrity+bounces-9141-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNbpChcU1mnwAwgAu9opvQ
	(envelope-from <linux-integrity+bounces-9141-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 10:38:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 997AB3B930E
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 10:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D884130157EC
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB73A6B9D;
	Wed,  8 Apr 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmHU4vQt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21833A6B8F;
	Wed,  8 Apr 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637499; cv=none; b=fGC91xyILjRrpmBkuQEm8MGOLLmqbZVlesSee/+A+uVUSbPnWIIThZ/CSNhv+Kzja4l671m255aJMsiXWQwdJTFA8df33Zw7VbgPrVbWv6ljI+MuljGmp8xMe8dpfR7FnIlQ0sosRoEAJmSboDp97Dud45KqzyWrvWSsFMzXw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637499; c=relaxed/simple;
	bh=tFO2wz8+moG8jwhFOJAx5x+1L99MAA6vAsWauEqfC8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUJgUjPSpWRL9Vo6ROzLqjy3FcEGBVijhBPTqvkoMSX+tmEQGco6c/DD0Xcgmye4Qv2e6CG46sAEhF8DxqJ4mWGsAh43YkfaP3PD70sSNVU++lIoeWyclk/CnjYpQcb8ap7MOfIkHFZet+ScznJUc59w66Edxv+WvjfCaPu1eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmHU4vQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C203C19424;
	Wed,  8 Apr 2026 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637498;
	bh=tFO2wz8+moG8jwhFOJAx5x+1L99MAA6vAsWauEqfC8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmHU4vQta41BCXG19fXqoa5tTQlJEl6WHONqU7CIzw/YpkiDljrlZPIravgBwwtXQ
	 EYMYZMKs8c/0GVDGXUQEC2sSMlB9/y01wj35boix4K9ORlZ2/e0rAZsCSq2vJDH/d5
	 crp40HkhXdnIILqqTqe9D2YbS8Za8D0nvzoYScDW9CX1TEb1YafPe2k9Y1D6GkF2m4
	 IVcVo9ZXmR+x0MmO3E4yACg2nFzr8OvkRE1PDCATHT6yk3nbsdHS82FddOq9EdvrBf
	 j6AFyf1NddimzzhMBhiahr6Mq/saYVBjZ/4l4SuVwD5Dw2RC+S54O6+EjSDhMLB2nR
	 m60qNuRTGtWbw==
Date: Wed, 8 Apr 2026 11:38:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ethan Luna <trunixcodes@zohomail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: i2c: atmel: fix block comment formatting
Message-ID: <adYT9yeJBO9PhMBM@kernel.org>
References: <20260324154354.6268-1-trunixcodes@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324154354.6268-1-trunixcodes@zohomail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,microchip.com,tuxon.dev,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9141-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zohomail.com:email]
X-Rspamd-Queue-Id: 997AB3B930E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 08:39:49AM -0700, Ethan Luna wrote:
> Multiple block comments in tpm_i2c_atmel.c placed the closing '*/' on the
> same line as the comment text. This violates the kernel's preferred
> comment style, which requires the closing delimiter to appear on its
> line.
> 
> Fix the formatting to improve readability and resolve checkpatch
> warnings.
> 
> Signed-off-by: Ethan Luna <trunixcodes@zohomail.com>
> ---
> 
> V1 -> V2: Fixed block comment formatting consistently across all multi-line comments
> V2 -> V3: Fixed trailing whitespaces consistently across all multi-line comments
> 
> v1: https://lore.kernel.org/all/20260322193112.27010-1-trunixcodes@zohomail.com/
> v2: https://lore.kernel.org/all/20260323134200.7766-1-trunixcodes@zohomail.com/
> 
>  drivers/char/tpm/tpm_i2c_atmel.c | 34 +++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
> index 4f229656a8e2..9fd73049821f 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -31,9 +31,11 @@
>  
>  struct priv_data {
>  	size_t len;
> -	/* This is the amount we read on the first try. 25 was chosen to fit a
> +	/*
> +	 * This is the amount we read on the first try. 25 was chosen to fit a
>  	 * fair number of read responses in the buffer so a 2nd retry can be
> -	 * avoided in small message cases. */
> +	 * avoided in small message cases.
> +	 */
>  	u8 buffer[sizeof(struct tpm_header) + 25];
>  };
>  
> @@ -58,7 +60,9 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  	if (status < 0)
>  		return status;
>  
> -	/* The upper layer does not support incomplete sends. */
> +	/*
> +	 * The upper layer does not support incomplete sends.
> +	 */
>  	if (status != len)
>  		return -E2BIG;
>  
> @@ -76,9 +80,11 @@ static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  	if (priv->len == 0)
>  		return -EIO;
>  
> -	/* Get the message size from the message header, if we didn't get the
> +	/*
> +	 * Get the message size from the message header, if we didn't get the
>  	 * whole message in read_status then we need to re-read the
> -	 * message. */
> +	 * message.
> +	 */
>  	expected_len = be32_to_cpu(hdr->length);
>  	if (expected_len > count)
>  		return -ENOMEM;
> @@ -111,15 +117,19 @@ static u8 i2c_atmel_read_status(struct tpm_chip *chip)
>  	struct i2c_client *client = to_i2c_client(chip->dev.parent);
>  	int rc;
>  
> -	/* The TPM fails the I2C read until it is ready, so we do the entire
> +	/*
> +	 * The TPM fails the I2C read until it is ready, so we do the entire
>  	 * transfer here and buffer it locally. This way the common code can
> -	 * properly handle the timeouts. */
> +	 * properly handle the timeouts.
> +	 */
>  	priv->len = 0;
>  	memset(priv->buffer, 0, sizeof(priv->buffer));
>  
>  
> -	/* Once the TPM has completed the command the command remains readable
> -	 * until another command is issued. */
> +	/*
> +	 * Once the TPM has completed the command the command remains readable
> +	 * until another command is issued.
> +	 */
>  	rc = i2c_master_recv(client, priv->buffer, sizeof(priv->buffer));
>  	dev_dbg(&chip->dev,
>  		"%s: sts=%d", __func__, rc);
> @@ -172,9 +182,11 @@ static int i2c_atmel_probe(struct i2c_client *client)
>  
>  	dev_set_drvdata(&chip->dev, priv);
>  
> -	/* There is no known way to probe for this device, and all version
> +	/*
> +	 * There is no known way to probe for this device, and all version
>  	 * information seems to be read via TPM commands. Thus we rely on the
> -	 * TPM startup process in the common code to detect the device. */
> +	 * TPM startup process in the common code to detect the device.
> +	 */
>  
>  	return tpm_chip_register(chip);
>  }
> -- 
> 2.53.0
> 

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied.

BR, Jarkko

