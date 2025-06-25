Return-Path: <linux-integrity+bounces-6516-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA9AE824C
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 14:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E623BB72B
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2322B5B8;
	Wed, 25 Jun 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsYcyYef"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E54223335;
	Wed, 25 Jun 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852910; cv=none; b=AbJXRwIYIlGnZMdMTxH7N/jAdO9LBTCwMUvQiCdppovx4zNRo6AFisoxZdcdTi37h/Jy5vEqFV0jVg1HvCxFkHeaLRPY7nDZ5zfFRLsODC6eeqLlNlOb28Jqs7K+oyF+UuNjZmXi9xEXBApeNPXLLkcay8Czfn18Zi5PH6sf/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852910; c=relaxed/simple;
	bh=YuVPG6sgd2zbeT6W9S8Is5S4byHin6+2b/fHWf5TrGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObFwf3E+sVKGlmrJp6+Snd5hmOQTwy5LPkEI74wHsoW+Bh5NFoHAnVItWDzJcdlT0JboId1sJDKkUoSqzJysXjzTxztWiE2eqlnNZhAqQS/GW1s3ZqUVgbry4b+Yg7VMuXb9c6cUVrI+1uKXFMZeHW06qUjSWp9E+3N46gsEP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsYcyYef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823CC4CEEA;
	Wed, 25 Jun 2025 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750852910;
	bh=YuVPG6sgd2zbeT6W9S8Is5S4byHin6+2b/fHWf5TrGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsYcyYefVKaIkeUGQO2ZN933uQdVB4wX8jUEUPzJvxhcRwedmyLrZHiabY4OrAi9h
	 gekz7dmf/pMfHD790VfTNYU/H4UoLxctIywSk5ERIxa58ih9BWpkxV0x0rE1wPLOEr
	 uNyJTvJdq+S50gIk8GTPrz56vX7F6bS049AcNbgCY8HNRxRTUugmPpHlStZ3aOQxQH
	 BPTI7e2xP6jKmYkebaGsbxuhrcZjJYpfKHmRRPU2F1/bqVHNsquv8nLrIETfRhy3pX
	 2zKzLeO6dRu3IGWY8wo1Sx2qGWRV9BNK11xRW6AM9Z/NvK6Y/89cLyRuHI4DbOLvbK
	 JxpILeeyP2pDQ==
Date: Wed, 25 Jun 2025 15:01:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Naveen N Rao <naveen@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicholas Piggin <npiggin@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/4] tpm/tpm_ftpm_tee: support TPM_CHIP_FLAG_SYNC
Message-ID: <aFvlKs4Mhtw1AZET@kernel.org>
References: <20250620130810.99069-1-sgarzare@redhat.com>
 <20250620130810.99069-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620130810.99069-4-sgarzare@redhat.com>

