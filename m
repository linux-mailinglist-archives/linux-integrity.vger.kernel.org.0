Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4570CE30
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 00:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjEVWpr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjEVWpp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 18:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60ADB
        for <linux-integrity@vger.kernel.org>; Mon, 22 May 2023 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684795499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DaVz2A4ookrYy0bG1/ownvewposvWWNIhPO/rg/szCc=;
        b=Sy6kS60bcbWm5wsu8nHLqGZJczvtHYz7SaWlKpQ/wOP9JbrbrzJqJBJkDQ8sAI64zQVmP+
        Are5ro30YqvKQ0WQLmWkHlt/hsMekNdW3Wzphha/uUwcpIhzdwO/PcttTa6e/RcsyAL6J3
        RXb7DZhj/6iFiFxOgcshgy+fM6mErz0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-7jq7zHtkNc6Td7CCcipaNQ-1; Mon, 22 May 2023 18:44:57 -0400
X-MC-Unique: 7jq7zHtkNc6Td7CCcipaNQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75b02da6949so194464085a.2
        for <linux-integrity@vger.kernel.org>; Mon, 22 May 2023 15:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684795497; x=1687387497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaVz2A4ookrYy0bG1/ownvewposvWWNIhPO/rg/szCc=;
        b=dTH7MMv/ZopEYLwtcu18P0CbDPVSYTumQelyO6O8q+dHVT8d8cL73PUYd6H756ipGQ
         a2xUanvSF2beZK+zoH+yvVr9H92qFnKqH2Vg1Kyujc/NyfHxSnyLhkxDGwC2z/CJ6bXM
         wwUID9vZVAOjGPPTuvdDzeFRBRZxIuvlUlm7lJJrVIPkiSnbQ0foSiMUQG02IhhWJwTe
         z2yuEs5yWRP4EvTZEeodvLpEanP4Ph7e6rdGxqn6q+8Q+qAQNdjsj3IFSsLyh4T6zOgs
         FsmFjroj3Ylx2GcTnNH/yl+nK85eYwKQe03i/cfZC5XSNZquCtVFkkChLoOe6zDfM8wg
         6x4g==
X-Gm-Message-State: AC+VfDx+psmWPtglPZgFQoxB2qA3tRgNBoYB27ybzaVTmbl2vq8RPp3C
        RaBZSDo5/cALOmV73zgj/8jCdff0qGhVfb0suhx53n6q7QEjkpAu30dOw6Gqw+iQKh/3SsUCjHN
        gQPkyFbuxqCKSKGMNaR39igwMIiHt
X-Received: by 2002:a05:620a:678e:b0:75b:23a1:424 with SMTP id rr14-20020a05620a678e00b0075b23a10424mr2265045qkn.58.1684795497388;
        Mon, 22 May 2023 15:44:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5E0z/Qztg9m+Xz89ofUOSQ7AaHC2ufX/Shd5E+wODIrQUEtmQTN9GTxHTglw3KD+jjSWGHrA==
X-Received: by 2002:a05:620a:678e:b0:75b:23a1:424 with SMTP id rr14-20020a05620a678e00b0075b23a10424mr2265021qkn.58.1684795496967;
        Mon, 22 May 2023 15:44:56 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b0074411b03972sm2053343qkm.51.2023.05.22.15.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 15:44:56 -0700 (PDT)
