Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1045D466ABD
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 21:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344876AbhLBUKU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 15:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344983AbhLBUJk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 15:09:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D80C06175E
        for <linux-integrity@vger.kernel.org>; Thu,  2 Dec 2021 12:05:48 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b26-20020aa7951a000000b004a815eb3a3aso362342pfp.16
        for <linux-integrity@vger.kernel.org>; Thu, 02 Dec 2021 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q7dcspo1yxZdIpTVvB7xq0jwV29ozWKIKptmzdGoFi8=;
        b=pRtiIFuWPD9tgarwR95185Mti/r0psZB9R+EUm436CXn7ny6uuCQVl/I4yPXu3cD+O
         1fvHmfUH2TlT614xVyz6CNZWIqWqGsfwLSuqzogK8e7PhlcG0zqnu8wahkIVjiGWUqOs
         ujZceN1gBWHiJ0muQbP6teJsdz8oF8bw77HI3Ijrg10oVMzigBWJKXmJR2AAmKvx6Tl1
         JExbE5slri1Hd+NoHSvDeqeItJXF67pDAxwO/HxBToOlsIvuRgPH+v4+FYkzc0T1ARh9
         XOmOqLNbIQURjU5U55pnAt4x8dQYdGgTz++Qmr1HRHudqmTjwzRAxjEyy+axs0F55zdQ
         fhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q7dcspo1yxZdIpTVvB7xq0jwV29ozWKIKptmzdGoFi8=;
        b=kxJY5sLHGd/+CSXCPiQRQYKP8f/K6muhEjiCwJUUjiJhDDQIkGDyY1PwBLZrLJ2k4I
         LXSht+gVVM6QoAmdTZmjOnq8D/Ph9rGVUz3AGpv0AZU5Y1OpLauJyEshqhi9z5P3Isv3
         N/ko7NGksVaoFtT8XTpg7YISiUzz+GPohCjAG6O7KUCEB50S7sPs1D+vN3ovLCrWPXuv
         0tjFU2pTdh83voVfchzWL+qWWZiu/NGYtx4NWYr17/cxSwHyGHfnR/hRQzJB9rs7kUEp
         +q477qZXmeIWiLOA3bJOL4r/88WTxntTpcwoCK8XKwIwgFaGKYWNOwIC7Xj1supujlza
         VmlQ==
X-Gm-Message-State: AOAM531L7zT3mE95fAc/fKO6m0DTGh4za3yWe8hdAc1mJWiOZTO4wREr
        hPsByFc0KGbmmznQMAE/mWYTqN7oSe4jaLM=
X-Google-Smtp-Source: ABdhPJxRzLigLbVcNn28qh4EgCSCeEih5LspCPYEyRBeE0p7mykjLIvRRjwyiSnl6rgxnOp7YYzzKtMyoj41o/8=
X-Received: from robscloud.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:553e])
 (user=robbarnes job=sendgmr) by 2002:a63:920b:: with SMTP id
 o11mr1111269pgd.314.1638475547585; Thu, 02 Dec 2021 12:05:47 -0800 (PST)
Date:   Thu,  2 Dec 2021 20:03:40 +0000
In-Reply-To: <202112011433.QeYkYJE1-lkp@intel.com>
Message-Id: <20211202200342.2430249-1-robbarnes@google.com>
Mime-Version: 1.0
References: <202112011433.QeYkYJE1-lkp@intel.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH v2] char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED based on
 device property
From:   Rob Barnes <robbarnes@google.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Rob Barnes <robbarnes@google.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Set TPM_FIRMWARE_POWER_MANAGED flag based on 'firmware-power-managed'
ACPI DSD property. For the CR50 TPM, this flag defaults to true when
the property is unset.

When this flag is set to false, the CR50 TPM driver will always send
a shutdown command whenever the system suspends.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 14 +++++++++++++-
 drivers/char/tpm/tpm_tis_spi_cr50.c | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index c89278103703..70143cc4f4e8 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -628,6 +628,17 @@ static bool tpm_cr50_i2c_req_canceled(struct tpm_chip *chip, u8 status)
 	return status == TPM_STS_COMMAND_READY;
 }
 
+static bool tpm_cr50_i2c_is_firmware_power_managed(struct device *dev)
+{
+	u8 val;
+	int ret;
+	/* This flag should default true when the device property is not present */
+	ret = device_property_read_u8(dev, "firmware-power-managed", &val);
+	if (ret)
+		return 1;
+	return val;
+}
+
 static const struct tpm_class_ops cr50_i2c = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = &tpm_cr50_i2c_tis_status,
@@ -686,7 +697,8 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 
 	/* cr50 is a TPM 2.0 chip */
 	chip->flags |= TPM_CHIP_FLAG_TPM2;
-	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
+	if (tpm_cr50_i2c_is_firmware_power_managed(dev))
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
 
 	/* Default timeouts */
 	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index dae98dbeeeac..6c40ff99d3ea 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -185,6 +185,17 @@ static int cr50_spi_flow_control(struct tpm_tis_spi_phy *phy,
 	return 0;
 }
 
+static bool tpm_cr50_spi_is_firmware_power_managed(struct device *dev)
+{
+	u8 val;
+	int ret;
+	/* This flag should default true when the device property is not present */
+	ret = device_property_read_u8(dev, "firmware-power-managed", &val);
+	if (ret)
+		return 1;
+	return val;
+}
+
 static int tpm_tis_spi_cr50_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				     u8 *in, const u8 *out)
 {
@@ -309,7 +320,8 @@ int cr50_spi_probe(struct spi_device *spi)
 	cr50_print_fw_version(&phy->priv);
 
 	chip = dev_get_drvdata(&spi->dev);
-	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
+	if (tpm_cr50_spi_is_firmware_power_managed(&spi->dev))
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
 
 	return 0;
 }
-- 
2.34.0.384.gca35af8252-goog

