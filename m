Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3744EFC7
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Nov 2021 23:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhKLW4N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Nov 2021 17:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhKLW4N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Nov 2021 17:56:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B19FC061766
        for <linux-integrity@vger.kernel.org>; Fri, 12 Nov 2021 14:53:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlfQ6-0000ZE-2t; Fri, 12 Nov 2021 23:53:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlfQ4-000ACg-O8; Fri, 12 Nov 2021 23:53:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlfQ3-00036m-My; Fri, 12 Nov 2021 23:53:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Subject: [PATCH] char: tpm: cr50_i2c: Drop if with an always false condition
Date:   Fri, 12 Nov 2021 23:53:08 +0100
Message-Id: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=SoW3Vuwhm8TIB5U4C9nlfKtJzkJHhUKcJlsyB7JbSpU=; m=5f3SEN4FqM+YnOUw7E3FyRLD55kyrMfA0yuJJExPdXQ=; p=UBEVABVT/pG5pknLPNg0e9utpAcWJRcwUGvkvbxr+QM=; g=9ec5403f3f20fb6409e4d318f6a23126681b003d
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGO8EMACgkQwfwUeK3K7AnxRgf8Ce7 ck5P6nDd15FnxtZiUgE2cHL31Bi4KF0U+whIjBMOF2N95o8FbPncSSoBed+nAOQVEEJihlN3cdcGH Mqpjx793aaoRuQ7ru+2vhYigEJzaVU2V6pIPjF3T0S01HjN99qnJTaE9ShPUBphkgRAHJoafjl/jG BrSJTNayjxFXVO6CJnlDQiP3Bj8HocWMWJ5hdsHatqH01ztJOAD86YffhUP8Cw/CzE5CgMmIg6VSM 263GjVTqp35MY23GGp/Dg58wSXYFi3ka1cCkmw/IWGpYlAlYYKK9f8tJ6EnfdXKYjMWDuA/UELpwZ JLNNTq20D543p30brGYKCWGjR5Pplig==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe() returned
successfully. As i2c_get_clientdata() returns driver data for the
client's device and this was set in tpmm_chip_alloc() it won't return
NULL.

Simplify accordingly to prepare changing the prototype of the i2c remove
callback to return void. Notice that already today returning an error
code from the remove callback doesn't prevent removal.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index c89278103703..622cdf622ddc 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -751,12 +751,6 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 static int tpm_cr50_i2c_remove(struct i2c_client *client)
 {
 	struct tpm_chip *chip = i2c_get_clientdata(client);
-	struct device *dev = &client->dev;
-
-	if (!chip) {
-		dev_err(dev, "Could not get client data at remove\n");
-		return -ENODEV;
-	}
 
 	tpm_chip_unregister(chip);
 	tpm_cr50_release_locality(chip, true);
-- 
2.30.2

