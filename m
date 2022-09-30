Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997435F1076
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiI3RDn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiI3RDg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:36 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC281D8F34;
        Fri, 30 Sep 2022 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557414; x=1696093414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VUi0yVf68uttuxGY8vSD9s/gXtmLvH2OkXk8bI2crYc=;
  b=bCqn9ajau5bnslsPnF4lxovvyxShE58Qh5lumRJ580PFuyKQHdMt83Fl
   MYPBRDCEyJ9rIxgRP/39zgn35HEb9AFGSzUhbPaVgtpVlk7OXCwYyLGhI
   5CnpjtzWX5Kfqrr3aaOQjHdYMmSp8SsBMpW7rAcwW0p6ZRLKYMsLQjTiR
   U=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="2634089"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="2634089"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:03:32 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:03:32 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 6/7] dt-bindings: tpm: Add fallbacks for all TCG-compliant TPM variants
Date:   Fri, 30 Sep 2022 19:03:11 +0200
Message-ID: <20220930170312.13419-2-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20220930170312.13419-1-Alexander.Steffen@infineon.com>
References: <20220930170312.13419-1-Alexander.Steffen@infineon.com>
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

Also, use the same spelling for all of them and mark the one exception as
deprecated.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 .../devicetree/bindings/security/tpm/trivial-tpms.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
index ebaa36f0875e..983c0a7cc6e1 100644
--- a/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
+++ b/Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml
@@ -76,9 +76,13 @@ properties:
         - socionext,synquacer-tpm-mmio
           # STMicroelectronics ST33TPHF2xSPI TPM 2.0
         - st,st33htpm-spi
+          # TCG TIS-compliant I2C TPM (generic fallback)
+        - tcg,tpm-tis-i2c
           # TCG TIS-compliant MMIO TPM (generic fallback)
         - tcg,tpm-tis-mmio
           # TCG TIS-compliant SPI TPM (generic fallback)
+        - tcg,tpm-tis-spi
+          # TCG TIS-compliant SPI TPM (generic fallback, deprecated)
         - tcg,tpm_tis-spi
           # Winbond WPCT301 I2C TPM 1.2
         - winbond,wpct301
-- 
2.25.1

