Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AD5F1071
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiI3RDJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiI3RDI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:08 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94181D8F0B;
        Fri, 30 Sep 2022 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557387; x=1696093387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GvfB0MVrva7QBtg+sGZTDoSSvs5VB9AHgqRsKrTHE9c=;
  b=BNrZ9JWxV/IRyXU233bEc4V2t95AnEz+i6pNWx+SgUcUs6nBmkvmA/mk
   iUysjkq2ybwhm/GxNCZnV+yKZEDB3Ro/Dm31mt9nMe13l5QpRS22FU/hN
   IYQi6Irq+x2pjG3O/hPCirgFyHJbvxwub9P2Q9AlwMOU4ygi+e7+0zkeV
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="143525587"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="143525587"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:01:57 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:01:57 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 3/7] dt-bindings: tpm: Add previously undocumented properties
Date:   Fri, 30 Sep 2022 18:51:12 +0200
Message-ID: <20220930165116.13329-4-Alexander.Steffen@infineon.com>
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

TPM devices may use some more properties than previously allowed by
trivial-devices.yaml. Document those in trivial-tpms.yaml.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 .../bindings/security/tpm/trivial-tpms.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
index 2092341c6491..a9e2dd17b1ca 100644
--- a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
+++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
@@ -25,6 +25,22 @@ properties:
 
   spi-max-frequency: true
 
+  linux,sml-base:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: |
+      64-bit base address of the reserved memory allocated for the firmware
+      event log
+
+  linux,sml-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size of the memory allocated for the firmware event log
+
+  powered-while-suspended:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Present when the TPM is left powered on between suspend and resume
+      (makes the suspend/resume callbacks do nothing).
+
   compatible:
     contains:
       enum:
-- 
2.25.1

