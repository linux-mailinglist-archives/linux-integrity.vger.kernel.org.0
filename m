Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8E2C9578
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 04:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgLAC7j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 21:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726923AbgLAC7i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 21:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606791492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxkTXZyAiIYzqxHIYeZdFwHfkIFnjh3lzejgigCLCGk=;
        b=JAwh1R35mXa7wbLCi9E+/on5KHYNwh0Av4xf9xGimC47clUYItQpuB1+Df1AamIhBPe0Za
        H6+b7ogUU4AF/KnTs+TlimXDld0MiXz20rJijoFnFjsXASMXnE37foRQMKcoCuVRhYLuoo
        ghNpJOE+gJA9lAzjyWFkGE8NodNu6es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-zfU2AHezPsu38QNkPwUoQw-1; Mon, 30 Nov 2020 21:58:10 -0500
X-MC-Unique: zfU2AHezPsu38QNkPwUoQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C033E74B;
        Tue,  1 Dec 2020 02:58:09 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-115-84.phx2.redhat.com [10.3.115.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8896F5D9C0;
        Tue,  1 Dec 2020 02:58:08 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm detected
Date:   Mon, 30 Nov 2020 19:58:07 -0700
Message-Id: <20201201025807.162241-1-jsnitsel@redhat.com>
In-Reply-To: <20201130232338.106892-1-jsnitsel@redhat.com>
References: <20201130232338.106892-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
v2: drop tpm_tis specific workqueue and use just system_wq

drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++++++++++
 drivers/char/tpm/tpm_tis_core.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 23b60583928b..72cc8a5a152c 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -24,6 +24,8 @@
 #include <linux/wait.h>
 #include <linux/acpi.h>
 #include <linux/freezer.h>
+#include <linux/workqueue.h>
+#include <linux/kernel_stat.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
@@ -745,9 +747,23 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
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
@@ -987,6 +1003,14 @@ static const struct tpm_class_ops tpm_tis = {
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
@@ -1003,6 +1027,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	priv->chip = chip;
+	INIT_WORK(&priv->storm_work, tpm_tis_storm_work);
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index edeb5dc61c95..5630f294dc0c 100644
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

