Return-Path: <linux-integrity+bounces-7210-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D4B8D36D
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 04:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFAE18A09F3
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Sep 2025 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4C1B4F0A;
	Sun, 21 Sep 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTHEtPwf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC019CC02;
	Sun, 21 Sep 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758420506; cv=none; b=p8FuSUaWbWJfOrlVJC0CDSqgq4SFtRNOlzqBPfFNo8/EFjE2n4OjpnfXRsnfv8xvNOgTHF7MSApi/I3CskggEofmSp8y/IMpXfaE3qh1KYNvY61S9nd0OpRPHMxwEaKodTSGeZfGCYQ93QyjExXAKxgJe+n+U39lT1vQobIemN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758420506; c=relaxed/simple;
	bh=X/bOsUEmbxefF48diYUiSoDG9kbS4cdIv6S/u6MFIew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8uUjN7ORj2Kk7hJGtUD8s/1X8P52WfhkvjlE/13XuRISvzugaKBO4ZeD/XBhozHJliSQCEIfBQskSPS/bgzTu+WK+XiR/j1k0EeFdUB0asLXeBLM1g1UNK3Nme7X+u5ERHZH4dUCZw6tmCPI84Po5MHtJ+kO3pKtYnyOruCutA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTHEtPwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E34C4CEEB;
	Sun, 21 Sep 2025 02:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758420505;
	bh=X/bOsUEmbxefF48diYUiSoDG9kbS4cdIv6S/u6MFIew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTHEtPwf4nLG14DV2pZltZuoSXs2CGNH4Iu7UAeYViYOsPdvgxJZ+Fyozd3oj6zED
	 X5LJlGtEYUlCZdNDErVj0WoB5bfuWeIDH51e7eP9SEYDa/BpaUMriULtS4ySToEGr/
	 NaIe31aUi1evNK4EMmPKJqFLkAgnccXbFXQsgsMCmKPWNTxeqPvWHmDxWXbncXk1mT
	 pLmUtxcu5mAgQjSjtbrg40Js32cZwEdDXChwOFKyR6RaTGfGWeRDLZJs/kURhePtPm
	 LVpzWDFtd8Gye8adj5nJrXJZCSI7mDmp7KYFRf/fBQrP5M4l3C4WPp+h1kiKIKidkv
	 /zq5WvLVEKXcw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v10 3/4] tpm, tpm2-cmd: Use stack for trivial cases
Date: Sun, 21 Sep 2025 05:08:03 +0300
Message-Id: <20250921020804.1088824-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250921020804.1088824-1-jarkko@kernel.org>
References: <20250921020804.1088824-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Use stack allocation for trivial "low-hanging fruit" sites, which are often
also critical code paths associated with probing and power management.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm2-cmd.c | 57 ++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 245c7c952e82..3c55f60ae4c2 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -382,14 +382,13 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
  */
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 {
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return;
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
 	tpm_buf_append_u16(buf, shutdown_type);
-	tpm_transmit_cmd(chip, buf, 0, "stopping the TPM");
+	tpm_transmit_cmd(chip, buf, 0, "TPM2_Shutdown");
 }
 
 /**
@@ -407,58 +406,49 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	int full;
 	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
-	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	for (full = 0; full < 2; full++) {
 		tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
 		tpm_buf_append_u8(buf, full);
-		rc = tpm_transmit_cmd(chip, buf, 0,
-				      "attempting the self test");
-
+		rc = tpm_transmit_cmd(chip, buf, 0, "TPM2_SelfTest");
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
 		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
 			return rc;
 	}
-
 	return rc;
 }
 
 /**
- * tpm2_probe() - probe for the TPM 2.0 protocol
+ * tpm2_probe() - Probe for the TPM 2.0 protocol
  * @chip:	a &tpm_chip instance
  *
- * Send an idempotent TPM 2.0 command and see whether there is TPM2 chip in the
- * other end based on the response tag. The flag TPM_CHIP_FLAG_TPM2 is set by
- * this function if this is the case.
+ * Sends an idempotent TPM 2.0 command, and based on the response tag deduces
+ * whether a functional TPM2 chip is on the other side. When the result is
+ * positive, TPM_CHIP_FLAG_TPM2 is append to the chip's flags.
  *
  * Return:
- *   0 on success,
- *   -errno otherwise
+ * * 0 on success,
+ * * -errno otherwise
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	struct tpm_header *out;
 	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	tpm_buf_append_u32(buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(buf, TPM_PT_TOTAL_COMMANDS);
 	tpm_buf_append_u32(buf, 1);
 	rc = tpm_transmit_cmd(chip, buf, 0, NULL);
-	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
 		out = (struct tpm_header *)buf->data;
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
@@ -651,17 +641,14 @@ EXPORT_SYMBOL_GPL(tpm2_get_cc_attrs_tbl);
 
 static int tpm2_startup(struct tpm_chip *chip)
 {
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	dev_info(&chip->dev, "starting up the TPM manually\n");
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	dev_info(&chip->dev, "TPM2_Startup\n");
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
 	tpm_buf_append_u16(buf, TPM2_SU_CLEAR);
-
-	return tpm_transmit_cmd(chip, buf, 0, "attempting to start the TPM");
+	return tpm_transmit_cmd(chip, buf, 0, "TPM2_Startup");
 }
 
 /**
-- 
2.39.5


