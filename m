Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8495A340E40
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Mar 2021 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhCRT36 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Mar 2021 15:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232623AbhCRT3h (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Mar 2021 15:29:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F0A664ED2;
        Thu, 18 Mar 2021 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616095776;
        bh=/bzwmHwk512quds2BBT7yCyX/ag7eV9iPnbC4bG0xOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lppo5g5qKorg4t2p3ZTvSk1WC3bN57/wGjACHadyO9DWkYP2Rp1ce/Z701vp3IcJX
         TsXLbbdDmZncR0R9XM7Nl050SHdw80lT/N6upBChupjFPtoHBm99RYCQzEqBsy45m3
         SskZBi1JhBlmlnN+rk7g3q0IzGe01Wcns+lpdJEnLMDbdhB/OBhjcXFASVzmIuUhx5
         pissioyMDMliwSSihkl+4hzmrbVIXWhkc70wr2SAb7zoVqxIlB1NIRIecMogiTkZ2E
         Q8aXCdtjqISxEFec/5nUXq/1AW1ufd7SQxhJryVfCMR1OVaPCCOD0f/LG3d2/dY0hG
         gazZZt4txrdBw==
Date:   Thu, 18 Mar 2021 21:29:10 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] char: tpm: move to use request_irq by IRQF_NO_AUTOEN
 flag
Message-ID: <YFOqBikw4HrfyzGE@kernel.org>
References: <1616036065-53621-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616036065-53621-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 18, 2021 at 10:54:25AM +0800, Tian Tao wrote:
> disable_irq() after request_irq() still has a time gap in which
> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> disable IRQ auto-enable because of requesting.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Link: https://lore.kernel.org/patchwork/patch/1388765/
> 
> v2: add the Link.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index ec9a65e..25299e5 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -705,14 +705,14 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client,
>  
>  	if (client->irq > 0) {
>  		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
> -				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
> +				      IRQF_NO_AUTOEN,
>  				      dev->driver->name, chip);
>  		if (rc < 0) {
>  			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
>  			return rc;
>  		}
>  
> -		disable_irq(client->irq);
>  		priv->irq = client->irq;
>  	} else {
>  		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
> -- 
> 2.7.4
> 
> 
