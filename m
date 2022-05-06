Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6626F51DE13
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444053AbiEFRIF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444052AbiEFRIE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 13:08:04 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED144D9E7;
        Fri,  6 May 2022 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1651856661; x=1683392661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kp2J7p8Gzuy8WcmKBo8MR2QLb9vJ2qnC+70trGBmjjA=;
  b=CLOpefQBOo/MHdf/FfEzRaMFXVaeQTRe0DdFS8fGWZUvEYwgfS4iDyxV
   5lPjv3PMLkcOfz9oKE5+azlqKLQGgtI79dy0RagNp6DM0GgAD7NTavBy/
   +Hxx7rPmG97VJ6K+3zDV6l/yFMAXjSx4vm00PlaqviH9cMDEENyCVD1/R
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293288928"
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="293288928"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 19:04:18 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 19:04:18 +0200 (CEST)
Received: from ISCN5CG1067W80.agb.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 19:04:18 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH v2 3/4] tpm: Implement command and response retry in tpm_tis_core
Date:   Fri, 6 May 2022 19:00:15 +0200
Message-ID: <20220506170013.22598-3-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220506170013.22598-1-johannes.holland@infineon.com>
References: <20220506170013.22598-1-johannes.holland@infineon.com>
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
index 66a5a13cd1df..d3d7c45cb762 100644
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
2.34.1

