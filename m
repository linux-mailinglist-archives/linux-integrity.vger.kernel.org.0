Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8712961429C
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 02:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKABGP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 21:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKABGO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 21:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD04911140;
        Mon, 31 Oct 2022 18:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F0961517;
        Tue,  1 Nov 2022 01:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145E9C433C1;
        Tue,  1 Nov 2022 01:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667264771;
        bh=QGO3KBMvioltcMGly9DBgBTnoHBaGMC8jg4aGRgcUUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i22u14ORQhTasBqajmSlKRansNjUOpNxISIDSscs7BB0AuuymJD+2ZlPXlyFAfpEP
         /WbB+TH93qvwJVYiaVFO/14VJ2T7lMYNTExObXhL2JlyPF3GnjbcvJ+y5/Hg2/qok7
         cNPk7SiLoDCNLyh3PSFGGi0sPAJ9EszzGgf0463H2tmBDQPrgCIAYNa2EbLn8N6V3Q
         Uz2zHPzX4Y95tKtVunPeAzZoBuq3ZUTMhOeed9IIsVADaB1YyBVXJ64e9qoFONd2X/
         YbxwB20cdpxNussDOvHU7z6Tpto0jz2486wzec6Dw/FKRpTNu1/vAQ5GvGD+eRUw+p
         5TViMQ6PLueCw==
Date:   Tue, 1 Nov 2022 03:06:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Message-ID: <Y2Bw/yhTs258Iiew@kernel.org>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de>
 <Y1TFzO1CBY8d4rfa@kernel.org>
 <fcf53b02-a505-46ac-006e-0e317f00bbe3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcf53b02-a505-46ac-006e-0e317f00bbe3@gmx.de>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 25, 2022 at 02:15:51AM +0200, Lino Sanfilippo wrote:
