Return-Path: <linux-integrity+bounces-3780-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18779981E9
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 11:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8DB1C266C3
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A781BD516;
	Thu, 10 Oct 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LS8nEO39"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64A1BC074
	for <linux-integrity@vger.kernel.org>; Thu, 10 Oct 2024 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551785; cv=none; b=XlazAsxLcbL9E2FUonye09rzS5F2/mi8L9Is4gFgiPmKl01OMrxB5XqmTsx5Auq/S1+BnM8NJIT+zo4KG/ifPwuKs0dvQBk3OJCef8XX1MwpJTj+AaGMkfCLunCKBaqxX0rN3E4M1Q62CNUoSO8tZGEF6rcmXpziV9iiSF3kncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551785; c=relaxed/simple;
	bh=4LHtDJcoHmwOzabrQefs8/8qAN2mYOVxAYXJz7dL1io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhhBXPG7/BJIiqjpQs7UwBPxc56ycZmp7RIkmBO4jqdBvD17p4aandsE6JUw2v18snsoBdiqB9kI893fuW95A1U/EXKiYtHmLLJlSKX6DsRucO/ICOcxviP1YpQdgDhid1vJobgYq/DKtOoV5vQpFSM0K45KQ9DnkdOZ0Yvd9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LS8nEO39; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43116f8a3c9so5437185e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 10 Oct 2024 02:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728551782; x=1729156582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ur+5KZOuYwz2GcZrxY0ybGvyN/X26x/9fV/Il1CpC6s=;
        b=LS8nEO39rMzlk9Ll9Ol/1OKzgKaNqi9SiCcjNLADZ4LFmhQakbvPayyFNoGFlR4BHK
         PBtbB/SZeZHtNn4wkSNYLYAQgqj6yIiSAPcnvMKdo35jXpc1NxwmYmwIn1CnCjRaYAsd
         lHwsCp0seX7qvSOrMaFBMvHPRfe72JnJvEtuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551782; x=1729156582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ur+5KZOuYwz2GcZrxY0ybGvyN/X26x/9fV/Il1CpC6s=;
        b=ArLguf9ovaOi0R97mh3vG7sTEEF6IqM4fyksd51tSOP8ygtWZf9wajG6DanMzzgUbu
         lIo14UzW08pJjJKF2sRvk3uCm4BEkhuD5OsOS7pu5pm477O5eufZ+0g/t6fgeCeOUYc/
         x5Mc599qa0iTTIc4N5Jeblrc9HaeapgpfHIS3yGSVF46hqhUs3ci2EGTmT8ooQfp9hEq
         erm8IHIiJomXE+M0/T7O3gYnQCXyAmu8mRiIBYII40Efuc77jVHpBiwk9+OnA+y54HBS
         Y79l20oyAdTc1MrsGIW+tycQZoyk/idvsgaVs9szcMUGzz2ins0fxF/PJsJWAAwuKGF5
         em1A==
X-Forwarded-Encrypted: i=1; AJvYcCVe//IlaNKtcKALg/+hT7ussduPVx2IneY3JYlV/mFrgKeSWOCqlm+dk9Mefr7082o2c/bfY0YJjBA5vKRfrRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsSkiECS0yhyRUlmsU3TNDtogVU/C4+rd/Sq7CGWbXr+Xipqw
	Re51LhJNA//pcWwtAbz5zj8gJBLKjLSG8b4kZ2blRCtyToyccEdUstNNmlpQQg==
X-Google-Smtp-Source: AGHT+IF+59lp4dWvtKMhVOBnpBXo3TAvmw/7SgIOL1xVypM1JQ5DTbBLgKjngVjQifJpxYRIOo/Azg==
X-Received: by 2002:a05:600c:cc3:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-430d749418amr47695415e9.35.1728551782044;
        Thu, 10 Oct 2024 02:16:22 -0700 (PDT)
