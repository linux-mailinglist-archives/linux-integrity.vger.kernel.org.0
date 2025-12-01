Return-Path: <linux-integrity+bounces-7754-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C734C996A8
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7F73A3EC9
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 22:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F914296BB5;
	Mon,  1 Dec 2025 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHDqfJoj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7F288502;
	Mon,  1 Dec 2025 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629170; cv=none; b=o+YmbXI3/2AjrneW2MDoDDayvNs19RefAVZiLeK8lzxPI0FCn/RcjRS9ITdqtncpa/mxcp//EWVB7/dv6GPo1mupC1mNdWRA5BS/03Jh5XbPternzGYWTbtjqCZ7rcoPsieaJEL0pWC9uSD/4UsoJwGFBdBdfPTuukNfK7NRSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629170; c=relaxed/simple;
	bh=ULXvr0OMzMzOdoI2/7vLfxzyN6IdbbjfJXPpGcfVgAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlBZ/IahsJQ09RbyRFSOMlKwljiH4AkVDpTsxOG0bbC+nGGeGxxcT8cbwX8OP4uEcfAM5UXpuFgeIdigzXDogAJxHkMDdTBEhDu8+WBCdoMggpcxiPUx7j35k1klQhv0mvNKGQjym8xT/Uc5t+PbaUETV7fVFlpgYTsTJkRu89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHDqfJoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275E3C4CEF1;
	Mon,  1 Dec 2025 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629169;
	bh=ULXvr0OMzMzOdoI2/7vLfxzyN6IdbbjfJXPpGcfVgAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHDqfJojs8d0ufPk46Jtxcp5G1UVRWaElwh3amDfrXy/SJEXLqZ7SiFN4K/yw/L6h
	 o80TBWm8adWascd/+1Jc5cb0Zo6kxK9Kw1sUaqB+2RzVWqYS+c02+O8+UEXgnMSHzB
	 JfalCXRSHYp0Soa08ji3LaQOplcWn3TxRD+nNSmUHB0vk4gD0ow+kkKQ1Fad2dSJ6D
	 e28kGhaDpC8W3raD4vxWnF0IFTzbTme3FvHyD7+TS/AZwVCW+T1+SVlrw/M2XsWUGz
	 KJ1vuKPQvzonl5pdnV4zey4ec4GXkbBO8CWnZH+iXpIJ0Gnm9T88lpT4S40g8Plx8v
	 7DfWobAqoyqeQ==
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
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH 1/4] tpm2-sessions: address out-of-range indexing
Date: Tue,  2 Dec 2025 00:45:49 +0200
Message-ID: <20251201224554.1717104-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201224554.1717104-1-jarkko@kernel.org>
References: <20251201224554.1717104-1-jarkko@kernel.org>
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
---
 drivers/char/tpm/tpm2-cmd.c               |  23 +++-
 drivers/char/tpm/tpm2-sessions.c          | 131 +++++++++++++++-------
 include/linux/tpm.h                       |   6 +-
 security/keys/trusted-keys/trusted_tpm2.c |  29 ++++-
 4 files changed, 136 insertions(+), 53 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5b6ccf901623..4473b81122e8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -187,7 +187,11 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
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
@@ -202,8 +206,14 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
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
@@ -261,7 +271,12 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
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
index 6d03c224e6b2..33ad0d668e1a 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -144,16 +144,24 @@ struct tpm2_auth {
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
+	case TPM_ALG_SM3_256:
+		return SM3256_DIGEST_SIZE + 2;
+	}
+
+	return -EINVAL;
 }
 
 static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
@@ -161,6 +169,7 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 	struct tpm_header *head = (struct tpm_header *)buf->data;
 	off_t offset = TPM_HEADER_SIZE;
 	u32 tot_len = be32_to_cpu(head->length);
+	int ret;
 	u32 val;
 
 	/* we're starting after the header so adjust the length */
@@ -172,9 +181,15 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
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
@@ -221,46 +236,70 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
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
@@ -533,11 +572,9 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
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
@@ -549,9 +586,12 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	u8 cphash[SHA256_DIGEST_SIZE];
 	struct sha256_ctx sctx;
 	struct hmac_sha256_ctx hctx;
+	int ret;
 
-	if (!auth)
-		return;
+	if (!auth) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	/* save the command code in BE format */
 	auth->ordinal = head->ordinal;
@@ -560,9 +600,10 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 
 	i = tpm2_find_cc(chip, cc);
 	if (i < 0) {
-		dev_err(&chip->dev, "Command 0x%x not found in TPM\n", cc);
-		return;
+		ret = -EINVAL;
+		goto err;
 	}
+
 	attrs = chip->cc_attrs_tbl[i];
 
 	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
@@ -576,9 +617,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		u32 handle = tpm_buf_read_u32(buf, &offset_s);
 
 		if (auth->name_h[i] != handle) {
-			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
-				  i);
-			return;
+			dev_err(&chip->dev, "invalid handle 0x%08x\n", handle);
+			ret = -EINVAL;
+			goto err;
 		}
 	}
 	/* point offset_s to the start of the sessions */
@@ -609,12 +650,14 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 		offset_s += len;
 	}
 	if (offset_s != offset_p) {
-		dev_err(&chip->dev, "TPM session length is incorrect\n");
-		return;
+		dev_err(&chip->dev, "session length is incorrect\n");
+		ret = -EINVAL;
+		goto err;
 	}
 	if (!hmac) {
-		dev_err(&chip->dev, "TPM could not find HMAC session\n");
-		return;
+		dev_err(&chip->dev, "could not find HMAC session\n");
+		ret = -EINVAL;
+		goto err;
 	}
 
 	/* encrypt before HMAC */
@@ -646,8 +689,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
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
 
@@ -668,6 +714,11 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
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
index 0e9e043f728c..1a59f0190eb3 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -528,8 +528,8 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 #endif
 }
 
-void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u32 handle, u8 *name);
+int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
+			u32 handle, u8 *name);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -562,7 +562,7 @@ static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 #ifdef CONFIG_TCG_TPM2_HMAC
 
 int tpm2_start_auth_session(struct tpm_chip *chip);
-void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
+int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
 void tpm2_end_auth_session(struct tpm_chip *chip);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index e165b117bbca..7672a4376dad 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -283,7 +283,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out_put;
 	}
 
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc)
+		goto out;
+
 	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
 				    options->keyauth, TPM_DIGEST_SIZE);
 
@@ -331,7 +334,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -438,7 +444,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc)
+		goto out;
+
 	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
 				    TPM_DIGEST_SIZE);
 
@@ -450,7 +459,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
@@ -497,7 +509,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	if (rc)
+		goto out;
 
 	if (!options->policyhandle) {
 		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
@@ -522,7 +536,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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


