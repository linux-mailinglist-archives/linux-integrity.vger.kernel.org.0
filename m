Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09D6EFA89
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjDZS7D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Apr 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjDZS7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Apr 2023 14:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA143C28;
        Wed, 26 Apr 2023 11:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769D363845;
        Wed, 26 Apr 2023 18:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55317C433EF;
        Wed, 26 Apr 2023 18:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682535519;
        bh=lCHPNUXMHsaIKajjyxQt1zXitlVWSvdFMaRn9VcrNO8=;
        h=From:To:Cc:Subject:Date:From;
        b=fHfF5CXHaKUKaXykNS6ee/krSyPz0kskh8/udLZPP0Tha18WWgyaJwXUVbOWmi9RN
         QjyxYBc7IrtfqDJczDr8FKgZWSz1I9MLPIxuOAroj66HuqmB/tv0fwnHuvwhyklVve
         Ryq0wLPxRMe7O+18US6fECNq1Bst2lvWZW+NIX3PVvHDBCgmq5wNorAcXfxrAKhLjG
         wQ2ClH0hZuJ+3Wwk7I7TlV8IUXCTcNbEiQAahvOB+fRGqGf5q3XjCJ9aK5nVbHwhZ6
         QwhoTgIG8/YYNPJNZS6uLDk/8g/nHiC1bmdGvh3f/kwRuUVfsO/ew+a2xcmY5F0tNo
         ncbKFn3YsXOnQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH] tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers
Date:   Wed, 26 Apr 2023 21:58:33 +0300
Message-Id: <20230426185833.289868-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM chip bootstrapping was removed from tpm_chip_register(), and it
was relocated to tpm_tis_core. This breaks all drivers which are not
based on tpm_tis because the chip will not get properly initialized.

Take the corrective steps:
1. Rename tpm_chip_startup() as tpm_chip_bootstrap() and make it one-shot.
2. Call tpm_chip_bootstrap() in tpm_chip_register(), which reverts the
   things  as tehy used to be.

Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/all/ZEjqhwHWBnxcaRV5@xpf.sh.intel.com/
Fixes: 548eb516ec0f ("tpm, tpm_tis: startup chip before testing for interrupts")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c     | 22 +++++++++++++++++++---
 drivers/char/tpm/tpm.h          |  2 +-
 drivers/char/tpm/tpm_tis_core.c |  2 +-
 include/linux/tpm.h             | 13 +++++++------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 6fdfa65a00c3..b8a484b4ff7a 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -606,13 +606,19 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
 }
 
 /*
- * tpm_chip_startup() - performs auto startup and allocates the PCRs
+ * tpm_chip_bootstrap() - Boostrap TPM chip after power on
  * @chip: TPM chip to use.
+ *
+ * Initialize TPM chip after power on. This a one-shot function: subsequent
+ * calls will have no effect.
  */
-int tpm_chip_startup(struct tpm_chip *chip)
+int tpm_chip_bootstrap(struct tpm_chip *chip)
 {
 	int rc;
 
+	if (chip->flags & TPM_CHIP_FLAG_BOOTSTRAP)
+		return 0;
+
 	rc = tpm_chip_start(chip);
 	if (rc)
 		return rc;
@@ -625,9 +631,15 @@ int tpm_chip_startup(struct tpm_chip *chip)
 stop:
 	tpm_chip_stop(chip);
 
+	/*
+	 * Unconditionally set, as driver initialization should cease, when the
+	 * boostrapping process fails.
+	 */
+	chip->flags |= TPM_CHIP_FLAG_BOOTSTRAP;
+
 	return rc;
 }
-EXPORT_SYMBOL_GPL(tpm_chip_startup);
+EXPORT_SYMBOL_GPL(tpm_chip_bootstrap);
 
 /*
  * tpm_chip_register() - create a character device for the TPM chip
@@ -644,6 +656,10 @@ int tpm_chip_register(struct tpm_chip *chip)
 {
 	int rc;
 
+	rc = tpm_chip_bootstrap(chip);
+	if (rc)
+		return rc;
+
 	tpm_sysfs_add_device(chip);
 
 	tpm_bios_log_setup(chip);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 88d3bd76e076..f6c99b3f0045 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -263,7 +263,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 		     delay_msec * 1000);
 };
 
-int tpm_chip_startup(struct tpm_chip *chip);
+int tpm_chip_bootstrap(struct tpm_chip *chip);
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c2421162cf34..02945d53fcef 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1139,7 +1139,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	init_waitqueue_head(&priv->read_queue);
 	init_waitqueue_head(&priv->int_queue);
 
-	rc = tpm_chip_startup(chip);
+	rc = tpm_chip_bootstrap(chip);
 	if (rc)
 		goto out_err;
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4dc97b9f65fb..50bcdee19b12 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -274,13 +274,14 @@ enum tpm2_cc_attrs {
 #define TPM_VID_ATML     0x1114
 
 enum tpm_chip_flags {
-	TPM_CHIP_FLAG_TPM2		= BIT(1),
-	TPM_CHIP_FLAG_IRQ		= BIT(2),
-	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
-	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
-	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
+	TPM_CHIP_FLAG_TPM2			= BIT(1),
+	TPM_CHIP_FLAG_IRQ			= BIT(2),
+	TPM_CHIP_FLAG_VIRTUAL			= BIT(3),
+	TPM_CHIP_FLAG_HAVE_TIMEOUTS		= BIT(4),
+	TPM_CHIP_FLAG_ALWAYS_POWERED		= BIT(5),
 	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
-	TPM_CHIP_FLAG_FIRMWARE_UPGRADE	= BIT(7),
+	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
+	TPM_CHIP_FLAG_BOOTSTRAP			= BIT(8),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.39.2

