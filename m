Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04252618042
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiKCO4D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiKCOzr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 10:55:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B119C1F
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 07:55:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b2so3257857lfp.6
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24XmB21kpqMgxYGKzD/gohKxEqtjgHf+9jw3WkxNndg=;
        b=Qz/Gu0H33QebnINGZqJ9YiO7eslQvw+NQrsbj8zYv7ZhM2/cw+fUNV/H8PM5R/jtll
         OPb7AelAUq3gcpvz8HM42srvdiMsqYIiMiGl7VEPxHGb4YLcubFaJGQZVDtU5N8hSoqM
         /KKNyZcUT1qQcmAU6uxRr3h4MYnzKMt/gozOEBvZurmhN+d0ypzIy0uEtDQALVZ20cnY
         qK9Zjjork8gcuTFpcjRMZGD2mdLqC/iLATsY8SEktEtzGBA2YvB+X5dYYNUkD9D8hwfs
         KeyxwVCPbbwzIIqME5SHjj1mNHAgfX1CpJHVVjEDZ7y5hnJ38aDNh0Gp1ktBE1O0UzSt
         01Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24XmB21kpqMgxYGKzD/gohKxEqtjgHf+9jw3WkxNndg=;
        b=C9YAF6UkAKEI9LTUbr1cVUXv2SDCjqre8BkdTxZ1HZtEEsH37960DeyRlByezNcEIp
         N2X82XKQih3Ga47kOgy0gS0Dv/q7D1VENOJCszO0eOxnT1OTACj5qGgwW6m5rhNbf18j
         0c7kAL797r6mdx5veOilxLze9H1RD1lRIdtmXj6ejweorBTEXqacuGo2wZvPTVQ59ein
         eT+UD4F0/VjZeiiJm1TtKo48sgAFR1kr8Mg5Wv/obTYDWeInf/E9EWcrR8xEDJ33RldP
         2Wu8HjBs2PILG+3fXgzCEthX5JgoOfsKIuLAEeYx9IgvkueuqKvp1K2Yu8jDrVdQsExR
         JG4w==
X-Gm-Message-State: ACrzQf1yxOnrhac1CqyF6zQ/s67Ueq8paidqSLuatsxauUUGhwAcG9Bb
        zjoC0bK1CqHFMQn8YS/cEV6LcOFfXDhRECNF
X-Google-Smtp-Source: AMsMyM5R5xcxyAvxWAGK1r7q5EICAulW0iE02XCH8BROra60uv6imCFp5DYq8Upk2PuVnpRVi1NRUQ==
X-Received: by 2002:ac2:5394:0:b0:4b0:94e7:c3b2 with SMTP id g20-20020ac25394000000b004b094e7c3b2mr10046208lfh.354.1667487326326;
        Thu, 03 Nov 2022 07:55:26 -0700 (PDT)
