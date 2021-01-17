Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B85B2F9467
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Jan 2021 19:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbhAQSMn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 Jan 2021 13:12:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbhAQSMm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Jan 2021 13:12:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DC69224D3;
        Sun, 17 Jan 2021 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610907121;
        bh=2vQvvvlsVb/nlFglh4UWS373hinBP3WdkcI9jdcWnZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b39hf5qcHwi1ASllSoshQBiatEYJFKjXsMPYBgjHdAVwc2PP9kX9o5IGp7ZTDW4lM
         jCVdOD0DNCvz4030/bsRO5k5y1CCAA3oEz5CiIEA1h4P5ylUB/1fQZQwNbD6lsY8qz
         q9Iwv5e0DculOPZeb9SF3/gkKAfVkXf7Rs4610dVsPctLR+CEZlV6jpDYhf459Uc6K
         IT1hKi/ZYZJtVNoW5LzgjnPmlx4cnbyQiCsPxK3P8ZF1ODZ0Qw+LLQqZ9iP++ooPNE
         KaEcaIu58G0y5EwMcV4CCyqJETqmSyEU2mCFfYAXSm75jBRF0DiBuAKIKA7K1U8vYF
         e1ZesAMrXZ8Cg==
Date:   Sun, 17 Jan 2021 20:11:56 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 2/4] tpm: fix reference counting for struct tpm_chip
Message-ID: <YAR97EMb47QM2ZkO@kernel.org>
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
 <1610760161-21982-3-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610760161-21982-3-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 16, 2021 at 02:22:39AM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Commit 8979b02aaf1d ("tpm: Fix reference count to main device") tried to
> fix a reference count issue which prevented the tpm_chip structure from
> being freed in case that no TPM2 was used. The fix was to only get an extra
> reference for chip->dev in case of TPM2 which is indicated by the
> TPM_CHIP_FLAG_TPM2 flag.
> Unfortunately this flag is never set, and thus the extra reference is not
> taken even in the TPM2 case. This results in a refcount underflow in case
> that the device file /dev/tpmrm* is used to write data after the tpm_chip
> has been unregistered (e.g if the /dev/tpmrm* file has been opened before
> and not yet closed at the time the chip was unregistered.)
> 
> Also the error path (label "out") in tpm_chip_alloc() results in such an
> underflow, since the dev reference is put twice (one time directly and the
> second time by the call of tpm_devs_release() due to the put of
> chip->devs).
> 
> Fix the described issues by taking the extra reference unconditionally and
> installing an additional resource management action handler which puts
> chip->devs. Releasing chip->devs eventually results in the call of
> tpm_devs_release() which then releases the extra reference to chip->dev.
> 
> Since we now actually take that extra reference, adjust users of
> tpm_chip_alloc() like VTPM proxy and FTPM tee to release it indirectly by
> putting the reference of chip->devs.
> 
> Fixes: 8979b02aaf1d ("tpm: Fix reference count to main device")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm-chip.c       | 11 +++++++++--
>  drivers/char/tpm/tpm_ftpm_tee.c   |  2 ++
>  drivers/char/tpm/tpm_vtpm_proxy.c |  1 +
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e242d2e..596824c 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -360,8 +360,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	 * while cdevs is in use.  The corresponding put
>  	 * is in the tpm_devs_release (TPM2 only)
>  	 */
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		get_device(&chip->dev);
> +	get_device(&chip->dev);
>  
>  	if (chip->dev_num == 0)
>  		chip->dev.devt = MKDEV(MISC_MAJOR, TPM_MINOR);
> @@ -425,12 +424,20 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  	if (rc)
>  		goto put_dev;
>  
> +	rc = devm_add_action_or_reset(pdev,
> +				      (void (*)(void *)) put_device,
> +				      &chip->devs);
> +	if (rc)
> +		goto put_devs;
> +
>  	dev_set_drvdata(pdev, chip);
>  
>  	return chip;
>  
>  put_dev:
>  	put_device(&chip->dev);
> +put_devs:
> +	put_device(&chip->devs);
>  	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_GPL(tpmm_chip_alloc);
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> index 2ccdf8a..82858c2 100644
> --- a/drivers/char/tpm/tpm_ftpm_tee.c
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -286,6 +286,7 @@ static int ftpm_tee_probe(struct device *dev)
>  
>  out_chip:
>  	put_device(&pvt_data->chip->dev);
> +	put_device(&pvt_data->chip->devs);
>  out_chip_alloc:
>  	tee_shm_free(pvt_data->shm);
>  out_shm_alloc:
> @@ -318,6 +319,7 @@ static int ftpm_tee_remove(struct device *dev)
>  	tpm_chip_unregister(pvt_data->chip);
>  
>  	/* frees chip */
> +	put_device(&pvt_data->chip->devs);
>  	put_device(&pvt_data->chip->dev);
>  
>  	/* Free the shared memory pool */
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 91c772e3..97b60f8 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -520,6 +520,7 @@ static struct proxy_dev *vtpm_proxy_create_proxy_dev(void)
>   */
>  static inline void vtpm_proxy_delete_proxy_dev(struct proxy_dev *proxy_dev)
>  {
> +	put_device(&proxy_dev->chip->devs);
>  	put_device(&proxy_dev->chip->dev); /* frees chip */
>  	kfree(proxy_dev);
>  }
> -- 
> 2.7.4
> 

NAK

/Jarkko
