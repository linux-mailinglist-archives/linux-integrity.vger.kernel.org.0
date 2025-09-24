Return-Path: <linux-integrity+bounces-7257-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDDB97FEE
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 03:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752524A443F
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91DD1E8322;
	Wed, 24 Sep 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6Y3Bysg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE71DA60F;
	Wed, 24 Sep 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676932; cv=none; b=MirRbF8LrlsWGePqWlnceBnhXgepM28BEhQaWR0aqY4YPTKkBO81JFtnzZCjGFNEDkWxn+M5ujEMHKAqfCa7aa8LRmNMdvdBRse72a1rNLSJo6JvcHAXFyroIWVqh3R8Td4JokrTH+8zKlNNwO5YZcyqRZ8dWJFJ5nEP0QpwaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676932; c=relaxed/simple;
	bh=PRDoBVqVXakfc3nlAj7RF/ig9jmQGLhKhOfaDtbry8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbKSAT3ev0hFi0UiWy2RPCpVb0cFsf/wELEMR6zkgz5m0jEhIehaK7sPLPtXjmne29hgbgsvhuK+ZtdCZqkUnxzEcyYdIK5rGyzfV5Zh6oSbBZwc1RPXOxNLZR1BqkguReYtWETehgRic6ldSQZ3Jef9MbCxbLNya1naqmvOj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6Y3Bysg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0136C4CEF5;
	Wed, 24 Sep 2025 01:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758676932;
	bh=PRDoBVqVXakfc3nlAj7RF/ig9jmQGLhKhOfaDtbry8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6Y3Bysgfz9QupipffPSKfBM9aNmjhqY057NnOtiXxJP4Dti/AgeZRllHsconW6LN
	 DDkx+xEwRt5dPJ8fnCaoXVYWoxBY0tSjgw/llM7ZbbipLDSzsAL/JAbJxUPD6qGsUH
	 I2xT3SD2z2sJGaBuErIMbhERRZy2pPBLkwOJ++5A+qH0NY0o/TWAmY0K0oNqYK+i5e
	 dqlUj1doskZDfB+1ZBvoHo7aXYwAKLq0hCi03rd6mP1jqmyEKz5Cp0um7znTkd0/oR
	 ExeEZByWFkXjtIuD4tVxlm3LOzSQ+3Q3sQoFYKbop3Qeha4mdsmoY2QFCuoH8gk5ZG
	 LKxZKAv3ywmHg==
Date: Wed, 24 Sep 2025 04:22:08 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
Message-ID: <aNNHwAUv52mwazCs@kernel.org>
References: <cover.1758646791.git.noodles@meta.com>
 <efb33d755aec0f557407fd69b0f68d9a69c33435.1758646791.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb33d755aec0f557407fd69b0f68d9a69c33435.1758646791.git.noodles@meta.com>

