Return-Path: <linux-integrity+bounces-5267-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB8A5EF3C
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 10:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDBF17243F
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73112260366;
	Thu, 13 Mar 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdU6BL+M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467B43159;
	Thu, 13 Mar 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857180; cv=none; b=uuaMAFsjMrl66bSIjHPWuwpI6/ASdflJiuOUJbB+yQvadRyacJDpBxtxwcM+JpXunfW9e94RR0Ad/4M9EV3seHdcae9u65b+6jF1qN6fJOCg2NqaoQgME+tEg5H+aGr6dzEol8KPXbwiBEHE8gAkTxl/iX+l7ofGWv7pnuFtj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857180; c=relaxed/simple;
	bh=5PbUeh6WBXBtwNcFqeXgxXqosFjPNOkIMa6lwYzuAjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2RSgUYG45kVSq4E/1zTOjrxyWlJTiX3icjdsZqjLxKNJjYUH8i1TDciYXySq8ldBrRCmO6lTM5teObwVJHYu3ssj+0pQp2tFa2oNJrEsLOqJEOjrVR61wy2pi0j08CTpk4UhwiGqpw1OaNj0R1ODrAFbGngSd/hxlRxGsIgigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdU6BL+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403D0C4CEDD;
	Thu, 13 Mar 2025 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857180;
	bh=5PbUeh6WBXBtwNcFqeXgxXqosFjPNOkIMa6lwYzuAjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdU6BL+ME64Ci5u78OkfuTG5Qx9oiiF/4K1NM6EPepI+iey9JqeMgciRqlHyOiJAT
	 Jpj9i1z8/k/pmqr2rFgmi4jW2XjFGuTWyHnZac6iZkk2QvqmexpLuBrs5B9ImSrIC0
	 0dsFT52fY8/lhFTn/muJYHbCsTc9lf3LlMYtofcjCLOzB5XEpo5SAf+6zIM9byl5MP
	 N0J7nkIXZ+bSc/j/39aOAo2OV060GxiJkAYgowwGz20zOiDoavZqCAtsVuiWEFHBct
	 +00MWLiFOIiS/ehfs+n/sdZVk8VMXnV44o0FG10i78nbaV/0w68b0c/cJaC9/rsK8m
	 AM+bUeaB1a1Yg==
Date: Thu, 13 Mar 2025 14:42:53 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [RFC PATCH 2/3] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z9KhlSr7qG6VooeC@sumit-X1>
References: <20250311100130.42169-1-sgarzare@redhat.com>
 <20250311100130.42169-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311100130.42169-3-sgarzare@redhat.com>

+ Jens

Hi Stefano,

On Tue, Mar 11, 2025 at 11:01:29AM +0100, Stefano Garzarella wrote:
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
> 
> It used an internal buffer to cache the response when .send() is called,
> and then return it when .recv() is called.
> 
> Let's simplify the driver by implementing the new send_recv() op, so that
> we can also remove the 4KB internal buffer used to cache the response.

Looks like a nice cleanup to me but it needs to be tested. Jens, can you
give this patch a try?

> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Note: I don't know how to test this driver, so I just build it.
> If someone can test it, or tell me how to do, it will be great!

The fTPM is now maintained as part of OP-TEE project here [1]. The
instructions to test it on Qemu can be found here [2] as part of CI
pipeline.

[1] https://github.com/OP-TEE/optee_ftpm
[2] https://github.com/OP-TEE/optee_ftpm/blob/master/.github/workflows/ci.yml

-Sumit

> ---
>  drivers/char/tpm/tpm_ftpm_tee.h |  4 --
>  drivers/char/tpm/tpm_ftpm_tee.c | 86 ++++++++-------------------------
>  2 files changed, 21 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
> index f98daa7bf68c..72b2f5c41274 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.h
> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> @@ -23,16 +23,12 @@
>   * @chip:     struct tpm_chip instance registered with tpm framework.
>   * @state:    internal state
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
> index 139556b21cc6..f0393d843780 100644
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
> 

