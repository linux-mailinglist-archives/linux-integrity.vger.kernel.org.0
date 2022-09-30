Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F035F1070
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiI3RDL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiI3RDJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:09 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF5C2CE26;
        Fri, 30 Sep 2022 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557387; x=1696093387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hz5VzooJ4PlsQKxFAxNlkVVphl4BcPIuaK+dWMrwDA=;
  b=pUmvR0yN9+3vJF2agultqllE9chOxsMxf34hpuv2sfUqR4+ZCHt1kh8A
   g/9cd9neVVkgZQtaNAwyeQ4Qw8wCHq+E2SelNIafe1Z2vw9XaADwTypDz
   WtpK7uiChQqZgsL/kAs8IiOp0AHpIcAXPq/hQZtqpZ4JAe9twNV03Le7d
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="143525588"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="143525588"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:01:57 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:01:57 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 19:01:57 +0200
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
Subject: [PATCH 4/7] dt-bindings: tpm: Merge existing trivial TPMs to YAML
Date:   Fri, 30 Sep 2022 18:51:13 +0200
Message-ID: <20220930165116.13329-5-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Several of the existing text files describe trivial TPMs, that fit
perfectly into the new trivial-tpms.yaml. Move them there.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 ----------
 .../bindings/security/tpm/tpm-i2c.txt         | 26 --------------
 .../bindings/security/tpm/tpm_tis_mmio.txt    | 25 -------------
 .../bindings/security/tpm/tpm_tis_spi.txt     | 23 ------------
 .../bindings/security/tpm/trivial-tpms.yaml   | 36 +++++++++++++++++++
 5 files changed, 36 insertions(+), 93 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt

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
diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
index a9e2dd17b1ca..1fd7f38b7b6d 100644
--- a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
+++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
@@ -44,20 +44,34 @@ properties:
   compatible:
     contains:
       enum:
+          # Atmel AT97SC3204 LPC TPM 1.2
+        - atmel,at97sc3204
           # Atmel AT97SC3204T I2C TPM 1.2
         - atmel,at97sc3204t
+          # Google Titan H1/Cr50 I2C/SPI TPM 2.0
+        - google,cr50
           # Infineon SLB9635 I2C TPM 1.2 (old protocol, max 100khz)
         - infineon,slb9635tt
           # Infineon SLB9645 I2C TPM 1.2 (new protocol, max 400khz)
         - infineon,slb9645tt
+          # Infineon SLB9670 SPI TPM 2.0
+        - infineon,slb9670
           # Infineon SLB9673 I2C TPM 2.0
         - infineon,slb9673
           # Nuvoton NPCT501 I2C TPM 1.2
         - nuvoton,npct501
           # Nuvoton NPCT601 I2C TPM 2.0
         - nuvoton,npct601
+          # Nuvoton NPCT650 I2C TPM 2.0
+        - nuvoton,npct650
           # Socionext SynQuacer MMIO TPM
         - socionext,synquacer-tpm-mmio
+          # STMicroelectronics ST33TPHF2xSPI TPM 2.0
+        - st,st33htpm-spi
+          # TCG TIS-compliant MMIO TPM (generic fallback)
+        - tcg,tpm-tis-mmio
+          # TCG TIS-compliant SPI TPM (generic fallback)
+        - tcg,tpm_tis-spi
           # Winbond WPCT301 I2C TPM 1.2
         - winbond,wpct301
 
@@ -67,4 +81,26 @@ required:
 
 additionalProperties: false
 
+examples:
+  - |
+    tpm@0 {
+      compatible = "google,cr50";
+      reg = <0>;
+      spi-max-frequency = <800000>;
+    };
+  - |
+    tpm@57 {
+      compatible = "nuvoton,npct601";
+      reg = <0x57>;
+      linux,sml-base = <0x7f 0xfd450000>;
+      linux,sml-size = <0x10000>;
+    };
+  - |
+    tpm_tis@90000 {
+      compatible = "atmel,at97sc3204";
+      reg = <0x90000 0x5000>;
+      interrupt-parent = <&EIC0>;
+      interrupts = <1 2>;
+    };
+
 ...
-- 
2.25.1

