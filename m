Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E47645168
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Dec 2022 02:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLGBpG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Dec 2022 20:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiLGBpC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Dec 2022 20:45:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF3528A3;
        Tue,  6 Dec 2022 17:45:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so15685761pld.7;
        Tue, 06 Dec 2022 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlNl9gT3ypsVBf/LSDoix4N90A3dWAoRGu2fcw4QFdY=;
        b=OdnHbUTFT/8DmtyOOvv+9E64KEoC8Ar1x7PR3h+pCYBmTIWxvRl6+P227u4lyi6r0c
         wkgwzWhEyx0sWHCMfPfcPysz+c3CWrSmVSjL2Vf6qnxBKCjOu3Yni1u68Lnkt+WwthN5
         IQsWZtYG0Fn9upvsw2LDaFoH/PjCOoSn5LNFc+ojV5jDYW/bo/eERrmUwyPSC9TZyhBK
         9r4p7HoaMXBLMIVdBSOJLGt/sL645J+PkZqCvG0pldZsSmePLuYC0GBsUOPtA7z7syTS
         fVCpcEm3jRmkMeHTSiNb9k8X9xU8OYod0D51V0RwKH3oMHDFfjqlmcZXZNdH70ojpKti
         wcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlNl9gT3ypsVBf/LSDoix4N90A3dWAoRGu2fcw4QFdY=;
        b=HhX91PDA5obvH8WWgs+1wTl92DZ1LQwoKSRttqHrUHOZg6WhwB0HnEygkADJ3O/mkb
         sLmW3MjB0+HKVKIVK1y4kM0bg2zD08v3QmseOkCnmLudXGO52o3KfA+ITqqXu8J98egi
         D0l2SxtnBeliQ7LFNexmYl1znk67FOkuT+hztbawOiIK5nf5cfSfk7n9hOk5k4DetpSb
         X6Ko6L5PDpPs7JFIjDu5Q/dFf84+sqx/1LiMTSFugiGUR1wXKihAJOVDGvbFpBmnfoNW
         S3vH6cWJdIWkv9PHgk9Pit+eVXB1vv2vtiQz37jgeZbDQgfiHY20LvTOjM9v5kGlOl5O
         M0kA==
X-Gm-Message-State: ANoB5plpj8avy99z+N9Hi9ZhaIdG5Jcev0L1j5BE87JLTHyTAfJG+iTN
        VoxHVmgIgd0wLMzI1GHP7Twk4igtk8o=
X-Google-Smtp-Source: AA0mqf6zk6QFzFHpFHKobXxmzNmxQ2D1eKrrBFdOplSBR0uPGNBCXet52/l1L6AYIp7uOVkEkxXbnQ==
X-Received: by 2002:a17:902:9a92:b0:189:9031:6758 with SMTP id w18-20020a1709029a9200b0018990316758mr12236402plp.138.1670377501029;
        Tue, 06 Dec 2022 17:45:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a61:38c7:d37a:7f43])
        by smtp.gmail.com with ESMTPSA id a23-20020a621a17000000b0057630286100sm9853945pfa.164.2022.12.06.17.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:45:00 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:44:57 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] tpm: st33zp24: remove pointless checks on probe
Message-ID: <Y4/wGWTgYfR/Jb9D@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v3: no changes
v2: reworked commit message

This was a part of a 3-patch series, the first 2 dealt with dropping
support for platform data and converting the driver to gpiod API, and
were applied, this one got reviewed-by from Jarkko but for some reason
was left out.

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
2.39.0.rc0.267.gcb52ba06e7-goog


-- 
Dmitry
