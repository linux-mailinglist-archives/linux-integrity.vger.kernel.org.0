Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89031E1F4
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Feb 2021 23:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhBQWTo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Feb 2021 17:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhBQWTn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Feb 2021 17:19:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A3A364E2E;
        Wed, 17 Feb 2021 22:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613600336;
        bh=R36+bIxLhYg5uGx9zGIf9dElz1HRmb2Ebj9z+LLFr9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtzXwoeqIC66ZhwW1glZg53tfP8ng/Zc3DtjXwFqn3zSEuj+Hf38+yiyVuSsFS5jf
         NGRO7+uQDGoICGutOTXAfDfaPYzCbo0jlXejEeqL76hvrvHujmjq5y/ZbHCNS/xJvr
         MzIiZYfUtVNw4kZC+JN3srTAa53w5LlT10tIwX8hsZhu21aGo6SOijxPe++qt75f79
         /IvjjaLzdBcnmscJsRb1616Dwslh/Kl1PvRCb1YOtQVADZbRX2dy5BJP2Bf5M3Q4UV
         d2gVpwxh2pISpTaS1S7HeABQpc2i7KsLh9dRb2DetdYCClJe4BCkWyOCfPfkEmWA52
         FIg/xse2kaJfg==
Date:   Thu, 18 Feb 2021 00:18:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, David.Laight@aculab.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND v5] tpm: fix reference counting for struct tpm_chip
Message-ID: <YC2WRJfNbY22yIOn@kernel.org>
References: <1613505191-4602-1-git-send-email-LinoSanfilippo@gmx.de>
 <1613505191-4602-2-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613505191-4602-2-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 16, 2021 at 08:53:11PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The following sequence of operations results in a refcount warning:
