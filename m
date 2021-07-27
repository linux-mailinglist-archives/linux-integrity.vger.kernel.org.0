Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADACB3D6C12
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhG0CGS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhG0CGS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:06:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E91B660FED;
        Tue, 27 Jul 2021 02:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627354006;
        bh=ZYpmbDsF6ia/xddzAjXQxYzKxGnOM1FJzTaQfUlC9dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Up8SE7vVoFEBSESjrUYpVwjXHYPfIUwEMSTaWjQ8Rt89tNXTnsuytdRKRS3HApf6b
         UvZ9h43DaCIJHuAcEOiapLhdpr71eD4RFXWx8JXDzWNzEjHKzZ8wSPTCtOdAOzotc5
         xqoY2WhKiBKMpo1k0pvvOgl4nXCpcNxLXizY8oRUFUo+Kye/mDK5sKnfgGERxVTBnN
         1/gDr8HPKv4CLc9IFvGNdZC0MKzAyql0zdP1AX+5Vh+oE+czdCZlwvOepSy7p0QPoY
         8eCxKoEqGE/ZL4Nyh351R1mK4zkQsOiWcyszWhUGokeM0IbF1j0h7nL32Bqc8eF69l
         BsKjL6fff3HgQ==
Date:   Tue, 27 Jul 2021 05:46:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     shrihari.kalkar@rubrik.com, seungyeop.han@rubrik.com,
        anish.jhaveri@rubrik.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
        kgold@linux.ibm.com, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, hamza@hpe.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, nayna@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v3] tpm: fix Atmel TPM crash caused by too frequent
 queries
Message-ID: <20210727024644.frkuo4a6ssyz6uhc@kernel.org>
References: <20210709044028.77278-1-hao.wu@rubrik.com>
 <20210711075122.30056-1-hao.wu@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711075122.30056-1-hao.wu@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jul 11, 2021 at 12:51:22AM -0700, Hao Wu wrote:
> The Atmel TPM 1.2 chips crash with error
> `tpm_try_transmit: send(): error -62` since kernel 4.14.
> It is observed from the kernel log after running `tpm_sealdata -z`.
> The error thrown from the command is as follows
> ```
> $ tpm_sealdata -z
> Tspi_Key_LoadKey failed: 0x00001087 - layer=tddl,
> code=0087 (135), I/O error
> ```
> 
> The issue was reproduced with the following Atmel TPM chip:
> ```
> $ tpm_version
> T0  TPM 1.2 Version Info:
>   Chip Version:        1.2.66.1
>   Spec Level:          2
>   Errata Revision:     3
>   TPM Vendor ID:       ATML
>   TPM Version:         01010000
>   Manufacturer Info:   41544d4c
> ```
> 
> The root cause of the issue is due to the TPM calls to msleep()
> were replaced with usleep_range() [1], which reduces
> the actual timeout. Via experiments, it is observed that
> the original msleep(5) actually sleeps for 15ms.
> Because of a known timeout issue in Atmel TPM 1.2 chip,
> the shorter timeout than 15ms can cause the error described above.
> 
> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
> reduced the timeout to less than 1ms. With experiments,
> the problematic timeout in the latest kernel is the one
> for `wait_for_tpm_stat`.
> 
> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
> for Ateml TPM 2.0 chip, and chips from other vendors.
> As explained above, the chosen 15ms timeout is
> the actual timeout before this issue introduced,
> thus the old value is used here.
> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
> the existing TPM_TIMEOUT_RANGE_US (300us).
> The fixed has been tested in the system with the affected Atmel chip
> with no issues observed after boot up.
> 
> References:
> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
> 1.2/2.0 generic drivers
> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
> granularity
> 
> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
> Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> ---
> This version (v3) removes unnecessary condition check
> in `wait_for_tpm_stat`.

Missing change long v1 -> v2.

Please do something like

v3:
- ...

v2:
- ...

> 
> Test Plan:
> - Run fixed kernel with ATMEL TPM chips and see crash
> has been fixed.
> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> the timeout has not been changed.
> 
> drivers/char/tpm/tpm.h          |  6 ++++--
>  drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++--
>  include/linux/tpm.h             |  3 +++
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 283f78211c3a..6de1b44c4aab 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -41,8 +41,10 @@ enum tpm_timeout {
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
>  	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
>  	TPM_TIMEOUT_POLL = 1,	/* msecs */
> -	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> -	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
> +	TPM_TIMEOUT_USECS_MIN = 100,	/* usecs */
> +	TPM_TIMEOUT_USECS_MAX = 500,	/* usecs */

What is going on here?

These lines should not change.

> +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN = 14700,	/* usecs */
> +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX = 15000	/* usecs */

Move these definitions to tpm_tis_core.h. They are only useful
for a single driver.


>  };
>  
>  /* TPM addresses */
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 55b9d3965ae1..2de1f71e8ae1 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -80,8 +80,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		}
>  	} else {
>  		do {
> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> -				     TPM_TIMEOUT_USECS_MAX);
> +			usleep_range(chip->timeout_wait_stat_min,
> +				     chip->timeout_wait_stat_max);
>  			status = chip->ops->status(chip);
>  			if ((status & mask) == mask)
>  				return 0;
> @@ -934,6 +934,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>  	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>  	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	/* init timeouts for wait_for_tpm_stat */

Remove this comment.

> +	chip->timeout_wait_stat_min = TPM_TIMEOUT_USECS_MIN;
> +	chip->timeout_wait_stat_max = TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops = phy_ops;
>  	dev_set_drvdata(&chip->dev, priv);
>  
> @@ -983,6 +986,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  
>  	priv->manufacturer_id = vendor;
>  
> +	if (priv->manufacturer_id == TPM_VID_ATML &&
> +		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> +		/* If TPM chip is 1.2 ATMEL chip, timeout need to be relaxed*/
> +		chip->timeout_wait_stat_min = TPM_ATML_TIMEOUT_WAIT_STAT_MIN;
> +		chip->timeout_wait_stat_max = TPM_ATML_TIMEOUT_WAIT_STAT_MAX;
> +	}
> +
>  	rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
>  	if (rc < 0)
>  		goto out_err;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index aa11fe323c56..171b9102c976 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -150,6 +150,8 @@ struct tpm_chip {
>  	bool timeout_adjusted;
>  	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
>  	bool duration_adjusted;
> +	unsigned int timeout_wait_stat_min; /* usecs */
> +	unsigned int timeout_wait_stat_max; /* usecs */
>  
>  	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>  
> @@ -269,6 +271,7 @@ enum tpm2_cc_attrs {
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
