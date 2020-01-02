Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52EE12EB8D
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 22:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgABVzX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 16:55:23 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50293 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABVzX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 16:55:23 -0500
Received: by mail-pf1-f202.google.com with SMTP id g69so30197665pfb.17
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 13:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5A2TnHWXdX+GMrk2nIFy/Of+t+wuSkOKHJdM2Pieu+Y=;
        b=XNRPCvQaJciACBj9ko97H/R2oOfk+/OrjwGMYY6F6SqTMap7SPUZeD4EsCaOkH/zUY
         p0K6GDDXeeDxLo+025Y8EKItiAbLFkwyfBFFgAz5MqiWuSAkaq0WkMuUFQq9Y0Pt8uMJ
         aRjhZ3ZGKbylD/51Q93redxOmkuMgvf+rWckvY6LwaYKOI73/NuxwAHz6ezUpc1SSITU
         4ShQajjXebecQIv+dYyaQjCzWQUf8S7E+vXeBgFqjnakpKmF2PBH+frDA5HOVkSBISVv
         DT1vC/TKURzR9GLsCzZ9zeIhadYbk1MtiBm/qndqP94+3eiJeKY4WLYX8kiVU3nzkECD
         Winw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5A2TnHWXdX+GMrk2nIFy/Of+t+wuSkOKHJdM2Pieu+Y=;
        b=DzTFxd9CcmlULCSnTIgBR2eSMG06r1m9Hq0MdvtLb85aplbxGMW7eJo2Y24uAHad0T
         CdZIE8Pbi/ZXqginq025vY3TS9wOuzLa9SVfB1p5MuDpEwxugYyhK7JVJwk7n+9zq8wV
         ykUu803RW/StJSk6VKgzeGNUAj44jYiuDY38uYNQABUmvmz/kiipP5/3OlhZP2Tf4Fo5
         KqrtgExEReJo5t+Heg2RxWsUDrfuFzTu3sJMmXD4osSOGpNFXt0k115LvEWBZ0AL5R2i
         loPJaClM46+F22S0wL2xFpHWjxdkaEH02abRD+QAdySd0a4G2eJAm73/TasNhHwnYrB8
         2nxw==
X-Gm-Message-State: APjAAAUgwnyk55o+sk4Y1gLvac8zvIy9XVgSCzk78ZkoXaPJGjfynp8N
        ykYpRQKytQD7N8cWtNNqEs6LadAhIYDnJ3OTrMfUI/YNYPEMk31O1HdK4kzsyuKtPUIRUxyaaqR
        8MYd3VYLBWRdj9BPmb6gNs0odn0a4pC0DYpcfHnQw9KGqC9X+j+pit2E0QV29nR+f9rqKK7P6Fi
        +Rlw4ROzEx8XJWDEypRSk=
X-Google-Smtp-Source: APXvYqzyxENAuCYJ9Qr0+Mi6C2N4HQ5Ypf46YGLeFibCO8yb9Jkqs+c8+2uwIQU05vbPaXil1pGBLWB7B72LaGQ5Jgt3Dw==
X-Received: by 2002:a63:d358:: with SMTP id u24mr92354888pgi.218.1578002122409;
 Thu, 02 Jan 2020 13:55:22 -0800 (PST)
Date:   Thu,  2 Jan 2020 13:55:18 -0800
Message-Id: <20200102215518.148051-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH V2] tpm: Don't make log failures fatal
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If a TPM is in disabled state, it's reasonable for it to have an empty
log. Bailing out of probe in this case means that the PPI interface
isn't available, so there's no way to then enable the TPM from the OS.
In general it seems reasonable to ignore log errors - they shouldn't
interfere with any other TPM functionality.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: stable@vger.kernel.org
---

V2: make tpm_bios_log_setup() void, since we're not using the return
code now. Fix typo in patch description.

 drivers/char/tpm/eventlog/common.c | 12 ++++--------
 drivers/char/tpm/tpm-chip.c        |  4 +---
 drivers/char/tpm/tpm.h             |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 7a0fca659b6a6..7460f230bae4c 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -99,11 +99,8 @@ static int tpm_read_log(struct tpm_chip *chip)
  *
  * If an event log is found then the securityfs files are setup to
  * export it to userspace, otherwise nothing is done.
- *
- * Returns -ENODEV if the firmware has no event log or securityfs is not
- * supported.
  */
-int tpm_bios_log_setup(struct tpm_chip *chip)
+void tpm_bios_log_setup(struct tpm_chip *chip)
 {
 	const char *name = dev_name(&chip->dev);
 	unsigned int cnt;
@@ -112,7 +109,7 @@ int tpm_bios_log_setup(struct tpm_chip *chip)
 
 	rc = tpm_read_log(chip);
 	if (rc < 0)
-		return rc;
+		return;
 	log_version = rc;
 
 	cnt = 0;
@@ -158,13 +155,12 @@ int tpm_bios_log_setup(struct tpm_chip *chip)
 		cnt++;
 	}
 
-	return 0;
+	return;
 
 err:
-	rc = PTR_ERR(chip->bios_dir[cnt]);
 	chip->bios_dir[cnt] = NULL;
 	tpm_bios_log_teardown(chip);
-	return rc;
+	return;
 }
 
 void tpm_bios_log_teardown(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 3d6d394a86618..58073836b5555 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -596,9 +596,7 @@ int tpm_chip_register(struct tpm_chip *chip)
 
 	tpm_sysfs_add_device(chip);
 
-	rc = tpm_bios_log_setup(chip);
-	if (rc != 0 && rc != -ENODEV)
-		return rc;
+	tpm_bios_log_setup(chip);
 
 	tpm_add_ppi(chip);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index b9e1547be6b51..1df2cf40ab794 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -236,7 +236,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
 		      size_t *bufsiz);
 
-int tpm_bios_log_setup(struct tpm_chip *chip);
+void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
 int tpm_dev_common_init(void);
 void tpm_dev_common_exit(void);
-- 
2.24.1.735.g03f4e72817-goog

