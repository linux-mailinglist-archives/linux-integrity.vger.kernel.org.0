Return-Path: <linux-integrity+bounces-7742-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A95FBC954D6
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Nov 2025 22:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93C80341350
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Nov 2025 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290D01F8723;
	Sun, 30 Nov 2025 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcXRXDzg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E736D4FC;
	Sun, 30 Nov 2025 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764537512; cv=none; b=DWrDUQfgSsGyANduv+Qa5HNCOOSShYxHkZyld93mXiCvPvsiTLAOxajROcfOZbtWPFJQ/TJeUK7cb4ztA3ai5tGjEdbTqYXIVRUtBJzEcalxU3piWdCU1c7Hsuv5CnycCo895etP4fqIuupSxlTInZ/SYamyvQ+9AvhKdt80+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764537512; c=relaxed/simple;
	bh=eep+PoaegdjE9CqLVaHfhxC2CgtBr0lqHcXJCs1P/Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjUsxnMFLyM/WubfdyDrqgiXgoeJ8CEgSHg/uZKEZGFj/RHAXDLA5e1hA2gNIRVY7yYrvcQqijxalI1GKwxT1piEEhrpW0lOHKKRNUAKtOqZKUV0mbRdhaC5MWswbEXChDx50P8xRqnQ9oBfdqpv2J0kWmk1WfNfia6GV+M7Jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcXRXDzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AAFC4CEF8;
	Sun, 30 Nov 2025 21:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764537511;
	bh=eep+PoaegdjE9CqLVaHfhxC2CgtBr0lqHcXJCs1P/Nk=;
	h=From:To:Cc:Subject:Date:From;
	b=kcXRXDzg2kGqYWFrVbymGr7CDax0/JCzeXUpBRXZ3ISDpsIb0C2WUKuKUa3foaR+B
	 sSu2oQEFq4qIvhVxP4YRqZk/Nw2/Oik+yKgqeDBwAEMg5SNrgk4pBDu66TrfmKzjsF
	 uYpqQnbKF1fRc4sIrWEQn2z+ptzEU8xrBGIKKtZus/DzDHS/u9KwEKFnjr3pKIGrS3
	 m/B20I2T0hn1A3gDlZ/GySF4CCNvG8fXi/ZsE+BsMkfnwhSIm5dfoe9/+kk7XHaDNr
	 cc8pGZYmRbilsVvYLptuB3yif7dOtuF8RcCuB+hpGPopfqh/gxlLfZ2ZYRPB8eNZ74
	 zA4075jvuTMaA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] tpm2-sessions: address out-of-range indexing
Date: Sun, 30 Nov 2025 23:18:14 +0200
Message-ID: <20251130211816.1195997-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'name_size' does not have any range checks, and it just directly indexes
with TPM_ALG_ID.

Address the issue by:

1. Rename 'name_size' as 'tpm2_name_size' so that it is bit easier to
   recognize and make it a fallible function.
2. Check for only known algorithms in 'tpm2_name_size'. Return -EINVAL for
   unrecognized algorithms.
3. In order to correctly propagate possible errors make also
   'tpm2_buf_append_name' and 'tpm_buf_fill_hmac_session' fallible and
   address their possible errors at the call sites.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c               |  23 ++++-
 drivers/char/tpm/tpm2-sessions.c          | 108 ++++++++++++++--------
 include/linux/tpm.h                       |   7 +-
 security/keys/trusted-keys/trusted_tpm2.c |  38 ++++++--
 4 files changed, 125 insertions(+), 51 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5b6ccf901623..e63254135a74 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -187,7 +187,12 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	}
 
 	if (!disable_pcr_integrity) {
-		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+		rc = tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
+		if (rc) {
+			tpm2_end_auth_session(chip);
+			return rc;
+		}
+
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(chip, &buf, pcr_idx);
@@ -202,8 +207,14 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			       chip->allocated_banks[i].digest_size);
 	}
 
