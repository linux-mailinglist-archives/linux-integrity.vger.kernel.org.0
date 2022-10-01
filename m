Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92B85F1A0E
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 07:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJAFvv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Oct 2022 01:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJAFvu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Oct 2022 01:51:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405AE2559B;
        Fri, 30 Sep 2022 22:51:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 10so2002517pli.0;
        Fri, 30 Sep 2022 22:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=a3vzhRK1Q2NWu6tijC9jAXxq+6f9f5sg6oBazUuCYOU=;
        b=PD1K/zGUmG6P/1xnC/2RTxP7tR7oiTbozxGB8cpd1o6GWEcK/8mhK2PIIblUKrgLn6
         L6R9OjQYF+mrJuEfhK6myMaAvs2/ZaMN/pkmRb3r9GpATNhlY1jxvzPJxvCeX1cb7gGd
         1spYZ4BC4Esg60o2VD2WAizBBH+9Jdf82iHMfa36IKElBRdmxSyUNxrC2c7kDRX1FeXx
         TZkJPasuOmcFagtoEKnJq7lQ4TuJZDL/VClFBgNkTF2rVycSUfTlaUWOK8x2kRXXYXrp
         ZpchDEsunVWNIsuWVgfRnyHRdtvqonN/xVTQRKuMU06pHhL7hzcQziVs/Cnzsd2KrcEv
         EjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a3vzhRK1Q2NWu6tijC9jAXxq+6f9f5sg6oBazUuCYOU=;
        b=PnpuXg4I4msP32jwnfVQm6+2RBW8bdebK3oLl8XtLRpnK6uAUrbh00iUns/1jXU+9F
         INqEy/6FkCoVgLFAXvTdKdwqSypHitBpdo3F2fofKqbzM5gD8ffIt7TBZ1AYJGYZ6mgV
         Ui344WOpwhx7P6uxl9Tk9AGriA7KNzVPPimvaGpOneqmRjJPpxx6aY1/nXll30w/qzGs
         TH4jEpKp5W7bYtFkZpiVEI1V8KmOGBj1Ag0E532dMYLO5XOJDOyU6lvDhcSTSy9TrUUB
         ZDrz/J6WAVGdY+Jikco02cmoJBQAHGDotKsEBGpPBxyJQe+wbTxWLWC049lNO8ZeGQk1
         MgKQ==
X-Gm-Message-State: ACrzQf2MB/Y0ecDz9UjYsqwtu3lWzHtBKy5WF0pPQlk9RY3CAc5vSMqi
        7b4QPC/PPJj5dIn05l30u+M=
X-Google-Smtp-Source: AMsMyM5Rx4JhhOVKpnSlRjoaLR/ogpuq66B6ItcEv+rYHlyDSHu+xr8FXa1UQrRNuj5q1lecA3Wb0Q==
X-Received: by 2002:a17:902:8347:b0:178:6e81:35ce with SMTP id z7-20020a170902834700b001786e8135cemr11976582pln.23.1664603508614;
        Fri, 30 Sep 2022 22:51:48 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79599000000b0055f6a0d82e0sm613268pfj.51.2022.09.30.22.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 22:51:48 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] tpm: st33zp24: remove pointless checks on probe
Date:   Fri, 30 Sep 2022 22:51:42 -0700
Message-Id: <20221001055142.3196483-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221001055142.3196483-1-dmitry.torokhov@gmail.com>
References: <20221001055142.3196483-1-dmitry.torokhov@gmail.com>
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

Remove tests for SPI device or I2C client to be non-NULL because
driver core will never call driver's probe method without having
a valid device structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: reworked commit message

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
2.38.0.rc1.362.ged0d419d3c-goog

