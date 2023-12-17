Return-Path: <linux-integrity+bounces-521-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05C815E93
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 11:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473351F220BB
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 10:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8656FAB;
	Sun, 17 Dec 2023 10:48:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132C6FA5;
	Sun, 17 Dec 2023 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 1ED51101E6B41;
	Sun, 17 Dec 2023 11:38:31 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id C72D26073EFF;
	Sun, 17 Dec 2023 11:38:30 +0100 (CET)
X-Mailbox-Line: From 52635205818ab201cacb0c0f37c7fa48149c7f8e Mon Sep 17 00:00:00 2001
Message-Id: <52635205818ab201cacb0c0f37c7fa48149c7f8e.1702806810.git.lukas@wunner.de>
In-Reply-To: <cover.1702806810.git.lukas@wunner.de>
References: <cover.1702806810.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 17 Dec 2023 11:13:32 +0100
Subject: [PATCH v3 2/4] dt-bindings: tpm: Convert Google Cr50 bindings to DT
 schema
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Nayna Jain <nayna@linux.ibm.com>, Thirupathaiah Annapureddy <thiruan@microsoft.com>, Sasha Levin <sashal@kernel.org>, Andrey Pronin <apronin@chromium.org>, Alexander Steffen <Alexander.Steffen@infineon.com>, Johannes Holland <Johannes.Holland@infineon.com>, Amir Mizinski <amirmizi6@gmail.com>, Benoit HOUYERE <benoit.houyere@st.com>, Peter Delevoryas <peter@pjd.dev>, Ninad Palsule <ninad@linux.ibm.com>, Guenter Roeck <linux@roeck-us.net>, Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>

Convert the devicetree bindings for the Google Security Chip H1 running
Cr50 firmware to DT schema.

The chip can be attached to SPI or I²C.  Existing devicetrees use the
same "google,cr50" compatible string for both cases without additionally
specifying a generic "tcg,tpm_tis-spi" or "tcg,tpm-tis-i2c" compatible.

The chip therefore cannot be documented in the tcg,tpm_tis-spi.yaml and
tcg,tpm-tis-i2c.yaml schemas:  The validator would select both of them
and complain about SPI properties when the chip is an I²C peripheral.

So document the chip in a schema of its own which includes both, SPI and
I²C properties by reference.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v2 -> v3:
  * Introduce new schema specifically for google,cr50 (Rob).
    Note that I can't use "oneOf" for SPI and I²C properties
    because a node with only a "reg" property is a valid SPI
    and I²C node and would match both subschemas.
    So "anyOf" it is.

 .../bindings/security/tpm/google,cr50.txt     | 19 ------
 .../devicetree/bindings/tpm/google,cr50.yaml  | 65 +++++++++++++++++++
 2 files changed, 65 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 Documentation/devicetree/bindings/tpm/google,cr50.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
deleted file mode 100644
index cd69c2efdd37..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
-
-H1 Secure Microcontroller running Cr50 firmware provides several
-functions, including TPM-like functionality. It communicates over
-SPI using the FIFO protocol described in the PTP Spec, section 6.
-
-Required properties:
-- compatible: Should be "google,cr50".
-- spi-max-frequency: Maximum SPI frequency.
-
-Example:
-
-&spi0 {
-	tpm@0 {
-		compatible = "google,cr50";
-		reg = <0>;
-		spi-max-frequency = <800000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/tpm/google,cr50.yaml b/Documentation/devicetree/bindings/tpm/google,cr50.yaml
new file mode 100644
index 000000000000..9302e12e9fc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/google,cr50.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Security Chip H1 (running Cr50 firmware)
+
+maintainers:
+  - Andrey Pronin <apronin@chromium.org>
+
+description: |
+  Google has designed a family of security chips called "Titan".
+  One member is the H1 built into Chromebooks and running Cr50 firmware:
+  https://www.osfc.io/2018/talks/google-secure-microcontroller-and-ccd-closed-case-debugging/
+
+  The chip provides several functions, including TPM 2.0 like functionality.
+  It communicates over SPI or I²C using the FIFO protocol described in the
+  TCG PC Client Platform TPM Profile Specification for TPM 2.0 (PTP), sec 6:
+  https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+
+properties:
+  compatible:
+    const: google,cr50
+
+allOf:
+  - $ref: tpm-common.yaml#
+
+anyOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: tcg,tpm-tis-i2c.yaml#/properties/reg
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tpm@0 {
+            reg = <0>;
+            compatible = "google,cr50";
+            spi-max-frequency = <800000>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tpm@50 {
+            compatible = "google,cr50";
+            reg = <0x50>;
+            interrupts-extended = <&pio 88 IRQ_TYPE_EDGE_FALLING>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&cr50_int>;
+        };
+    };
-- 
2.40.1


