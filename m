Return-Path: <linux-integrity+bounces-1623-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD88744F7
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 01:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F361F25AC6
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 00:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124F7FF;
	Thu,  7 Mar 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFvJEPM8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3929CA
	for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769873; cv=none; b=p2UnG0pJ8kJyAZg9qSZNNKuGxZ4LYw43zZTFYy/JnrYQPkxR529EX6qy3x5KSRbIbFoXJGGH7XiZvyodwE2t2xcaeaRtcW0haHNffBNfyz6yg24cbXEDW8Yc7Ahl8H3//ijbQ4K1+hjbDetlV0avVCUnVlg4o0JXBgfphKsajsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769873; c=relaxed/simple;
	bh=PtkNAHA2Oai91h9dj0HfJHNY60MfkqFSs+cdH3EWqcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDGLoAuk/ieJT1fjrxgcAgIS1VA22xxYOvvxuNW0lu1p3JatEt6mw5tiU1GLDdw9+ZVMcTo4EZ0yLPTFvzlt87ea1iLnY2rOA2GJiAzA2wiXqREZWtPY029dRvB70R3486d+hF+Ahaq1XcEounPMthYfocH/VFP8ItDBv18YpvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFvJEPM8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so287028b3a.0
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2024 16:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709769871; x=1710374671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPhEl0KtXSoCo+AToXeurBfoWEEZ+5Cj7Lt84G+L6Ks=;
        b=bFvJEPM8U7BD6xYZl3F/e/Toy/zzbegqEkT+eFYPLgcHunUeNb8PGbmkyX2Ck/odhk
         A7DEgiqeJWuUBse+zzLMvuyVzQToFrmlLOfGrV//2LrgcCheWbJUz6ftl2w6Q16RCitC
         2AcEMEaq5IZAVizM1Gvubge0wCEpsy5rHXXAwZ9ZKqboF4231ewThacm+vhNccyeK9Te
         amKjIyyPGWmdTIHHIlI5Axz7iiiLXU9xWWwYauWm/whsdO5dt0Pspc6zYf//7S6dSfT/
         tT6Y0e7Jw+ksW+J5+F5zLifQjaI9Qs51srSOANfhFujBFsCR64zuMXG6+ixq+e/wIXym
         gKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769871; x=1710374671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPhEl0KtXSoCo+AToXeurBfoWEEZ+5Cj7Lt84G+L6Ks=;
        b=Ce2PtmxB0jV0iiwKW7sU3hygAYEyqKIe2j1k7H4qvbZMpXNt/UbBYdwK5SUahnA+t1
         k8atOB62rzGvQiQBLkjqiwTEcVEA3onQJLoyDFp9YDnkOelG0GTt83D6Hw6djOlvB7ZT
         n7AqgG1eyGOp+Fz7Jy1LzaBjmyPspQyWl8+yIzHkV5Ybhk5HR7bM+uejVIKyquMyMdm/
         VjHtGVZSLU0+C+oZGIKE37TFGkhscBmVDcY9fIsRTcRS5WCPXAaghPlgeJ/qxMv/hmLZ
         Qxhs0qDIR+kh7Zewyh53sgohrLIw7hHZymAOFBg6uBKXYgZPQeKSRIR+RxgVXdVXpC1M
         dQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEC/JwscbJtUtlD3JIDNS+GZKivhuwVzvN8CLzi8hhjmsevMI27WJX3zxtcnTtSNDcOPKICT8aVMvZ4HZVKP9zw0G7N2EUyFek1Z0a+LSF
X-Gm-Message-State: AOJu0YxhqmGGy4wU4UTp948dfF1Bom3kQ7tFkiT4OtPKX1Y2urQOPd9Q
	0IvTX+IsDTOfXszv5wqGMWlbDUlGGtwR8UCvA/noQPYXZPoiqCUxmlpCUarB
X-Google-Smtp-Source: AGHT+IH/pi2SG6WsThJTDYsT/ts3LB9flhE8vJsIeZOFmt1n9WpAyVKOzbekyqndn9ftESEJDYe4XQ==
X-Received: by 2002:a05:6a00:8d6:b0:6e6:2dc9:dcbc with SMTP id s22-20020a056a0008d600b006e62dc9dcbcmr11281840pfu.10.1709769870521;
        Wed, 06 Mar 2024 16:04:30 -0800 (PST)
Received: from fedora.. (189-47-54-93.dsl.telesp.net.br. [189.47.54.93])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a000bd700b006e04553a4c5sm11387449pfu.52.2024.03.06.16.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:04:29 -0800 (PST)
From: Adam Alves <adamoa@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: [PATCH 1/1] Fix TPM chip hanging system before suspend/shutdown
Date: Wed,  6 Mar 2024 21:03:31 -0300
Message-ID: <20240307000331.14848-2-adamoa@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307000331.14848-1-adamoa@gmail.com>
References: <20240307000331.14848-1-adamoa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