Date:   Mon, 22 May 2023 15:44:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peter.ujfalusi@linux.intel.com, peterz@infradead.org,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <ur6ype3ki6sxmpbzh53vfoewhq5oiqucioz3nwbdcda2vkaut7@sjt2hr33j3xk>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 22, 2023 at 04:31:04PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
> interrupts instead of polling on all capable TPMs. Unfortunately, on some
> products the interrupt line is either never asserted or never deasserted.
> 
> The former causes interrupt timeouts and is detected by
> tpm_tis_core_init(). The latter results in interrupt storms.
> 
> Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkPad
> L490 and Inspur NF5180M6:
> 
> https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel@redhat.com/
> https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/
> 
> The current approach to avoid those storms is to disable interrupts by
> adding a DMI quirk for the concerned device.
> 
> However this is a maintenance burden in the long run, so use a generic
> approach:
> 
> Detect an interrupt storm by counting the number of unhandled interrupts
> within a 10 ms time interval. In case that more than 1000 were unhandled
> deactivate interrupts, deregister the handler and fall back to polling.
> 
> This equals the implementation that handles interrupt storms in
> note_interrupt() by means of timestamps and counters in struct irq_desc.
> However the function to access this structure is private so the logic has
> to be reimplemented in the TPM TIS core.
> 
> Since handler deregistration would deadlock from within the interrupt
> routine trigger a worker thread that executes the unregistration.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis_core.c | 71 +++++++++++++++++++++++++++++++--
>  drivers/char/tpm/tpm_tis_core.h |  6 +++
>  2 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 558144fa707a..458ebf8c2f16 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -752,6 +752,55 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>  	return status == TPM_STS_COMMAND_READY;
>  }
>  
> +static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	int intmask = 0;
> +
> +	dev_err(&chip->dev, HW_ERR
> +		"TPM interrupt storm detected, polling instead\n");
> +
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +
> +	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> +
> +	tpm_tis_request_locality(chip, 0);
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	tpm_tis_relinquish_locality(chip, 0);
> +
> +	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +
> +	/*
> +	 * We must not call devm_free_irq() from within the interrupt handler,
> +	 * since this function waits for running interrupt handlers to finish
> +	 * and thus it would deadlock. Instead trigger a worker that does the
> +	 * unregistration.
> +	 */
> +	schedule_work(&priv->free_irq_work);
> +}
> +
> +static void tpm_tis_process_unhandled_interrupt(struct tpm_chip *chip)
> +{
> +	const unsigned int MAX_UNHANDLED_IRQS = 1000;
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	/*
> +	 * The worker to free the TPM interrupt (free_irq_work) may already
> +	 * be scheduled, so make sure it is not scheduled again.
> +	 */
> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> +		return;
> +
> +	if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
> +		priv->unhandled_irqs = 1;
> +	else
> +		priv->unhandled_irqs++;
> +
> +	priv->last_unhandled_irq = jiffies;
> +
> +	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
> +		tpm_tis_handle_irq_storm(chip);
> +}
> +
>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  {
>  	struct tpm_chip *chip = dev_id;
> @@ -761,10 +810,10 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>  	if (rc < 0)
> -		return IRQ_NONE;
> +		goto unhandled;
>  
>  	if (interrupt == 0)
> -		return IRQ_NONE;
> +		goto unhandled;
>  
>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
> @@ -780,10 +829,14 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
>  	tpm_tis_relinquish_locality(chip, 0);
>  	if (rc < 0)
> -		return IRQ_NONE;
> +		goto unhandled;
>  
>  	tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>  	return IRQ_HANDLED;
> +
> +unhandled:
> +	tpm_tis_process_unhandled_interrupt(chip);
> +	return IRQ_HANDLED;
>  }
>  
>  static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
> @@ -804,6 +857,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  		chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>  }
>  
> +static void tpm_tis_free_irq_func(struct work_struct *work)
> +{
> +	struct tpm_tis_data *priv = container_of(work, typeof(*priv), free_irq_work);
> +	struct tpm_chip *chip = priv->chip;
> +
> +	devm_free_irq(chip->dev.parent, priv->irq, chip);
> +	priv->irq = 0;
> +}
> +
>  /* Register the IRQ and issue a command that will cause an interrupt. If an
>   * irq is seen then leave the chip setup for IRQ operation, otherwise reverse
>   * everything and leave in polling mode. Returns 0 on success.
> @@ -816,6 +878,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
>  
> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
>  
>  	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>  				       tis_int_handler, IRQF_ONESHOT | flags,
> @@ -918,6 +981,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
>  		interrupt = 0;
>  
>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
> +	flush_work(&priv->free_irq_work);
>  
>  	tpm_tis_clkrun_enable(chip, false);
>  
> @@ -1021,6 +1085,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>  	chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>  	chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	priv->chip = chip;
>  	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
>  	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops = phy_ops;
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index e978f457fd4d..6fc86baa4398 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -91,12 +91,18 @@ enum tpm_tis_flags {
>  };
>  
>  struct tpm_tis_data {
> +	struct tpm_chip *chip;
>  	u16 manufacturer_id;
>  	struct mutex locality_count_mutex;
>  	unsigned int locality_count;
>  	int locality;
> +	/* Interrupts */
>  	int irq;
> +	struct work_struct free_irq_work;
> +	unsigned long last_unhandled_irq;
> +	unsigned int unhandled_irqs;
>  	unsigned int int_mask;
> +
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
>  	u16 clkrun_enabled;
> 
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
> -- 
> 2.40.1
> 

