Return-Path: <linux-integrity+bounces-7889-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56DCB32C4
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 15:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59BDE30282D4
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB001FBEB0;
	Wed, 10 Dec 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjvW5tgt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EA221DAD;
	Wed, 10 Dec 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377602; cv=none; b=nXzKo+4l1XwLTpyVjy03R39wMMk/cMKxWFuxibLUD/0lW+P6gF9z3Sy5nNKa4qjTEYottHvNiorM4+noOJCO6q1r9PEMiViaXmZ5EBGsjg/vuEETzeJrnNyTFlgzGY6D69XtZQdf7dmL8Ih5cf37Db6Uv8vCxu9VUXFRB5wvlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377602; c=relaxed/simple;
	bh=FImZXxsx3vdik3A+AE8B0smFOqFlJAYmfBu9rXDotvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWDGLOeS/D6DbFHFG80xcsIUM0fNPGY6Xi/0dnhWh1Krc6t6qscCYzCZx0DXOHDmPQJzFBzGEEtQyIhRGhZBPjvsg9PgqQ969VUgfYXTCBFo5k62py6jq+ORJ77k6ZuP9r6B3FOb16XXv1jq1fVh7KQaBBDdCvGSpQtAe1nPp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjvW5tgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BB9C4CEF1;
	Wed, 10 Dec 2025 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377601;
	bh=FImZXxsx3vdik3A+AE8B0smFOqFlJAYmfBu9rXDotvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjvW5tgtE9a5AZbhHsfEQSt+Bn21lpcfpBUKalIhgaloQJ1Ub93EcNGefzw2WYfD1
	 PE8zH3sPh3SRkeLHFVfbLo98gCMUrngABptiO+D4AWq5FmRdF/Cq1gDMpRblqtjYmH
	 XRkLzIJlBchQwmyYOHXxfAZtUX1BwID+7jYmyd6mmZvRcI32mxiP0ZeTqBhYf7su6u
	 b0GJZv//yERuFh0KVo9ATGlq/SH6gi28JMdBEvYzfbH6jPbt4uIctASovAIywgd6Gr
	 mkdX7cANj7uZRBXMtPv95MIZelrGtm7z5tnS6yXFV/j/i7KGH1qC4rZNEy/jnOklMr
	 mslyOKFHKqcmQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 3/7] KEYS: trusted: Re-orchestrate tpm2_read_public() calls
Date: Wed, 10 Dec 2025 16:39:35 +0200
Message-ID: <20251210143940.264191-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210143940.264191-1-jarkko@kernel.org>
References: <20251210143940.264191-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_load_cmd() and tpm2_unseal_cmd() use the same parent, and calls to
tpm_buf_append_name() cause the exact same TPM2_ReadPublic command to be
sent to the chip, causing unnecessary traffic.

1. Export tpm2_read_public in order to make it callable from
   'trusted_tpm2'.
2. Re-orchestrate tpm2_seal_trusted() and tpm2_unseal_trusted() in order to
   halve the name resolutions required:
2a. Move tpm2_read_public() calls into trusted_tpm2.
2b. Pass TPM name to tpm_buf_append_name().
2c. Rework tpm_buf_append_name() to use the pre-resolved name.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c               |   3 +-
 drivers/char/tpm/tpm2-sessions.c          |  95 +++++------------
 include/linux/tpm.h                       |  10 +-
 security/keys/trusted-keys/trusted_tpm2.c | 124 ++++++++++++++--------
 4 files changed, 118 insertions(+), 114 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 543c1c62c938..436ee82620e4 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -199,7 +199,8 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 
 	if (!disable_pcr_integrity) {
-		rc = tpm_buf_append_name(chip, buf, pcr_idx, NULL);
+		rc = tpm_buf_append_name(chip, buf, pcr_idx, (u8 *)&pcr_idx,
+					 sizeof(u32));
 		if (rc)
 			return rc;
 		tpm_buf_append_hmac_session(chip, buf, 0, NULL, 0);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index a0c88fb1804c..0816a91134fc 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -136,8 +136,8 @@ struct tpm2_auth {
 	 * handle, but they are part of the session by name, which
 	 * we must compute and remember
 	 */
-	u32 name_h[AUTH_MAX_NAMES];
 	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
+	u16 name_size_tbl[AUTH_MAX_NAMES];
 };
 
 #ifdef CONFIG_TCG_TPM2_HMAC
@@ -163,7 +163,17 @@ static int name_size(const u8 *name)
 	}
 }
 
