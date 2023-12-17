Return-Path: <linux-integrity+bounces-520-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B65815E8B
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 11:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F09283AFE
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F65681;
	Sun, 17 Dec 2023 10:36:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8892D2EB;
	Sun, 17 Dec 2023 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 10CE010192642;
	Sun, 17 Dec 2023 11:29:49 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id D9C976073EFF;
	Sun, 17 Dec 2023 11:29:48 +0100 (CET)
X-Mailbox-Line: From 953fd4c7519030db88e5b5e12ab6307414ebdd21 Mon Sep 17 00:00:00 2001
Message-Id: <953fd4c7519030db88e5b5e12ab6307414ebdd21.1702806810.git.lukas@wunner.de>
In-Reply-To: <cover.1702806810.git.lukas@wunner.de>
References: <cover.1702806810.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 17 Dec 2023 11:13:31 +0100
Subject: [PATCH v3 1/4] dt-bindings: tpm: Consolidate TCG TIS bindings
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

A significant number of Trusted Platform Modules conform to the "TIS"
specification published by the Trusted Computing Group ("TCG PC Client
Specific TPM Interface Specification").  These chips typically use an
SPI, I²C or LPC bus as transport (via MMIO in the latter case).  Some
of them even support multiple of those buses (selectable through a
config strap) or the same chip is available in multiple SKUs, each with
a different bus interface.

The devicetree bindings for these TPMs have not been converted to DT
schema yet and are spread out across 3 generic files and 2 chip-specific
files.  A few TPM compatible strings were added to trivial-devices.yaml
even though additional properties are documented in the plaintext
bindings.

Consolidate the devicetree bindings into 3 yaml files, one per bus.

Move common properties to a separate tpm-common.yaml.

Document compatible strings which are supported by the TPM TIS driver
but were neglected to be added to the devicetree bindings.

Document the memory-region property recently introduced by commit
1e2714bb83fc ("tpm: Add reserved memory event log").

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v2 -> v3:
  * Drop clock-frequency property from tcg,tpm-tis-i2c.yaml.
    It doesn't exist at the peripheral level, only at the
    controller level.  Document maximum clock frequency for
    infineon,slb9635tt and infineon,slb9645tt in textual form
    (as was previously done in trivial-devices.yaml).
  * Document reset-gpios property as used by:
    arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts

 .../bindings/security/tpm/st33zp24-i2c.txt    | 34 -------
 .../bindings/security/tpm/st33zp24-spi.txt    | 32 -------
 .../bindings/security/tpm/tpm-i2c.txt         | 26 ------
 .../bindings/security/tpm/tpm_tis_mmio.txt    | 25 ------
 .../bindings/security/tpm/tpm_tis_spi.txt     | 23 -----
 .../bindings/tpm/tcg,tpm-tis-i2c.yaml         | 90 +++++++++++++++++++
 .../bindings/tpm/tcg,tpm-tis-mmio.yaml        | 49 ++++++++++
 .../bindings/tpm/tcg,tpm_tis-spi.yaml         | 75 ++++++++++++++++
 .../devicetree/bindings/tpm/tpm-common.yaml   | 87 ++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 16 ----
 10 files changed, 301 insertions(+), 156 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tpm-common.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt b/Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
deleted file mode 100644
index 0dc121b6eace..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* STMicroelectronics SAS. ST33ZP24 TPM SoC
-
-Required properties:
-- compatible: Should be "st,st33zp24-i2c".
-- clock-frequency: I²C work frequency.
-- reg: address on the bus
-
-Optional ST33ZP24 Properties:
-- interrupts: GPIO interrupt to which the chip is connected
-- lpcpd-gpios: Output GPIO pin used for ST33ZP24 power management D1/D2 state.
-If set, power must be present when the platform is going into sleep/hibernate mode.
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-
-Example (for ARM-based BeagleBoard xM with ST33ZP24 on I2C2):
-
-&i2c2 {
-
-
-        st33zp24: st33zp24@13 {
-
-                compatible = "st,st33zp24-i2c";
-
-                reg = <0x13>;
-                clock-frequency = <400000>;
-
-                interrupt-parent = <&gpio5>;
-                interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
-
-                lpcpd-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
-        };
-};
diff --git a/Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt b/Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
deleted file mode 100644
index 37198971f17b..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* STMicroelectronics SAS. ST33ZP24 TPM SoC
-
-Required properties:
-- compatible: Should be "st,st33zp24-spi".
-- spi-max-frequency: Maximum SPI frequency (<= 10000000).
-
-Optional ST33ZP24 Properties:
-- interrupts: GPIO interrupt to which the chip is connected
-- lpcpd-gpios: Output GPIO pin used for ST33ZP24 power management D1/D2 state.
-If set, power must be present when the platform is going into sleep/hibernate mode.
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-
-Example (for ARM-based BeagleBoard xM with ST33ZP24 on SPI4):
-
-&mcspi4 {
-
-
-        st33zp24@0 {
-
-                compatible = "st,st33zp24-spi";
-
-                spi-max-frequency = <10000000>;
-
-                interrupt-parent = <&gpio5>;
-                interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
-
-                lpcpd-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
-        };
-};
diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt b/Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
deleted file mode 100644
index a65d7b71e81a..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Device Tree Bindings for I2C based Trusted Platform Module(TPM)
-
-Required properties:
-
-- compatible     : 'manufacturer,model', eg. nuvoton,npct650
-- label          : human readable string describing the device, eg. "tpm"
-- linux,sml-base : 64-bit base address of the reserved memory allocated for
-                   the firmware event log
-- linux,sml-size : size of the memory allocated for the firmware event log
-
-Optional properties:
-
-- powered-while-suspended: present when the TPM is left powered on between
-                           suspend and resume (makes the suspend/resume
-                           callbacks do nothing).
-
-Example (for OpenPower Systems with Nuvoton TPM 2.0 on I2C)
-----------------------------------------------------------
-
-tpm@57 {
-	reg = <0x57>;
-	label = "tpm";
-	compatible = "nuvoton,npct650", "nuvoton,npct601";
-	linux,sml-base = <0x7f 0xfd450000>;
-	linux,sml-size = <0x10000>;
-};
diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
deleted file mode 100644
index 7c6304426da1..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Trusted Computing Group MMIO Trusted Platform Module
-
-The TCG defines multi vendor standard for accessing a TPM chip, this
-is the standard protocol defined to access the TPM via MMIO. Typically
-this interface will be implemented over Intel's LPC bus.
-
-Refer to the 'TCG PC Client Specific TPM Interface Specification (TIS)' TCG
-publication for the specification.
-
-Required properties:
-
-- compatible: should contain a string below for the chip, followed by
-              "tcg,tpm-tis-mmio". Valid chip strings are:
-	          * "atmel,at97sc3204"
-- reg: The location of the MMIO registers, should be at least 0x5000 bytes
-- interrupts: An optional interrupt indicating command completion.
-
-Example:
-
-	tpm_tis@90000 {
-				compatible = "atmel,at97sc3204", "tcg,tpm-tis-mmio";
-				reg = <0x90000 0x5000>;
-				interrupt-parent = <&EIC0>;
-				interrupts = <1 2>;
-	};
diff --git a/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt b/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
deleted file mode 100644
index b800667da92b..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Required properties:
-- compatible: should be one of the following
-    "st,st33htpm-spi"
-    "infineon,slb9670"
-    "tcg,tpm_tis-spi"
-- spi-max-frequency: Maximum SPI frequency (depends on TPMs).
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-
-Example (for ARM-based BeagleBoard xM with TPM_TIS on SPI4):
-
-&mcspi4 {
-
-
-        tpm_tis@0 {
-
-                compatible = "tcg,tpm_tis-spi";
-
-                spi-max-frequency = <10000000>;
-        };
-};
diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
new file mode 100644
index 000000000000..3ab4434b7352
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I²C-attached Trusted Platform Module conforming to TCG TIS specification
+
+maintainers:
+  - Lukas Wunner <lukas@wunner.de>
+
+description: |
+  The Trusted Computing Group (TCG) has defined a multi-vendor standard
+  for accessing a TPM chip.  It can be transported over various buses,
+  one of them being I²C.  The standard is named:
+  TCG PC Client Specific TPM Interface Specification (TIS)
+  https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
+
+  The I²C interface was not originally part of the standard, but added
+  in 2017 with a separate document:
+  TCG PC Client Platform TPM Profile Specification for TPM 2.0 (PTP)
+  https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+
+  Recent TPM 2.0 chips conform to this generic interface, others use a
+  vendor-specific I²C interface.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Generic TPM 2.0 chips conforming to TCG PTP interface
+        items:
+          - enum:
+              - infineon,slb9673
+              - nuvoton,npct75x
+          - const: tcg,tpm-tis-i2c
+
+      - description: TPM 1.2 and 2.0 chips with vendor-specific I²C interface
+        items:
+          - enum:
+              - atmel,at97sc3204t # TPM 1.2
+              - infineon,slb9635tt # TPM 1.2 (maximum 100 kHz)
+              - infineon,slb9645tt # TPM 1.2 (maximum 400 kHz)
+              - infineon,tpm_i2c_infineon # TPM 1.2
+              - nuvoton,npct501 # TPM 1.2
+              - nuvoton,npct601 # TPM 2.0
+              - st,st33zp24-i2c # TPM 2.0
+              - winbond,wpct301 # TPM 1.2
+
+  reg:
+    description: address of TPM on the I²C bus
+
+allOf:
+  - $ref: tpm-common.yaml#
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tpm@57 {
+            label = "tpm";
+            compatible = "nuvoton,npct601";
+            reg = <0x57>;
+            linux,sml-base = <0x7f 0xfd450000>;
+            linux,sml-size = <0x10000>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tpm@13 {
+            reg = <0x13>;
+            compatible = "st,st33zp24-i2c";
+            interrupt-parent = <&gpio5>;
+            interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+            lpcpd-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
new file mode 100644
index 000000000000..87bce0692129
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-mmio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MMIO-accessed Trusted Platform Module conforming to TCG TIS specification
+
+maintainers:
+  - Lukas Wunner <lukas@wunner.de>
+
+description: |
+  The Trusted Computing Group (TCG) has defined a multi-vendor standard
+  for accessing a TPM chip.  It can be transported over various buses,
+  one of them being LPC (via MMIO).  The standard is named:
+  TCG PC Client Specific TPM Interface Specification (TIS)
+  https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - at97sc3201
+          - atmel,at97sc3204
+          - socionext,synquacer-tpm-mmio
+      - const: tcg,tpm-tis-mmio
+
+  reg:
+    description:
+      location and length of the MMIO registers, length should be
+      at least 0x5000 bytes
+
+allOf:
+  - $ref: tpm-common.yaml#
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    tpm@90000 {
+        compatible = "atmel,at97sc3204", "tcg,tpm-tis-mmio";
+        reg = <0x90000 0x5000>;
+        interrupt-parent = <&EIC0>;
+        interrupts = <1 2>;
+    };
diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
new file mode 100644
index 000000000000..c3413b47ac3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-attached Trusted Platform Module conforming to TCG TIS specification
+
+maintainers:
+  - Lukas Wunner <lukas@wunner.de>
+
+description: |
+  The Trusted Computing Group (TCG) has defined a multi-vendor standard
+  for accessing a TPM chip.  It can be transported over various buses,
+  one of them being SPI.  The standard is named:
+  TCG PC Client Specific TPM Interface Specification (TIS)
+  https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - infineon,slb9670
+          - st,st33htpm-spi
+          - st,st33zp24-spi
+      - const: tcg,tpm_tis-spi
+
+allOf:
+  - $ref: tpm-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,st33zp24-spi
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 10000000
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
+            compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+            spi-max-frequency = <10000000>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tpm@0 {
+            reg = <0>;
+            compatible = "st,st33zp24-spi", "tcg,tpm_tis-spi";
+            spi-max-frequency = <10000000>;
+            interrupt-parent = <&gpio5>;
+            interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+            lpcpd-gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
new file mode 100644
index 000000000000..90390624a8be
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/tpm-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trusted Platform Module common properties
+
+maintainers:
+  - Lukas Wunner <lukas@wunner.de>
+
+properties:
+  $nodename:
+    pattern: '^tpm(@[0-9a-f]+)?$'
+
+  interrupts:
+    description: indicates command completion
+    maxItems: 1
+
+  label:
+    description: human readable string describing the device, e.g. "tpm"
+
+  linux,sml-base:
+    description:
+      base address of reserved memory allocated for firmware event log
+    $ref: /schemas/types.yaml#/definitions/uint64
+
+  linux,sml-size:
+    description:
+      size of reserved memory allocated for firmware event log
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  memory-region:
+    description: reserved memory allocated for firmware event log
+    maxItems: 1
+
+  powered-while-suspended:
+    description:
+      present when the TPM is left powered on between suspend and resume
+      (makes the suspend/resume callbacks do nothing)
+    type: boolean
+
+  resets:
+    description: Reset controller to reset the TPM
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  reset-gpios:
+    description: Output GPIO pin to reset the TPM
+    maxItems: 1
+
+# must always have both linux,sml-base and linux,sml-size
+dependentRequired:
+  linux,sml-base: ['linux,sml-size']
+  linux,sml-size: ['linux,sml-base']
+
+# must only have either memory-region or linux,sml-base
+# as well as either resets or reset-gpios
+dependentSchemas:
+  memory-region:
+    properties:
+      linux,sml-base: false
+  linux,sml-base:
+    properties:
+      memory-region: false
+  resets:
+    properties:
+      reset-gpios: false
+  reset-gpios:
+    properties:
+      resets: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: '^st,st33zp24'
+    then:
+      properties:
+        lpcpd-gpios:
+          description:
+            Output GPIO pin used for ST33ZP24 power management of D1/D2 state.
+            If set, power must be present when the platform is going into
+            sleep/hibernate mode.
+          maxItems: 1
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index c3190f2a168a..29aed5ddba6b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -49,8 +49,6 @@ properties:
           - ams,iaq-core
             # i2c serial eeprom (24cxx)
           - at,24c08
-            # i2c trusted platform module (TPM)
-          - atmel,at97sc3204t
             # ATSHA204 - i2c h/w symmetric crypto module
           - atmel,atsha204
             # ATSHA204A - i2c h/w symmetric crypto module
@@ -145,12 +143,6 @@ properties:
           - infineon,ir38263
             # Infineon IRPS5401 Voltage Regulator (PMIC)
           - infineon,irps5401
-            # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
-          - infineon,slb9635tt
-            # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-          - infineon,slb9645tt
-            # Infineon SLB9673 I2C TPM 2.0
-          - infineon,slb9673
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280
@@ -301,10 +293,6 @@ properties:
           - national,lm85
             # I2C ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator
           - national,lm92
-            # i2c trusted platform module (TPM)
-          - nuvoton,npct501
-            # i2c trusted platform module (TPM2)
-          - nuvoton,npct601
             # Nuvoton Temperature Sensor
           - nuvoton,w83773g
             # OKI ML86V7667 video decoder
@@ -349,8 +337,6 @@ properties:
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452
-            # Socionext SynQuacer TPM MMIO module
-          - socionext,synquacer-tpm-mmio
             # SparkFun Qwiic Joystick (COM-15168) with i2c interface
           - sparkfun,qwiic-joystick
             # i2c serial eeprom (24cxx)
@@ -405,8 +391,6 @@ properties:
           - winbond,w83793
             # Vicor Corporation Digital Supervisor
           - vicor,pli1209bc
-            # i2c trusted platform module (TPM)
-          - winbond,wpct301
 
 required:
   - compatible
-- 
2.40.1


