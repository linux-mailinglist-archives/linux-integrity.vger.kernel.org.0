Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD20C1EE740
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 17:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgFDPD7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgFDPD7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 11:03:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D1DC08C5C0
        for <linux-integrity@vger.kernel.org>; Thu,  4 Jun 2020 08:03:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id n24so7682886lji.10
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eox8fZ0WSYZz73QuDot1O+nsmoLfoZMQmPTJJxk9miI=;
        b=yNhaN4laZs4jtyGj4BW9C//sJC8xcVoulKoVv6nvBlGiN3o8JY2/zeSFTGoNV2OyP3
         D0oFrztPcNWS+Q0AjiYloLba+IEptMUFVldxGzJR0ovTKKlMUSvZoamJkpf8AEXSsL/A
         r+srMc0cCy0UHGqjVohpWGdhCJ06HG70MWUMcTIDX2MrSGNgUvg5KwkD0HZiLH2JxP0r
         G+AsEOpTJHQbdsdEiB6f0QA3vrtIX0qKUBir4sH/CdEo8zkmx7T5abSmMvM5kEtioWSQ
         beS4YfC2+GdiI4Ez2Olre5azc7wvRFpXUQkAamoKjXh0cgXdUQqVfSPgMlsFC8wB8m5+
         NCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eox8fZ0WSYZz73QuDot1O+nsmoLfoZMQmPTJJxk9miI=;
        b=QmxxfCi2iBzLp/1h6H1B3u9NmliluiTvx/75FNHaiEUsTemYwkjehdzEiPUoKKMsio
         g0Yjz52Jr4i0UNzhTIOWnVqg+9/co99rrUJGGuRNkFc8rD8Jw9kdb78B1VtP86ApU3qR
         FBVMn6nVmHLS8AgF/c0CtCkxn/2A1SkvPTElALufvOdc+SNmeve4xMa4UwCs5dOZJ0nJ
         GKF8rjpZXDD33W1Acn5xc/cbdkRlFzbFOctI9YrdWz21+F7Xl35HhPsTojLwovo/ttGd
         Gck7mqalwedMsDHngrSgaK0OZfAxBQzkNPKPC3ugCH9SfSm3AobjzAUt3o5LECD8jmfj
         /ZNw==
X-Gm-Message-State: AOAM533IZOEoaVYdiWjH8BytPvvpHm7oEgi1j9Dgv3VNdZ1P6wFysANR
        dvbD4/+ubuQopP754nVngYRbHQ==
X-Google-Smtp-Source: ABdhPJz/gNhccM/KtpOQ8iM8zka9VraLxZf6WyMDQrn15loVX1/O+KKQDbxDBGCTN34NC0de7NFT1w==
X-Received: by 2002:a2e:b529:: with SMTP id z9mr2467342ljm.390.1591283037440;
        Thu, 04 Jun 2020 08:03:57 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id m15sm1514619lfk.65.2020.06.04.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 08:03:56 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 3/3] tpm_ftpm_tee: register driver on TEE bus
Date:   Thu,  4 Jun 2020 18:03:48 +0300
Message-Id: <20200604150348.27996-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200604150348.27996-1-maxim.uvarov@linaro.org>
References: <20200604150348.27996-1-maxim.uvarov@linaro.org>
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

