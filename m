Return-Path: <linux-integrity+bounces-7835-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36CCAA9F2
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Dec 2025 17:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D389304A9BC
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Dec 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6A2FFF8F;
	Sat,  6 Dec 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meeNYLMx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AB2FFDEA;
	Sat,  6 Dec 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765037646; cv=none; b=RJxzYwfMMolbFIMEyhFcpTn1hgd1CsTKSuKNReRUzqoI8RXlClXuqTqI8JEpwqahr4yHOaCYk/ZKkQMXX0Rn5OQPbeNg15xbweT7w7VLkfNIf/oirJ3tqpfI1HzMpejt6gA0KmF+rCMOhjCTd/VUNwraMe0FaVyAwCIHov79Juk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765037646; c=relaxed/simple;
	bh=AgjqHxLpAROeeBLkwuM7jMn7RAbEAPYBkVKJ48qLhow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQF3YWcOmxqXjY0qHD3kU6pDD1PUyVs9/M0YIYVxGTposP3WqC0k19r2lDsEjp0FFwGwt5+Vuzgp6aFaT3C5Qx2WoJllhUOHoqktxkMiW9y7xGkBcbenvuh1p0c9MVEl0TYp5vLbsemijaDEIdUwUHkfoCalFbB5KJIQbRdIHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meeNYLMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36C8C4CEF5;
	Sat,  6 Dec 2025 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765037646;
	bh=AgjqHxLpAROeeBLkwuM7jMn7RAbEAPYBkVKJ48qLhow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meeNYLMxvsIpN1Hc3a9Yup/dMKgZGm3O4unzODjYWk1utiLJ2k7D/x0huxtkIsKsZ
	 syOLp4a9B3vk/4Uwjn7k+z8ZViF4bZTqQe7paoRih1L+5JeShLl+m4aPB5CGPYT14j
	 gWzEJjdTZ77fnTEoc8LqF2E80AjQyNHhtiyg6OJDLFq1+AlOeqIjdgbO/vqfvDtcF4
	 h+cfVl5weVqRHPKYQwHXINddrZ4ksw9A4sZtb+kKEUYvTwtDV+PozRarvl8hMm+WC2
	 fY50KJt0Gstl/Q8tjnV8fqsu2QGpIUzjf0qDaOMQUpmmL0MHyb3t2xc3QtQUs/HtKs
	 ZVVarujziqJ8A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v5 2/2] KEYS: trusted: Store parent's name to the encoded keys
Date: Sat,  6 Dec 2025 18:13:45 +0200
Message-Id: <20251206161345.2038730-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251206161345.2038730-1-jarkko@kernel.org>
References: <20251206161345.2038730-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend TPMKey ASN.1 speciication [1] with an optional 'parentName'
attribute containing TPM name of the parent key (in other words, TPMT_HA
blob).

The life-cycle for trusted keys will now proceed as follows:

1. Encode parent's name to the 'paretName' during tpm2_key_encode().
2. During tpm2_unseal_trusted, read parent's name from 'parentName'. When
   the attribute is not available, fallback on doing tpm2_read_public().

In other words, in the common (i.e., not loading a legacy key blob),
tpm2_read_public() will now only happen at the time when a key is first
created.

In addition, move tpm2_read_public() to 'tpm2-cmd.c' and make its body
unconditional so that the binary format of the saved keys is not dependent
on kernel configuration.

[1] https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5:
- Rebased to the mainline.
v4:
- No changes.
v3:
- Fixed three low-hanging fruit issues I found myself.
v2:
- A new patch.
---
 drivers/char/tpm/tpm2-cmd.c               | 90 ++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.c          | 92 ----------------------
 include/linux/tpm.h                       |  9 +--
 security/keys/trusted-keys/tpm2key.asn1   | 17 ++++-
 security/keys/trusted-keys/trusted_tpm2.c | 93 ++++++++++++++++-------
 5 files changed, 173 insertions(+), 128 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1f561ad3bdcf..360bc014d895 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -793,3 +793,93 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
