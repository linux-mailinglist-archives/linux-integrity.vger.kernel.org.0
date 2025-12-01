Return-Path: <linux-integrity+bounces-7748-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CF7C98616
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Dec 2025 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61B23A30FD
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Dec 2025 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF88334C1A;
	Mon,  1 Dec 2025 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxeHnCxm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5E315D30;
	Mon,  1 Dec 2025 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608155; cv=none; b=Zgsn/sO5plqfPXVx9L4tIXJG330CDWvvJ9hba0+you8SNEeOswp2jN3Bk+s7Dh3sqCvou57b2fEcEcFGgCxG7OMTcZsWNrDsAlmMBKcsOK9NcaRC7oCYyFmu0tQnxPcw31vHgkjIcResEKF9gd8O/T1NweLAmZe2pbJMQ/7vsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608155; c=relaxed/simple;
	bh=EUIjqavuIeUzMiAYONWEg7x6sMK2XPW3egS5wTGSHuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjpmSYaFUhzFFc8fA8zzx6ZSEKoQHqWnayVWRER3TOYqLEflYKU7hMAjyq6o3InxFn154pw4hIPCq8/20E7NkvUFv/gKkpIlIIa98dHA5G5cDMIIxTl1L88+gXGQUhgbukPnnGXYVqHGA+ZEW2n8Z1kFrOGt4Wp8YwGA3xPSaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxeHnCxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7FDC4CEF1;
	Mon,  1 Dec 2025 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764608155;
	bh=EUIjqavuIeUzMiAYONWEg7x6sMK2XPW3egS5wTGSHuA=;
	h=From:To:Cc:Subject:Date:From;
	b=sxeHnCxmrnm586BzJ/MYUZmjS2inD096CbMlpLhPfAfJ3E67Q/rIkdvDWAB05IYRg
	 qwnR0bZOXXaUocwROnUhFGOUrOP/x+p6DXSvGeF4a0pPsZ19TWtjiOZCnS6NN7kGel
	 m6DtSf77P830FOQomLHHpDg3oigDQnyiWVcVF4kE63uI7dzlUt7OQLB/ZSuD8xJzaM
	 h+fnAhIKQrZBtVnf9pF6enT/wmHaoqTBUqPiJEIENzkbhaFNO8vHVweCuMmhSkLVGT
	 KJF2oHhtgBmtOtjBc5UVyMVm1OHsLPOtF7pDnLk5TzdOuw5GJVaAFzszg+gZ9ec5VE
	 YOjoW5Utp7qnA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm2-sessions: Fix tpm2_read_public range checks
Date: Mon,  1 Dec 2025 18:55:45 +0200
Message-ID: <20251201165545.629875-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'tpm2_read_public' has some rudimentary range checks but does not
explicitly check that both fields of TPMT_HA actually fit within the buffer
size limits.

Introduce a new function 'tpm2_resolve_name' to address all the possible
out-of-range issues, and in addition do handle type validation.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c      | 95 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.c | 78 +-------------------------
 include/linux/tpm.h              |  2 +
 3 files changed, 98 insertions(+), 77 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e63254135a74..d51272573004 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -11,8 +11,11 @@
  * used by the kernel internally.
  */
 
+#include "linux/dev_printk.h"
+#include "linux/tpm.h"
 #include "tpm.h"
 #include <crypto/hash_info.h>
+#include <linux/unaligned.h>
 
 static bool disable_pcr_integrity;
 module_param(disable_pcr_integrity, bool, 0444);
@@ -769,3 +772,95 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
 
 	return -1;
 }
+
+/**
+ * tpm2_name_size() - Resolve size of a TPMT_HA instance
+ * @name:	Pointer to TPMT_HA structure extracted from TPM2B_NAME.
+ *
+ * Calculate size of the TPMT_HA payload of TPM2B_NAME. It is used with
+ * transient keys, persistent and NV indexes.
+ *
+ * Returns zero when the hash size was successfully calculated.
+ * Returns -EINVAL when the hash algorithm was not recognized.
+ */
+int tpm2_name_size(const u8 *name)
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
+	case TPM_ALG_SM3_256:
+		return SM3256_DIGEST_SIZE + 2;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * tpm2_resolve_name - Resolve TPM object's name from the public area
+ * @handle:	Persistent, transient or nv handle.
+ *
+ * Returns zero on success.
+ * Returns -EINVAL when handles are not of valid type.
+ * Returns -EIO if the transmission fails or response is malformed.
+ */
+int tpm2_resolve_name(struct tpm_chip *chip, u32 handle, void *name)
+{
+	u32 mso = tpm2_handle_mso(handle);
+	off_t offset = TPM_HEADER_SIZE;
+	int name_size, name_size_2;
+	struct tpm_buf buf;
+	int rc;
+
+	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
+	    mso != TPM2_MSO_NVRAM)
+		return -EINVAL;
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
+	name_size = tpm_buf_read_u16(&buf, &offset);
+	name_size_2 = tpm2_name_size(&buf.data[offset]);
+
+	if (name_size != name_size_2) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	if (offset + name_size > tpm_buf_length(&buf)) {
+		tpm_buf_destroy(&buf);
+		return -EIO;
+	}
+
+	memcpy(name, &buf.data[offset], name_size);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm2_resolve_name);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 82b9d9096fd1..7c85333d47c4 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -140,82 +140,6 @@ struct tpm2_auth {
 	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
 };
 
-#ifdef CONFIG_TCG_TPM2_HMAC
-
-/*
- * Calculate size of the TPMT_HA payload of TPM2B_NAME.
- */
-static int tpm2_name_size(const u8 *name)
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
-	case TPM_ALG_SM3_256:
-		return SM3256_DIGEST_SIZE + 2;
-	}
-
-	return -EINVAL;
-}
-
-static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-	off_t offset = TPM_HEADER_SIZE;
-	u32 tot_len = be32_to_cpu(head->length);
-	int name_size_alg;
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
-
-	val = tpm_buf_read_u16(buf, &offset);
-	name_size_alg = tpm2_name_size(&buf->data[offset]);
-	if (name_size_alg < 0)
-		return name_size_alg;
-
-	if (val != name_size_alg)
-		return -EINVAL;
-
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
-#endif /* CONFIG_TCG_TPM2_HMAC */
-
 /**
  * tpm_buf_append_name() - add a handle area to the buffer
  * @chip: the TPM chip structure
@@ -272,7 +196,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	    mso == TPM2_MSO_VOLATILE ||
 	    mso == TPM2_MSO_NVRAM) {
 		if (!name) {
-			ret = tpm2_read_public(chip, handle, auth->name[slot]);
+			ret = tpm2_resolve_name(chip, handle, auth->name[slot]);
 			if (ret)
 				return tpm_ret_to_err(ret);
 		}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1a59f0190eb3..727e6c26feeb 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -477,6 +477,8 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
+int tpm2_name_size(const u8 *name);
+int tpm2_resolve_name(struct tpm_chip *chip, u32 handle, void *name);
 
 static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 {
-- 
2.52.0


