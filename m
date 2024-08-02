Return-Path: <linux-integrity+bounces-3255-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDF9464CA
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 23:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA391C2188D
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48C8060D;
	Fri,  2 Aug 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdmolVEE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055A757EA
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632690; cv=none; b=lRh/GHJ0NhGvbSL361DBhuU2+CNE3QTPqT13JJX9Hyqw5KPIOXWjBN+CjGPeIfrlu30tgosNHdtcMvnE1vjq7ihvxp+5IVGx7BcaVajDMXyDnNa/ucfGvLOUFcZdfQMGQjURwJ3glsKuGTCZKkHfkx3qwqrM0vvK+4yPNktoMrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632690; c=relaxed/simple;
	bh=z1RdEZ7A8nCpAdJiYNdv+o6BPnQVzKEX+9aqwiP/Jig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUbPVF0I854v0oHMxKdVzz0+FEB6MRQQWC+wwGU+fRcxeNN33VZBl7kXds+feLv1UXeRGaxqpQNYJWx0v9ZswLcD4CL1e7gfelhGLxtTvNTZ2XofQzoub0eEmeztB4UAiC7GJ7BcLepCV+weX5OFh8u9RH+uXTUni63ymiyE1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hdmolVEE; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8152f0c63c1so306120739f.1
        for <linux-integrity@vger.kernel.org>; Fri, 02 Aug 2024 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722632687; x=1723237487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bizVYN62g2WR0h6WdBjGD7lztQUVqZACzgFg3ew1NZg=;
        b=hdmolVEEz3F+RJMK0XoDpq4DHzYtDE48C+k1TzlEB82oZRtD2cAQ/W4mZKgG0P9itj
         DfLFI3EmT8cl5zas7GmWLAvl3x78g0ob/r1oQyLyElpnF00LKaVFzZwoI0twQU48di2B
         n6KYi5qkGPGL85W00E/yq6pqAncO7syKTcEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632687; x=1723237487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bizVYN62g2WR0h6WdBjGD7lztQUVqZACzgFg3ew1NZg=;
        b=MctbfMuDewQYA2xjJxjMNbaLo60a8JHF7GDAQAxa0/7i9YuY95QTX8vGohMUi+Oiry
         HcIpC6lcklg//yMChQGEQX1RRVlXits2h0lXxmXM6NnhzTTGD6uPr6Vrq/Q2eGa54hRJ
         g84Ur6vNJMj6bCqsDVn3wVox/3OrQWmubFPVkId6x0L5wQlGM5ReL1WKLi9uYwdhBUKc
         /kx2BSzSHuwM1S5NDQfQopxEYgZVa+Kc/4jfesdXNwtQlAmjjL+nxvCTNnH+2EiLnV+X
         TTucj0mvdiQhNSqtZ7dz0DR22oXa8vjdtXGx8SxXbu4CmPEEwzGdqeEgxs7wtsB7YoQN
         JhNA==
X-Forwarded-Encrypted: i=1; AJvYcCWM4T3Js5vK1NhHx6CoAEBUc5pKtrMOLWAeiOVV1/bxq5WUzhSzXm7tuSfCmEJV2vwTZeCXHCrpEQSBqpuBepViQxcijuAYFG+EZlpTJ4W8
X-Gm-Message-State: AOJu0Yz29lA2sezny01GeG7yg5m9xmdYba5B+8LMBT1/FXaqcheorkO6
	CsET80BsmRJ03nzldliwcrr4trven0uVIbceSmGyv8VE5/+7LOasi+hCMpJQAA==
X-Google-Smtp-Source: AGHT+IHUFG1Og3qZnJuB+WHW/Mj9RyaQmwZbLxjxKt93uYCF5XTb9EODVbRysfl5tZk2LzoGN4JDew==
X-Received: by 2002:a05:6602:3ca:b0:81f:9468:7c3c with SMTP id ca18e2360f4ac-81fd43e3415mr598235239f.12.1722632687275;
        Fri, 02 Aug 2024 14:04:47 -0700 (PDT)
Received: from rink.c.googlers.com.com (212.165.232.35.bc.googleusercontent.com. [35.232.165.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d7223csm70159939f.42.2024.08.02.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:04:46 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org,
	jettrink@chromium.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3] tpm: Add new device/vendor ID 0x50666666
Date: Fri,  2 Aug 2024 21:04:32 +0000
Message-ID: <20240802210441.625738-1-jettrink@chromium.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept another DID:VID for the next generation Google TPM. This TPM
has the same Ti50 firmware and fulfills the same interface.

Signed-off-by: Jett Rink <jettrink@chromium.org>
---

Changes in v3:
Refactor ternary operators into helper method.

Changes in v2:
Patchset 2 applies cleanly

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 30 ++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index adf22992138e..1f83cfe2724c 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -31,7 +31,8 @@
 #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
 #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
-#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_DT_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
+#define TPM_TI50_OT_I2C_DID_VID		0x50666666L	/* Device and vendor ID reg value */
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
+		return "";
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
2.46.0.rc2.264.g509ed76dc8-goog


