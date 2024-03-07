Return-Path: <linux-integrity+bounces-1668-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE0875A75
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 23:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4126B213A0
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB71E86E;
	Thu,  7 Mar 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEZJYw1l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470B3C473
	for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2024 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851953; cv=none; b=mO5B99vlKFUMWyuqsbR9fPMNw7AB6XCalXz70QCpOx4BgsUjZoDBbCspAbBq4HDUfJA862ug6vligbQlgssW3ZyGVZ7V91ThKHBFFQEYYc8F8ZdcxtYgZrtPENZRH59fBlj5FzHcE/iRw8TTUHEzEl9dHbZfmcSBCYYcPO7ZDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851953; c=relaxed/simple;
	bh=osYdqzS3K3CjtVNMksITHmUdUVyVqNyYbt+C7RwHI9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikRFt3psiiEk+JbWeeoGoDgf8kAi+ihmPAm/Y+BjimFOcqaymjwreIFUbQR4Y9vi3spwDPRElY5BcsldrAn1hxyA4EtmoryFK4GOnSr2/KFWTn3LcMoq0hu6TCjp7albeBf+JRXPxnzVVsQS1iYSOrKUlrjmxBy8q+Xmb3bVEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEZJYw1l; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcad814986so11989715ad.0
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2024 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709851950; x=1710456750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fdA8qIvPbvTcdiZdxil+/8M1k3wps25sBwFaDrYxLw=;
        b=fEZJYw1lpk/01Ia8hPA7JgeDidvO4HJPwgMplg5mg0P001JcJGf0zZp3J3y9utLO9m
         4609DdYbSmV5hebNXgaZ/sC5lgT0n8N3HM0THcImpGtFx3YhVBlkXmYpqMCmftqg+CmL
         CxYY7RcR2VqPFt1MCReILYWBfvGNhlR5RZqSfsr7aH3gzNzMMgPKzhzEa3chnKZ5w73I
         bH2HeBXH9vaKHyF7ybUQeyEBROvoQj4Sg8syEa/m6rk65zqCVl9FeRoF4aruF8eg4nCA
         1zQ/CFuSDkbXk5xC8NyD53Op0Bb45nCgKgwPNnFlyNdjxHGDZ4G05wRIb9hOCLe14Zga
         wfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709851950; x=1710456750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fdA8qIvPbvTcdiZdxil+/8M1k3wps25sBwFaDrYxLw=;
        b=mkEAv+HF5eVlkGFIeh+lcAlgO9q5zeKg1ApgxwhKmkt3tIrwAKRyTy2j1tJ0BpE92v
         B/9RHe6D4NQe//GwSu71dCtizZDfRalMW6dwY9aMzFduDeTz6AcyGG3kBinerSKmA/v2
         8U2FNioL/Cnol0EoW+QRAciXr1XaGa1Dx776CE5bt5H0/mkPOTc48bahoffhHf+KrfgJ
         dmyVb/3JZGY78+otRnyvXSJywUVIp9A2LT76ov0lEPtk3TamxZHTxGt16fWXUPUW2wiG
         E7SxU02YC7keym5bUblTaPL3Ggz9DAGVpVGMz2dZISkM35MEYMUYa5oLscOPGlM71ScH
         GFrg==
X-Forwarded-Encrypted: i=1; AJvYcCXlgVvFM0j7+glBDBMTf+sMWuAHKaBlKun0leMd+aY5mS1feaKGGkymJmV9DdX0mBsWRuksi+Xl8fX9E4mhKoI35CnTnCowXU4KtHHNZnnM
X-Gm-Message-State: AOJu0YyXCysg7cU/zjJDBmcttfGoe/XVW9zfwOvGTAetP3coSe76AKxF
	/yzlY7AFplCt8fbackR+WGy+uIN16LmYXqc2dPRhiwCVeCXYRLWevXTunB3Ku/E=
X-Google-Smtp-Source: AGHT+IEKMzIY2PDvbowsF9ICn4Yc5QRaikTZVkGtdt1//EbULgH/LkfhuNU4CG2dnTwc8AGC4c691w==
X-Received: by 2002:a17:903:40cf:b0:1dd:67de:be5e with SMTP id t15-20020a17090340cf00b001dd67debe5emr300781pld.15.1709851949791;
        Thu, 07 Mar 2024 14:52:29 -0800 (PST)
Received: from adampc.internal.adamoa.com.br ([2804:431:c7c0:eeea:3e7c:3fff:fe3b:efe2])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001dd3ea391f4sm3797013plx.177.2024.03.07.14.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 14:52:29 -0800 (PST)
From: Adam Alves <adamoa@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: [PATCH v2] tpm: Fix suspend/shutdown on some boards by preserving chip Locality
Date: Thu,  7 Mar 2024 19:49:57 -0300
Message-ID: <20240307224957.29432-1-adamoa@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some buggy firmware might require the TPM device to be in default
locality (Locality 0) before suspend or shutdown. Failing to do so
would leave the system in a hanged state before sleep or power off
(after “reboot: Power down” message). Such is the case for the ASUSTeK
COMPUTER INC. TUF GAMING B460M-PLUS board, I believe this might be the
case for several other boards based on some bugs over the internet
while trying to find out how to fix my specific issue. Most forums
suggest the user to disable the TPM device on firmware BIOS in order to
work around this specific issue, which disables several security
features provided by TPM.