-static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
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
 {
 	u32 mso = tpm2_handle_mso(handle);
 	off_t offset = TPM_HEADER_SIZE;
@@ -212,14 +222,16 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 	memcpy(name, &buf->data[offset], rc);
 	return name_size_alg;
 }
+EXPORT_SYMBOL_GPL(tpm2_read_public);
 #endif /* CONFIG_TCG_TPM2_HMAC */
 
 /**
- * tpm_buf_append_name() - add a handle area to the buffer
- * @chip: the TPM chip structure
- * @buf: The buffer to be appended
- * @handle: The handle to be appended
- * @name: The name of the handle (may be NULL)
+ * tpm_buf_append_name() - Append a handle and store TPM name
+ * @chip:		TPM chip to use.
+ * @buf:		TPM buffer containing the TPM command in-transit.
+ * @handle:		TPM handle to be appended.
+ * @name:		TPM name of the handle
+ * @name_size:		Size of the TPM name.
  *
  * In order to compute session HMACs, we need to know the names of the
  * objects pointed to by the handles.  For most objects, this is simply
@@ -236,15 +248,14 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
  * will be caused by an incorrect programming model and indicated by a
  * kernel message.
  *
- * Ends the authorization session on failure.
+ * Returns zero on success.
+ * Returns -EIO when the authorization area state is malformed.
  */
 int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			u32 handle, u8 *name)
+			u32 handle, u8 *name, u16 name_size)
 {
 #ifdef CONFIG_TCG_TPM2_HMAC
-	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
 	struct tpm2_auth *auth;
-	u16 name_size_alg;
 	int slot;
 	int ret;
 #endif
@@ -269,36 +280,15 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 	tpm_buf_append_u32(buf, handle);
 	auth->session += 4;
-
-	if (mso == TPM2_MSO_PERSISTENT ||
-	    mso == TPM2_MSO_VOLATILE ||
-	    mso == TPM2_MSO_NVRAM) {
-		if (!name) {
-			ret = tpm2_read_public(chip, handle, auth->name[slot]);
-			if (ret < 0)
-				goto err;
-
-			name_size_alg = ret;
-		}
-	} else {
-		if (name) {
-			dev_err(&chip->dev, "handle 0x%08x does not use a name\n",
-				handle);
-			ret = -EIO;
-			goto err;
-		}
-	}
-
-	auth->name_h[slot] = handle;
-	if (name)
-		memcpy(auth->name[slot], name, name_size_alg);
+	memcpy(auth->name[slot], name, name_size);
+	auth->name_size_tbl[slot] = name_size;
 #endif
 	return 0;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 err:
 	tpm2_end_auth_session(chip);
-	return tpm_ret_to_err(ret);
+	return ret;
 #endif
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
@@ -606,22 +596,8 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	attrs = chip->cc_attrs_tbl[i];
 
 	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
+	offset_s += handles * sizeof(u32);
 
-	/*
-	 * just check the names, it's easy to make mistakes.  This
-	 * would happen if someone added a handle via
-	 * tpm_buf_append_u32() instead of tpm_buf_append_name()
-	 */
-	for (i = 0; i < handles; i++) {
-		u32 handle = tpm_buf_read_u32(buf, &offset_s);
-
-		if (auth->name_h[i] != handle) {
-			dev_err(&chip->dev, "invalid handle 0x%08x\n", handle);
-			ret = -EIO;
-			goto err;
-		}
-	}
-	/* point offset_s to the start of the sessions */
 	val = tpm_buf_read_u32(buf, &offset_s);
 	/* point offset_p to the start of the parameters */
 	offset_p = offset_s + val;
@@ -682,23 +658,8 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	/* ordinal is already BE */
 	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
 	/* add the handle names */
-	for (i = 0; i < handles; i++) {
-		enum tpm2_mso_type mso = tpm2_handle_mso(auth->name_h[i]);
-
-		if (mso == TPM2_MSO_PERSISTENT ||
-		    mso == TPM2_MSO_VOLATILE ||
-		    mso == TPM2_MSO_NVRAM) {
-			ret = name_size(auth->name[i]);
-			if (ret < 0)
-				goto err;
-
-			sha256_update(&sctx, auth->name[i], ret);
-		} else {
-			__be32 h = cpu_to_be32(auth->name_h[i]);
-
-			sha256_update(&sctx, (u8 *)&h, 4);
-		}
-	}
+	for (i = 0; i < handles; i++)
+		sha256_update(&sctx, auth->name[i], auth->name_size_tbl[i]);
 	if (offset_s != tpm_buf_length(buf))
 		sha256_update(&sctx, &buf->data[offset_s],
 			      tpm_buf_length(buf) - offset_s);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 922a43ef23b5..9f684fc7ae04 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -543,7 +543,7 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 }
 
 int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			u32 handle, u8 *name);
