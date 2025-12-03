Return-Path: <linux-integrity+bounces-7789-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCCCA1C87
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 23:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2118F3009808
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCDA2DCBE0;
	Wed,  3 Dec 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9tJf8D7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248102D063C;
	Wed,  3 Dec 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799947; cv=none; b=PCCK6pDtIQMmSx/KiqCRe4+ez34PYXbllv2S/v9rvVcU8EDBfPhwnloRBrpAzbUuGZrMkOPNUPlJPwhwLHC3yKYYRQVTBe0R5B2ncCI7TWdMrdzmMWHVE4GGd92BmDcPKb1ScqLs3QyjkNZLw+EDsL8gSYSC7sUTAuI4HZNliXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799947; c=relaxed/simple;
	bh=k18D9jOm3t2JA+KSpMfSCTERDWm5Y+1XAY9792c443U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQEa1rHfM6KUf++5bjIa5UBot6YPRDF4RG0/GUUxMIjAxcC+3r9XTDzHwMz0mNHHnC3fmR0PW4BYd0ShYvViqObfSm/RkEGfxpN6Hi5+AoTTFFUUhsI0d5FNha/J+jTg0eGQfc59R8DIgrlTTfnFifjtavP28KMKB3aEL73o80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9tJf8D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1519CC4CEFB;
	Wed,  3 Dec 2025 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764799946;
	bh=k18D9jOm3t2JA+KSpMfSCTERDWm5Y+1XAY9792c443U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9tJf8D7zJ+fUHpLbzVkSk6DCW7Fy6qDPAw7vG2WX2fFNE7uManuqiv0FdpABpkeJ
	 aOp4Wqmh0+zFrIP0Pqfpx45lDl8oyyUdf1qvsvnh7oIX8xyTgDyViV1jKTOYCvm4x5
	 L0yTi3J0eOcyiO22ofq4l/lXw9/fso3cAPZKrD0uEn8REvCLigZjLXdrSZvSlB7eTg
	 TefASfPgC8gQFnRxHy9npIKCn9ERJozAMdqLhZSJq5rnTSfyn7HIOzpg9CRc8poXQs
	 6NJY7fNUC0MYxczmpW1K7FfBuRVaBgyy6AXPeLjiSZ4SLkUGoM+9NBDX86vewwDPSE
	 01+U/dCv9QVqw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@earth.li>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list),
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 1/4] tpm2-sessions: fix out of range indexing in name_size
Date: Thu,  4 Dec 2025 00:12:11 +0200
Message-ID: <20251203221215.536031-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203221215.536031-1-jarkko@kernel.org>
References: <20251203221215.536031-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'name_size' does not have any range checks, and it just directly indexes
with TPM_ALG_ID, which could lead into memory corruption at worst.

Address the issue by only processing known values and returning -EINVAL for
unrecognized values.

Make also 'tpm_buf_append_name' and 'tpm_buf_fill_hmac_session' fallible so
that errors are detected before causing any spurious TPM traffic.

End also the authorization session on failure in both of the functions, as
the session state would be then by definition corrupted.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

v3:
- Fix pr_warn() format string in name_size().
- Fix !CONFIG_TPM2_HMAC compilation.
v2:
- Wrote a better short summary.
- Addressed remarks in https://lore.kernel.org/linux-integrity/aS8TIeviaippVAha@earth.li/
- Use -EIO consistently in tpm2_fill_hmac_session. These are not input value
  errors. They could only spun from malformed (kernel) state.
- name_size did not have a proper default-case. Reorganize the
  fallback into that.
---
 drivers/char/tpm/tpm2-cmd.c               |  23 +++-
 drivers/char/tpm/tpm2-sessions.c          | 133 +++++++++++++++-------
 include/linux/tpm.h                       |  13 ++-
 security/keys/trusted-keys/trusted_tpm2.c |  29 ++++-
 4 files changed, 143 insertions(+), 55 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index dd502322f499..be4a9c7f2e1a 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -199,7 +199,11 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	}
 
 	if (!disable_pcr_integrity) {
-		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+		rc = tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+		if (rc) {
+			tpm_buf_destroy(&buf);
+			return rc;
+		}
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(chip, &buf, pcr_idx);
@@ -214,8 +218,14 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
-	if (!disable_pcr_integrity)
-		tpm_buf_fill_hmac_session(chip, &buf);
+	if (!disable_pcr_integrity) {
+		rc = tpm_buf_fill_hmac_session(chip, &buf);
+		if (rc) {
+			tpm_buf_destroy(&buf);
+			return rc;
+		}
+	}
+
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
 	if (!disable_pcr_integrity)
 		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
@@ -273,7 +283,12 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 						| TPM2_SA_CONTINUE_SESSION,
 						NULL, 0);
 		tpm_buf_append_u16(&buf, num_bytes);