> 
> 1. Open device /dev/tpmrm.
> 2. Remove module tpm_tis_spi.
> 3. Write a TPM command to the file descriptor opened at step 1.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 1161 at lib/refcount.c:25 kobject_get+0xa0/0xa4
> refcount_t: addition on 0; use-after-free.
> Modules linked in: tpm_tis_spi tpm_tis_core tpm mdio_bcm_unimac brcmfmac
> sha256_generic libsha256 sha256_arm hci_uart btbcm bluetooth cfg80211 vc4
> brcmutil ecdh_generic ecc snd_soc_core crc32_arm_ce libaes
> raspberrypi_hwmon ac97_bus snd_pcm_dmaengine bcm2711_thermal snd_pcm
> snd_timer genet snd phy_generic soundcore [last unloaded: spi_bcm2835]
> CPU: 3 PID: 1161 Comm: hold_open Not tainted 5.10.0ls-main-dirty #2
> Hardware name: BCM2711
> [<c0410c3c>] (unwind_backtrace) from [<c040b580>] (show_stack+0x10/0x14)
> [<c040b580>] (show_stack) from [<c1092174>] (dump_stack+0xc4/0xd8)
> [<c1092174>] (dump_stack) from [<c0445a30>] (__warn+0x104/0x108)
> [<c0445a30>] (__warn) from [<c0445aa8>] (warn_slowpath_fmt+0x74/0xb8)
> [<c0445aa8>] (warn_slowpath_fmt) from [<c08435d0>] (kobject_get+0xa0/0xa4)
> [<c08435d0>] (kobject_get) from [<bf0a715c>] (tpm_try_get_ops+0x14/0x54 [tpm])
> [<bf0a715c>] (tpm_try_get_ops [tpm]) from [<bf0a7d6c>] (tpm_common_write+0x38/0x60 [tpm])
> [<bf0a7d6c>] (tpm_common_write [tpm]) from [<c05a7ac0>] (vfs_write+0xc4/0x3c0)
> [<c05a7ac0>] (vfs_write) from [<c05a7ee4>] (ksys_write+0x58/0xcc)
> [<c05a7ee4>] (ksys_write) from [<c04001a0>] (ret_fast_syscall+0x0/0x4c)
> Exception stack(0xc226bfa8 to 0xc226bff0)
> bfa0:                   00000000 000105b4 00000003 beafe664 00000014 00000000
> bfc0: 00000000 000105b4 000103f8 00000004 00000000 00000000 b6f9c000 beafe684
> bfe0: 0000006c beafe648 0001056c b6eb6944
> ---[ end trace d4b8409def9b8b1f ]---
> 
> The reason for this warning is the attempt to get the chip->dev reference
> in tpm_common_write() although the reference counter is already zero.
> 
> Since commit 8979b02aaf1d ("tpm: Fix reference count to main device") the
> extra reference used to prevent a premature zero counter is never taken,
> because the required TPM_CHIP_FLAG_TPM2 flag is never set.
> 
> Fix this by moving the TPM 2 character device handling from
> tpm_chip_alloc() to tpm_add_char_device() which is called at a later point
> in time when the flag has been set in case of TPM2.
> 
> Commit fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> already introduced function tpm_devs_release() to release the extra
> reference but did not implement the required put on chip->devs that results
> in the call of this function.
> 
> Fix this by putting chip->devs in tpm_chip_unregister().
> 
> Finally move the new implementation for the TPM 2 handling into a new
> function to avoid multiple checks for the TPM_CHIP_FLAG_TPM2 flag in the
> good case and error cases.
> 
> Cc: stable@vger.kernel.org
> Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> Fixes: 8979b02aaf1d ("tpm: Fix reference count to main device")
> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm-chip.c   | 48 +++++++++----------------------------------
>  drivers/char/tpm/tpm.h        |  1 +
>  drivers/char/tpm/tpm2-space.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb..a1fda0d 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -274,14 +274,6 @@ static void tpm_dev_release(struct device *dev)
>  	kfree(chip);
>  }
>  
> -static void tpm_devs_release(struct device *dev)
> -{
> -	struct tpm_chip *chip = container_of(dev, struct tpm_chip, devs);
> -
> -	/* release the master device reference */
> -	put_device(&chip->dev);
> -}
> -
>  /**
>   * tpm_class_shutdown() - prepare the TPM device for loss of power.
>   * @dev: device to which the chip is associated.
> @@ -344,7 +336,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	chip->dev_num = rc;
>  
>  	device_initialize(&chip->dev);
> -	device_initialize(&chip->devs);
>  
>  	chip->dev.class = tpm_class;
>  	chip->dev.class->shutdown_pre = tpm_class_shutdown;
> @@ -352,39 +343,20 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	chip->dev.parent = pdev;
>  	chip->dev.groups = chip->groups;
>  
> -	chip->devs.parent = pdev;
> -	chip->devs.class = tpmrm_class;
> -	chip->devs.release = tpm_devs_release;
> -	/* get extra reference on main device to hold on
> -	 * behalf of devs.  This holds the chip structure
> -	 * while cdevs is in use.  The corresponding put
> -	 * is in the tpm_devs_release (TPM2 only)
> -	 */
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -		get_device(&chip->dev);
> -
>  	if (chip->dev_num == 0)
>  		chip->dev.devt = MKDEV(MISC_MAJOR, TPM_MINOR);
>  	else
>  		chip->dev.devt = MKDEV(MAJOR(tpm_devt), chip->dev_num);
>  
> -	chip->devs.devt =
> -		MKDEV(MAJOR(tpm_devt), chip->dev_num + TPM_NUM_DEVICES);
> -
>  	rc = dev_set_name(&chip->dev, "tpm%d", chip->dev_num);
>  	if (rc)
>  		goto out;
> -	rc = dev_set_name(&chip->devs, "tpmrm%d", chip->dev_num);
> -	if (rc)
> -		goto out;
>  
>  	if (!pdev)
>  		chip->flags |= TPM_CHIP_FLAG_VIRTUAL;
>  
>  	cdev_init(&chip->cdev, &tpm_fops);
> -	cdev_init(&chip->cdevs, &tpmrm_fops);
>  	chip->cdev.owner = THIS_MODULE;
> -	chip->cdevs.owner = THIS_MODULE;
>  
>  	rc = tpm2_init_space(&chip->work_space, TPM2_SPACE_BUFFER_SIZE);
>  	if (rc) {
> @@ -396,7 +368,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	return chip;
>  
>  out:
> -	put_device(&chip->devs);
>  	put_device(&chip->dev);
>  	return ERR_PTR(rc);
>  }
> @@ -445,14 +416,9 @@ static int tpm_add_char_device(struct tpm_chip *chip)
>  	}
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		rc = cdev_device_add(&chip->cdevs, &chip->devs);
> -		if (rc) {
> -			dev_err(&chip->devs,
> -				"unable to cdev_device_add() %s, major %d, minor %d, err=%d\n",
> -				dev_name(&chip->devs), MAJOR(chip->devs.devt),
> -				MINOR(chip->devs.devt), rc);
> -			return rc;
> -		}
> +		rc = tpm2_add_device(chip);
> +		if (rc)
> +			goto del_cdev;
>  	}
>  
>  	/* Make the chip available. */
> @@ -460,6 +426,10 @@ static int tpm_add_char_device(struct tpm_chip *chip)
>  	idr_replace(&dev_nums_idr, chip, chip->dev_num);
>  	mutex_unlock(&idr_lock);
>  
> +	return 0;
> +
> +del_cdev:
> +	cdev_device_del(&chip->cdev, &chip->dev);
>  	return rc;
>  }
>  
> @@ -640,8 +610,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		cdev_device_del(&chip->cdevs, &chip->devs);
> +		put_device(&chip->devs);
> +	}
>  	tpm_del_char_device(chip);
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_unregister);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db..aa93af5 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -238,6 +238,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
>  		       size_t cmdsiz);
>  int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
>  		      size_t *bufsiz);
> +int tpm2_add_device(struct tpm_chip *chip);
>  
>  void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 784b8b3..96b2a4b 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -571,3 +571,51 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
>  	dev_err(&chip->dev, "%s: error %d\n", __func__, rc);
>  	return rc;
>  }
> +
> +static void tpm_devs_release(struct device *dev)
> +{
> +	struct tpm_chip *chip = container_of(dev, struct tpm_chip, devs);
> +
> +	/* release the master device reference */
> +	put_device(&chip->dev);
> +}
> +