Received: from localhost (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-37d4b9180adsm955406f8f.112.2024.10.10.02.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:16:21 -0700 (PDT)
From: Grzegorz Bernacki <bernacki@chromium.org>
X-Google-Original-From: Grzegorz Bernacki <bernacki@google.com>
To: jsd@semihalf.com
Cc: apronin@google.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	mw@semihalf.com,
	peterhuewe@gmx.de,
	rrangel@chromium.org,
	timvp@google.com,
	Grzegorz Bernacki <bernacki@chromium.org>
Subject: [PATCH V3 1/2] char: tpm: cr50: Use generic request/relinquish locality ops
Date: Thu, 10 Oct 2024 09:15:58 +0000
Message-ID: <20241010091559.30866-2-bernacki@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241010091559.30866-1-bernacki@google.com>
References: <20221101020352.939691-1-jsd@semihalf.com>
 <20241010091559.30866-1-bernacki@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Dabros <jsd@semihalf.com>

Instead of using static functions tpm_cr50_request_locality and
tpm_cr50_release_locality register callbacks from tpm class chip->ops
created for this purpose.

Change-Id: Iee45ab1cbb2f4d898fbac12e9632de27f615bfba
Signed-off-by: Jan Dabros <jsd@semihalf.com>
Signed-off-by: Grzegorz Bernacki <bernacki@chromium.org>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 94 +++++++++++++++++------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index adf22992138e..eed1c296a00c 100644
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
@@ -285,25 +287,26 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
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
@@ -311,48 +314,57 @@ static int tpm_cr50_check_locality(struct tpm_chip *chip)
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
@@ -373,7 +385,7 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
 {
 	u8 buf[4];
 
-	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
+	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0)
 		return 0;
 
 	return buf[0];
@@ -389,7 +401,7 @@ static void tpm_cr50_i2c_tis_set_ready(struct tpm_chip *chip)
 {
 	u8 buf[4] = { TPM_STS_COMMAND_READY };
 
-	tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), buf, sizeof(buf));
+	tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf));
 	msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 }
 
@@ -419,7 +431,7 @@ static int tpm_cr50_i2c_get_burst_and_status(struct tpm_chip *chip, u8 mask,
 	stop = jiffies + chip->timeout_b;
 
 	do {
-		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0) {
+		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(chip->locality), buf, sizeof(buf)) < 0) {
 			msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 			continue;
 		}
@@ -453,7 +465,7 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 
 	u8 mask = TPM_STS_VALID | TPM_STS_DATA_AVAIL;
 	size_t burstcnt, cur, len, expected;
-	u8 addr = TPM_I2C_DATA_FIFO(0);
+	u8 addr = TPM_I2C_DATA_FIFO(chip->locality);
 	u32 status;
 	int rc;
 
@@ -515,7 +527,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 		goto out_err;
 	}
 
-	tpm_cr50_release_locality(chip, false);
 	return cur;
 
 out_err:
@@ -523,7 +534,6 @@ static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
 	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
 		tpm_cr50_i2c_tis_set_ready(chip);
 
-	tpm_cr50_release_locality(chip, false);
 	return rc;
 }
 
@@ -545,10 +555,6 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	u32 status;
 	int rc;
 
-	rc = tpm_cr50_request_locality(chip);
-	if (rc < 0)
-		return rc;
-
 	/* Wait until TPM is ready for a command */
 	stop = jiffies + chip->timeout_b;
 	while (!(tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)) {
@@ -577,7 +583,8 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		 * that is inserted by tpm_cr50_i2c_write()
 		 */
 		limit = min_t(size_t, burstcnt - 1, len);
-		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(0), &buf[sent], limit);
+		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(chip->locality),
+					&buf[sent], limit);
 		if (rc < 0) {
 			dev_err(&chip->dev, "Write failed\n");
 			goto out_err;
@@ -598,7 +605,7 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	}
 
 	/* Start the TPM command */
-	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), tpm_go,
+	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(chip->locality), tpm_go,
 				sizeof(tpm_go));
 	if (rc < 0) {
 		dev_err(&chip->dev, "Start command failed\n");
@@ -611,7 +618,6 @@ static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
 		tpm_cr50_i2c_tis_set_ready(chip);
 
-	tpm_cr50_release_locality(chip, false);
 	return rc;
 }
 
@@ -650,6 +656,8 @@ static const struct tpm_class_ops cr50_i2c = {
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = &tpm_cr50_i2c_req_canceled,
+	.request_locality = &tpm_cr50_request_locality,
+	.relinquish_locality = &tpm_cr50_release_locality,
 };
 
 #ifdef CONFIG_ACPI
@@ -684,6 +692,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	u32 vendor;
 	u8 buf[4];
 	int rc;
+	int loc;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -726,24 +735,30 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 			 TPM_CR50_TIMEOUT_NOIRQ_MS);
 	}
 
-	rc = tpm_cr50_request_locality(chip);
-	if (rc < 0) {
+	loc = tpm_cr50_request_locality(chip, TPM_CR50_I2C_DEFAULT_LOC);
+	if (loc < 0) {
 		dev_err(dev, "Could not request locality\n");
-		return rc;
+		return loc;
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
 
@@ -772,7 +787,6 @@ static void tpm_cr50_i2c_remove(struct i2c_client *client)
 	}
 
 	tpm_chip_unregister(chip);
-	tpm_cr50_release_locality(chip, true);
 }
 
 static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
-- 
2.47.0.rc0.187.ge670bccf7e-goog


