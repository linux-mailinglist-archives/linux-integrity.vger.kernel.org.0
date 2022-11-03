Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5311618044
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKCO4D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiKCOzt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 10:55:49 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CD019039
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 07:55:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so3210051lfb.13
        for <linux-integrity@vger.kernel.org>; Thu, 03 Nov 2022 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=797EtY+3agoh3EckHxqCO4GdYgV/ObcVxut9/TriEp4=;
        b=oNfUg3hpxIZ7Yzl1SIL56j8kPoZmkn6N3H8r3ujzPVMPHxGX+8d6w7B1iegBtVAk6W
         MKJz53gkJ1lJrBOAOtRRZuhncJcBDfcFgCsgz34QnS/Ae51jtz5BjU4t4RP7EJBznvNx
         W52OWvsgKxRu9VokqbxrrrQkLalDvMbxcLXO0gou9ORsxyWtROHeAq1fj3uIGjktJ+Xo
         nv6S2MeHmEXBaEvRAQ0b4F5h2qBo5gW1JXC3YdJ2Hs3SKOVt1fx91FEdXERccB2pZ/4e
         l8RrMN6se105eXcfsHAN16rBhY9yyv/yAyABhNJ49CG2zV0oyeg52o9Kvx7PRGyoakvZ
         ZfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=797EtY+3agoh3EckHxqCO4GdYgV/ObcVxut9/TriEp4=;
        b=OqGIHHWvPlx/NzctJO9H2MtWXc19uECCPk7tzjXw3ns4pfy4fwDce30NXBxw+cXJZS
         R9YAaj+hjY92q3g6+wSNx9UObJ/8kf3RwER1Tt2RlUx/a0vzGFMvL42hhruyL10r4zKe
         x47rsVMBTuwySPKVVHHSqHhqyRvSRFvYSz9Ejoao+NkgAbnnxWzn9ziYw/5sRSSa6e9P
         pl4v2gbWIM8Nb0NYvnQsH5PlfbgzhbcazhYxeSx31BQo0sODTBcmQYiH+ejiBFXvxLuy
         qbPnHBGIfz1xqDFLODwplbVtUtvxRccL4vKG3Sswk8HuyPvy9UyLokS5h+qXVjEJqsxr
         886A==
X-Gm-Message-State: ACrzQf2KH3Rl59BBRYGcIODH4j7dPDwuyBk0tQHx6Lx/0KrXq65Oisqg
        c1euDDSW+Q1BGvRtKUmEB7ewXx4suq1GVSNW
X-Google-Smtp-Source: AMsMyM7zD2LHnsvto2Wtv5t2RisYntHENi4UMi2MLiW9MqwoOuWbe1+cfYCTeOdRLMITJZkZ8RpIEQ==
X-Received: by 2002:a05:6512:1281:b0:4a2:cbfc:d6a8 with SMTP id u1-20020a056512128100b004a2cbfcd6a8mr12270149lfs.514.1667487327503;
        Thu, 03 Nov 2022 07:55:27 -0700 (PDT)
Received: from dabros-l.wifi.semihalf.net ([83.142.187.86])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0049c29389b98sm154878lfr.151.2022.11.03.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 07:55:27 -0700 (PDT)
From:   Jan Dabros <jsd@semihalf.com>
To:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rrangel@chromium.org, timvp@google.com, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com, jsd@semihalf.com
Subject: [PATCH v2 3/3] char: tpm: cr50: Move i2c locking to request/relinquish locality ops
Date:   Thu,  3 Nov 2022 15:54:50 +0100
Message-Id: <20221103145450.1409273-4-jsd@semihalf.com>
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
index 517d8410d7da0..f8a67fc2382cc 100644
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
 	if (!tpm_cr50_check_locality(chip, loc))
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