+/*
+ * Name Size based on TPM algorithm (assumes no hash bigger than 255)
+ */
+static int name_size(const u8 *name)
+{
+	u16 hash_alg = get_unaligned_be16(name);
+
+	switch (hash_alg) {
+	case TPM_ALG_SHA1:
+		return SHA1_DIGEST_SIZE + 2;
+	case TPM_ALG_SHA256:
+		return SHA256_DIGEST_SIZE + 2;
+	case TPM_ALG_SHA384:
+		return SHA384_DIGEST_SIZE + 2;
+	case TPM_ALG_SHA512:
+		return SHA512_DIGEST_SIZE + 2;
+	default:
+		pr_warn("tpm: unsupported name algorithm: 0x%04x\n", hash_alg);
+		return -EINVAL;
+	}
+}
+
+/**
+ * tpm2_read_public: Resolve TPM name for a handle
+ * @chip:		TPM chip to use.
+ * @handle:		TPM handle.
+ * @name:		A buffer for returning the name blob. Must have a
+ *			capacity of 'SHA512_DIGET_SIZE + 2' bytes at minimum
+ *
+ * Returns size of TPM handle name of success.
+ * Returns tpm_transmit_cmd error codes when TPM2_ReadPublic fails.
+ */
+int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
+{
+	u32 mso = tpm2_handle_mso(handle);
+	off_t offset = TPM_HEADER_SIZE;
+	int rc, name_size_alg;
+	struct tpm_buf buf;
+
+	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
+	    mso != TPM2_MSO_NVRAM) {
+		memcpy(name, &handle, sizeof(u32));
+		return sizeof(u32);
+	}
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, handle);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "TPM2_ReadPublic");
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		return tpm_ret_to_err(rc);
+	}
+
+	/* Skip TPMT_PUBLIC: */
+	offset += tpm_buf_read_u16(&buf, &offset);
+
+	/*
+	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
+	 * TPMT_HA (the extra four bytes).
+	 */
+	if (offset + 4 > tpm_buf_length(&buf)) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	rc = tpm_buf_read_u16(&buf, &offset);
+	name_size_alg = name_size(&buf.data[offset]);
+
+	if (name_size_alg < 0)
+		return name_size_alg;
+
+	if (rc != name_size_alg) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	if (offset + rc > tpm_buf_length(&buf)) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	memcpy(name, &buf.data[offset], rc);
+	return name_size_alg;
+}
+EXPORT_SYMBOL_GPL(tpm2_read_public);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index e33be09446ff..c8b44b1a6cb6 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -140,98 +140,6 @@ struct tpm2_auth {
 	u16 name_size_tbl[AUTH_MAX_NAMES];
 };
 
