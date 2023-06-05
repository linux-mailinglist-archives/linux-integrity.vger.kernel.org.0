Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64EF722DF2
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjFERxa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjFERx2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 13:53:28 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B279100;
        Mon,  5 Jun 2023 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1685987607; x=1717523607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9H0eyeHOdjewny8tzzedWjAUOkDdFz5OOsBgwYf/hM=;
  b=ln13UZZc9v+A3SRds2Y6QsIrFJxYaAQ9U9QlYLX31r2Oh5e2PVuKEx+r
   Wd655OUxB3/HBPeO96/eC/vG4DCbF4d3PTCXE0iXyPxM9gS1r7mMdvoRz
   J/VM4E9MrfPC04KPXaJF9hOrQhiML6c3EOazBvnBsJFKMS6ggVrtvtf0W
   I=;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="17446197"
X-IronPort-AV: E=Sophos;i="6.00,218,1681164000"; 
   d="scan'208";a="17446197"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:53:24 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 19:53:24 +0200
Received: from ISCNPC0VBFBX.infineon.com (10.161.6.196) by
 KLUSE818.infineon.com (172.28.156.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 19:53:23 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH 1/4] tpm_tis: Explicitly check for error code
Date:   Mon, 5 Jun 2023 19:52:47 +0200
Message-ID: <20230605175250.2055-2-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20230605175250.2055-1-Alexander.Steffen@infineon.com>
References: <20230605175250.2055-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.161.6.196]
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 KLUSE818.infineon.com (172.28.156.171)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

recv_data either returns the number of received bytes, or a negative value
representing an error code. Adding the return value directly to the total
number of received bytes therefore looks a little weird, since it might add
a negative error code to a sum of bytes.

The following check for size < expected usually makes the function return
ETIME in that case, so it does not cause too many problems in practice. But
to make the code look cleaner and because the caller might still be
interested in the original error code, explicitly check for the presence of
an error code and pass that through.

Change-Id: I5a310daaa71f0acaaf7fff62cadd79d5edaa9207
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 558144fa707a..aaaa136044ae 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -363,8 +363,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
+	rc = recv_data(chip, &buf[TPM_HEADER_SIZE],
+		       expected - TPM_HEADER_SIZE);
+	if (rc < 0) {
+		size = rc;
+		goto out;
+	}
+	size += rc;
 	if (size < expected) {
 		dev_err(&chip->dev, "Unable to read remainder of result\n");
 		size = -ETIME;
-- 
2.34.1

