Return-Path: <linux-integrity+bounces-1680-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3828766BC
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E831C208DA
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881831865;
	Fri,  8 Mar 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvgDmq2H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3A139B
	for <linux-integrity@vger.kernel.org>; Fri,  8 Mar 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909716; cv=none; b=dv7JJpxis1Bez6ENpThBaGrDGNV/K3nM4wd9fC5aGgstmN9iqC4Ooura10deOfi47tf3J2J+7UJyz3xdYsjgdJJbVy5fgNxz+xffuMdyoYwhYKboJbDJB+Gh2G75g8BiMlZqnJRTsXjidvZgNno54ftAOV3pe7gCRPu8T/Jky80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909716; c=relaxed/simple;
	bh=c2wqKooEQLw5hfDd+iMKvGlu60m4UtKwL+aizhOVu8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9wEb+E0b+XjUYBbOZ8oLhgAqzO4F3+C4jy8sOnUCCZIfjl2jj22Nv7RInqm5/aCDYcPbGyd3CLdr0V7XeNMzt90HrDol3TEQqQsNXTbDJb8XHwLLnQ7A4YUnMQuR5stLtyiIST2dKVRgg6XSqurPOPUFrtkcqiPhdiq1RxRvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvgDmq2H; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5eb3dd2f8so1692029b3a.2
        for <linux-integrity@vger.kernel.org>; Fri, 08 Mar 2024 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709909714; x=1710514514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEXQY7s0zyEUTZUF+wwQlc3FPrGL6qrKlWZkkcTlWoQ=;
        b=gvgDmq2HEG0dphYm7umlppUoVE9ilspToMkd88RBQDn1xdnbxK4kkMVZfvZDzpaV78
         HU9yinPtHjXuvWLivC4RX+WZzOifY2KmKLtyEI1I5rIclmk7usyH5RAW9ZsEmxHYDtcb
         +yra77T7I8YzEDzfMl3lR7W5eFUp/C4MPHHIv8jwVhwaL4pvBuOM7NYZkfwNxpYeCHoD
         4ZsIkqpepu3b2hKz2nSu1i4b3HxvIS0aHDBGzS5na8cibqVDdMdbpYmjNopejbpPsO0A
         63qByG0rlkWFL6ksU1jy84/2sf3W0aj3naDUkoVs+N2tm2SUWicDLSopE0TfZoKeR1Wm
         6GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909714; x=1710514514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEXQY7s0zyEUTZUF+wwQlc3FPrGL6qrKlWZkkcTlWoQ=;
        b=gDty5Yz17TyX1KeG0tLMQxsN+bgIGlK0pyhPLPR6zILYzg7mQ/LLgrk/Jw/IrdSE6G
         YnvUcPRdA/znJ54ZsixGWoNotbz3KRKoxtDoeG+b6eOsvXvvTL3iJzk5gUKkt74lDHwM
         u7oAxeGHGGkyZnpRvaGMRMRtkZOFbrugIGm1jat1IHCIjGwx2jetwhhuz0YKyuGZwZIN
         FDxFiQp86gvPYAp9xfhngtLNQo4U1gUGiliQJj4OE2HhmFyYuM8NB38UvjY8gwIdkmEn
         lzEyTNzWYEbNeLomqDEF15hl2aGxg98qvSh392a+FK6zWNQJyRxCFMeJGJNcdNc1IT84
         eCRw==
X-Forwarded-Encrypted: i=1; AJvYcCWCJ8w95ciw2Q7Cmaj/ngcvX5j6GK0irjSDi2jtXZe/07+NcMUOvtcGj/uSQPujxumrpwBp298zvZ+bumhzA/x6INFrIRzK6K4rN5PNGIuU
X-Gm-Message-State: AOJu0YwwpYLIIgT8+Mlm97bupz6YIB95goGDytuDhFA2VDUU0qaKXrAo
	Xu70HdfV5S/2XaB7SVc0Px86+usShyRqupY5Vp5DwN1aO3SorCP9
X-Google-Smtp-Source: AGHT+IHzdRZd4pa0NBARobB6Y8TiCPK3YGIj3jz2uATRqhwSKw+wKRciLlP+YEtlE4RruFIrdqsKIA==
X-Received: by 2002:a05:6a20:1456:b0:1a1:72ea:2da1 with SMTP id a22-20020a056a20145600b001a172ea2da1mr5440254pzi.2.1709909713796;
        Fri, 08 Mar 2024 06:55:13 -0800 (PST)
Received: from adampc.internal.adamoa.com.br ([2804:431:c7c0:eeea:3e7c:3fff:fe3b:efe2])
        by smtp.gmail.com with ESMTPSA id s5-20020a62e705000000b006e5619b2f83sm14083625pfh.7.2024.03.08.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:55:13 -0800 (PST)
From: Adam Alves <adamoa@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] tpm: Fix suspend/shutdown on some boards by preserving chip Locality
Date: Fri,  8 Mar 2024 11:53:12 -0300
Message-ID: <20240308145313.40932-1-adamoa@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <61067410-5cbe-4b28-a31c-f994933f310d@molgen.mpg.de>
References: <61067410-5cbe-4b28-a31c-f994933f310d@molgen.mpg.de>
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
COMPUTER INC. TUF GAMING B460M-PLUS board with a TPM 2.0 Intel chip
(rev. 500.16 - CRM start method), I believe this might be the case for
several other boards based on some bugs over the internet while trying
to find out how to fix my specific issue. Most forums suggest the user
to disable the TPM device on firmware BIOS in order to work around this
specific issue, which disables several security features provided by
TPM.