The root cause might be that after the ACPI command to put the device
to S3 or S5, some firmware application/driver will try to use the TPM
chip expecting it to be in Locality 0 as expected by TCG PC Client
Platform Firmware Profile Version 1.06 Revision 52 (3.1.1 – Pre-OS
Environment) and then when it fails to do so it simply halts the
whole system.

Enable a user to configure the kernel through
“tpm.locality_on_suspend=1” boot parameter so that the locality is set
before suspend/shutdown in order to diagnose whether or not the board is
one of the buggy ones that require this workaround. Since this bug is
related to the board/platform instead of the specific TPM chip, call
dmi_check_system on the tpm_init function so that this setting is
automatically enabled for boards specified in code (ASUS TUF GAMING
B460M-PLUS already included) – automatic configuration only works in
case CONFIG_DMI is set though, since dmi_check_system is a non-op when
CONFIG_DMI is not set.

In case “tpm.locality_on_suspend=0” (the default) don't change any
behavior thus preserving current functionality of any other board
except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
boards as we successfully diagnose other boards with the same issue
fixed by using “tpm.locality_on_suspend=1”.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217890
Signed-off-by: Adam Alves <adamoa@gmail.com>
---
v1->v2: fix formatting issues and simplified tpm_chip_stop code.

 drivers/char/tpm/tpm-chip.c      | 12 +++++++++++
 drivers/char/tpm/tpm-interface.c | 37 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 include/linux/tpm.h              |  1 +
 4 files changed, 51 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..a183e1355289 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -137,6 +137,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
  */
 void tpm_chip_stop(struct tpm_chip *chip)
 {
+	if (chip->flags & TPM_CHIP_FLAG_PRESERVE_LOCALITY) {
+		if (chip->locality != 0)
+			tpm_request_locality(chip);
+		return;
+	}
+
 	tpm_go_idle(chip);
 	tpm_relinquish_locality(chip);
 	tpm_clk_disable(chip);
@@ -291,6 +297,9 @@ int tpm_class_shutdown(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
+	if (tpm_locality_on_suspend)
+		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
+
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
@@ -668,6 +677,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+	if (tpm_locality_on_suspend)
+		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
+
 	tpm_del_legacy_sysfs(chip);
 	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..7f770ea98402 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/tpm_eventlog.h>
+#include <linux/dmi.h>
 
 #include "tpm.h"
 
@@ -382,6 +383,36 @@ int tpm_auto_startup(struct tpm_chip *chip)
 	return rc;
 }
 
+/*
+ * Bug workaround - some boards expect the TPM to be on Locality 0
+ * before suspend/shutdown, halting the system otherwise before
+ * suspend and shutdown. Change suspend behavior for these cases.
+ */
+bool tpm_locality_on_suspend;
+module_param_named(locality_on_suspend, tpm_locality_on_suspend, bool, 0644);
+MODULE_PARM_DESC(locality_on_suspend,
+		 "Put TPM at locality 0 before suspend/shutdown.");
+
+static int __init tpm_set_locality_on_suspend(const struct dmi_system_id *system_id)
+{
+	pr_info("Board %s: TPM locality preserved before suspend/shutdown.\n",
+		system_id->ident);
+	tpm_locality_on_suspend = true;
+
+	return 0;
+}
+
+static const struct dmi_system_id tpm_board_quirks[] __initconst = {
+	{
+		.ident = "TUF GAMING B460M-PLUS",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "TUF GAMING B460M-PLUS"),
+		},
+		.callback = tpm_set_locality_on_suspend,
+	},
+};
+
 /*
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
@@ -394,6 +425,9 @@ int tpm_pm_suspend(struct device *dev)
 	if (!chip)
 		return -ENODEV;
 
+	if (tpm_locality_on_suspend)
+		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
+
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		goto suspended;
 
@@ -431,6 +465,7 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	chip->flags &= ~TPM_CHIP_FLAG_PRESERVE_LOCALITY;
 	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
 
 	/*
@@ -476,6 +511,8 @@ static int __init tpm_init(void)
 {
 	int rc;
 
+	dmi_check_system(tpm_board_quirks);
+
 	rc = class_register(&tpm_class);
 	if (rc) {
 		pr_err("couldn't create tpm class\n");
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..f2657b611b81 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -236,6 +236,7 @@ extern dev_t tpm_devt;
 extern const struct file_operations tpm_fops;
 extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
+extern bool tpm_locality_on_suspend;
 
 ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
 int tpm_get_timeouts(struct tpm_chip *);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..1fbb33f386d1 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -284,6 +284,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
+	TPM_CHIP_FLAG_PRESERVE_LOCALITY		= BIT(10),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.44.0


