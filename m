Return-Path: <linux-integrity+bounces-2279-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BE68B63B5
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C181F22AFE
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862B16ABC8;
	Mon, 29 Apr 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rNno/PUx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACA168B11;
	Mon, 29 Apr 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422703; cv=none; b=qW8S7ocG9fLxgIFMKWa0CjNNS+OLjirNGJSB8ENVGEbm6DCAL3XAJgaW+lEjM+PWg0dizuUUy3saSlwuUCw/R2o/0OWxKIEaACgam+eAaXp6qr7EjC69PJvgZrGirb3l+zXlB9JxkX7jZ/l89kIB2Bj0UfDyHqPrrbqbZQUjv8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422703; c=relaxed/simple;
	bh=TCTQawSlwHMAHRI35VJYzOZgu+nzZlAXwDrbDxmmq7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLnYz9QwHw1Na4cXdqyzOr+ZjN9sM3UdaENC4T0sa6xLHMHjSL/dKuqjMdMmyfonPv+65rGeSb9VUu5RSvaoxmzscvnSITRBYWiXfAFlK7Cye08fzbPTSvsh3BUsmv7dP/eyTvQnbMAJrIMyuqhELz33U4WIasVSwTvZ06cSLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rNno/PUx; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422701;
	bh=TCTQawSlwHMAHRI35VJYzOZgu+nzZlAXwDrbDxmmq7E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=rNno/PUxIWfPvYods1pgxlxPD+pMoTcTPicBGuh7L9qlbjBChJmVZXDrjZgV5ywxd
	 whp+/6WgqRYBrbCNbzE19WIVZygntgVz+YxZNrIss6X6ZKT85a1f2wtgYejggmW4b/
	 AxuGr96utWdhoRoj/IQPWVrot9UuP2V5/F/M9WCc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3A7C61281D87;
	Mon, 29 Apr 2024 16:31:41 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hgPZm-lGzbaI; Mon, 29 Apr 2024 16:31:41 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4927A1280AB2;
	Mon, 29 Apr 2024 16:31:40 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 22/22] tpm: disable the TPM if NULL name changes
Date: Mon, 29 Apr 2024 16:28:11 -0400
Message-Id: <20240429202811.13643-23-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update tpm2_load_context() to return -EINVAL on integrity failures and
use this as a signal when loading the NULL context that something
might be wrong.  If the signal fails, check the name of the NULL
primary against the one stored in the chip data and if there is a
mismatch disable the TPM because it is likely to have suffered a reset
attack.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-chip.c      |  3 ++
 drivers/char/tpm/tpm2-sessions.c | 77 +++++++++++++++++++++++++-------
 drivers/char/tpm/tpm2-space.c    |  3 ++
 include/linux/tpm.h              |  4 +-
 4 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index d93937326b2e..854546000c92 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -158,6 +158,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 {
 	int rc = -EIO;
 
+	if (chip->flags & TPM_CHIP_FLAG_DISABLE)
+		return rc;
+
 	get_device(&chip->dev);
 
 	down_read(&chip->ops_sem);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3c97d3d5e00e..98819c9a0913 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -80,6 +80,9 @@
 /* maximum number of names the TPM must remember for authorization */
 #define AUTH_MAX_NAMES	3
 
+static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
+			       u32 *handle, u8 *name);
+
 /*
  * This is the structure that carries all the auth information (like
  * session handle, nonces, session key and auth) from use to use it is
@@ -851,6 +854,37 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 	return 0;
 }
 
+static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
+{
+	int rc;
+	unsigned int offset = 0; /* dummy offset for null seed context */
+	u8 name[SHA256_DIGEST_SIZE + 2];
+
+	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
+			       null_key);
+	if (rc != -EINVAL)
+		return rc;
+
+	/* an integrity failure may mean the TPM has been reset */
+	dev_err(&chip->dev, "NULL key integrity failure!\n");
+	/* check the null name against what we know */
+	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
+	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
+		/* name unchanged, assume transient integrity failure */
+		return rc;
+	/*
+	 * Fatal TPM failure: the NULL seed has actually changed, so
+	 * the TPM must have been illegally reset.  All in-kernel TPM
+	 * operations will fail because the NULL primary can't be
+	 * loaded to salt the sessions, but disable the TPM anyway so
+	 * userspace programmes can't be compromised by it.
+	 */
+	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
+	chip->flags |= TPM_CHIP_FLAG_DISABLE;
+
+	return rc;
+}
+
 /**
  * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
  * @chip: the TPM chip structure to create the session with
@@ -868,12 +902,9 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	struct tpm_buf buf;
 	struct tpm2_auth *auth = chip->auth;
 	int rc;
-	/* null seed context has no offset, but we must provide one */
-	unsigned int offset = 0;
-	u32 nullkey;
+	u32 null_key;
 
-	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
-			       &nullkey);
+	rc = tpm2_load_null(chip, &null_key);
 	if (rc)
 		goto out;
 