On Tue, Sep 23, 2025 at 06:10:19PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> There are situations where userspace might reasonably desire exclusive
> access to the TPM, or the kernel's internal context saving + flushing
> may cause issues, for example when performing firmware upgrades. Extend
> the locking already used for avoiding concurrent userspace access to
> prevent internal users of the TPM when /dev/tpm<n> is in use.
> 
> The few internal users who already hold the open_lock are changed to use
> tpm_(try_get|put)_ops_locked, with the old tpm_(try_get|put)_ops
> functions changing to obtain read access to the open_lock.  We return
> -EBUSY when another user has exclusive access, rather than adding waits.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
> v2: Switch to _locked instead of _internal_ for function names.
> 
>  drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
>  drivers/char/tpm/tpm-dev-common.c |  8 ++---
>  drivers/char/tpm/tpm.h            |  2 ++
>  drivers/char/tpm/tpm2-space.c     |  5 ++-
>  4 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ba906966721a..687f6d8cd601 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_chip_stop);
>  
>  /**
> - * tpm_try_get_ops() - Get a ref to the tpm_chip
> + * tpm_try_get_ops_locked() - Get a ref to the tpm_chip
>   * @chip: Chip to ref
>   *
>   * The caller must already have some kind of locking to ensure that chip is
> @@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
>   *
>   * Returns -ERRNO if the chip could not be got.
>   */
> -int tpm_try_get_ops(struct tpm_chip *chip)
> +int tpm_try_get_ops_locked(struct tpm_chip *chip)
>  {
>  	int rc = -EIO;
>  
> @@ -185,22 +185,57 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>  	put_device(&chip->dev);
>  	return rc;
>  }
> -EXPORT_SYMBOL_GPL(tpm_try_get_ops);
>  
>  /**
> - * tpm_put_ops() - Release a ref to the tpm_chip
> + * tpm_put_ops_locked() - Release a ref to the tpm_chip
>   * @chip: Chip to put
>   *
> - * This is the opposite pair to tpm_try_get_ops(). After this returns chip may
> - * be kfree'd.
> + * This is the opposite pair to tpm_try_get_ops_locked(). After this returns
> + * chip may be kfree'd.
>   */
> -void tpm_put_ops(struct tpm_chip *chip)
> +void tpm_put_ops_locked(struct tpm_chip *chip)
>  {
>  	tpm_chip_stop(chip);
>  	mutex_unlock(&chip->tpm_mutex);
>  	up_read(&chip->ops_sem);
>  	put_device(&chip->dev);
>  }
> +
> +/**
> + * tpm_try_get_ops() - Get a ref to the tpm_chip
> + * @chip: Chip to ref
> + *
> + * The caller must already have some kind of locking to ensure that chip is
> + * valid. This function will attempt to get the open_lock for the chip,
> + * ensuring no other user is expecting exclusive access, before locking the
> + * chip so that the ops member can be accessed safely. The locking prevents
> + * tpm_chip_unregister from completing, so it should not be held for long
> + * periods.
> + *
> + * Returns -ERRNO if the chip could not be got.
> + */
> +int tpm_try_get_ops(struct tpm_chip *chip)
> +{
> +	if (!down_read_trylock(&chip->open_lock))
> +		return -EBUSY;
> +
> +	return tpm_try_get_ops_locked(chip);
> +}
> +EXPORT_SYMBOL_GPL(tpm_try_get_ops);
> +
> +/**
> + * tpm_put_ops() - Release a ref to the tpm_chip
> + * @chip: Chip to put
> + *
> + * This is the opposite pair to tpm_try_get_ops(). After this returns
> + * chip may be kfree'd.
> + */
> +void tpm_put_ops(struct tpm_chip *chip)
> +{
> +	tpm_put_ops_locked(chip);
> +
> +	up_read(&chip->open_lock);
> +}
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
>  /**
> @@ -644,10 +679,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	int rc;
>  
> -	rc = tpm_try_get_ops(chip);
> +	rc = tpm_try_get_ops_locked(chip);
>  	if (!rc) {
>  		tpm2_end_auth_session(chip);
> -		tpm_put_ops(chip);
> +		tpm_put_ops_locked(chip);
>  	}
>  #endif
>  
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index f2a5e09257dd..0f5bc63411aa 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -65,7 +65,7 @@ static void tpm_dev_async_work(struct work_struct *work)
>  
>  	mutex_lock(&priv->buffer_mutex);
>  	priv->command_enqueued = false;
> -	ret = tpm_try_get_ops(priv->chip);
> +	ret = tpm_try_get_ops_locked(priv->chip);
>  	if (ret) {
>  		priv->response_length = ret;
>  		goto out;
> @@ -73,7 +73,7 @@ static void tpm_dev_async_work(struct work_struct *work)
>  
>  	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
>  			       sizeof(priv->data_buffer));
> -	tpm_put_ops(priv->chip);
> +	tpm_put_ops_locked(priv->chip);
>  
>  	/*
>  	 * If ret is > 0 then tpm_dev_transmit returned the size of the
> @@ -220,14 +220,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	 * lock during this period so that the tpm can be unregistered even if
>  	 * the char dev is held open.
>  	 */
> -	if (tpm_try_get_ops(priv->chip)) {
> +	if (tpm_try_get_ops_locked(priv->chip)) {
>  		ret = -EPIPE;
>  		goto out;
>  	}
>  
>  	ret = tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
>  			       sizeof(priv->data_buffer));
> -	tpm_put_ops(priv->chip);
> +	tpm_put_ops_locked(priv->chip);
>  
>  	if (ret > 0) {
>  		priv->response_length = ret;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 9c158c55c05f..c2ec56e2cd24 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -272,6 +272,8 @@ struct tpm_chip *tpm_chip_alloc(struct device *dev,
>  				const struct tpm_class_ops *ops);
>  struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  				 const struct tpm_class_ops *ops);
> +int tpm_try_get_ops_locked(struct tpm_chip *chip);
> +void tpm_put_ops_locked(struct tpm_chip *chip);
>  int tpm_chip_register(struct tpm_chip *chip);
>  void tpm_chip_unregister(struct tpm_chip *chip);
>  
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 60354cd53b5c..0ad5e18355e0 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -58,10 +58,9 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>  
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  {
> -
> -	if (tpm_try_get_ops(chip) == 0) {
> +	if (tpm_try_get_ops_locked(chip) == 0) {
>  		tpm2_flush_sessions(chip, space);
> -		tpm_put_ops(chip);
> +		tpm_put_ops_locked(chip);
>  	}
>  
>  	kfree(space->context_buf);
> -- 
> 2.51.0
> 

I can take these to the next PR, thanks.

BR, Jarkko