-#ifdef CONFIG_TCG_TPM2_HMAC
-/*
- * Name Size based on TPM algorithm (assumes no hash bigger than 255)
- */
-static int name_size(const u8 *name)
-{
-	u16 hash_alg = get_unaligned_be16(name);
-
-	switch (hash_alg) {
-	case TPM_ALG_SHA1:
-		return SHA1_DIGEST_SIZE + 2;
-	case TPM_ALG_SHA256:
-		return SHA256_DIGEST_SIZE + 2;
-	case TPM_ALG_SHA384:
-		return SHA384_DIGEST_SIZE + 2;
-	case TPM_ALG_SHA512:
-		return SHA512_DIGEST_SIZE + 2;
-	default:
-		pr_warn("tpm: unsupported name algorithm: 0x%04x\n", hash_alg);
-		return -EINVAL;
-	}
-}
-
-/**
- * tpm2_read_public: Resolve TPM name for a handle
- * @chip:		TPM chip to use.
- * @handle:		TPM handle.
- * @name:		A buffer for returning the name blob. Must have a
- *			capacity of 'SHA512_DIGET_SIZE + 2' bytes at minimum
- *
- * Returns size of TPM handle name of success.
- * Returns tpm_transmit_cmd error codes when TPM2_ReadPublic fails.
- */
-int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
-{
-	u32 mso = tpm2_handle_mso(handle);
-	off_t offset = TPM_HEADER_SIZE;
-	int rc, name_size_alg;
-	struct tpm_buf buf;
-
-	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
-	    mso != TPM2_MSO_NVRAM) {
-		memcpy(name, &handle, sizeof(u32));
-		return sizeof(u32);
-	}
-
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
-	if (rc)
-		return rc;
-
-	tpm_buf_append_u32(&buf, handle);
-
-	rc = tpm_transmit_cmd(chip, &buf, 0, "TPM2_ReadPublic");
-	if (rc) {
-		tpm_buf_destroy(&buf);
-		return tpm_ret_to_err(rc);
-	}
-
-	/* Skip TPMT_PUBLIC: */
-	offset += tpm_buf_read_u16(&buf, &offset);
-
-	/*
-	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
-	 * TPMT_HA (the extra four bytes).
-	 */
-	if (offset + 4 > tpm_buf_length(&buf)) {
-		tpm_buf_destroy(&buf);
-		return -EIO;
-	}
-
-	rc = tpm_buf_read_u16(&buf, &offset);
-	name_size_alg = name_size(&buf.data[offset]);
-
-	if (name_size_alg < 0)
-		return name_size_alg;
-
-	if (rc != name_size_alg) {
-		tpm_buf_destroy(&buf);
-		return -EIO;
-	}
-
-	if (offset + rc > tpm_buf_length(&buf)) {
-		tpm_buf_destroy(&buf);
-		return -EIO;
-	}
-
-	memcpy(name, &buf.data[offset], rc);
-	return name_size_alg;
-}
-EXPORT_SYMBOL_GPL(tpm2_read_public);
-#endif /* CONFIG_TCG_TPM2_HMAC */
-
 /**
  * tpm_buf_append_name() - Append a handle and store TPM name
  * @chip:		TPM chip to use.
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 319ba75dd79a..704fceb46a40 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -478,6 +478,7 @@ extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 int tpm2_find_hash_alg(unsigned int crypto_id);
+int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name);
 
 static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 {
@@ -544,7 +545,6 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
 void tpm2_end_auth_session(struct tpm_chip *chip);
-int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name);
 #else
 #include <linux/unaligned.h>
 
@@ -568,13 +568,6 @@ static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
 {
 	return rc;
 }
-
-static inline int tpm2_read_public(struct tpm_chip *chip, u32 handle,
-				   void *name)
-{
-	memcpy(name, &handle, sizeof(u32));
-	return sizeof(u32);
-}
 #endif	/* CONFIG_TCG_TPM2_HMAC */
 
 #endif
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
index f57f869ad600..70cca3b7c3d4 100644
--- a/security/keys/trusted-keys/tpm2key.asn1
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -1,11 +1,26 @@
 ---
 --- ASN.1 for TPM 2.0 keys
 ---
+TPMPolicy ::= SEQUENCE {
+	commandCode	[0] EXPLICIT INTEGER,
+	commandPolicy	[1] EXPLICIT OCTET STRING
+}
+
+TPMAuthPolicy ::= SEQUENCE {
+	name		[0] EXPLICIT UTF8String OPTIONAL,
+	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy
+}
 
 TPMKey ::= SEQUENCE {
 	type		OBJECT IDENTIFIER ({tpm2_key_type}),
 	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
+	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL,
+	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
+	authPolicy	[3] EXPLICIT SEQUENCE OF TPMAuthPolicy OPTIONAL,
+	description	[4] EXPLICIT UTF8String OPTIONAL,
+	rsaParent	[5] EXPLICIT BOOLEAN OPTIONAL,
+	parentName	[6] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_parent_name}),
 	parent		INTEGER ({tpm2_key_parent}),
 	pubkey		OCTET STRING ({tpm2_key_pub}),
 	privkey		OCTET STRING ({tpm2_key_priv})
-	}
+}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 88bafbcc011a..07f04cc010bc 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -20,16 +20,26 @@
 
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
 
+enum tpm_key_tag {
+	TPM_KEY_TAG_EMPTY_AUTH	= 0,
+	TPM_KEY_TAG_POLICY	= 1,
+	TPM_KEY_TAG_SECRET	= 2,
+	TPM_KEY_TAG_AUTH_POLICY	= 3,
+	TPM_KEY_TAG_DESCRIPTION = 4,
+	TPM_KEY_TAG_RSA_PARENT	= 5,
+	TPM_KEY_TAG_PARENT_NAME	= 6,
+};
+
 static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
