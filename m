Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E455341D6
	for <lists+linux-integrity@lfdr.de>; Wed, 25 May 2022 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiEYQ7O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 May 2022 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245549AbiEYQ7J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 May 2022 12:59:09 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C55A5037;
        Wed, 25 May 2022 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1653497947; x=1685033947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dymnBxY2vuS1CRRGk1ytxV9OMADaUdrv7fRDs/cMwXk=;
  b=SoDSOC3rtONmEeJR5ipTlv6xpPh03n40wWlydd2271sxeQ7wvBEebAFY
   81uElhOMPp6bFZ2+bxo6vnD0qK2328FHsXM/0rMW0A/BEOzOWk1t4LWnH
   c6YicVIDrTT8QNDsYYvzOjUmvNJZ8R95pp+1LbSVKZOT51SUreoMFpa4e
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="297939393"
X-IronPort-AV: E=Sophos;i="5.91,250,1647298800"; 
   d="scan'208";a="297939393"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 18:59:05 +0200
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 25 May 2022 18:59:05 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 25 May
 2022 18:59:04 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 25 May 2022 18:59:04 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: trivial-devices: Add two I2C TPM devices
Date:   Wed, 25 May 2022 18:58:47 +0200
Message-ID: <20220525165849.7789-2-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20220525165849.7789-1-Alexander.Steffen@infineon.com>
References: <20220525165849.7789-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
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

Both are supported by the upcoming tpm_tis_i2c driver.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 550a2e5c9e05..dc52822331dd 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -135,6 +135,8 @@ properties:
           - infineon,slb9635tt
             # Infineon SLB9645 I2C TPM (new protocol, max 400khz)
           - infineon,slb9645tt
+            # Infineon SLB9673 I2C TPM 2.0
+          - infineon,slb9673
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
             # Infineon Multi-phase Digital VR Controller xdpe11280
@@ -323,6 +325,8 @@ properties:
           - st,24c256
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
+            # TCG TIS-compliant TPM with I2C interface
+          - tcg,tpm_tis-i2c
             # Temperature Monitoring and Fan Control
           - ti,amc6821
             # Temperature and humidity sensor with i2c interface
-- 
2.25.1

