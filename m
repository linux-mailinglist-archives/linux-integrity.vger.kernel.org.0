Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128065E98D9
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Sep 2022 07:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiIZFkL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Sep 2022 01:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiIZFkK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Sep 2022 01:40:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727D183BA;
        Sun, 25 Sep 2022 22:40:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id u69so5618518pgd.2;
        Sun, 25 Sep 2022 22:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zbMWBpJAr3OkSRe66ITLMsu2IwUoetprW3YnPTViuio=;
        b=dOx4PbxAEA45IugHMxj+VOgf0c4AcoOEBjy447rlNd/9AfP2QjGYXtea3yg9skyxIK
         fFjDAPYOleyizDiY0xCUpedgRZgYP2f5Tmssaj+rZXY07EEj5I4eh8pMWmFdBeGSJkBe
         LfilB76y6vrdRBTtBlKgGq2SidQxImUas7yA7A+sm2rjUPR1iXgLfPCMf7LMK8FMTBu2
         1tkfrFu9+yCBHKMIhrf1oD9eazvBMpGmvcJE2lK3itp6b9mdCzfAuxQTSOjul6uEwRIE
         EGw9WgP3rLgHkTsD2nPR6S5+XmuRTF/Xq6J7NtSwuc1Qsc/UXedMAkm9yV8HiwZEBj+N
         q0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zbMWBpJAr3OkSRe66ITLMsu2IwUoetprW3YnPTViuio=;
        b=JHFm0Xlw7vIt/GxMxas/dYAWHUrjSLeQPvd6RNlbAeUBjCrh3GCgldcRrROwZJkchB
         /QWKnYEK9a73jzIsu0LXEd85qyO1QU9vcjRdXOP39io3OQoIePgmYrRhvkug0EjwLq8a
         WL3Nk1bvOG2bDTHV6NABQVw1GqL3pUUUCBBCv2FbKq6huYbSAiRuuy5JxuFkBf3kdc9J
         xkc7Z6Ns+kae0WfasW4pwy4SYLR8ghMQpmr1acYS/UYST4WLprc6YQrf/lk8ePzpRyLu
         YWmkFrK3nSHX+QFGNRxNjHExg/dTypGDhtTzZChI2s7XgeM/KPvUFmzt4NtrqSmora71
         WXOg==
X-Gm-Message-State: ACrzQf08vXBd6yNXqe1L7en3p5cd+cgBMQ3rHINsULKLoG2YZjnZVUA6
        6flO4ZCPncO3SudAvHh37lI=
X-Google-Smtp-Source: AMsMyM78y3GHje17aC0crHddY/JbQqOBEWo9hveb8SUBzolzOMysUeG0fZK7vLtmf1eNsVtTJuA1iw==
X-Received: by 2002:a63:90c9:0:b0:434:b578:3bb4 with SMTP id a192-20020a6390c9000000b00434b5783bb4mr17686371pge.389.1664170803940;
        Sun, 25 Sep 2022 22:40:03 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f71200b00176b0dec886sm10120350plo.58.2022.09.25.22.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:40:03 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tpm: st33zp24: remove pointless checks on probe
Date:   Sun, 25 Sep 2022 22:39:58 -0700
Message-Id: <20220926053958.1541912-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
References: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Driver core will never call driver's probe method without appropriate
device structure, so testing them for NULL is pointless.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/char/tpm/st33zp24/i2c.c | 6 ------
 drivers/char/tpm/st33zp24/spi.c | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 614c7d8ed84f..8156bb2af78c 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -106,12 +106,6 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
 {
 	struct st33zp24_i2c_phy *phy;
 
-	if (!client) {
-		pr_info("%s: i2c client is NULL. Device not accessible.\n",
-			__func__);
-		return -ENODEV;
-	}
-
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_info(&client->dev, "client not i2c capable\n");
 		return -ENODEV;
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index ff4adbe104cf..2154059f0235 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -223,13 +223,6 @@ static int st33zp24_spi_probe(struct spi_device *dev)
 {
 	struct st33zp24_spi_phy *phy;
 
-	/* Check SPI platform functionnalities */
-	if (!dev) {
-		pr_info("%s: dev is NULL. Device is not accessible.\n",
-			__func__);
-		return -ENODEV;
-	}
-
 	phy = devm_kzalloc(&dev->dev, sizeof(struct st33zp24_spi_phy),
 			   GFP_KERNEL);
 	if (!phy)
-- 
2.37.3.998.g577e59143f-goog

