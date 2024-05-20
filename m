Return-Path: <linux-integrity+bounces-2479-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87528CA23C
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 20:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040B51C21866
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C3137C57;
	Mon, 20 May 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DurDf+K6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE21137C2E;
	Mon, 20 May 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230872; cv=none; b=awds8FWu81bBT2OV3TmuBVUVeIUTFDiVZW+VLzJtD4CrVuERxhSysS9q+mdWh1PgrW/5R9hSja5pyOMxJnSBM7oJOhrPAwv37eXKyaKGbZ/kyLT0NW5jumXKvjbbVijGNCuAoOuKptBnfCEVokezdaq1gGWonoLRkSFJ4Khed2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230872; c=relaxed/simple;
	bh=jec1TbJ+akbpJqkAQc6Azv309XlSmxotrVc7+fbbuXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4UztMlM5310feWkKu0xw1zxzXmY3Q23nYPLE7qX8wJL5CG8kFXsr+WB/6F0QII5ObxSXda8Lse5Th/+RyM3CXBWjX1fRquKOmPWhPe8H+JpF48+goI5Tug3p0Lg4/6kLt2XsESjHLiuNpiuTXtID2gjIu/xDt+7INzrSwcs7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DurDf+K6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84613C2BD10;
	Mon, 20 May 2024 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716230871;
	bh=jec1TbJ+akbpJqkAQc6Azv309XlSmxotrVc7+fbbuXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DurDf+K6tI8CwTetvZaUheJ6zrWhdD75ECb9521ETi19cqtDb0UmQkMEOcIn8WIm6
	 LL9E//ffoDKaaA+vXiYobhRX0ad8vx/Oa3Zartdn6PFp5UIrGGMJmIYTJyTsbr5gFU
	 haqKlhs5XtkB1MGw54CwtizMwiYjnNWX1/rZUb+0WqPB7WV3sZsE3Jw7Wfv4YodKTr
	 XnsmG2XgLUwDK8j5RfNp6jz0TburKjLo2HcMgl31cz7ad6C8S/vJKFekSeR5E+f0ee
	 GuyxXAMbPiOpixRVGA1Tr7Z97jdAw4J+w4GLshCcDuWgqEL6S1BmLCMy+BGOOr0V4X
	 U46nLx+bd6bEg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list),
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/6] tpm: Export tpm2_load_context()
Date: Mon, 20 May 2024 21:47:10 +0300
Message-ID: <20240520184727.22038-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520184727.22038-1-jarkko@kernel.org>
References: <20240520184727.22038-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export tpm2_load_context() so that the null key can be loaded as the
parent of a asymmetric TPM2 key.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm.h        |  2 -
 drivers/char/tpm/tpm2-cmd.c   | 77 +++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-space.c | 61 ---------------------------
 include/linux/tpm.h           |  2 +
 4 files changed, 79 insertions(+), 63 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 6b8b9956ba69..c9c67fe84f33 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -314,8 +314,6 @@ int tpm_devs_add(struct tpm_chip *chip);
 void tpm_devs_remove(struct tpm_chip *chip);
 int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 		      unsigned int buf_size, unsigned int *offset);
-int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
-		      unsigned int *offset, u32 *handle);
 
 void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 0cdf892ec2a7..eb07a109e2ba 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -370,6 +370,83 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 }
 EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
