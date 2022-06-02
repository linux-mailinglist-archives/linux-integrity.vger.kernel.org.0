Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E399553BC3A
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jun 2022 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiFBQNS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jun 2022 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiFBQNB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jun 2022 12:13:01 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9FD2B07E7;
        Thu,  2 Jun 2022 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654186376; x=1685722376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=64I2hWjSsz8ShqBRRtbrBxWa8hB+j6kiFV8hbWcV28Y=;
  b=DchHePGDOq0tpKWXoSS7MgjTfMOyRkPCuZaDSu/1BX5cLEoEmAqn3Ti9
   7s10136AP8CEPBe7jTJhJDAWoY94Mkkntz8Z7LbdCbQvWb2U4STtkjDjl
   XtirZ86PX13CDXtZ4EjaG/df7YUmqTfpdkHkQDsThje58dyLt6BKNGWQO
   Y=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="299399728"
X-IronPort-AV: E=Sophos;i="5.91,271,1647298800"; 
   d="scan'208";a="299399728"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 18:12:54 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Thu,  2 Jun 2022 18:12:53 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 2 Jun 2022
 18:12:53 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 2 Jun 2022 18:12:53 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Subject: [PATCH v2] tpm: Add upgrade/reduced mode support for TPM1.2 modules
Date:   Thu, 2 Jun 2022 18:13:01 +0200
Message-ID: <20220602161301.4281-1-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
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

In case a TPM in failure mode is detected, the TPM should be accessible
through a transparent communication channel for analysing purposes (e.g.
TPM_GetTestResult) or a field upgrade. Since a TPM in failure mode has
similar reduced functionality as in field upgrade mode, the flag
TPM_CHIP_FLAG_FIRMWARE_UPGRADE is also valid.

As described in TCG TPM Main Part1 Design Principles, Revision 116,
chapter 9.2.1. the TPM also allows an update function in case a TPM is
in failure mode.

If the TPM in failure mode is detected, the function tpm1_auto_startup()
sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE flag, which is used later during
driver initialization/deinitialization to disable functionality which
makes no sense or will fail in the current TPM state. The following
functionality is affected:
 * Do not register TPM as a hwrng
 * Do not get pcr allocation
 * Do not register sysfs entries which provide information impossible to
   obtain in limited mode

Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
---
Changelog:
 * v2:
   * Commit message updated.
   * Error handling for failed self test and other errors seperated.
.
 drivers/char/tpm/tpm.h      | 1 +
 drivers/char/tpm/tpm1-cmd.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2163c6ee0d36..c0778498bc41 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -56,6 +56,7 @@ enum tpm_addr {
 #define TPM_ERR_DEACTIVATED     0x6
 #define TPM_ERR_DISABLED        0x7
 #define TPM_ERR_INVALID_POSTINIT 38
+#define TPM_ERR_FAILEDSELFTEST  0x1C
 
 #define TPM_TAG_RQU_COMMAND 193
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index f7dc986fa4a0..fe21679ba0b6 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -709,8 +709,13 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 	if (rc)
 		goto out;
 	rc = tpm1_do_selftest(chip);
-	if (rc) {
-		dev_err(&chip->dev, "TPM self test failed\n");
+	if (rc == TPM_ERR_FAILEDSELFTEST) {
+		dev_err(&chip->dev, "TPM self test failed, so the TPM has limited functionality\n");
+		/* A TPM in this state possibly allows or needs a firmware upgrade */
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
+		return 0;
+	} else if (rc) {
+		dev_err(&chip->dev, "TPM self test not successful\n");
 		goto out;
 	}
 
-- 
2.25.1

