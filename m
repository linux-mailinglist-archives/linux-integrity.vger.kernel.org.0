Return-Path: <linux-integrity+bounces-3754-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E1A9965BD
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 11:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62F41F21FE6
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2497418A93A;
	Wed,  9 Oct 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EPrHAR/w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089D189528
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466996; cv=none; b=W6fDJSWZO3CWFdWBz1vwaMILE+FnZ6L6fFJG+rknBGEhejFY+LhfAIAYNIOdYene5xQQzLxwXnkpqRUNIc0xfY0iCkmqrB2MiLsXvAi4oazFOzIlzJJXN0ZbBRMECzl0OKMER0YZaDK0FJggzrj19WkcLUOkAag5cDDAdAtAaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466996; c=relaxed/simple;
	bh=ZYxNK5hFZ6iVjtXf85rFV7Cy6YXXoBmRK20cr66qNh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gstq9/jx0eT0kUdtSVeN5IxzoqyVFdtFMgnNP5Sbzy9FQO1j15zFEbQTt4h/LT0uo/59QKeS5S46oio4oHhs7vxH/srbozDm7I3XOmhHCQhwgbFtsKtnJazzGGRRWAaGsTsueUazA+unJsKXvTpBqxE1VS3I69ZsJhazhs3Zsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EPrHAR/w; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d375ddfc0so836614f8f.2
        for <linux-integrity@vger.kernel.org>; Wed, 09 Oct 2024 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728466993; x=1729071793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv95wUfVWG4fcvTn6B78w2Ak92jQ43dNXHoq4YGYUo4=;
        b=EPrHAR/wbKXM1DADIQ7zHJQaQBeQt7DE8BLnbg7OPdTW391ejyq+WzcUrN2/2QFZnI
         PY4PtP5os4t9sepKpogl2a2LiM5pAYLlqpIgbk+1rBVi/VCXE63mqjZDMSvkHJNgIiHv
         W5rBxX82MzJMoOOk5nbcgd2r9/ri9U7thMQ8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728466993; x=1729071793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv95wUfVWG4fcvTn6B78w2Ak92jQ43dNXHoq4YGYUo4=;
        b=gLUGECI9LIfQ1PAUKOUnYptWosqOkjf7+O5V8ZjqR6bAS/U9flqH4SMcsVf1ltPjHF
         ObGvCMH3nvkPx4DKHdpm+JQzIz4knotCBWMA6rUhbDNxCgIJtCtlFDJ1DJw1hkPrE8I6
         jdg8vn79i5ax3W7/o+jg0hLPrt4gaotaXO9Cesap7ddSfpkBsn09bpsF3ByInLaA+ro3
         h1xFvkkjs4l1cfTlG6OXn3gQ5KwG68I99n+Mqb/roGP7jJa319SUCR9IA38cfhBBIplP
         wRjrufv43Izldi3TsS2/iBNEEpJqpRD2cSu60faQvOkPokYBBFhqS5jMWDBGWZ7+pN7M
         qahw==
X-Forwarded-Encrypted: i=1; AJvYcCUlCJrt4tyUPqabEcA3GkCJ6GzdPmDVmEDTDImXCbyQsuxPNYKbABw4OeJ/n56iy8g40ZPjD3k5TC3nZDn2ohk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvl19ZabCmCqpbqJezchqaL6oD5i17/eXtXmOud6B4cyIUPdZI
	fcjleESPF9a8BimEklPSmAnl8hh8kVVDUnAOqLFWLW/D5EHGZtAFfGX9IwZUig==
X-Google-Smtp-Source: AGHT+IH9kxMlG2auVxQkOg4WZzRLReO4rw0egjhfNSwGxufZYLHxNPBj/enq6C1rps1iZ1pB79Ohdg==
X-Received: by 2002:a5d:638a:0:b0:37d:393a:97c5 with SMTP id ffacd0b85a97d-37d3aa28d52mr1066107f8f.28.1728466992576;
        Wed, 09 Oct 2024 02:43:12 -0700 (PDT)
Received: from localhost (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-430d748d42fsm14668255e9.43.2024.10.09.02.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 02:43:11 -0700 (PDT)
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
Subject: [PATCH V2 2/2] char: tpm: cr50: Move i2c locking to request/relinquish locality ops
Date: Wed,  9 Oct 2024 09:42:07 +0000
Message-ID: <20241009094207.2897048-3-bernacki@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241009094207.2897048-1-bernacki@google.com>
References: <20221101020352.939691-1-jsd@semihalf.com>
 <20241009094207.2897048-1-bernacki@google.com>
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
index 1b1e403383fc..104ef6c7f11c 100644
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


