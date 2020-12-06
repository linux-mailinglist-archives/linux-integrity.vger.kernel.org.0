Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB32D06DF
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Dec 2020 20:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgLFT1A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 14:27:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgLFT1A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 14:27:00 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607282777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2Be4+YLW5TxokiaWwRdxVmQKFAAEtdJ0Q9wRx1ZJQ8=;
        b=t5tWucw/RvIGvw13Gc7uPVvU7w8ChXXet2quzmvsNd/DCHRv5dkF4HaD4cBIqG9clHqwHP
        0pOk8DxSWNx4T6GfxzenLhkpDjv7NyTVKKbRV3OWhJzlLaoZD5YLZK9cibst+usGyNIcOT
        gvcGThs1f2jb5xvVrjnPkX5p8n7d93I2xflY6Cs4stDDwBDt0YKTlTtQOMMfgVEqSq1fyB
        joFBUtxCDjPCutuw61xSkfpLfbjyWnN/bwWosozf3w7+uxLNWC9/W/mQBMGi286+TNXuGJ
        gEok3Gu6qEcU7dHxW7NgDG77F4Pp36E4h/VI6HyV7QlXQx1ct2RdoohSY75weA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607282777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2Be4+YLW5TxokiaWwRdxVmQKFAAEtdJ0Q9wRx1ZJQ8=;
        b=cnf8atbjZ5DVmOTUpR0MSx2vL4sCcAKpvbP5dtywuTaDNVkXumZS/N24iJCK1SCwtfyGTx
        UfRedPYkRfVj78BQ==
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] tpm_tis: Disable interrupts if interrupt storm detected
In-Reply-To: <20201205014340.148235-4-jsnitsel@redhat.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-4-jsnitsel@redhat.com>
Date:   Sun, 06 Dec 2020 20:26:16 +0100
Message-ID: <87tusy7n3b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jerry,

On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:
> @@ -715,9 +717,23 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  {
>  	struct tpm_chip *chip = dev_id;
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	static bool check_storm = true;
> +	static unsigned int check_start;

So this assumes that there can't be two TPMs which is probably true, but
everything else in this driver has stuff in tpm_tis_data per device.

>  	u32 interrupt;
>  	int i, rc;
>  
> +	if (unlikely(check_storm)) {
> +		if (!check_start) {
> +			check_start = jiffies_to_msecs(jiffies);

Yuck. I had to read that twice to figure out that it's correct vs. the
truncation of the result to unsigned int. You can spare that conversion
by simply doing

   unsigned long end_of_check = jiffies + HZ / 2;

and then the check becomes

    time_before(jiffies, end_of_check)

> +		} else if ((kstat_irqs(priv->irq) > 1000) &&
> +			   (jiffies_to_msecs(jiffies) - check_start < 500)) {

I assume you can't call disable_irq_nosync() here, but shouldn't this
shut up the interrupt at the TPM level right here?

> +			check_storm = false;
> +			schedule_work(&priv->storm_work);
> +		} else if (jiffies_to_msecs(jiffies) - check_start >= 500) {
> +			check_storm = false;
> +		}
> +	}

So back to kstat_irqs(). As this needs two extra variables anyway:

init()
	priv->irq_check = 1;
	priv->end_check = 0;

isr()
	if (unlikely(priv->irq_check)) {
		if (!priv->end_check) {
			priv->end_check = jiffies + HZ / 2;
		} else if (time_before(jiffies, priv->end_check)) {
			if (priv->irq_check++ > 1000)
				schedule_work(...);
		} else {
			priv->irq_check = 0;
		}
	}

Hmm? I still need to see an argument for an kstat_irqs() export being
superior.

Though I wonder whether such an infrastructure should be provided in the
irq core. Let me think about it.

Just as a side note. I was looking at tpm_tis_probe_irq_single() and
that function is leaking the interrupt request if any of the checks
afterwards fails, except for the final interrupt probe check which does
a cleanup. That means on fail before that the interrupt handler stays
requested up to the point where the module is removed. If that's a
shared interrupt and some other device is active on the same line, then
each interrupt from that device will call into the TPM code. Something
like the below is needed.

Also the X86 autoprobe mechanism is interesting:

	if (IS_ENABLED(CONFIG_X86))
		for (i = 3; i <= 15; i++)
			if (!tpm_tis_probe_irq_single(chip, intmask, 0, i))
				return;

The third argument is 'flags' which is handed to request_irq(). So that
won't ever be able to probe a shared interrupt. But if an interrupt
number > 0 is handed to tpm_tis_core_init() the interrupt is requested
with IRQF_SHARED. Same issue when the chip has an interrupt number in
the register. It's also requested exclusive which is pretty likely
to fail on ancient x86 machines.

The vast amount of comments didn't help to figure out what the reasoning
is.

Thanks,

        tglx
---
 drivers/char/tpm/tpm_tis_core.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -782,26 +782,26 @@ static int tpm_tis_probe_irq_single(stru
 	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
 			   &original_int_vec);
 	if (rc < 0)
-		return rc;
+		goto fail;
 
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
 	if (rc < 0)
-		return rc;
+		goto fail;
 
 	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
 	if (rc < 0)
-		return rc;
+		goto fail;
 
 	/* Clear all existing */
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
 	if (rc < 0)
-		return rc;
+		goto fail;
 
 	/* Turn on */
 	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
 			     intmask | TPM_GLOBAL_INT_ENABLE);
 	if (rc < 0)
-		return rc;
+		goto fail;
 
 	priv->irq_tested = false;
 
@@ -825,6 +825,10 @@ static int tpm_tis_probe_irq_single(stru
 	}
 
 	return 0;
+
+fail:
+	disable_interrupts(chip);
+	return rc;
 }
 
 /* Try to find the IRQ the TPM is using. This is for legacy x86 systems that
