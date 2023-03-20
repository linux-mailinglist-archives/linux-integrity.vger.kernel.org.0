Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4FC6C0BBA
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 09:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCTIGa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCTIG1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 04:06:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CC21422F
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 01:06:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX3-00068f-V7; Mon, 20 Mar 2023 09:06:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX3-005PK8-AD; Mon, 20 Mar 2023 09:06:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX2-006OCv-5B; Mon, 20 Mar 2023 09:06:16 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 3/3] tpm/tpm_tis_synquacer: Convert to platform remove callback returning void
Date:   Mon, 20 Mar 2023 09:06:07 +0100
Message-Id: <20230320080607.306495-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NQjaHtGPwJE7TicGWHp/UREo05zMVS/r5r/8WbZ7yBI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhQJ4TcXu1rTdp1++HpXi9qu9S8ufyh6mh2wa/oXH9ay/ M/RCr/WdjIaszAwcjHIiimy2DeuybSqkovsXPvvMswgViaQKQxcnAIwEXcx9v9VikxLb/i2VpZU HTnK7zHz9emH6aKf6pVem3FK8S1aU/5F1i6z1qd7J5N09b1E/lUXdu9pOPRgs6P9BJ7nKXFCysa fGrvCGDJ1Oxki9tuX27vb3mEu8cjIFw7Sf3bkLU9OYo7nwTLpbJl/MYJicpsfanYeW7woVWgP79 QX8VOs31m2ph5auMVd9umL7JsXK92uruD1Wyi/K6Uw0MrjVS3rAUEp/XKrT99E/xYw7Hfv+pXo3 mzw5k7Xsijm2fP3Fc/QnH277X5H0x3OYpFDrDyZXlMe6Jl+v9eu2uuirGrwZ5X12u/OjRMbj3CY LzTispmj4fxPWiKOq6tq1h+/WLUFU2tDFz0Wc85fFPkYAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/tpm/tpm_tis_synquacer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
index 679196c61401..49278746b0e2 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -127,14 +127,12 @@ static int tpm_tis_synquacer_probe(struct platform_device *pdev)
 	return tpm_tis_synquacer_init(&pdev->dev, &tpm_info);
 }
 
-static int tpm_tis_synquacer_remove(struct platform_device *pdev)
+static void tpm_tis_synquacer_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -155,7 +153,7 @@ MODULE_DEVICE_TABLE(acpi, tpm_synquacer_acpi_tbl);
 
 static struct platform_driver tis_synquacer_drv = {
 	.probe = tpm_tis_synquacer_probe,
-	.remove = tpm_tis_synquacer_remove,
+	.remove_new = tpm_tis_synquacer_remove,
 	.driver = {
 		.name		= "tpm_tis_synquacer",
 		.pm		= &tpm_tis_synquacer_pm,
-- 
2.39.2

