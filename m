Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4684973D9
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Jan 2022 18:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiAWRwb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jan 2022 12:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbiAWRwX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jan 2022 12:52:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D36C06173D
        for <linux-integrity@vger.kernel.org>; Sun, 23 Jan 2022 09:52:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh29-0007aH-Qo; Sun, 23 Jan 2022 18:52:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh28-00BycL-Fi; Sun, 23 Jan 2022 18:52:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nBh27-000tzd-1m; Sun, 23 Jan 2022 18:52:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 3/5] tpm: st33zp24: Make st33zp24_remove() a void function
Date:   Sun, 23 Jan 2022 18:51:59 +0100
Message-Id: <20220123175201.34839-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2756; h=from:subject; bh=xanM/4H9Bd80DO/mfvdHRdub2K22KGbCgYSxlx9+sdw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh7ZWy1e/PJkcVrROxK5T6z8YTUUNJu4Inqu5c3JNY tlgPPmKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYe2VsgAKCRDB/BR4rcrsCdUtCA CUuyOVE/+am5ZKhqJvoFkF3PNBMcT39WEXG3AXwkYiKH2FgT5lTbJpnMcOAdo4H116CtXDR9teUVid L9tiE9achFHxhi8ALqj93x1OsCZyV2WTjl5Kb/NrmHYSdNDf/X+EJE1kbHiMHti4rNvS/BLoQYbhzp Rqfia8JhT5IEfTmF1AdM1XMHUworLm9kJT0jK2fI27nDKht7wcCrFFeX+K9Ab+cwxWqKkJqY7v1HIV sGdmfBvb4zt9p1AWBL72BWuu+Jnrz523cfsNv/cSBGhTBnRxdmvlsNAMEiXKqA63uCiileVpJHeiWy 8APu5Fm5YQKTSWe2KyIyiYvpu6qG4K
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

Link: https://lore.kernel.org/r/20220104231103.227924-1-u.kleine-koenig@pengutronix.de
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
index ce9efb73c144..15b393e92c8e 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -511,10 +511,9 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 }
 EXPORT_SYMBOL(st33zp24_probe);
 
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
2.34.1

