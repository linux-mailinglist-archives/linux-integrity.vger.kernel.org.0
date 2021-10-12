Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC542A881
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Oct 2021 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbhJLPmJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Oct 2021 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbhJLPmC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Oct 2021 11:42:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A271C061570
        for <linux-integrity@vger.kernel.org>; Tue, 12 Oct 2021 08:40:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsi-0000GR-MA; Tue, 12 Oct 2021 17:39:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsi-0004jt-3w; Tue, 12 Oct 2021 17:39:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsf-0004ZK-1f; Tue, 12 Oct 2021 17:39:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 20/20] tpm: st33zp24: Make st33zp24_remove() return void
Date:   Tue, 12 Oct 2021 17:39:45 +0200
Message-Id: <20211012153945.2651412-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=2RfjlQngpYVdDmF7/sh7VSPt9aAaxh1F9oCTWbtcFaI=; m=YmvLiK47JXRlSzLFzxqwlRAcg9TrPiYd49fSIG4963c=; p=J4sUOjxlatUSZp6KZXQHP7X5Nt2PutSw8I364wwqzYo=; g=fcea7ec8c956ac6a1c9afce0aa9705bb0fa52453
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrDsACgkQwfwUeK3K7Al++wf/T7U BatUKSlTBuJgmVw3wJPKYATQxH2k+OkCGL8UcAuKk++dm+EX1WT6PF/3yyhszwvZmFK8NkysabDTK OKDMQ+V3fg/dlAaVYv3L8uqC/BHO9qL0lffpGhogS1uF1UMbnO0IP2k/HqRxknijkWWsN5JfjAC5M 7CiYl8yhdAaYuzXqxQSL27iV2QicbzQjZ9gSpENmnJ0gdvlge+G3FAq6Fh0DXdF+SyhtGYM2ZV+Px XWAQLPxTRP+4PrpBAuJIdmsVzUzvw/9ANbXmqxoh4Js27SZt1pYgZrcXBezQWTSNIUFb9CreIdOUG ZHiIasfdEq0A+UmpOcxU1FfA8J2DwFQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Up to now st33zp24_remove() returns zero unconditionally. Make it return
void instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of i2c and spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/tpm/st33zp24/i2c.c      | 5 +----
 drivers/char/tpm/st33zp24/spi.c      | 5 +----
 drivers/char/tpm/st33zp24/st33zp24.c | 3 +--
 drivers/char/tpm/st33zp24/st33zp24.h | 2 +-
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 7c617edff4ca..3170d59d660c 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -267,11 +267,8 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
 static int st33zp24_i2c_remove(struct i2c_client *client)
 {
 	struct tpm_chip *chip = i2c_get_clientdata(client);
-	int ret;
 
-	ret = st33zp24_remove(chip);
-	if (ret)
-		return ret;
+	st33zp24_remove(chip);
 
 	return 0;
 }
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index a75dafd39445..ccd9e42b8eab 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -384,11 +384,8 @@ static int st33zp24_spi_probe(struct spi_device *dev)
 static int st33zp24_spi_remove(struct spi_device *dev)
 {
 	struct tpm_chip *chip = spi_get_drvdata(dev);
-	int ret;
 
-	ret = st33zp24_remove(chip);
-	if (ret)
-		return ret;
+	st33zp24_remove(chip);
 
 	return 0;
 }
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 4ec10ab5e576..2b63654c38d6 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -588,10 +588,9 @@ EXPORT_SYMBOL(st33zp24_probe);
  * @param: tpm_data, the tpm phy.
  * @return: 0 in case of success.
  */
-int st33zp24_remove(struct tpm_chip *chip)
+void st33zp24_remove(struct tpm_chip *chip)
 {
 	tpm_chip_unregister(chip);
-	return 0;
 }
 EXPORT_SYMBOL(st33zp24_remove);
 
diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
index 6747be1e2502..b387a476c555 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.h
+++ b/drivers/char/tpm/st33zp24/st33zp24.h
@@ -34,5 +34,5 @@ int st33zp24_pm_resume(struct device *dev);
 
 int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 		   struct device *dev, int irq, int io_lpcpd);
-int st33zp24_remove(struct tpm_chip *chip);
+void st33zp24_remove(struct tpm_chip *chip);
 #endif /* __LOCAL_ST33ZP24_H__ */
-- 
2.30.2

