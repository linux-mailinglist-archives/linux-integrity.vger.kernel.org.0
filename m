Return-Path: <linux-integrity+bounces-7004-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AAFB429C8
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 21:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F211BC60C9
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Sep 2025 19:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9734AAFE;
	Wed,  3 Sep 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ictWGzIV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BA31354F;
	Wed,  3 Sep 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927380; cv=none; b=BU1gr46KiksFAhfM7uC7F0fMEPm3IMYsJrGdLsUYBsSrRtqI4LkLtwraS2nz4dGWOZtKAPlIhEiVfISmRFrakF8XVuJGvjrgfOvQTrqLAFl5PAsLx92hvT6KQ48+A3jJxOCGQ79PhOGafhhBxU0yTTWTqrmebUtq2SHHA7cC5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927380; c=relaxed/simple;
	bh=wmn/gNIk8OauV7Ug+01aR8efPqOv6wLmyXjJF9wL4ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRe3kH6esUtJ3E/w2jMJpl/PyUj11O/jsfXyO9WaAhfXmk4pvQN7Zg4v4dobOlkWjB1G8fyUErcV5sh9lW4thwMSXoGNBrqBIhlRBQEbVgpcC5S4SZMh1H2grm5X9OGwH48g1HqwadlUh24NwxvhZynpF0HYGL95W9KifUaL3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ictWGzIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AACC4CEE7;
	Wed,  3 Sep 2025 19:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927380;
	bh=wmn/gNIk8OauV7Ug+01aR8efPqOv6wLmyXjJF9wL4ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ictWGzIVnHtOW+dmZlPDkdXn9lU1pc6pprhTivZJY4n0lygPKqGrAhL10d61hjzvA
	 DlHn73BaYqe4ccJJNJwYs6yS0RRqOt9vBMI6I+hNQUu0J7MTZtLsU6663a7GlH4HTf
	 gnT9vl6dNK0D9e/gz+7EPemEBNSq7ND24zZ4okcsgdrmL10iz8mKV9bUmTEGprsxOQ
	 sy8k68Qdff6JA5A6ExAvX+XOftFe+i0x0a95oB/Uz+fHPzAnMc0/akVcabhQ6WX9NH
	 HALYYEGq8LSZmmaBlODSyMcrAx0K+r8bH5kJlg0/b1+a0Dm7omWjoT+XZo+F9iR9g0
	 qBUpzusdYPEuQ==
Date: Wed, 3 Sep 2025 22:22:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] tpm: Ensure exclusive userspace access when
 using /dev/tpm<n>
Message-ID: <aLiVkKbcCoLqcLtG@kernel.org>
References: <cover.1756833527.git.noodles@meta.com>
 <d2d7c8105a73e43866f23c88b188ee6e83562726.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d7c8105a73e43866f23c88b188ee6e83562726.1756833527.git.noodles@meta.com>

On Tue, Sep 02, 2025 at 06:26:49PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> There is an is_open lock on /dev/tpm<n> that dates back to at least
> 2013, but it only prevents multiple accesses via *this* interface. It is
> perfectly possible for userspace to use /dev/tpmrm<n>, or the kernel to
> use the internal interfaces, to access the TPM.
> 
> This can cause problems with userspace expecting exclusive access and
> something changing state underneath it, for example while performing a
> TPM firmware upgrade.
> 
> Close the userspace loophole by changing the simple bit lock to a full
> read/write mutex. Direct /dev/tpm<n> access needs an exclusive write
> lock, the resource broker continues to allow concurrent access *except*
> when /dev/tpm<n> is open.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>

I think the rationale makes sense to me as they are different view port
for the exact same hardware instance, and /dev/tpmrm0 scales only within
its own virtual universum.

I don't know what would be the best write up but basically I'd cut the
story shorter a bit and explicitly enumerate these anchoring "hard
reasons". Problems in user space is something that I can imagine that
there is a variety problem but it is more abstract side of this
issue. When you have a smoking gun just point your finger to it
exactly.


