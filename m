Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF2452633E
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiEMNuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 May 2022 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382016AbiEMNmb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 09:42:31 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A2BC0E;
        Fri, 13 May 2022 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1652449350; x=1683985350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uguWhCfJrqay1S13NWgbZNRG98dj6oaX1/xu1tlmmzM=;
  b=g1CzpIgG2Noc6I4YtTP0yXuou+aHgwq/aKxBZ8laP6osOm7B3yV41cf0
   Yz2QVsrQxPRrHVNQUtmiZvYcuLL28AdsGezLrYs238sfB9EWj9zZUNpJ2
   LCsXXksrwiXYFCoGW6PiZ3X/Aux1LeeNiNaa5LXZmZWtr5xrc1I9tavRH
   w=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="294595933"
X-IronPort-AV: E=Sophos;i="5.91,223,1647298800"; 
   d="scan'208";a="294595933"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:42:28 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 13 May 2022 15:42:27 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 15:42:27 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 15:42:27 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <nayna@linux.vnet.ibm.com>, <stefan.mahnke-hartmann@infineon.com>,
        <alexander.steffen@infineon.com>
Subject: [PATCH v2 2/2] tpm: Add field upgrade mode support for Infineon TPM2 modules
Date:   Fri, 13 May 2022 15:41:53 +0200
Message-ID: <20220513134152.270442-2-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513134152.270442-1-stefan.mahnke-hartmann@infineon.com>
References: <20220513134152.270442-1-stefan.mahnke-hartmann@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE813.infineon.com (172.23.29.39) To
 MUCSE818.infineon.com (172.23.29.44)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM2_GetCapability with a capability that has the property type value
of TPM_PT_TOTAL_COMMANDS returns a zero length list, when an Infineon
TPM2 is in field upgrade mode.
Since an Infineon TPM2.0 in field upgrade mode returns RC_SUCCESS on
TPM2_Startup, the field upgrade mode has to be detected by
TPM2_GetCapability.

Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
---
Changelog:
 * v2:
   * Move check of -ENODATA to if condition below.
   * Change 'field upgrade mode' to lower case.

 drivers/char/tpm/tpm2-cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 04a3e23a4afc..c1eb5d223839 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -754,7 +754,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	rc = tpm2_get_cc_attrs_tbl(chip);
 
 out:
-	if (rc == TPM2_RC_UPGRADE) {
+	/*
+	 * Infineon TPM in field upgrade mode will return no data for the number
+	 * of supported commands.
+	 */
+	if (rc == TPM2_RC_UPGRADE || rc == -ENODATA) {
 		dev_info(&chip->dev, "TPM in field upgrade mode, requires firmware upgrade\n");
 		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
 		rc = 0;
-- 
2.25.1

