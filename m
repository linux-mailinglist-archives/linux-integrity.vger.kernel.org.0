Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB2371879
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhECPx2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 11:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhECPxZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 11:53:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 772DB611AB;
        Mon,  3 May 2021 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620057151;
        bh=0FOzX6F3EPFvxCwzzbqt+hOdd4POhkQYcLJcCvjSKDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9H1ZIOS/kZyHN71BivA/Kf5l7LO+jE3AEST5ToIppiajzC7Qa3KRJ4bJbX3SKcLR
         WJp5yXz+w5M6TGBEYSiXA0SNrhn8awdEMV/KnPn5qai5jRAL34cVMNAyi34qUxohdC
         vKTiEMwOn0v3V8hXv5uN5a9yLJz6rW5IhM9u2RtsfbWORqXYSV4h6stmTBi+6pMkxr
         3L3/QzopaM2/x8HxV3aZQ9k6/+msWdn3/fMv3pGMjnryUHGQLHLkDVmmGcE4+Ro938
         2U9DoADFhw/isHpawSIiJ7gsrDGEgYQRtJTkCLSgq03Kdf+C/CPt9YghwRmijRZJNY
         u2OudXgIwTFzA==
Date:   Mon, 3 May 2021 18:52:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] tpm: Fix test for interrupts
Message-ID: <YJAcPAbFopeW7PYs@kernel.org>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-4-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501135727.17747-4-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 01, 2021 at 03:57:26PM +0200, Lino Sanfilippo wrote:
> The current test for functional interrupts is broken in multiple ways:
> 1. The needed flag TPM_CHIP_FLAG_IRQ is never set, so the test is never
> executed.
> 2. The test includes the check for two variables and the check is done for
> each transmission which is unnecessarily complicated.

Unnecessary complicated is again terminolgy that I don't decipher,
unfortunately. I get "something that works" or "has a regression".
We don't polish things for nothing.

> 3. Part of the test is setting a bool variable in an interrupt handler and
> then check the value in the main thread. However there is nothing that
> guarantees the visibility of the value set in the interrupt handler for
> any other thread. Some kind of synchronization primitive is required for this purpose.
> 
> Fix all these issues by a reimplementation:
> Instead of doing the test in tpm_tis_send() which is called for each
> transmission do it only once in tpm_tis_probe_irq_single(). Furthermore
> use proper accessor functions like get_bit()/set_bit() which include the
> required synchronization primitives to guarantee visibility between the
> interrupt handler and threads.
> Finally remove one function which is no longer needed.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Not sure why to take this patch.

> ---
>  drivers/char/tpm/tpm_tis_core.c | 61 ++++++++++-----------------------
>  drivers/char/tpm/tpm_tis_core.h |  1 -
>  include/linux/tpm.h             |  2 +-
>  3 files changed, 20 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index f892b1ae46f2..9615234054aa 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -420,7 +420,7 @@ static void disable_interrupts(struct tpm_chip *chip)
>   * tpm.c can skip polling for the data to be available as the interrupt is
>   * waited for here
>   */
> -static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> +static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int rc;
> @@ -453,29 +453,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	return rc;
>  }
>  
> -static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
> -{
> -	int rc, irq;
> -	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
> -		return tpm_tis_send_main(chip, buf, len);
> -
> -	/* Verify receipt of the expected IRQ */
> -	irq = priv->irq;
> -	priv->irq = 0;
> -	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> -	rc = tpm_tis_send_main(chip, buf, len);
> -	priv->irq = irq;
> -	chip->flags |= TPM_CHIP_FLAG_IRQ;
> -	if (!priv->irq_tested)
> -		tpm_msleep(1);
> -	if (!priv->irq_tested)
> -		disable_interrupts(chip);
> -	priv->irq_tested = true;
> -	return rc;
> -}
> -
>  struct tis_vendor_durations_override {
>  	u32 did_vid;
>  	struct tpm1_version version;
> @@ -677,7 +654,8 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	if (interrupt == 0)
>  		return IRQ_NONE;
>  
> -	priv->irq_tested = true;
> +	set_bit(TPM_CHIP_FLAG_IRQ, &chip->flags);
> +
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>  		wake_up_interruptible(&priv->read_queue);
>  	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> @@ -734,45 +712,44 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	}
>  	priv->irq = irq;
>  
> +	clear_bit(TPM_CHIP_FLAG_IRQ, &chip->flags);
> +
>  	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>  			   &original_int_vec);
>  	if (rc < 0)
> -		return rc;
> +		goto out;
>  
>  	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>  	if (rc < 0)
> -		return rc;
> +		goto out;
>  
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
>  	if (rc < 0)
> -		return rc;
> +		goto out;
>  
>  	/* Clear all existing */
>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
>  	if (rc < 0)
> -		return rc;
> +		goto out;
>  
>  	/* Turn on */
>  	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>  			     intmask | TPM_GLOBAL_INT_ENABLE);
>  	if (rc < 0)
> -		return rc;
> -
> -	priv->irq_tested = false;
> +		goto out;
>  
> -	/* Generate an interrupt by having the core call through to
> -	 * tpm_tis_send
> -	 */
> +	/* Generate an interrupt by transmitting a command to the chip */
>  	rc = tpm_tis_gen_interrupt(chip);
>  	if (rc < 0)
> -		return rc;
> +		goto out;
> +
> +	tpm_msleep(1);
> +out:
> +	if (!test_bit(TPM_CHIP_FLAG_IRQ, &chip->flags)) {
> +		disable_interrupts(chip);
>  
> -	/* tpm_tis_send will either confirm the interrupt is working or it
> -	 * will call disable_irq which undoes all of the above.
> -	 */
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>  		rc = tpm_tis_write8(priv, original_int_vec,
> -				TPM_INT_VECTOR(priv->locality));
> +				    TPM_INT_VECTOR(priv->locality));
>  		if (rc < 0)
>  			return rc;
>  
> @@ -1039,7 +1016,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		if (irq) {
>  			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>  						 irq);
> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> +			if (!test_bit(TPM_CHIP_FLAG_IRQ, &chip->flags)) {
>  				dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
>  
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 9b2d32a59f67..dc5f92b18dca 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,7 +89,6 @@ struct tpm_tis_data {
>  	u16 manufacturer_id;
>  	int locality;
>  	int irq;
> -	bool irq_tested;
>  	unsigned int flags;
>  	void __iomem *ilb_base_addr;
>  	u16 clkrun_enabled;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 7a68832b14bb..c57d0f0395f0 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -133,7 +133,7 @@ struct tpm_chip {
>  	struct tpm_chip_seqops bin_log_seqops;
>  	struct tpm_chip_seqops ascii_log_seqops;
>  
> -	unsigned int flags;
> +	unsigned long flags;
>  
>  	int dev_num;		/* /dev/tpm# */
>  	unsigned long is_open;	/* only one allowed */
> -- 
> 2.31.1
> 

/Jarkko
