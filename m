Return-Path: <linux-integrity+bounces-3513-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D9974335
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 21:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1C3282DA0
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 19:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC2208A5;
	Tue, 10 Sep 2024 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvqhE2H7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223A19412D
	for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995486; cv=none; b=ZrLPPQY36dz2VQE2fPq5r3GXWZR2goPMSDZuvIUEKOt9F2rLmhrhliR8yxCTobzdolmgKbA3d5bxP5MqhMbVdXjma9eQLX1yRFg0Y4qzlXs40NPEFb6DcNIBNlvK8woG6oeag5iqBR2GQRgFe6kKb22SoQ1YA2cGwlJRlZNAxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995486; c=relaxed/simple;
	bh=VRKJRu9RUMCW/Ep3bydArOQS+E80rdfLAV15uey/Z34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLIvQ3M8LM5MJ2rLI1zWweSBkm54Uj0+kuRu5myYwmxLnLjeG7oLq/sD7yYrF2IJGHYmhP/thmERjTAXiVUjGwlJoNaUg0aRIMacheJVlR5nfkmw7TkDtN+xjdf0/uQ2RhgInUtwwqF28aarQIVxO7DrZ83ZMojqpiUg1LHBGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PvqhE2H7; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e1ba05bf73so1982562eaf.3
        for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2024 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725995483; x=1726600283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yVh+0umsxe3NmEOyboRonlTg0PRACWPVXWQxD+jYRtk=;
        b=PvqhE2H7Ols45JZplEs1jPTonbZiVLh2KHzyPObKRJRpxyxhorcIZnU7BcgmgBZXQM
         FkK9onyH9LMP1KxtgE1iBr8L/Z9FOmCsIIItfdqKqvorMyLK5nO9mLXpbMZeTspLZPnE
         MEaalAhIeQOioObRCx945A1AHTKzY/r9BSQqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995483; x=1726600283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVh+0umsxe3NmEOyboRonlTg0PRACWPVXWQxD+jYRtk=;
        b=bYnYXksxfvWAcO65koGGEOu6vuF8/oZ8qSESJnRpBJsqna3bPGi4kgdhPQxlaVq2/x
         jo8wCKmvHGElQrfHIeAfznz2BB1BtUFaeCGREmfFT2PFUKk2iaRURwrCWP5rCc95O0VD
         JOceHYSoLz+K1s6NDstVhXLP8/WeJied96qsYweB6mIV0J1FDqEy3iY1ltA6PXbQbo/r
         QTv4soD3HKSg8YIzEHWqQyN1UdoEzvo6Iv3wGIPPFW4z59J/ST+PSM3yDK+/LfajKR8w
         QyCyylkBmS4fMcvKXPH+YIR0Z7MLMRkpxETE2C26i+ZKLU7PY/IM1FnkibUslK1SdzAj
         WfoA==
X-Forwarded-Encrypted: i=1; AJvYcCXlcdMmB2KRdv+aCspEnsIy3AlV4NkRXg+bm692axL6yKBeu3lNFIp2yT5am1E/76/IYBAd8PSgCe51t8lXqZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDpHt6illZakY2RV5E+gs2bdHR7Qd/EWP9FG18ExOKpNqJ5sq
	hvX6As5vKDfJQBXGjKpu4TMU/S9xZE5TEgI63amfyPle8lT52qzYAz03q0EoKA==
X-Google-Smtp-Source: AGHT+IG+QS+VP8zMZnQg2OGY3vbTxSTiFxzjoQo84bN9fxs5YjL2aFgOtLdbc9SVDXn6UGVsfNaA6Q==
X-Received: by 2002:a05:6358:7e85:b0:1b8:48bf:16db with SMTP id e5c5f4694b2df-1b84d1a0a28mr500134655d.16.1725995483313;
        Tue, 10 Sep 2024 12:11:23 -0700 (PDT)
Received: from rink.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7968ed5sm334305485a.42.2024.09.10.12.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:11:22 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: jettrink@chromium.org,
	linux-security-module@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
Date: Tue, 10 Sep 2024 19:11:14 +0000
Message-ID: <20240910191117.1001581-1-jettrink@chromium.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept another DID:VID for the next generation Google TPM. This TPM
has the same Ti50 firmware and fulfills the same interface.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jett Rink <jettrink@chromium.org>
---

Changes in v6:
Update comments and string based on internal review.

Changes in v5:
Correct Suggested-by tag form.

Changes in v4:
Add Suggested-by tag. Sorry that I forget.

Changes in v3:
Refactor ternary operators into helper method.

Changes in v2:
Patchset 2 applies cleanly

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 32 +++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index adf22992138e..fea744234aa0 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -30,8 +30,9 @@
 #define TPM_CR50_MAX_BUFSIZE		64
 #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
-#define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
-#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID for Cr50 H1 */
+#define TPM_TI50_DT_I2C_DID_VID		0x504a6666L	/* Device and vendor ID for Ti50 DT */
+#define TPM_TI50_OT_I2C_DID_VID		0x50666666L	/* Device and vendor ID for TI50 OT */
 #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
 #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
 #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
@@ -668,6 +669,27 @@ static const struct of_device_id of_cr50_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
 #endif
 
+/**
+ * tpm_cr50_vid_to_name() - Maps VID to name.
+ * @vendor:	Vendor identifier to map to name
+ *
+ * Return:
+ *	A valid string for the vendor or empty string
+ */
+static const char *tpm_cr50_vid_to_name(u32 vendor)
+{
+	switch (vendor) {
+	case TPM_CR50_I2C_DID_VID:
+		return "cr50";
+	case TPM_TI50_DT_I2C_DID_VID:
+		return "ti50 DT";
+	case TPM_TI50_OT_I2C_DID_VID:
+		return "ti50 OT";
+	default:
+		return "unknown";
+	}
+}
+
 /**
  * tpm_cr50_i2c_probe() - Driver probe function.
  * @client:	I2C client information.
@@ -741,14 +763,16 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	}
 
 	vendor = le32_to_cpup((__le32 *)buf);
-	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
+	if (vendor != TPM_CR50_I2C_DID_VID &&
+	    vendor != TPM_TI50_DT_I2C_DID_VID &&
+	    vendor != TPM_TI50_OT_I2C_DID_VID) {
 		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
 		tpm_cr50_release_locality(chip, true);
 		return -ENODEV;
 	}
 
 	dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
-		 vendor == TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
+		 tpm_cr50_vid_to_name(vendor),
 		 client->addr, client->irq, vendor >> 16);
 	return tpm_chip_register(chip);
 }
-- 
2.46.0.662.g92d0881bb0-goog


