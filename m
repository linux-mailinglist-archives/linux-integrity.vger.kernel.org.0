Return-Path: <linux-integrity+bounces-3008-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE60927D5A
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 20:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CB3283889
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A3F13C9B8;
	Thu,  4 Jul 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed6vnC+b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8BF13C90B;
	Thu,  4 Jul 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119215; cv=none; b=BVhUy0PE3hXpriIqw1/U9FNp/033/PCgOLPSJs30Fx/5IbGeQFwO6naKMpizptH4Gzp/7Uu3YemNmDVNshXY5tASY18tB/6sD9LzTc0ZMiKBkzpbDdQ5/79tq+UFf3YaVkCKjihjSmgL99wihmfZna4CoLu2Bp3YOH0sqAnSgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119215; c=relaxed/simple;
	bh=6dnQmoNRVdKNz5z+5LQzjfW1/goiM1Ez8Qa4oDUYHRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRKZbdesMLDkwJxRG5DeAceBCuvDRTlD8oAlAHF43mJ/NEuAY4u11DcAaVXO6HMD1krP6McABFpusO0Pw27juhk0WyoDWHFMaByPyOiVFtSnAoF+GhjMjys4eW9nh0OVtuOSe7ua/iJZDzUIIakjaw25aW2u7BmPD9TJfhKFgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed6vnC+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2BEC32786;
	Thu,  4 Jul 2024 18:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720119215;
	bh=6dnQmoNRVdKNz5z+5LQzjfW1/goiM1Ez8Qa4oDUYHRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ed6vnC+bmJyT3MstBT7LGw61D23EL+ozcha/lS/DWW17xu0QortmKEK8uY2S2h/aD
	 Ta0DNuxTMlStuK7mH/GQktbZjYBcTVbaMAGzTQg8FI62WYuL9VqDlTkYGVoxdE7wZP
	 hqyOp2WCGpEXlXzvN4UN8jHuNdvkRiGZpPGpMclZuZa+ZmS9vM4YBAYzu3JVDQTAoo
	 UYY9ZBHYpnjpJOpm60wHqTcz5E4DEMiIUS0lKv414437iDRSHay31Gy/G9F9Rfil0h
	 /O09+yTyXneMURFpEOEtQFLrvw/7deWqEFRW+9UbS5Bpuzzr44K7dHB3Bzp4kefecH
	 Bj65LfAhYBNlg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: [PATCH v4 3/3] tpm: Address !chip->auth in tpm_buf_append_hmac_session*()
Date: Thu,  4 Jul 2024 21:53:08 +0300
Message-ID: <20240704185313.224318-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704185313.224318-1-jarkko@kernel.org>
References: <20240704185313.224318-1-jarkko@kernel.org>
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
Tested-by: Michael Ellerman <mpe@ellerman.id.au> # ppc
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
* Address:
  https://lore.kernel.org/linux-integrity/CAHk-=wiM=Cyw-07EkbAH66pE50VzJiT3bVHv9CS=kYR6zz5mTQ@mail.gmail.com/
* Added tested-by from Michael Ellerman.
v3:
* Address:
  https://lore.kernel.org/linux-integrity/922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com/
v2:
* Use auth in place of chip->auth.
---
 drivers/char/tpm/tpm2-sessions.c | 186 ++++++++++++++++++-------------
 include/linux/tpm.h              |  68 ++++-------
 2 files changed, 130 insertions(+), 124 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index b3ed35e7ec00..2281d55df545 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -272,6 +272,110 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
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
+#ifdef CONFIG_TCG_TPM2_HMAC
+	u8 nonce[SHA256_DIGEST_SIZE];
+	struct tpm2_auth *auth;
+	u32 len;
+#endif
+
+	if (!tpm2_chip_auth(chip)) {
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
+#endif
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_hmac_session);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 
 static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
@@ -457,82 +561,6 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
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
@@ -563,6 +591,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	u8 cphash[SHA256_DIGEST_SIZE];
 	struct sha256_state sctx;
 
+	if (!auth)
+		return;
+
 	/* save the command code in BE format */
 	auth->ordinal = head->ordinal;
 
@@ -721,6 +752,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	u32 cc = be32_to_cpu(auth->ordinal);
 	int parm_len, len, i, handles;
 
+	if (!auth)
+		return rc;
+
 	if (auth->session >= TPM_HEADER_SIZE) {
 		WARN(1, "tpm session not filled correctly\n");
 		goto out;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4d3071e885a0..e93ee8d936a9 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -502,10 +502,6 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
-
-#ifdef CONFIG_TCG_TPM2_HMAC
-
-int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -515,9 +511,27 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   u8 *passphrase,
 						   int passphraselen)
 {
-	tpm_buf_append_hmac_session(chip, buf, attributes, passphrase,
-				    passphraselen);
+	struct tpm_header *head;
+	int offset;
+
+	if (tpm2_chip_auth(chip)) {
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
@@ -532,48 +546,6 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
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


