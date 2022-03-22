Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376114E3D12
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 12:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiCVLBc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 07:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiCVLBa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 07:01:30 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4EE6A05C
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1647946803; x=1679482803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5xxad+ygjE25DXIo2Jz/w96/MgYU6kftq9NOPg7qp8s=;
  b=fY/lGj0A/PQX2iWfMQh5K2/gxixiZ8QppsJ1D/HQ4LRsR4494pKLC7Go
   VbpyysBSR1vo79b1IN2HOXf5MFEoOFHIJXVDUJx6OGsCKhVkXsRW+vJxB
   MOZ/9J94A57PA5SMz9MSQ4+NDA457+NoIoI4c5UJrJTecIXrJsQ31bjnV
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="286844934"
X-IronPort-AV: E=Sophos;i="5.90,201,1643670000"; 
   d="scan'208";a="286844934"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 12:00:00 +0100
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 22 Mar 2022 12:00:00 +0100 (CET)
Received: from ISCN5CG1067W80.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 12:00:00 +0100
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH v1] tpm: Fix regression in tpm_tis_synquacer.c
Date:   Tue, 22 Mar 2022 11:59:32 +0100
Message-ID: <20220322105933.1242-1-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove unused variables and type mismatch (integer from pointer without
a cast).

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
 drivers/char/tpm/tpm_tis_synquacer.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
index 2751be8e6065..679196c61401 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -39,11 +39,6 @@ static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 addr,
 					enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
-	__le16 result_le16;
-	__le32 result_le32;
-	u16 result16;
-	u32 result32;
-
 	switch (io_mode) {
 	case TPM_TIS_PHYS_8:
 		while (len--)
@@ -69,11 +64,6 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
 					 enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
-	__le16 result_le16;
-	__le32 result_le32;
-	u16 result16;
-	u32 result32;
-
 	switch (io_mode) {
 	case TPM_TIS_PHYS_8:
 		while (len--)
@@ -86,10 +76,10 @@ static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
 		 * Due to the limitation of SPI controller on SynQuacer,
 		 * 16/32 bits access must be done in byte-wise and descending order.
 		 */
-		iowrite8(&value[3], phy->iobase + addr + 3);
-		iowrite8(&value[2], phy->iobase + addr + 2);
-		iowrite8(&value[1], phy->iobase + addr + 1);
-		iowrite8(&value[0], phy->iobase + addr);
+		iowrite8(value[3], phy->iobase + addr + 3);
+		iowrite8(value[2], phy->iobase + addr + 2);
+		iowrite8(value[1], phy->iobase + addr + 1);
+		iowrite8(value[0], phy->iobase + addr);
 		break;
 	}
 
-- 
2.31.1.windows.1

