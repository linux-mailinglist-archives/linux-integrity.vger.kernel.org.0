Return-Path: <linux-integrity+bounces-3007-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E224927D56
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 20:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40E31F248FE
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 18:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0302B135A69;
	Thu,  4 Jul 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPm38ftN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDF73476;
	Thu,  4 Jul 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119210; cv=none; b=Knz94zwvjFOa+MMEyPXUAy5vyVDgt0OGu0arqd2+kLNwfECHVwOVo1yKNBSEvwGvrYjtiJUanYVZbp8HdK7Dh2myQ9ilJ7+pnlyB8oSzOpwAAn474e1uop9zpyXx8/BzftNkZvpe5A552Tq82sOfKQfEgVbgRTxCAEitOL5ackQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119210; c=relaxed/simple;
	bh=AwcpxZYvgEvo+N2vtFk6XV8PMyh7gCgnuHoShrZayvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGb3VddpQRsO5BMnDd+E5iTIWnhz/WmCwnFQck3n3uM6Dzg75dYWQjBi2T7QlTLPl5H+lY1vUuk8DmToyNBWtS01Pkjfu0t+VicLj+XEhz/JhvP8AOnOiDykwuT9k5Nzsaoq4JpODDV5NSbEqSUzKmZX69AiZp6pcCLRXQx23Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPm38ftN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66D2C3277B;
	Thu,  4 Jul 2024 18:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720119210;
	bh=AwcpxZYvgEvo+N2vtFk6XV8PMyh7gCgnuHoShrZayvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPm38ftNQ7gkL1SJlnlLaVJLAtwmUZh9rqwP41rZDJvinzPpCMbLPjGNSrE0BysSC
	 ZtC8pZC+9BOXPpvpuB1xKWJAdY3cQKlCPWwM8nLoBikIyZNu194saDkNg+k4Py+b/8
	 Cae94E2w0cIZ4iM2jxkJTAJU1ULTilgZUqfVng5FtrAgNvanRUKxQMd7/tmeIoowIO
	 bbn2SibZpUH8engy0SyAIUVITFTN4cctTlSubjdxz0DfRx+83XQy8N4pjQ3vXNOmnu
	 jayNIZ7Zkl5nnbA798XxK/5Vdj+FFkaUgPHPvsZHQuSAFIWaaTwPNqdZnEqgbbbN14
	 eG0RNMN0yzx+w==
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
Subject: [PATCH v4 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
Date: Thu,  4 Jul 2024 21:53:07 +0300
Message-ID: <20240704185313.224318-3-jarkko@kernel.org>
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
cause a null derefence in tpm_buf_append_name().  Thus, address
!chip->auth in tpm_buf_append_name() and remove the fallback
implementation for !TCG_TPM2_HMAC.

Cc: stable@vger.kernel.org # v6.10+
Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
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
* N/A
---
 drivers/char/tpm/Makefile        |   2 +-
 drivers/char/tpm/tpm2-sessions.c | 219 +++++++++++++++++--------------
 include/linux/tpm.h              |  21 +--
 3 files changed, 131 insertions(+), 111 deletions(-)

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 4c695b0388f3..9bb142c75243 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -16,8 +16,8 @@ tpm-y += eventlog/common.o
 tpm-y += eventlog/tpm1.o
 tpm-y += eventlog/tpm2.o
 tpm-y += tpm-buf.o
+tpm-y += tpm2-sessions.o
 
-tpm-$(CONFIG_TCG_TPM2_HMAC) += tpm2-sessions.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
 tpm-$(CONFIG_EFI) += eventlog/efi.o
 tpm-$(CONFIG_OF) += eventlog/of.o
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 2f1d96a5a5a7..b3ed35e7ec00 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -83,9 +83,6 @@
 #define AES_KEY_BYTES	AES_KEYSIZE_128
 #define AES_KEY_BITS	(AES_KEY_BYTES*8)
 
-static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
-			       u32 *handle, u8 *name);
-
 /*
  * This is the structure that carries all the auth information (like
  * session handle, nonces, session key and auth) from use to use it is
@@ -148,6 +145,7 @@ struct tpm2_auth {
 	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
 };
 
+#ifdef CONFIG_TCG_TPM2_HMAC
 /*
  * Name Size based on TPM algorithm (assumes no hash bigger than 255)
  */
