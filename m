Return-Path: <linux-integrity+bounces-9038-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VbzsBi7TwGkkMgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9038-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:44:14 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5762ECB80
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 06:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9818F30041EB
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Mar 2026 05:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330E2C21DF;
	Mon, 23 Mar 2026 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m39DqGfv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503982BEC23;
	Mon, 23 Mar 2026 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244650; cv=none; b=Zup8CcyFifNJszfSqjozRGMsBNIdrQMWxL7P1intfQEQFO/76bTd9JICJZl9EdhSUaZMqTgemIDsOaVhI2UlM6oRCNeBSyk3IvKo8ZQmRrMIRo8VmqxE5Z9Uzw5aJ0UUnxZTzqrXCsj1FUJUSqA7Ox1oMhIRoGvx31RnRmrVhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244650; c=relaxed/simple;
	bh=Ir8hCmjyPf2Ze81ZaE3IWsYRpbwEsWy/ErIWhj8mOsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0XdIoVrFREeaAvRzN+1zN1ava8+hI2hSHBhDpoyrHjVMvuXv9CdibvVRZq34tRc8QfSsRyplN3CVQjMc8MGmLbHPQz499tcpNHY/U5eAKqmd4alYVzbs9A+8gFN76eXVl/YVLga72h481eFydZipEW8+hiW3DnXHx4sMbsyFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m39DqGfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E54C4CEF7;
	Mon, 23 Mar 2026 05:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774244649;
	bh=Ir8hCmjyPf2Ze81ZaE3IWsYRpbwEsWy/ErIWhj8mOsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m39DqGfvrDfGdMll05g6haD4ZbZQ/mZgMPqVS1mUjOVIddG0gLO8oMBCs5+J9MkA9
	 B0StEfTEvIMQYlHgpN0GrbDtPGVIT65E9CriYl6rwh6rbc7osj/sd8QRAAsQZGwIQo
	 KKWuEE2obSPln8OPzTZInmKPXSIctRtGozAPDCdDe7GKoSfGixK/brC8Tsw378rWfz
	 dHfGZyeJYgmuJHzSNKi9kO0jEQVEzf0DW76Esv/+da4M+M8hm0FQd9EVdSTv+rwh7s
	 JRLbqFXrzVSNs0tRXDnmH2LfWAtPRANGxA9Qe7egLllaYElTMJs2KSvycl/M+iBsfu
	 Lf8FItyNR5mbQ==
Date: Mon, 23 Mar 2026 07:44:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ethan Luna <trunixcodes@zohomail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: i2c: atmel: fix block comment formatting
Message-ID: <acDTJbHJOHIQRUsY@kernel.org>
References: <20260322193112.27010-1-trunixcodes@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322193112.27010-1-trunixcodes@zohomail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,microchip.com,tuxon.dev,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9038-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C5762ECB80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:30:53PM -0700, Ethan Luna wrote:
> Multiple block comments in tpm_i2c_atmel.c placed the closing '*/' on the
> same line as the comment text. This violates the kernel's preferred
> comment style, which requires the closing delimiter to appear on it's
> line.
> 
> Fix the formatting to improve readability and resolve checkpatch
> warnings.
> 
> Signed-off-by: Ethan Luna <trunixcodes@zohomail.com>
> ---
>  drivers/char/tpm/tpm_i2c_atmel.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
> index 4f229656a8e2..702b3c9191dc 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -33,7 +33,8 @@ struct priv_data {
>  	size_t len;
>  	/* This is the amount we read on the first try. 25 was chosen to fit a

If you fix this up here.

>  	 * fair number of read responses in the buffer so a 2nd retry can be
> -	 * avoided in small message cases. */
> +	 * avoided in small message cases.
> +	 */
>  	u8 buffer[sizeof(struct tpm_header) + 25];
>  };
>  
> @@ -58,7 +59,9 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
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
> @@ -78,7 +81,8 @@ static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  
>  	/* Get the message size from the message header, if we didn't get the
>  	 * whole message in read_status then we need to re-read the
> -	 * message. */
> +	 * message.
> +	 */
>  	expected_len = be32_to_cpu(hdr->length);
>  	if (expected_len > count)
>  		return -ENOMEM;
> @@ -113,13 +117,15 @@ static u8 i2c_atmel_read_status(struct tpm_chip *chip)
>  
>  	/* The TPM fails the I2C read until it is ready, so we do the entire
>  	 * transfer here and buffer it locally. This way the common code can
> -	 * properly handle the timeouts. */
> +	 * properly handle the timeouts.
> +	 */
>  	priv->len = 0;
>  	memset(priv->buffer, 0, sizeof(priv->buffer));
>  
>  
>  	/* Once the TPM has completed the command the command remains readable
> -	 * until another command is issued. */
> +	 * until another command is issued.
> +	 */
>  	rc = i2c_master_recv(client, priv->buffer, sizeof(priv->buffer));
>  	dev_dbg(&chip->dev,
>  		"%s: sts=%d", __func__, rc);
> @@ -174,7 +180,8 @@ static int i2c_atmel_probe(struct i2c_client *client)
>  
>  	/* There is no known way to probe for this device, and all version
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

The same comment applies for all.

BR, Jarkko

