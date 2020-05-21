Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B381DC728
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2020 08:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEUGsA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 May 2020 02:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgEUGr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 May 2020 02:47:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CCDC061A0E
        for <linux-integrity@vger.kernel.org>; Wed, 20 May 2020 23:47:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so6962274ljj.1
        for <linux-integrity@vger.kernel.org>; Wed, 20 May 2020 23:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WyySsXsCG9MIZJ/jWPxqgRjjVutKdSUUpR6QxpSgcX4=;
        b=V0TloVpYXP1bD/hsGAN4FygY70Z10WXF8RyXqXiDRncUdBTwJx59ccQQiokBtmpdeu
         jZGSHMEyjjN+DskrvebXPqYGTD8x3xcgy9dlwuo6j5rcTF3tcUkuN111RTcWv9e5r7pK
         DSer1RFGvh/sEBNScC2KQH8TMrlGaNnHUzMfeMTpzOisNUyP5bwMLpxZJJs5+DsGbKv3
         nPvcjLsTjnk/Ofkd+DWgyyCyClD1Pj0A7vJIJeNs5DaZg5kKc8mVL7Vvmvo5iiQtmIFh
         MVWQ7sVFRtiENruXVqQ6oywYRPBGR0dTAepNLvpFmWbNO3CLd2xbfjTA919ggJbNJIHe
         xa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WyySsXsCG9MIZJ/jWPxqgRjjVutKdSUUpR6QxpSgcX4=;
        b=UUCGC2b8zuZ7xOJ2uR8eqxiiCfWPRH4rEqsZh4/zeE8zqyJWfjcGSPn8nMffwCVBs1
         tM1DFYKl6+AIPLUZMBrqteMxNGYx5KyjtSw0FlSYma6dE0C3I5/39WlBgJIYpB/6gAbe
         uxLLOYUr/WQ+NlBFJrZlEg4fpTrNp5L1EH/WaPhpxuJXou4ZOCS48/4haHqlSL2Wzo9u
         y3iE2MfeiVNNmKV2R6mFke6ECTYPSvFm2wGMAJn0JwH+J0JBC6wMbtR2rKGbUk2ssgPR
         eLzsD2MpOlxnb1QEFBzGN2gW+fb9If5M2ViCUZMrWWYRAytu/jv1dK5yTWXPTT9imLfT
         aKxQ==
X-Gm-Message-State: AOAM532eIo4x/MgTPL3AaHWWHDdtxbUHZ4fSDsF2aYANpNOHKrHegJxi
        b38pNoyW8nq10NgahX8GZeHesw==
X-Google-Smtp-Source: ABdhPJw9fk0dkqjBiw67XDw5+R1u6y1FF6vogoFFNQ59RVVueMV4QBR6Z2+seXfp0A+gjlvb5Uw/cA==
X-Received: by 2002:a2e:b5d1:: with SMTP id g17mr4268376ljn.59.1590043673998;
        Wed, 20 May 2020 23:47:53 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id z16sm1807465lfq.18.2020.05.20.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:47:53 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
Date:   Thu, 21 May 2020 09:47:43 +0300
Message-Id: <20200521064743.4769-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521064743.4769-1-maxim.uvarov@linaro.org>
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Register driver on TEE bus. module tee registers bus,
and module optee calls optee_enumerate_devices() to scan
all devices on the bus. Trusted Application for this driver
can be Early TA's (can be compiled into optee-os). In that
case it will be on OPTEE bus before linux booting. Also
optee-suplicant application is needed to be loaded between
OPTEE module and ftpm module to maintain functionality
for fTPM driver.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Arnd Bergmann <arnd@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 69 ++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 22bf553ccf9d..7bb4ce281050 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -214,11 +214,10 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
  * Return:
  *	On success, 0. On failure, -errno.
  */
-static int ftpm_tee_probe(struct platform_device *pdev)
+static int ftpm_tee_probe(struct device *dev)
 {
 	int rc;
 	struct tpm_chip *chip;
-	struct device *dev = &pdev->dev;
 	struct ftpm_tee_private *pvt_data = NULL;
 	struct tee_ioctl_open_session_arg sess_arg;
 
@@ -297,6 +296,13 @@ static int ftpm_tee_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static int ftpm_plat_tee_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ftpm_tee_probe(dev);
+}
+
 /**
  * ftpm_tee_remove() - remove the TPM device
  * @pdev: the platform_device description.
@@ -304,9 +310,9 @@ static int ftpm_tee_probe(struct platform_device *pdev)
  * Return:
  *	0 always.
  */
-static int ftpm_tee_remove(struct platform_device *pdev)
+static int ftpm_tee_remove(struct device *dev)
 {
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
 
 	/* Release the chip */
 	tpm_chip_unregister(pvt_data->chip);
@@ -328,11 +334,18 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int ftpm_plat_tee_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ftpm_tee_remove(dev);
+}
+
 /**
  * ftpm_tee_shutdown() - shutdown the TPM device
  * @pdev: the platform_device description.
  */
-static void ftpm_tee_shutdown(struct platform_device *pdev)
+static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
 
@@ -347,17 +360,53 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
 
-static struct platform_driver ftpm_tee_driver = {
+static struct platform_driver ftpm_tee_plat_driver = {
 	.driver = {
 		.name = "ftpm-tee",
 		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
 	},
-	.probe = ftpm_tee_probe,
-	.remove = ftpm_tee_remove,
-	.shutdown = ftpm_tee_shutdown,
+	.shutdown = ftpm_plat_tee_shutdown,
+	.probe = ftpm_plat_tee_probe,
+	.remove = ftpm_plat_tee_remove,
+};
+
+static const struct tee_client_device_id optee_ftpm_id_table[] = {
+	{UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
+		   0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
+	{}
 };
 
-module_platform_driver(ftpm_tee_driver);
+MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
+
+static struct tee_client_driver ftpm_tee_driver = {
+	.id_table	= optee_ftpm_id_table,
+	.driver		= {
+		.name		= "optee-ftpm",
+		.bus		= &tee_bus_type,
+		.probe		= ftpm_tee_probe,
+		.remove		= ftpm_tee_remove,
+	},
+};
+
+static int __init ftpm_mod_init(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&ftpm_tee_plat_driver);
+	if (rc)
+		return rc;
+
+	return driver_register(&ftpm_tee_driver.driver);
+}
+
+static void __exit ftpm_mod_exit(void)
+{
+	platform_driver_unregister(&ftpm_tee_plat_driver);
+	driver_unregister(&ftpm_tee_driver.driver);
+}
+
+module_init(ftpm_mod_init);
+module_exit(ftpm_mod_exit);
 
 MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
 MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
-- 
2.17.1

