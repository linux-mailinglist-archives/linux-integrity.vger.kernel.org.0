Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3851A55C2D
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jun 2019 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFYXVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jun 2019 19:21:48 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36754 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfFYXVr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 19:21:47 -0400
X-Greylist: delayed 2751 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 19:21:42 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x5PMZ85k025279;
        Wed, 26 Jun 2019 01:35:08 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20053)
        id F10B861C4B; Wed, 26 Jun 2019 01:35:07 +0300 (IDT)
From:   Oshri Alkoby <oshrialkoby85@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, oshrialkoby85@gmail.com,
        oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        tomer.maimon@nuvoton.com
Subject: [PATCH v1 1/2] dt-bindings: tpm: add the TPM I2C PTP device tree binding documentation
Date:   Wed, 26 Jun 2019 01:35:02 +0300
Message-Id: <20190625223503.367710-2-oshrialkoby85@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190625223503.367710-1-oshrialkoby85@gmail.com>
References: <20190625223503.367710-1-oshrialkoby85@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Oshri Alkoby <oshrialkoby85@gmail.com>
---
 .../bindings/security/tpm/tpm-i2c-ptp.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt b/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
new file mode 100644
index 000000000000..6bd512f023a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
@@ -0,0 +1,17 @@
+* Device Tree Bindings for I2C PTP based Trusted Platform Module(TPM)
+
+Required properties:
+
+- compatible     : Should be "tcg,tpm_i2c_ptp"
+- reg            : Address on the bus
+- tpm-pirq       : Input gpio pin, used for host interrupts
+
+Example (for Raspberry Pie 3 Board with Nuvoton's NPCT75X (2.0)
+-------------------------------------------------------------------
+
+tpm_i2c_ptp: tpm_i2c_ptp@2e {
+
+	compatible = "tcg,tpm_i2c_ptp";
+	reg = <0x2e>;
+	tpm-pirq = <&gpio 24 GPIO_ACTIVE_HIGH>;
+};
-- 
2.18.0

