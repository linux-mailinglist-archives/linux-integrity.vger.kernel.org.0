Return-Path: <linux-integrity+bounces-7047-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F71FB51E59
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2C73A20C8
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2732798F3;
	Wed, 10 Sep 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0KSeCuY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9909226D1D;
	Wed, 10 Sep 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523265; cv=none; b=Lm7WFtKKlGCjCqca1+EdjaQDAPGDV07ePN5PS7ZhKm2Awiie44OpqGYOba4OmIynOr+zeKzmiHrOJAv8R9cW0VLPgmNV4vTlPZSAbHR2ql4R88an+l2mlAJkMhspC5nghqyqLIgYI4pgyKcgpibZSuI7ASz6sxhxcMTRU5kL30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523265; c=relaxed/simple;
	bh=x617WPPMSkNXqdPPSiCbqo3B1cRcv9yl6Yk8mFOktgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDacB2+8CE6Zppa2dLgqpGbvwwGTn7kFdAqr3MznnlVoar/1jNpX1xBACBkjO2a9mKNLJiguhJALCd9HbVHw1Hys8eE4ulkWo20+psrKdb9gWle6vnCi5TMEERh+uqVfGChpEX5XKL/r4Bs0vFBCqmUz3uqEqBYRG7C6tHuDLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0KSeCuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB8EC4CEEB;
	Wed, 10 Sep 2025 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523264;
	bh=x617WPPMSkNXqdPPSiCbqo3B1cRcv9yl6Yk8mFOktgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0KSeCuYvcljMyXqODCNzhi0FnCjKgtgjISOelHqyvIZlk0elwXpD0PEnvfpfU7Tb
	 aBM+UXTyyEWabjxp7D0OuDx/TYumIqNoj6u0bpIhsXLNFt+I7giXPPR4O5+MqvOp63
	 eFWuPifgOrDVEMO7hkbmDVv5dcSdOKrQnoDH1qnltycAs7r2rLQjBpNAYo53gnNkIL
	 G9qzXg4dMRgGE1hXRXe2Fif09R0G5YosDsJL4EXbNOOR45tzNWNRouxyb/8OB0HS7c
	 Bj6pWoVR4OwQpP3nsxXuNmdx5Lbeaqoo8jmWDILHWXNeia4gl1p7lJ7TCMjvoD3dI/
	 xI0GDiTguNLyg==
Date: Wed, 10 Sep 2025 19:54:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] tpm: Remove tpm_find_get_ops
Message-ID: <aMGtPNV0lgH54yqK@kernel.org>
References: <cover.1756833527.git.noodles@meta.com>
 <659c2a453908ba98ee6481c25ab878a65133d3af.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659c2a453908ba98ee6481c25ab878a65133d3af.1756833527.git.noodles@meta.com>

On Tue, Sep 02, 2025 at 06:27:03PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> tpm_find_get_ops() looks for the first valid TPM if the caller passes in
> NULL. All internal users have been converted to either associate
> themselves with a TPM directly, or call tpm_default_chip() as part of
> their setup. Remove the no longer necessary tpm_find_get_ops().
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>

This is a welcome change, thanks.

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

Sorry outside scope of the review but I'll remark something while I
still remember it :-)

Looking at "if  (!test_and_set_bit(TPM_TIS_INVALID_STATUS, &priv->flags)) {"

Despite unfortunately git blame points out to me I don't agree with the
"pr_err + dump_stack" rollback sequence:

1. Stack here is useless noise.
2. This should be fallible situation really, as at it can be affected by
   outside stimuli, not just long-strech malicious device alike case,
   but also it could be like perhaps TPM emulator or something else
   more flakky than a chip.

Improved rollback sequence would be:

1. Print dev_err, exactly as it does now. It's not a kernel bug per se
   but something is definitely acting weirdly.
2. Make '->status' fallible so that rollback can be further propagated
   to 'tpm_transmit'
3. Return some sensible POSIX error code, probably -EIO combined with
   pre-existing dev_err would be fine.

Back to the topic. I agree with the patch. I'll come back on this
once I've tested it with a live kernel in my environment [1].

[1] https://codeberg.org/jarkko/linux-tpmdd-test
    
BR, Jarkko