-	if (!disable_pcr_integrity)
-		tpm_buf_fill_hmac_session(chip, &buf);
+	if (!disable_pcr_integrity) {
+		rc = tpm_buf_fill_hmac_session(chip, &buf);
+		if (rc) {
+			tpm2_end_auth_session(chip);
+			return rc;
+		}
+	}
+
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
 	if (!disable_pcr_integrity)
 		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
@@ -261,7 +272,11 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 						| TPM2_SA_CONTINUE_SESSION,
 						NULL, 0);
 		tpm_buf_append_u16(&buf, num_bytes);
-		tpm_buf_fill_hmac_session(chip, &buf);
+
+		err = tpm_buf_fill_hmac_session(chip, &buf);
+		if (err)
+			goto out;
+
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 6d03c224e6b2..82b9d9096fd1 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -141,19 +141,28 @@ struct tpm2_auth {
 };
 
 #ifdef CONFIG_TCG_TPM2_HMAC
+
 /*
- * Name Size based on TPM algorithm (assumes no hash bigger than 255)
+ * Calculate size of the TPMT_HA payload of TPM2B_NAME.
  */
-static u8 name_size(const u8 *name)
+static int tpm2_name_size(const u8 *name)
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
+	case TPM_ALG_SM3_256:
+		return SM3256_DIGEST_SIZE + 2;
+	}
+
+	return -EINVAL;
 }
 
 static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
@@ -161,6 +170,7 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 	struct tpm_header *head = (struct tpm_header *)buf->data;
 	off_t offset = TPM_HEADER_SIZE;
 	u32 tot_len = be32_to_cpu(head->length);
+	int name_size_alg;
 	u32 val;
 
 	/* we're starting after the header so adjust the length */
@@ -172,9 +182,15 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 		return -EINVAL;
 	offset += val;
 	/* name */
+
 	val = tpm_buf_read_u16(buf, &offset);
-	if (val != name_size(&buf->data[offset]))
+	name_size_alg = tpm2_name_size(&buf->data[offset]);
+	if (name_size_alg < 0)
+		return name_size_alg;
+
+	if (val != name_size_alg)
 		return -EINVAL;
+
 	memcpy(name, &buf->data[offset], val);
 	/* forget the rest */
 	return 0;
@@ -222,46 +238,59 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
  * will be caused by an incorrect programming model and indicated by a
  * kernel message.
  */
-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u32 handle, u8 *name)
+int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			u32 handle, u8 *name)
 {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
 	struct tpm2_auth *auth;
+	int name_size;
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
+		return -ENOMEM;
 	}
 	auth = chip->auth;
-	WARN(auth->session != tpm_buf_length(buf),
-	     "name added in wrong place\n");
+	if (auth->session != tpm_buf_length(buf)) {
+		dev_err(&chip->dev, "session state malformed");
+		return -EIO;
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
+				return tpm_ret_to_err(ret);
+		}
 	} else {
 		if (name)
-			dev_err(&chip->dev, "TPM: Handle does not require name but one is specified\n");
+			return -EINVAL;
 	}
 
 	auth->name_h[slot] = handle;
-	if (name)
-		memcpy(auth->name[slot], name, name_size(name));
+	if (name) {
+		name_size = tpm2_name_size(name);
+		if (name_size < 0)
+			return name_size;
+
+		memcpy(auth->name[slot], name, name_size);
+	}
 #endif
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
@@ -537,7 +566,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
  * will be caused by an incorrect programming model and indicated by a
  * kernel message.
  */
