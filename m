Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0670D48B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 09:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEWHIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 03:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjEWHIS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 03:08:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BDD1AE;
        Tue, 23 May 2023 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684825665; x=1716361665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P4h8ovz3qibeDR+siOiDguBM0Qq8LPdVyV+4yrVzL1Y=;
  b=oJLMbNzrWEarfljw0Gt6qqDEzhi1Fcnh/NPxAR3vmNPO0ckOmCSddRCp
   s12bZ3WL/P+jM4zwaA4E6+TbqoPWXUfnwdSNEaXHJrnJXENJciJp3cxqa
   gnUvw6QpClq8Si65LOAT0AkOO6xHhY9vndEmNmRGZoYhG8d1E/BVzp67c
   TPJX95YCOb+rfI5uUdYZm7BIiWIInxoYTNClLUpcOdZfcJ+1nYCcVZAfY
   Dmvtkbf67H01bGEJLk3MXfEW8+ls6p45Ttdygl1i5ObL1gyw+P5s6FvAa
   cN3bi9rgpnNrACPffAulhHCSN+XMMsCPjamwliLmfigdX5s7y01zkM07M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="353182080"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="353182080"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 00:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="697946264"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="697946264"
Received: from nmkenne1-mobl2.ger.corp.intel.com (HELO [10.252.53.154]) ([10.252.53.154])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 00:07:40 -0700
Message-ID: <d753c02d-38ab-3061-c410-9ef979fe09f1@linux.intel.com>
Date:   Tue, 23 May 2023 10:08:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] tpm, tpm_tis: reuse code in disable_interrupts()
Content-Language: en-US
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <20230522143105.8617-2-LinoSanfilippo@gmx.de>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230522143105.8617-2-LinoSanfilippo@gmx.de>
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
> Avoid code redundancy by shifting part of the code in disable_interrupts()
> into a subfunction and reusing this function in tpm_tis_handle_irq_storm().
> Make sure that in the subfunction the INT_ENABLE register is written with a
> claimed locality even if the caller did not claim it before.
> 
> In the shifted code get rid of the variable "rc" by initializing the
> interrupt mask to zero at variable declaration.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 36 ++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 458ebf8c2f16..8f4f2cb5520f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -468,25 +468,32 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	return rc;
>  }
>  
> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	u32 intmask = 0;
> +
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> +
> +	tpm_tis_request_locality(chip, 0);
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	tpm_tis_relinquish_locality(chip, 0);
> +
> +	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +}
> +
>  static void disable_interrupts(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	u32 intmask;
> -	int rc;
>  
>  	if (priv->irq == 0)
>  		return;
>  
> -	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> -		intmask = 0;
> -
> -	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> -	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	__tpm_tis_disable_interrupts(chip);
>  
>  	devm_free_irq(chip->dev.parent, priv->irq, chip);
>  	priv->irq = 0;
> -	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>  }
>  
>  /*
> @@ -755,20 +762,11 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>  static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	int intmask = 0;
>  
>  	dev_err(&chip->dev, HW_ERR
>  		"TPM interrupt storm detected, polling instead\n");
>  
> -	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -
> -	intmask &= ~TPM_GLOBAL_INT_ENABLE;
> -
> -	tpm_tis_request_locality(chip, 0);
> -	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> -	tpm_tis_relinquish_locality(chip, 0);
> -
> -	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +	__tpm_tis_disable_interrupts(chip);
>  
>  	/*
>  	 * We must not call devm_free_irq() from within the interrupt handler,

-- 
Péter
