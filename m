Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28DF51DE17
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444095AbiEFRJD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444093AbiEFRJB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 13:09:01 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A84D9E7;
        Fri,  6 May 2022 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1651856717; x=1683392717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8R9iqVwlSWBcLxOnV282bKq83f750AtG8muuAs3ZADI=;
  b=HBs7GtUEFQ5Pe2zrwVGT48QaT3OOxGu86ca5aVglAO72xdEFFV5693YE
   bhm/AVRB6/9Ps9TQKi/OOl2/ALvvkZbGPbk5lmtZFGmBG6gTVBbegCAVm
   x+INJdBhXBO2w3KPFq2AJaVYu6JZXm3aaLOjSBgZ7UM1/Bmbf0rq/Io57
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="176373805"
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="176373805"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 19:05:15 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 19:05:15 +0200 (CEST)
Received: from ISCN5CG1067W80.agb.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 19:05:14 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH v2 4/4] dt-bindings: doc/devicetree/bindings/security/tpm: Move tpm-i2c.txt to YAML
Date:   Fri, 6 May 2022 19:00:17 +0200
Message-ID: <20220506170013.22598-4-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220506170013.22598-1-johannes.holland@infineon.com>
References: <20220506170013.22598-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Migrate the existing plain text I2c driver schema to YAML and extend by
the options of the generic TIS driver for I2C TPMs which comply to the
TCG PC Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
Revision 14.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
Changelog:
 * v2:
   * move existing device tree instead of just adding a new one
   * do not use wildcard compatibles
   * make properties "label", "linux,sml-base" and "linux,sml-size"
     optional, as they should be

All properties are listed, even if some drivers do not implement them.

As mentioned, I kept the generic compatible in there because the TPM
is a standardized device. For vendor-specific features and bugs, the
specific compatibles can be used. Please let me know if you need it
removed.

 .../bindings/security/tpm/tpm-i2c.txt         | 26 --------
 .../bindings/security/tpm/tpm-i2c.yaml        | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml

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
diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml
new file mode 100644
index 000000000000..952605ab8611
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-i2c.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/tpm-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C PTP based TPM Device Tree Bindings
+
+maintainers:
+  - Johannes Holland <johannes.holland@infineon.com>
+
+description:
+  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # Infineon's Trusted Platform Module (TPM) (SLB9673)
+          - infineon,slb9673
+          - nuvoton,npct601
+          - nuvoton,npct650
+      - const: tcg,tpm-tis-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupt:
+    maxItems: 1
+
+  label:
+    description: |
+      Human readable string describing the device, eg. "tpm".
+
+  linux,sml-base:
+    description: |
+      64-bit base address of the reserved memory allocated
+      for the firmware event log.
+
+  linux,sml-size:
+    description: |
+      Size of the memory allocated for the firmware event log.
+
+  powered-while-suspended:
+    description: |
+      Present when the TPM is left powered on between suspend and
+      resume (makes the suspend/resume callbacks do nothing).
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
+        compatible = "infineon,slb9673", "tcg,tpm-tis-i2c";
+        reg = <0x2e>;
+      };
+    };
+...
-- 
2.34.1

