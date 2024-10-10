Return-Path: <linux-integrity+bounces-3781-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C99981EA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA151C26738
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E31BDA8F;
	Thu, 10 Oct 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZN+JoxgW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E91A0AF5
	for <linux-integrity@vger.kernel.org>; Thu, 10 Oct 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551786; cv=none; b=O/t7eN1xt2H3jPKogDmfToEtSHThzCT9jyREcrPyGrKAJi7/dQU8Wdiw6ZRBqT5uND/1WrAxRVAC21o/el/5b5cBMZ0N8qdNw4LZOS8nK3R/1tyGbbSs2Ifk9mXstaf6jsjbUg5U70RhBjERYKJ8H0cG+9AlOjfm92PnNHGaHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551786; c=relaxed/simple;
	bh=HwRMVaR6pdueD8o9m+TkshOXgdsenIdO/o32GNQjbTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AotKltoa9AVzZLWq4+j0Cjnf30t4fyvM5oLV2ZGGFLmTgd8ixe8T0UgyRBwCHzQ3wYcMv9GwWfkfnUAJdfcdw3Azk08R2Iz1nB1ark8Y2Y0bimo2eDQ2YHVBziRJyQuaLYDxu/R+cKt7In5+133koLGVaiBDJq6HhJ20sAbGDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZN+JoxgW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4311ae6426aso327625e9.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Oct 2024 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728551783; x=1729156583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHKiW5K4pvs94vg2y7yDOAb8eOHF1LHGauH8VuHu7fE=;
        b=ZN+JoxgW0JmWiZ5HjyP4Xo+8Uwz7wMOwBUdsn/Tpj2Zl0zOc/2A3rTykhHXx4XQQQU
         a2n4R9aCw+Tz95qwJ/aMsaXPvyf4H2OMtwsoXo+HUfUNi0RZZ2jMnSPW1KWRdxHpNmkt
         ZobW4LIVI+HYC/X2PH2D5WJn+Jeybs3Ma75P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551783; x=1729156583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHKiW5K4pvs94vg2y7yDOAb8eOHF1LHGauH8VuHu7fE=;
        b=qYSP2XltWrSC1Fqf0CyQL7DlJvAXoxpKRvcUB8C6iAMZw9jiHeF5NVXpEIJas9cbxU
         6j39fZJcWiky5ts2AYjaNa7cYaytvgIlERCf3Etl36pl57hRWbeLY+ggy58gzlRayT0j
         VyXyUQYSWQ0h9Q4i+jjBmL/ndeAhcpK5woK63ioo7aDvyGrGn9tRdUTonQZ8GOSktBUn
         krmdL+HQxaWdCFJS3EUiXBAhvA+18GQf/XMvuKOMn/VDVsKnUeFF8die2+xt41hxifGF
         ksVLiqaXAJRjFv5vA0OgSexcLIAAE2uyEvtS1ovJ73dXgbj63guIryuL/zC7majJwhyU
         pTpw==
X-Forwarded-Encrypted: i=1; AJvYcCV91PCuGH0DD3zR7AoCbH4F/cUhQzD7RFQstZAym+zJo2MujUTAVyrIPvUTcA9FAydbhUcyGuozSer5IqvqUac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcUiQfWgpg8Hs2ueJrHGHaP1zRDOwlL9cc6nkt3H7qwjcRIxT
	QbLW8ZRo/8OC5v5l177bS9nth8uBQnZMD2dG4+8z0viD8yi1EUldQ0p1fxLCTA==
X-Google-Smtp-Source: AGHT+IHSmyL/OD7yBzsupC0J5lTRhj3VuUP8hKO/1bGTMrcnNdYsge05JpsWTQvgpgvgZp/8noxF5A==
X-Received: by 2002:a05:600c:4f0c:b0:425:7884:6b29 with SMTP id 5b1f17b1804b1-430ccf470a2mr39745755e9.19.1728551783058;
        Thu, 10 Oct 2024 02:16:23 -0700 (PDT)
Received: from localhost (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-430ccf46e96sm42995885e9.18.2024.10.10.02.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:16:22 -0700 (PDT)
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
	timvp@google.com
Subject: [PATCH V3 2/2] char: tpm: cr50: Move i2c locking to request/relinquish locality ops
Date: Thu, 10 Oct 2024 09:15:59 +0000
Message-ID: <20241010091559.30866-3-bernacki@google.com>
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

Move i2c locking primitives to request_locality and relinquish_locality
callbacks, what effectively blocks TPM bus for the whole duration of
logical TPM operation.

With this in place, cr50-equipped TPM may be shared with external CPUs -
assuming that underneath i2c controller driver is aware of this setup
(see i2c-designware-amdpsp as an example).

Signed-off-by: Jan Dabros <jsd@semihalf.com>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index eed1c296a00c..80b0f41ffb5f 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -201,8 +201,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t
 	};
 	int rc;
 
-	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
-
 	/* Prepare for completion interrupt */
 	tpm_cr50_i2c_enable_tpm_irq(chip);
 
@@ -221,7 +219,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t
 
 out:
 	tpm_cr50_i2c_disable_tpm_irq(chip);
-	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 
 	if (rc < 0)
 		return rc;
@@ -263,8 +260,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
 	priv->buf[0] = addr;
 	memcpy(priv->buf + 1, buffer, len);
 
-	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
-
 	/* Prepare for completion interrupt */
 	tpm_cr50_i2c_enable_tpm_irq(chip);
 
@@ -278,7 +273,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
 
 out:
 	tpm_cr50_i2c_disable_tpm_irq(chip);
-	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 
 	if (rc < 0)
 		return rc;
@@ -322,6 +316,7 @@ static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
  */
 static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
 {
+	struct i2c_client *client = to_i2c_client(chip->dev.parent);
 	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
 	u8 addr = TPM_I2C_ACCESS(loc);
 	u8 buf;
@@ -329,13 +324,15 @@ static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
 
 	rc = tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf));
 	if (rc < 0)
-		return rc;
+		goto unlock_out;
 
 	if ((buf & mask) == mask) {
 		buf = TPM_ACCESS_ACTIVE_LOCALITY;
 		rc = tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
 	}
 
+unlock_out:
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 	return rc;
 }
 
@@ -350,16 +347,19 @@ static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
  */
 static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
 {
+	struct i2c_client *client = to_i2c_client(chip->dev.parent);
 	u8 buf = TPM_ACCESS_REQUEST_USE;
 	unsigned long stop;
 	int rc;
 
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+
 	if (tpm_cr50_check_locality(chip, loc) == loc)
 		return loc;
 
 	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
 	if (rc < 0)
-		return rc;
+		goto unlock_out;
 
 	stop = jiffies + chip->timeout_a;
 	do {
@@ -369,7 +369,11 @@ static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
 		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
 	} while (time_before(jiffies, stop));
 
-	return -ETIMEDOUT;
+	rc = -ETIMEDOUT;
+
+unlock_out:
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	return rc;
 }
 
 /**
-- 
2.47.0.rc0.187.ge670bccf7e-goog


