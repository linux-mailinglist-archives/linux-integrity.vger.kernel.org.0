Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748405B6A5C
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiIMJKq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 05:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiIMJKn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 05:10:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883E5789E;
        Tue, 13 Sep 2022 02:10:42 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so10756856pgs.3;
        Tue, 13 Sep 2022 02:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=0fVYsPpgbLrfPt7bLk4lwcWWIsrCzoQTWLFoUGZ6eQA=;
        b=mD5Nrf9RC73HP7UlMAlqVZ7qrPKSzlaRv1D1fvm79DjLszTOee1+MXHRJnxK/PXkTe
         lFjlbQKOPIKElRI52MdvQ30Zn0FPR8k/+xhBzwSY1cMi8tevL1XE0k/tWq2SRYESEkMi
         j12TXt/L2PzwxGwZvbcqljYDBEjmF96chrePeYFR7xYlRww5sD7glw8CBF3UIsonyymB
         QVSRM8k80x40WStagLQY4I2XLazNhAgAj2UCmvTwLzEuczM1l/ad1VuSbSb6KrUP45IS
         p7XPH4vHqi7zqP74+lkLBrDaXHbG0GfbeQuJeP0u03koD+nJOLCyUpvt55XH00I0iDK6
         Hrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=0fVYsPpgbLrfPt7bLk4lwcWWIsrCzoQTWLFoUGZ6eQA=;
        b=WHkfxdxx9YZBsA2+xRCjv6OatWejpnshxHLv8gW0pRemC/qm+EAfWLoC6rYZWSuYkZ
         dBM4qSh+TW+kATHS3x2Gxfkpp9p+TduXls9AUDxkBpj4YeLgI1wqGt/SDBVlSW//Vtzk
         c3R1WjFr0ay1sAFo31U/QiKcEkCabsbwElP3WmaEgfjRGKg6Lk28jWa/IUg1NHQYGxlZ
         65uhLS3vKrAvTuFgwvGRVkC9/7K6GdvBHHHOcQuzOQ+zlrFkTU4XP2ZBqfvzzp8dbtp1
         7rdJ9RtSvMdk/ImiLjaIxhwDxE3gGam/DY16gbd1SLbiPXZdsEB5Ga+tgKU76u0Uy3dA
         Vmow==
X-Gm-Message-State: ACgBeo0ympJlswfVgaPHRbwkcrR+ezj9ZfUuVrWZmv6fMVDf2X68OsFZ
        i/p5MJxq9fjfX21gKEl9eXQ=
X-Google-Smtp-Source: AA6agR5vx4/PQEVnRCknNIWqZbl79A20RYHcHvnVgGv2e2ZUTpNB5MkLCDVP5yILwwciFJlKAw3igQ==
X-Received: by 2002:a63:174c:0:b0:438:aece:e2f5 with SMTP id 12-20020a63174c000000b00438aecee2f5mr14212391pgx.366.1663060241941;
        Tue, 13 Sep 2022 02:10:41 -0700 (PDT)
Received: from voyager.lan ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090ad48800b001f2fa09786asm6801668pju.19.2022.09.13.02.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 02:10:41 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Johannes Holland <johannes.holland@infineon.com>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, eajames@linux.ibm.com
Subject: [PATCH 1/2] dt-bindings: tpm: Add schema for TIS I2C devices
Date:   Tue, 13 Sep 2022 18:40:23 +0930
Message-Id: <20220913091025.1768882-2-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913091025.1768882-1-joel@jms.id.au>
References: <20220913091025.1768882-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Johannes Holland <johannes.holland@infineon.com>

Add a YAML schema to support device tree bindings for the generic I2C
physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
Specification for TPM 2.0 v1.04 Revision 14.

This includes descriptions for the Nuvoton and Infineon devices.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 000000000000..fb7b747ff2a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,49 @@
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
+  $nodename:
+    pattern: "^tpm(@[0-9a-f]+)?$"
+
+  compatible:
+    oneOf:
+      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
+        items:
+          - const: infineon,slb9673
+      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
+        items:
+          - const: nuvoton,npct75x
+          - const: tcg,tpm-tis-i2c
+      - const: tcg,tpm-tis-i2c
+  reg:
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
+        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+        reg = <0x2e>;
+      };
+    };
+...
-- 
2.35.1

