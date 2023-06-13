Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5915172EA77
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jun 2023 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjFMSDZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jun 2023 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbjFMSDW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jun 2023 14:03:22 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD919B3;
        Tue, 13 Jun 2023 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1686679401; x=1718215401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xEMIE6JZW1YN5TsGLns9bWf/BYLfKZwBzKAFxtl7BSA=;
  b=QC6EqAsJR7gIIMY5u+gEgJoQeKy3iHMmDCKZwIMYqJ1ooUTxC8Z62Qzr
   pLqpM11frWfI9E+LVvoWFMYoq0Elcj75LpmnCivM6XAVa0a2H/NGKgR0W
   xRGJ3ZMFK8Wv9B6s1x/oRWrPeLkkvwjqnP5fnF10+gW/J+ZdNdFU/IKnJ
   o=;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="16924802"
X-IronPort-AV: E=Sophos;i="6.00,240,1681164000"; 
   d="scan'208";a="16924802"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 20:03:18 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v3 3/4] tpm_tis: Use responseRetry to recover from data transfer errors
Date:   Tue, 13 Jun 2023 20:02:58 +0200
Message-ID: <20230613180259.3525-4-Alexander.Steffen@infineon.com>
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

TPM responses may become damaged during transmission, for example due to
bit flips on the wire. Instead of aborting when detecting such issues, the
responseRetry functionality can be used to make the TPM retransmit its
response and receive it again without errors.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 37 ++++++++++++++++++++++++++-------
 drivers/char/tpm/tpm_tis_core.h |  1 +
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5ddaf24518be..a6d1396413a7 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -337,7 +337,7 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	return size;
 }
 
-static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+static int tpm_tis_try_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
@@ -345,11 +345,6 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	u32 expected;
 	int rc;
 
-	if (count < TPM_HEADER_SIZE) {
-		size = -EIO;
-		goto out;
-	}
-
 	size = recv_data(chip, buf, TPM_HEADER_SIZE);
 	/* read first 10 bytes, including tag, paramsize, and result */
 	if (size < TPM_HEADER_SIZE) {
@@ -382,7 +377,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 	status = tpm_tis_status(chip);
-	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
+	if (status & TPM_STS_DATA_AVAIL) {
 		dev_err(&chip->dev, "Error left over data\n");
 		size = -EIO;
 		goto out;
@@ -396,10 +391,36 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	}
 
 out:
-	tpm_tis_ready(chip);
 	return size;
 }
 
+static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	unsigned int try;
+	int rc = 0;
+
+	if (count < TPM_HEADER_SIZE)
+		return -EIO;
+
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_try_recv(chip, buf, count);
+
+		if (rc == -EIO)
+			/* Data transfer errors, indicated by EIO, can be
+			 * recovered by rereading the response.
+			 */
+			tpm_tis_write8(priv, TPM_STS(priv->locality),
+				       TPM_STS_RESPONSE_RETRY);
+		else
+			break;
+	}
+
+	tpm_tis_ready(chip);
+
+	return rc;
+}
+
 /*
  * If interrupts are used (signaled by an irq set in the vendor structure)
  * tpm.c can skip polling for the data to be available as the interrupt is
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 610bfadb6acf..3a6b600d22ba 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -34,6 +34,7 @@ enum tis_status {
 	TPM_STS_GO = 0x20,
 	TPM_STS_DATA_AVAIL = 0x10,
 	TPM_STS_DATA_EXPECT = 0x08,
+	TPM_STS_RESPONSE_RETRY = 0x02,
 	TPM_STS_READ_ZERO = 0x23, /* bits that must be zero on read */
 };
 
-- 
2.25.1

