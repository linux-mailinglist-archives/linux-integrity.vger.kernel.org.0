Return-Path: <linux-integrity+bounces-3186-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F8935263
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2024 22:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F00D1F21F58
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2024 20:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144B145B30;
	Thu, 18 Jul 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJ7kKKAl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B1145B0B
	for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334257; cv=none; b=sWWKYrgRv+cO5eOSvZarMn6UcNFfA8VnKL9QGbb3l4XfdLE80/6G6Ryqs6llhAKGZqN3NrYfuxtX30xu0b4QzMPt53nWpRk9966jShEU7aA6nVGvza3Fmv7o8Ds/qxghahtaFTwl+nMN/Ry1LgKPgLStxUfuAjB9s28tsN9eTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334257; c=relaxed/simple;
	bh=Y0KT7kX9YaVl3aer/d085haNhD5NnDzB4JE+rocmmJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgfvmwgyMaDtPJ7BHo2rv/Ul0JG2ACNINg5yiW30ZjRguX+0x2j++eTAClmIJW2Ct383e4tvV2VE7yLx312hG2QlSUCzKcYfYIoKq9FFQlNv6f3kJLtHIAAW5atzXl5ko2CT5bwjKcy+LmkHR8qWxlj5t+1kMnIfvZZpf/AiJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mJ7kKKAl; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-380bfd7cdbfso4925575ab.1
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2024 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721334254; x=1721939054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sO75zMNZ2oS5yiFcWvWFnn+7GgQViti8sJ8HNULNiFU=;
        b=mJ7kKKAlXLG2v5Mno8OyRjUcal06n3SaJxyzp1C7UIHTDdCLLIEo0uUKm8uTzb0s16
         YnEwB+VpHQszFs5U4KoMp3zC/2bDIMOjddOlaNhgXpkHsuHmecy4TpAhhylPttoDUpX/
         tFOp/ehpSpWR7xeICkTY0qxZGGS4WiPLtcI6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334254; x=1721939054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO75zMNZ2oS5yiFcWvWFnn+7GgQViti8sJ8HNULNiFU=;
        b=Fh8FtWWPf6/GMTgmv15jDPBAvk+6PA7+zYK8wl6dvDxOGpfxgzQgwniW1FrNH+BZV0
         MrPHf1LHKRe3oTBsVSMN5sAigQQSRoyYd/2qOyDpuhGqAY8SX9H2LjgTaiKyzb+VIHk/
         BkwGnWstnqKNQGK09iZdUxmQadlI3JCLDBrOT4u9bFZ4lD3cjrGfKCSc6hTN2+Wq+yKC
         btGUaZFHUaRfYH/yuRf+671RXpw4EuWtXIg3cahHz7bd03WFE5nBoIW9BJ0y/fsAuDq1
         BYKpTGteulM7EAorp1i9WDAW677l8k7zmd/qgnIHCqZ0mVJyXWWjKILcJnaN4euU+Eag
         91lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJDZ/NmPU5aPGcNvkGW6p68yWfwAwbEJZ6HAJDXLf8/RpdHSTHgQQz2kj6rVwy4G1WTminJBQDxw3KTe6ZOnRAlLT2J/lSJTFkKbjJN7Pq
X-Gm-Message-State: AOJu0Yxc+YhNnHzGBbDVGwJoBKspv82EaQnyo9Zenwa8+11sVexHc22h
	t1tekvpaWKVh7E6wOf8QGHpE8IPlM1xKFzF4lxkJ/g9na3tlXq93CxhHqdSZcQ==
X-Google-Smtp-Source: AGHT+IHZPGNqhBOvV5YQLPgRg+bUR77xw4PNBSLiWtTSbz7AjsRnwsM+5ZvhdEOFS+1B0ScAkq3xMA==
X-Received: by 2002:a05:6e02:2164:b0:397:584d:9b73 with SMTP id e9e14a558f8ab-397584d9d43mr23414195ab.7.1721334253923;
        Thu, 18 Jul 2024 13:24:13 -0700 (PDT)
Received: from rink.c.googlers.com.com (212.165.232.35.bc.googleusercontent.com. [35.232.165.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950b6ad6e5sm18932175ab.39.2024.07.18.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:24:13 -0700 (PDT)
From: Jett Rink <jettrink@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org,
	jettrink@chromium.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2] tpm: Add new device/vendor ID 0x50666666
Date: Thu, 18 Jul 2024 20:23:52 +0000
Message-ID: <20240718202359.127482-1-jettrink@chromium.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
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

Changes in v2:
Patchset 2 applies cleanly

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index adf22992138e..b50005ccfc5e 100644
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
@@ -741,14 +742,18 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
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
+		 vendor == TPM_CR50_I2C_DID_VID    ? "cr50" :
+		 vendor == TPM_TI50_DT_I2C_DID_VID ? "ti50 DT" :
+						     "ti50 OT",
 		 client->addr, client->irq, vendor >> 16);
 	return tpm_chip_register(chip);
 }
-- 
2.45.2.1089.g2a221341d9-goog