@@ -163,6 +161,122 @@ static u8 name_size(const u8 *name)
 	return size_map[alg] + 2;
 }
 
+static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	off_t offset = TPM_HEADER_SIZE;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val;
+
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	/* skip public */
+	val = tpm_buf_read_u16(buf, &offset);
+	if (val > tot_len)
+		return -EINVAL;
+	offset += val;
+	/* name */
+	val = tpm_buf_read_u16(buf, &offset);
+	if (val != name_size(&buf->data[offset]))
+		return -EINVAL;
+	memcpy(name, &buf->data[offset], val);
+	/* forget the rest */
+	return 0;
+}
+
+static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
+{
+	struct tpm_buf buf;
+	int rc;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, handle);
+	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
+	if (rc == TPM2_RC_SUCCESS)
+		rc = tpm2_parse_read_public(name, &buf);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+#endif /* CONFIG_TCG_TPM2_HMAC */
+
+/**
+ * tpm_buf_append_name() - add a handle area to the buffer
+ * @chip: the TPM chip structure
+ * @buf: The buffer to be appended
+ * @handle: The handle to be appended
+ * @name: The name of the handle (may be NULL)
+ *
+ * In order to compute session HMACs, we need to know the names of the
+ * objects pointed to by the handles.  For most objects, this is simply
+ * the actual 4 byte handle or an empty buf (in these cases @name
+ * should be NULL) but for volatile objects, permanent objects and NV
+ * areas, the name is defined as the hash (according to the name
+ * algorithm which should be set to sha256) of the public area to
+ * which the two byte algorithm id has been appended.  For these
+ * objects, the @name pointer should point to this.  If a name is
+ * required but @name is NULL, then TPM2_ReadPublic() will be called
+ * on the handle to obtain the name.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			 u32 handle, u8 *name)
+{
+#ifdef CONFIG_TCG_TPM2_HMAC
+	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
+	struct tpm2_auth *auth;
+	int slot;
+#endif
+
+	if (!tpm2_chip_auth(chip)) {
+		tpm_buf_append_u32(buf, handle);
+		/* count the number of handles in the upper bits of flags */
+		buf->handles++;
+		return;
+	}
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
+	if (slot >= AUTH_MAX_NAMES) {
+		dev_err(&chip->dev, "TPM: too many handles\n");
+		return;
+	}
+	auth = chip->auth;
+	WARN(auth->session != tpm_buf_length(buf),
+	     "name added in wrong place\n");
+	tpm_buf_append_u32(buf, handle);
+	auth->session += 4;
+
+	if (mso == TPM2_MSO_PERSISTENT ||
+	    mso == TPM2_MSO_VOLATILE ||
+	    mso == TPM2_MSO_NVRAM) {
+		if (!name)
+			tpm2_read_public(chip, handle, auth->name[slot]);
+	} else {
+		if (name)
+			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");
+	}
+
+	auth->name_h[slot] = handle;
+	if (name)
+		memcpy(auth->name[slot], name, name_size(name));
+#endif
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_name);
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+
+static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
+			       u32 *handle, u8 *name);
+
 /*
  * It turns out the crypto hmac(sha256) is hard for us to consume
  * because it assumes a fixed key and the TPM seems to change the key
@@ -567,104 +681,6 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 }
 EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
 
-static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-	off_t offset = TPM_HEADER_SIZE;
-	u32 tot_len = be32_to_cpu(head->length);
-	u32 val;
-
-	/* we're starting after the header so adjust the length */
-	tot_len -= TPM_HEADER_SIZE;
-
-	/* skip public */
-	val = tpm_buf_read_u16(buf, &offset);
-	if (val > tot_len)
-		return -EINVAL;
-	offset += val;
-	/* name */
-	val = tpm_buf_read_u16(buf, &offset);
-	if (val != name_size(&buf->data[offset]))
-		return -EINVAL;
-	memcpy(name, &buf->data[offset], val);
-	/* forget the rest */
-	return 0;
-}
-
-static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
-{
-	struct tpm_buf buf;
-	int rc;
-
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, handle);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
-	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_read_public(name, &buf);
-
-	tpm_buf_destroy(&buf);
-
-	return rc;
-}
-
-/**
- * tpm_buf_append_name() - add a handle area to the buffer
- * @chip: the TPM chip structure
- * @buf: The buffer to be appended
- * @handle: The handle to be appended
- * @name: The name of the handle (may be NULL)
- *
- * In order to compute session HMACs, we need to know the names of the
- * objects pointed to by the handles.  For most objects, this is simply
- * the actual 4 byte handle or an empty buf (in these cases @name
- * should be NULL) but for volatile objects, permanent objects and NV
- * areas, the name is defined as the hash (according to the name
- * algorithm which should be set to sha256) of the public area to
- * which the two byte algorithm id has been appended.  For these
- * objects, the @name pointer should point to this.  If a name is
- * required but @name is NULL, then TPM2_ReadPublic() will be called
- * on the handle to obtain the name.
- *
- * As with most tpm_buf operations, success is assumed because failure
- * will be caused by an incorrect programming model and indicated by a
- * kernel message.
- */
-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u32 handle, u8 *name)
-{
-	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
-	struct tpm2_auth *auth = chip->auth;
-	int slot;
-
-	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
-	if (slot >= AUTH_MAX_NAMES) {
-		dev_err(&chip->dev, "TPM: too many handles\n");
-		return;
-	}
-	WARN(auth->session != tpm_buf_length(buf),
-	     "name added in wrong place\n");
-	tpm_buf_append_u32(buf, handle);
-	auth->session += 4;
-
-	if (mso == TPM2_MSO_PERSISTENT ||
-	    mso == TPM2_MSO_VOLATILE ||
-	    mso == TPM2_MSO_NVRAM) {
-		if (!name)
-			tpm2_read_public(chip, handle, auth->name[slot]);
-	} else {
-		if (name)
-			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");
-	}
-
-	auth->name_h[slot] = handle;
-	if (name)
-		memcpy(auth->name[slot], name, name_size(name));
-}
-EXPORT_SYMBOL(tpm_buf_append_name);
-
 /**
  * tpm_buf_check_hmac_response() - check the TPM return HMAC for correctness
  * @chip: the TPM chip structure
@@ -1311,3 +1327,4 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
+#endif /* CONFIG_TCG_TPM2_HMAC */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 21a67dc9efe8..4d3071e885a0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -490,11 +490,22 @@ static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 {
 }
 #endif
+
+static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
+{
 #ifdef CONFIG_TCG_TPM2_HMAC
+	return chip->auth;
+#else
+	return NULL;
+#endif
+}
 
-int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+
+int tpm2_start_auth_session(struct tpm_chip *chip);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -521,14 +532,6 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
 static inline void tpm2_end_auth_session(struct tpm_chip *chip)
 {
 }
-static inline void tpm_buf_append_name(struct tpm_chip *chip,
-				       struct tpm_buf *buf,
-				       u32 handle, u8 *name)
-{
-	tpm_buf_append_u32(buf, handle);
-	/* count the number of handles in the upper bits of flags */
-	buf->handles++;
-}
 static inline void tpm_buf_append_hmac_session(struct tpm_chip *chip,
 					       struct tpm_buf *buf,
 					       u8 attributes, u8 *passphrase,
-- 
2.45.2


