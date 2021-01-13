Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2242F4ADF
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 13:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbhAMMBO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 07:01:14 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:38158 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725771AbhAMMBN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 07:01:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ULcwkx0_1610539221;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0ULcwkx0_1610539221)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Jan 2021 20:00:21 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] tpm/tpm_tis: Fix variable reset during IRQ probing
Date:   Wed, 13 Jan 2021 20:00:21 +0800
Message-Id: <20210113120021.59045-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In tpm_tis_core_init(), tpm2_probe() will be called first, this
function will eventually call tpm_tis_send(), and then
tpm_tis_probe_irq_single() will detect whether the interrupt is
normal, mainly the installation interrupted, set `priv->irq_tested`
to false. The logic will eventually be executed to tpm_tis_send()
to trigger an interrupt.

There is currently such a scenario, which will cause the IRQ probe
code to never be executed, so that the TPM device is in polling
mode: after setting irq_tested to false, an interrupt occurs
between entering the ttpm_tis_send() function, and the interrupt
will be first set irq_tested to true will cause the IRQ probe code
to never be executed.

It seems that this interrupt comes from tpm2_probe(). Although the
interrupt has not been installed when tpm2_probe() is called, the
interrupt of tpm2_probe() is only received after IRQ detection.

This patch solves this issue by introducing a new variable, which
is only used in interrupts, and irq_tested only marks whether the
interrupt test has been completed.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/char/tpm/tpm_tis_core.c | 8 ++++----
 drivers/char/tpm/tpm_tis_core.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 92c51c6cfd1b..d7589b0b3e56 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -502,7 +502,7 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	int rc, irq;
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
-	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
+	if (priv->irq_tested)
 		return tpm_tis_send_main(chip, buf, len);
 
 	/* Verify receipt of the expected IRQ */
@@ -512,9 +512,9 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	rc = tpm_tis_send_main(chip, buf, len);
 	priv->irq = irq;
 	chip->flags |= TPM_CHIP_FLAG_IRQ;
-	if (!priv->irq_tested)
+	if (!priv->int_count)
 		tpm_msleep(1);
-	if (!priv->irq_tested)
+	if (!priv->int_count)
 		disable_interrupts(chip);
 	priv->irq_tested = true;
 	return rc;
@@ -725,7 +725,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 	if (interrupt == 0)
 		return IRQ_NONE;
 
-	priv->irq_tested = true;
+	priv->int_count += 1;
 	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
 		wake_up_interruptible(&priv->read_queue);
 	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 9b2d32a59f67..c6845672f6f7 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -90,6 +90,7 @@ struct tpm_tis_data {
 	int locality;
 	int irq;
 	bool irq_tested;
+	unsigned int int_count;
 	unsigned int flags;
 	void __iomem *ilb_base_addr;
 	u16 clkrun_enabled;
-- 
2.19.1.3.ge56e4f7

