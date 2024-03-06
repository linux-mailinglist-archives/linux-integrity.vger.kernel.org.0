Return-Path: <linux-integrity+bounces-1599-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864B874393
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 00:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC05C1C2138A
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Mar 2024 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92301C6A0;
	Wed,  6 Mar 2024 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5TM8UuJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B7CA4E
	for <linux-integrity@vger.kernel.org>; Wed,  6 Mar 2024 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766742; cv=none; b=c5+fmKbuA1WyeCAZgu7Y9oGUDYqKJ4/PF0o2aPve3IJS7U/HWwfvjBiZ7TKRg6OlJcw0hZM3XsaTBRnhYF+2an+UXa6j/z3FzQDYvkkCnZ2395SrbYmlq4Wsn1cn1hHMq98h0MXD5MFGQK2GGVLwmhmp8uoy64mLRb4Ecq3sHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766742; c=relaxed/simple;
	bh=rH9Z/DtLyGYzmi1hIEaR2lVuyQZCZojIcMcWQIwvFGI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=B6oE1BGuoqpT13gUfVNdaseQw4z+CQel2CPGCo0Ng9xoOLj4VBbYXyuOp5s/3GjzNGnqBYF7XrktzdpCouzFxba7oQ1M4oR3U5LbhPkxVQtHDtspq7Y1T97MHw8bv18TAKmEKztIoibTam9FU4Wv7Gt31sflJ77fuUCmLk1immo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5TM8UuJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso274145276.1
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2024 15:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766740; x=1710371540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vRXAHyu+wIAaaDZN+VkwZ72bRDgl2trC3EHAkiNmP7M=;
        b=d5TM8UuJDZTu7rbcIudy7c/Iux3P3Jcnjh96ombFnJ6jsuMajn2C9N1RW6SEgwzCSi
         TiyceZDS5N/rwqNubCEBMXzHJCIzJ4FMgvWjKgaRnFPUQK2Gs0CYdf61+d66IryEsZcu
         1hX+7K9i2s7jaPbveLK53my61dcZ3s5OtBt1kbrEqdxEUgyDngpm4FV4zsLgh+SVAJav
         koWSvUnrladx+Gv1d7WXKj6HKuCLrJRAG0aaRwEBXSzMP2tuKfxkzE5OZKzsxwf4Vf9p
         TyAa4gAjBoEKGDiXxF6ahSV/A/pIpQBPFQOa+XcoXMm4Tr1pGJOb4APPkoYdEZzraagP
         8GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766740; x=1710371540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRXAHyu+wIAaaDZN+VkwZ72bRDgl2trC3EHAkiNmP7M=;
        b=i6PX65F6H9zLWMCLzyi9mNqS+pAR+bcC/T8jvKmXPRpp0tGAjwNRkIdXnTVOAXZWq4
         fxtBBgUUfWAW3VLM+CkJZRjH8SaD5c4j7aWosvz7sYpRV+RWYLINj7LUJMLgItTVrrgo
         V1yke3D7v4I2rkRnYPLi4JzlLYDvbCWzK2kgTnNlkLrUyLfE1sYqw/oBsgJ24LeaKeCD
         BmHDuDgMfw+Je3Tr5Bf9lokVE25E07fs/npfYClZwDnUS1YCQ1nGnfz0iJjBpnDe+0QN
         dMkjC/bWm749gLROuN5smpljqpHvHVF0/bMPYnYT4neLPKdWNONjSxfDlWpmkzCbDdlM
         LdQw==
X-Forwarded-Encrypted: i=1; AJvYcCVwH3IOI2V2dtl9ctDiw7wrxQMIMfj0d8c7T7XfSmOYUYXjAOL3pwq4qOkeBFXicd3jgfxUnD1LbRAK8esmDdiCztFhCeAECgMN9KBBXtCy
X-Gm-Message-State: AOJu0YxDFawjzQ/xEq6Oo5L0kOpkOko6b/b6gIBL6iwNKbqO7WfhhhVs
	meSARtVbTpJ7ZYqB34CghCqaOnmYOdM49uJmirZ1PZqeIfWI2Erxp/D9XRqV482ATE+morZUQZJ
	W8Rz0RdyBbwH8goFGRHrOmhgSotk=
X-Google-Smtp-Source: AGHT+IGHioYIY22PS1pivTB6KySOH/du1NBWgBffG03Tv1pWWvOgxJ79K2DZ0fuF8p2upg8QTHjsPBJjopl8t9581aU=
X-Received: by 2002:a25:bb0e:0:b0:dc6:54c5:285c with SMTP id
 z14-20020a25bb0e000000b00dc654c5285cmr14170082ybg.0.1709766739972; Wed, 06
 Mar 2024 15:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adam Alves <adamoa@gmail.com>
Date: Wed, 6 Mar 2024 20:12:08 -0300
Message-ID: <CAHwaaX_6OYVy8o8nUjYhNjAV+j28QGLSHxpWxoMDxiBzT2Z50Q@mail.gmail.com>
Subject: [PATCH] Fix TPM chip hanging system before suspend/shutdown
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some buggy firmwares might require the TPM device to be in default
locality (Locality 0) before suspend or shutdown. Failing to do so
would leave the system in a hanged state before sleep or power off
(after =E2=80=9Creboot: Power down=E2=80=9D message). Such is the case for =
the ASUSTeK
COMPUTER INC. TUF GAMING B460M-PLUS board, I believe this might be the
case for several other boards based on the bugs I have found on the
internet while trying to find out how to fix my specific issue. Most
forums suggest the user to disable the TPM device on firmware BIOS in
order to work around this specific issue, which disables several nice
security features provided by TPM, such as secure boot attestation,
automatic decryption and hardware random generator.

