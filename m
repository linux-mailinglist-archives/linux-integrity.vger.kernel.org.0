Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAE539F94
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jun 2022 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiFAIfb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Jun 2022 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350893AbiFAIfS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Jun 2022 04:35:18 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A6F5A2C4;
        Wed,  1 Jun 2022 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654072518; x=1685608518;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GSKnelBxdWmfc7RJf11dvJoo5v+fqKtdhdUj6iF6Il0=;
  b=VnV8qzNLnfaiC734L5R530Xut9H+4/DPd3/1LB+XF4H8LEOBdJHelQl5
   69AucbnsK2MfO6pgc8UZYDDikqhk0QoSqTe6+hyyqYv9PazUnZMZOeFBg
   U0t/Nq48FPp+nOwynYtDTDsBtXOvhISlCAK6Mca7PhjAZdYvp03/Cxi0v
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="299148781"
X-IronPort-AV: E=Sophos;i="5.91,266,1647298800"; 
   d="scan'208";a="299148781"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:35:15 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Wed,  1 Jun 2022 10:35:14 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 1 Jun 2022
 10:35:14 +0200
Received: from smaha-lin-dev01.agb.infineon.com (172.23.8.247) by
 MUCSE818.infineon.com (172.23.29.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 1 Jun 2022 10:35:13 +0200
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <stefan.mahnke-hartmann@infineon.com>
Subject: [PATCH] tpm: Add upgrade/reduced mode support for TPM1.2 modules
Date:   Wed, 1 Jun 2022 10:38:11 +0200
Message-ID: <20220601083810.330809-1-stefan.mahnke-hartmann@infineon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE810.infineon.com (172.23.29.36) To
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
TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE is also valid.

As described in TCG TPM Main Part1 Design Principles, Revision 116,
chapter 9.2.1. the TPM also allows an update function in case a TPM is
in failure mode.

If the TPM in failure mode is detected, the function tpm1_auto_startup()
sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE flag. This patch simply follows
the same rationale as TPM2 in field upgrade mode.

Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
---
If you have any better suggestions, please let me know.

 drivers/char/tpm/tpm1-cmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index f7dc986fa4a0..7a42d74c450c 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -710,8 +710,10 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 		goto out;
 	rc = tpm1_do_selftest(chip);
 	if (rc) {
-		dev_err(&chip->dev, "TPM self test failed\n");
-		goto out;
+		dev_err(&chip->dev, "TPM self test failed, so the TPM has limited functionality\n");
+		/* A TPM in this state possibly allows or needs a firmware upgrade */
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
+		rc = 0;
 	}
 
 	return rc;
-- 
2.25.1