+			u32 handle, u8 *name, u16 name_size);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -557,6 +557,7 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
 void tpm2_end_auth_session(struct tpm_chip *chip);
+int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name);
 #else
 #include <linux/unaligned.h>
 
@@ -580,6 +581,13 @@ static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
 {
 	return rc;
 }
+
+static inline int tpm2_read_public(struct tpm_chip *chip, u32 handle,
+				   void *name)
+{
+	memcpy(name, &handle, sizeof(u32));
+	return sizeof(u32);
+}
 #endif	/* CONFIG_TCG_TPM2_HMAC */
 
 #endif
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 27424e1a4a63..63539b344ffb 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -203,7 +203,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	u8 parent_name[TPM2_MAX_NAME_SIZE];
 	off_t offset = TPM_HEADER_SIZE;
+	u16 parent_name_size;
 	int blob_len = 0;
 	int hash;
 	u32 flags;
@@ -220,6 +222,12 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
+	rc = tpm2_read_public(chip, options->keyhandle, parent_name);
+	if (rc < 0)
+		goto out_put;
+
+	parent_name_size = rc;
+
 	rc = tpm2_start_auth_session(chip);
 	if (rc)
 		goto out_put;
@@ -234,7 +242,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	tpm_buf_init(buf, TPM_BUFSIZE);
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 
-	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, buf, options->keyhandle, parent_name,
+				 parent_name_size);
 	if (rc)
 		goto out_put;
 
@@ -326,48 +335,38 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 }
 
 /**
- * tpm2_load_cmd() - execute a TPM2_Load command
- *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- * @blob_handle: returned blob handle
+ * tpm2_load_cmd() - Execute TPM2_Load
+ * @chip:		TPM chip to use.
+ * @payload:		Key data in clear text.
+ * @options:		Trusted key options.
+ * @parent_name:	A cryptographic name, i.e. a TPMT_HA blob, of the
+ *			parent key.
+ * @blob:		The decoded payload for the key.
+ * @blob_handle:	On success, will contain handle to the loaded keyedhash
+ *			blob.
  *
- * Return: 0 on success.
- *        -E2BIG on wrong payload size.
- *        -EPERM on tpm error status.
- *        < 0 error from tpm_send.
+ * Return -E2BIG when the blob size is too small for all the data.
+ * Returns tpm_transmit_cmd() error codes when either TPM2_Load fails.
  */
 static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_payload *payload,
 			 struct trusted_key_options *options,
