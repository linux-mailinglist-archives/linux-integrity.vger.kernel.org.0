Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB81F4431A1
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhKBP2n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 11:28:43 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:47482 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234599AbhKBP2k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 11:28:40 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 1A2FMgOT005904;
        Tue, 2 Nov 2021 17:22:42 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id E47BB63A1D; Tue,  2 Nov 2021 17:22:53 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v18 6/6] tpm: Add YAML schema for TPM TIS I2C options
Date:   Tue,  2 Nov 2021 17:20:56 +0200
Message-Id: <20211102152056.241769-7-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211102152056.241769-1-amirmizi6@gmail.com>
References: <20211102152056.241769-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Add a YAML schema to support tpm tis i2c related dt-bindings for the I2c
PTP based physical layer.

This patch adds the documentation for corresponding device tree bindings of
I2C based Physical TPM.
Refer to the 'I2C Interface Definition' section in
'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
for specification.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml         | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 0000000..217ba8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+    items:
+      - enum:
+          # Nuvoton's Trusted Platform Module (TPM) (NPCT75x)
+          - nuvoton,npct75x
+      - const: tcg,tpm-tis-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupt:
+    maxItems: 1
+
+  crc-checksum:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set this flag to enable CRC checksum.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      tpm@2e {
+        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+        reg = <0x2e>;
+        crc-checksum;
+      };
+    };
+...
-- 
2.7.4

