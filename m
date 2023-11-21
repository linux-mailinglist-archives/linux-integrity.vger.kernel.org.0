Return-Path: <linux-integrity+bounces-139-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449977F2969
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 10:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4D3B20F34
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAA3C089;
	Tue, 21 Nov 2023 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C55F5;
	Tue, 21 Nov 2023 01:55:11 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B67A730001194;
	Tue, 21 Nov 2023 10:55:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A93E036DAE; Tue, 21 Nov 2023 10:55:09 +0100 (CET)
Message-Id: <fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de>
In-Reply-To: <cover.1700555862.git.lukas@wunner.de>
References: <cover.1700555862.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 21 Nov 2023 10:48:42 +0100
Subject: [PATCH 2/3] dt-bindings: tpm: Convert IBM vTPM bindings to DT schema
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Convert the devicetree bindings for the IBM Virtual Trusted Platform
Module to DT schema.  Drop properties which are already documented in
tpm-common.yaml.

Document the "IBM,vtpm20" compatible string introduced by commit
18b3670d79ae ("tpm: ibmvtpm: Add support for TPM2").

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 .../bindings/security/tpm/ibmvtpm.txt         |  41 -------
 .../devicetree/bindings/tpm/ibm,vtpm.yaml     | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
 create mode 100644 Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt b/Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
deleted file mode 100644
index d89f99971368..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Device Tree Bindings for IBM Virtual Trusted Platform Module(vtpm)
-
-Required properties:
-
-- compatible            : property name that conveys the platform architecture
-                          identifiers, as 'IBM,vtpm'
-- device_type           : specifies type of virtual device
-- interrupts            : property specifying the interrupt source number and
-                          sense code associated with this virtual I/O Adapters
-- ibm,my-drc-index      : integer index for the connector between the device
-                          and its parent - present only if Dynamic
-                          Reconfiguration(DR) Connector is enabled
-- ibm,#dma-address-cells: specifies the number of cells that are used to
-                          encode the physical address field of dma-window
-                          properties
-- ibm,#dma-size-cells   : specifies the number of cells that are used to
-                          encode the size field of dma-window properties
-- ibm,my-dma-window     : specifies DMA window associated with this virtual
-                          IOA
-- ibm,loc-code          : specifies the unique and persistent location code
-                          associated with this virtual I/O Adapters
-- linux,sml-base        : 64-bit base address of the reserved memory allocated
-                          for the firmware event log
-- linux,sml-size        : size of the memory allocated for the firmware event log
-
-Example (IBM Virtual Trusted Platform Module)
----------------------------------------------
-
-                vtpm@30000003 {
-                        ibm,#dma-size-cells = <0x2>;
-                        compatible = "IBM,vtpm";
-                        device_type = "IBM,vtpm";
-                        ibm,my-drc-index = <0x30000003>;
-                        ibm,#dma-address-cells = <0x2>;
-                        linux,sml-base = <0xc60e 0x0>;
-                        interrupts = <0xa0003 0x0>;
-                        ibm,my-dma-window = <0x10000003 0x0 0x0 0x0 0x10000000>;
-                        ibm,loc-code = "U8286.41A.10082DV-V3-C3";
-                        reg = <0x30000003>;
-                        linux,sml-size = <0xbce10200>;
-                };
diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
new file mode 100644
index 000000000000..a88ed96c80cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/ibm,vtpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM Virtual Trusted Platform Module (vTPM)
+
+maintainers:
+  - Nayna Jain <nayna@linux.ibm.com>
+
+description: |
+  Virtual TPM is used on IBM POWER7+ and POWER8 systems running POWERVM.
+  It is supported through the adjunct partition with firmware release 740
+  or higher.  With vTPM support, each lpar is able to have its own vTPM
+  without the physical TPM hardware.  The TPM functionality is provided by
+  communicating with the vTPM adjunct partition through Hypervisor calls
+  (Hcalls) and Command/Response Queue (CRQ) commands.
+
+properties:
+  compatible:
+    enum:
+      - IBM,vtpm
+      - IBM,vtpm20
+
+  device_type:
+    description:
+      type of virtual device
+
+  reg:
+    maxItems: 1
+
+  'ibm,#dma-address-cells':
+    description:
+      number of cells that are used to encode the physical address field of
+      dma-window properties
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  'ibm,#dma-size-cells':
+    description:
+      number of cells that are used to encode the size field of
+      dma-window properties
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  ibm,my-dma-window:
+    description:
+      DMA window associated with this virtual I/O Adapter
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    maxItems: 5
+
+  ibm,my-drc-index:
+    description:
+      integer index for the connector between the device and its parent;
+      present only if Dynamic Reconfiguration (DR) Connector is enabled
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ibm,loc-code:
+    description:
+      unique and persistent location code associated with this virtual
+      I/O Adapter
+    $ref: /schemas/types.yaml#/definitions/string
+
+required:
+  - compatible
+  - device_type
+  - reg
+  - interrupts
+  - ibm,#dma-address-cells
+  - ibm,#dma-size-cells
+  - ibm,my-dma-window
+  - ibm,my-drc-index
+  - ibm,loc-code
+  - linux,sml-base
+  - linux,sml-size
+
+allOf:
+  - $ref: tpm-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vtpm@30000003 {
+            compatible = "IBM,vtpm";
+            device_type = "IBM,vtpm";
+            reg = <0x30000003>;
+            interrupts = <0xa0003 0x0>;
+            ibm,#dma-address-cells = <0x2>;
+            ibm,#dma-size-cells = <0x2>;
+            ibm,my-dma-window = <0x10000003 0x0 0x0 0x0 0x10000000>;
+            ibm,my-drc-index = <0x30000003>;
+            ibm,loc-code = "U8286.41A.10082DV-V3-C3";
+            linux,sml-base = <0xc60e 0x0>;
+            linux,sml-size = <0xbce10200>;
+        };
+    };
-- 
2.40.1


