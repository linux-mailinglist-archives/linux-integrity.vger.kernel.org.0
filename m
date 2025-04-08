Return-Path: <linux-integrity+bounces-5673-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2116A8103E
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 17:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB67173A99
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15922CBCC;
	Tue,  8 Apr 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4UJEaCt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B622A810;
	Tue,  8 Apr 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126294; cv=none; b=i+WqTMkoJ52irMF2dyvbCOAnPZid2colk7wwBMU3b6N7BMx9PJ1vfJiua9KtsbdDr32CCOAh2jwpU6JFIqrhDO3W/+S5GZNVljPscSVR8hN/5WrrOetY9/K+EFmqDt9RmuxEAbGB9f8L7wmUcRF+Jo/yqdSDSoIRCJOl71EURZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126294; c=relaxed/simple;
	bh=Uq29KL+ro4IRBo8g5H8MypBCBK0Ooc76QGNcWH4alfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKTi6jwoTaToT+X/2FTVJ+BUTaJniWajgjCuAr1/3rpK3nGEaHu9pcjcRMCIiz7Jk2zHFsk5u53JBcWcpHKg3Kl2Xa0JKSM1v+1kC4dn2sqCRuGL9HZ+CIKas51C8EGBZ7SED0Ci9OEj2MUo4JJu72HddPbtNeVUXfgmyQgJOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4UJEaCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14E9C4CEE5;
	Tue,  8 Apr 2025 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126294;
	bh=Uq29KL+ro4IRBo8g5H8MypBCBK0Ooc76QGNcWH4alfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4UJEaCtF61oGuLRw5Uii2z9vVlYo67NwlmwTqICCwpgHdYrc/oIvkhAI0jjnKiYr
	 Foi1EZ+/FfOtwDutvDlZ9IsQ6EaTcYYiD+reVoWqi4tU8zzV1GPixJdCq3xMn5ULof
	 keSD4lGX9dDqatRoGU+M0XVaSjc2nQ2FStY95360gQvs2zoe+wDlgAKASUDQjaYgeZ
	 kQ3WWSvJQ9LkYm40V+PxAHXYZKpuv+S9USOhEty0CogIdTgr+YTMAnmHfwKeorOjfK
	 lEPaV0ygH0+6jINKFxGVxFPjOV4RS3OnCQKWa9pJFTARzwygN4IV07Gvc2xj2sINKa
	 D8jpHP3BSx3cg==
Date: Tue, 8 Apr 2025 18:31:30 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sumit Garg <sumit.garg@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v2 2/4] tpm: support devices with synchronous send()
Message-ID: <Z_VBUozuHvbxdyB3@kernel.org>
References: <20250408083208.43512-1-sgarzare@redhat.com>
 <20250408083208.43512-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408083208.43512-3-sgarzare@redhat.com>

On Tue, Apr 08, 2025 at 10:32:06AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Some devices do not support interrupts and provide a single synchronous
> operation to send the command and receive the response on the same buffer.
> 
> Currently, these types of drivers must use an internal buffer where they
> temporarily store the response between .send() and recv() calls.
> 
> Introduce a new flag (TPM_CHIP_FLAG_SYNC) to support synchronous send().
> If that flag is set by the driver, tpm_try_transmit() will use the send()
> callback to send the command and receive the response on the same buffer
> synchronously. In that case send() return the number of bytes of the
> response on success, or -errno on failure.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/tpm.h              |  1 +
>  drivers/char/tpm/tpm-interface.c | 18 +++++++++++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 2e38edd5838c..0e9746dc9d30 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -350,6 +350,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
>  	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
>  	TPM_CHIP_FLAG_DISABLE			= BIT(10),
> +	TPM_CHIP_FLAG_SYNC			= BIT(11),
>  };
>  
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 3b6ddcdb4051..9fbe84b5a131 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -114,8 +114,17 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  		return rc;
>  	}
>  
> -	/* A sanity check. send() should just return zero on success e.g.
> -	 * not the command length.
> +	/* Synchronous devices return the response directly during the send()
> +	 * call in the same buffer.
> +	 */

Nit:

/*
 * ...

It's wrong in the existing comment.

> +	if (chip->flags & TPM_CHIP_FLAG_SYNC) {
> +		len = rc;
> +		rc = 0;
> +		goto out_send_sync;
> +	}
> +
> +	/* A sanity check. send() of asynchronous devices should just return
> +	 * zero on success e.g. not the command length.
>  	 */
>  	if (rc > 0) {
>  		dev_warn(&chip->dev,
> @@ -151,7 +160,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	if (len < 0) {
>  		rc = len;
>  		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
> -	} else if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
> +		return rc;
> +	}
> +out_send_sync:

out_sync would be sufficient

> +	if (len < TPM_HEADER_SIZE || len != be32_to_cpu(header->length))
>  		rc = -EFAULT;
>  
>  	return rc ? rc : len;
> -- 
> 2.49.0
> 

BR, Jarkko

