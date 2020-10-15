Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4297C28FAC7
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgJOVom (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Oct 2020 17:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729254AbgJOVoj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Oct 2020 17:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602798278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mpuNHZgzNVhYq85pnOEXEuCpteLYCDH+aPUQTLrccAI=;
        b=XhWh0F9mqU1dwqcmQBkLEOKaCsr2E8EbSvQmrwaCSW0FpVXKQq2aOOz8je/0tCsFYDdxkI
        NNb0KfYKZezApqEZBCxHhWvX7i5Ot4e+aRTNum2biXMp/2M3KYu1W+JksmVEWTbhX/JdQo
        FE9hGaXlPQkSUjE/Lr7RKkMGFnOXXyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-Ftts9uMfPl-YR3YS8Fd97A-1; Thu, 15 Oct 2020 17:44:35 -0400
X-MC-Unique: Ftts9uMfPl-YR3YS8Fd97A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3D34186841C;
        Thu, 15 Oct 2020 21:44:33 +0000 (UTC)
Received: from jsnitsel.users.ipa.redhat.com (ovpn-112-224.phx2.redhat.com [10.3.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F009176649;
        Thu, 15 Oct 2020 21:44:32 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jarkko@kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hans de Goede <hdegoede@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
Date:   Thu, 15 Oct 2020 14:44:30 -0700
Message-Id: <20201015214430.17937-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

Cc: jarkko@kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 0b214963539d..4ed6e660273a 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/kernel.h>
+#include <linux/dmi.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
 
@@ -49,8 +50,8 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_tcg_phy, priv);
 }
 
-static bool interrupts = true;
-module_param(interrupts, bool, 0444);
+static int interrupts = -1;
+module_param(interrupts, int, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
 
 static bool itpm;
@@ -63,6 +64,28 @@ module_param(force, bool, 0444);
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
@@ -192,6 +215,8 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 	int irq = -1;
 	int rc;
 
+	dmi_check_system(tpm_tis_dmi_table);
+
 	rc = check_acpi_tpm2(dev);
 	if (rc)
 		return rc;
-- 
2.28.0

