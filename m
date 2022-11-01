Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC45614304
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 03:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKACEc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 22:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKACEb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 22:04:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526155583
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f37so21835639lfv.8
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksjL9ufW8c1MPdBzxowE9ajMhhVqL34CT4/l1yzhAQU=;
        b=FRbbE2NOpze/hGsCD7MVY3dKVwYwliBgkhiB05ZE9omyUwxPOKIQWTAyk2CbCYSXAs
         /DM00yNAiR+AGaE6FZ1C6H4ZC9X5byiXxHSumKBQ6MOJLBQlzy4bk3zBD3+863sk3ERn
         6h+NOqF+DUmJtxT3KhrwXDzHXPYiuU6YvvxlZsABKSeAHxWvyc7gxzpgAMWE+AyXK1Wq
         iftRkd6OvigKzZ8kr4WqR1fsBVqePpi8p+/k5xKtjmRF4SZ/7bs/Rwf1RDPa9Zd1r5Wl
         UzeJx5KKplBg3/mWk8V7cdLj02G7bZhPcZfT698ixFZ2Y1RNth4fh6BNDIOv82onkC14
         BPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksjL9ufW8c1MPdBzxowE9ajMhhVqL34CT4/l1yzhAQU=;
        b=5QihY+m/JdK20NlpfhjWaa7pVXZ0fAwsgCqT9+26d0KYFOxqeSY3u2SMsJVvwd5b97
         DDjp0QUBVafEpcZgSNczyKj7Y71vcyuYeFqaCMaGT9C/t4wpDFFISg50nXyaepah3hC6
         Xq0BCTWc9dSNn8COGWlVn2ASOm2Vp/rOP/UZIrX6Ufs41f3wkLsOPEZfQ8rUCrK0s10p
         OKGn0z2vlsYFAa7wfWiFCH8YITF1m3Aa4MlN94Vi7HXtSx63FV+InzkQ/E3vCt+CZJTy
         xWABDWupoeQgAHi3Dtf4awywb24PtR6NoL4W8GPCUB6GyYjrG9GoV0UyQtYuzajleF/m
         GdGw==
X-Gm-Message-State: ACrzQf0LoTFq8z8cThXZa2bVrpsKraQhjGx8hO1wqZDTvKfvaH7o9TSs
        6beGOsvSPa6bFpFiHbR44B8BE67quVYDJKd4WG0=
X-Google-Smtp-Source: AMsMyM7IHPgod4DcAI2LLg7QDieFbn3WaltYgpAei7YL/WVdkWaC8MVqzuHiyAgHQq/p7aJYcjItxg==
X-Received: by 2002:a05:6512:238e:b0:4a2:48d4:c13a with SMTP id c14-20020a056512238e00b004a248d4c13amr7231777lfv.391.1667268268283;
        Mon, 31 Oct 2022 19:04:28 -0700 (PDT)
Received: from dabros-l.roam.corp.google.com ([185.157.14.92])
        by smtp.gmail.com with ESMTPSA id k11-20020ac257cb000000b00494942bec60sm1508799lfo.17.2022.10.31.19.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:04:27 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH 2/3] char: tpm: cr50: Use generic request/relinquish locality ops
Date:   Tue,  1 Nov 2022 03:03:51 +0100
Message-Id: <20221101020352.939691-3-jsd@semihalf.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221101020352.939691-1-jsd@semihalf.com>
References: <20221101020352.939691-1-jsd@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of using static functions tpm_cr50_request_locality and
tpm_cr50_release_locality register callbacks from tpm class chip->ops
created for this purpose.

Signed-off-by: Jan Dabros <jsd@semihalf.com>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 98 ++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 77cea5b31c6e4..d3438a4ed1ef8 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bug.h>
 #include <linux/completion.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -35,6 +36,7 @@
 #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
 #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
 #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
+#define TPM_CR50_I2C_DEFAULT_LOC	0
 
 #define TPM_I2C_ACCESS(l)	(0x0000 | ((l) << 4))
 #define TPM_I2C_STS(l)		(0x0001 | ((l) << 4))