> ---
>  drivers/char/tpm/tpm-chip.c  |  1 +
>  drivers/char/tpm/tpm-dev.c   | 14 ++++++++------
>  drivers/char/tpm/tpmrm-dev.c | 20 ++++++++++++++++++--
>  include/linux/tpm.h          |  3 ++-
>  4 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e25daf2396d3..8c8e9054762a 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -338,6 +338,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  
>  	mutex_init(&chip->tpm_mutex);
>  	init_rwsem(&chip->ops_sem);
> +	init_rwsem(&chip->open_lock);
>  
>  	chip->ops = ops;
>  
> diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
> index 97c94b5e9340..80c4b3f3ad18 100644
> --- a/drivers/char/tpm/tpm-dev.c
> +++ b/drivers/char/tpm/tpm-dev.c
> @@ -22,10 +22,12 @@ static int tpm_open(struct inode *inode, struct file *file)
>  
>  	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
>  
> -	/* It's assured that the chip will be opened just once,
> -	 * by the check of is_open variable, which is protected
> -	 * by driver_lock. */
> -	if (test_and_set_bit(0, &chip->is_open)) {
> +	/*
> +	 * Only one client is allowed to have /dev/tpm0 open at a time, so we
> +	 * treat it as a write lock. The shared /dev/tpmrm0 is treated as a
> +	 * read lock.
> +	 */
> +	if (!down_write_trylock(&chip->open_lock)) {
>  		dev_dbg(&chip->dev, "Another process owns this TPM\n");
>  		return -EBUSY;
>  	}
> @@ -39,7 +41,7 @@ static int tpm_open(struct inode *inode, struct file *file)
>  	return 0;
>  
>   out:
> -	clear_bit(0, &chip->is_open);
> +	up_write(&chip->open_lock);
>  	return -ENOMEM;
>  }
>  
> @@ -51,7 +53,7 @@ static int tpm_release(struct inode *inode, struct file *file)
>  	struct file_priv *priv = file->private_data;
>  
>  	tpm_common_release(file, priv);
> -	clear_bit(0, &priv->chip->is_open);
> +	up_write(&priv->chip->open_lock);
>  	kfree(priv);
>  
>  	return 0;
> diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
> index c25df7ea064e..40c139a080b6 100644
> --- a/drivers/char/tpm/tpmrm-dev.c
> +++ b/drivers/char/tpm/tpmrm-dev.c
> @@ -17,19 +17,34 @@ static int tpmrm_open(struct inode *inode, struct file *file)
>  	int rc;
>  
>  	chip = container_of(inode->i_cdev, struct tpm_chip, cdevs);
> +
> +	/*
> +	 * Only one client is allowed to have /dev/tpm0 open at a time, so we
> +	 * treat it as a write lock. The shared /dev/tpmrm0 is treated as a
> +	 * read lock.
> +	 */
> +	if (!down_read_trylock(&chip->open_lock)) {
> +		dev_dbg(&chip->dev, "Another process owns this TPM\n");
> +		return -EBUSY;
> +	}
> +
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (priv == NULL)
> -		return -ENOMEM;
> +		goto out;
>  
>  	rc = tpm2_init_space(&priv->space, TPM2_SPACE_BUFFER_SIZE);
>  	if (rc) {
>  		kfree(priv);
> -		return -ENOMEM;
> +		goto out;
>  	}
>  
>  	tpm_common_open(file, chip, &priv->priv, &priv->space);
>  
>  	return 0;
> +
> +out:

nit 

err:

as it is purely for error propagation


> +	up_read(&chip->open_lock);
> +	return -ENOMEM;
>  }
>  
>  static int tpmrm_release(struct inode *inode, struct file *file)
> @@ -40,6 +55,7 @@ static int tpmrm_release(struct inode *inode, struct file *file)
>  	tpm_common_release(file, fpriv);
>  	tpm2_del_space(fpriv->chip, &priv->space);
>  	kfree(priv);
> +	up_read(&fpriv->chip->open_lock);
>  
>  	return 0;
>  }
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index b0e9eb5ef022..548362d20b32 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -22,6 +22,7 @@
>  #include <linux/cdev.h>
>  #include <linux/fs.h>
>  #include <linux/highmem.h>
> +#include <linux/rwsem.h>
>  #include <crypto/hash_info.h>
>  #include <crypto/aes.h>
>  
> @@ -168,7 +169,7 @@ struct tpm_chip {
>  	unsigned int flags;
>  
>  	int dev_num;		/* /dev/tpm# */
> -	unsigned long is_open;	/* only one allowed */
> +	struct rw_semaphore open_lock;
>  
>  	char hwrng_name[64];
>  	struct hwrng hwrng;
> -- 
> 2.51.0
> 

BR, Jarkko