/*
 * Please describe what the heck the function does. No need for full on
 * kdoc.
 */
> +int tpm2_add_device(struct tpm_chip *chip)

Please, rename as tpm_devs_add for coherency sake.

> +{
> +	int rc;
> +
> +	device_initialize(&chip->devs);
> +	chip->devs.parent = chip->dev.parent;
> +	chip->devs.class = tpmrm_class;

Empty line. Cannot recall, if I stated before.
> +	/* +	 * get extra reference on main device to hold on behalf of devs.
> +	 * This holds the chip structure while cdevs is in use. The
> +	 * corresponding put is in the tpm_devs_release.
> +	 */
> +	get_device(&chip->dev);
> +	chip->devs.release = tpm_devs_release;
> +	chip->devs.devt = MKDEV(MAJOR(tpm_devt),
> +					chip->dev_num + TPM_NUM_DEVICES);

NAK, same comment as before.

> +	cdev_init(&chip->cdevs, &tpmrm_fops);
> +	chip->cdevs.owner = THIS_MODULE;
> +
> +	rc = dev_set_name(&chip->devs, "tpmrm%d", chip->dev_num);
> +	if (rc)
> +		goto out_put_devs;
> +
> +	rc = cdev_device_add(&chip->cdevs, &chip->devs);
> +	if (rc) {
> +		dev_err(&chip->devs,
> +			"unable to cdev_device_add() %s, major %d, minor %d, err=%d\n",
> +			dev_name(&chip->devs), MAJOR(chip->devs.devt),
> +			MINOR(chip->devs.devt), rc);
> +		goto out_put_devs;
> +	}
> +
> +	return 0;
> +
> +out_put_devs:
> +	put_device(&chip->devs);
> +
> +	return rc;
> +}
> -- 
> 2.7.4
> 

/Jarkko
