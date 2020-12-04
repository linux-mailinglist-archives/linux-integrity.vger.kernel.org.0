Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82002CEF1D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 15:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgLDN5k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 08:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgLDN5k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 08:57:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8CEC0613D1
        for <linux-integrity@vger.kernel.org>; Fri,  4 Dec 2020 05:57:00 -0800 (PST)
Received: from guri.fritz.box (p200300c7cf49f800d89bd04994991187.dip0.t-ipconnect.de [IPv6:2003:c7:cf49:f800:d89b:d049:9499:1187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 156E71F4608B;
        Fri,  4 Dec 2020 13:56:57 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        enric.balletbo@collabora.com, dafna.hirschfeld@collabora.com,
        kernel@collabora.com, dafna3@gmail.com,
        Andrey Pronin <apronin@chromium.org>
Subject: [PATCH] tpm: ignore failed selftest in probe
Date:   Fri,  4 Dec 2020 14:56:49 +0100
Message-Id: <20201204135649.19391-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

If a tpm firmware update is interrupted, e.g due
to loss of power or a reset while installing the
update, you end with the tpm chip in failure mode.
ConstinueSelfTest command results in TPM_FAILEDSELFTEST
error, and probe fails. The tpm device is not
created, and that prevents the OS from attempting
any further recover operations with the tpm. Instead,
ignore the error code of the self test, and create the
device - the chip is out there, it's just in the
failed state.

Testing:
Tested with swtpm as tpm simulator and a patch in libtpms
to enter failure mode

With this settings, the 'dev/tpm0' is created but
the tcsd daemon fails to run.
In addition, the commands
TPM_GetTestResult, TPM_GetCapability and TPM_GetRandom
were tested.

A normal operation was tested with
Chromeos Elm device.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
[change the code to still fail in case of fatal error]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

---
This commit comes from chromeos:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/1065c2fe54d6%5E%21/

In Chromeos, the selftest fails if the tpm firmware is updated
during EC reset. In that case the userspace wants to access
the tpm for recovery.

This patch is for tpm 1.2 only, I can also send a patch for tpm 2
if it is required that the behaviour stays consistent among the versions.

libtpms patch:
https://gitlab.collabora.com/dafna/libtpms/-/commit/42848f4a838636d01ddb5ed353b3990dad3f601d

tpm tests:
https://gitlab.collabora.com/dafna/test-tpm1.git
---
 drivers/char/tpm/tpm1-cmd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ca7158fa6e6c..8b7997ef8d1c 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -697,6 +697,8 @@ EXPORT_SYMBOL_GPL(tpm1_do_selftest);
 /**
  * tpm1_auto_startup - Perform the standard automatic TPM initialization
  *                     sequence
+ * NOTE: if tpm1_do_selftest returns with a TPM error code, we return 0 (success)
+ *	 to allow userspace interaction with the TPM when it is on failure mode.
  * @chip: TPM chip to use
  *
  * Returns 0 on success, < 0 in case of fatal error.
@@ -707,18 +709,15 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 
 	rc = tpm1_get_timeouts(chip);
 	if (rc)
-		goto out;
+		return rc < 0 ? rc : -ENODEV;
+
 	rc = tpm1_do_selftest(chip);
 	if (rc) {
-		dev_err(&chip->dev, "TPM self test failed\n");
-		goto out;
+		dev_err(&chip->dev, "TPM self test failed %d\n", rc);
+		if (rc < 0)
+			return rc;
 	}
-
-	return rc;
-out:
-	if (rc > 0)
-		rc = -ENODEV;
-	return rc;
+	return 0;
 }
 
 #define TPM_ORD_SAVESTATE 152
-- 
2.17.1

