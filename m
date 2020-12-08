Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536452D2972
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 12:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgLHLCs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 06:02:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:2613 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgLHLCs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 06:02:48 -0500
IronPort-SDR: 7tBnBGVNB0dLml9NaGfdr52bxCLHRwVWwceyY4r8v8lV5U7cRwZYRV4N3JU9hXTjnREHMc7Ni7
 PkA2iYOs1ulg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="235470139"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="235470139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 03:01:00 -0800
IronPort-SDR: wUbxcJyXvjaYncX++g7+Vw7du6mF5XsTpUxQyPCe3+F4Qc9O/rzf4/y+eGEi6oI94vYYNNRVJ1
 qE+TEZtFLx2w==
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="363591563"
Received: from lrohns-mobl1.ger.corp.intel.com (HELO linux.intel.com) ([10.252.33.185])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 03:00:56 -0800
Date:   Tue, 8 Dec 2020 13:00:51 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] tpm: Rework open/close/shutdown to avoid races
Message-ID: <20201208110051.GA18099@linux.intel.com>
References: <20201204101805.27374-1-s.temerkhanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204101805.27374-1-s.temerkhanov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 04, 2020 at 01:18:05PM +0300, Sergey Temerkhanov wrote:
> Avoid race condition at shutdown by shutting downn the TPM 2.0
> devices synchronously. This eliminates the condition when the
> shutdown sequence sets chip->ops to NULL leading to the following:
> 
> [ 1586.593561][ T8669] tpm2_del_space+0x28/0x73
> [ 1586.598718][ T8669] tpmrm_release+0x27/0x33wq
> [ 1586.603774][ T8669] __fput+0x109/0x1d
> [ 1586.608380][ T8669] task_work_run+0x7c/0x90
> [ 1586.613414][ T8669] prepare_exit_to_usermode+0xb8/0x128
> [ 1586.619522][ T8669] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1586.626068][ T8669] RIP: 0033:0x4cb4bb
> 
> Signed-off-by: Sergey Temerkhanov <s.temerkhanov@gmail.com>

bitops is an atomic API. I don't understand why you want to convert
to "atomic_t". You are also removing tpm_class_shutdown() without
any explanation. Finally, there is no bug report.

/Jarkko


> ---
>  drivers/char/tpm/tpm-chip.c  | 27 ---------------------------
>  drivers/char/tpm/tpm-dev.c   | 11 ++++++-----
>  drivers/char/tpm/tpmrm-dev.c |  7 +++++++
>  include/linux/tpm.h          |  2 +-
>  4 files changed, 14 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 1838039b0333..ede7f4790c5e 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -282,32 +282,6 @@ static void tpm_devs_release(struct device *dev)
>  	put_device(&chip->dev);
>  }
>  
> -/**
> - * tpm_class_shutdown() - prepare the TPM device for loss of power.
> - * @dev: device to which the chip is associated.
> - *
> - * Issues a TPM2_Shutdown command prior to loss of power, as required by the
> - * TPM 2.0 spec. Then, calls bus- and device- specific shutdown code.
> - *
> - * Return: always 0 (i.e. success)
> - */
> -static int tpm_class_shutdown(struct device *dev)
> -{
> -	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
> -
> -	down_write(&chip->ops_sem);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		if (!tpm_chip_start(chip)) {
> -			tpm2_shutdown(chip, TPM2_SU_CLEAR);
> -			tpm_chip_stop(chip);
> -		}
> -	}
> -	chip->ops = NULL;
> -	up_write(&chip->ops_sem);
> -
> -	return 0;
> -}
> -
>  /**
>   * tpm_chip_alloc() - allocate a new struct tpm_chip instance
>   * @pdev: device to which the chip is associated
> @@ -347,7 +321,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	device_initialize(&chip->devs);
>  
>  	chip->dev.class = tpm_class;
> -	chip->dev.class->shutdown_pre = tpm_class_shutdown;
>  	chip->dev.release = tpm_dev_release;
>  	chip->dev.parent = pdev;
>  	chip->dev.groups = chip->groups;
> diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
> index e2c0baa69fef..e04f3d47c64e 100644
> --- a/drivers/char/tpm/tpm-dev.c
> +++ b/drivers/char/tpm/tpm-dev.c
> @@ -23,9 +23,9 @@ static int tpm_open(struct inode *inode, struct file *file)
>  	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
>  
>  	/* It's assured that the chip will be opened just once,
> -	 * by the check of is_open variable, which is protected
> -	 * by driver_lock. */
> -	if (test_and_set_bit(0, &chip->is_open)) {
> +	 * by the check of is_open variable
> +	 */
> +	if (atomic_fetch_or(1, &chip->is_open)) {
>  		dev_dbg(&chip->dev, "Another process owns this TPM\n");
>  		return -EBUSY;
>  	}
> @@ -39,7 +39,7 @@ static int tpm_open(struct inode *inode, struct file *file)
>  	return 0;
>  
>   out:
> -	clear_bit(0, &chip->is_open);
> +	atomic_set(&chip->is_open, 0);
>  	return -ENOMEM;
>  }
>  
> @@ -49,9 +49,10 @@ static int tpm_open(struct inode *inode, struct file *file)
>  static int tpm_release(struct inode *inode, struct file *file)
>  {
>  	struct file_priv *priv = file->private_data;
> +	struct tpm_chip *chip = priv->chip;
>  
>  	tpm_common_release(file, priv);
> -	clear_bit(0, &priv->chip->is_open);
> +	atomic_set(&chip->is_open, 0);
>  	kfree(priv);
>  
>  	return 0;
> diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
> index eef0fb06ea83..ec83ca8105b8 100644
> --- a/drivers/char/tpm/tpmrm-dev.c
> +++ b/drivers/char/tpm/tpmrm-dev.c
> @@ -27,6 +27,8 @@ static int tpmrm_open(struct inode *inode, struct file *file)
>  		return -ENOMEM;
>  	}
>  
> +	atomic_inc(&chip->is_open);
> +
>  	tpm_common_open(file, chip, &priv->priv, &priv->space);
>  
>  	return 0;
> @@ -39,6 +41,11 @@ static int tpmrm_release(struct inode *inode, struct file *file)
>  
>  	tpm_common_release(file, fpriv);
>  	tpm2_del_space(fpriv->chip, &priv->space);
> +
> +	if (!atomic_dec_return(&fpriv->chip->is_open)) {
> +		tpm2_shutdown(fpriv->chip, TPM2_SU_CLEAR);
> +		tpm_chip_stop(fpriv->chip);
> +	}
>  	kfree(priv);
>  
>  	return 0;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 77fdc988c610..26e070198a15 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -126,7 +126,7 @@ struct tpm_chip {
>  	unsigned int flags;
>  
>  	int dev_num;		/* /dev/tpm# */
> -	unsigned long is_open;	/* only one allowed */
> +	atomic_t is_open;	/* only one allowed */
>  
>  	char hwrng_name[64];
>  	struct hwrng hwrng;
> -- 
> 2.25.1
> 

/Jarkko
