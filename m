Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B5B6C0BBC
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 09:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCTIGc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCTIG1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 04:06:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A9314E9A
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 01:06:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX4-00068g-0d; Mon, 20 Mar 2023 09:06:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX3-005PKB-DH; Mon, 20 Mar 2023 09:06:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX1-006OCs-V7; Mon, 20 Mar 2023 09:06:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/3] tpm/tpm_tis: Convert to platform remove callback returning void
Date:   Mon, 20 Mar 2023 09:06:06 +0100
Message-Id: <20230320080607.306495-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1UyU5L1rMsYYBEv7hAOPoVer7b7HLeh5HnUGe7VevMI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGBPrWKdDOOrpVK0Rhmdg5YgSR3WbEkphAD95c 0L2HmAyNHqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBgT6wAKCRCPgPtYfRL+ TlSNB/9qq/QWIczxk1Jcukg+QdFWPt7RsSVSzEL3ZWP2kdxVGAfx4/lZWhuhMm8X3/lvhi76yTH k+kC5F63kJUqSerUXOcfkW4XK/RH/Hcm5fLdrXn1fNA8g5b8zPbCLzsUdfoNZIYULuY8TN/0f1L UkGJE9FPofzLEepbzPZKxUeAr3ejDD/3A+mGueWo+/qaNBLaGFCN4Aznd1q2yyJcG2cG9D5UsaS HL3bNbYFCKhApEpxN3nGR1zIkhr1OcIQ6kFjiNJvaPQhXMnrn4VxYz5qlQKUS2VMqtn6BrTF974 f+VyfFqPGQE5XhXEFbC/pKxVPHOXeAv9un+tZ2/UUP6o6hzn
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
 drivers/char/tpm/tpm_tis.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ed5dabd3c72d..fe2b889cd13d 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -324,14 +324,12 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
 	return tpm_tis_init(&pdev->dev, &tpm_info);
 }
 
-static int tpm_tis_plat_remove(struct platform_device *pdev)
+static void tpm_tis_plat_remove(struct platform_device *pdev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
 
 	tpm_chip_unregister(chip);
 	tpm_tis_remove(chip);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -344,7 +342,7 @@ MODULE_DEVICE_TABLE(of, tis_of_platform_match);
 
 static struct platform_driver tis_drv = {
 	.probe = tpm_tis_plat_probe,
-	.remove = tpm_tis_plat_remove,
+	.remove_new = tpm_tis_plat_remove,
 	.driver = {
 		.name		= "tpm_tis",
 		.pm		= &tpm_tis_pm,
-- 
2.39.2

