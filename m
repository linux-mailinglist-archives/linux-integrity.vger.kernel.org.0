Return-Path: <linux-integrity+bounces-2999-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A792725A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D531F24135
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E81AB529;
	Thu,  4 Jul 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9VZUILx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817F1AB521;
	Thu,  4 Jul 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083459; cv=none; b=AxIued+2zkiM+9tYCs+OKNO0jwcVEuB8lD/4GzfwtenVWNiVnjfA/jHKxWkTvOc0svaIELnUUGo0vDVh7Ub9uUG8j6GPm7Le2YTbnRYpjc/QXga8VldGJSb5Esa8zbtyuN9HJbnlMjkqHeh4934OwOOsLxGh/FhoqK8xgqsCiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083459; c=relaxed/simple;
	bh=1R1l/jh/2sVbYXEuHFTT6vinE3yiZu+gRxbg7eWhc4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/rhxM6TW6SP8jWrgQ8TjZonLk8KdTBhqQXQM0aQaYZcweeM6fQ0DkWRz8kKM/vEqrZXt6f/wGYoMELTjVaT6Giph53lLd1yO1uHUMg5R/FVRx0cBRoOh+DOaSIVf/HSJCALF1F18pmFQ/fDNBhc5oCqFbTYd8eYxG6WGKma9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9VZUILx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296B0C4AF0B;
	Thu,  4 Jul 2024 08:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083458;
	bh=1R1l/jh/2sVbYXEuHFTT6vinE3yiZu+gRxbg7eWhc4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9VZUILxFQlQsYkDK5sjS4MXCR40r/4MWt6lsSedyN2b573OFxRYKCDROoxC7pO48
	 iyfM6g/OjzHZXu73ERxx4BFtQSG8cUjGrTGQJp9LU8iPUfhzxmXlCidQv6G6rHynYE
	 sUhfp1x5m42Jkj62+x6M5JLiIlohItWprZA/FXhk/rlLlccD1ZOxfduKNE3NQPb3xo
	 nZJiHdk7PUH1kbOGTQEeeKtyJX1tFXZN0UPjGv88yR4vvBETFJgq7EJIFpD6yK84EP
	 SkJqLLCFUvkfBe7B5hxunEmjHcLroAhkuCYGdi68C7gXEOXnu6FPUCjtqxnmYqdQgZ
	 iMcWadP/GJppA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] tpm: Address !chip->auth in tpm_buf_append_hmac_session*()
Date: Thu,  4 Jul 2024 11:57:04 +0300
Message-ID: <20240704085708.661142-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704085708.661142-1-jarkko@kernel.org>
References: <20240704085708.661142-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unless tpm_chip_bootstrap() was called by the driver, !chip->auth can
cause a null derefence in tpm_buf_hmac_session*().  Thus, address
!chip->auth in tpm_buf_hmac_session*() and remove the fallback
implementation for !TCG_TPM2_HMAC.

Cc: stable@vger.kernel.org # v6.9+
Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
* Address:
  https://lore.kernel.org/linux-integrity/922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com/
v2:
* Use auth in place of chip->auth.
---
 drivers/char/tpm/tpm2-sessions.c | 184 ++++++++++++++++++-------------
 include/linux/tpm.h              |  68 ++++--------
 2 files changed, 128 insertions(+), 124 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 179bcaac06ce..e0be22b8ae70 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -270,6 +270,108 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
