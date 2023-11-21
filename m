Return-Path: <linux-integrity+bounces-155-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C77F37F1
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AF528102A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E7B54667;
	Tue, 21 Nov 2023 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvhgJxUF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49A54666
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 21:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E1C433C7;
	Tue, 21 Nov 2023 21:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700601450;
	bh=JhIxIpxRqOX9d+TKHEN9Y5MeVUPXrIM8NDLV56PQmNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvhgJxUF/j8r4lIGvHz3JkwvPzaA1rQ4UurCNmN32gFTB78zRqsI5z9Bra8nTuHzf
	 pp4js2QeICOUkbnuFlfqAkY4cnrk0WppEgFp0RYKQ6Jo6FhQ6a73JKWvACweJFVCeW
	 LjTrJxp1F0PTMKzmL6dBfjtOBYl+2pKXQwAN5zhRW7MxeerPhgIRYd7kJn/AN6H6Y2
	 EqRGcj9wBPiPMb4zeZ1bx8nT/vNNF4gqLp5yjw9qX6J+AV6gk7WpcKj0MsCQW/fvM4
	 rhnDNij/E1udLwdoVNg4FrcCgbRF5XfnBIrlA35G2iYOOvTPvJlp143vubqvZdoMNg
	 QHv144LCrWBKg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	William Roberts <bill.c.roberts@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <jejb@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Julien Gomes <julien@arista.com>
Subject: [PATCH v4 2/8] tpm: Remove tpm_send()
Date: Tue, 21 Nov 2023 23:17:11 +0200
Message-ID: <20231121211717.31681-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121211717.31681-1-jarkko@kernel.org>
References: <20231121211717.31681-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open code the last remaining call site for tpm_send().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1 [2023-11-21]: A new patch.
---
 drivers/char/tpm/tpm-interface.c          | 25 -----------------------
 include/linux/tpm.h                       |  5 -----
 security/keys/trusted-keys/trusted_tpm1.c | 14 +++++++++++--
 3 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..163ae247bff2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -342,31 +342,6 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 }
 EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 
-/**
- * tpm_send - send a TPM command
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @cmd:	a TPM command buffer
- * @buflen:	the length of the TPM command buffer
- *
- * Return: same as with tpm_transmit_cmd()
- */
-int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	chip = tpm_find_get_ops(chip);
-	if (!chip)
-		return -ENODEV;
-
-	buf.data = cmd;
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to a send a command");
-
-	tpm_put_ops(chip);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(tpm_send);
-
 int tpm_auto_startup(struct tpm_chip *chip)
 {
 	int rc;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6588ca87cf93..d9d645e9c52c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -422,7 +422,6 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
-extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
@@ -443,10 +442,6 @@ static inline int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return -ENODEV;
 }
 
-static inline int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen)
-{
-	return -ENODEV;
-}
 static inline int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max)
 {
 	return -ENODEV;
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index aa108bea6739..37bce84eef99 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -356,17 +356,27 @@ static int TSS_checkhmac2(unsigned char *buffer,
  */
 int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 {
+	struct tpm_buf buf;
 	int rc;
 
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc)
+		return rc;
+
+	buf.flags = 0;
+	buf.data = cmd;
 	dump_tpm_buf(cmd);
-	rc = tpm_send(chip, cmd, buflen);
+	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
 	dump_tpm_buf(cmd);
+
 	if (rc > 0)
-		/* Can't return positive return codes values to keyctl */
+		/* TPM error */
 		rc = -EPERM;
+
+	tpm_put_ops(chip);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(trusted_tpm_send);
-- 
2.42.1