@@ -884,7 +915,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 		goto out;
 
 	/* salt key handle */
-	tpm_buf_append_u32(&buf, nullkey);
+	tpm_buf_append_u32(&buf, null_key);
 	/* bind key handle */
 	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
 	/* nonce caller */
@@ -908,7 +939,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
-	tpm2_flush_context(chip, nullkey);
+	tpm2_flush_context(chip, null_key);
 
 	if (rc == TPM2_RC_SUCCESS)
 		rc = tpm2_parse_start_auth_session(auth, &buf);
@@ -930,19 +961,25 @@ EXPORT_SYMBOL(tpm2_start_auth_session);
  * @buf:	The response buffer from the chip
  * @handle:	pointer to be filled in with the return handle of the primary
  * @hierarchy:	The hierarchy the primary was created for
+ * @name:	pointer to be filled in with the primary key name
  *
  * @returns: 0 on success or a positive TPM or negative standard error
  */
 static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
-				     u32 *handle, u32 hierarchy)
+				     u32 *handle, u32 hierarchy, u8 *name)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
 	off_t offset_r = TPM_HEADER_SIZE, offset_t;
 	u16 len = TPM_HEADER_SIZE;
 	u32 total_len = be32_to_cpu(head->length);
-	u32 val, param_len;
+	u32 val, param_len, keyhandle;
+
+	keyhandle = tpm_buf_read_u32(buf, &offset_r);
+	if (handle)
+		*handle = keyhandle;
+	else
+		tpm2_flush_context(chip, keyhandle);
 
-	*handle = tpm_buf_read_u32(buf, &offset_r);
 	param_len = tpm_buf_read_u32(buf, &offset_r);
 	/*
 	 * param_len doesn't include the header, but all the other
@@ -955,9 +992,14 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 		return -EINVAL;
 	len = tpm_buf_read_u16(buf, &offset_r);
 	offset_t = offset_r;
-	/* now we have the public area, compute the name of the object */
-	put_unaligned_be16(TPM_ALG_SHA256, chip->null_key_name);
-	sha256(&buf->data[offset_r], len, chip->null_key_name + 2);
+	if (name) {
+		/*
+		 * now we have the public area, compute the name of
+		 * the object
+		 */
+		put_unaligned_be16(TPM_ALG_SHA256, name);
+		sha256(&buf->data[offset_r], len, name + 2);
+	}
 
 	/* validate the public key */
 	val = tpm_buf_read_u16(buf, &offset_t);
@@ -1086,6 +1128,7 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
  * @chip:      the TPM chip to create under
  * @hierarchy: The hierarchy handle to create under
  * @handle:    The returned volatile handle on success
+ * @name:      The name of the returned key
  *
  * For platforms that might not have a persistent primary, this can be
  * used to create one quickly on the fly (it uses Elliptic Curve not
@@ -1097,7 +1140,7 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
  * @returns: 0 on success or positive TPM or negative error.
  */
 static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
-			       u32 *handle)
+			       u32 *handle, u8 *name)
 {
 	int rc;
 	struct tpm_buf buf;
@@ -1187,7 +1230,8 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 			      "attempting to create NULL primary");
 
 	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_create_primary(chip, &buf, handle, hierarchy);
+		rc = tpm2_parse_create_primary(chip, &buf, handle, hierarchy,
+					       name);
 
 	tpm_buf_destroy(&buf);
 
@@ -1199,7 +1243,8 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
 	u32 null_key;
 	int rc;
 
-	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &null_key);
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &null_key,
+				 chip->null_key_name);
 
 	if (rc == TPM2_RC_SUCCESS) {
 		unsigned int offset = 0; /* dummy offset for null key context */
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 24479a81c23c..4892d491da8d 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -105,6 +105,9 @@ int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 		*handle = 0;
 		tpm_buf_destroy(&tbuf);
 		return -ENOENT;
+	} else if (tpm2_rc_value(rc) == TPM2_RC_INTEGRITY) {
+		tpm_buf_destroy(&tbuf);
+		return -EINVAL;
 	} else if (rc > 0) {
 		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
 			 __func__, rc);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dd4d6a6158c4..c17e4efbb2e5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -248,6 +248,7 @@ enum tpm2_return_codes {
 	TPM2_RC_SUCCESS		= 0x0000,
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
+	TPM2_RC_INTEGRITY	= 0x009F,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
@@ -346,6 +347,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
+	TPM_CHIP_FLAG_DISABLE			= BIT(10),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -447,7 +449,7 @@ static inline bool tpm_is_firmware_upgrade(struct tpm_chip *chip)
 
 static inline u32 tpm2_rc_value(u32 rc)
 {
-	return (rc & BIT(7)) ? rc & 0xff : rc;
+	return (rc & BIT(7)) ? rc & 0xbf : rc;
 }
 
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
-- 
2.35.3


