Return-Path: <linux-integrity+bounces-7255-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C516B97FB7
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 03:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE174C3CEE
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F21F3B85;
	Wed, 24 Sep 2025 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ/zqcZk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8CC2E0;
	Wed, 24 Sep 2025 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676501; cv=none; b=LLAWBdUXr7FNwhq6qSSv9n7Uutg2vj1WXlD71RL0JSEHRJYWzTkR2RjjzqIjtx0EZ4nHQzyyX1C5OCwDWqAedGeOmSA74ZsxGgwBLrOWU0blPDQ3Ai63f19hD3gnpmPLhaKnIXySZU5Mc5eoGeZM3ydFBI4qHxpl+LI94sBcHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676501; c=relaxed/simple;
	bh=JiyOmmu/L6xN4AZgB4LR7xvyam9W9RhGmQa4QapilEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1RiLZVUfU69IV7C+RbGTpf4cI/HadfzDJ4/4Xeix5TYMGYx9fepe4ZNCBROU3nzAmuITM03hCRDNJrWJkQQCVE82WnxEMvyWwwUfhVrAxS1Db78VRkgcFiRqBT/JXyXamU0zU0PyjVFqbIJ+fqMihVlwYL9gKGdKgQCei/y2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ/zqcZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E66BC4CEF5;
	Wed, 24 Sep 2025 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758676500;
	bh=JiyOmmu/L6xN4AZgB4LR7xvyam9W9RhGmQa4QapilEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZ/zqcZkm0D/xt1+chS6mxJJOiE8I38yy/DlTyqjG4JvHHBlpZLo/F39MX7D04vZF
	 F/gib6LLCrzF5W7evXTtXUsEYdkUkmwpYDvnrO5q3nP2Nm7lHCMEgiVPKY9ZgDjHcb
	 4Pbvsg0tJL2DSjUc8L/47lqXUWVnoQqFljSUdCsB+qKtMINKs03hSgm+acglGZgqi3
	 YYyauwd+qCCRdtZYEkrHLhBEEQPBFSMPNkDXLfNqkpdj9BsK+BicIom1gI3IzHFK+4
	 Vp7yqgmhsBh+MOaYABntnmzmyvdtSOmNoHZSu+MMNET+nuOSk7jvdcbdV21+xTwZSq
	 Aj03abyr+HC+A==
Date: Wed, 24 Sep 2025 04:14:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Ensure exclusive userspace access when using
 /dev/tpm<n>
Message-ID: <aNNGECfE2izNx2LM@kernel.org>
References: <cover.1758646791.git.noodles@meta.com>
 <5497b6bbaaed64fbd245aff0190904c9beba714b.1758646791.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5497b6bbaaed64fbd245aff0190904c9beba714b.1758646791.git.noodles@meta.com>

On Tue, Sep 23, 2025 at 06:10:00PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> There is an is_open lock on /dev/tpm<n> that dates back to at least
> 2013, but it only prevents multiple accesses via *this* interface. It is
> perfectly possible for userspace to use /dev/tpmrm<n>, or the kernel to
> use the internal interfaces, to access the TPM. For tooling expecting
> exclusive access, such as firmware updates, this can cause issues.
> 
> Close the userspace loophole by changing the simple bit lock to a full
> read/write mutex. Direct /dev/tpm<n> access needs an exclusive write
> lock, the resource broker continues to allow concurrent access *except*
> when /dev/tpm<n> is open.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>

I'm mostly thinking should be tag it as bug fix and backport or not.

> ---
> v2: Change error path label to err instead of out. Rework commit
>     message.
> 
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
> index c25df7ea064e..13322dd9ac9e 100644
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
> +		goto err;
>  
>  	rc = tpm2_init_space(&priv->space, TPM2_SPACE_BUFFER_SIZE);
>  	if (rc) {
>  		kfree(priv);
> -		return -ENOMEM;
> +		goto err;
>  	}
>  
>  	tpm_common_open(file, chip, &priv->priv, &priv->space);
>  
>  	return 0;
> +
> +err:
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

