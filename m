Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ACB7AF3F9
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Sep 2023 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjIZTQR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Sep 2023 15:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjIZTQQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2023 15:16:16 -0400
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 12:16:09 PDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D38292;
        Tue, 26 Sep 2023 12:16:09 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A9B0D100DA1AC;
        Tue, 26 Sep 2023 21:09:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7AC89173A43; Tue, 26 Sep 2023 21:09:37 +0200 (CEST)
Message-Id: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 26 Sep 2023 21:09:35 +0200
Subject: [PATCH 1/2] dt-bindings: reset: Add Infineon SLB9670 TPM reset driver
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new reset driver is about to be added to perform the reset sequence of
the Infineon SLB9670 Trusted Platform Module.

Document its device tree bindings.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 .../bindings/reset/infineon,slb9670-reset.yaml     | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml b/Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml
new file mode 100644
index 00000000..b1e23d47
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/infineon,slb9670-reset.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/infineon,slb9670-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon SLB9670 TPM Reset Driver
+
+maintainers:
+  - Lukas Wunner <lukas@wunner.de>
+
+description: |
+  The Infineon SLB9670 Trusted Platform Module requires a specific reset
+  sequence on its RST# pin which is documented in sections 5.4 and 5.5 of
+  the datasheet [1]. This driver performs the reset sequence using a GPIO.
+
+  The sequence with minimum wait intervals is as follows:
+  deassert RST#
+  wait at least 60 ms
+  assert RST#
+  wait at least 2 usecs
+  deassert RST#
+  wait at least 60 ms
+  assert RST#
+  wait at least 2 usecs
+  deassert RST#
+  wait at least 60 ms before issuing the first TPM command
+
+  [1] https://www.infineon.com/dgdl/Infineon-SLB%209670VQ2.0-DataSheet-v01_04-EN.pdf?fileId=5546d4626fc1ce0b016fc78270350cd6
+
+properties:
+  compatible:
+    enum:
+      - infineon,slb9670-reset
+
+  reset-gpios:
+    maxItems: 1
+    description: Reference to the GPIO connected to the RST# pin.
+
+  "#reset-cells":
+    const: 0
+
+required:
+  - compatible
+  - reset-gpios
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    tpm_reset: reset-controller {
+        compatible = "infineon,slb9670-reset";
+        #reset-cells = <0>;
+        reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
+    };
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tpm@0 {
+            compatible = "infineon,slb9670";
+            reg = <0>;
+            resets = <&tpm_reset>;
+        };
+    };
-- 
2.40.1

