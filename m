Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD86A1D79F6
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2020 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERNfO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 May 2020 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgERNfM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 May 2020 09:35:12 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74614C061A0C
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 06:35:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 82so8084774lfh.2
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2020 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0aUlMq/63glpNB0bkXwx31ZfwXJhcL6Z/BXqIB9cFM=;
        b=SBV5322WvYvfG6DaHYiEeKge8brMMkEZoKx5eT3RELJi/imRy/M2jc9NZKqDGmIDBS
         KHEjea0KFpcxhVb1ThwIMx7gu2Pb/YQKI+sZ/DZyD2NUZGySRpTWUCDNxQcQuQ/6XCtO
         77lJjskguAOcwyKrcyUAoYZs3uZuadhJ6HiYfKo8MzkvYcVsLdSrYqRZP6UDUdsPKQpL
         udfh+YlzfN3QfVCKLjfv5xesuTjp8cGddvi+oLSDd6vhBfEWs6jkTIQfmgCJzYFiU4e7
         A754vXdJWIBmi4F9Ig5oopa7TJAMXbDOR/HmKyNVUiGwNgF/J0ri+V4GknF48EZ7H0JP
         IluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0aUlMq/63glpNB0bkXwx31ZfwXJhcL6Z/BXqIB9cFM=;
        b=U2ez+bwUXTrXs/266IuH8G5VV12HfNQs49QpzXN4w4ODfRC+v5s/j4tajY9W7KdyE3
         mFtt+wwthYxcEchR6utP5mKhGiwz3eZuh4ecPPBYO+307XBOJy2c2LoHRe+mGk8buJr4
         yhtspk7CxMkCHmpEuEEoA8bOKQd7Hsjo9tsmWgV0E855e+mf1XL1klzbuQVUFHp6wUhW
         Wb4eiOJ0agSzgJx+MFL+9SlUY+Gf6K+4fyozPn+JLLiiR49Fsf6t6KaffPjOGI3wRDqh
         NKiRKPoUpfEap8M5w8gDfvaSbEkP27zeaJIvzy7ERaQX01gb4cmEoM9UaF0Pez6P43r6
         +zWQ==
X-Gm-Message-State: AOAM532bwhjbqV6ImWk1tjHjZPK3FQh/87HJdidXTvvzEkRxLLj7IRfX
        Ltjvg7VpuC0cYsIijwd/snqKlg==
X-Google-Smtp-Source: ABdhPJwbRlLvvQGBnUhqbGClYa2BKFj9nzfp/rgzRXAAaVOvqA4MFC5fu2L++5v71tE/L1dEVEmrag==
X-Received: by 2002:ac2:58d7:: with SMTP id u23mr11345004lfo.119.1589808910779;
        Mon, 18 May 2020 06:35:10 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id w20sm1370439lfk.56.2020.05.18.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:35:09 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCH 2/2] tpm_ftpm_tee: register driver on tee bus
Date:   Mon, 18 May 2020 16:34:59 +0300
Message-Id: <20200518133459.28019-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133459.28019-1-maxim.uvarov@linaro.org>
References: <20200518133459.28019-1-maxim.uvarov@linaro.org>
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

