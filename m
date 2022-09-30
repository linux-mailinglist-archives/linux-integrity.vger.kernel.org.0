Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8E5F1069
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiI3RDH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiI3RDG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:06 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 10:03:04 PDT
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8392CE26;
        Fri, 30 Sep 2022 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557385; x=1696093385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXpovvhc1F99+qouUSx7eKoSRNU23zayh3V3g0+X1+8=;
  b=YU/yPf/YaUmjJJ4Q+0DKNlReU45snWTj89LO1VvQXgRtZhC4xF4hZzp/
   UbHQlmx8cRq9hFzRt9oorMaryHTW5bAE++jyYIWDdJ8YB6IQmURCldxbG
   eYrDPyqc1xJOy34LRGGbOUdhQUBWwQ++hli6ain+SdkESk6ofz9vsKLIe
   w=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="143525586"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="143525586"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:01:57 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:01:56 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 2/7] dt-bindings: tpm: Improve documentation of compatibles
Date:   Fri, 30 Sep 2022 18:51:11 +0200
Message-ID: <20220930165116.13329-3-Alexander.Steffen@infineon.com>
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

Add missing information:
* Device name, for discoverability
* Interface, to distinguish otherwise similar devices
* TPM version, so that outdated devices can be deprecated in the future

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 .../bindings/security/tpm/trivial-tpms.yaml        | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
index fadd4ca96554..2092341c6491 100644
--- a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
+++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
@@ -28,21 +28,21 @@ properties:
   compatible:
     contains:
       enum:
-          # i2c trusted platform module (TPM)
+          # Atmel AT97SC3204T I2C TPM 1.2
         - atmel,at97sc3204t
-          # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
+          # Infineon SLB9635 I2C TPM 1.2 (old protocol, max 100khz)
         - infineon,slb9635tt
-          # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+          # Infineon SLB9645 I2C TPM 1.2 (new protocol, max 400khz)
         - infineon,slb9645tt
           # Infineon SLB9673 I2C TPM 2.0
         - infineon,slb9673
-          # i2c trusted platform module (TPM)
+          # Nuvoton NPCT501 I2C TPM 1.2
         - nuvoton,npct501
-          # i2c trusted platform module (TPM2)
+          # Nuvoton NPCT601 I2C TPM 2.0
         - nuvoton,npct601
-          # Socionext SynQuacer TPM MMIO module
+          # Socionext SynQuacer MMIO TPM
         - socionext,synquacer-tpm-mmio
-          # i2c trusted platform module (TPM)
+          # Winbond WPCT301 I2C TPM 1.2
         - winbond,wpct301
 
 required:
-- 
2.25.1

