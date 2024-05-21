Return-Path: <linux-integrity+bounces-2493-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A881F8CA6C4
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 05:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C0B1F21A3F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 03:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1751BF47;
	Tue, 21 May 2024 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oilhY33F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86E25634;
	Tue, 21 May 2024 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261429; cv=none; b=eOB/G1kr7OO3ZTcLE0zineeWHuMBbMGdNCSXFX15YvpH80niVYqzSuO+BGaAraseKjLhdJdQal60IcGDtJV/+xaupUjyK5q5DpMMuegb+bYohdClCgY5+ykCym+65pQG3b9cygJE/iil4ScES/Y1mHegeUoY0F6yH90+BuMrE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261429; c=relaxed/simple;
	bh=jec1TbJ+akbpJqkAQc6Azv309XlSmxotrVc7+fbbuXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t16V5YeOS8cg/yWdNBRQmqxJp8qQdGXi3X8U8jlq+dvd0qX205WFThE/r/80OVkInrU9CdRQ8Dwhu/ZuReYojlMritPDWZcBxLAqFcTwaELOnV1DCGMVS5pfuKLlnrSgZw+1laWdIh4qkXkpUho2wATQnTIDu6XY4bpI5aRPXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oilhY33F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519BDC2BD10;
	Tue, 21 May 2024 03:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716261428;
	bh=jec1TbJ+akbpJqkAQc6Azv309XlSmxotrVc7+fbbuXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oilhY33FFXb+C+i5c31ceEevAOIRz1Cqa1PM2if0um6uCG+Z7Q6RO0I7lk7YH7lfL
	 dJkaKM39368DN8fkkMzGZqFaSX2c84Mi71/kar5txrHYvoCYYKLEz/bYXvIBaZbQwU
	 lh4/WY7NcXIffTudKvX5yW/DoesW4adc5rLQ6sfNHIp8DWCQtezuz9Op0rpZNLXDRQ
	 hSDjYVYA0eBIYUlcxzdx75xQrs6lx6FP1UR3vZGSqR08UMBHKsg0w3E18dG547uhBY
	 FyqeF99PhyLZrdMBm+aSfeAZa6I7m+v+WhxWPw664G0ytAfwvC3D3Fep1OmprfTnTO
	 gsxskQWCkZd1g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
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
Subject: [PATCH v2 3/6] tpm: Export tpm2_load_context()
Date: Tue, 21 May 2024 06:16:28 +0300
Message-ID: <20240521031645.17008-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521031645.17008-1-jarkko@kernel.org>
References: <20240521031645.17008-1-jarkko@kernel.org>
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


