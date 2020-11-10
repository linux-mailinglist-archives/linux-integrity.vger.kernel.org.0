Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9BD2ACD19
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Nov 2020 04:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbgKJD7p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Nov 2020 22:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387474AbgKJD4I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Nov 2020 22:56:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428CF20870;
        Tue, 10 Nov 2020 03:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604980568;
        bh=VA5SZyo0Z8SFLkqcGfxNL8fP++Eeshs2aTA2ESgMpzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bC7iuFI0JqDW75vQRU6DMstrpNpZSAIqht5mdSVn7v3PE+k9icC+ntysmOIISx1u
         fpcwhjjJ0glGuRT7/wCV4Y7VSiNUY9ZoNu1Bx4cFVQSiPpF4RsKVdzFFYkfy6kBb/q
         Q/GCk35STLQOtDRKFqROTZpqDpZKsmrW3eYM7qkY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/21] tpm_tis: Disable interrupts on ThinkPad T490s
Date:   Mon,  9 Nov 2020 22:55:40 -0500
Message-Id: <20201110035541.424648-20-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035541.424648-1-sashal@kernel.org>
References: <20201110035541.424648-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

[ Upstream commit b154ce11ead925de6a94feb3b0317fafeefa0ebc ]

There is a misconfiguration in the bios of the gpio pin used for the
interrupt in the T490s. When interrupts are enabled in the tpm_tis
driver code this results in an interrupt storm. This was initially
reported when we attempted to enable the interrupt code in the tpm_tis
driver, which previously wasn't setting a flag to enable it. Due to
the reports of the interrupt storm that code was reverted and we went back
to polling instead of using interrupts. Now that we know the T490s problem
is a firmware issue, add code to check if the system is a T490s and
disable interrupts if that is the case. This will allow us to enable
interrupts for everyone else. If the user has a fixed bios they can
force the enabling of interrupts with tpm_tis.interrupts=1 on the
kernel command line.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index f08949a5f6785..5a3a4f0953910 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/kernel.h>
+#include <linux/dmi.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
@@ -53,8 +54,8 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_tcg_phy, priv);
 }
 
-static bool interrupts = true;
-module_param(interrupts, bool, 0444);
+static int interrupts = -1;
+module_param(interrupts, int, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
 
 static bool itpm;
@@ -67,6 +68,28 @@ module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
 #endif
 
+static int tpm_tis_disable_irq(const struct dmi_system_id *d)
+{
+	if (interrupts == -1) {
+		pr_notice("tpm_tis: %s detected: disabling interrupts.\n", d->ident);
+		interrupts = 0;
+	}
+
+	return 0;
+}
+
+static const struct dmi_system_id tpm_tis_dmi_table[] = {
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkPad T490s",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
+		},
+	},
+	{}
+};
+
 #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
 static int has_hid(struct acpi_device *dev, const char *hid)
 {
@@ -196,6 +219,8 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 	int irq = -1;
 	int rc;
 
+	dmi_check_system(tpm_tis_dmi_table);
+
 	rc = check_acpi_tpm2(dev);
 	if (rc)
 		return rc;
-- 
2.27.0

