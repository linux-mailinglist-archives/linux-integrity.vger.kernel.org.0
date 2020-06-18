Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA01FF3EF
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgFRNxG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbgFRNxA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 09:53:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E328C0613EE
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 06:52:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d7so3498870lfi.12
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jun 2020 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCKO4KAmC6t1/xjLg97oW5MQyzYYn4C2HI5vulCaWjo=;
        b=LIKoIHVL7/dtxgL0YTVqziTRKr2IXVBLtuDnmJaaBuLg2qWuVZF81JrDdMjTOZsWe8
         R/g7Hobi0QVRaqpcrmwA3ipwTTw9pZT/E5DFI0/WNEvcnATbo+/ZrlQc9b4qyu1kvLgo
         Jw85cH2uo36G9mls7riTrpDIcYeCViKhbtp3faiIprtev1+J+ABv2ADt+mttZLytEMiL
         Ox8QZL6wOuEAVsQErLV9pz1oDZpNzALTFPf5UO80LUBu+/ofr+q9jh/91MsUQBq8Iqji
         MLpo7cOYWHy27B8fBxT4u3+WlpDx7a+PAB0vCmZYTDxqGPObz5F3/7FE7BjHcFU9gm2x
         eDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCKO4KAmC6t1/xjLg97oW5MQyzYYn4C2HI5vulCaWjo=;
        b=iOwT8HygrNiDo5vOe38d/LyqGh5y8gl4Vjfv3QZKcjaelmNM7mkV6FwCEayVUDAcg2
         wehMAKBrTRE+iF6Dd2SdAx5LHuvuTSUVg7yc+9ItJMcmU1yAEqN4ZRsrqR+H+yvYvD3h
         hFk81eLkvxTTtYOd8VCBHG3CVJml9F68RUAVvN53+lXeCICks+ymHh8WuXh2gg2Pu4Hx
         87LFsZ26jCsCNmJtdtPLkiEOnqhj9CRk1IvoIWMG2iiEBYkqEKuHbg80/QRhIs3m4zwE
         aIMENPgnrvXzYQJI2h7pQalhC6JmEOWKNkd3VH5HCVuhqUOyfv+UufO6opLx0rOEuobb
         ntqA==
X-Gm-Message-State: AOAM530j+ty7oDLf87ugyFmF0L3ReE21cnTxjUgsckkR4OSIuqTzFcKT
        kn2VYjQC8aJIJcaZ/mtdM6CxMw==
X-Google-Smtp-Source: ABdhPJyRe9YpUDbeCkQv53AEEx+b/DzoZviTu3xdCnINh3Ga4OlAzUDrYDSg8hO9aQ1Us/9bWPoAkg==
X-Received: by 2002:ac2:4886:: with SMTP id x6mr2512328lfc.198.1592488377963;
        Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
Received: from maximlap.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id f2sm768324lfc.11.2020.06.18.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 3/3] tpm_ftpm_tee: register driver on TEE bus
Date:   Thu, 18 Jun 2020 16:52:51 +0300
Message-Id: <20200618135251.5761-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618135251.5761-1-maxim.uvarov@linaro.org>
References: <20200618135251.5761-1-maxim.uvarov@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

OP-TEE based fTPM Trusted Application depends on tee-supplicant to
provide NV RAM implementation based on RPMB secure storage. So this
dependency can be resolved via TEE bus where we only invoke fTPM
driver probe once fTPM device is registered on the bus which is only
true after the tee-supplicant is up and running. Additionally, TEE bus
provides auto device enumeration.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Arnd Bergmann <arnd@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 70 ++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2491a2cb54a2..2ccdf8ac6994 100644
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