My PC would hang on almost every shutdown/suspend until I started
testing this patch and so far in the past week I haven=E2=80=99t experience=
d
any problems anymore.

I suspect that the root cause on my specific board is that after the
ACPI command to put the device to S3 or S5, some firmware
application/driver will try to use the TPM chip expecting it to be in
Locality 0 as expected by TCG PC Client Platform Firmware Profile
Version 1.06 Revision 52 (3.1.1 =E2=80=93 Pre-OS Environment) and then when=
 it
fails to do so it simply halts the whole system.

This issue might be related to the following bug:
https://bugzilla.kernel.org/show_bug.cgi?id=3D217890

Enable a user to configure the kernel
through =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D boot parameter so tha=
t the locality
is set before suspend/shutdown in order to diagnose whether or not the
board is one of the buggy ones that require this workaround. Since this
bug is related to the board/platform instead of the specific TPM chip,
call dmi_check_system on the tpm_init function so that this setting is
automatically enabled for boards specified in code (ASUS TUF GAMING
B460M-PLUS already included) =E2=80=93 automatic configuration only works i=
n
case CONFIG_DMI is set though, since dmi_check_system is a non-op when
CONFIG_DMI is not set.

In case =E2=80=9Ctpm.locality_on_suspend=3D0=E2=80=9D (the default) don't c=
hange any
behavior thus preserving current functionality of any other board
except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
boards as we successfully diagnose other boards with the same issue
fixed by using =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D.

Signed-off-by: Adam Alves <adamoa@gmail.com>

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..8fdf7a137a94 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -139,6 +139,9 @@ void tpm_chip_stop(struct tpm_chip *chip)
 {
  tpm_go_idle(chip);
  tpm_relinquish_locality(chip);
+ // If locality is to be preserved, we need to make sure it is Locality 0.
+ if (chip->flags & TPM_CHIP_PRESERVE_LOCALITY)
+ tpm_request_locality(chip);
  tpm_clk_disable(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_chip_stop);
@@ -291,6 +294,9 @@ int tpm_class_shutdown(struct device *dev)
 {
  struct tpm_chip *chip =3D container_of(dev, struct tpm_chip, dev);

+ if (tpm_locality_on_suspend)
+ chip->flags |=3D TPM_CHIP_PRESERVE_LOCALITY;
+
  down_write(&chip->ops_sem);
  if (chip->flags & TPM_CHIP_FLAG_TPM2) {
  if (!tpm_chip_start(chip)) {
@@ -668,6 +674,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+ if (tpm_locality_on_suspend)
+ chip->flags |=3D TPM_CHIP_PRESERVE_LOCALITY;
+
  tpm_del_legacy_sysfs(chip);
  if (tpm_is_hwrng_enabled(chip))
  hwrng_unregister(&chip->hwrng);
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interf=
ace.c
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
+module_param_named(locality_on_suspend, tpm_locality_on_suspend, bool, 064=
4);
+MODULE_PARM_DESC(locality_on_suspend, "The firmware expects TPM to be
at locality 0 before suspend/shutdown.");
+
+static int __init tpm_set_locality_on_suspend(const struct
dmi_system_id *system_id)
+{
+ pr_info("Board %s: TPM locality preserved before
suspend/shutdown.\n", system_id->ident);
+ tpm_locality_on_suspend =3D true;
+
+ return 0;
+}
+
+static const struct dmi_system_id tpm_board_quirks[] __initconst =3D {
+ {
+ .ident =3D "TUF GAMING B460M-PLUS",
+ .matches =3D {
+ DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+ DMI_MATCH(DMI_BOARD_NAME, "TUF GAMING B460M-PLUS"),
+ },
+ .callback =3D tpm_set_locality_on_suspend,
+ },
+};
+
 /*
  * We are about to suspend. Save the TPM state
  * so that it can be restored.
@@ -394,6 +423,9 @@ int tpm_pm_suspend(struct device *dev)
  if (!chip)
  return -ENODEV;

+ if (tpm_locality_on_suspend)
+ chip->flags |=3D TPM_CHIP_PRESERVE_LOCALITY;
+
  if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
  goto suspended;

@@ -431,7 +463,7 @@ int tpm_pm_resume(struct device *dev)
  if (chip =3D=3D NULL)
  return -ENODEV;

- chip->flags &=3D ~TPM_CHIP_FLAG_SUSPENDED;
+ chip->flags &=3D ~(TPM_CHIP_PRESERVE_LOCALITY | TPM_CHIP_FLAG_SUSPENDED);

  /*
  * Guarantee that SUSPENDED is written last, so that hwrng does not
@@ -476,6 +508,8 @@ static int __init tpm_init(void)
 {
  int rc;

+ dmi_check_system(tpm_board_quirks);
+
  rc =3D class_register(&tpm_class);
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
  TPM_CHIP_FLAG_FIRMWARE_UPGRADE =3D BIT(7),
  TPM_CHIP_FLAG_SUSPENDED =3D BIT(8),
  TPM_CHIP_FLAG_HWRNG_DISABLED =3D BIT(9),
+ TPM_CHIP_PRESERVE_LOCALITY =3D BIT(10),
 };

 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)

