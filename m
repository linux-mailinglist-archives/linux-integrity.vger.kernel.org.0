Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341F1371871
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhECPvb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 11:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhECPvb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 11:51:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53D01600CC;
        Mon,  3 May 2021 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620057037;
        bh=WJg+e9uBFOI93oL5MTA6JZSTiBnC8uXPaGlLA3niCpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GN8ux1ImbVmtojX71P0cXJthD1zmsOw7NloB7bQQS5m18DOmyZJk+PHRBhWoL2S64
         c92/o4h5rsgtTUOswB+2Duuc4dioYloVj0Kudadx5AWV4WMPeRWFeCwxefgI26HcRg
         xxk9rj9DTeurIEDMVhyea6v/LQNXws5Hb0KoVPIWuAUMnhYDveOC0RVyJJp4fzisWn
         G3x4LE0Y7GJps2qJL+ILvAsGbWFehlmY/sEaAkhLhdyRAEo+VuOMrTPPym7q/8g7mh
         ko/zzDSn7H3dYLtjgULgrjwichR46N1x5Z3dOyvJgpi+EtLJk/D7iTxrjUUjT23Wl6
         77J0mb9SBARag==
Date:   Mon, 3 May 2021 18:50:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] tpm: Simplify locality handling
Message-ID: <YJAby8mmiJ74qWAh@kernel.org>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-3-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501135727.17747-3-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

What the heck is "simplification" and what that has to do with fixing
anything? I don't understand your terminology. 

