Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC695F1079
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiI3RDn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiI3RDg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:36 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DA21D8F2D;
        Fri, 30 Sep 2022 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557414; x=1696093414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jEJA7SgFblgEmcrWe6FToX9JMzMY7RtU7J5CqLcFaTs=;
  b=U8LFe8eUt6q3k1fUFpyeIsqN7BSBp8Gc7RVQdyPWwuK7OvG48sjGEQo/
   TEqESbQfBgkaz7+20GiEu33ojGCzXDMRtFcC6XzvaqJ5rUU94THMP8PtM
   uIhoEbzqvF/KawNFCWcHYe2P1Q3LtfDMEhgey9GyFo1MNjtRuD4wNKuM5
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="143525930"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="143525930"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:03:32 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:03:31 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 19:03:31 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 19:03:31 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <Johannes.Holland@infineon.com>, <benoit.houyere@st.com>,
        <amirmizi6@gmail.com>, <peter@pjd.dev>
Subject: [PATCH 5/7] dt-bindings: tpm: Document previously undocumented compatibles
Date:   Fri, 30 Sep 2022 19:03:10 +0200
Message-ID: <20220930170312.13419-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE810.infineon.com (172.23.29.36) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some drivers or device trees are using them already, but documentation was
missing.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 .../devicetree/bindings/security/tpm/trivial-tpms.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
index 1fd7f38b7b6d..ebaa36f0875e 100644
--- a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
+++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
@@ -44,6 +44,8 @@ properties:
   compatible:
     contains:
       enum:
+          # Atmel AT97SC3201 LPC TPM 1.1b
+        - atmel,at97sc3201
           # Atmel AT97SC3204 LPC TPM 1.2
         - atmel,at97sc3204
           # Atmel AT97SC3204T I2C TPM 1.2
@@ -58,12 +60,18 @@ properties:
         - infineon,slb9670
           # Infineon SLB9673 I2C TPM 2.0
         - infineon,slb9673
+          # Infineon tpm_i2c_infineon-compatible device (deprecated)
+        - infineon,tpm_i2c_infineon
+          # Microsoft fTPM 2.0
+        - microsoft,ftpm
           # Nuvoton NPCT501 I2C TPM 1.2
         - nuvoton,npct501
           # Nuvoton NPCT601 I2C TPM 2.0
         - nuvoton,npct601
           # Nuvoton NPCT650 I2C TPM 2.0
         - nuvoton,npct650
+          # Nuvoton NPCT75x I2C TPM 2.0
+        - nuvoton,npct75x
           # Socionext SynQuacer MMIO TPM
         - socionext,synquacer-tpm-mmio
           # STMicroelectronics ST33TPHF2xSPI TPM 2.0
-- 
2.25.1

