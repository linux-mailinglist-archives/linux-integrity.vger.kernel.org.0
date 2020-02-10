Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B891580BF
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBJRKF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 12:10:05 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36755 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727536AbgBJRKE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 12:10:04 -0500
X-Greylist: delayed 2425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 12:09:57 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 01AGT8JK011300;
        Mon, 10 Feb 2020 18:29:08 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 820EB6032E; Mon, 10 Feb 2020 18:29:08 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v3 6/7] dt-bindings: tpm: Add YAML schema for TPM TIS I2C options
Date:   Mon, 10 Feb 2020 18:28:37 +0200
Message-Id: <20200210162838.173903-7-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200210162838.173903-1-amirmizi6@gmail.com>
References: <20200210162838.173903-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Added a YAML schema to support tpm tis i2c realted dt-bindings for the I2c
 PTP based physical layer.

This patch adds the documentation for corresponding device tree bindings of
 I2C based Physical TPM.
Refer to the 'I2C Interface Definition' section in
 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
 for specification.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml         | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 0000000..ca16b59
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C PTP based TPM Device Tree Bindings
+
+maintainers:
+  - Amir Mizinski <amirmizi6@gmail.com>
+
+description:
+  Device Tree Bindings for I2C based Trusted Platform Module(TPM).
+
+properties:
+  compatible:
+    contains:
+      const: tcg,tpm-tis-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  crc-checksum:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      CRC checksum enable.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    tpm-tis-i2c: tpm-tis-i2c@2e {
+       compatible = "tcg,tpm-tis-i2c";
+       reg = <0x2e>;
+       interrupts = <&gpio 24 GPIO_ACTIVE_HIGH>;
+       crc-checksum;
+    };
-- 
2.7.4

