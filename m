Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0C722DF5
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjFERxe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 13:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjFERxa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 13:53:30 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A4D10B;
        Mon,  5 Jun 2023 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1685987610; x=1717523610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhugzGSrT0hfnugDbYqjGfVx3bVGA7aZy3nl5v+JSRM=;
  b=T5j7KHWhze+ABe1QOOI68YfYkVWKI4XoPaKuXPLZBoVfZhtzLelJYKBl
   QoJKxiZK56wSUoukftVm6KovpjyyzlYEJeCVv9NfFaBlRazjjRIv0m8Jw
   9mvMEIein0omDcqPSzU8WLlMoSkUyeyn5cuAv3otOZTD4pKopMLkFj2Pb
   Q=;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="40772632"
X-IronPort-AV: E=Sophos;i="6.00,218,1681164000"; 
   d="scan'208";a="40772632"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 19:53:25 +0200
Received: from KLUSE818.infineon.com (172.28.156.171) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 19:53:24 +0200
Received: from ISCNPC0VBFBX.infineon.com (10.161.6.196) by
 KLUSE818.infineon.com (172.28.156.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 5 Jun 2023 19:53:24 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH 3/4] tpm_tis: Use responseRetry to recover from data transfer errors
Date:   Mon, 5 Jun 2023 19:52:49 +0200
Message-ID: <20230605175250.2055-4-Alexander.Steffen@infineon.com>
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

TPM responses may become damaged during transmission, for example due to
bit flips on the wire. Instead of aborting when detecting such issues, the
responseRetry functionality can be used to make the TPM retransmit its
response and receive it again without errors.

Change-Id: Ifb9fa8bf2106fed6f3dfc9fae935e0bbd30d117f
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 40 ++++++++++++++++++++++++++-------
 drivers/char/tpm/tpm_tis_core.h |  1 +
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5ddaf24518be..a08768e55803 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
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
@@ -396,10 +391,39 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	}
 
 out:
-	tpm_tis_ready(chip);
 	return size;
 }
 
+static int tpm_tis_recv_with_retries(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	unsigned int try;
+	int rc = 0;
+
+	if (count < TPM_HEADER_SIZE) {
+		rc = -EIO;
+		goto out;
+	}
+
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_recv(chip, buf, count);
+
+		if (rc == -EIO) {
+			/* Data transfer errors, indicated by EIO, can be
+			 * recovered by rereading the response.
+			 */
+			tpm_tis_write8(priv, TPM_STS(priv->locality),
+				       TPM_STS_RESPONSE_RETRY);
+		} else {
+			break;
+		}
+	}
+
+out:
+	tpm_tis_ready(chip);
+	return rc;
+}
+
 /*
  * If interrupts are used (signaled by an irq set in the vendor structure)
  * tpm.c can skip polling for the data to be available as the interrupt is
@@ -986,7 +1010,7 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
 static const struct tpm_class_ops tpm_tis = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = tpm_tis_status,
-	.recv = tpm_tis_recv,
+	.recv = tpm_tis_recv_with_retries,
 	.send = tpm_tis_send,
 	.cancel = tpm_tis_ready,
 	.update_timeouts = tpm_tis_update_timeouts,
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index e978f457fd4d..8458cd4a84ec 100644
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

