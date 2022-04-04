Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060C4F10BF
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Apr 2022 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbiDDIVR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 04:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbiDDIVM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 04:21:12 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB63B3F5;
        Mon,  4 Apr 2022 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1649060356; x=1680596356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5/V/b34epGg8B1yd9EkHhKeSrC0QZBHyPFuqOyeHGo=;
  b=mKY/+WlisFdQkbPz+bL076gMSZdoInu1txwSmdXeDTGHz2XRP2W2crbd
   yvWpSlT/cks5gAyZf1N/jzS9CHLCKORPHFbw+E56y97LSCNYKqNfO6bh8
   buboKuuTccx9Rb01mPK/eJDQ1eT5wVdJ1RSa3SoZWINJxUrHzFVmImXmv
   o=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="115548210"
X-IronPort-AV: E=Sophos;i="5.90,233,1643670000"; 
   d="scan'208";a="115548210"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 10:19:14 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Mon,  4 Apr 2022 10:19:13 +0200 (CEST)
Received: from ISCN5CG1067W80.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 10:19:12 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <amirmizi6@gmail.com>, <robh@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH 3/4] tpm: Implement command and response retry in tpm_tis_core
Date:   Mon, 4 Apr 2022 10:18:34 +0200
Message-ID: <20220404081835.495-3-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20220404081835.495-1-johannes.holland@infineon.com>
References: <20220404081835.495-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
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

Some errors during command transmission and response reception are
recoverable. Implement the specified retry mechanisms.

Recoverable errors during response reception:
 * invalid response size during header read
 * left over data:
   a communication error can lead to a FIFO read of 0xFFs and an
   unexpected STS.dataAvail = 1, subsequently
 * CRC mismatch

Recoverable errors during transmit:
 * CRC mismatch

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 98 +++++++++++++++++++--------------
 drivers/char/tpm/tpm_tis_core.h |  1 +
 2 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index f1c893a5a38f..a2b6fba7f719 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -287,6 +287,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
+	int i = 0;
 	int status;
 	u32 expected;
 	int rc;
@@ -296,45 +297,52 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
-	size = recv_data(chip, buf, TPM_HEADER_SIZE);
-	/* read first 10 bytes, including tag, paramsize, and result */
-	if (size < TPM_HEADER_SIZE) {
-		dev_err(&chip->dev, "Unable to read header\n");
-		goto out;
-	}
+	do {
+		if (size < 0)
+			tpm_tis_write8(priv, TPM_STS(priv->locality),
+				       TPM_STS_RESPONSE_RETRY);
+
+		size = recv_data(chip, buf, TPM_HEADER_SIZE);
+		/* read first 10 bytes, including tag, paramsize, and result */
+		if (size < TPM_HEADER_SIZE) {
+			dev_err(&chip->dev, "Unable to read header\n");
+			goto out;
+		}
 
-	expected = be32_to_cpu(*(__be32 *) (buf + 2));
-	if (expected > count || expected < TPM_HEADER_SIZE) {
-		size = -EIO;
-		goto out;
-	}
+		expected = be32_to_cpu(*(__be32 *)(buf + 2));
+		if (expected > count || expected < TPM_HEADER_SIZE) {
+			dev_info(&chip->dev, "Bad response size: %d. Retry...\n", expected);
+			size = -EIO;
+			continue;
+		}
 
-	size += recv_data(chip, &buf[TPM_HEADER_SIZE],
-			  expected - TPM_HEADER_SIZE);
-	if (size < expected) {
-		dev_err(&chip->dev, "Unable to read remainder of result\n");
-		size = -ETIME;
-		goto out;
-	}
+		size += recv_data(chip, &buf[TPM_HEADER_SIZE],
+				expected - TPM_HEADER_SIZE);
+		if (size < expected) {
+			dev_err(&chip->dev, "Unable to read remainder of result\n");
+			size = -ETIME;
+			goto out;
+		}
 
-	if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
-				&priv->int_queue, false) < 0) {
-		size = -ETIME;
-		goto out;
-	}
-	status = tpm_tis_status(chip);
-	if (status & TPM_STS_DATA_AVAIL) {	/* retry? */
-		dev_err(&chip->dev, "Error left over data\n");
-		size = -EIO;
-		goto out;
-	}
+		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
+				      &priv->int_queue, false) < 0) {
+			size = -ETIME;
+			goto out;
+		}
+		status = tpm_tis_status(chip);
+		if (status & TPM_STS_DATA_AVAIL) {
+			dev_info(&chip->dev, "Error left over data. Retry...\n");
+			size = -EIO;
+			continue;
+		}
 
-	rc = tpm_tis_verify_crc(priv, (size_t)size, buf);
-	if (rc < 0) {
-		dev_err(&chip->dev, "Error crc mismatch for response.\n");
-		size = rc;
-		goto out;
-	}
+		rc = tpm_tis_verify_crc(priv, (size_t)size, buf);
+		if (rc < 0) {
+			dev_info(&chip->dev, "Error crc mismatch for response. Retry...\n");
+			size = rc;
+			continue;
+		}
+	} while (unlikely(size < 0) && i++ < TPM_RETRY);
 
 out:
 	tpm_tis_ready(chip);
@@ -444,18 +452,24 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc;
+	int i = 0;
 	u32 ordinal;
 	unsigned long dur;
 
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	do {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc < 0)
+			return rc;
 
-	rc = tpm_tis_verify_crc(priv, len, buf);
-	if (rc < 0) {
-		dev_err(&chip->dev, "Error crc mismatch for command.\n");
+		rc = tpm_tis_verify_crc(priv, len, buf);
+		if (rc < 0) {
+			dev_info(&chip->dev, "Error crc mismatch for command. Retry...\n");
+			tpm_tis_ready(chip);
+		}
+	} while (unlikely(rc < 0) && i++ < TPM_RETRY);
+
+	if (rc < 0)
 		return rc;
-	}
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 21b4a67c9aac..b4b36d5c5514 100644
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
2.31.1.windows.1

