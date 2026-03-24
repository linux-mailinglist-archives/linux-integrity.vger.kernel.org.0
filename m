Return-Path: <linux-integrity+bounces-9048-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNZLBJFpwmlScwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9048-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:38:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA030688C
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 11:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83B18300850F
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25563E0C69;
	Tue, 24 Mar 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcVHWeff"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B63E3D8E;
	Tue, 24 Mar 2026 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348684; cv=none; b=OwzZ7sSZ1y30hT3DHrwRkm9BEzqOdPeY49W0tko+muhAPQaNwNXHLQMWRfE8bQLjvvVuzGZzmm8qIkDYzDYYb1o+sfBMM6LeqJBveAUVPJCFbDjL/tyRbaP7MO445hSLuNglmAidQJ/zKmAIP5/RaKhxGWW/mGuPGFohOgGFkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348684; c=relaxed/simple;
	bh=vcAir2+YXNybyvB/oBcWm4qS6aRDqpLfvt3qrS1KdJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTHTk3RWVUUZdyuIB7KBHQAGnPet3sMZmGIr1v0t6BXLPn37bcaBrqd7nsKGQ66GhBY/sUJZ1fgQmBeaIRghTFUPeJyvVJ/QB4HrHNmxzqNtMMtycixbQ5J7681XsMTwG4DERfV1H1EU1V7SB3u+NqyzgW9ml7R8ReWmp16dOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcVHWeff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA061C19424;
	Tue, 24 Mar 2026 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348683;
	bh=vcAir2+YXNybyvB/oBcWm4qS6aRDqpLfvt3qrS1KdJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcVHWeffcJdbcc21GihRp9sele7i/Au1y9iiAADfdvwdpBjvllDi4imKP64haEO+x
	 /bTdwCHhr+hJCOjqX3ixXceovjo0pq3RfAuuU9Fp9sYzrK5MJyIkZsOx/Lhl8Kmwkj
	 mDY/Kp4hhkesIrrW12fe9qEkiqTxLf8em2AYjWsEMN7wBIem9ys2dI38S+f9jyYEUb
	 nEOiJIdPWNMxCxoGeIMip3qpsSCiZP5Xip0sWyRL8Z670SibJKQaQpcmsDwUylXXC6
	 w/2qvyu+iMtak0KWtqZFsVzmSmyQOj+dX9KJjtyxGL8ImmqNtJdexAJbpP5xZSbTgP
	 v9Mwu2FnywvvQ==
Date: Tue, 24 Mar 2026 12:37:59 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ethan Luna <trunixcodes@zohomail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: i2c: atmel: fix block comment formatting
Message-ID: <acJph47mxNatFPC1@kernel.org>
References: <20260323134200.7766-1-trunixcodes@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323134200.7766-1-trunixcodes@zohomail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,microchip.com,tuxon.dev,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9048-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 7BBA030688C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 06:40:49AM -0700, Ethan Luna wrote:
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
> 
> v1: https://lore.kernel.org/all/20260322193112.27010-1-trunixcodes@zohomail.com/
> 
>  drivers/char/tpm/tpm_i2c_atmel.c | 34 +++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
> index 4f229656a8e2..c3cdc0d6e61c 100644
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

Almost there but when I applied it I spotted some trailing whitespace
errors:

❯ scripts/checkpatch.pl --strict -g HEAD
ERROR: trailing whitespace
#30: FILE: drivers/char/tpm/tpm_i2c_atmel.c:34:
+^I/* $

ERROR: trailing whitespace
#55: FILE: drivers/char/tpm/tpm_i2c_atmel.c:83:
+^I/* $

ERROR: trailing whitespace
#69: FILE: drivers/char/tpm/tpm_i2c_atmel.c:120:
+^I/* $

ERROR: trailing whitespace
#81: FILE: drivers/char/tpm/tpm_i2c_atmel.c:129:
+^I/* $

ERROR: trailing whitespace
#93: FILE: drivers/char/tpm/tpm_i2c_atmel.c:185:
+^I/* $

total: 5 errors, 0 warnings, 0 checks, 72 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

Commit fe31e9522c2c ("tpm: i2c: atmel: fix block comment formatting") has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

BR, Jarkko

