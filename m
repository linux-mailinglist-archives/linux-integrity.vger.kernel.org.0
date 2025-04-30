Return-Path: <linux-integrity+bounces-6100-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A3DAA50C2
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551E01C050EE
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1D19C556;
	Wed, 30 Apr 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILkRzJmx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865A2DC797;
	Wed, 30 Apr 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028183; cv=none; b=hlNkxJl3w3aduz53ltqUwVJENMOhVsXoLfw6UgP2Eb1NLVhcJ4xq38Nugw2tyeasCz9T53aHTp2VHF6r774Zn8yYANmfQM7gzrKf99EOXfA8R1JETSR3Yk5CtOmALjvxFqugi03AIrxXDda4w423mv2S3oYmaXoO11Ga/HBWojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028183; c=relaxed/simple;
	bh=jbN75Y77ia3DaPmLil5WAcGzaZgfrTs67v8JYHeLyFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulhlpMZEF0md3NFO6yMwYYb6YqBVeKV1q3+9kR8a+DlKDGaVfub2yKY6EpEnjQnFiccEWuyykFigB5CxR/ROPc69EtKO7KDnXCcz4s6pgNKpVbZj8hV2Q75NpdYr+XLVSoQ6NWHYq0eRjH5gMNnYYogbVZHvs79TkPnqqEGkaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILkRzJmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB48DC4CEE7;
	Wed, 30 Apr 2025 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746028182;
	bh=jbN75Y77ia3DaPmLil5WAcGzaZgfrTs67v8JYHeLyFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILkRzJmxPdFObsI9MPCYwxX97C4pY7WZMUG69FkF2voL4XquCgdJqXarl/qXSmdsT
	 lIE+AMd4Db+DvmeQIlqNoL1xbfIFeUiYZIWEMhbbxTe6T82fBtJQVkcfuwBWzs9vnZ
	 2v1VvzarKWKk6kHsUF7YLUq8XDSco1Hy7lT0Owon3EWnk74hfL0VsyDxC1CugjAZrz
	 0KhAuvpzMf2pXyQG4H3hQtLNkWpqyEAMtY8aiDijMy3p5zSKqi5zD7Nsuw/CecffIl
	 Y+CFLFQ5Ck/om6P0AA0xzbTrnH45tDY2ptwuSj3T2Ag4pWXq1iPlboUxdMmHpjZus1
	 pT5EdHo2bLaXg==
Date: Wed, 30 Apr 2025 18:49:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Huewe <peterhuewe@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 4/4] tpm/tpm_svsm: support TPM_CHIP_FLAG_SYNC
Message-ID: <aBJGkSil1YAzSXsg@kernel.org>
References: <20250414145653.239081-1-sgarzare@redhat.com>
 <20250414145653.239081-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414145653.239081-5-sgarzare@redhat.com>

On Mon, Apr 14, 2025 at 04:56:53PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This driver does not support interrupts, and receiving the response is
> synchronous with sending the command.
> 
> So we can set TPM_CHIP_FLAG_SYNC to support synchronous send() and
> return responses in the same buffer used for commands. This way we
> don't need to implement recv() op.
> 
> Keep using the same pre-allocated buffer to avoid having to allocate
> it for each command. We need the buffer to have the header required by
> the SVSM protocol and the command contiguous in memory.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Similar comments, and a bit redundancy does not matter i.e., they can
have pretty much the same explanation.

> ---
>  drivers/char/tpm/tpm_svsm.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> index d3ca5615b6f7..db1983072345 100644
> --- a/drivers/char/tpm/tpm_svsm.c
> +++ b/drivers/char/tpm/tpm_svsm.c
> @@ -25,38 +25,32 @@ struct tpm_svsm_priv {
>  	void *buffer;
>  };
>  
> -static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len,
> +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
>  			 size_t buf_size)
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
> +	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, buf_size);
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

BR, Jarkko

