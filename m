Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B350D614305
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 03:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiKACEd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 22:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKACEc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 22:04:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8C5FAC
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j14so18977332ljh.12
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 19:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPl1SOnxyAnQu6lEK1ziCKE74cXYRenL9yBkUnWkw14=;
        b=F1igKS61rW0KJ3aOyU2c0g4z4smdRxqTgtzdhbdpFum/1avRujwvQFbx8TaILeqrWu
         wBk7C25kWgmeIdowA1zWM9/c4zi8pQw3XqOY6ookBu/TQqWePz5jbMqj+rsIBNw7FuyH
         m5ql7j5vMnLSttGBPzmZWQBN4AEaGfS5B2bFI1uD7aXHrwEFcuT3seyjv4BpplGrtTkQ
         hT9zDgAkX7FKMR8tW3qmv3aER2pgH6a15pCRe9cBDDkSAvFv5NaSL7hhzMnutJtpqBtQ
         tThH9kbnnGg27MV2dxw03u8vqATADURZ/InhJel1UKreFmj8WlsrsbAAhEkRBEpiZYgd
         QgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPl1SOnxyAnQu6lEK1ziCKE74cXYRenL9yBkUnWkw14=;
        b=UvXXD94UIqydwLpopZDLKcFL773WjThhOW8mqpkH8XbB2AAcKGXqb1O8d4xnvzv4J+
         0DDLJONcgq2R3YU+2G9Nr/id+87AQcXl2gjESM2HFg96TNKNzgmcI+T30VGLspUcJC/P
         7UXoKM+coYxbNsJrGQVwtWd98zlw1Pd2U5RDfScShwFoB8Lqk4lI3A8N01nA+crR0mk2
         G8p21XI+UL+2cPRqdS931DRpN6bY2DPxFNN5rVKWlVXNri0PHPKdwBpFfQhHvgqDq7Fy
         O7cQgOKXCdLJM6+lDb8LqnbppIyyGs8Iw623p0XqE3RTEtf6j2pg0FNOn1rLnVj2fGxc
         BMmA==
X-Gm-Message-State: ACrzQf02rPt7TfcA4RRpuwLQos4fUtvBXUaR8vhXX1G0D1cA8R3qrvBl
        eBFIKDRy0N45D7Y0tk9FjhDt0H5KnXNRvOR8+xs=
X-Google-Smtp-Source: AMsMyM4gh7IwkqsCFTFXzDOx8pgg2BLRHFpsXXl6fVoGy8CA3oRpPQ837gfTfHUkglTlTt5Snl1ieg==
X-Received: by 2002:a2e:a37a:0:b0:277:2e8a:bc82 with SMTP id i26-20020a2ea37a000000b002772e8abc82mr6881736ljn.391.1667268269375;
        Mon, 31 Oct 2022 19:04:29 -0700 (PDT)
Received: from dabros-l.roam.corp.google.com ([185.157.14.92])
        by smtp.gmail.com with ESMTPSA id k11-20020ac257cb000000b00494942bec60sm1508799lfo.17.2022.10.31.19.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:04:29 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH 3/3] char: tpm: cr50: Move i2c locking to request/relinquish locality ops
Date:   Tue,  1 Nov 2022 03:03:52 +0100
Message-Id: <20221101020352.939691-4-jsd@semihalf.com>
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
index d3438a4ed1ef8..c6628351ec383 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -202,8 +202,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t
 	};
 	int rc;
 
-	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
-
 	/* Prepare for completion interrupt */
 	tpm_cr50_i2c_enable_tpm_irq(chip);
 
@@ -222,7 +220,6 @@ static int tpm_cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t
 
 out:
 	tpm_cr50_i2c_disable_tpm_irq(chip);
-	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 
 	if (rc < 0)
 		return rc;
@@ -264,8 +261,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
 	priv->buf[0] = addr;
 	memcpy(priv->buf + 1, buffer, len);
 
-	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
-
 	/* Prepare for completion interrupt */
 	tpm_cr50_i2c_enable_tpm_irq(chip);
 
@@ -279,7 +274,6 @@ static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
 
 out:
 	tpm_cr50_i2c_disable_tpm_irq(chip);
-	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
 
 	if (rc < 0)
 		return rc;
@@ -323,6 +317,7 @@ static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
  */
 static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
 {
+	struct i2c_client *client = to_i2c_client(chip->dev.parent);
 	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
 	u8 addr = TPM_I2C_ACCESS(loc);
 	u8 buf;
@@ -330,13 +325,15 @@ static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
 
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
 
@@ -351,16 +348,19 @@ static int tpm_cr50_release_locality(struct tpm_chip *chip, int loc)
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
@@ -370,7 +370,11 @@ static int tpm_cr50_request_locality(struct tpm_chip *chip, int loc)
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
2.38.1.273.g43a17bfeac-goog

