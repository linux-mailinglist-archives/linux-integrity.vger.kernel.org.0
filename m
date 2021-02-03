Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884A330D0A1
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 02:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBCBJv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 20:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhBCBJu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 20:09:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F09F664F59;
        Wed,  3 Feb 2021 01:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612314548;
        bh=HOgKBBbXaavpK1QmCgpeqtlhU/D1f5hiJDLNDTcIzno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OM7nlRPP39RoXe0gXaU2XzqknPFJqkgGsOls6H2PXiS0QesK/SSN+tSRSGPp/bTV7
         A4REv8iO0RHBvVJ76zmq1/t6PE/xTYOAJepSjn7DjjIgB4E/NgcqQY1yPcUyZxCWVE
         g2bOnk7osRGkV0sY8Iu9c0r5jQAYdQhmvGNrHZCyIPfxNFLD+Im6Z6UmlDeEYx3cCL
         iKAhAXqsjovxlOE1YpHUix8iBQs/j4UL3QiE1BD6ZFbfyD60F3b+pXXlmBAiMTzVGF
         QxZ/hPuAIjAOHTz/gF8FP/35ShGRvEx0Hg+wZXypCLqzF0D/1YhiXG6ROO+DlCfHx3
         ufOzfr69A3yfA==
Date:   Wed, 3 Feb 2021 03:09:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 1/3] tpm: fix reference counting for struct tpm_chip
Message-ID: <YBn3rdErdKNAUdgZ@kernel.org>
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612303743-29017-2-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612303743-29017-2-git-send-email-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 11:09:01PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The following sequence of operations
> 
> 1. open device /dev/tpmrm
> 2. remove the registered tpm chip driver

What is "tpm chip driver"? Please just refer to the exact thing
(e.g. tpm_tis_spi is the one you should refer to in your case).

> 3. perform a write() to /dev/tpmrm

Just a nit: Use capital letter as the first letter in sentences.

If I do "rmmod tpm_tis" the device is gone.

> results in a refcount warning:
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

I guess this is happening with tpm_tis_spi. Unfortunately I don't have
anything available that would use it.

I did testing with tpm_tis but so far no success reproducing.

> 
> The reason is an attempt to get the chip->dev reference (see
> tpm_try_get_ops()) although the last reference to this device has already
> been released with the unregistration of the chip driver.
> 
> As far as I understand, the history of this bug is as follows:

Generally you don't write in person to a commit message. This not an
email in that sense. You should write in imperative form.

> Commit fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> introduced the support for /dev/tpmrm. Beside the new device chip->devs
> this code introduced the taking of an extra reference to chip->dev to
> ensure that this device is not released as long as /dev/tpmrm is still in
> use:
> 
> +       chip->devs.release = tpm_devs_release;
> +       /* get extra reference on main device to hold on
> +        * behalf of devs.  This holds the chip structure
> +        * while cdevs is in use.  The corresponding put
> +        * is in the tpm_devs_release
> +        */


Copy pasting this is probably unnecessary.

> The extra reference to chip->dev was supposed to be released as soon as the
> reference to chip->devs was freed:
> 
> +static void tpm_devs_release(struct device *dev)
> +{
> +       struct tpm_chip *chip = container_of(dev, struct tpm_chip, devs);
> +
> +       /* release the master device reference */
> +       put_device(&chip->dev);
> +}

OK, what you really should explain in the commit message is:

1. Why this function *is not* called.
2. What your fix does to make things better.



> However the code did not work as expected, because the reference to
> chip->devs was never released. Thus tpm_devs_release() was never called
> which in turn also prevented the extra reference to chip->dev from being
> released.

If it did not work, it works now :-) So any fix would not be required.
Just making a point here.

> This led to behaviour which commit 8979b02aaf1d ("tpm: Fix reference count
> to main device") tried to fix as an excerpt of the commit message shows:
> 
> "The main device is currently not properly released due to one additional
>  reference to the 'devs' device which is only released in case of a TPM 2.
>  So, also get the additional reference only in case of a TPM2."
> 
> Instead of adding the missing put for chip->devs, this patch chose another
> approach by only taking the reference in case of TPM2:
> 
> +       if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +               get_device(&chip->dev);
> 
> This fixed the non-TPM2 case but left the TPM2 case without the required
> extra reference, since there is no code path that ever sets the flag
> TPM_CHIP_FLAG_TPM2, which is the situation we have todoay.

You should not need this explanation to explain refcount mismatch. Also
past tense should not be used.

I appreciate the time taken to write all this but you should just explain
what you do and why. Let's just say this explanation is very obfuscted and
hard to follow.

> To fix this
> 
> 1. revert commit 8979b02aaf1d ("tpm: Fix reference count to main device")
> to make sure the extra reference is taken unconditionally as proposed by
> commit fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> 2. fix commit fdc915f7f719 ("tpm: expose spaces via a device link
>
>  /dev/tpmrm<n>") by adding an action handler to do the missing put to
> chip->devs. This eventually results in the call of function
> tpm_devs_release() which in turn performs the final put to the extra
> reference to chip->dev.
> 
> Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> Fixes: 8979b02aaf1d ("tpm: Fix reference count to main device")

If the fix makes sense a Cc stable is also required.

> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm-chip.c       | 18 +++++++++++++++---
>  drivers/char/tpm/tpm_ftpm_tee.c   |  2 ++
>  drivers/char/tpm/tpm_vtpm_proxy.c |  1 +
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb..3ace199 100644
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
> @@ -422,8 +421,21 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  	rc = devm_add_action_or_reset(pdev,
>  				      (void (*)(void *)) put_device,
>  				      &chip->dev);
> -	if (rc)
> +	if (rc) {
> +		put_device(&chip->devs);
>  		return ERR_PTR(rc);
> +	}
> +
> +	rc = devm_add_action_or_reset(pdev,
> +				      (void (*)(void *)) put_device,
> +				      &chip->devs);
> +	if (rc) {
> +		devm_remove_action(pdev,
> +				   (void (*)(void *)) put_device,
> +				   &chip->dev);
> +		put_device(&chip->dev);
> +		return ERR_PTR(rc);
> +	}
>  
>  	dev_set_drvdata(pdev, chip);
>  
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

Hope this feedback helps to improve. You really need to rewrite the whole
commit message. I wonder who could try to reproduce this. With a quick
skim I get the issue.

Also you don't have James Bottomley in the CC list of the patch who is
the author of the original commit. Please sort that out too...

/Jarkko
