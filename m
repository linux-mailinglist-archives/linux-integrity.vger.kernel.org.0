Return-Path: <linux-integrity+bounces-6225-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED71AB7B1A
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 03:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BEB1BA75A1
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 01:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B322820AE;
	Thu, 15 May 2025 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNc4tPUl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DB28152F;
	Thu, 15 May 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273543; cv=none; b=RmkZ+Dmo46ohPLA5GY3LoEjWsFko2yirDXF/qKA1FdIfz/e9m7oyfWQVdI+ppbKr+MsihGVLG5X/JMKxe/Np2h6FdkobqDdIrEwI0l1x33ERmzhvjuZuzJI1LuY/SWuEUxlOrkBE6+ObcAtfCEljhXFGx0p99r73oSQqnKOmjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273543; c=relaxed/simple;
	bh=pnNBST+c9YzDalNQ25GoKXrq/N4ZaCLn+kBAH2QlzYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7vtxql1llS1n6vLVwfwvh9sG2bHMFYPr5aKqrXTEnYAKIPuMrGo/lU+nvMc3HYiapE5dMfgKVTpEZENQbykplstBnQFC50KlGo6bZFn+YbtKtTZWRT8RZDK4W1MKa2+PapSFJT87EQyOWIm1Ea2gZJaX63DagreOyY/GhB6NHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNc4tPUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AEEC4CEE3;
	Thu, 15 May 2025 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747273542;
	bh=pnNBST+c9YzDalNQ25GoKXrq/N4ZaCLn+kBAH2QlzYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNc4tPUliPhaLP8MScTBz9lzD/DbFYbrmeQrGDWpJqBK+OQTnINZVdKbioHL6ZlaG
	 7B0bXpM5nFKBFsjTFtIARi8xIxPPdsGvR8QSEjkD0LDsPK7paj3VIDwNhiy8qLmeS2
	 Q4vSfcc1Q/MFQqHCSTZoL1YNd65JA6kq/y1Q4LlKsawjEVMBJatGqzWHgfCc0MW7Zm
	 8aNhLfenXAcGTnLGqlfUzpCqVjZ+e8uT3pusUg7EVriHSdUSomg0SBSri09+p3jmmA
	 eO5c/aiw0dn9R0/3bGlvru/Yo86J8ScWuzWm/R7NXvtQsxml1nU8VoDc2tJu0iKAur
	 xuSFgNziuESLA==
Date: Thu, 15 May 2025 04:45:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Huewe <peterhuewe@gmx.de>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-integrity@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Message-ID: <aCVHQ-LRqHeEVEAW@kernel.org>
References: <20250514134630.137621-1-sgarzare@redhat.com>
 <20250514134630.137621-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514134630.137621-5-sgarzare@redhat.com>

On Wed, May 14, 2025 at 03:46:30PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
> 
> Enable synchronous send() with TPM_CHIP_FLAG_SYNC, which implies that
> ->send() already fills the provided buffer with a response, and ->recv()
> is not implemented.
> 
> Keep using the same pre-allocated buffer to avoid having to allocate
> it for each command. We need the buffer to have the header required by
> the SVSM protocol and the command contiguous in memory.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v5:
> - changed order and parameter names to match tpm_try_transmit() [Jarkko]
> v4:
> - reworked commit description [Jarkko]
> ---
>  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> index 0847cbf450b4..f5ba0f64850b 100644
> --- a/drivers/char/tpm/tpm_svsm.c
> +++ b/drivers/char/tpm/tpm_svsm.c
> @@ -26,37 +26,31 @@ struct tpm_svsm_priv {
>  };
>  
>  static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> -			 size_t len)
> +			 size_t cmd_len)
>  {
>  	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
>  	int ret;
>  
> -	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
> +	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, cmd_len);
>  	if (ret)
>  		return ret;
>  
>  	/*
>  	 * The SVSM call uses the same buffer for the command and for the
> -	 * response, so after this call, the buffer will contain the response
> -	 * that can be used by .recv() op.
> +	 * response, so after this call, the buffer will contain the response.
> +	 *
> +	 * Note: we have to use an internal buffer because the device in SVSM
> +	 * expects the svsm_vtpm header + data to be physically contiguous.
>  	 */
> -	return snp_svsm_vtpm_send_command(priv->buffer);
> -}
> -
> -static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> -{
> -	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> +	ret = snp_svsm_vtpm_send_command(priv->buffer);
> +	if (ret)
> +		return ret;
>  
> -	/*
> -	 * The internal buffer contains the response after we send the command
> -	 * to SVSM.
> -	 */
> -	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
>  }
>  
>  static struct tpm_class_ops tpm_chip_ops = {
>  	.flags = TPM_OPS_AUTO_STARTUP,
> -	.recv = tpm_svsm_recv,
>  	.send = tpm_svsm_send,
>  };
>  
> @@ -85,6 +79,7 @@ static int __init tpm_svsm_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(&chip->dev, priv);
>  
> +	chip->flags |= TPM_CHIP_FLAG_SYNC;
>  	err = tpm2_probe(chip);
>  	if (err)
>  		return err;
> -- 
> 2.49.0
> 
> 

I can pick this for 6.16.

BR, Jarkko

BR, Jarkko