My PC would hang on almost every shutdown/suspend until I started
testing this patch and so far in the past week I haven’t experienced
any problems anymore.

I suspect that the root cause on my specific board is that after the
ACPI command to put the device to S3 or S5, some firmware
application/driver will try to use the TPM chip expecting it to be in
Locality 0 as expected by TCG PC Client Platform Firmware Profile
Version 1.06 Revision 52 (3.1.1 – Pre-OS Environment) and then when it
fails to do so it simply halts the whole system.

This issue might be related to the following bug:
https://bugzilla.kernel.org/show_bug.cgi?id=217890

Enable a user to configure the kernel
through “tpm.locality_on_suspend=1” boot parameter so that the locality
is set before suspend/shutdown in order to diagnose whether or not the
board is one of the buggy ones that require this workaround. Since this
bug is related to the board/platform instead of the specific TPM chip,
call dmi_check_system on the tpm_init function so that this setting is
automatically enabled for boards specified in code (ASUS TUF GAMING
B460M-PLUS already included) – automatic configuration only works in
case CONFIG_DMI is set though, since dmi_check_system is a non-op when
CONFIG_DMI is not set.

In case “tpm.locality_on_suspend=0” (the default) don't change any
behavior thus preserving current functionality of any other board
except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
boards as we successfully diagnose other boards with the same issue
fixed by using “tpm.locality_on_suspend=1”.

Signed-off-by: Adam Alves <adamoa@gmail.com>
---
 drivers/char/tpm/tpm-chip.c      |  9 ++++++++
 drivers/char/tpm/tpm-interface.c | 36 +++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm.h           |  1 +
 include/linux/tpm.h              |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..8fdf7a137a94 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -139,6 +139,9 @@ void tpm_chip_stop(struct tpm_chip *chip)
 {
 	tpm_go_idle(chip);
 	tpm_relinquish_locality(chip);
+	// If locality is to be preserved, we need to make sure it is Locality 0.
+	if (chip->flags & TPM_CHIP_PRESERVE_LOCALITY)
+		tpm_request_locality(chip);
 	tpm_clk_disable(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_chip_stop);
@@ -291,6 +294,9 @@ int tpm_class_shutdown(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
+	if (tpm_locality_on_suspend)
+		chip->flags |= TPM_CHIP_PRESERVE_LOCALITY;
+
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
@@ -668,6 +674,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+	if (tpm_locality_on_suspend)
+		chip->flags |= TPM_CHIP_PRESERVE_LOCALITY;
+
 	tpm_del_legacy_sysfs(chip);
 	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..8aeea2dee0a8 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -26,6 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/tpm_eventlog.h>
+#include <linux/dmi.h>
 
 #include "tpm.h"
 
@@ -382,6 +383,34 @@ int tpm_auto_startup(struct tpm_chip *chip)
 	return rc;
 }
 
+/*
+ * Bug workaround - some boards expect the TPM to be on ready
+ * state before suspend/shutdown, otherwise suspend and shutdown might
+ * hang the system, so we need to adjust suspend code for handling this.
+ */
+bool tpm_locality_on_suspend;
+module_param_named(locality_on_suspend, tpm_locality_on_suspend, bool, 0644);
+MODULE_PARM_DESC(locality_on_suspend, "The firmware expects TPM to be at locality 0 before suspend/shutdown.");
+
+static int __init tpm_set_locality_on_suspend(const struct dmi_system_id *system_id)
+{
+	pr_info("Board %s: TPM locality preserved before suspend/shutdown.\n", system_id->ident);
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
@@ -394,6 +423,9 @@ int tpm_pm_suspend(struct device *dev)
 	if (!chip)
 		return -ENODEV;
 
+	if (tpm_locality_on_suspend)
+		chip->flags |= TPM_CHIP_PRESERVE_LOCALITY;
+
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		goto suspended;
 
@@ -431,7 +463,7 @@ int tpm_pm_resume(struct device *dev)
 	if (chip == NULL)
 		return -ENODEV;
 
-	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
+	chip->flags &= ~(TPM_CHIP_PRESERVE_LOCALITY | TPM_CHIP_FLAG_SUSPENDED);
 
 	/*
 	 * Guarantee that SUSPENDED is written last, so that hwrng does not
@@ -476,6 +508,8 @@ static int __init tpm_init(void)
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
index 4ee9d13749ad..7717f484ac25 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -284,6 +284,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
+	TPM_CHIP_PRESERVE_LOCALITY		= BIT(10),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
2.44.0


