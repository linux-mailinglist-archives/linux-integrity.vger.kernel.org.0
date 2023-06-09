Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A1E729CF4
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbjFIOdg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbjFIOdd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 10:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0B3585;
        Fri,  9 Jun 2023 07:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EED7361338;
        Fri,  9 Jun 2023 14:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC0C433D2;
        Fri,  9 Jun 2023 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686321209;
        bh=CY+YYElYqC/kJKILLNqHwJZdhRGnFwjotZHTV7ULykA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=cmDVEVwII5eebwEqT5/cbmDOQpms95jzSsjtKUNDmmB2S7jVf/RVt2C9PvCXKxEdT
         x+bPrOB9L5j/FnzcBUQr7RBPxC+l/7g5MKqnSWruQgJr9pxf8h1/3CTVNcvZy/hiGI
         uPRs3253OP/q06CWGcLJaCS5uqPxW8TCezvTs3E4fJDGuc9ivCGJZ8bniI4aZa/W0W
         GmUnPtont62O3yEVAqyEtzS0vVKhzCGSv4JSOW5LNkswdf4j3rWyBUc5seUSk6XBBO
         8wvjckUSxNlF/UGyRvyQmnOfXT9wyID+Cn8F79TesLfBUX7cFjpfwvn1S+RTksV39u
         kprcOUmu2WFLA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 17:33:23 +0300
Message-Id: <CT86Z65L4O9A.2FIOFZUI6BVB4@suppilovahvero>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>,
        "kernel test robot" <yujie.liu@intel.com>
Subject: Re: [PATCH v2] tpm,tpm_tis: Handle interrupt storm
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
X-Mailer: aerc 0.14.0
References: <20230530174712.6989-1-LinoSanfilippo@gmx.de>
In-Reply-To: <20230530174712.6989-1-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 30, 2023 at 8:47 PM EEST, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> After activation of interrupts for TPM TIS drivers 0-day reports an
> interrupt storm on an Inspur NF5180M6/NF5180M6 server.
>
> Fix this by detecting the storm and falling back to polling:
> Count the number of unhandled interrupts within a 10 ms time interval. In
> case that more than 1000 were unhandled deactivate interrupts entirely,
> deregister the handler and use polling instead.
>
> The storm detection logic equals the implementation in note_interrupt()
> which uses timestamps and counters stored in struct irq_desc. Since this
> structure is private to the generic interrupt core the TPM TIS core uses
> its own timestamps and counters. Furthermore the TPM interrupt handler
> always returns IRQ_HANDLED to prevent the generic interrupt core from
> processing the interrupt storm.
>
> Since the interrupt deregistration function devm_free_irq() waits for all
> interrupt handlers to finish, only trigger a worker in the interrupt
> handler and do the unregistration in the worker to avoid a deadlock.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@in=
tel.com/
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---

Sorry for the latency. I've moved home office to a new location,
which has caused ~2 week lag. Unfortunate timing.

>  drivers/char/tpm/tpm_tis_core.c | 93 ++++++++++++++++++++++++++++-----
>  drivers/char/tpm/tpm_tis_core.h |  4 ++
>  2 files changed, 85 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 558144fa707a..7ae8228e803f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -468,25 +468,32 @@ static int tpm_tis_send_data(struct tpm_chip *chip,=
 const u8 *buf, size_t len)
>  	return rc;
>  }
> =20
> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	u32 intmask =3D 0;
> +
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> +
> +	tpm_tis_request_locality(chip, 0);
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	tpm_tis_relinquish_locality(chip, 0);
> +
> +	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
> +}
> +
>  static void disable_interrupts(struct tpm_chip *chip)

Add tpm_ prefix here too. It makes tracing/grepping/etc so much nicer.

