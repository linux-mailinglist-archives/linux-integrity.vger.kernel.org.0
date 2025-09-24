Return-Path: <linux-integrity+bounces-7256-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC2B97FDC
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 03:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705C73BC0E5
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 01:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752E6F305;
	Wed, 24 Sep 2025 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0IRjL84"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83B8C11;
	Wed, 24 Sep 2025 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676747; cv=none; b=gWkQOLtjlGSSMf00f1kra9HRq0m2MCYi+gTW3PlKP/5PJ3yHzC67kTf7/Z4M45+UOK9pxyTA0cd8ioLNT3Uk5xPQw3rl7z7BiCXgtz+wH2vEn+5rfmeCzGox6D3f7oYgf3nPtxCD99+LLNO30IyV51Xc68hUnKLoyADYwQZ9Ywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676747; c=relaxed/simple;
	bh=4ckDzFBdDWTMnu77Q7MkJM1VEgwyVh5pEBFVZ0CjY1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g86kVkvDspNO+DoJikOe28wjfpa5Tx1BBlsccBuTBCmIR7yJ/J6fm4Bh9vtyRQ3APZHJgvnnTVow+QoCgL/KFogvfPrGoGX8EzFjPUPznoN0uIhadpSOj0WdrU/qxJkE4Hd/PKJCGoUwhCba5mQU5Z9op0KZIGxV5TqBJbMhVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0IRjL84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57B9C4CEF5;
	Wed, 24 Sep 2025 01:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758676747;
	bh=4ckDzFBdDWTMnu77Q7MkJM1VEgwyVh5pEBFVZ0CjY1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0IRjL84sClowTdYXfeUurDkvPnKx2JYFnPYztltG2oGjx6p2xAPTwQaXyY7RBSqv
	 TzlIFofBvC9msph5IpRNHWf7YP7j8/ZEXduoz0O8OQSqkfoRkzi7w2sRl6fadJt3s1
	 cQUXZi9hn+99vV/+eDYy6yqnS5ueIPuv7ESbGKfyk4c5mdwZGm3p1K/85Y2btdqsyL
	 i5GwD39f779F8lEjbPBpQOnokeGZ2XhoWTxsOO3q7gTfB/C5KlFbiBi1PhyyX0/qlG
	 50RbaqdELOL4xuqnY4wiWqyOPbKtt28/R8CktrSV7UeufE68kNHmO+uLyEbkZ+FqAc
	 9M8LrFOehS/Cg==
Date: Wed, 24 Sep 2025 04:19:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tpm: Remove tpm_find_get_ops
Message-ID: <aNNHBzE3MiAsUkx0@kernel.org>
References: <cover.1758646791.git.noodles@meta.com>
 <99f6216783c4c1c71668ec951cfd8f73bbf93bc6.1758646791.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f6216783c4c1c71668ec951cfd8f73bbf93bc6.1758646791.git.noodles@meta.com>

On Tue, Sep 23, 2025 at 06:10:11PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> tpm_find_get_ops() looks for the first valid TPM if the caller passes in
> NULL. All internal users have been converted to either associate
> themselves with a TPM directly, or call tpm_default_chip() as part of
> their setup. Remove the no longer necessary tpm_find_get_ops().
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>

This patch fits really well with the changes I've been working on
streamlining some parts (mainly tpm_bufs and sanitizing tpm2-sessions).

I might have ended up doing this type of path myself so I'm glad
it's done.

> ---
>  drivers/char/tpm/tpm-chip.c      | 36 --------------------------------
>  drivers/char/tpm/tpm-interface.c | 20 ++++++++++++++----
>  drivers/char/tpm/tpm.h           |  1 -
>  drivers/char/tpm/tpm_tis_core.c  |  3 +--
>  4 files changed, 17 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8c8e9054762a..ba906966721a 100644
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
> index b71725827743..8f65dc06a157 100644
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
> index 7bb87fa5f7a1..9c158c55c05f 100644
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
> index 4b12c4b9da8b..73b94f4daf4b 100644
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
> 2.51.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