+struct tpm2_context {
+	__be64 sequence;
+	__be32 saved_handle;
+	__be32 hierarchy;
+	__be16 blob_size;
+} __packed;
+
+/**
+ * tpm2_load_context() - Load TPM2 object to the TPM memory
+ * @chip:	TPM chip to use
+ * @buf:	Blob containing TPM2 object.
+ * @offset:	Output variable for the offset in @buf reached.
+ * @handle:	Output variable for the handle of the object in TPM memory.
+ *
+ * Load a blob encrypted with TPM from the memory to the TPM chip.
+ *
+ * Return:
+ * - 0 when the blob is successfully loaded to the TPM.
+ * - -EFAULT if the TPM chip itself fails.
+ * - -ENOENT if the TPM object is replayed.
+ * - -EINVAL if the TPM object is corrupted.
+ */
+int tpm2_load_context(struct tpm_chip *chip, const u8 *buf,
+		      unsigned int *offset, u32 *handle)
+{
+	struct tpm_buf tbuf;
+	struct tpm2_context *ctx;
+	unsigned int body_size;
+	int rc;
+
+	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
+	if (rc)
+		return rc;
+
+	ctx = (struct tpm2_context *)&buf[*offset];
+	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
+	tpm_buf_append(&tbuf, &buf[*offset], body_size);
+
+	rc = tpm_transmit_cmd(chip, &tbuf, 4, NULL);
+	if (rc < 0) {
+		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
+			 __func__, rc);
+		tpm_buf_destroy(&tbuf);
+		return -EFAULT;
+	} else if (tpm2_rc_value(rc) == TPM2_RC_HANDLE ||
+		   rc == TPM2_RC_REFERENCE_H0) {
+		/*
+		 * TPM_RC_HANDLE means that the session context can't
+		 * be loaded because of an internal counter mismatch
+		 * that makes the TPM think there might have been a
+		 * replay.  This might happen if the context was saved
+		 * and loaded outside the space.
+		 *
+		 * TPM_RC_REFERENCE_H0 means the session has been
+		 * flushed outside the space
+		 */
+		*handle = 0;
+		tpm_buf_destroy(&tbuf);
+		return -ENOENT;
+	} else if (tpm2_rc_value(rc) == TPM2_RC_INTEGRITY) {
+		tpm_buf_destroy(&tbuf);
+		return -EINVAL;
+	} else if (rc > 0) {
+		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
+			 __func__, rc);
+		tpm_buf_destroy(&tbuf);
+		return -EFAULT;
+	}
+
+	*handle = be32_to_cpup((__be32 *)&tbuf.data[TPM_HEADER_SIZE]);
+	*offset += body_size;
+
+	tpm_buf_destroy(&tbuf);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm2_load_context);
+
 struct tpm2_get_cap_out {
 	u8 more_data;
 	__be32 subcap_id;
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 4892d491da8d..708c6e4d64cd 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -21,13 +21,6 @@ enum tpm2_handle_types {
 	TPM2_HT_TRANSIENT	= 0x80000000,
 };
 
-struct tpm2_context {
-	__be64 sequence;
-	__be32 saved_handle;
-	__be32 hierarchy;
-	__be16 blob_size;
-} __packed;
-
 static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 {
 	int i;
@@ -68,60 +61,6 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 	kfree(space->session_buf);
 }
 
-int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
-		      unsigned int *offset, u32 *handle)
-{
-	struct tpm_buf tbuf;
-	struct tpm2_context *ctx;
-	unsigned int body_size;
-	int rc;
-
-	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
-	if (rc)
-		return rc;
-
-	ctx = (struct tpm2_context *)&buf[*offset];
-	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
-	tpm_buf_append(&tbuf, &buf[*offset], body_size);
-
-	rc = tpm_transmit_cmd(chip, &tbuf, 4, NULL);
-	if (rc < 0) {
-		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
-			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
-	} else if (tpm2_rc_value(rc) == TPM2_RC_HANDLE ||
-		   rc == TPM2_RC_REFERENCE_H0) {
-		/*
-		 * TPM_RC_HANDLE means that the session context can't
-		 * be loaded because of an internal counter mismatch
-		 * that makes the TPM think there might have been a
-		 * replay.  This might happen if the context was saved
-		 * and loaded outside the space.
-		 *
-		 * TPM_RC_REFERENCE_H0 means the session has been
-		 * flushed outside the space
-		 */
-		*handle = 0;
-		tpm_buf_destroy(&tbuf);
-		return -ENOENT;
-	} else if (tpm2_rc_value(rc) == TPM2_RC_INTEGRITY) {
-		tpm_buf_destroy(&tbuf);
-		return -EINVAL;
-	} else if (rc > 0) {
-		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
-			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
-		return -EFAULT;
-	}
-
-	*handle = be32_to_cpup((__be32 *)&tbuf.data[TPM_HEADER_SIZE]);
-	*offset += body_size;
-
-	tpm_buf_destroy(&tbuf);
-	return 0;
-}
-
 int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 		      unsigned int buf_size, unsigned int *offset)
 {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index c17e4efbb2e5..2f25ca07127b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -466,6 +466,8 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
+int tpm2_load_context(struct tpm_chip *chip, const u8 *buf,
+		      unsigned int *offset, u32 *handle);
 
 static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 {
-- 
2.45.1


