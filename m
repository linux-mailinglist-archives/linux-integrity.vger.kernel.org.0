Return-Path: <linux-integrity+bounces-2989-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B313C926818
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D6B1F219D9
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CD187543;
	Wed,  3 Jul 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj4+CsA7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD671849EB;
	Wed,  3 Jul 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031112; cv=none; b=mENyg0xrer5TelitNVsYsDFmlBKwo3R5IfDvtPHEqBZySx9m9Awvv9SoD3BFgQAu1JUlRIIDDZumP7LZBjRggzK/ku6/Qa752+TBJeOCgpSxosFMkpST2QA2iYtMaNI4kh1XqaZnMIUsJI+Vl/ubuQbUhYcqZH8DateHKg7F8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031112; c=relaxed/simple;
	bh=s8bNAJx6+OLBWKemBM18n5pNaFOTy89B3uBlg32MasU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz5RpbojCWOVj5ptwhe+EtlUBzeuj0klmR/ApPZ7DpF+6QFGx9N8wkcOC8vt9PiYqnYYzDmXGcn3BcULgiY1vfGxfQg1LlMB6CLfL5DFWf63uJzKcKQD+BoB7hcfgCnDDAnFCTYbL0XDO1Ec8kRY2Wl2Pf126Q6FIdOuuB4THeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj4+CsA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859BEC2BD10;
	Wed,  3 Jul 2024 18:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720031111;
	bh=s8bNAJx6+OLBWKemBM18n5pNaFOTy89B3uBlg32MasU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aj4+CsA7RJpI2npws6RhDu8wcdlvM62h6Dqo5/a7+/ITKX/oBG/GnHSU4WN8rXwZ5
	 80fdPuD5ZpD8YdStDz5fK+5/3dQZDgeTBrpxLiTeVaouc4zO1eUfuXXbmxKf0QdwSr
	 T6llZQKm+36ZEmJp0PUyG6+LkKQPvdcCntUOM0bJMIh0zPsMDbI+/wiHK2IzVVHzjP
	 0mMOc91tkjiBSl7/VJVh8mPkGgTElTrZGuxEz9L4ygs/EBp3P/3WUaPmpekKrHthvS
	 +F2ir98L5wxOYz/sZY8ORNre3R/peeeNH3Ytj7S5RS05Z8w9ShzJzLNAXs8UGFdvbR
	 WuAlMkyF6A1hw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
Date: Wed,  3 Jul 2024 21:24:49 +0300
Message-ID: <20240703182453.1580888-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703182453.1580888-1-jarkko@kernel.org>
References: <20240703182453.1580888-1-jarkko@kernel.org>
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

Cc: stable@vger.kernel.org # v6.9+
Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/Makefile        |   2 +-
 drivers/char/tpm/tpm2-sessions.c | 205 ++++++++++++++++---------------
 include/linux/tpm.h              |  16 +--
 3 files changed, 113 insertions(+), 110 deletions(-)

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
index 2f1d96a5a5a7..06d0f10a2301 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -163,6 +163,112 @@ static u8 name_size(const u8 *name)
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
+	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
+	struct tpm2_auth *auth = chip->auth;
+	int slot;
+
+	if (!chip->auth) {
+		tpm_buf_append_u32(buf, handle);
+		/* count the number of handles in the upper bits of flags */
+		buf->handles++;
+		return;
+	}
+
+	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
+	if (slot >= AUTH_MAX_NAMES) {
+		dev_err(&chip->dev, "TPM: too many handles\n");
+		return;
+	}
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
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_name);
+
+#ifdef CONFIG_TCG_TPM2_HMAC
 /*
  * It turns out the crypto hmac(sha256) is hard for us to consume
  * because it assumes a fixed key and the TPM seems to change the key
@@ -567,104 +673,6 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
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
@@ -1311,3 +1319,4 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
+#endif /* CONFIG_TCG_TPM2_HMAC */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 21a67dc9efe8..2844fea4a12a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -211,8 +211,8 @@ struct tpm_chip {
 	u8 null_key_name[TPM2_NAME_SIZE];
 	u8 null_ec_key_x[EC_PT_SZ];
 	u8 null_ec_key_y[EC_PT_SZ];
-	struct tpm2_auth *auth;
 #endif
+	struct tpm2_auth *auth;
 };
 
 #define TPM_HEADER_SIZE		10
@@ -490,11 +490,13 @@ static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 {
 }
 #endif
-#ifdef CONFIG_TCG_TPM2_HMAC
 
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
@@ -521,14 +523,6 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
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