-		tpm_buf_fill_hmac_session(chip, &buf);
+		err = tpm_buf_fill_hmac_session(chip, &buf);
+		if (err) {
+			tpm_buf_destroy(&buf);
+			return err;
+		}
+
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 6d03c224e6b2..a265e9752a5e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -144,16 +144,23 @@ struct tpm2_auth {
 /*
  * Name Size based on TPM algorithm (assumes no hash bigger than 255)
  */
-static u8 name_size(const u8 *name)
+static int name_size(const u8 *name)
 {
-	static u8 size_map[] = {
-		[TPM_ALG_SHA1] = SHA1_DIGEST_SIZE,
-		[TPM_ALG_SHA256] = SHA256_DIGEST_SIZE,
-		[TPM_ALG_SHA384] = SHA384_DIGEST_SIZE,
-		[TPM_ALG_SHA512] = SHA512_DIGEST_SIZE,
-	};
-	u16 alg = get_unaligned_be16(name);
-	return size_map[alg] + 2;
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
 }
 
 static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
@@ -161,6 +168,7 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 	struct tpm_header *head = (struct tpm_header *)buf->data;
 	off_t offset = TPM_HEADER_SIZE;
 	u32 tot_len = be32_to_cpu(head->length);
+	int ret;
 	u32 val;
 
 	/* we're starting after the header so adjust the length */
@@ -172,9 +180,15 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 		return -EINVAL;
 	offset += val;
 	/* name */
+
 	val = tpm_buf_read_u16(buf, &offset);
-	if (val != name_size(&buf->data[offset]))
+	ret = name_size(&buf->data[offset]);
+	if (ret < 0)
+		return ret;
+
+	if (val != ret)
 		return -EINVAL;
+
 	memcpy(name, &buf->data[offset], val);
 	/* forget the rest */
 	return 0;
@@ -221,46 +235,72 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
  * As with most tpm_buf operations, success is assumed because failure
  * will be caused by an incorrect programming model and indicated by a
  * kernel message.
+ *
+ * Ends the authorization session on failure.
  */
-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u32 handle, u8 *name)
+int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			u32 handle, u8 *name)
 {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
 	struct tpm2_auth *auth;
 	int slot;
+	int ret;
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
 		tpm_buf_append_handle(chip, buf, handle);
-		return;
+		return 0;
 	}
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE) / 4;
 	if (slot >= AUTH_MAX_NAMES) {
-		dev_err(&chip->dev, "TPM: too many handles\n");
-		return;
+		dev_err(&chip->dev, "too many handles\n");
+		ret = -EIO;
+		goto err;
 	}
 	auth = chip->auth;
-	WARN(auth->session != tpm_buf_length(buf),
-	     "name added in wrong place\n");
+	if (auth->session != tpm_buf_length(buf)) {
+		dev_err(&chip->dev, "session state malformed");
+		ret = -EIO;
+		goto err;
+	}
 	tpm_buf_append_u32(buf, handle);
 	auth->session += 4;
 
 	if (mso == TPM2_MSO_PERSISTENT ||
 	    mso == TPM2_MSO_VOLATILE ||
 	    mso == TPM2_MSO_NVRAM) {
-		if (!name)
-			tpm2_read_public(chip, handle, auth->name[slot]);
+		if (!name) {
+			ret = tpm2_read_public(chip, handle, auth->name[slot]);
+			if (ret)
+				goto err;
+		}
 	} else {
-		if (name)
-			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");
+		if (name) {
+			dev_err(&chip->dev, "handle 0x%08x does not use a name\n",
+				handle);
+			ret = -EIO;
+			goto err;
+		}
 	}
 
 	auth->name_h[slot] = handle;
-	if (name)
-		memcpy(auth->name[slot], name, name_size(name));
+	if (name) {
+		ret = name_size(name);
+		if (ret < 0)
+			goto err;
+
+		memcpy(auth->name[slot], name, ret);
+	}
+#endif
+	return 0;
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+err:
+	tpm2_end_auth_session(chip);
+	return tpm_ret_to_err(ret);
 #endif
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
@@ -533,11 +573,9 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
  * encryption key and encrypts the first parameter of the command
  * buffer with it.
  *
- * As with most tpm_buf operations, success is assumed because failure
- * will be caused by an incorrect programming model and indicated by a
- * kernel message.
+ * Ends the authorization session on failure.
  */
