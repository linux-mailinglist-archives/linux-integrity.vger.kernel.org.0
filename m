Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DF53CB9A
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jun 2022 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245130AbiFCOfw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jun 2022 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbiFCOfv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jun 2022 10:35:51 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5135045E;
        Fri,  3 Jun 2022 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654266950; x=1685802950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AyOTPTgLqbYDShkfugp5O/fooG0CdJCxOl7r7wFid8E=;
  b=VbiqgxfOE5SMAuVr0n0qkFRrdQ6Igkle/HZBbNa1ZOjkjz9Dm+SsRG9e
   HMimoOrVx2/wK+uNJpgZ/Cm49EEIVq6TNligossztGsZncckwWdbeRTX9
   bUqlzRLofNBoVRRMx3JWLyNPfdzjiyejVA3rQV+Rs8g7T3htv7HUQ5c6P
   k=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="125104039"
X-IronPort-AV: E=Sophos;i="5.91,274,1647298800"; 
   d="scan'208";a="125104039"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 16:35:47 +0200
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  3 Jun 2022 16:35:47 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 3 Jun 2022
 16:35:46 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Fri, 3 Jun 2022 16:35:46 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v5 2/3] tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer
Date:   Fri, 3 Jun 2022 16:35:31 +0200
Message-ID: <20220603143532.8202-3-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20220603143532.8202-1-Alexander.Steffen@infineon.com>
References: <20220603143532.8202-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some TPMs, e.g. those implementing the I2C variant of TIS, can verify
data transfers to/from the FIFO with a CRC. The CRC is calculated over
the entirety of the FIFO register. Since the phy_ops layer is not aware
when the core layer is done reading/writing the FIFO, CRC verification
must be triggered from the core layer. To this end, add an optional
phy_ops API call.

Co-developed-by: Johannes Holland <johannes.holland@infineon.com>
Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Change-Id: I43716c8d45f62c0fcdaabfc3366f8deb89fd1f32
---
 drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
 drivers/char/tpm/tpm_tis_core.h | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index dc56b976d816..757623bacfd5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -289,6 +289,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0;
 	int status;
 	u32 expected;
+	int rc;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -328,6 +329,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
+	rc = tpm_tis_verify_crc(priv, (size_t)size, buf);
+	if (rc < 0) {
+		dev_err(&chip->dev, "CRC mismatch for response.\n");
+		size = rc;
+		goto out;
+	}
+
 out:
 	tpm_tis_ready(chip);
 	return size;
@@ -443,6 +451,12 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (rc < 0)
 		return rc;
 
+	rc = tpm_tis_verify_crc(priv, len, buf);
+	if (rc < 0) {
+		dev_err(&chip->dev, "CRC mismatch for command.\n");
+		return rc;
+	}
+
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6c203f36b8a1..66a5a13cd1df 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -121,6 +121,8 @@ struct tpm_tis_phy_ops {
 			  u8 *result, enum tpm_tis_io_mode mode);
 	int (*write_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
 			   const u8 *value, enum tpm_tis_io_mode mode);
+	int (*verify_crc)(struct tpm_tis_data *data, size_t len,
+			  const u8 *value);
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
@@ -188,6 +190,14 @@ static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
 	return rc;
 }
 
+static inline int tpm_tis_verify_crc(struct tpm_tis_data *data, size_t len,
+				     const u8 *value)
+{
+	if (!data->phy_ops->verify_crc)
+		return 0;
+	return data->phy_ops->verify_crc(data, len, value);
+}
+
 static inline bool is_bsw(void)
 {
 #ifdef CONFIG_X86
-- 
2.25.1