@@ -286,25 +288,26 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
 }
 
 /**
- * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
+ * tpm_cr50_check_locality() - Verify if required TPM locality is active.
  * @chip: A TPM chip.
+ * @loc: Locality to be verified
  *
  * Return:
- * - 0:		Success.
+ * - loc:	Success.
  * - -errno:	A POSIX error code.
  */
-static int tpm_cr50_check_locality(struct tpm_chip *chip)
+static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
 {
 	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
 	u8 buf;
 	int rc;
 
-	rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
+	rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
 	if (rc < 0)
 		return rc;
 
 	if ((buf & mask) == mask)
-		return 0;
+		return loc;
 
 	return -EIO;
 }
@@ -312,48 +315,57 @@ static int tpm_cr50_check_locality(struct tpm_chip *chip)
 /**
  * tpm_cr50_release_locality() - Release TPM locality.
  * @chip:	A TPM chip.
- * @force:	Flag to force release if set.
+ * @loc:	Locality to be released
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	A POSIX error code.
  */
-static void tpm_cr50_release_locality(struct tpm_chip *chip, bool force)
+static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
 {
 	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
-	u8 addr = TPM_I2C_ACCESS(0);
+	u8 addr = TPM_I2C_ACCESS(loc);
 	u8 buf;
+	int rc;
 
-	if (tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf)) < 0)
-		return;
+	rc = tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf));
+	if (rc < 0)
+		return rc;
 
-	if (force || (buf & mask) == mask) {
+	if ((buf & mask) == mask) {
 		buf = TPM_ACCESS_ACTIVE_LOCALITY;
-		tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
+		rc = tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
 	}
+
+	return rc;
 }
 
 /**
- * tpm_cr50_request_locality() - Request TPM locality 0.
+ * tpm_cr50_request_locality() - Request TPM locality.
  * @chip: A TPM chip.
+ * @loc: Locality to be requested.
  *
  * Return:
- * - 0:		Success.
+ * - loc:	Success.
  * - -errno:	A POSIX error code.
  */
-static int tpm_cr50_request_locality(struct tpm_chip *chip)
+static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
 {
 	u8 buf = TPM_ACCESS_REQUEST_USE;
 	unsigned long stop;
 	int rc;
 
-	if (!tpm_cr50_check_locality(chip))
-		return 0;
+	if (tpm_cr50_check_locality(chip, loc) == loc)
+		return loc;
 
-	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
+	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
 	if (rc < 0)
 		return rc;
 
 	stop = jiffies + chip->timeout_a;
 	do {
-		if (!tpm_cr50_check_locality(chip))
-			return 0;
+		if (tpm_cr50_check_locality(chip, loc) == loc)
+			return loc;
 
 		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 	} while (time_before(jiffies, stop));
@@ -374,7 +386,9 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
 {
 	u8 buf[4];
 
-	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
+	WARN_ONCE((chip->locality < 0), "Incorrect tpm locality value\n");
+
+	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0)
 		return 0;
 
 	return buf[0];
@@ -390,7 +404,9 @@ static void tpm_cr50_i2c_tis_set_ready(struct tpm_chip *chip)
 {
 	u8 buf[4] = { TPM_STS_COMMAND_READY };
 
-	tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), buf, sizeof(buf));
+	WARN_ONCE((chip->locality < 0), "Incorrect tpm locality value\n");
+
+	tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf));
 	msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 }
 
@@ -420,7 +436,7 @@ static int tpm_cr50_i2c_get_burst_and_status(struct tpm_chip *chip, u8 mask,
 	stop = jiffies + chip->timeout_b;
 
 	do {
-		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0) {
+		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0) {
 			msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 			continue;
 		}
@@ -454,10 +470,12 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 
 	u8 mask = TPM_STS_VALID | TPM_STS_DATA_AVAIL;
 	size_t burstcnt, cur, len, expected;
-	u8 addr = TPM_I2C_DATA_FIFO(0);
+	u8 addr = TPM_I2C_DATA_FIFO(chip->locality);
 	u32 status;
 	int rc;
 
+	WARN_ONCE((chip->locality < 0), "Incorrect tpm locality value\n");
+
 	if (buf_len < TPM_HEADER_SIZE)
 		return -EINVAL;
 
@@ -516,7 +534,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 		goto out_err;
 	}
 
