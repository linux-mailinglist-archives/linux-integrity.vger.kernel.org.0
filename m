Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E97484B16
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiADXLQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 18:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiADXLQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 18:11:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FAFC061761
        for <linux-integrity@vger.kernel.org>; Tue,  4 Jan 2022 15:11:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4sxT-0002pc-Dh; Wed, 05 Jan 2022 00:11:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4sxR-008UVE-Pv; Wed, 05 Jan 2022 00:11:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n4sxQ-0003ls-BY; Wed, 05 Jan 2022 00:11:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Cc:     linux-integrity@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: [PATCH v3] tpm: st33zp24: Make st33zp24_remove() a void function
Date:   Wed,  5 Jan 2022 00:11:03 +0100
Message-Id: <20220104231103.227924-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; h=from:subject; bh=80KsYLOHTqSH02UuY0HZVOPoJasZOIRyvA5e9kvk04M=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh1NPbdxXJECkrmj+EyM7A7q8i97xjl/KulqcK2QSu IW8DB9WJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYdTT2wAKCRDB/BR4rcrsCSTKCA Cg3Di+C9G2tjMrWxCU/ybNQMpUCpwK/VMsOdSR3b3K+9eOqrqBJLFbS8Vz5t4V4Ib/ZD2nSVvOoGqd i5YmmK8mgJCE5X2aWf68r8lCF8EX1+uGI+UAWE3gj+YazqlydmKOqIKMXUFTkOdlg+v1hMJ67FYFod wnrk5WXRXtNddunxy6Vq0diG99W36a7eklSwEGndjQw8gQNZK/rC9dq3R+dpGigCXeLwCqUq4EjPA6 OwBQhMQl81KB0hQ6hyEgF7TvnbPxenrD/9I/gxZ362K0VUpfNUUTS12HJeD5leARmR/ZLerfHSIhCz Dsn13JkhW0VOX7VdkDsLnKRigG4RYj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Up to now st33zp24_remove() returns zero unconditionally. Make it return
no value instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of i2c and spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes since v2:

 - reword commit log to not say "return void"

Best regards
Uwe

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

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
-- 
2.34.1

