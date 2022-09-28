Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A064F5ED3F7
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 06:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiI1ElM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 00:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiI1ElL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 00:41:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD183F21;
        Tue, 27 Sep 2022 21:41:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso657139pjh.4;
        Tue, 27 Sep 2022 21:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=YP8+TpInxIDb5PM1pJKT5re6Yn5jKTALc0NCg1LZkn0=;
        b=KKLaNJ1QH76g3DIxqhzTpeYElGtBvYDnAUlpInkf/PnC5rgspVWBGbOu+sTHH1EPa6
         xd0NzM7+ETu5R/2Nvba5H5ET2kqvQ6TPdkHClXNW/dkrtqsE7HW7T4/7bTCUZT7Je8Vl
         C/E5ehDgKSJw5Yra8MJdhJGEfG2aJjzu0cR/Uft6ypf3PLgKSqDSlzSHLcO30w/wLbJn
         dO4PthWxb9cTm/pPiJObzRmZci3pJu6a4pUKlRLWuLQyfm89xiWfFORHmLkePk4f4+Po
         rbCMA224531Pss3CZiskB+UOGweWbnb0anfoWbKZ43ItI9xyvRQ0JrxswVTC/WcGSWyl
         YWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=YP8+TpInxIDb5PM1pJKT5re6Yn5jKTALc0NCg1LZkn0=;
        b=v0MgiaNZn6j7G5HaVP4wEKfYpNS70ddQP5D5NtkuOSpD97Tv6b4hTHpcVIomGDHgnW
         xw87NWu0kmiFA/QFW5xpNun5kKoFcJ6c4RVSLaaTSHgZrGoFDsdt0gU3s6pbg5mt4yBy
         cDDh9tfW0KXfQQ4VUMVIRA5CsaHESVCPuA85M/jnpj7Ax6vENVDM+3q1JXAxjFs+1EYf
         foFTBJ2epkX9TMhUANbKf/scZwZj5yMmu6SDlP6aq2U0V64rtdA7zucdtxX2jQTzuOpG
         +Hc6/maj4+FruEpxUtjCNJoKbui6kVAMqRbnn9JhzEBw6eI0X/eTSuElvJOcV9KVDkYM
         04cA==
X-Gm-Message-State: ACrzQf1N78zYPluE6eaNIMAmXj4YvmVmJXiMfZPG3daUapS20fq0FnTe
        lDSCSY67HUUzYu2S4/DyzG41YDhKgY+AEw==
X-Google-Smtp-Source: AMsMyM7deK8wlX0z1IjwHr/cLNIQYfRM7lKaVFdlqAj02nLxiOg+hhxLPeMfkDtGjUFFjxhbcvvQcw==
X-Received: by 2002:a17:902:ecc6:b0:178:3c7c:18ad with SMTP id a6-20020a170902ecc600b001783c7c18admr30387274plh.112.1664340070156;
        Tue, 27 Sep 2022 21:41:10 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b00178ac4e70dcsm2504439plg.185.2022.09.27.21.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:41:09 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Johannes Holland <johannes.holland@infineon.com>,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, eajames@linux.ibm.com
Subject: [PATCH v2 2/3] dt-bindings: tpm: Add schema for TIS I2C devices
Date:   Wed, 28 Sep 2022 14:09:56 +0930
Message-Id: <20220928043957.2636877-3-joel@jms.id.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928043957.2636877-1-joel@jms.id.au>
References: <20220928043957.2636877-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Johannes Holland <johannes.holland@infineon.com>

Add a dt schema to support device tree bindings for the generic I2C
physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
Specification for TPM 2.0 v1.04 Revision 14.

This includes descriptions for the Nuvoton and Infineon devices.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: String changes
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 000000000000..de1e34065748
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C PTP based TPM Devices
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
+          - const: tcg,tpm-tis-i2c
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

