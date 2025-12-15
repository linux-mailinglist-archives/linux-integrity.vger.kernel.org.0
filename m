Return-Path: <linux-integrity+bounces-8004-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C7CC023A
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A9B300FE1E
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 22:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231112FE596;
	Mon, 15 Dec 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB3niWaC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BF2638AF;
	Mon, 15 Dec 2025 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765839213; cv=none; b=jGVbUgJq9/PEA6jle1TtHw3DjNm5pYCxAo7lsoXQOcC4EGd4XKpc4GeTFOBDn7pXAqynztDuVfaRoX9NCnmbtkrTKxF1X8sOyIJ/CB8a4ThB/iXVMYJFyEZ2lMqw3BWNA+Z1E2ZyF8QAvZjfrFwesEK+0orFcNupqwTiSSMwGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765839213; c=relaxed/simple;
	bh=B1h7/1DmR44SJyNfk6xG+ATAskZvle6ewB/MpObH3BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBXuPJtKZRnNpYt7HKi4mGcwI04OJOhOKd2Drv5v1CST6y9ITmeep+B2Ar1jepPBIKlZTOMIw15GmxbHfT7mBCjEFy9R/gSe0EJNttY6B1qstj4O/tES/LBD1vAuuNNcM/J62Ls17cnz2mBIm+/OlCETrJhdk2n9+6PmXdZbCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB3niWaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1247FC4CEF5;
	Mon, 15 Dec 2025 22:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765839212;
	bh=B1h7/1DmR44SJyNfk6xG+ATAskZvle6ewB/MpObH3BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB3niWaC7Ien1/Y0GfZr61WTp6exsLmJF1/UrG6af14N+OjXWdpLP25l6BBzgOpIT
	 djGIMMSCvyjaj2nkF6J7MLkehpBA8LomYDaUGRD87j+Rc+aPu32pWdImvEY6q2c4hm
	 B/HXj8wCviR1HgEUIjtrSEHAH5y7Lm8HMKQON9PMCGDR6Rt/qEwnEgp6OZ9a8i8tzp
	 lhYvuiXeuM0MGO0jBvp/i5sWbpRJ/jaxjN3/5OSqe/khUQIsDIqMCJz6P9aMGgo8Jj
	 C6dBFPhvo1On1oqjbnsJw7HzWqjBWiobjJb5eihikAkk5KBINZyQ5va6R5CKVc3Xwm
	 kzEX8x1ZhYwfA==
Date: Tue, 16 Dec 2025 00:53:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@kernel.org>, linux-integrity@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v2 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Message-ID: <aUCRaIL9DFSZcA7O@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <7bb98eeb8a478ca69344499f2e58016bbf787313.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bb98eeb8a478ca69344499f2e58016bbf787313.1765791463.git.u.kleine-koenig@baylibre.com>

On Mon, Dec 15, 2025 at 03:16:47PM +0100, Uwe Kleine-König wrote:
> The tee bus got dedicated callbacks for probe and remove.

nit: "TEE subsystem has implemented callbacks for probe() and remove()".

Or this what I presume has happened: someone has implemented new
callbacks to subsystem (vs randomly appearing from the divine
skies).

> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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

BR, Jarkko

