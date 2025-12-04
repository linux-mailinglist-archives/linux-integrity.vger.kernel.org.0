Return-Path: <linux-integrity+bounces-7805-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5003CA52B5
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 20:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D59303154C38
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520D2E1726;
	Thu,  4 Dec 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvTzXgsk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406B1FBC92;
	Thu,  4 Dec 2025 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764877705; cv=none; b=pDDWOl+bdtRZdDBGBCXKa1uaQzQfNj0RPhfEZPKdU/2fnnlJMMAABy/ruV8rNeslaoitfs2K3ACcew0d9kMwMsZq9xALtqykYQ5z9VnaCZ9zuPRtvvYfUHGzHnr9hhQ1zvoQiwbXMl0StoiIgN4B4Ip5K6ADfcsC1uiXijes+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764877705; c=relaxed/simple;
	bh=zrJn8EcwvPlQmApQF2Qhl2tuf7U7YPJfrDOiCzPAJsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1n/7sbEoghVo7ZnW8cUBeEyKsy0l4gh3IWDBKTObLew15baHpD8x3Pg8ks8i9axxmPNxrERgL4gmSt2UdbIFerOvS3OjGoOfatAOzlQzAWVLg5mkTPKeLWyGwp3MHvwHBTRaH8BvTlBmrWsbJlJ/C/KsSPVJ5/gtyuUsBEfKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvTzXgsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C700C4CEFB;
	Thu,  4 Dec 2025 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764877704;
	bh=zrJn8EcwvPlQmApQF2Qhl2tuf7U7YPJfrDOiCzPAJsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvTzXgskSV9O2uWXd0C0dLRm58UYI+m2JJVy2z0OMIQtaajHj75YNQoDEJS8WQyWK
	 jwl7QIeFJUQd81w6iZP+pUkEeJCNbfT6xEkUZABs7XGEBaX3fmZhjrOH5uWrjfTPdV
	 21pvn/M/mx/LylXgTFeNA0dPe9zKk2oI9TxOMLbAgDA8eIYgkSta8yzr000o/7XgZG
	 HMvZoSX2EyEeD8yg2xpNTm0V6hZNgf5hL6TFiUwbpMB1uL1h/D9Bk3eLZwXyIPOgV1
	 Oo8dELOwKfU42Fx9ZOatBTLgJZxZOLS+smby2hlmPy0BDFN78P+xm6fHuqIFjAjqNG
	 pC0GUltqd8taA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list),
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v4 4/4] tpm2-sessions: Open code tpm_buf_append_hmac_session()
Date: Thu,  4 Dec 2025 21:47:42 +0200
Message-ID: <20251204194743.69035-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204194743.69035-1-jarkko@kernel.org>
References: <20251204194743.69035-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Open code 'tpm_buf_append_hmac_session_opt' to the call site, as it only
masks a call sequence and does otherwise nothing particularly useful.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
 include/linux/tpm.h                       | 23 -----------------------
 security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ce0a1c6b0596..3a77be7ebf4a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -282,9 +282,17 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
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
 		err = tpm_buf_fill_hmac_session(chip, &buf);
 		if (err) {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index afa51723296a..202da079d500 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -536,29 +536,6 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
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
index 5b205279584b..a7ea4a1c3bed 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -481,8 +481,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
+	struct tpm_header *head;
 	struct tpm_buf buf;
 	u16 data_len;
+	int offset;
 	u8 *data;
 	int rc;
 
@@ -519,8 +521,14 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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
 
 	rc = tpm_buf_fill_hmac_session(chip, &buf);
-- 
2.52.0


