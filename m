Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322C953C70B
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jun 2022 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiFCInJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jun 2022 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiFCInI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jun 2022 04:43:08 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7471AF08;
        Fri,  3 Jun 2022 01:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654245788; x=1685781788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yxeS19Ie7EpNl/oaJ6C+O+T88X917wAoRTSCg0t/yDo=;
  b=hDWnUUpfuVuWUfF7fKyWaxGowEWUyR5tAhWeZaMHcjmgBJ38F24M0a4A
   0o+29KO1WXtZvFxwI6WGDmBu/SU/X3Kgg99Z3hd1rq3m3Aokt8r42LH+E
   snjuP+mYj39QOumeoSrtHiCRGZv/bgegv0L4gF9H1BusHFSjXYzQtHmzT
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="299504368"
X-IronPort-AV: E=Sophos;i="5.91,274,1647298800"; 
   d="scan'208";a="299504368"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:43:05 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  3 Jun 2022 10:43:04 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 3 Jun 2022
 10:43:04 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Fri, 3 Jun 2022 10:43:04 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Subject: [PATCH v3] tpm: Add upgrade/reduced mode support for TPM1.2 modules
Date:   Fri, 3 Jun 2022 10:41:58 +0200
Message-ID: <20220603084156.7090-1-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
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
 * v3:
   * Change kernel messages

 drivers/char/tpm/tpm.h      | 1 +
 drivers/char/tpm/tpm1-cmd.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2163c6ee0d36..24ee4e1cc452 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -55,6 +55,7 @@ enum tpm_addr {
 #define TPM_WARN_DOING_SELFTEST 0x802
 #define TPM_ERR_DEACTIVATED     0x6
 #define TPM_ERR_DISABLED        0x7
+#define TPM_ERR_FAILEDSELFTEST  0x1C
 #define TPM_ERR_INVALID_POSTINIT 38
 
 #define TPM_TAG_RQU_COMMAND 193
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index f7dc986fa4a0..cf64c7385105 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -709,7 +709,12 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 	if (rc)
 		goto out;
 	rc = tpm1_do_selftest(chip);
-	if (rc) {
+	if (rc == TPM_ERR_FAILEDSELFTEST) {
+		dev_warn(&chip->dev, "TPM self test failed, switching to the firmware upgrade mode\n");
+		/* A TPM in this state possibly allows or needs a firmware upgrade */
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
+		return 0;
+	} else if (rc) {
 		dev_err(&chip->dev, "TPM self test failed\n");
 		goto out;
 	}
-- 
2.25.1