-			   u8 *src, u32 len)
+			   u8 *src, u32 len, u8 *parent_name,
+			   u16 parent_name_size)
 {
 	const int SCRATCH_SIZE = PAGE_SIZE;
-	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
-	u8 *work = scratch, *work1;
-	u8 *end_work = scratch + SCRATCH_SIZE;
-	u8 *priv, *pub;
+	u8 *end_work, *name_end;
 	u16 priv_len, pub_len;
+	u8 *work, *work1;
+	u8 *priv, *pub;
 	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
@@ -40,23 +50,41 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	pub_len = get_unaligned_be16(src) + 2;
 	pub = src;
 
+	u8 *scratch __free(kfree) = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
 	if (!scratch)
 		return -ENOMEM;
 
+	work = scratch;
+	end_work = scratch + SCRATCH_SIZE;
+
 	work = asn1_encode_oid(work, end_work, tpm2key_oid,
 			       asn1_oid_len(tpm2key_oid));
 
 	if (options->blobauth_len == 0) {
-		unsigned char bool[3], *w = bool;
-		/* tag 0 is emptyAuth */
-		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
-			ret = PTR_ERR(w);
-			goto err;
+		u8 *bool_end;
+		u8 bool[3];
+
+		bool_end = asn1_encode_boolean(&bool[0], &bool[sizeof(bool)],
+					       true);
+		if (IS_ERR(bool_end)) {
+			pr_err("BUG: Boolean failed to encode\n");
+			return PTR_ERR(bool_end);
 		}
-		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+
+		work = asn1_encode_tag(work, end_work, TPM_KEY_TAG_EMPTY_AUTH,
+				       bool, bool_end - bool);
 	}
 
+	u8 *name_encoded __free(kfree) = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	if (!name_encoded)
+		return -ENOMEM;
+
+	name_end = asn1_encode_octet_string(&name_encoded[0],
+					    &name_encoded[SCRATCH_SIZE],
+					    parent_name, parent_name_size);
+	work = asn1_encode_tag(work, end_work, TPM_KEY_TAG_PARENT_NAME,
+			       name_encoded, name_end - name_encoded);
+
 	/*
 	 * Assume both octet strings will encode to a 2 byte definite length
 	 *
@@ -65,8 +93,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
 		 "BUG: scratch buffer is too small")) {
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
@@ -79,15 +106,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	if (IS_ERR(work1)) {
 		ret = PTR_ERR(work1);
 		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	kfree(scratch);
 	return work1 - payload->blob;
-
-err:
-	kfree(scratch);
-	return ret;
 }
 
 struct tpm2_key_context {
@@ -96,11 +118,13 @@ struct tpm2_key_context {
 	u32 pub_len;
 	const u8 *priv;
 	u32 priv_len;
+	const u8 *name;
+	u32 name_len;
 };
 
 static int tpm2_key_decode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
-			   u8 **buf)
+			   u8 **buf, u8 *parent_name, u16 *parent_name_size)
 {
 	int ret;
 	struct tpm2_key_context ctx;
@@ -127,6 +151,8 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	blob += ctx.priv_len;
 
 	memcpy(blob, ctx.pub, ctx.pub_len);
+	memcpy(parent_name, ctx.name, ctx.name_len);
+	*parent_name_size = ctx.name_len;
 
 	return 0;
 }
@@ -190,6 +216,16 @@ int tpm2_key_priv(void *context, size_t hdrlen,
 	return 0;
 }
 
+int tpm2_key_parent_name(void *context, size_t hdrlen, unsigned char tag,
+			 const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->name = value;
+	ctx->name_len = vlen;
+
+	return 0;
+}
 /**
  * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
@@ -347,7 +383,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
+	blob_len = tpm2_key_encode(payload, options, &buf.data[offset],
+				   blob_len, parent_name, parent_name_size);
 	if (blob_len < 0)
 		rc = blob_len;
 
@@ -602,7 +639,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	 * Try to decode the provided blob as an ASN.1 blob. Assume that the
 	 * blob is in the legacy format if decoding does not end successfully.
 	 */
-	rc = tpm2_key_decode(payload, options, &blob);
+	rc = tpm2_key_decode(payload, options, &blob, &parent_name[0], &parent_name_size);
 	if (rc) {
 		blob = payload->blob;
 		payload->old_format = 1;
@@ -617,11 +654,13 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
-	rc = tpm2_read_public(chip, options->keyhandle, parent_name);
-	if (rc < 0)
-		goto out;
+	if (!parent_name_size) {
+		rc = tpm2_read_public(chip, options->keyhandle, parent_name);
+		if (rc < 0)
+			goto out;
 
-	parent_name_size = rc;
+		parent_name_size = rc;
+	}
 
 	rc = tpm2_load_cmd(chip, payload, options, parent_name,
 			   parent_name_size, blob, &blob_handle);
-- 
2.39.5