-	tpm_cr50_release_locality(chip, false);
 	return cur;
 
 out_err:
@@ -524,7 +541,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
 		tpm_cr50_i2c_tis_set_ready(chip);
 
-	tpm_cr50_release_locality(chip, false);
 	return rc;
 }
 
@@ -546,9 +562,7 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	u32 status;
 	int rc;
 
-	rc = tpm_cr50_request_locality(chip);
-	if (rc < 0)
-		return rc;
+	WARN_ONCE((chip->locality < 0), "Incorrect tpm locality value\n");
 
 	/* Wait until TPM is ready for a command */
 	stop = jiffies + chip->timeout_b;
@@ -578,7 +592,8 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		 * that is inserted by tpm_cr50_i2c_write()
 		 */
 		limit = min_t(size_t, burstcnt - 1, len);
-		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(0), &buf[sent], limit);
+		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(chip->locality),
+					&buf[sent], limit);
 		if (rc < 0) {
 			dev_err(&chip->dev, "Write failed\n");
 			goto out_err;
@@ -599,7 +614,7 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	}
 
 	/* Start the TPM command */
-	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), tpm_go,
+	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), tpm_go,
 				sizeof(tpm_go));
 	if (rc < 0) {
 		dev_err(&chip->dev, "Start command failed\n");
@@ -612,7 +627,6 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
 		tpm_cr50_i2c_tis_set_ready(chip);
 
-	tpm_cr50_release_locality(chip, false);
 	return rc;
 }
 
@@ -651,6 +665,8 @@ static const struct tpm_class_ops cr50_i2c = {
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = &tpm_cr50_i2c_req_canceled,
+	.request_locality = &tpm_cr50_request_locality,
+	.relinquish_locality = &tpm_cr50_release_locality,
 };
 
 #ifdef CONFIG_ACPI
@@ -686,6 +702,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	u32 vendor;
 	u8 buf[4];
 	int rc;
+	int loc;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -728,24 +745,30 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 			 TPM_CR50_TIMEOUT_NOIRQ_MS);
 	}
 
-	rc = tpm_cr50_request_locality(chip);
-	if (rc < 0) {
+	loc = tpm_cr50_request_locality(chip, TPM_CR50_I2C_DEFAULT_LOC);
+	if (loc < 0) {
 		dev_err(dev, "Could not request locality\n");
 		return rc;
 	}
 
 	/* Read four bytes from DID_VID register */
-	rc = tpm_cr50_i2c_read(chip, TPM_I2C_DID_VID(0), buf, sizeof(buf));
+	rc = tpm_cr50_i2c_read(chip, TPM_I2C_DID_VID(loc), buf, sizeof(buf));
 	if (rc < 0) {
 		dev_err(dev, "Could not read vendor id\n");
-		tpm_cr50_release_locality(chip, true);
+		if (tpm_cr50_release_locality(chip, loc))
+			dev_err(dev, "Could not release locality\n");
+		return rc;
+	}
+
+	rc = tpm_cr50_release_locality(chip, loc);
+	if (rc) {
+		dev_err(dev, "Could not release locality\n");
 		return rc;
 	}
 
 	vendor = le32_to_cpup((__le32 *)buf);
 	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
 		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
-		tpm_cr50_release_locality(chip, true);
 		return -ENODEV;
 	}
 
@@ -774,7 +797,6 @@ static void tpm_cr50_i2c_remove(struct i2c_client *client)
 	}
 
 	tpm_chip_unregister(chip);
-	tpm_cr50_release_locality(chip, true);
 }
 
 static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
-- 
2.38.1.273.g43a17bfeac-goog

