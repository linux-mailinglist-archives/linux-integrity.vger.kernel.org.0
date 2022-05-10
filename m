Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7E5213C8
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiEJLfH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiEJLfE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 07:35:04 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4762FFEC;
        Tue, 10 May 2022 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1652182267; x=1683718267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2SNelXJdTh3xGopHG8ofy7R9HS6iWQB+gEljljkwN88=;
  b=lgkF0Z5EDZK523ENyRA0OfwRx2/qnh8j6PSVHrrkT60uWZEKM5KhnOyt
   jkgxxZ5+3DW5t7CWDztkDfNp2ZG9HRd1D0wHRkC82A1A0E2UO/hbTIipb
   MNCXu1vERuhCwzhCfec09VxaLE1lJyBA8u3Fy4zsl+uBg7gP44FoKYLsD
   Y=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="119943251"
X-IronPort-AV: E=Sophos;i="5.91,214,1647298800"; 
   d="scan'208";a="119943251"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 13:31:04 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 10 May 2022 13:31:03 +0200 (CEST)
Received: from ISCN5CG1067W80.muc.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 13:30:59 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
Date:   Tue, 10 May 2022 13:29:03 +0200
Message-ID: <20220510112902.23213-1-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To comply with protocol requirements, minimum polling times must often
be adhered to. Therefore, a macro like tpm_msleep() should sleep at
least the given amount of time (not up to the given period). Have
tpm_msleep() sleep at least the given number of milliseconds.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
 drivers/char/tpm/tpm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2163c6ee0d36..0971b55fffe3 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
 
 static inline void tpm_msleep(unsigned int delay_msec)
 {
-	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
-		     delay_msec * 1000);
+	usleep_range(delay_msec * 1000, (delay_msec * 1000)
+		     + TPM_TIMEOUT_RANGE_US);
 };
 
 int tpm_chip_start(struct tpm_chip *chip);
-- 
2.34.1

