Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED06C0BB9
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 09:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCTIG2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 04:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCTIG0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 04:06:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E858114E8C
        for <linux-integrity@vger.kernel.org>; Mon, 20 Mar 2023 01:06:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX3-00068e-Qv; Mon, 20 Mar 2023 09:06:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX3-005PK5-6G; Mon, 20 Mar 2023 09:06:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1peAX1-006OCp-Op; Mon, 20 Mar 2023 09:06:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/3] tpm/tpm_ftpm_tee: Convert to platform remove callback returning void
Date:   Mon, 20 Mar 2023 09:06:05 +0100
Message-Id: <20230320080607.306495-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7Zr2bZcWF6QwqeT4Oa94Xv8wT3EoWo296pQfyEzYldA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGBPq7BLdGRigORnKCzVxurX31AhShNoZXB3mt b4rOvOUsAaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBgT6gAKCRCPgPtYfRL+ Tti8B/4+143+Oeaw4NH1CGYm6M6XnAZ+Dwhnx7OY7Qxbn39f+T6agccRheTw4vXhy/CkQaUsOWb S0Xe/2azKczZSvBeZvEDl4XG2MM5It8ONlMH6ib+Xiac2j21eTAI46+aSblhnG8MoEuOL4OQIiH nV0HXjAEwWA9jh+hHTs2tRvAQDXlsI/gGqZxjgG1Z6RoaroRw1jaoAvAbSeIeMwZ6TAIN1fA9KB SdroYJJp2diCE6E7ZPqLnNArQchmzcMn26zd8xnWWszEmRIsQRkxcwDy6qd3Qk78feOaeRFggFY b89SF4oBr77TW3oX1D7sAJ2Oc7m2rloDTHiFKnlrhENLG25Z
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

ftpm_tee_remove() returns zero unconditionally (and cannot easily
converted to return void). So ignore the return value to be able to make
ftpm_plat_tee_remove() return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index deff23bb54bf..528f35b14fb6 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -334,11 +334,11 @@ static int ftpm_tee_remove(struct device *dev)
 	return 0;
 }
 
-static int ftpm_plat_tee_remove(struct platform_device *pdev)
+static void ftpm_plat_tee_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	return ftpm_tee_remove(dev);
+	ftpm_tee_remove(dev);
 }
 
 /**
@@ -367,7 +367,7 @@ static struct platform_driver ftpm_tee_plat_driver = {
 	},
 	.shutdown = ftpm_plat_tee_shutdown,
 	.probe = ftpm_plat_tee_probe,
-	.remove = ftpm_plat_tee_remove,
+	.remove_new = ftpm_plat_tee_remove,
 };
 
 /* UUID of the fTPM TA */
-- 
2.39.2