-void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
+int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 {
 	u32 cc, handles, val;
 	struct tpm2_auth *auth = chip->auth;
@@ -549,9 +578,10 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	u8 cphash[SHA256_DIGEST_SIZE];
 	struct sha256_ctx sctx;
 	struct hmac_sha256_ctx hctx;
+	int name_size;
 
 	if (!auth)
-		return;
+		return -EINVAL;
 
 	/* save the command code in BE format */
 	auth->ordinal = head->ordinal;
@@ -559,10 +589,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	cc = be32_to_cpu(head->ordinal);
 
 	i = tpm2_find_cc(chip, cc);
-	if (i < 0) {
-		dev_err(&chip->dev, "Command 0x%x not found in TPM\n", cc);
-		return;
-	}
+	if (i < 0)
+		return -EINVAL;
+
 	attrs = chip->cc_attrs_tbl[i];
 
 	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
@@ -576,9 +605,8 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		u32 handle = tpm_buf_read_u32(buf, &offset_s);
 
 		if (auth->name_h[i] != handle) {
-			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
-				  i);
-			return;
+			dev_err(&chip->dev, "invalid handle 0x%08x\n", handle);
+			return -EINVAL;
 		}
 	}
 	/* point offset_s to the start of the sessions */
@@ -609,12 +637,12 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		offset_s += len;
 	}
 	if (offset_s != offset_p) {
-		dev_err(&chip->dev, "TPM session length is incorrect\n");
-		return;
+		dev_err(&chip->dev, "session length is incorrect\n");
+		return -EINVAL;
 	}
 	if (!hmac) {
-		dev_err(&chip->dev, "TPM could not find HMAC session\n");
-		return;
+		dev_err(&chip->dev, "could not find HMAC session\n");
+		return -EINVAL;
 	}
 
 	/* encrypt before HMAC */
@@ -646,8 +674,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		if (mso == TPM2_MSO_PERSISTENT ||
 		    mso == TPM2_MSO_VOLATILE ||
 		    mso == TPM2_MSO_NVRAM) {
-			sha256_update(&sctx, auth->name[i],
-				      name_size(auth->name[i]));
+			name_size = tpm2_name_size(auth->name[i]);
+			if (name_size < 0)
+				return name_size;
+
+			sha256_update(&sctx, auth->name[i], name_size);
 		} else {
 			__be32 h = cpu_to_be32(auth->name_h[i]);
 
@@ -668,6 +699,7 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	hmac_sha256_update(&hctx, auth->tpm_nonce, sizeof(auth->tpm_nonce));
 	hmac_sha256_update(&hctx, &auth->attrs, 1);
 	hmac_sha256_final(&hctx, hmac);
+	return 0;
 }
 EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0e9e043f728c..f168c547abae 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -413,6 +413,7 @@ enum tpm2_session_attributes {
 struct tpm2_hash {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
+	unsigned int hash_size;
 };
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
@@ -528,8 +529,8 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 #endif
 }
 
-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u32 handle, u8 *name);
+int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			u32 handle, u8 *name);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -562,7 +563,7 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 #ifdef CONFIG_TCG_TPM2_HMAC
 
 int tpm2_start_auth_session(struct tpm_chip *chip);
-void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
+int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
 void tpm2_end_auth_session(struct tpm_chip *chip);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index e165b117bbca..33544b6bc105 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -283,7 +283,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out_put;
 	}
 
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		tpm2_end_auth_session(chip);
+		goto out_put;
+	}
+
 	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
 				    options->keyauth, TPM_DIGEST_SIZE);
 
@@ -331,7 +337,12 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
+	rc = tpm_buf_fill_hmac_session(chip, &buf);
+	if (rc) {
+		tpm2_end_auth_session(chip);
+		goto out;
+	}
+
 	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 	if (rc)
@@ -438,7 +449,12 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc) {
+		tpm2_end_auth_session(chip);
+		return rc;
+	}
+
 	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
 				    TPM_DIGEST_SIZE);
 
@@ -450,7 +466,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
@@ -497,7 +516,11 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc) {
+		tpm2_end_auth_session(chip);
+		return rc;
+	}
 
 	if (!options->policyhandle) {
 		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
@@ -522,7 +545,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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


