Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985502D12B5
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 14:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgLGN6T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Dec 2020 08:58:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgLGN6T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Dec 2020 08:58:19 -0500
Received: from guri.fritz.box (p200300c7cf349800c84e93961ddb4a49.dip0.t-ipconnect.de [IPv6:2003:c7:cf34:9800:c84e:9396:1ddb:4a49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D35191F45014;
        Mon,  7 Dec 2020 13:57:37 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        enric.balletbo@collabora.com, dafna.hirschfeld@collabora.com,
        kernel@collabora.com, dafna3@gmail.com,
        Andrey Pronin <apronin@chromium.org>
Subject: [PATCH v2] tpm: ignore failed selftest in probe
Date:   Mon,  7 Dec 2020 14:57:10 +0100
Message-Id: <20201207135710.17321-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

If a TPM firmware update is interrupted, e.g due to loss of power or a
reset while installing the update, you end with the TPM chip in failure
mode. TPM_ContinueSelfTest command is called when the device is probed.
It results in TPM_FAILEDSELFTEST error, and probe fails. The TPM device
is not created, and that prevents the OS from attempting any further
recover operations with the TPM. Instead, ignore the error code of the
TPM_ContinueSelfTest command, and create the device - the chip is out
there, it's just in failure mode.

Testing:
Tested with the swtpm as TPM simulator and a patch in 'libtpms'
to enter failure mode

With this settings, the '/dev/tpm0' is created but the tcsd daemon fails
to run.  In addition, the commands TPM_GetTestResult, TPM_GetCapability
and TPM_GetRandom were tested.

A normal operation was tested with an Acer Chromebook R13 device
(also called Elm) running Debian.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
[change the code to still fail in case of fatal error]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

---
changes since v1:
- rewriting the commit message

This commit comes from chromeos:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/1065c2fe54d6%5E%21/

In Chromeos, the selftest fails if the TPM firmware is updated during EC
reset. In that case the userspace wants to access the TPM for recovery.

This patch is for TPM 1.2 only, I can also send a patch for TPM 2 if it
is required that the behaviour stays consistent among the versions.

libtpms patch:
https://gitlab.collabora.com/dafna/libtpms/-/commit/42848f4a838636d01ddb5ed353b3990dad3f601d

TPM tests:
https://gitlab.collabora.com/dafna/test-tpm1.git

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