+/**
+ * tpm_buf_append_hmac_session() - Append a TPM session element
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
+ * @attributes: The session attributes
+ * @passphrase: The session authority (NULL if none)
+ * @passphrase_len: The length of the session authority (0 if none)
+ *
+ * This fills in a session structure in the TPM command buffer, except
+ * for the HMAC which cannot be computed until the command buffer is
+ * complete.  The type of session is controlled by the @attributes,
+ * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
+ * session won't terminate after tpm_buf_check_hmac_response(),
+ * TPM2_SA_DECRYPT which means this buffers first parameter should be
+ * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
+ * response buffer's first parameter needs to be decrypted (confusing,
+ * but the defines are written from the point of view of the TPM).
+ *
+ * Any session appended by this command must be finalized by calling
+ * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
+ * and the TPM will reject the command.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
+				 u8 attributes, u8 *passphrase,
+				 int passphrase_len)
+{
+	u8 __maybe_unused nonce[SHA256_DIGEST_SIZE];
+	struct tpm2_auth __maybe_unused *auth;
+	u32 __maybe_unused len;
+
+	if (!__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth)) {
+		/* offset tells us where the sessions area begins */
+		int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+		u32 len = 9 + passphrase_len;
+
+		if (tpm_buf_length(buf) != offset) {
+			/* not the first session so update the existing length */
+			len += get_unaligned_be32(&buf->data[offset]);
+			put_unaligned_be32(len, &buf->data[offset]);
+		} else {
+			tpm_buf_append_u32(buf, len);
+		}
+		/* auth handle */
+		tpm_buf_append_u32(buf, TPM2_RS_PW);
+		/* nonce */
+		tpm_buf_append_u16(buf, 0);
+		/* attributes */
+		tpm_buf_append_u8(buf, 0);
+		/* passphrase */
+		tpm_buf_append_u16(buf, passphrase_len);
+		tpm_buf_append(buf, passphrase, passphrase_len);
+		return;
+	}
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+	/*
+	 * The Architecture Guide requires us to strip trailing zeros
+	 * before computing the HMAC
+	 */
+	while (passphrase && passphrase_len > 0 && passphrase[passphrase_len - 1] == '\0')
+		passphrase_len--;
+
+	auth = chip->auth;
+	auth->attrs = attributes;
+	auth->passphrase_len = passphrase_len;
+	if (passphrase_len)
+		memcpy(auth->passphrase, passphrase, passphrase_len);
+
+	if (auth->session != tpm_buf_length(buf)) {
+		/* we're not the first session */
+		len = get_unaligned_be32(&buf->data[auth->session]);
+		if (4 + len + auth->session != tpm_buf_length(buf)) {
+			WARN(1, "session length mismatch, cannot append");
+			return;
+		}
+
+		/* add our new session */
+		len += 9 + 2 * SHA256_DIGEST_SIZE;
+		put_unaligned_be32(len, &buf->data[auth->session]);
+	} else {
+		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
+	}
+
+	/* random number for our nonce */
+	get_random_bytes(nonce, sizeof(nonce));
+	memcpy(auth->our_nonce, nonce, sizeof(nonce));
+	tpm_buf_append_u32(buf, auth->handle);
+	/* our new nonce */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+	tpm_buf_append_u8(buf, auth->attrs);
+	/* and put a placeholder for the hmac */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+#endif /* CONFIG_TCG_TPM2_HMAC */
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_hmac_session);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 
 static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
@@ -455,82 +557,6 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	crypto_free_kpp(kpp);
 }
 
-/**
- * tpm_buf_append_hmac_session() - Append a TPM session element
- * @chip: the TPM chip structure
- * @buf: The buffer to be appended
- * @attributes: The session attributes
- * @passphrase: The session authority (NULL if none)
- * @passphrase_len: The length of the session authority (0 if none)
- *
- * This fills in a session structure in the TPM command buffer, except
- * for the HMAC which cannot be computed until the command buffer is
- * complete.  The type of session is controlled by the @attributes,
- * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
- * session won't terminate after tpm_buf_check_hmac_response(),
- * TPM2_SA_DECRYPT which means this buffers first parameter should be
- * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
- * response buffer's first parameter needs to be decrypted (confusing,
- * but the defines are written from the point of view of the TPM).
- *
- * Any session appended by this command must be finalized by calling
- * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
- * and the TPM will reject the command.
- *
- * As with most tpm_buf operations, success is assumed because failure
- * will be caused by an incorrect programming model and indicated by a
- * kernel message.
- */
-void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
-				 u8 attributes, u8 *passphrase,
-				 int passphrase_len)
-{
-	u8 nonce[SHA256_DIGEST_SIZE];
-	u32 len;
-	struct tpm2_auth *auth = chip->auth;
-
-	/*
-	 * The Architecture Guide requires us to strip trailing zeros
-	 * before computing the HMAC
-	 */
-	while (passphrase && passphrase_len > 0
-	       && passphrase[passphrase_len - 1] == '\0')
-		passphrase_len--;
-
-	auth->attrs = attributes;
-	auth->passphrase_len = passphrase_len;
-	if (passphrase_len)
-		memcpy(auth->passphrase, passphrase, passphrase_len);
-
-	if (auth->session != tpm_buf_length(buf)) {
-		/* we're not the first session */
-		len = get_unaligned_be32(&buf->data[auth->session]);
-		if (4 + len + auth->session != tpm_buf_length(buf)) {
-			WARN(1, "session length mismatch, cannot append");
-			return;
-		}
-
-		/* add our new session */
-		len += 9 + 2 * SHA256_DIGEST_SIZE;
-		put_unaligned_be32(len, &buf->data[auth->session]);
-	} else {
-		tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
-	}
-
-	/* random number for our nonce */
-	get_random_bytes(nonce, sizeof(nonce));
-	memcpy(auth->our_nonce, nonce, sizeof(nonce));
-	tpm_buf_append_u32(buf, auth->handle);
-	/* our new nonce */
-	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
-	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
-	tpm_buf_append_u8(buf, auth->attrs);
-	/* and put a placeholder for the hmac */
-	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
-	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
-}
-EXPORT_SYMBOL(tpm_buf_append_hmac_session);
-
 /**
  * tpm_buf_fill_hmac_session() - finalize the session HMAC
  * @chip: the TPM chip structure
@@ -561,6 +587,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	u8 cphash[SHA256_DIGEST_SIZE];
 	struct sha256_state sctx;
 
+	if (!auth)
+		return;
+
 	/* save the command code in BE format */
 	auth->ordinal = head->ordinal;
 
