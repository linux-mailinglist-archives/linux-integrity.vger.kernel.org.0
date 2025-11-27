Return-Path: <linux-integrity+bounces-7696-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E367C8EA43
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 14:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B00244E9BA2
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2032E332ED9;
	Thu, 27 Nov 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1yR0f24"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859F332ED6;
	Thu, 27 Nov 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251730; cv=none; b=N8T14+yo7j9f5LOoWR9zx7QlGiRvKa53nyLRGCvwyON3K9PA+0qEUyRgNyBp6GqGO/EaC/ZcIiTpC60RAdxdK65K8y+JrnbNaHJPCtI4IGpsQbZe/W8UWFG3VH6S/dxoI2e/iU7Kyszt7U5usFYcAVEPOO1LuduFwBK97SQwl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251730; c=relaxed/simple;
	bh=KereAcgUVMPHRMEmAgQUnJp1tT3JWOELRLLeiIfsjFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGfzaVyy6tvuXtyQJWAXqGxF9/wXD2uiPOkqfaJTRTnRnwokYD0mOgB0d5KjLxC9ghYbD3u7dPfO1UCdpRO89U//6CYq4D74mry6ktwW7PEJAmnbBshW7T01s1T2/4sowK656TP6RoA2rBY1gQq5PL2JfYE61D6sL3/brCwhKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1yR0f24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C2BC4CEF8;
	Thu, 27 Nov 2025 13:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251729;
	bh=KereAcgUVMPHRMEmAgQUnJp1tT3JWOELRLLeiIfsjFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1yR0f24daz+Ci5eY9pj+5vLBrOKHhfXXPs2qa6JcBybbsf8yuvHapQQeRRH1FBAI
	 jXpZJk2amq0jmRcWR2QLDRUzYVo2Qb2vgKB5ckX1dJPDE2yys9XxGU7vSiloDA/EwD
	 8/ikn5Hfo8asHfOYGMoLU62k8m6cN39lrE4FYzCdUe9t9T9xQss/g7lCFH/1ukx6sP
	 kmhjuYbqaKTN2j36NYGujn9RCJcXLluUcuyV1W1h1+FQiqc06PP3J43kS9fIqlZY17
	 MZnCJ6ty+1LJg2sinV/7bSya8Glub9JDLvvqzOAfqyDDLRRNhw77qzq2OLHEnMxnY6
	 Vzm9Z9v8W/I0g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 07/11] tpm2-sessions: Unmask tpm_buf_append_hmac_session()
Date: Thu, 27 Nov 2025 15:54:39 +0200
Message-ID: <20251127135445.2141241-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127135445.2141241-1-jarkko@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Open code tpm_buf_append_hmac_session_opt() in order to unmask the code
paths in the call sites of tpm_buf_append_hmac_session().

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
v6:
- No changes.
v5:
- No changes.
v4:
- Fixed typo in short summary.
v3:
- No changes.
v2:
- Uncorrupt the patch.
---
 drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
 include/linux/tpm.h                       | 23 -----------------------
 security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ceffa3bd2b5c..e9ee6ff32aea 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -272,9 +272,17 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
 	do {
 		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
-						| TPM2_SA_CONTINUE_SESSION,
-						NULL, 0);
+		if (tpm2_chip_auth(chip)) {
+			tpm_buf_append_hmac_session(chip, &buf,
+						    TPM2_SA_ENCRYPT |
+						    TPM2_SA_CONTINUE_SESSION,
+						    NULL, 0);
+		} else  {
+			offset = buf.handles * 4 + TPM_HEADER_SIZE;
+			head = (struct tpm_header *)buf.data;
+			if (tpm_buf_length(&buf) == offset)
+				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		}
 		tpm_buf_append_u16(&buf, num_bytes);
 		tpm_buf_fill_hmac_session(chip, &buf);
 		err = tpm_transmit_cmd(chip, &buf,
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 5acf6422e2b9..dc38fc1870f8 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -532,29 +532,6 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 int passphraselen);
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u8 *passphrase, int passphraselen);
-static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
-						   struct tpm_buf *buf,
-						   u8 attributes,
-						   u8 *passphrase,
-						   int passphraselen)
-{
-	struct tpm_header *head;
-	int offset;
-
-	if (tpm2_chip_auth(chip)) {
-		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
-	} else  {
-		offset = buf->handles * 4 + TPM_HEADER_SIZE;
-		head = (struct tpm_header *)buf->data;
-
-		/*
-		 * If the only sessions are optional, the command tag must change to
-		 * TPM2_ST_NO_SESSIONS.
-		 */
-		if (tpm_buf_length(buf) == offset)
-			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-	}
-}
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c9973ac46041..367bcfb59c4d 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -467,8 +467,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
+	struct tpm_header *head;
 	struct tpm_buf buf;
 	u16 data_len;
+	int offset;
 	u8 *data;
 	int rc;
 
@@ -503,8 +505,14 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		tpm2_buf_append_auth(&buf, options->policyhandle,
 				     NULL /* nonce */, 0, 0,
 				     options->blobauth, options->blobauth_len);
-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
-						NULL, 0);
+		if (tpm2_chip_auth(chip)) {
+			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
+		} else  {
+			offset = buf.handles * 4 + TPM_HEADER_SIZE;
+			head = (struct tpm_header *)buf.data;
+			if (tpm_buf_length(&buf) == offset)
+				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		}
 	}
 
 	tpm_buf_fill_hmac_session(chip, &buf);
-- 
2.52.0