-void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
+int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 {
 	u32 cc, handles, val;
 	struct tpm2_auth *auth = chip->auth;
@@ -549,9 +587,12 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	u8 cphash[SHA256_DIGEST_SIZE];
 	struct sha256_ctx sctx;
 	struct hmac_sha256_ctx hctx;
+	int ret;
 
-	if (!auth)
-		return;
+	if (!auth) {
+		ret = -EIO;
+		goto err;
+	}
 
 	/* save the command code in BE format */
 	auth->ordinal = head->ordinal;
@@ -560,9 +601,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 
 	i = tpm2_find_cc(chip, cc);
 	if (i < 0) {
-		dev_err(&chip->dev, "Command 0x%x not found in TPM\n", cc);
-		return;
+		dev_err(&chip->dev, "command 0x%08x not found\n", cc);
+		ret = -EIO;
+		goto err;
 	}
+
 	attrs = chip->cc_attrs_tbl[i];
 
 	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
@@ -576,9 +619,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		u32 handle = tpm_buf_read_u32(buf, &offset_s);
 
 		if (auth->name_h[i] != handle) {
-			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
-				  i);
-			return;
+			dev_err(&chip->dev, "invalid handle 0x%08x\n", handle);
+			ret = -EIO;
+			goto err;
 		}
 	}
 	/* point offset_s to the start of the sessions */
@@ -609,12 +652,14 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		offset_s += len;
 	}
 	if (offset_s != offset_p) {
-		dev_err(&chip->dev, "TPM session length is incorrect\n");
-		return;
+		dev_err(&chip->dev, "session length is incorrect\n");
+		ret = -EIO;
+		goto err;
 	}
 	if (!hmac) {
-		dev_err(&chip->dev, "TPM could not find HMAC session\n");
-		return;
+		dev_err(&chip->dev, "could not find HMAC session\n");
+		ret = -EIO;
+		goto err;
 	}
 
 	/* encrypt before HMAC */
@@ -646,8 +691,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		if (mso == TPM2_MSO_PERSISTENT ||
 		    mso == TPM2_MSO_VOLATILE ||
 		    mso == TPM2_MSO_NVRAM) {
-			sha256_update(&sctx, auth->name[i],
-				      name_size(auth->name[i]));
+			ret = name_size(auth->name[i]);
+			if (ret < 0)
+				goto err;
+
+			sha256_update(&sctx, auth->name[i], ret);
 		} else {
 			__be32 h = cpu_to_be32(auth->name_h[i]);
 
@@ -668,6 +716,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	hmac_sha256_update(&hctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
 	hmac_sha256_update(&hctx, &auth->attrs, 1);
 	hmac_sha256_final(&hctx, hmac);
+	return 0;
+
+err:
+	tpm2_end_auth_session(chip);
+	return ret;
 }
 EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3d8f7d1ce2b8..aa816b144ab3 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -529,8 +529,8 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 #endif
 }
 
-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u32 handle, u8 *name);
+int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			u32 handle, u8 *name);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -563,7 +563,7 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 #ifdef CONFIG_TCG_TPM2_HMAC
 
 int tpm2_start_auth_session(struct tpm_chip *chip);
-void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
+int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
 void tpm2_end_auth_session(struct tpm_chip *chip);
@@ -577,10 +577,13 @@ static inline int tpm2_start_auth_session(struct tpm_chip *chip)
 static inline void tpm2_end_auth_session(struct tpm_chip *chip)
 {
 }
-static inline void tpm_buf_fill_hmac_session(struct tpm_chip *chip,
-					     struct tpm_buf *buf)
+
+static inline int tpm_buf_fill_hmac_session(struct tpm_chip *chip,
+					    struct tpm_buf *buf)
 {
+	return 0;
 }
+
 static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
 					      struct tpm_buf *buf,
 					      int rc)
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 8bc6efa8accb..5b205279584b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -268,7 +268,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out_put;
 	}
 
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc)
+		goto out;
+
 	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
 				    options->keyauth, TPM_DIGEST_SIZE);
 
@@ -316,7 +319,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
+	rc = tpm_buf_fill_hmac_session(chip, &buf);
+	if (rc)
+		goto out;
+
 	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 	if (rc)
@@ -427,7 +433,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc)
+		goto out;
+
 	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
 				    TPM_DIGEST_SIZE);
 
@@ -439,7 +448,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		goto out;
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
+	rc = tpm_buf_fill_hmac_session(chip, &buf);
+	if (rc)
+		goto out;
+
 	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 	if (!rc)
@@ -484,7 +496,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc)
+		goto out;
 
 	if (!options->policyhandle) {
 		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
@@ -509,7 +523,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 						NULL, 0);
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
+	rc = tpm_buf_fill_hmac_session(chip, &buf);
+	if (rc)
+		goto out;
+
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 
-- 
2.52.0