The root cause might be that after the ACPI command to put the device
to S3 or S5, some firmware application/driver will try to use the TPM
chip expecting it to be in Locality 0 as expected by TCG PC Client
Platform Firmware Profile Version 1.06 Revision 52 (3.1.1 – Pre-OS
Environment) and then when it fails to do so it simply halts the
whole system.

Enable a user to configure the kernel through
`tpm.sleep_locality_preserve=1` boot parameter so that the locality is
preserved before suspend/shutdown in order to diagnose whether or not
the board is one of the buggy ones that require this workaround. Since
this bug is related to the board/platform instead of the specific TPM
chip, call `dmi_check_system` on the `tpm_init` function so that this
setting is automatically enabled for boards specified in code (ASUS TUF
GAMING B460M-PLUS already included) – automatic configuration only
works in case `CONFIG_DMI` is set though, since `dmi_check_system` is a
non-op when `CONFIG_DMI` is not set.

In case `tpm.sleep_locality_preserve=0` force the workaround to be
disabled.

In case `tpm.sleep_locality_preserve=-1` (the default) automatically
enable the workaround for specific boards (currently only ASUSTeK
COMPUTER INC. TUF GAMING B460M-PLUS, others should be added when we
diagnose this specific issue), if a compatible board is detected an
info message will be logged with the following text: "Board XXX: TPM
locality preserved before suspend/shutdown.".

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217890
Signed-off-by: Adam Alves <adamoa@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2->v3:
  - Fixed quotes on commit text and included TPM chip used on test
    setup
  - Allow forcing pre-fix behavior even for buggy boards
  - Documented logged message for detected boards
  - Changed parameter name to tpm_sleep_locality_preserve, since
    shutdown is also a sleep state
  - Included kernel cmdline parameter documentation
  

 .../admin-guide/kernel-parameters.txt         |  8 ++++
 drivers/char/tpm/tpm-chip.c                   | 12 ++++++
 drivers/char/tpm/tpm-interface.c              | 41 +++++++++++++++++++
 drivers/char/tpm/tpm.h                        |  1 +
 include/linux/tpm.h                           |  1 +
 5 files changed, 63 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..dc2c229f57a6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6531,6 +6531,14 @@
 			This will guarantee that all the other pcrs
 			are saved.
 
+	tpm.sleep_locality_preserve= [HW,TPM]
+			Format: { -1 | 0 | 1 }
+			Defines the locality behavior of the TPM chip before suspend/shutdown.
+		 	 0 -- Force normal behavior (relinquish before sleep)
+		 	 1 -- Force locality to be preserved before sleep
+		 	-1 -- Automatically set based on known buggy boards
+		 	Default: -1
+
 	tpm_tis.interrupts= [HW,TPM]
 			Enable interrupts for the MMIO based physical layer
 			for the FIFO interface. By default it is set to false
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..beee18e0d60e 100644
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
 
+	if (tpm_sleep_locality_preserve)
+		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
+
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
@@ -668,6 +677,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+	if (tpm_sleep_locality_preserve)
+		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
+
 	tpm_del_legacy_sysfs(chip);
 	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..fcc4fe569da5 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/tpm_eventlog.h>
+#include <linux/dmi.h>
 
 #include "tpm.h"
 
@@ -382,6 +383,38 @@ int tpm_auto_startup(struct tpm_chip *chip)
 	return rc;
 }
 
+/*
+ * Bug workaround - some boards expect the TPM to be on Locality 0
+ * before suspend/shutdown, halting the system otherwise before
+ * suspend and shutdown. Change suspend behavior for these cases.
+ */
+int tpm_sleep_locality_preserve = -1;
+module_param_named(sleep_locality_preserve, tpm_sleep_locality_preserve, int, 0644);
+MODULE_PARM_DESC(sleep_locality_preserve,
+		 "Locality before sleep/shutdown (0: relinquish, 1: preserve, -1: auto)");
+
+static int __init tpm_set_sleep_locality_preserve(const struct dmi_system_id *system_id)
+{
+	if (tpm_sleep_locality_preserve < 0) {
+		pr_info("Board %s: TPM locality preserved before suspend/shutdown.\n",
+			system_id->ident);
+		tpm_sleep_locality_preserve = 1;
+	}
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
+		.callback = tpm_set_sleep_locality_preserve,
+	},
+};
+
 /*
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
@@ -394,6 +427,9 @@ int tpm_pm_suspend(struct device *dev)
 	if (!chip)
 		return -ENODEV;
 
+	if (tpm_sleep_locality_preserve)
+		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
+
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		goto suspended;
 
@@ -431,6 +467,7 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
+	chip->flags &= ~TPM_CHIP_FLAG_PRESERVE_LOCALITY;
 	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
 
 	/*
@@ -476,6 +513,10 @@ static int __init tpm_init(void)
 {
 	int rc;
 
+	dmi_check_system(tpm_board_quirks);
+	if (tpm_sleep_locality_preserve < 0)
+		tpm_sleep_locality_preserve = 0;
+
 	rc = class_register(&tpm_class);
 	if (rc) {
 		pr_err("couldn't create tpm class\n");
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..9ff1146c4259 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -236,6 +236,7 @@ extern dev_t tpm_devt;
 extern const struct file_operations tpm_fops;
 extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
+extern int tpm_sleep_locality_preserve;
 
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


