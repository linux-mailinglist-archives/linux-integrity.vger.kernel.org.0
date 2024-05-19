Return-Path: <linux-integrity+bounces-2460-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF968C9327
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 02:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CABD1C20B4D
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2E11CB8;
	Sun, 19 May 2024 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WND+1bRF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E110A2A;
	Sun, 19 May 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716078402; cv=none; b=KkKMtQJt+AFQ65103KLkqvMSQOAJVX6IDfTGwcWCYfzU+z4IDX2Hq84DaD0Nia1NqfBAJmp4Lu3LVuSedxmdJ/8ZAC3KbZZRalm/leIm7KVmM+FlHkTzbW967KK8L1zcIjxU5yov0QsXUfgJTrgx/FVF6GnXlrL5K5xCQB9b/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716078402; c=relaxed/simple;
	bh=oTDI4GPnHAbi7+pIHO4XaSxp6pYbisRl2egk0kE22ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArG6N/zc1naQDaogBR3qPU64BwbVgSwBhbDkHi1/OrFkpa8DjQnndcPGkKWDOXHFyfczVcjXDnl00fO14KW+HWEgilrryUTDwESvc+jh0ISlVVO5URZEiFz3R03CQ0Boy5WKFNAtBZJPq9Hg6ten4oQaHNfFzjPnuDFdhCymrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WND+1bRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB40C113CC;
	Sun, 19 May 2024 00:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716078401;
	bh=oTDI4GPnHAbi7+pIHO4XaSxp6pYbisRl2egk0kE22ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WND+1bRFoYcBfwgVk5tGdnFw7A6uduZiGlLfaLUAv4yGEbEJtj9BQOzH+0BtXL24E
	 6gu+I//cZP1za6dCYdEA5bNB37Nc1JZN47Pm8kM79jdYVAgI/CVnYt84QDqXBSeCwv
	 exFpJxovII5JEb80A0LSXfL1ibjX49miywSuHV4BVHBldT/JFQWby+/sgTHzU/+j7j
	 JPfH8HjiXg0RgWXnw5RF/hBqavzacX9GL6k2ZRxNICQgCao1Kaxym86l5wsJMFhef3
	 t7D2YjRA0ooP01bCXuC/tyg0UoVC8GTTA1v6agSFTPFIR/Lmgnrnw20Y8xP6WoNqXi
	 3SQh5gdebBbUQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v2 2/5] tpm: export tpm2_load_context()
Date: Sun, 19 May 2024 03:25:37 +0300
Message-ID: <20240519002616.4432-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240519002616.4432-1-jarkko@kernel.org>
References: <20240519002616.4432-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


