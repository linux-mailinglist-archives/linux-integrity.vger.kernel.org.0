Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD98543A79
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiFHRcF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiFHRb4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 13:31:56 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF8F5C;
        Wed,  8 Jun 2022 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654709513; x=1686245513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xB3txhfkl0VivXr33UmlzyXm5J+9YW5QDhcSrJH3aUk=;
  b=MVUpl70wTuPRY9HIFUmZsDduyxowday9+wyHyhvoeWg3g5JAF2zYqEOe
   MLqqH6knvC/B6sqAGY+wlzGbgEK7FEg8O3L+XFR0fHC+OYNGrppA6bp3p
   kqVqq9aUygaVsWd2kLP2vUvDS64WTrvdECcWQVZZbrKPZHcEc6K6y2l5v
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="182831458"
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="182831458"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:31:48 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Wed,  8 Jun 2022 19:31:48 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 8 Jun 2022
 19:31:47 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 8 Jun 2022 19:31:47 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v6 1/3] dt-bindings: trivial-devices: Add Infineon SLB9673 TPM
Date:   Wed, 8 Jun 2022 19:31:11 +0200
Message-ID: <20220608173113.9232-2-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20220608173113.9232-1-Alexander.Steffen@infineon.com>
References: <20220608173113.9232-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Initial device to be supported by the upcoming tpm_tis_i2c driver. More
to be added later.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6aafa71806a3..47a88e891a06 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -139,6 +139,8 @@ properties:
           - infineon,slb9635tt
             # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
           - infineon,slb9645tt
+            # Infineon SLB9673 I2C TPM 2.0
+          - infineon,slb9673
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280
-- 
2.25.1

