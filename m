Return-Path: <linux-integrity+bounces-7049-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63606B51E8A
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958581C8727E
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13928A73F;
	Wed, 10 Sep 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSj6NG1f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2A199BC;
	Wed, 10 Sep 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524003; cv=none; b=tTcsWtuCFm035tABz69Ejw/pBJjHZji3Vo4acTufc13rgDhpyKgFJ5/K+nuH6NPLyVesBQVzbs/h9VDzNFOIc3620kkwAU+D8uVM52+jtQ0z3IF15YYTHUdTJK9gyRB5/BJ3z0PHEpXqy95+0UvZSqaGjbV17mQ2A+Slq8HrTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524003; c=relaxed/simple;
	bh=EmUAw9Ks8dlPjJt/KtW3b6vR5sZRMZTlMch3sN9sarI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK8dlsWrF9K1ErJxVUjTLLP0KuM+Js3D5myNow5F4gcqMUe+JwpCCo0AcGlGPFZAA0UaFaH+ALm7QRBQy6vMHUIzcJM0zEZoc8GA6yjYwBydtjZiMwJ5O+6PEVqFS8vMk7FMnBwmtev2ZPKp+yh0Xh6a224LJh9/G9SKuhj8KYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSj6NG1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0602AC4CEEB;
	Wed, 10 Sep 2025 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757524003;
	bh=EmUAw9Ks8dlPjJt/KtW3b6vR5sZRMZTlMch3sN9sarI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSj6NG1fJoBrcwWAVBQWDdvE24RjFpDrA/pGavijp37CeRDcUadYmsjhiAapw/n8F
	 nLygviE4eNrC9OATvmHnM25I2AbAnduaPg9Frac+jqcXOTIgLtMb+zz64SST5S0FjF
	 mwOZibWiC69ws1gL2eNu7vK+bVVVaLh7aymFYSXOvn9mFyksZPzeQUwFEL6uEZuGPy
	 6onydqMhf/DVOpvIuHBHBym1775Nmi6A0h60RjcRXs+O6df/PsFixIr8CVXT5L6Ffi
	 0iIykpkbzcJYhVOI8i/XWNdSiEeCKNMT6LdrkUaQwGeArR8Jryj35UOhs+7SNn3paZ
	 gv/15YNQSDIgQ==
Date: Wed, 10 Sep 2025 20:06:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] tpm: Require O_EXCL for exclusive /dev/tpm access
Message-ID: <aMGwH3zYX0pWe-hg@kernel.org>
References: <cover.1756833527.git.noodles@meta.com>
 <aad903683a912d6e36904c2d4ad1230a224e0780.1756833527.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad903683a912d6e36904c2d4ad1230a224e0780.1756833527.git.noodles@meta.com>

On Tue, Sep 02, 2025 at 06:27:17PM +0100, Jonathan McDowell wrote:
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

I'll hold with testing to +1 version but overall patch set looks good.

BR, Jarkko