> 
> On 23.10.22 06:40, Jarkko Sakkinen wrote:
> > On Tue, Oct 18, 2022 at 01:57:29AM +0200, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> Implement a usage counter for the (default) locality used by the TPM TIS
> >> driver:
> >> Request the locality from the TPM if it has not been claimed yet, otherwise
> >> only increment the counter. Also release the locality if the counter is 0
> >> otherwise only decrement the counter. Ensure thread-safety by protecting
> >> the counter with a mutex.
> >>
> >> This allows to request and release the locality from a thread and the
> >> interrupt handler at the same time without the danger to interfere with
> >> each other.
> >>
> >> By doing this refactor the names of the amended functions to use the proper
> >> prefix.
> >>
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >> Tested-by: Michael Niewöhner <linux@mniewoehner.de>
> >> ---
> >>  drivers/char/tpm/tpm_tis_core.c | 75 ++++++++++++++++++++++-----------
> >>  drivers/char/tpm/tpm_tis_core.h |  2 +
> >>  2 files changed, 53 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> >> index 4336f7ea8c2b..79dfab65976f 100644
> >> --- a/drivers/char/tpm/tpm_tis_core.c
> >> +++ b/drivers/char/tpm/tpm_tis_core.c
> >> @@ -165,16 +165,27 @@ static bool check_locality(struct tpm_chip *chip, int l)
> >>  	return false;
> >>  }
> >>
> >> -static int release_locality(struct tpm_chip *chip, int l)
> >> +static int tpm_tis_release_locality_locked(struct tpm_tis_data *priv, int l)
> >
> > Nit: usually you would actually use "unlocked" here, not locked.
> >
> > Probably best name would be __tpm_tis_release_locality().
> 
> 
> Agreed. This is also consistent with the naming scheme used for many other
> kernel functions.
> 
> >
> >> +{
> >> +	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int tpm_tis_release_locality(struct tpm_chip *chip, int l)
> >>  {
> >>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >>
> >> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> >> +	mutex_lock(&priv->locality_count_mutex);
> >> +	priv->locality_count--;
> >> +	if (priv->locality_count == 0)
> >> +		tpm_tis_release_locality_locked(priv, l);
> >> +	mutex_unlock(&priv->locality_count_mutex);
> >>
> >>  	return 0;
> >>  }
> >
> > Since the function pointer has the word "relinquish" and not "release",
> > perhaps these should also use that word for consistency.
> >
> >>
> >> -static int request_locality(struct tpm_chip *chip, int l)
> >> +static int tpm_tis_request_locality_locked(struct tpm_chip *chip, int l)
> >>  {
> >>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >>  	unsigned long stop, timeout;
> >> @@ -215,6 +226,20 @@ static int request_locality(struct tpm_chip *chip, int l)
> >>  	return -1;
> >>  }
> >>
> >> +static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
> >> +{
> >> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >> +	int ret = 0;
> >> +
> >> +	mutex_lock(&priv->locality_count_mutex);
> >> +	if (priv->locality_count == 0)
> >> +		ret = tpm_tis_request_locality_locked(chip, l);
> >> +	if (!ret)
> >> +		priv->locality_count++;
> >> +	mutex_unlock(&priv->locality_count_mutex);
> >> +	return ret;
> >> +}
> >> +
> >>  static u8 tpm_tis_status(struct tpm_chip *chip)
> >>  {
> >>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >> @@ -682,7 +707,7 @@ static int probe_itpm(struct tpm_chip *chip)
> >>  	if (vendor != TPM_VID_INTEL)
> >>  		return 0;
> >>
> >> -	if (request_locality(chip, 0) != 0)
> >> +	if (tpm_tis_request_locality(chip, 0) != 0)
> >>  		return -EBUSY;
> >>
> >>  	rc = tpm_tis_send_data(chip, cmd_getticks, len);
> >> @@ -703,7 +728,7 @@ static int probe_itpm(struct tpm_chip *chip)
> >>
> >>  out:
> >>  	tpm_tis_ready(chip);
> >> -	release_locality(chip, priv->locality);
> >> +	tpm_tis_release_locality(chip, priv->locality);
> >>
> >>  	return rc;
> >>  }
> >> @@ -762,7 +787,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
> >>  	cap_t cap;
> >>  	int ret;
> >>
> >> -	ret = request_locality(chip, 0);
> >> +	ret = tpm_tis_request_locality(chip, 0);
> >>  	if (ret < 0)
> >>  		return ret;
> >>
> >> @@ -771,7 +796,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
> >>  	else
> >>  		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
> >>
> >> -	release_locality(chip, 0);
> >> +	tpm_tis_release_locality(chip, 0);
> >>
> >>  	return ret;
> >>  }
> >> @@ -796,33 +821,33 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
> >>  	}
> >>  	priv->irq = irq;
> >>
> >> -	rc = request_locality(chip, 0);
> >> +	rc = tpm_tis_request_locality(chip, 0);
> >>  	if (rc < 0)
> >>  		return rc;
> >>
> >>  	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
> >>  			   &original_int_vec);
> >>  	if (rc < 0) {
> >> -		release_locality(chip, priv->locality);
> >> +		tpm_tis_release_locality(chip, priv->locality);
> >>  		return rc;
> >>  	}
> >>
> >>  	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
> >>  	if (rc < 0) {
> >> -		release_locality(chip, priv->locality);
> >> +		tpm_tis_release_locality(chip, priv->locality);
> >>  		return rc;
> >>  	}
> >>
> >>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
> >>  	if (rc < 0) {
> >> -		release_locality(chip, priv->locality);
> >> +		tpm_tis_release_locality(chip, priv->locality);
> >>  		return rc;
> >>  	}
> >>
> >>  	/* Clear all existing */
> >>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
> >>  	if (rc < 0) {
> >> -		release_locality(chip, priv->locality);
> >> +		tpm_tis_release_locality(chip, priv->locality);
> >>  		return rc;
> >>  	}
> >>
> >> @@ -830,11 +855,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
> >>  	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
> >>  			     intmask | TPM_GLOBAL_INT_ENABLE);
> >>  	if (rc < 0) {
> >> -		release_locality(chip, priv->locality);
> >> +		tpm_tis_release_locality(chip, priv->locality);
> >>  		return rc;
> >>  	}
> >>
> >> -	release_locality(chip, priv->locality);
> >> +	tpm_tis_release_locality(chip, priv->locality);
> >>  	clear_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
> >>
> >>  	/* Generate an interrupt by having the core call through to
> >> @@ -970,8 +995,8 @@ static const struct tpm_class_ops tpm_tis = {
> >>  	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> >>  	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> >>  	.req_canceled = tpm_tis_req_canceled,
> >> -	.request_locality = request_locality,
> >> -	.relinquish_locality = release_locality,
> >> +	.request_locality = tpm_tis_request_locality,
> >> +	.relinquish_locality = tpm_tis_release_locality,
> >>  	.clk_enable = tpm_tis_clkrun_enable,
> >>  };
> >>
> >> @@ -1005,6 +1030,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> >>  	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
> >>  	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
> >>  	priv->phy_ops = phy_ops;
> >> +	priv->locality_count = 0;
> >> +	mutex_init(&priv->locality_count_mutex);
> >>
> >>  	dev_set_drvdata(&chip->dev, priv);
> >>
> >> @@ -1083,14 +1110,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> >>
> >>  	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> >>
> >> -	rc = request_locality(chip, 0);
> >> +	rc = tpm_tis_request_locality(chip, 0);
> >>  	if (rc < 0) {
> >>  		rc = -ENODEV;
> >>  		goto out_err;
> >>  	}
> >>
> >>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> >> -	release_locality(chip, 0);
> >> +	tpm_tis_release_locality(chip, 0);
> >>
> >>  	rc = tpm_chip_start(chip);
> >>  	if (rc)
> >> @@ -1124,13 +1151,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> >>  		 * proper timeouts for the driver.
> >>  		 */
> >>
> >> -		rc = request_locality(chip, 0);
> >> +		rc = tpm_tis_request_locality(chip, 0);
> >>  		if (rc < 0)
> >>  			goto out_err;
> >>
> >>  		rc = tpm_get_timeouts(chip);
> >>
> >> -		release_locality(chip, 0);
> >> +		tpm_tis_release_locality(chip, 0);
> >>
> >>  		if (rc) {
> >>  			dev_err(dev, "Could not get TPM timeouts and durations\n");
> >> @@ -1150,11 +1177,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
> >>  			dev_err(&chip->dev, FW_BUG
> >>  					"TPM interrupt not working, polling instead\n");
> >>
> >> -			rc = request_locality(chip, 0);
> >> +			rc = tpm_tis_request_locality(chip, 0);
> >>  			if (rc < 0)
> >>  				goto out_err;
> >>  			disable_interrupts(chip);
> >> -			release_locality(chip, 0);
> >> +			tpm_tis_release_locality(chip, 0);
> >>  		}
> >>  	}
> >>
> >> @@ -1221,13 +1248,13 @@ int tpm_tis_resume(struct device *dev)
> >>  	 * an error code but for unknown reason it isn't handled.
> >>  	 */
> >>  	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >> -		ret = request_locality(chip, 0);
> >> +		ret = tpm_tis_request_locality(chip, 0);
> >>  		if (ret < 0)
> >>  			return ret;
> >>
> >>  		tpm1_do_selftest(chip);
> >>
> >> -		release_locality(chip, 0);
> >> +		tpm_tis_release_locality(chip, 0);
> >>  	}
> >>
> >>  	return 0;
> >> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> >> index 2deef11c88db..13bdcf38e56f 100644
> >> --- a/drivers/char/tpm/tpm_tis_core.h
> >> +++ b/drivers/char/tpm/tpm_tis_core.h
> >> @@ -91,6 +91,8 @@ enum tpm_tis_flags {
> >>
> >>  struct tpm_tis_data {
> >>  	u16 manufacturer_id;
> >> +	struct mutex locality_count_mutex;
> >
> > BTW, why mutex and not spinlock?
> >
> > Hmm.. also I think you might have given feedback already on this
> > but could the lock cover the whole struct instead of a counter?
> > I tried to dig lore for earlier response but could not find. I'm
> > sorry if I'm asking the same question again.
> >
> 
> Actually thats on me, since it took me much too long to send the v8 after the v7 review.
> 
> However the reason that we need a mutex here is that we not only increase or decrease
> the locality_counter under the mutex, but also do the locality request and release by
> writing to the ACCESS register. Since in the SPI case each communication over the spi bus
> is protected by the bus_lock_mutex of the SPI device we must not hold a spinlock when doing
> the register accesses.
> 
> Concerning covering the whole tpm_tis_data struct:
> Most structure elements are set once at driver startup but never changed at driver
> runtime. So no locking needed for these. The only exception is "flags" and "locality_count"
> whereby "flags" is accessed by atomic bit manipulating functions and thus
> does not need extra locking. So "locality_count" is AFAICS the only element that needs to be
> protected by the mutex.

OK, but you should should still address this in commit message, e.g.
by mentioning that in the case of SPI bus mutex is required because
the bus itself needs to be locked in the mutex.

I.e. this a claim, definitely not an argument: "Ensure thread-safety by
protecting the counter with a mutex."

BR, Jarkko
