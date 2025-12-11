Return-Path: <linux-integrity+bounces-7925-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 879BECB724D
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 21:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D838C301EF85
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382FD277819;
	Thu, 11 Dec 2025 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgsNkldv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E856200110;
	Thu, 11 Dec 2025 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484532; cv=none; b=TAjwjaMOMe3m7lVmT/CKSES6v3mMuEsbKVhDybOfa7dIQ84SG7tDdfIRq/LjcwfH5nw0EfTJmFbqAKNmN6Zha5ZiDub/usF+CnP74g72kd09QVvCG1d3YBGQBq5sTy9kZdDbJl3pRJ+wBVPOnxuFnHLf+sKUiyAPf6BEpVSkkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484532; c=relaxed/simple;
	bh=OTUbSafBlMdPjB7WkuRZL30NeFaSui4oJg03ss8lKjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bakqF587yU0AmAAGb/HDebJTyM6Ri4m3N0LghQxKlFbRNmOTKbgaVuW0euwqzc+N1vfBvIQzRNadYiiX9ewr/RsjcLctrKidyvKWCGDLlCXlt0tX6RWND1xs8X10+KsIcO5cigDSkxqisGLe9R1LGOUZlUDtGZ/wW6Nar1hKHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgsNkldv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22588C4CEF7;
	Thu, 11 Dec 2025 20:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765484531;
	bh=OTUbSafBlMdPjB7WkuRZL30NeFaSui4oJg03ss8lKjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgsNkldvX1Nc4me6puLvnsG1Us3cKfSX5xPEJhmQV5FIgjs94Rb6slOO/yk+yX3PS
	 9OYwNE7KQUZRqJ94Zm2KSfkfFzFADSCz4Fy/MmRnXw9bzCXtZIGLbkKqjpzWhMCQF3
	 1GulEMh0X6Gbxk+fyvQ1WN7/iYx31qPn50yaVv0XHji9TQF5U+1OFaeeLqKLPTyV/O
	 GZKJLLD3rIQIjZ+FS+1283FNu1X35wPlaLWnLW+lKRrtA5liD/N3PhovMwJy4Zm5te
	 eLpnnXbtiTtFLWyCWp/vZVF8DvmEcufFekkJ0KVd9HlyHMvxHXHRoFiXi+IbGLOcSi
	 /z8+gUEsUQRhg==
Date: Thu, 11 Dec 2025 22:22:07 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Message-ID: <aTsn7wNwAt3F2aLw@kernel.org>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>

On Thu, Dec 11, 2025 at 06:15:11PM +0100, Uwe Kleine-König wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/char/tpm/tpm_ftpm_tee.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index e5fbc70b0eca..20294d1953a3 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -169,7 +169,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
>   * Return:
>   *	On success, 0. On failure, -errno.
>   */
> -static int ftpm_tee_probe(struct device *dev)
> +static int ftpm_tee_probe_generic(struct device *dev)
>  {
>  	int rc;
>  	struct tpm_chip *chip;
> @@ -251,11 +251,18 @@ static int ftpm_tee_probe(struct device *dev)
>  	return rc;
>  }
>  
> +static int ftpm_tee_probe(struct tee_client_device *tcdev)
> +{
> +	struct device *dev = &tcdev->dev;
> +
> +	return ftpm_tee_probe_generic(dev);
> +}
> +
>  static int ftpm_plat_tee_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  
> -	return ftpm_tee_probe(dev);
> +	return ftpm_tee_probe_generic(dev);
>  }
>  
>  /**
> @@ -265,7 +272,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
>   * Return:
>   *	0 always.
>   */
> -static int ftpm_tee_remove(struct device *dev)
> +static void ftpm_tee_remove_generic(struct device *dev)
>  {
>  	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
>  
> @@ -285,15 +292,20 @@ static int ftpm_tee_remove(struct device *dev)
>  	tee_client_close_context(pvt_data->ctx);
>  
>  	/* memory allocated with devm_kzalloc() is freed automatically */
> +}
>  
> -	return 0;
> +static void ftpm_tee_remove(struct tee_client_device *tcdev)
> +{
> +	struct device *dev = &tcdev->dev;
> +
> +	ftpm_tee_remove_generic(dev);
>  }
>  
>  static void ftpm_plat_tee_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  
> -	ftpm_tee_remove(dev);
> +	ftpm_tee_remove_generic(dev);
>  }
>  
>  /**
> @@ -335,11 +347,11 @@ static const struct tee_client_device_id optee_ftpm_id_table[] = {
>  MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
>  
>  static struct tee_client_driver ftpm_tee_driver = {
> +	.probe		= ftpm_tee_probe,
> +	.remove		= ftpm_tee_remove,
>  	.id_table	= optee_ftpm_id_table,
>  	.driver		= {
>  		.name		= "optee-ftpm",
> -		.probe		= ftpm_tee_probe,
> -		.remove		= ftpm_tee_remove,
>  	},
>  };
>  
> -- 
> 2.47.3
> 

I checked trusted key patches and ftpm patches. I don't have anything
against merging them.

So for those four patches:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

