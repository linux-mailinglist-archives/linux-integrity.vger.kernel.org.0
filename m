Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B359E87
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfF1POI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jun 2019 11:14:08 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:37009 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726880AbfF1POI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jun 2019 11:14:08 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x5SFDURE004544;
        Fri, 28 Jun 2019 18:13:30 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20053)
        id 5D2E061FCD; Fri, 28 Jun 2019 18:13:30 +0300 (IDT)
From:   Oshri Alkoby <oshrialkoby85@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, oshrialkoby85@gmail.com,
        oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        dan.morav@nuvoton.com, tomer.maimon@nuvoton.com
Subject: [PATCH v2 1/2] dt-bindings: tpm: add the TPM I2C PTP device tree binding documentation
Date:   Fri, 28 Jun 2019 18:13:26 +0300
Message-Id: <20190628151327.206818-2-oshrialkoby85@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190628151327.206818-1-oshrialkoby85@gmail.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Oshri Alkoby <oshrialkoby85@gmail.com>
---
 .../bindings/security/tpm/tpm-i2c-ptp.txt     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt b/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
new file mode 100644
index 000000000000..8b0207fdf3e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
@@ -0,0 +1,24 @@
+* Device Tree Bindings for I2C PTP based Trusted Platform Module(TPM)
+
+The TCG defines a hardware protocol, registers and interface (based
+on the TPM Interface Specification) for accessing TPM devices
+implemented with an I2C interface.
+
+Refer to the 'I2C Interface Definition' section in 'TCG PC Client
+PlatformTPMProfile(PTP) Specification' publication for specification.
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