@@ -719,6 +748,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	u32 cc = be32_to_cpu(auth->ordinal);
 	int parm_len, len, i, handles;
 
+	if (!auth)
+		return rc;
+
 	if (auth->session >= TPM_HEADER_SIZE) {
 		WARN(1, "tpm session not filled correctly\n");
 		goto out;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index d9a6991b247d..e47f5d65935e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -493,10 +493,6 @@ static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
-
-#ifdef CONFIG_TCG_TPM2_HMAC
-
-int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -506,9 +502,27 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   u8 *passphrase,
 						   int passphraselen)
 {
-	tpm_buf_append_hmac_session(chip, buf, attributes, passphrase,
-				    passphraselen);
+	struct tpm_header *head;
+	int offset;
+
+	if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth)) {
+		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
+	} else  {
+		offset = buf->handles * 4 + TPM_HEADER_SIZE;
+		head = (struct tpm_header *)buf->data;
+
+		/*
+		 * If the only sessions are optional, the command tag must change to
+		 * TPM2_ST_NO_SESSIONS.
+		 */
+		if (tpm_buf_length(buf) == offset)
+			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+	}
 }
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+
+int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
@@ -523,48 +537,6 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
 static inline void tpm2_end_auth_session(struct tpm_chip *chip)
 {
 }
-static inline void tpm_buf_append_hmac_session(struct tpm_chip *chip,
-					       struct tpm_buf *buf,
-					       u8 attributes, u8 *passphrase,
-					       int passphraselen)
-{
-	/* offset tells us where the sessions area begins */
-	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-	u32 len = 9 + passphraselen;
-
-	if (tpm_buf_length(buf) != offset) {
-		/* not the first session so update the existing length */
-		len += get_unaligned_be32(&buf->data[offset]);
-		put_unaligned_be32(len, &buf->data[offset]);
-	} else {
-		tpm_buf_append_u32(buf, len);
-	}
-	/* auth handle */
-	tpm_buf_append_u32(buf, TPM2_RS_PW);
-	/* nonce */
-	tpm_buf_append_u16(buf, 0);
-	/* attributes */
-	tpm_buf_append_u8(buf, 0);
-	/* passphrase */
-	tpm_buf_append_u16(buf, passphraselen);
-	tpm_buf_append(buf, passphrase, passphraselen);
-}
-static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
-						   struct tpm_buf *buf,
-						   u8 attributes,
-						   u8 *passphrase,
-						   int passphraselen)
-{
-	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-	struct tpm_header *head = (struct tpm_header *) buf->data;
-
-	/*
-	 * if the only sessions are optional, the command tag
-	 * must change to TPM2_ST_NO_SESSIONS
-	 */
-	if (tpm_buf_length(buf) == offset)
-		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-}
 static inline void tpm_buf_fill_hmac_session(struct tpm_chip *chip,
 					     struct tpm_buf *buf)
 {
-- 
2.45.2


