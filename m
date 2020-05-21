Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BCC1DC726
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2020 08:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEUGrz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 May 2020 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgEUGry (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 May 2020 02:47:54 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9729C061A0E
        for <linux-integrity@vger.kernel.org>; Wed, 20 May 2020 23:47:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so6883295lji.12
        for <linux-integrity@vger.kernel.org>; Wed, 20 May 2020 23:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0aUlMq/63glpNB0bkXwx31ZfwXJhcL6Z/BXqIB9cFM=;
        b=G1pyU+CRNBOLJfXsduHj4Pu+5ng80gQz/l4uHoITgKsD3LoCGELrne8d6nysQV4e6S
         RsTSM9gLf8Ss3G9upeaClk74eXYU/qqsDFkKopUuXsY2Atfg+oBvupt0cjB4MOgNF+iS
         1oSjhRoLkqyitC3cNR+XYMjOYHgKM3khsiiUbTloIAxPHzqUr05byYRsCNzEt9C6VYj5
         6CxJvKQdNL+Tcilw+n7M5Bo9LWQCZVGP2uxvpWKGwz1fU3YCVPjtg+2pQrfnnwkd7GXc
         9cG4Cgn5Hi8blOSKVedWxxmNPULKPptTQj73kLZV2BS5QkI+It9bzh8Iu5yVpt3G10DD
         SoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0aUlMq/63glpNB0bkXwx31ZfwXJhcL6Z/BXqIB9cFM=;
        b=oVoZv8RJ0MBElfww2AcafLMisPkAbUxyfz+C5sVlXpzY851wH0QrYSwbjRFciakBN0
         o4EklzuCZM+zKdPYv7XEFH6CRw9JrDFo5bwGG6ySVkMi9Hg4MGBbGgEceb3nMjCYLTYY
         c+DZo2HW0j9aDsGl2JCC8FoRXeJYP0bP33fdUjpO2s9zoj9OAkC4AXJquVAkZ1kPa6Wz
         YqzE2FL22bwKKRgr4WVeQiGV38bOTzUK+TnQFKcwVpO7L8kPTGpsAwR5C2Co527sZ2yb
         Zl66ZEu3D1iy38VxzY3yqQEENO0ryh/TwBVtaxZTcpaC0qEqtbnj0huf86pxLX7FqrB6
         KHsA==
X-Gm-Message-State: AOAM5322Dp2RbhGW+CDew7rT3fzb1ts+ecMqcy0iBGVW17xSzLjQWqAi
        bRwcoLEts1ew84vV4DqRddr/ww==
X-Google-Smtp-Source: ABdhPJwtGiO8F6wmOrX7d82BHZk8h+sIG7Yr8WAP9VQ255vnF0mu1gfMBixN8vVbIG95C+b6y0eIqQ==
X-Received: by 2002:a2e:b3cd:: with SMTP id j13mr4424226lje.237.1590043672417;
        Wed, 20 May 2020 23:47:52 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id z16sm1807465lfq.18.2020.05.20.23.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 23:47:51 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCH 2/2] tpm_ftpm_tee: register driver on tee bus
Date:   Thu, 21 May 2020 09:47:42 +0300
Message-Id: <20200521064743.4769-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521064743.4769-1-maxim.uvarov@linaro.org>
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Register driver on tee bus. module tee registers bus,
and module optee calls optee_enumerate_devices() to scan
all devices on the bus. This TA can be Early TA's ( can be
compiled into optee-os). In that case it will be on optee
bus before linux booting. Also optee-suplicant application
is needed to be loaded between optee module and ftpm module to
to maintain functionality for ftpm driver.

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

