Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE427A3EC
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Sep 2020 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI0UGG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 16:06:06 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49090 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgI0UGG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 16:06:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3DF808EE17F;
        Sun, 27 Sep 2020 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601237165;
        bh=lYj/PieHvGAHpFdVHGC4SX6CVGQP9Ew6mOHz2QaaFvA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cv0A4X6rEesN5EBchaB78YUDJDBSAcS4sakPd0KL3aL9X7Xcb6VpH5wFyJEm4kAuR
         Q+fCJtIUXMKdpt9L4fNxqq/QMuCTvf/Un2Y+AytYCn1IGnvhj3qthxit3Y4Dx/SzUt
         icT9/QHkT4Idixvc88QjB/qJRupH1nt/7hlwpF0Y=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mlRbctdbteLJ; Sun, 27 Sep 2020 13:06:05 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 997A38EE012;
        Sun, 27 Sep 2020 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601237164;
        bh=lYj/PieHvGAHpFdVHGC4SX6CVGQP9Ew6mOHz2QaaFvA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EgA5hI80p2sXneRBg3nnAvoyPE2sHJFRCjGT+JNi58hx81QkLqE9bDhr+SXiUyB0R
         gxiYuhpvD/irJfRv4GQdN12llWVXq0wPdh4XSTnUQhOm16uYyPbxrbj1uudAuoQEwt
         N585XiFVWAJtEPyo/bfcEop3PcensudR/xNEDAMY=
Message-ID: <1de642865a142dfbf9d7ef0da398c98d52228943.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/2] tpm: Revert "tpm_tis_core: Turn on the TPM before
 probing IRQ's"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Sun, 27 Sep 2020 13:06:03 -0700
In-Reply-To: <20191126131753.3424363-3-stefanb@linux.vnet.ibm.com>
References: <20191126131753.3424363-1-stefanb@linux.vnet.ibm.com>
         <20191126131753.3424363-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-11-26 at 08:17 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Revert the patch that was turning the TPM on before probing for IRQs.
> 
> Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing
> IRQ's")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/char/tpm/tpm_tis_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c
> b/drivers/char/tpm/tpm_tis_core.c
> index 5dc52c4e2292..27c6ca031e23 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1059,7 +1059,6 @@ int tpm_tis_core_init(struct device *dev,
> struct tpm_tis_data *priv, int irq,
>  			goto out_err;
>  		}
>  
> -		tpm_chip_start(chip);
>  		if (irq) {
>  			tpm_tis_probe_irq_single(chip, intmask,
> IRQF_SHARED,
>  						 irq);
> @@ -1069,7 +1068,6 @@ int tpm_tis_core_init(struct device *dev,
> struct tpm_tis_data *priv, int irq,
>  		} else {
>  			tpm_tis_probe_irq(chip, intmask);
>  		}
> -		tpm_chip_stop(chip);
>  	}
>  
>  	rc = tpm_chip_register(chip);

This patch is completely bogus: it's not a full revert of what it
claims to be.  With this patch applied all my TIS TPMs are returning
0xff to the status reads because the locality hasn't been properly
requested.  The chip has to be started somewhere for the interrupt
probe to work on these TPMs ... what the original patch did was
eliminate a bunch of start/stops for a global one.  However, if the
global one isn't working we should have gone back to the bunch of
smaller ones i.e. a full revert.

The only real manifestation of the problems this patch causes is that
interrupts never get enabled on TIS TPMs that have this issue, but they
still work via polling.

The below is what fixes this for me with the minimum possible extend of
additional chip start/stop in the code.  This should be checked against
the previous failing laptops.

James

---

From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] tpm_tis: fix interrupt probing

When we send a command into the TPM core, the TPM must be started
otherwise the register reads can be bogus.  There have been several
bug reports about doing this inside the TIS core, so fix the issue by
adding an external version of the tpm2_get_tpm_pt() call which adds a
tpm ops get/put to set up the TPM correctly before the command is
sent.

Fixes: aa4a63dd9816 (tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQ's")
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm.h          |  2 ++
 drivers/char/tpm/tpm2-cmd.c     | 30 ++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_tis_core.c |  2 +-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..041b0b5bd2a5 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -223,6 +223,8 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
+ssize_t tpm2_get_tpm_pt_cmd(struct tpm_chip *chip, u32 property_id,
+			    u32 *value, const char *desc);
 
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);
 int tpm2_auto_startup(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index eff1f12d981a..9b84158c5a9e 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -407,6 +407,36 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
 
+/**
+ * tpm2_get_tpm_pt_cmd() - get value of a TPM_CAP_TPM_PROPERTIES type property
+ * @chip:		a &tpm_chip instance
+ * @property_id:	property ID.
+ * @value:		output variable.
+ * @desc:		passed to tpm_transmit_cmd()
+ *
+ * This calls the necessary tpm_try_get_ops()/tpm_put_ops() around
+ * tpm2_get_tpm_pt() and must be called where it is used stand alone
+ * outside the core code.
+ *
+ * Return:
+ *   0 on success,
+ *   -errno or a TPM return code otherwise
+ */
+ssize_t tpm2_get_tpm_pt_cmd(struct tpm_chip *chip, u32 property_id,  u32 *value,
+			    const char *desc)
+{
+	ssize_t rc;
+
+	rc = tpm_try_get_ops(chip);
+	if (rc)
+		return rc;
+	rc = tpm2_get_tpm_pt(chip, property_id, value, desc);
+	tpm_put_ops(chip);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt_cmd);
+
 /**
  * tpm2_shutdown() - send a TPM shutdown command
  *
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 92c51c6cfd1b..6b884badabe7 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -753,7 +753,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
 	cap_t cap;
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
+		return tpm2_get_tpm_pt_cmd(chip, 0x100, &cap2, desc);
 	else
 		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
 				  0);
-- 
2.28.0


