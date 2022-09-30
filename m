Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1E5F106F
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiI3RDP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiI3RDN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:13 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F51D8F24;
        Fri, 30 Sep 2022 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557391; x=1696093391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+Ca+rPzfinJ31D4JgeNITQ6MRRb0mvisyTTPC1liic=;
  b=V8mYk5o8ltajlXSr2SDMaLw1/fr07aA8oE43oKiLx/8+3qQT4wtMeA4S
   UQjmL/Ni+UKc0VoVEGuIX39YStha9S0dWTFwxM/d6ZrfJFgkDJcGN7pvl
   ihwfkRI2KpUm3osaw9A8MgyL09EKjapLXFzC2ndkDfMkoLmjaBP3fo7vm
   s=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="319753130"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="319753130"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:01:57 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:01:56 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 19:01:56 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 19:01:56 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <Johannes.Holland@infineon.com>, <benoit.houyere@st.com>,
        <amirmizi6@gmail.com>, <peter@pjd.dev>
Subject: [PATCH 1/7] dt-bindings: tpm: Introduce trivial-tpms.yaml
Date:   Fri, 30 Sep 2022 18:51:10 +0200
Message-ID: <20220930165116.13329-2-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Most TPM devices are very similar and only need a few common properties
to describe them. However, they may use more properties than other
trivial I2C or SPI devices, e.g. powered-while-suspended. Therefore,
move them to their own trivial-tpms.yaml.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 .../bindings/security/tpm/trivial-tpms.yaml   | 54 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 16 ------
 2 files changed, 54 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
new file mode 100644
index 000000000000..fadd4ca96554
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/trivial-tpms.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trivial TPM devices that have simple device tree bindings
+
+maintainers:
+  - linux-integrity@vger.kernel.org
+
+description: |
+  This is a list of trivial TPM devices that share the same properties and
+  therefore have simple device tree bindings.
+
+  If a device needs more specific bindings, such as properties to
+  describe some aspect of it, there needs to be a specific binding
+  document for it just like any other devices.
+
+properties:
+  reg:
+    maxItems: 1
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  compatible:
+    contains:
+      enum:
+          # i2c trusted platform module (TPM)
+        - atmel,at97sc3204t
+          # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
+        - infineon,slb9635tt
+          # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+        - infineon,slb9645tt
+          # Infineon SLB9673 I2C TPM 2.0
+        - infineon,slb9673
+          # i2c trusted platform module (TPM)
+        - nuvoton,npct501
+          # i2c trusted platform module (TPM2)
+        - nuvoton,npct601
+          # Socionext SynQuacer TPM MMIO module
+        - socionext,synquacer-tpm-mmio
+          # i2c trusted platform module (TPM)
+        - winbond,wpct301
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 61746755c107..1cc7f82c0822 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -47,8 +47,6 @@ properties:
           - ams,iaq-core
             # i2c serial eeprom (24cxx)
           - at,24c08
-            # i2c trusted platform module (TPM)
-          - atmel,at97sc3204t
             # ATSHA204 - i2c h/w symmetric crypto module
           - atmel,atsha204
             # ATSHA204A - i2c h/w symmetric crypto module
@@ -135,12 +133,6 @@ properties:
           - infineon,ir38164
             # Infineon IR38263 Voltage Regulator
           - infineon,ir38263
-            # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
-          - infineon,slb9635tt
-            # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
-          - infineon,slb9645tt
-            # Infineon SLB9673 I2C TPM 2.0
-          - infineon,slb9673
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280
@@ -289,10 +281,6 @@ properties:
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
@@ -327,8 +315,6 @@ properties:
           - silabs,si7020
             # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
           - skyworks,sky81452
-            # Socionext SynQuacer TPM MMIO module
-          - socionext,synquacer-tpm-mmio
             # SparkFun Qwiic Joystick (COM-15168) with i2c interface
           - sparkfun,qwiic-joystick
             # i2c serial eeprom (24cxx)
@@ -383,8 +369,6 @@ properties:
           - winbond,w83793
             # Vicor Corporation Digital Supervisor
           - vicor,pli1209bc
-            # i2c trusted platform module (TPM)
-          - winbond,wpct301
 
 required:
   - compatible
-- 
2.25.1

