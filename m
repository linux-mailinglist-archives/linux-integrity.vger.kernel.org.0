Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A515F1073
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiI3RDN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiI3RDL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:11 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0771D8F16;
        Fri, 30 Sep 2022 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557390; x=1696093390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Knr+Hzq9RQYhEhNbMogwjiMXs3F1e3L5+MsZw1GVh8=;
  b=Jzq/JezhSGQAH9LyEauHsNsGG4vmtXt8Y4DOGReF70u1tXWBunpof/Yl
   kHj1xjQIIFeYJkH3WQVq6AwCYWAp0oRA4dryg9VUQurXInaQzHRDx4nU7
   JIqHiyT774jU3NHyZVMJwedlDQPKm3wPA3n/YKuGELiEdqjOiCwr3/00+
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="2633828"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="2633828"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:01:56 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:01:56 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 19:01:56 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 19:01:55 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <Johannes.Holland@infineon.com>, <benoit.houyere@st.com>,
        <amirmizi6@gmail.com>, <peter@pjd.dev>
Subject: [PATCH 0/7] Clean up TPM compatibles
Date:   Fri, 30 Sep 2022 18:51:09 +0200
Message-ID: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
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

Not all TPM compatibles were documented correctly so far. Some were not
documented at all, others missed some properties, most of them did not use the
latest YAML format. But by design most TPMs are very similar, so this allows to
document them in a single trivial-tpms.yaml, similar to how
trivial-devices.yaml documents simple I2C and SPI devices. This fixes all the
documentation issues and ensures that dtbs_check can be used in the future to
detect incorrect configurations automatically.

Alexander Steffen (7):
  dt-bindings: tpm: Introduce trivial-tpms.yaml
  dt-bindings: tpm: Improve documentation of compatibles
  dt-bindings: tpm: Add previously undocumented properties
  dt-bindings: tpm: Merge existing trivial TPMs to YAML
  dt-bindings: tpm: Document previously undocumented compatibles
  dt-bindings: tpm: Add fallbacks for all TCG-compliant TPM variants
  tpm: Add missing compatibles to drivers

 .../bindings/security/tpm/google,cr50.txt     |  19 ---
 .../bindings/security/tpm/tpm-i2c.txt         |  26 ----
 .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 ----
 .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
 .../bindings/security/tpm/trivial-tpms.yaml   | 118 ++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  16 ---
 drivers/char/tpm/tpm_tis_i2c.c                |   2 +
 drivers/char/tpm/tpm_tis_spi_main.c           |   1 +
 8 files changed, 121 insertions(+), 109 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
 create mode 100644 Documentation/devicetree/bindings/security/tpm/trivial-tpms.yaml

-- 
2.25.1

