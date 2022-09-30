Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271C5F107B
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Sep 2022 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiI3RDq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Sep 2022 13:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiI3RDk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Sep 2022 13:03:40 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A271DA882;
        Fri, 30 Sep 2022 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664557418; x=1696093418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AuMdP58VIuJgHnuvfhI5Y22DBT68iqVJkmcngAf6utg=;
  b=aOirbA9pKreUi0Jk+eaRHE23Z9jtlyt2zCaaYg7fhW39YCzMIp5x467+
   U5eFu8N7qMIo9PGakQ719AvBgVQoXQBOglRucPFvE266c9/zTaO+W6g2w
   h7zw9FuLBagvw7gQU7ZMjA017peHCawI69XouG82SDTm7PdBDZNQ+lpxi
   Q=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="143525933"
X-IronPort-AV: E=Sophos;i="5.93,358,1654552800"; 
   d="scan'208";a="143525933"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 19:03:32 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 30 Sep 2022 19:03:32 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 19:03:32 +0200
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
Subject: [PATCH 7/7] tpm: Add missing compatibles to drivers
Date:   Fri, 30 Sep 2022 19:03:12 +0200
Message-ID: <20220930170312.13419-3-Alexander.Steffen@infineon.com>
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

Those have been added to the documentation before, now also add them to
the drivers.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_i2c.c      | 2 ++
 drivers/char/tpm/tpm_tis_spi_main.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index ba0911b1d1ff..a2ae2eafed6d 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -369,6 +369,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 #ifdef CONFIG_OF
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
+	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..274c35982a05 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -234,6 +234,7 @@ MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
 static const struct of_device_id of_tis_spi_match[] = {
 	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
+	{ .compatible = "tcg,tpm-tis-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "google,cr50", .data = cr50_spi_probe },
 	{}
-- 
2.25.1

