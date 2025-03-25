Return-Path: <linux-integrity+bounces-5415-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA03A6E93D
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 06:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21A3188FCF0
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 05:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0419CC3D;
	Tue, 25 Mar 2025 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg2bhnKP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CDDDA9;
	Tue, 25 Mar 2025 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742879985; cv=none; b=ire0qtoOehL6Fysj7g/K7g3agzJftcsrudxH5q8T5he7F1KwPoyuqBtQ2ekJeAe8zkJtpLNekUYF38JPjCjMUWXI4kI1HuJoSnyAeciTehaP4HDJ2OVjnvC7BIoVDT+KHztnKMniYHDpYtV5kA4UgSIUGgEuJzqjUSFPKzblph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742879985; c=relaxed/simple;
	bh=eSul+/3jQyvKTWw3aK9S+uNoEVTyeL5sqC95x+Vdco8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSZavrBqro70N5KCEHBq68achDxgWs5B2RNYhj8xQktf5oSxXuw745K9LKcA8+KgCkd7R7N0Ubrk1sI0HTc8L5B+GCsuG5GbuEEFhMnzpqsn+IezkHJ0RL8wdCetG9VdfzUDJGYYfwBkI4cBT6e+2A1tVuU9Fq6t9aoTG80U4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg2bhnKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FA5C4CEE9;
	Tue, 25 Mar 2025 05:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742879984;
	bh=eSul+/3jQyvKTWw3aK9S+uNoEVTyeL5sqC95x+Vdco8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pg2bhnKP7kfpNogcVhDxrpbNsj2+i56JBViNDRJAUFL0ySzEY4VQq41IYzVy6IJDX
	 qasOu9jb/3nwL6uJP587ZM8cyQNiOI3F2ZYDJljcf4P2TT/0Dvj8HVNr4tjOABiqD0
	 bPfeOn3DXR9up+M3aNFRsTRYqAjnszu98zOaWV6clpLjmabaG4N5ogEEpUX2FrNrdh
	 3+jMiyNobyv/cXzjLsr9pdS6k94PBH0XH6TMoGZXyPpYQch2rJdj1miWcs/2GAgwRO
	 aoEEbcmdAnm1FI+Nz9JL8U0qjUa39tgPTe1XCzevary4DlUFeRRdpCdHgwGTTFFh7L
	 j9/vq/MDMg47Q==
Date: Tue, 25 Mar 2025 10:49:38 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z-I86tWMcD6b_YeM@sumit-X1>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320152433.144083-3-sgarzare@redhat.com>

On Thu, Mar 20, 2025 at 04:24:33PM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
> 
> It used an internal buffer to cache the response when .send() is called,
> and then return it when .recv() is called.
> 
> Let's simplify the driver by implementing the new send_recv() op, so that
> we can also remove the 4KB internal buffer used to cache the response.
> 
> Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v1:
> - added Jens' T-b
> ---
>  drivers/char/tpm/tpm_ftpm_tee.h |  4 --
>  drivers/char/tpm/tpm_ftpm_tee.c | 86 ++++++++-------------------------
>  2 files changed, 21 insertions(+), 69 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@kernel.org>

-Sumit

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
> index 8d9209dfc384..d472199c0a7b 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -31,45 +31,19 @@ static const uuid_t ftpm_ta_uuid =
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
> + * ftpm_tee_tpm_op_send_recv() - send TPM commands through the TEE shared memory
> + * and retrieve the response.
>   * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
> - * @buf:	the buffer to send.
> - * @len:	the number of bytes to send.
> + * @buf:	the buffer to send and to store the response.
> + * @buf_len:	the size of the buffer.
> + * @cmd_len:	the number of bytes to send.
>   *
>   * Return:
> - *	In case of success, returns 0.
> + *	In case of success, returns the number of bytes received.
>   *	On failure, -errno
>   */
> -static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
> +static int ftpm_tee_tpm_op_send_recv(struct tpm_chip *chip, u8 *buf,
> +				     size_t buf_len, size_t cmd_len)
>  {
>  	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>  	size_t resp_len;
> @@ -80,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
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
> @@ -103,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>  		.u.memref = {
>  			.shm = shm,
> -			.size = len,
> +			.size = cmd_len,
>  			.shm_offs = 0,
>  		},
>  	};
> @@ -115,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  		return PTR_ERR(temp_buf);
>  	}
>  	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
> -	memcpy(temp_buf, buf, len);
> +	memcpy(temp_buf, buf, cmd_len);
>  
>  	command_params[1] = (struct tee_param) {
>  		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> @@ -156,38 +129,21 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  			__func__, resp_len);
>  		return -EIO;
>  	}
> +	if (resp_len > buf_len) {
> +		dev_err(&chip->dev,
> +			"%s: Invalid size in recv: buf_len=%zd, resp_len=%zd\n",
> +			__func__, buf_len, resp_len);
> +		return -EIO;
> +	}
>  
> -	/* sanity checks look good, cache the response */
> -	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
> -	pvt_data->resp_len = resp_len;
> -
> -	return 0;
> -}
> -
> -static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
> -{
> -	/* not supported */
> -}
> -
> -static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
> -{
> -	return 0;
> -}
> +	memcpy(buf, temp_buf, resp_len);
>  
> -static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
> -{
> -	return false;
> +	return resp_len;
>  }
>  
>  static const struct tpm_class_ops ftpm_tee_tpm_ops = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
> -	.recv = ftpm_tee_tpm_op_recv,
> -	.send = ftpm_tee_tpm_op_send,
> -	.cancel = ftpm_tee_tpm_op_cancel,
> -	.status = ftpm_tee_tpm_op_status,
> -	.req_complete_mask = 0,
> -	.req_complete_val = 0,
> -	.req_canceled = ftpm_tee_tpm_req_canceled,
> +	.send_recv = ftpm_tee_tpm_op_send_recv,
>  };
>  
>  /*
> -- 
> 2.48.1
> 

