Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8572EA71
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jun 2023 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbjFMSDU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jun 2023 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbjFMSDU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jun 2023 14:03:20 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861E13E;
        Tue, 13 Jun 2023 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1686679399; x=1718215399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pcn4JBKT2FT6yd1+VzPQHvpUKyuNh4EHo//3ud20mE=;
  b=JQ0jWuAdI90t7G7oOkkrKO4bSiUT81cJ7cfEYlKDst6nfaLQsAlgclCI
   nwzpEkNLVaK9AVhAx4s5xLZdYg9BpRuFS1LYZrQ50v+RgcivbV9iO5OXQ
   PaP6GGSK2u+MYRHbP/L76sTzt70UZWLPbS9Iplvg4cJqN3F0ixYLAe8UW
   4=;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="18551330"
X-IronPort-AV: E=Sophos;i="6.00,240,1681164000"; 
   d="scan'208";a="18551330"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 20:03:17 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 13 Jun
 2023 20:03:16 +0200
Received: from ISCNPC0VBFBX.infineon.com (10.161.6.196) by
 KLUSE818.infineon.com (172.28.156.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 20:03:16 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v3 2/4] tpm_tis: Move CRC check to generic send routine
Date:   Tue, 13 Jun 2023 20:02:57 +0200
Message-ID: <20230613180259.3525-3-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20230613180259.3525-1-Alexander.Steffen@infineon.com>
References: <20230613180259.3525-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.161.6.196]
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 KLUSE818.infineon.com (172.28.156.171)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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
2.25.1

