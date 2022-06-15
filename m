Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022C154D0D1
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347605AbiFOSUN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiFOSUM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:20:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336B53A67;
        Wed, 15 Jun 2022 11:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2E7C61C1A;
        Wed, 15 Jun 2022 18:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00963C34115;
        Wed, 15 Jun 2022 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655317210;
        bh=zgMm3tT9CMOKGocsDUTWvQnrf6rZzPwugTdww0pEwQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kA2H6iCIfbsuQDEdBsjB51SdyM8UmeClAPVHQ7KBXx263xxyHSM1UUN2G0NmDzERf
         n05l061sd2keBXkJ9uTSDhHXPy0DILiyeTkjAH1fBLtsynnjNnW/Xyu0izNOGJPZ+K
         MJRm42OXpkTj6+2uF2oNVzdPnirelaZ130lKQMgj+39NQho3YAT9HGLBN1ycNGf99Y
         E3IGLnWh4m3O2ZAu089iVv3EEJA0jbsXbSCxKys2QlfD4aq+c/k4yK/4j+B0JUd3/2
         vf2+98bAbu+Chk3x+/l2xd5Aiur/nbNpyw5870aXlVBovX2+UVz0C6uX4icOZOoHvG
         QaBpVsjOIKwLQ==
Date:   Wed, 15 Jun 2022 21:18:01 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 05/10] tpm, tpm_tis: Store result of interrupt
 capability query
Message-ID: <YqoiWdwcds6AZgoO@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-6-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-6-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:41PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> According to the TPM Interface Specification (TIS) support for "stsValid"
> and "commandReady" interrupts is only optional.
> This has to be taken into account when handling the interrupts in functions
> like wait_for_tpm_stat(). So query the set of supported interrupts and
> store it in a global variable so that it can be accessed later.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 73 +++++++++++++++++----------------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  2 files changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 718525fcadc0..2f03fefa1706 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1007,8 +1007,39 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	if (rc < 0)
>  		goto out_err;
>  
> -	intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
> -		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
> +	/* Figure out the capabilities */
> +	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
> +	if (rc < 0)
> +		goto out_err;
> +
> +	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
> +		intfcaps);
> +	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
> +		dev_dbg(dev, "\tBurst Count Static\n");
> +	if (intfcaps & TPM_INTF_CMD_READY_INT) {
> +		intmask |= TPM_INTF_CMD_READY_INT;
> +		dev_dbg(dev, "\tCommand Ready Int Support\n");
> +	}
> +	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
> +		dev_dbg(dev, "\tInterrupt Edge Falling\n");
> +	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
> +		dev_dbg(dev, "\tInterrupt Edge Rising\n");
> +	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
> +		dev_dbg(dev, "\tInterrupt Level Low\n");
> +	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
> +		dev_dbg(dev, "\tInterrupt Level High\n");
> +	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
> +		intmask |= TPM_INTF_LOCALITY_CHANGE_INT;
> +		dev_dbg(dev, "\tLocality Change Int Support\n");
> +	if (intfcaps & TPM_INTF_STS_VALID_INT) {
> +		intmask |= TPM_INTF_STS_VALID_INT;
> +		dev_dbg(dev, "\tSts Valid Int Support\n");
> +	}
> +	if (intfcaps & TPM_INTF_DATA_AVAIL_INT) {
> +		intmask |= TPM_INTF_DATA_AVAIL_INT;
> +		dev_dbg(dev, "\tData Avail Int Support\n");
> +	}
> +
>  	intmask &= ~TPM_GLOBAL_INT_ENABLE;
>  
>  	rc = request_locality(chip, 0);
> @@ -1042,32 +1073,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
>  
> -	/* Figure out the capabilities */
> -	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
> -	if (rc < 0)
> -		goto out_err;
> -
> -	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
> -		intfcaps);
> -	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
> -		dev_dbg(dev, "\tBurst Count Static\n");
> -	if (intfcaps & TPM_INTF_CMD_READY_INT)
> -		dev_dbg(dev, "\tCommand Ready Int Support\n");
> -	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
> -		dev_dbg(dev, "\tInterrupt Edge Falling\n");
> -	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
> -		dev_dbg(dev, "\tInterrupt Edge Rising\n");
> -	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
> -		dev_dbg(dev, "\tInterrupt Level Low\n");
> -	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
> -		dev_dbg(dev, "\tInterrupt Level High\n");
> -	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
> -		dev_dbg(dev, "\tLocality Change Int Support\n");
> -	if (intfcaps & TPM_INTF_STS_VALID_INT)
> -		dev_dbg(dev, "\tSts Valid Int Support\n");
> -	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
> -		dev_dbg(dev, "\tData Avail Int Support\n");
> -
>  	/* INTERRUPT Setup */
>  	init_waitqueue_head(&priv->read_queue);
>  	init_waitqueue_head(&priv->int_queue);
> @@ -1098,7 +1103,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		else
>  			tpm_tis_probe_irq(chip, intmask);
>  
> -		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> +		if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> +			priv->irqs_in_use = intmask;
> +		} else {
>  			dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
>  
> @@ -1145,13 +1152,7 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
>  	if (rc < 0)
>  		goto out;
>  
> -	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> -		goto out;
> -
> -	intmask |= TPM_INTF_CMD_READY_INT
> -	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
> -	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
> +	intmask = priv->irqs_in_use | TPM_GLOBAL_INT_ENABLE;
>  
>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>  
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 0f29d0b68c3e..8e02faa4079d 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -96,6 +96,7 @@ struct tpm_tis_data {
>  	u16 manufacturer_id;
>  	int locality;
>  	int irq;
> +	unsigned int irqs_in_use;
>  	unsigned long irqtest_flags;
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
> -- 
> 2.36.1
> 

int_mask would be imho a better name.

Can you squash this and the following patch? It's good to slice in
small patches but here I think it would make sense to tie the field
to use case, in order for it to make sense.

BR, Jarkko