+			 u8 *parent_name,
+			 u16 parent_name_size,
+			 const u8 *blob,
 			 u32 *blob_handle)
 {
 	u8 *blob_ref __free(kfree) = NULL;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
-	u8 *blob, *pub;
+	const u8 *pub;
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
-	if (rc) {
-		/* old form */
-		blob = payload->blob;
-		payload->old_format = 1;
-	} else {
-		/* Bind for cleanup: */
-		blob_ref = blob;
-	}
-
-	/* new format carries keyhandle but old format doesn't */
-	if (!options->keyhandle)
-		return -EINVAL;
-
 	/* must be big enough for at least the two be16 size counts */
 	if (payload->blob_len < 4)
-		return -EINVAL;
+		return -E2BIG;
 
 	private_len = get_unaligned_be16(blob);
 
@@ -406,7 +405,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	tpm_buf_init(buf, TPM_BUFSIZE);
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
 
-	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, buf, options->keyhandle, parent_name,
+				 parent_name_size);
 	if (rc)
 		return rc;
 
@@ -434,20 +434,23 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 }
 
 /**
- * tpm2_unseal_cmd() - execute a TPM2_Unload command
+ * tpm2_unseal_cmd() - Execute TPM2_Unload
  *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- * @blob_handle: blob handle
+ * @chip:		TPM chip to use
+ * @payload:		Key data in clear text.
+ * @options:		Trusted key options.
+ * @parent_name:	A cryptographic name, i.e. a TPMT_HA blob, of the
+ *			parent key.
+ * @blob_handle:	Handle to the loaded keyedhash blob.
  *
- * Return: 0 on success
- *         -EPERM on tpm error status
- *         < 0 error from tpm_send
+ * Return -E2BIG when the blob size is too small for all the data.
+ * Returns tpm_transmit_cmd() error codes when either TPM2_Load fails.
  */
 static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
+			   u8 *parent_name,
+			   u16 parent_name_size,
 			   u32 blob_handle)
 {
 	u16 data_len;
@@ -465,7 +468,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_init(buf, TPM_BUFSIZE);
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
 
-	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, buf, options->keyhandle, parent_name,
+				 parent_name_size);
 	if (rc)
 		return rc;
 
@@ -526,30 +530,60 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 }
 
 /**
- * tpm2_unseal_trusted() - unseal the payload of a trusted key
+ * tpm2_unseal_trusted() - Unseal a trusted key
+ * @chip:	TPM chip to use.
+ * @payload:	Key data in clear text.
+ * @options:	Trusted key options.
  *
- * @chip: TPM chip to use
- * @payload: the key data in clear and encrypted form
- * @options: authentication values and other options
- *
- * Return: Same as with tpm_send.
+ * Return -E2BIG when the blob size is too small for all the data.
+ * Return -EINVAL when parent's key handle has not been set.
+ * Returns tpm_transmit_cmd() error codes when either TPM2_Load or TPM2_Unseal
+ * fails.
  */
 int tpm2_unseal_trusted(struct tpm_chip *chip,
 			struct trusted_key_payload *payload,
 			struct trusted_key_options *options)
 {
+	u8 *blob_ref __free(kfree) = NULL;
+	u8 parent_name[TPM2_MAX_NAME_SIZE];
+	u16 parent_name_size;
 	u32 blob_handle;
+	u8 *blob;
 	int rc;
 
+	/*
+	 * Try to decode the provided blob as an ASN.1 blob. Assume that the
+	 * blob is in the legacy format if decoding does not end successfully.
+	 */
+	rc = tpm2_key_decode(payload, options, &blob);
+	if (rc) {
+		blob = payload->blob;
+		payload->old_format = 1;
+	} else {
+		blob_ref = blob;
+	}
+
+	if (!options->keyhandle)
+		return -EINVAL;
+
 	rc = tpm_try_get_ops(chip);
 	if (rc)
 		return rc;
 
-	rc = tpm2_load_cmd(chip, payload, options, &blob_handle);
+	rc = tpm2_read_public(chip, options->keyhandle, parent_name);
+	if (rc < 0)
+		goto out;
+
+	parent_name_size = rc;
+
+	rc = tpm2_load_cmd(chip, payload, options, parent_name,
+			   parent_name_size, blob, &blob_handle);
 	if (rc)
 		goto out;
 
-	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
+	rc = tpm2_unseal_cmd(chip, payload, options, parent_name,
+			     parent_name_size, blob_handle);
+
 	tpm2_flush_context(chip, blob_handle);
 
 out:
-- 
2.52.0


