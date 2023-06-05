Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE8722E13
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjFESAP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjFESAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 14:00:12 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC864F1;
        Mon,  5 Jun 2023 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1685988011; x=1717524011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=89MCpdG+JGXZTxJwkWPn/J+rl3u69O0nt8q8tvWyKNM=;
  b=nFQPneGteeYZdHM9WhK5PtnP5+kZPzwN56kRiYfX2VPlYvJFoRaMGQbS
   gl8ae5xwM4mdCLrulJEbOAQx0YEvdyi7mEJPgasRgaO8VvpsMBqsFB9Tx
   DEo9rELqEdS60rqlpEqxbzSZFIyvmQviag/ENB1L5w0QibbdP7YHqxU7v
   c=;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="17446835"
X-IronPort-AV: E=Sophos;i="6.00,218,1681164000"; 
   d="scan'208";a="17446835"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 20:00:09 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 20:00:09 +0200
Received: from ISCNPC0VBFBX.infineon.com (10.161.6.196) by
 KLUSE818.infineon.com (172.28.156.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 20:00:08 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v2 2/4] tpm_tis: Move CRC check to generic send routine
Date:   Mon, 5 Jun 2023 19:59:57 +0200
Message-ID: <20230605175959.2131-3-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
References: <20230605175959.2131-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.161.6.196]
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
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

The CRC functionality is initialized before tpm_tis_core, so it can be used
on all code paths within the module. Therefore, move the CRC check to the
generic send routine, that also contains all other checks for successful
command transmission, so that all those checks are in one place.

Also, this ensures that tpm_tis_ready is called when a CRC failure is
detected, to clear the invalid data from the TPM, which did not happen
previously.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index aaaa136044ae..5ddaf24518be 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -466,6 +466,12 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		goto out_err;
 	}
 
+	rc = tpm_tis_verify_crc(priv, len, buf);
+	if (rc < 0) {
+		dev_err(&chip->dev, "CRC mismatch for command.\n");
+		goto out_err;
+	}
+
 	return 0;
 
 out_err:
@@ -510,12 +516,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (rc < 0)
 		return rc;
 
-	rc = tpm_tis_verify_crc(priv, len, buf);
-	if (rc < 0) {
-		dev_err(&chip->dev, "CRC mismatch for command.\n");
-		return rc;
-	}
-
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
-- 
2.34.1

