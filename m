Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D53B1B3D
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jun 2021 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhFWNhi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Jun 2021 09:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhFWNhi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jun 2021 09:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328A961075;
        Wed, 23 Jun 2021 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624455320;
        bh=cWGflcAnJWvdc4QH8AEbyuoShGTRkNWNUXa3p3os9ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRO1j4lGoHPYXAp3+uQkEmuZE2jnkj4G4M/1o9WM2I6SlntWQ07/ulD4/yL7mCw5O
         yQgIvbW/G3T9ZAt+ETxOPENB8cNMjDzzTYy0PZB50gQJ9oJHmZ5g/WcUoZZkwTirUy
         cny/iDtBaSLpAitImUtraV+bjJHTHOhCD3yAE9WbVrP4ZBvPriDWcDbIXFp8Sj7GA/
         zN61YNguYdISYd3UMUaTGay1UR9PdaP7hHnhpiFvSgvjRsv6bByeUVfewTK8Up9FEl
         79ApLXKHLIehhCBVaz5g4UnayIjUkBUvDl5kaHdHkK47xZs8YV2vDytyYmZYpOQRFY
         vEgBvev3thq2w==
Date:   Wed, 23 Jun 2021 16:35:18 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     shrihari.kalkar@rubrik.com, seungyeop.han@rubrik.com,
        anish.jhaveri@rubrik.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20210623133518.5vykitqsdwtfqzd6@kernel.org>
References: <20210620231809.21101-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210620231809.21101-1-hao.wu@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jun 20, 2021 at 04:18:09PM -0700, Hao Wu wrote:
> This is a fix for the ATMEL TPM crash bug reported in
> https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> 
> According to the discussions in the original thread,
> we don't want to revert the timeout of wait_for_tpm_stat
> for non-ATMEL chips, which brings back the performance cost.
> For investigation and analysis of why wait_for_tpm_stat
> caused the issue, and how the regression was introduced,
> please read the original thread above.
> 
> Thus the proposed fix here is to only revert the timeout
> for ATMEL chips by checking the vendor ID.
> 
> Test Plan:
> - Run fixed kernel with ATMEL TPM chips and see crash
>   has been fixed.
> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>   the timeout has not been changed.

Please move test plan right before diffstat if you wan to include such,
so that it does not go into the commit log.


> ---
>  drivers/char/tpm/tpm.h          |  9 ++++++++-
>  drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
>  include/linux/tpm.h             |  2 ++
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 283f78211c3a..bc6aa7f9e119 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -42,7 +42,9 @@ enum tpm_timeout {
>  	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
>  	TPM_TIMEOUT_POLL = 1,	/* msecs */
>  	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> -	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
> +	TPM_TIMEOUT_USECS_MAX = 500,	/* usecs */
> +	TPM_TIMEOUT_WAIT_STAT = 500,	/* usecs */
> +	TPM_ATML_TIMEOUT_WAIT_STAT = 15000	/* usecs */
>  };
>  
>  /* TPM addresses */
> @@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned int delay_msec)
>  		     delay_msec * 1000);
>  };
>  
> +static inline void tpm_usleep(unsigned int delay_usec)
> +{
> +	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, delay_usec);
> +};
> +
>  int tpm_chip_start(struct tpm_chip *chip);
>  void tpm_chip_stop(struct tpm_chip *chip);
>  struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 55b9d3965ae1..9ddd4edfe1c2 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		}
>  	} else {
>  		do {
> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> -				     TPM_TIMEOUT_USECS_MAX);
> +			if (chip->timeout_wait_stat && 
> +				chip->timeout_wait_stat >= TPM_TIMEOUT_WAIT_STAT) {
> +				tpm_usleep((unsigned int)(chip->timeout_wait_stat));
> +			} else {
> +				tpm_usleep((unsigned int)(TPM_TIMEOUT_WAIT_STAT));
> +			}
>  			status = chip->ops->status(chip);
>  			if ((status & mask) == mask)
>  				return 0;
> @@ -934,6 +938,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>  	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>  	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	/* init timeout for wait_for_tpm_stat */
> +	chip->timeout_wait_stat = TPM_TIMEOUT_WAIT_STAT;
>  	priv->phy_ops = phy_ops;
>  	dev_set_drvdata(&chip->dev, priv);
>  
> @@ -983,6 +989,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  
>  	priv->manufacturer_id = vendor;
>  
> +	switch (priv->manufacturer_id) {
> +	case TPM_VID_ATML:
> +        /* ATMEL chip needs longer timeout to avoid crash */
> +		chip->timeout_wait_stat = TPM_ATML_TIMEOUT_WAIT_STAT;
> +		break;
> +	default:
> +		chip->timeout_wait_stat = TPM_TIMEOUT_WAIT_STAT;
> +	}
> +
>  	rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
>  	if (rc < 0)
>  		goto out_err;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index aa11fe323c56..35f2a0260d76 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -150,6 +150,7 @@ struct tpm_chip {
>  	bool timeout_adjusted;
>  	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
>  	bool duration_adjusted;
> +	unsigned long timeout_wait_stat; /* usecs */
>  
>  	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>  
> @@ -269,6 +270,7 @@ enum tpm2_cc_attrs {
>  #define TPM_VID_INTEL    0x8086
>  #define TPM_VID_WINBOND  0x1050
>  #define TPM_VID_STM      0x104A
> +#define TPM_VID_ATML     0x1114
>  
>  enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_TPM2		= BIT(1),
> -- 
> 2.29.0.vfs.0.0
> 
> 

/Jarkko
