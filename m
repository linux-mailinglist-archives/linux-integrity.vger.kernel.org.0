Return-Path: <linux-integrity+bounces-7720-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E0C90413
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 644EC34E576
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120A304BA6;
	Thu, 27 Nov 2025 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQDG4WxN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963D2BE630;
	Thu, 27 Nov 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764280490; cv=none; b=Laa8JweastaK0XpZMfLlkRX63lleDLZm2vJUPJ/h2qi3Py6LkrbN5sNH24LvvPjjHvIlK/e6uH7Ju5gTvhD/p4bPyEu2pQEAdnLrurFzabPAFrS+x0hcQxqPAcOSm3N1pzSPMNapY/TDmWxYDnLUenRGR6i6HhGunI+GxEisCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764280490; c=relaxed/simple;
	bh=Q2Mdt8wGwW8ccdBiB+zrLkSWXFow9jncK8IMk/T0rR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulQ1dtsWuS+Cd/mrkg0xbS9vbTiHOrIbX7A2611prOt97QyQ48qvPtiIqGJ8/bxZKlHew/f1BCTFig6bcQ3zt1pyKDPBgA03jzu2S//96m637qDrKzOSx2kMsA8MqU8p7ElJjndUejR555E9BfArW+sIzRcuKljn8N44LY9fsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQDG4WxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341CBC4CEF8;
	Thu, 27 Nov 2025 21:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764280489;
	bh=Q2Mdt8wGwW8ccdBiB+zrLkSWXFow9jncK8IMk/T0rR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQDG4WxNnER3sK0QjhSGRWW7SLQSk5Zc3FA+F7kBX6m45A0dPuHsPzhmiD5zj8bkr
	 ejUQG8G/BoSDZos2jSG9NU7yzcUSiVhm62Ju1N2q9FGxZgcjmqDuz2pzdD49J/qNyW
	 3B6LIL2CKgeuGrFJyiQMXHwgQxx9WdZMiplC6l2kW3OMF1FTO6uVJCmhCbRKZ21TsX
	 N66hMHZAsrgcy/7ude2/lKw8HRdX9Xy8i7gcLElw1no716wbjsY/g6iptaus3FficJ
	 L++TDdqQwYTTwVxu6NhFjgABuymAYMBI9dWV1uliGeS7wdtpYmoyAvHm1KVs/xTahp
	 zeCX+axdP9JSw==
Date: Thu, 27 Nov 2025 23:54:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Remove tpm_find_get_ops
Message-ID: <aSjIpUZhAd5PxSBg@kernel.org>
References: <aSiEJWcmkADPHEOY@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSiEJWcmkADPHEOY@earth.li>

On Thu, Nov 27, 2025 at 05:02:29PM +0000, Jonathan McDowell wrote:
> tpm_find_get_ops() looks for the first valid TPM if the caller passes in
> NULL. All internal users have been converted to either associate
> themselves with a TPM directly, or call tpm_default_chip() as part of
> their setup. Remove the no longer necessary tpm_find_get_ops().
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
> (Separating this out from the exclusive access series, because I think 
> this bit is uncontroversial and is a legit cleanup.)
> 
>  drivers/char/tpm/tpm-chip.c      | 36 --------------------------------
>  drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++----
>  drivers/char/tpm/tpm.h           |  1 -
>  drivers/char/tpm/tpm_tis_core.c  |  3 +--
>  4 files changed, 17 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e25daf2396d3..30d00219f9f3 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -230,42 +230,6 @@ struct tpm_chip *tpm_default_chip(void)
>  }
>  EXPORT_SYMBOL_GPL(tpm_default_chip);
>  
> -/**
> - * tpm_find_get_ops() - find and reserve a TPM chip
> - * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> - *
> - * Finds a TPM chip and reserves its class device and operations. The chip must
> - * be released with tpm_put_ops() after use.
> - * This function is for internal use only. It supports existing TPM callers
> - * by accepting NULL, but those callers should be converted to pass in a chip
> - * directly.
> - *
> - * Return:
> - * A reserved &struct tpm_chip instance.
> - * %NULL if a chip is not found.
> - * %NULL if the chip is not available.
> - */
> -struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
> -{
> -	int rc;
> -
> -	if (chip) {
> -		if (!tpm_try_get_ops(chip))
> -			return chip;
> -		return NULL;
> -	}
> -
> -	chip = tpm_default_chip();
> -	if (!chip)
> -		return NULL;
> -	rc = tpm_try_get_ops(chip);
> -	/* release additional reference we got from tpm_default_chip() */
> -	put_device(&chip->dev);
> -	if (rc)
> -		return NULL;
> -	return chip;
> -}
> -
>  /**
>   * tpm_dev_release() - free chip memory and the device number
>   * @dev: the character device for the TPM chip
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index c9f173001d0e..f745a098908b 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -313,10 +313,13 @@ int tpm_is_tpm2(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> -	chip = tpm_find_get_ops(chip);
>  	if (!chip)
>  		return -ENODEV;
>  
> +	rc = tpm_try_get_ops(chip);
> +	if (rc)
> +		return rc;
> +
>  	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) != 0;
>  
>  	tpm_put_ops(chip);
> @@ -338,10 +341,13 @@ int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  {
>  	int rc;
>  
> -	chip = tpm_find_get_ops(chip);
>  	if (!chip)
>  		return -ENODEV;
>  
> +	rc = tpm_try_get_ops(chip);
> +	if (rc)
> +		return rc;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		rc = tpm2_pcr_read(chip, pcr_idx, digest, NULL);
>  	else
> @@ -369,10 +375,13 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  	int rc;
>  	int i;
>  
> -	chip = tpm_find_get_ops(chip);
>  	if (!chip)
>  		return -ENODEV;
>  
> +	rc = tpm_try_get_ops(chip);
> +	if (rc)
> +		return rc;
> +
>  	for (i = 0; i < chip->nr_allocated_banks; i++) {
>  		if (digests[i].alg_id != chip->allocated_banks[i].alg_id) {
>  			rc = -EINVAL;
> @@ -492,10 +501,13 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  	if (!out || max > TPM_MAX_RNG_DATA)
>  		return -EINVAL;
>  
> -	chip = tpm_find_get_ops(chip);
>  	if (!chip)
>  		return -ENODEV;
>  
> +	rc = tpm_try_get_ops(chip);
> +	if (rc)
> +		return rc;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		rc = tpm2_get_random(chip, out, max);
>  	else
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2726bd38e5ac..02c07fef41ba 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -267,7 +267,6 @@ static inline void tpm_msleep(unsigned int delay_msec)
>  int tpm_chip_bootstrap(struct tpm_chip *chip);
>  int tpm_chip_start(struct tpm_chip *chip);
>  void tpm_chip_stop(struct tpm_chip *chip);
> -struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>  
>  struct tpm_chip *tpm_chip_alloc(struct device *dev,
>  				const struct tpm_class_ops *ops);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 8954a8660ffc..e2a1769081b1 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -265,8 +265,7 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
>  
>  			/*
>  			 * Dump stack for forensics, as invalid TPM_STS.x could be
> -			 * potentially triggered by impaired tpm_try_get_ops() or
> -			 * tpm_find_get_ops().
> +			 * potentially triggered by impaired tpm_try_get_ops().
>  			 */
>  			dump_stack();
>  		}
> -- 
> 2.52.0
> 

Thanks. I changed author to @meta.com in order to address checkpatch
complaint.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

It's pushed to master/next.

BR, Jarkko