Received: from dabros-l.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0049c29389b98sm154878lfr.151.2022.11.03.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:55:25 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH v2 2/3] char: tpm: cr50: Use generic request/relinquish locality ops
Date:   Thu,  3 Nov 2022 15:54:49 +0100
Message-Id: <20221103145450.1409273-3-jsd@semihalf.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221103145450.1409273-1-jsd@semihalf.com>
References: <20221103145450.1409273-1-jsd@semihalf.com>
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
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 106 ++++++++++++++++++----------
 1 file changed, 70 insertions(+), 36 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 77cea5b31c6e4..517d8410d7da0 100644
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
@@ -286,20 +288,21 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
 }
 
 /**
- * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
+ * tpm_cr50_check_locality() - Verify if required TPM locality is active.
  * @chip: A TPM chip.
+ * @loc: Locality to be verified
  *
  * Return:
  * - 0:		Success.
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
+	if (!tpm_cr50_check_locality(chip, loc))
+		return loc;
 
-	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
+	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
 	if (rc < 0)
 		return rc;
 
 	stop = jiffies + chip->timeout_a;
 	do {
-		if (!tpm_cr50_check_locality(chip))
-			return 0;
+		if (!tpm_cr50_check_locality(chip, loc))
+			return loc;
 
 		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 	} while (time_before(jiffies, stop));
@@ -374,7 +386,12 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
 {
 	u8 buf[4];
 
-	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
+	if (chip->locality < 0){
+		WARN_ONCE(1, "Incorrect tpm locality value\n");
+		return 0;
+	}
+
+	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0)
 		return 0;
 
 	return buf[0];
@@ -390,7 +407,12 @@ static void tpm_cr50_i2c_tis_set_ready(struct tpm_chip *chip)
 {
 	u8 buf[4] = { TPM_STS_COMMAND_READY };
 
-	tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), buf, sizeof(buf));
+	if (chip->locality < 0) {
+		WARN_ONCE(1, "Incorrect tpm locality value\n");
+		return;
+	}
+
+	tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf));
 	msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 }
 
@@ -420,7 +442,7 @@ static int tpm_cr50_i2c_get_burst_and_status(struct tpm_chip *chip, u8 mask,
 	stop = jiffies + chip->timeout_b;
 
 	do {
-		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0) {
+		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0) {
 			msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 			continue;
 		}
@@ -454,10 +476,15 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 
 	u8 mask = TPM_STS_VALID | TPM_STS_DATA_AVAIL;
 	size_t burstcnt, cur, len, expected;
-	u8 addr = TPM_I2C_DATA_FIFO(0);
+	u8 addr = TPM_I2C_DATA_FIFO(chip->locality);
 	u32 status;
 	int rc;
 
+	if (chip->locality < 0) {
+		WARN_ONCE(1, "Incorrect tpm locality value\n");
+		return -EINVAL;
+	}
+
 	if (buf_len < TPM_HEADER_SIZE)
 		return -EINVAL;
 
@@ -516,7 +543,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 		goto out_err;
 	}
 
-	tpm_cr50_release_locality(chip, false);
 	return cur;
 
 out_err:
@@ -524,7 +550,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
 		tpm_cr50_i2c_tis_set_ready(chip);
 
-	tpm_cr50_release_locality(chip, false);
 	return rc;
 }
 
@@ -546,9 +571,10 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	u32 status;
 	int rc;
 
-	rc = tpm_cr50_request_locality(chip);
-	if (rc < 0)
-		return rc;
+	if (chip->locality < 0) {
+		WARN_ONCE(1, "Incorrect tpm locality value\n");
+		return -EINVAL;
+	}
 
 	/* Wait until TPM is ready for a command */
 	stop = jiffies + chip->timeout_b;
@@ -578,7 +604,8 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		 * that is inserted by tpm_cr50_i2c_write()
 		 */
 		limit = min_t(size_t, burstcnt - 1, len);
-		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(0), &buf[sent], limit);
+		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(chip->locality),
+					&buf[sent], limit);
 		if (rc < 0) {
 			dev_err(&chip->dev, "Write failed\n");
 			goto out_err;
@@ -599,7 +626,7 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	}
 
 	/* Start the TPM command */
-	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), tpm_go,
+	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), tpm_go,
 				sizeof(tpm_go));
 	if (rc < 0) {
 		dev_err(&chip->dev, "Start command failed\n");
@@ -612,7 +639,6 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
 		tpm_cr50_i2c_tis_set_ready(chip);
 
-	tpm_cr50_release_locality(chip, false);
 	return rc;
 }
 
@@ -651,6 +677,8 @@ static const struct tpm_class_ops cr50_i2c = {
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = &tpm_cr50_i2c_req_canceled,
+	.request_locality = &tpm_cr50_request_locality,
+	.relinquish_locality = &tpm_cr50_release_locality,
 };
 
 #ifdef CONFIG_ACPI
@@ -686,6 +714,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	u32 vendor;
 	u8 buf[4];
 	int rc;
+	int loc;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -728,24 +757,30 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
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
 
@@ -774,7 +809,6 @@ static void tpm_cr50_i2c_remove(struct i2c_client *client)
 	}
 
 	tpm_chip_unregister(chip);
-	tpm_cr50_release_locality(chip, true);
 }
 
 static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
-- 
2.38.1.273.g43a17bfeac-goog

