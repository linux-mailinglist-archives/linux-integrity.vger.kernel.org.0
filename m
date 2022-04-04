Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28D54F10BE
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Apr 2022 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiDDIVP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbiDDIVO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 04:21:14 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA653B543;
        Mon,  4 Apr 2022 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1649060357; x=1680596357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6g5F7vqMqbm8qvjj6KZ0nEFUne1Z/PQPj4eHWzChsVw=;
  b=HsBE7eIAm2v0Elk237xPOOX55zJOmSeLJZMRwNj76ueMthVKXwPndRlT
   5VeA34OUR28xWwqK+aBedY4G22beOxIV5k93heyEQ6cOSg5Ou0Z/+hjQP
   bGg0YW7TR4oLflV9Yj9SHnOkq1x6Hz/WHty4I8BywmyFps2hJBrsVcbPw
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="172160987"
X-IronPort-AV: E=Sophos;i="5.90,233,1643670000"; 
   d="scan'208";a="172160987"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 10:19:15 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Mon,  4 Apr 2022 10:19:15 +0200 (CEST)
Received: from ISCN5CG1067W80.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 10:19:15 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <amirmizi6@gmail.com>, <robh@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH 4/4] tpm: Add YAML schema for the TPM TIS I2C options
Date:   Mon, 4 Apr 2022 10:18:35 +0200
Message-ID: <20220404081835.495-4-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20220404081835.495-1-johannes.holland@infineon.com>
References: <20220404081835.495-1-johannes.holland@infineon.com>
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

Add a YAML schema to support device tree bindings for the generic I2C
physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
Specification for TPM 2.0 v1.04 Revision 14.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 000000000000..7948867ff3f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
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
+        compatible = "infineon,slb9673", "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+        reg = <0x2e>;
+      };
+    };
+...
-- 
2.31.1.windows.1

