Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88260F100
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Oct 2022 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJ0HOE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Oct 2022 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiJ0HN6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Oct 2022 03:13:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5679A153E0F;
        Thu, 27 Oct 2022 00:13:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l6so746576pjj.0;
        Thu, 27 Oct 2022 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8uC60Lm5VPQvrMvRNF42R32uBkv9Pf19UWsJ/wtWPU=;
        b=QBgrM6yNGhTKdBH2jup/NAGiL/CLp/VY8VlvFR5+hlHOj+B6LhTkei9NtNa9+/vxF0
         x84vsvtzspU4nnfkRt4O6p0fyq6BhXTVoh4dB7Uhs5GywQxCIrm3rXpCdF87l6vZMzdP
         U85dYCB4DJbGOJp1gQGQEqhgkhqJ2kFv5EWGnaV7Ym5vlq4rPB7VqsBI9B9g1ANMokuV
         odsDdFX6MB6QLKeelXmqCWRHzNZFCRVeRAaRsFtJFBIhxoDdXo59vIhyFfRa8UetLVAO
         /TBUkrJffERVJQ0BR4NsqgHkphQZfguBF9YH+kU5M0AeuL7nzjSsAN1D80IYTgJrCnT6
         0uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8uC60Lm5VPQvrMvRNF42R32uBkv9Pf19UWsJ/wtWPU=;
        b=s1c/c31OgnO1VS4b9AH1eakI0GThM6lQDX1Ulbm1F7ZbP5ljrxuxSDKnaV+g2VX8HG
         U9yaD5XdiLFFQPCigbCjI+duU7soKa8pH1sigatsc38IfZdr3nAJ3zprnoXHyXNX9dDC
         6dMRRf7f1ChlLR/8MCorTflegYN2TieG8lGf+lpVF2ZndRaFIKRZxM+chXE9pY8Mwl8r
         QdBdR64o0UwTuQ0xHoe9OBfhhmC7F+iAw+NfMjqPzY59m8gp5GS2l7UGqsRrPVu2r/mv
         A9UkrLQrQ+pB88AX1Vwc+8kn1LVQ+FsCG5hEXsTqlta6E0ILO2+WtNljSky9ilf37OjQ
         PFeQ==
X-Gm-Message-State: ACrzQf3rkKPZYE2c9UeC9OohoLD9ny8YtJQrw98Hw+GdwWcCq+I3IqDH
        yrRBOqS2pox9sqmQnlHmDXaIpbzN7bs=
X-Google-Smtp-Source: AMsMyM44rf+HuKWjzpOVsNOhnq00uRA5jnpr0jYjsNsAEzeXfJGnIF4ZeMvWMeqpj8XRLsci1y71YA==
X-Received: by 2002:a17:902:ef52:b0:17c:f072:95bc with SMTP id e18-20020a170902ef5200b0017cf07295bcmr6845576plx.28.1666854836693;
        Thu, 27 Oct 2022 00:13:56 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id je11-20020a170903264b00b00186ac812ab0sm496321plb.83.2022.10.27.00.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:13:55 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] tpm: st33zp24: remove pointless checks on probe
Date:   Thu, 27 Oct 2022 00:13:49 -0700
Message-Id: <20221027071349.991730-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027071349.991730-1-dmitry.torokhov@gmail.com>
References: <20221027071349.991730-1-dmitry.torokhov@gmail.com>
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

v3: no changes
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
index 25b0e7994d27..c249d3f964fd 100644
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
2.38.0.135.g90850a2211-goog

