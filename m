Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ADF1E0DD6
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbgEYLw7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390365AbgEYLwr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 07:52:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD41C061A0E
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z13so10775966ljn.7
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8XJcyDics6QppGAwov3ce/mqEK9W5Tv5D45BwQleJ0=;
        b=uFkP7s0aVfiHwOUSOTG958fE3r4sUYDia2xIAZKxVV97pdFN/NhkC9s2DOEsMBcpBA
         2i+8rxjlSUOIbzToBI29IvJdHy4nAj6J0TBIn39IsEo+7oQu6PLs8R0hN580dMSsSaj1
         XArlSMJdVOxWh6J76GgNfbKYqmwdSCMUOVMXcSrtMIDbpnvkq87s2Ue23kkPsOPHQ5wK
         Bfpbqs75jLWOAaF94GOkG1PAKa4taM2u8UUf8rsQaTo3JjGfY/gr2z7Bs58GL9ehk/dS
         jm/BnnEglE12+NZ9aI159HB8x8F6iB84SyrKlVtqeKdY1m7nNV42yUVEkLNMEqBt2zNh
         gNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8XJcyDics6QppGAwov3ce/mqEK9W5Tv5D45BwQleJ0=;
        b=Nj++FzK6Cd7kJzWpYfPrrpv3OssHSw5y6v15hLNYoLMCHkQCSuI9ydM4oR9hniXHac
         o6DjFDajEZYz0lP5d/kO6US+z8uc9gaqP1eTRW/6VSMuD3UUPgU/KEXMGmMcuvAYvisT
         JjkH/Thnv2OuhP0AFuzyIwrrnhyjyTygmYG2BWrw4O/0qiNKVJ4Owjv7j74arHezrGNX
         1gzTgSJ61kGV2bdEDv2ri7whIlIhBBdWjlqMvQzaou36Qp5xwE2sLY6LHA08DzzskJwV
         JBFk8oXZXDoCX4tzbOJNK4/d/Svi/rIc+Wbw9TVlDEOF5P4aHG+IJlspPhSwNljY+6tn
         N6Lw==
X-Gm-Message-State: AOAM530j9yvfZfDJanElzOpYjcl82dPBX/U1LqIzjL+EYdDwwhLejDST
        iiAzdD2gstIvFwH56295S/4oOVcXlqM=
X-Google-Smtp-Source: ABdhPJzPlpLdeAuCQdLkckFQzUH5bSPNlAdrnEhWBcy8VHuoiY+5i2K5dsOzxw8c3RP5KrX2GYQDdw==
X-Received: by 2002:a2e:780c:: with SMTP id t12mr8667835ljc.240.1590407565554;
        Mon, 25 May 2020 04:52:45 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y130sm4847756lfc.22.2020.05.25.04.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:52:45 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv3 3/3] tpm_ftpm_tee: register driver on TEE bus
Date:   Mon, 25 May 2020 14:52:35 +0300
Message-Id: <20200525115235.5405-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525115235.5405-1-maxim.uvarov@linaro.org>
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Register driver on the TEE bus. The :module tee registers bus,
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
 drivers/char/tpm/tpm_ftpm_tee.c | 70 ++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 22bf553ccf9d..28da638360d8 100644
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
 
@@ -347,17 +360,54 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
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
+/* UUID of the fTPM TA */
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

