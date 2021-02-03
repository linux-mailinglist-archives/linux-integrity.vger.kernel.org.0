Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A448630D0C9
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 02:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBCB3e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 20:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhBCB3b (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 20:29:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04ABF64F4C;
        Wed,  3 Feb 2021 01:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612315730;
        bh=n/k8xGF6YjG7foOcHD5rJG7qc0kZXb2dYJ70lCaKG50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCZXegLWZazwiuvYKZatUZAWLDIdj5t/yc4Q/d9YvkaqcMxRwYHTnqa5upRZyqOkI
         sjTdv4A2KkcaqalmJjLyGj0UNuhCeQ+Mk3lvAsotakn6KKIVfJgVcIe7DVDza1O4gI
         T4HOSPH7PCJVK1yPTrdHhfz+cageosJDRNtDCCNJ4M8T/QNfnYKt5slYy9xtqTVljf
         cW11JOBisZFlMT/xehM7Ps+sGN2hnTXkMlr4xyhBsK9VvL5BS/trYSDsyNk+XyTxxV
         qXXIlWk5YBAZ8R79W+4LbRfnyOs+1dJbyc8+WZ+4ID1tVpD6DD+Lkqg2qRVliLKVUw
         PME072/99vKGw==
Date:   Wed, 3 Feb 2021 03:28:43 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v2 2/3] tpm: Provide a function tpm_chip_free() to free
 tpm chips
Message-ID: <YBn8S8rY2wvv9A8A@kernel.org>
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612303743-29017-3-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612303743-29017-3-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 11:09:02PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Provide a function tpm_chip_free() as a counterpart to tpm_chip_alloc().
> The function hides the internals of freeing a struct tpm_chip instance
> by putting the device references which are part of this structure.
> 
> Use the new function at the appropriate places.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

I prefer open coding here.

/Jarkko

> ---
>  drivers/char/tpm/tpm-chip.c       | 16 ++++++++++++++++
>  drivers/char/tpm/tpm.h            |  1 +
>  drivers/char/tpm/tpm_ftpm_tee.c   |  6 ++----
>  drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
>  4 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 3ace199..777baae 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -402,6 +402,22 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  EXPORT_SYMBOL_GPL(tpm_chip_alloc);
>  
>  /**
> + * tpm_chip_free() - free an instance of struct tpm_chip that has been
> + * allocated with tpm_chip_alloc() before.
> + * @chip: chip to free
> + *
> + * Frees an instance of struct tpm_chip by releasing internal device references.
> + * This function is used to hide the internals needed to free a struct tpm_chip
> + * instance thas has been allocated with tpm_chip_alloc() before.
> + */
> +void tpm_chip_free(struct tpm_chip *chip)
> +{
> +	put_device(&chip->devs);
> +	put_device(&chip->dev);
> +}
> +EXPORT_SYMBOL_GPL(tpm_chip_free);
> +
> +/**
>   * tpmm_chip_alloc() - allocate a new struct tpm_chip instance
>   * @pdev: parent device to which the chip is associated
>   * @ops: struct tpm_class_ops instance
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db..e6bb6ae 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -199,6 +199,7 @@ void tpm_put_ops(struct tpm_chip *chip);
>  
>  struct tpm_chip *tpm_chip_alloc(struct device *dev,
>  				const struct tpm_class_ops *ops);
> +void tpm_chip_free(struct tpm_chip *chip);
>  struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  				 const struct tpm_class_ops *ops);
>  int tpm_chip_register(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 82858c2..47ffaae 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -285,8 +285,7 @@ static int ftpm_tee_probe(struct device *dev)
>  	return 0;
>  
>  out_chip:
> -	put_device(&pvt_data->chip->dev);
> -	put_device(&pvt_data->chip->devs);
> +	tpm_chip_free(chip);
>  out_chip_alloc:
>  	tee_shm_free(pvt_data->shm);
>  out_shm_alloc:
> @@ -319,8 +318,7 @@ static int ftpm_tee_remove(struct device *dev)
>  	tpm_chip_unregister(pvt_data->chip);
>  
>  	/* frees chip */
> -	put_device(&pvt_data->chip->devs);
> -	put_device(&pvt_data->chip->dev);
> +	tpm_chip_free(pvt_data->chip);
>  
>  	/* Free the shared memory pool */
>  	tee_shm_free(pvt_data->shm);
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 97b60f8..f887bb3 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -520,8 +520,7 @@ static struct proxy_dev *vtpm_proxy_create_proxy_dev(void)
>   */
>  static inline void vtpm_proxy_delete_proxy_dev(struct proxy_dev *proxy_dev)
>  {
> -	put_device(&proxy_dev->chip->devs);
> -	put_device(&proxy_dev->chip->dev); /* frees chip */
> +	tpm_chip_free(proxy_dev->chip);
>  	kfree(proxy_dev);
>  }
>  
> -- 
> 2.7.4
> 
