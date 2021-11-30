Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C74643B6
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 01:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbhLAAEA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 19:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhLAAD7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 19:03:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D65C061574
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 16:00:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w2-20020a627b02000000b0049fa951281fso13807076pfc.9
        for <linux-integrity@vger.kernel.org>; Tue, 30 Nov 2021 16:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZefXwhcIHm0Ttnev84L5bE/n+qzlIl43bNci83zhxKI=;
        b=Qs+piKvudKug0xO6CcPwITHI0sffJOklWL2jLDd2B+zSmN0wLKXILudqb7kIo8JPEw
         SfJX2Breev4rocib99DDEb7I5wJ3DwpSUGKKVngaEzcrWMhp6JEy1wG6tCl6cYnKZLFC
         eMvzF0qsgvZYGitlo8/JBM6upgsZfz9hJohNEWP8t8dKF6n7GlcDDvNOWw1dwL27vbvP
         4a83jndUgSKpZLXAChafmp6l9BIg/7b3JWq5B2L1xSei76FoZZW5av3CgHYgKu3PJoiE
         Vv0YCD5m0QK1yMkIlkNuVG0CU2EoCGIIXs97t0sE3h3XEtU1LEHFPvPCJZT3w5Iu00jn
         0Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZefXwhcIHm0Ttnev84L5bE/n+qzlIl43bNci83zhxKI=;
        b=A1uRaXAj1bwZV/qBAwxpiHlZBcNDThJGnPLHHdMWqfJkKthzXV3zB8cESltsYRJuye
         i2gAMU3OA2224dNr9+LUr96QmsfLc9bpFK/vtqnhKivVeRXe3Hj5He5mq6z9yBIBLdNV
         yrLwFKx3z+nVpmLz/Z4owECTF73ALrRIoVx06kBooExjiK2r918AkrUHKcn3Z8HfE0Zx
         XBqhS+LL5Tlu0Nk5rNY2KxXaCuaDtNUexg0+M1bQO90b6z1gj9rbOQgvq1feAeasndT1
         T5QRMvylNGLvYICq5SIUwF37eyZb6CbbXpHJDyUExw0SNMhy+QOE1XaasCXO59tHAutA
         oDkg==
X-Gm-Message-State: AOAM531xeUw/c0ITx5MZ1iCX9idUOwTpDGDGFT6fRpVj+TLkUWA0oG5s
        2bXO/SxJy7o4I4S+fVPooCbYOdACq8dp168=
X-Google-Smtp-Source: ABdhPJyH73l75EnnFFjaSfPuqroVUJVphZ5/8Om3Ulzrxx83pBCTJn6/4UwQhQJiACL35u2kaXtognL5oz8LOkY=
X-Received: from robscloud.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:553e])
 (user=robbarnes job=sendgmr) by 2002:a17:902:ed89:b0:141:f601:d6a with SMTP
 id e9-20020a170902ed8900b00141f6010d6amr2907864plj.77.1638316838643; Tue, 30
 Nov 2021 16:00:38 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:59:17 +0000
Message-Id: <20211130235918.2216110-1-robbarnes@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED based on
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
index dae98dbeeeac..e01f7cc258ca 100644
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
+	if (tpm_cr50_spi_is_firmware_power_managed(dev))
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
 
 	return 0;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

