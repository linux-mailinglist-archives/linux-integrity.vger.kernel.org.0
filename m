Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5945627A477
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgI0XRm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 19:17:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50424 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgI0XRm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 19:17:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA1508EE17F;
        Sun, 27 Sep 2020 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601248661;
        bh=3+c0CPRM++6Djus/P02s4x9GdYlXB8QO4iG8pUNUIdo=;
        h=Subject:From:To:Cc:Date:From;
        b=jP7EZuIshTGzw1Y9zUkEOkphG1lGTRhID+WWS93lgPLYcyTinkHSD/EECkYZTn4TC
         XZ7IuyPH8MGauELxvAuZaaoLEHYkiY/fg3+c7JNdL0sTydvH73YEaM08xYns+5dX+F
         8cY6lw0VWtk4e+2Rm7SCPv2Ta+RFzv/EjBvrebWc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mxY1MjN6zQVo; Sun, 27 Sep 2020 16:17:41 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 632CA8EE012;
        Sun, 27 Sep 2020 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601248661;
        bh=3+c0CPRM++6Djus/P02s4x9GdYlXB8QO4iG8pUNUIdo=;
        h=Subject:From:To:Cc:Date:From;
        b=jP7EZuIshTGzw1Y9zUkEOkphG1lGTRhID+WWS93lgPLYcyTinkHSD/EECkYZTn4TC
         XZ7IuyPH8MGauELxvAuZaaoLEHYkiY/fg3+c7JNdL0sTydvH73YEaM08xYns+5dX+F
         8cY6lw0VWtk4e+2Rm7SCPv2Ta+RFzv/EjBvrebWc=
Message-ID: <e63012add04eee75d67d15f55fe4f6b68fb1d6ed.camel@HansenPartnership.com>
Subject: [PATCH] tpm: only export stand alone version of flush context
 command
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sun, 27 Sep 2020 16:17:40 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove the currently exported version of flush context, which is
designed for tpm core internal use only and substitute a corrected
version that does the necessary tpm ops get/put.  This fixes a bug
with trusted keys in that some TIS TPMs are unable to flush the
loaded secret because the status register isn't reading correctly.

Fixes: 45477b3fe3d1 ("security: keys: trusted: fix lost handle flush")
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm.h                    |  1 +
 drivers/char/tpm/tpm2-cmd.c               | 23 ++++++++++++++++++++++-
 include/linux/tpm.h                       |  2 +-
 security/keys/trusted-keys/trusted_tpm2.c |  2 +-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 21ac88d4076c..cba09be7ce23 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -240,6 +240,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
 		       size_t cmdsiz);
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
 		      size_t *bufsiz);
+void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 
 void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 9b84158c5a9e..d5aaea72d578 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -362,7 +362,28 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
 	tpm_buf_destroy(&buf);
 }
-EXPORT_SYMBOL_GPL(tpm2_flush_context);
+
+/**
+ * tpm2_flush_context_cmd() - execute a TPM2_FlushContext command
+ * @chip:	TPM chip to use
+ * @handle:	context handle
+ *
+ * This version of the command is designed to be used outside the
+ * TPM core so acquires and releases the tpm ops.
+ */
+void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle)
+{
+	int rc;
+
+	rc = tpm_try_get_ops(chip);
+	if (rc) {
+		dev_err(&chip->dev, "Failed to acquire tpm ops for flush\n");
+		return;
+	}
+	tpm2_flush_context(chip, handle);
+	tpm_put_ops(chip);
+}
+EXPORT_SYMBOL_GPL(tpm2_flush_context_cmd);
 
 struct tpm2_get_cap_out {
 	u8 more_data;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index ae2482510f8c..c4ca52138e8b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -411,7 +411,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
-void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
+void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 08ec7f48f01d..38bb33333cdf 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -309,7 +309,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 		return rc;
 
 	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
-	tpm2_flush_context(chip, blob_handle);
+	tpm2_flush_context_cmd(chip, blob_handle);
 
 	return rc;
 }
-- 
2.26.2


