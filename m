Return-Path: <linux-integrity+bounces-7258-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779DEB97FF7
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 03:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996C11AE09F5
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B31DA60F;
	Wed, 24 Sep 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVrUYCWd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D56F305;
	Wed, 24 Sep 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758677030; cv=none; b=W3f/9t8aJxrKgbJdYUXadpN2qFkJvJFOHz9uT3t1BRbRq7uVNWQbu9AB2zrh3J2P3FKtSDqhY0bMssgkzGTrfS3RvpjUPtxZ6LOylP0ju05i2dPBnBwuiDcLzRnq39XOH7IHZtb9+QyFbVKSHnjiNymUcn+D3PbUEw4uns8MEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758677030; c=relaxed/simple;
	bh=2fqqjd+Rchrm9DPV7cf+RbmXNcv1N1kzNehE1I4JENc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCedf/BAjtaZWWbmZDgoeOCltDB6mlH24y8SkZcRBUaCob/KvQnS7tatVOlYKw+drP/x90kTJpFSR0r86pJl4gZdLDHHSr9IWvqEEqbw5tIYylU9KKiupk6oy17R13UBL+e73b94C9b6KRZJrBh82KvV7SC/NirEOibAg5CPVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVrUYCWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E7EC113D0;
	Wed, 24 Sep 2025 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758677029;
	bh=2fqqjd+Rchrm9DPV7cf+RbmXNcv1N1kzNehE1I4JENc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVrUYCWdN/u/RRa3ng1+YzBwFtOQJLHoHLXOv7my5v3ozuQU3cuQEb8PIh5O9Y/6e
	 U5d8Y6lZ8dGCbempPHQFFTL611q6Ugj5na8SYON7Q/k0RRr5fHGsII5tSbATWOnGJ5
	 +mcdD1EBPA33L9Qs6tb8UNGZsGh5QCC5lcVpH15o7UvzImBZO8pfW52SoDxfSwnH34
	 tdQ3rYGHIVaTeb9lyyQerCU5dfiKXq2CzzaPpVSupGy8H5TlgaUWph5quQxD6obHiT
	 ewz1lWIU2dP5P+UVWD+RRWh/B/sYGd6JXJaF2WdqHK7EezZUV+b5XXxYJQaESWp/3E
	 RRYuaKjx5sZhw==
Date: Wed, 24 Sep 2025 04:23:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] tpm: Require O_EXCL for exclusive /dev/tpm access
Message-ID: <aNNIIlZCQe8oocta@kernel.org>
References: <cover.1758646791.git.noodles@meta.com>
 <83a323d597819d928da45b5b3914b37375c67869.1758646791.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a323d597819d928da45b5b3914b37375c67869.1758646791.git.noodles@meta.com>

On Tue, Sep 23, 2025 at 06:10:28PM +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
> 
> Given that /dev/tpm has not had exclusive access to the TPM since the
> existence of the kernel resource broker and other internal users, stop
> defaulted to exclusive access to the first client that opens the device.
> Continue to support exclusive access, but only with the use of the
> O_EXCL flag on device open.
> 
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
>  drivers/char/tpm/tpm-dev.c | 25 +++++++++++++++++++------
>  drivers/char/tpm/tpm-dev.h |  1 +
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
> index 80c4b3f3ad18..8921bbb541c1 100644
> --- a/drivers/char/tpm/tpm-dev.c
> +++ b/drivers/char/tpm/tpm-dev.c
> @@ -19,15 +19,21 @@ static int tpm_open(struct inode *inode, struct file *file)
>  {
>  	struct tpm_chip *chip;
>  	struct file_priv *priv;
> +	int rc;
>  
>  	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
>  
>  	/*
> -	 * Only one client is allowed to have /dev/tpm0 open at a time, so we
> -	 * treat it as a write lock. The shared /dev/tpmrm0 is treated as a
> -	 * read lock.
> +	 * If a client uses the O_EXCL flag then it expects to be the only TPM
> +	 * user, so we treat it as a write lock. Otherwise we do as /dev/tpmrm
> +	 * and use a read lock.
>  	 */
> -	if (!down_write_trylock(&chip->open_lock)) {
> +	if (file->f_flags & O_EXCL)
> +		rc = down_write_trylock(&chip->open_lock);
> +	else
> +		rc = down_read_trylock(&chip->open_lock);
> +
> +	if (!rc) {
>  		dev_dbg(&chip->dev, "Another process owns this TPM\n");
>  		return -EBUSY;
>  	}
> @@ -35,13 +41,17 @@ static int tpm_open(struct inode *inode, struct file *file)
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (priv == NULL)
>  		goto out;
> +	priv->exclusive = (file->f_flags & O_EXCL);
>  
>  	tpm_common_open(file, chip, priv, NULL);
>  
>  	return 0;
>  
>   out:
> -	up_write(&chip->open_lock);
> +	if (file->f_flags & O_EXCL)
> +		up_write(&chip->open_lock);
> +	else
> +		up_read(&chip->open_lock);
>  	return -ENOMEM;
>  }
>  
> @@ -53,7 +63,10 @@ static int tpm_release(struct inode *inode, struct file *file)
>  	struct file_priv *priv = file->private_data;
>  
>  	tpm_common_release(file, priv);
> -	up_write(&priv->chip->open_lock);
> +	if (priv->exclusive)
> +		up_write(&priv->chip->open_lock);
> +	else
> +		up_read(&priv->chip->open_lock);
>  	kfree(priv);
>  
>  	return 0;
> diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
> index f3742bcc73e3..0ad8504c73e4 100644
> --- a/drivers/char/tpm/tpm-dev.h
> +++ b/drivers/char/tpm/tpm-dev.h
> @@ -17,6 +17,7 @@ struct file_priv {
>  	ssize_t response_length;
>  	bool response_read;
>  	bool command_enqueued;
> +	bool exclusive;
>  
>  	u8 data_buffer[TPM_BUFSIZE];
>  };
> -- 
> 2.51.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

