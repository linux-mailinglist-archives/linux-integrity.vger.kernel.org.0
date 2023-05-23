Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FEC70D442
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 08:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjEWGrb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEWGrb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 02:47:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D2109;
        Mon, 22 May 2023 23:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684824447; x=1716360447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nPGzOVJo0Gt6rMmPyaGX6LyVhlcwd0uy6tJG10dAewY=;
  b=kI6smQIdOgeV7CBV7p3qI/iC1t1QWFrs4trONtz9B+pi0MZlhu+Yf+Re
   eGjeexMycOUfTPcsZrOPQnPvgihC0joB2xJ7SJcJB38W98uBQaut9Bspt
   TSeT1RVXQ+zv6qn5TEBScVcRP7kf6JPP98kGnH0n6Oess4Na+S/O1JWGN
   V8hD30rwCt97y/qdyvfCbFsRlXiRCyen5FsaFL2ongHDr44IAo3NWq4Qx
   0p8iyayXaMHtwdCVBjk6p3GtmEjGPBFMS94fzkcCn+AWC/bU5gkNd3rTU
   iz+kixOrNcu+DWb4V6xbt+4BvTkrG3VaGu5jdgKDJTSCrR3D2nOFNiLBO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350658460"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="350658460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 23:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="768865527"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="768865527"
Received: from nmkenne1-mobl2.ger.corp.intel.com (HELO [10.252.53.154]) ([10.252.53.154])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 23:47:23 -0700
Message-ID: <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
Date:   Tue, 23 May 2023 09:48:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 22/05/2023 17:31, Lino Sanfilippo wrote:
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

This looked promising, however it looks like the UPX-i11 needs the DMI
quirk.

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

Should this be dev_warn or even dev_info level?
It is done delibaretly and it is handled as planned, so it is not really
an error?

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

unsigned long storm_window;
..
storm_window = priv->last_unhandled_irq + msecs_to_jiffies(10);
if (time_after(jiffies, storm_window))
	priv->unhandled_irqs = 0;

priv->unhandled_irqs++;

> +		priv->unhandled_irqs = 1;
> +	else
> +		priv->unhandled_irqs++;
> +
> +	priv->last_unhandled_irq = jiffies;
> +
> +	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
> +		tpm_tis_handle_irq_storm(chip);

Will the kernel step in and disbale the IRQ before we would have
detected the storm?
I don't know top of my head the trigger in core to stop an interrupt
storm...

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

This is more like an error than just unhandled IRQ. Yes, it was ignored,
probably because it is common?

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

Should disable_interrupts() be called instead (with the locality
request/relinquish)?

Is there a chance of a race or is a race matters?

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

-- 
Péter