On Fri, Jun 20, 2025 at 03:08:09PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
> 
> Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
> ->send() already fills the provided buffer with a response, and ->recv()
> is not implemented.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v5:
> - changed order and parameter names to match tpm_try_transmit() [Jarkko]
> v4:
> - added Sumit's R-b
> - reworked commit description [Jarkko]
> v2:
> - set TPM_CHIP_FLAG_SYNC and support it in the new send()
> - removed Jens' T-b
> v1:
> - added Jens' T-b
> ---
>  drivers/char/tpm/tpm_ftpm_tee.h |  4 ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 64 ++++++++++-----------------------
>  2 files changed, 19 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
> index e39903b7ea07..8d5c3f0d2879 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.h
> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> @@ -22,16 +22,12 @@
>   * struct ftpm_tee_private - fTPM's private data
>   * @chip:     struct tpm_chip instance registered with tpm framework.
>   * @session:  fTPM TA session identifier.
> - * @resp_len: cached response buffer length.
> - * @resp_buf: cached response buffer.
>   * @ctx:      TEE context handler.
>   * @shm:      Memory pool shared with fTPM TA in TEE.
>   */
>  struct ftpm_tee_private {
>  	struct tpm_chip *chip;
>  	u32 session;
> -	size_t resp_len;
> -	u8 resp_buf[MAX_RESPONSE_SIZE];
>  	struct tee_context *ctx;
>  	struct tee_shm *shm;
>  };
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index dbad83bf798e..4e63c30aeaf1 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -31,47 +31,19 @@ static const uuid_t ftpm_ta_uuid =
>  		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
>  
>  /**
> - * ftpm_tee_tpm_op_recv() - retrieve fTPM response.
> - * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h.
> - * @buf:	the buffer to store data.
> - * @count:	the number of bytes to read.
> - *
> - * Return:
> - *	In case of success the number of bytes received.
> - *	On failure, -errno.
> - */
> -static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> -{
> -	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> -	size_t len;
> -
> -	len = pvt_data->resp_len;
> -	if (count < len) {
> -		dev_err(&chip->dev,
> -			"%s: Invalid size in recv: count=%zd, resp_len=%zd\n",
> -			__func__, count, len);
> -		return -EIO;
> -	}
> -
> -	memcpy(buf, pvt_data->resp_buf, len);
> -	pvt_data->resp_len = 0;
> -
> -	return len;
> -}
> -
> -/**
> - * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory.
> + * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory
> + * and retrieve the response.
>   * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
> - * @buf:	the buffer to send.
> + * @buf:	the buffer to send and to store the response.
>   * @bufsiz:	the size of the buffer.
> - * @len:	the number of bytes to send.
> + * @cmd_len:	the number of bytes to send.
>   *
>   * Return:
> - *	In case of success, returns 0.
> + *	In case of success, returns the number of bytes received.
>   *	On failure, -errno
>   */
>  static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> -				size_t len)
> +				size_t cmd_len)
>  {
>  	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>  	size_t resp_len;
> @@ -82,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  	struct tee_param command_params[4];
>  	struct tee_shm *shm = pvt_data->shm;
>  
> -	if (len > MAX_COMMAND_SIZE) {
> +	if (cmd_len > MAX_COMMAND_SIZE) {
>  		dev_err(&chip->dev,
>  			"%s: len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
> -			__func__, len);
> +			__func__, cmd_len);
>  		return -EIO;
>  	}
>  
>  	memset(&transceive_args, 0, sizeof(transceive_args));
>  	memset(command_params, 0, sizeof(command_params));
> -	pvt_data->resp_len = 0;
>  
>  	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
>  	transceive_args = (struct tee_ioctl_invoke_arg) {
> @@ -105,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>  		.u.memref = {
>  			.shm = shm,
> -			.size = len,
> +			.size = cmd_len,
>  			.shm_offs = 0,
>  		},
>  	};
> @@ -117,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  		return PTR_ERR(temp_buf);
>  	}
>  	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
> -	memcpy(temp_buf, buf, len);
> +	memcpy(temp_buf, buf, cmd_len);
>  
>  	command_params[1] = (struct tee_param) {
>  		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> @@ -158,17 +129,20 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>  			__func__, resp_len);
>  		return -EIO;
>  	}
> +	if (resp_len > bufsiz) {
> +		dev_err(&chip->dev,
> +			"%s: resp_len=%zd exceeds bufsiz=%zd\n",
> +			__func__, resp_len, bufsiz);
> +		return -EIO;
> +	}
>  
> -	/* sanity checks look good, cache the response */
> -	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
> -	pvt_data->resp_len = resp_len;
> +	memcpy(buf, temp_buf, resp_len);
>  
> -	return 0;
> +	return resp_len;
>  }
>  
>  static const struct tpm_class_ops ftpm_tee_tpm_ops = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
> -	.recv = ftpm_tee_tpm_op_recv,
>  	.send = ftpm_tee_tpm_op_send,
>  };
>  
> @@ -253,7 +227,7 @@ static int ftpm_tee_probe(struct device *dev)
>  	}
>  
>  	pvt_data->chip = chip;
> -	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
>  
>  	/* Create a character device for the fTPM */
>  	rc = tpm_chip_register(pvt_data->chip);
> -- 
> 2.49.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