>  {
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> -	u32 intmask;

int_mask is more readable

> -	int rc;
> =20
>  	if (priv->irq =3D=3D 0)
>  		return;
> =20
> -	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> -		intmask =3D 0;
> -
> -	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> -	rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	__tpm_tis_disable_interrupts(chip);
> =20
>  	devm_free_irq(chip->dev.parent, priv->irq, chip);
>  	priv->irq =3D 0;
> -	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>  }
> =20
>  /*
> @@ -752,6 +759,53 @@ static bool tpm_tis_req_canceled(struct tpm_chip *ch=
ip, u8 status)
>  	return status =3D=3D TPM_STS_COMMAND_READY;
>  }
> =20
> +static void tpm_tis_reenable_polling(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +
> +	dev_warn(&chip->dev, FW_BUG
> +		 "TPM interrupt storm detected, polling instead\n");
> +
> +	__tpm_tis_disable_interrupts(chip);
> +
> +	/*
> +	 * devm_free_irq() must not be called from within the interrupt handler=
,
> +	 * since this function waits for running handlers to finish and thus it
> +	 * would deadlock. Instead trigger a worker that takes care of the
> +	 * unregistration.
> +	 */
> +	schedule_work(&priv->free_irq_work);
> +}
> +
> +static irqreturn_t tpm_tis_check_for_interrupt_storm(struct tpm_chip *ch=
ip)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	const unsigned int MAX_UNHANDLED_IRQS =3D 1000;

Please declare this in the beginning of file because it is non-empirical
tuning parameter. I do not want it to be buried here. It is now as good
as a magic number.

Or perhaps even tpm_tis_core.h?

Why MAX_UNHANDLED_IRQS is exactly 1000 and not 1? I would rollback eagerly.

> +
> +	/*
> +	 * The worker to free the TPM interrupt (free_irq_work) may already
> +	 * be scheduled, so make sure it is not scheduled again.
> +	 */
> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> +		return IRQ_HANDLED;
> +
> +	if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
> +		priv->unhandled_irqs =3D 1;
> +	else
> +		priv->unhandled_irqs++;
> +
> +	priv->last_unhandled_irq =3D jiffies;
> +
> +	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
> +		tpm_tis_reenable_polling(chip);
> +
> +	/*
> +	 * Prevent the genirq code from starting its own interrupt storm
> +	 * handling by always reporting that the interrupt was handled.
> +	 */
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  {
>  	struct tpm_chip *chip =3D dev_id;
> @@ -761,10 +815,10 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
> =20
>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt)=
;
>  	if (rc < 0)
> -		return IRQ_NONE;
> +		goto unhandled;
> =20
>  	if (interrupt =3D=3D 0)
> -		return IRQ_NONE;
> +		goto unhandled;
> =20
>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
> @@ -780,10 +834,13 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
>  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt)=
;
>  	tpm_tis_relinquish_locality(chip, 0);
>  	if (rc < 0)
> -		return IRQ_NONE;
> +		goto unhandled;
> =20
>  	tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>  	return IRQ_HANDLED;
> +
> +unhandled:
> +	return tpm_tis_check_for_interrupt_storm(chip);
>  }
> =20
>  static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
> @@ -804,6 +861,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *c=
hip)
>  		chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>  }
> =20
> +static void tpm_tis_free_irq_func(struct work_struct *work)
> +{
> +	struct tpm_tis_data *priv =3D container_of(work, typeof(*priv), free_ir=
q_work);
> +	struct tpm_chip *chip =3D priv->chip;
> +
> +	devm_free_irq(chip->dev.parent, priv->irq, chip);
> +	priv->irq =3D 0;
> +}
> +
>  /* Register the IRQ and issue a command that will cause an interrupt. If=
 an
>   * irq is seen then leave the chip setup for IRQ operation, otherwise re=
verse
>   * everything and leave in polling mode. Returns 0 on success.
> @@ -816,6 +882,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *=
chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
> =20
> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> =20
>  	rc =3D devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>  				       tis_int_handler, IRQF_ONESHOT | flags,
> @@ -918,6 +985,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
>  		interrupt =3D 0;
> =20
>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
> +	flush_work(&priv->free_irq_work);
> =20
>  	tpm_tis_clkrun_enable(chip, false);
> =20
> @@ -1021,6 +1089,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>  	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>  	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	priv->chip =3D chip;
>  	priv->timeout_min =3D TPM_TIMEOUT_USECS_MIN;
>  	priv->timeout_max =3D TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops =3D phy_ops;
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index e978f457fd4d..b1fa42367052 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -91,11 +91,15 @@ enum tpm_tis_flags {
>  };
> =20
>  struct tpm_tis_data {
> +	struct tpm_chip *chip;
>  	u16 manufacturer_id;
>  	struct mutex locality_count_mutex;
>  	unsigned int locality_count;
>  	int locality;
>  	int irq;
> +	struct work_struct free_irq_work;
> +	unsigned long last_unhandled_irq;
> +	unsigned int unhandled_irqs;
>  	unsigned int int_mask;
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
>
> base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
> --=20
> 2.40.1


BR, Jarkko
