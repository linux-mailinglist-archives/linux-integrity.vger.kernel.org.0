Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0EC2CF8C8
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 02:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgLEBpT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 20:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730941AbgLEBpR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 20:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607132631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+TO2oSaQ81IHJLncB8OI5/1JnLZbRs6jJE1YPlG8SE=;
        b=KieAOJFRFI49vwW1164gymvzk7Y5pFlsKzJ9pzBCAwiljbRLVHbFauf9Q0ARUvgT+cjSau
        1ZSFrx/qXEq4EtjSmq3n/c4chzSBYUE5zpnjsB5TZhVywaICzxpvKA4TVE4umvhhHcghxN
        WuMgXi+cAO3R/t9Dxb1qaLhl8hQ+JcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-AsaoKEgGMOyymeR2UkUFOA-1; Fri, 04 Dec 2020 20:43:47 -0500
X-MC-Unique: AsaoKEgGMOyymeR2UkUFOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 016A6107ACE4;
        Sat,  5 Dec 2020 01:43:46 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-114-119.phx2.redhat.com [10.3.114.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BAC060917;
        Sat,  5 Dec 2020 01:43:45 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/4] tpm_tis: Disable interrupts if interrupt storm detected
Date:   Fri,  4 Dec 2020 18:43:39 -0700
Message-Id: <20201205014340.148235-4-jsnitsel@redhat.com>
In-Reply-To: <20201205014340.148235-1-jsnitsel@redhat.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When enabling the interrupt code for the tpm_tis driver we have
noticed some systems have a bios issue causing an interrupt storm to
occur. The issue isn't limited to a single tpm or system manufacturer
so keeping a denylist of systems with the issue isn't optimal. Instead
try to detect the problem occurring, disable interrupts, and revert to
polling when it happens.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v3: - Change include from linux/kernel_stat.h to linux/irq.h
v2: - drop tpm_tis specific workqueue and use just system_w

drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++++++++++
 drivers/char/tpm/tpm_tis_core.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 92c51c6cfd1b..d817ff5664d1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -24,6 +24,8 @@
 #include <linux/wait.h>
 #include <linux/acpi.h>
 #include <linux/freezer.h>
+#include <linux/workqueue.h>
+#include <linux/irq.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
@@ -715,9 +717,23 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 {
 	struct tpm_chip *chip = dev_id;
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	static bool check_storm = true;
+	static unsigned int check_start;
 	u32 interrupt;
 	int i, rc;
 
+	if (unlikely(check_storm)) {
+		if (!check_start) {
+			check_start = jiffies_to_msecs(jiffies);
+		} else if ((kstat_irqs(priv->irq) > 1000) &&
+			   (jiffies_to_msecs(jiffies) - check_start < 500)) {
+			check_storm = false;
+			schedule_work(&priv->storm_work);
+		} else if (jiffies_to_msecs(jiffies) - check_start >= 500) {
+			check_storm = false;
+		}
+	}
+
 	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
 	if (rc < 0)
 		return IRQ_NONE;
@@ -943,6 +959,14 @@ static const struct tpm_class_ops tpm_tis = {
 	.clk_enable = tpm_tis_clkrun_enable,
 };
 
+static void tpm_tis_storm_work(struct work_struct *work)
+{
+	struct tpm_tis_data *priv = container_of(work, struct tpm_tis_data, storm_work);
+
+	disable_interrupts(priv->chip);
+	dev_warn(&priv->chip->dev, "Interrupt storm detected, using polling.\n");
+}
+
 int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		      const struct tpm_tis_phy_ops *phy_ops,
 		      acpi_handle acpi_dev_handle)
@@ -959,6 +983,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	priv->chip = chip;
+	INIT_WORK(&priv->storm_work, tpm_tis_storm_work);
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 9b2d32a59f67..973297ee2e16 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -95,6 +95,8 @@ struct tpm_tis_data {
 	u16 clkrun_enabled;
 	wait_queue_head_t int_queue;
 	wait_queue_head_t read_queue;
+	struct work_struct storm_work;
+	struct tpm_chip *chip;
 	const struct tpm_tis_phy_ops *phy_ops;
 	unsigned short rng_quality;
 };
-- 
2.27.0