On Sat, May 01, 2021 at 03:57:25PM +0200, Lino Sanfilippo wrote:
> Currently the TPM (default) locality is claimed and released for each
> access to the TPM registers which require a claimed locality. This results
> in locality claim/release combos at various code places. For interrupt
> handling we also need such a combo in the interrupt handler (for clearing
> the interrupts) which makes the locality handling even more complicated
> since now we also have to synchronize concurrent accesses in process and in
> interrupt context.
> 
> Since currently the driver uses only one locality anyway, avoid the
> increasing complexity by claiming it once at driver startup and only
> releasing it at driver shutdown.
> 
> Due to the simplifications the functions tpm_request_locality() and
> tpm_relinquish_locality() are not needed any more an can be removed.
> 
> As a side-effect these modifications fix a bug which results in the
> following warning when using TPM 2:
> 
> TPM returned invalid status
> WARNING: CPU: 0 PID: 874 at drivers/char/tpm/tpm_tis_core.c:249 tpm_tis_status+0xbc/0xc8 [tpm_tis_core]
> Modules linked in: tpm_tis_spi tpm_tis_core tpm sha256_generic cfg80211 rfkill 8021q garp stp llc spidev v3d gpu_sched vc4 bcm2835_codec(C) cec raspberrypi_hwmon drm_kms_helper drm bcm2835_isp(C) v4l2_mem2mem bcm2835_v4l2(C) bcm2835_mmal_vchiq(C) videobuf2_vmalloc videobuf2_dma_contig snd_bcm2835(C) videobuf2_memops drm_panel_orientation_quirks videobuf2_v4l2 videobuf2_common snd_soc_core snd_compress videodev snd_pcm_dmaengine spi_bcm2835 snd_pcm mc vc_sm_cma(C) snd_timer snd syscopyarea rpivid_mem sysfillrect sysimgblt fb_sys_fops backlight uio_pdrv_genirq uio ip_tables x_tables ipv6 [last unloaded: tpm]
> CPU: 0 PID: 874 Comm: kworker/u8:1 Tainted: G        WC        5.11.0-rc2-LS-HOME+ #1
> Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> pc : tpm_tis_status+0xbc/0xc8 [tpm_tis_core]
> lr : tpm_tis_status+0xbc/0xc8 [tpm_tis_core]
> sp : ffffffc0127e38f0
> x29: ffffffc0127e38f0 x28: ffffffc011238000
> x27: 0000000000000016 x26: 000000000000017a
> x25: 0000000000000014 x24: ffffff8047f60000
> x23: 0000000000000000 x22: 0000000000000016
> x21: ffffff8044e8a480 x20: 0000000000000000
> x19: ffffffc011238000 x18: ffffffc011238948
> x17: 0000000000000000 x16: 0000000000000000
> x15: ffffffc01141be81 x14: ffffffffffffffff
> x13: ffffffc01141be7e x12: ffffffffffffffff
> x11: ffffff807fb797f0 x10: 00000000000019b0
> x9 : ffffffc0127e38f0 x8 : 766e692064656e72
> x7 : 0000000000000000 x6 : ffffffc011239000
> x5 : ffffff807fb628b8 x4 : 0000000000000000
> x3 : 0000000000000027 x2 : 0000000000000000
> x1 : 6818b6f22fdef800 x0 : 0000000000000000
> Call trace:
> tpm_tis_status+0xbc/0xc8 [tpm_tis_core]
> tpm_tis_send_data+0x58/0x250 [tpm_tis_core]
> tpm_tis_send_main+0x50/0x128 [tpm_tis_core]
> tpm_tis_send+0x4c/0xe0 [tpm_tis_core]
> tpm_transmit+0xd0/0x350 [tpm]
> tpm_transmit_cmd+0x3c/0xc0 [tpm]
> tpm2_get_tpm_pt+0x124/0x1e8 [tpm]
> tpm_tis_probe_irq_single+0x198/0x364 [tpm_tis_core]
> tpm_tis_core_init+0x304/0x520 [tpm_tis_core]
> tpm_tis_spi_init+0x5c/0x78 [tpm_tis_spi]
> tpm_tis_spi_probe+0x80/0x98 [tpm_tis_spi]
> tpm_tis_spi_driver_probe+0x4c/0x60 [tpm_tis_spi]
> spi_probe+0x84/0xf0
> really_probe+0x118/0x420
> driver_probe_device+0x5c/0xc0
> __driver_attach_async_helper+0x64/0x68
> async_run_entry_fn+0x48/0x150
> process_one_work+0x15c/0x4d0
> worker_thread+0x50/0x490
> kthread+0x118/0x150
> ret_from_fork+0x10/0x1c
> 
> The reason for this issue is that in case of TPM 2 function
> tpm2_get_timeouts() which executes a TPM command is called without a
> claimed locality. Since with this patch the locality is taken once at
> driver startup and never released before shutdown the issue does not occur
> any more.

Please rather create fix that fixes the issue exactly in the code path.
I don't want to worry what other things this might do "as a side-effect".

Also, lacks the explanation why this patch fixes the issue.

> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>  drivers/char/tpm/tpm-chip.c     | 40 ---------------------------------
>  drivers/char/tpm/tpm_tis_core.c | 35 +++++++++--------------------
>  include/linux/tpm.h             |  3 ---
>  3 files changed, 10 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..a09b6523261e 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -32,35 +32,6 @@ struct class *tpm_class;
>  struct class *tpmrm_class;
>  dev_t tpm_devt;
>  
> -static int tpm_request_locality(struct tpm_chip *chip)
> -{
> -	int rc;
> -
> -	if (!chip->ops->request_locality)
> -		return 0;
> -
> -	rc = chip->ops->request_locality(chip, 0);
> -	if (rc < 0)
> -		return rc;
> -
> -	chip->locality = rc;
> -	return 0;
> -}
> -
> -static void tpm_relinquish_locality(struct tpm_chip *chip)
> -{
> -	int rc;
> -
> -	if (!chip->ops->relinquish_locality)
> -		return;
> -
> -	rc = chip->ops->relinquish_locality(chip, chip->locality);
> -	if (rc)
> -		dev_err(&chip->dev, "%s: : error %d\n", __func__, rc);
> -
> -	chip->locality = -1;
> -}
> -
>  static int tpm_cmd_ready(struct tpm_chip *chip)
>  {
>  	if (!chip->ops->cmd_ready)
> @@ -103,17 +74,8 @@ int tpm_chip_start(struct tpm_chip *chip)
>  
>  	tpm_clk_enable(chip);
>  
> -	if (chip->locality == -1) {
> -		ret = tpm_request_locality(chip);
> -		if (ret) {
> -			tpm_clk_disable(chip);
> -			return ret;
> -		}
> -	}
> -
>  	ret = tpm_cmd_ready(chip);
>  	if (ret) {
> -		tpm_relinquish_locality(chip);
>  		tpm_clk_disable(chip);
>  		return ret;
>  	}
> @@ -133,7 +95,6 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
>  void tpm_chip_stop(struct tpm_chip *chip)
>  {
>  	tpm_go_idle(chip);
> -	tpm_relinquish_locality(chip);
>  	tpm_clk_disable(chip);
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_stop);
> @@ -392,7 +353,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  		goto out;
>  	}
>  
> -	chip->locality = -1;
>  	return chip;
>  
>  out:
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index a12992ae2a3e..f892b1ae46f2 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -626,9 +626,6 @@ static int probe_itpm(struct tpm_chip *chip)
>  	if (vendor != TPM_VID_INTEL)
>  		return 0;
>  
> -	if (request_locality(chip, 0) != 0)
> -		return -EBUSY;
> -
>  	rc = tpm_tis_send_data(chip, cmd_getticks, len);
>  	if (rc == 0)
>  		goto out;
> @@ -647,7 +644,6 @@ static int probe_itpm(struct tpm_chip *chip)
>  
>  out:
>  	tpm_tis_ready(chip);
> -	release_locality(chip, priv->locality);
>  
>  	return rc;
>  }
> @@ -707,22 +703,13 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  	const char *desc = "attempting to generate an interrupt";
>  	u32 cap2;
>  	cap_t cap;
> -	int ret;
>  
>  	/* TPM 2.0 */
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>  
>  	/* TPM 1.2 */
> -	ret = request_locality(chip, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
> -
> -	release_locality(chip, 0);
> -
> -	return ret;
> +	return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
>  }
>  
>  /* Register the IRQ and issue a command that will cause an interrupt. If an
> @@ -836,6 +823,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
>  
>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
>  
> +	release_locality(chip, 0);
>  	tpm_tis_clkrun_enable(chip, false);
>  
>  	if (priv->ilb_base_addr)
> @@ -963,6 +951,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
>  
> +	rc = request_locality(chip, 0);
> +	if (rc)
> +		goto out_err;
> +
> +	rc = tpm_chip_start(chip);
> +	if (rc)
> +		goto out_err;
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
> @@ -973,9 +969,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	intmask &= ~TPM_GLOBAL_INT_ENABLE;
>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>  
> -	rc = tpm_chip_start(chip);
> -	if (rc)
> -		goto out_err;
>  	rc = tpm2_probe(chip);
>  	tpm_chip_stop(chip);
>  	if (rc)
> @@ -1036,15 +1029,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		 * to make sure it works. May as well use that command to set the
>  		 * proper timeouts for the driver.
>  		 */
> -
> -		rc = request_locality(chip, 0);
> -		if (rc < 0)
> -			goto out_err;
> -
>  		rc = tpm_get_timeouts(chip);
> -
> -		release_locality(chip, 0);
> -
>  		if (rc) {
>  			dev_err(dev, "Could not get TPM timeouts and durations\n");
>  			rc = -ENODEV;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index aa11fe323c56..7a68832b14bb 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -167,9 +167,6 @@ struct tpm_chip {
>  	u32 last_cc;
>  	u32 nr_commands;
>  	u32 *cc_attrs_tbl;
> -
> -	/* active locality */
> -	int locality;
>  };
>  
>  #define TPM_HEADER_SIZE		10
> -- 
> 2.31.1
> 

/Jarkko
