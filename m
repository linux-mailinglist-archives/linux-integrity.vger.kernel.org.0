Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE671180F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 May 2023 22:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbjEYUZE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 May 2023 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjEYUZD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 May 2023 16:25:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5AFE2
        for <linux-integrity@vger.kernel.org>; Thu, 25 May 2023 13:24:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2HVd-0004Pg-VS; Thu, 25 May 2023 22:24:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2HVb-002njl-ES; Thu, 25 May 2023 22:24:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2HVa-007xRo-Jw; Thu, 25 May 2023 22:24:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tpm: Switch i2c drivers back to use .probe()
Date:   Thu, 25 May 2023 22:24:24 +0200
Message-Id: <20230525202424.630260-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3875; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=s4gzQpu/cnWE/azhbPTFeCDvBQGiwpuB+zul42Ilj3k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkb8PvnJP6QYPqtuF1ADwvHbyGmWy0tct9ADxv9 k1TlEhk2pmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG/D7wAKCRCPgPtYfRL+ TuYlB/44PConlpiAujaRiCguop25vfvRm9DPggOQSg27VtYHSQpFywJiWpUNTYdi8u+fWMA5n/q EFoj0zJCZ8CleKK8U0dcTlJzYs627/sLiv8N48H2aiCXhacsREZgMt5hV0+fu8kFnDwFS/zctCM HBEjRPoOfugopZP59U8SJB89J94j07PaKCgxOxZ65+iWlkgsKoS5d7FX3CzjsB/O3yi3yuPXTtH 4iZ1V8jEt2m2Xgv8oTaA+8LcJRdyg6nlKHslu9pBTvTXfmJpqUQA4u994rf34Wyxo1uKAD1MVDE tHORWOKPuUilYWoW2+kazAUigq6VNFKlBuSUEE0e6xWOud8e
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/tpm/st33zp24/i2c.c     | 2 +-
 drivers/char/tpm/tpm_i2c_atmel.c    | 2 +-
 drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c  | 2 +-
 drivers/char/tpm/tpm_tis_i2c.c      | 2 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 2d28f55ef490..661574bb0acf 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -160,7 +160,7 @@ static struct i2c_driver st33zp24_i2c_driver = {
 		.of_match_table = of_match_ptr(of_st33zp24_i2c_match),
 		.acpi_match_table = ACPI_PTR(st33zp24_i2c_acpi_match),
 	},
-	.probe_new = st33zp24_i2c_probe,
+	.probe = st33zp24_i2c_probe,
 	.remove = st33zp24_i2c_remove,
 	.id_table = st33zp24_i2c_id
 };
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 8f77154e0550..301a95b3734f 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -203,7 +203,7 @@ static SIMPLE_DEV_PM_OPS(i2c_atmel_pm_ops, tpm_pm_suspend, tpm_pm_resume);
 
 static struct i2c_driver i2c_atmel_driver = {
 	.id_table = i2c_atmel_id,
-	.probe_new = i2c_atmel_probe,
+	.probe = i2c_atmel_probe,
 	.remove = i2c_atmel_remove,
 	.driver = {
 		.name = I2C_DRIVER_NAME,
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 7cdaff52a96d..81d8a78dc655 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -716,7 +716,7 @@ static void tpm_tis_i2c_remove(struct i2c_client *client)
 
 static struct i2c_driver tpm_tis_i2c_driver = {
 	.id_table = tpm_tis_i2c_table,
-	.probe_new = tpm_tis_i2c_probe,
+	.probe = tpm_tis_i2c_probe,
 	.remove = tpm_tis_i2c_remove,
 	.driver = {
 		   .name = "tpm_i2c_infineon",
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index a026e98add50..d7be03c41098 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -650,7 +650,7 @@ static SIMPLE_DEV_PM_OPS(i2c_nuvoton_pm_ops, tpm_pm_suspend, tpm_pm_resume);
 
 static struct i2c_driver i2c_nuvoton_driver = {
 	.id_table = i2c_nuvoton_id,
-	.probe_new = i2c_nuvoton_probe,
+	.probe = i2c_nuvoton_probe,
 	.remove = i2c_nuvoton_remove,
 	.driver = {
 		.name = "tpm_i2c_nuvoton",
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index c8c34adc14c0..11b4196b7136 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -379,7 +379,7 @@ static struct i2c_driver tpm_tis_i2c_driver = {
 		.pm = &tpm_tis_pm,
 		.of_match_table = of_match_ptr(of_tis_i2c_match),
 	},
-	.probe_new = tpm_tis_i2c_probe,
+	.probe = tpm_tis_i2c_probe,
 	.remove = tpm_tis_i2c_remove,
 	.id_table = tpm_tis_i2c_id,
 };
diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index 376ae18a04eb..e70abd69e1ae 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -779,7 +779,7 @@ static void tpm_cr50_i2c_remove(struct i2c_client *client)
 static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
 
 static struct i2c_driver cr50_i2c_driver = {
-	.probe_new = tpm_cr50_i2c_probe,
+	.probe = tpm_cr50_i2c_probe,
 	.remove = tpm_cr50_i2c_remove,
 	.driver = {
 		.name = "cr50_i2c",
-- 
2.39.2

