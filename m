Return-Path: <linux-integrity+bounces-7301-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F729BAA864
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3B1178E00
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528A250BEC;
	Mon, 29 Sep 2025 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rApo4mDj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2A27F16F;
	Mon, 29 Sep 2025 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175364; cv=none; b=O+0A+fuPi4Lsz13/BrBpmuLGrVfZDi3402qxUTmBxCMV3E3UjrzaVKKUYxMlixE79AGFp4MWTACU0EipvcxQEzxwH3k+kbJEmuD7qp8g5393GfljISQdvso4ZrNcl79eYCqV7grt5iCATbYzXP38/KwVobatqo2CFnXlnDgCVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175364; c=relaxed/simple;
	bh=iabUj9nCYLUEv2DBg/fGF9QBOXZMDZakiZpuPhyebqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLhFsS4qTd12iCU1JrV2AjO55B6RXY+gA35V2KMwn/J80QWnclmb6DjEYYV+oD7IpZ1u+/0YFulyW5q99NKVS7LURlh9os4JlGF/2TXZZr+mJs6v6OpO2K1HlJ6BuI3sFkgMJQAomcSiC5nXXsInFMA3rmTq/BInd9K/x4CMPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rApo4mDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B0C4CEF4;
	Mon, 29 Sep 2025 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759175363;
	bh=iabUj9nCYLUEv2DBg/fGF9QBOXZMDZakiZpuPhyebqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rApo4mDjPKsdQXSeGe+0zEYBvOqopa0su1NNWuWuPQe3QLvEUhNY0ZDrdaLBHdUyT
	 H/TY9JWQSfobOCqaRsWToB2lmJINIEe6HJzQb5Sd3sFCyfhMxxfQ2QKgriiClH71zI
	 xvXa0arvk+VnnwwVBxfOodhPGX67iCP13wedv/4Y+APddGREHN5IsNGLKAmmaKGhYo
	 Wg36hwRYlZ1fRkFc1axDwK1anIDyTbYlgD9fFID6e1a7blqbGdRku2TFJwDH897h/d
	 0HbVBwWVdqsXuV/sEbqBvEnrLOzmW1v84FkIidcIyVuGSF6q5KRBdZIo/V6Id1THWQ
	 B/dloQtYej7JQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 09/10] tpm-buf: Build PCR extend commands
Date: Mon, 29 Sep 2025 22:48:31 +0300
Message-Id: <20250929194832.2913286-10-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929194832.2913286-1-jarkko@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Build and append TPM_ORD_EXTEND and TPM2_CC_PCR_EXTEND command bodies
with the two new functions:

1. tpm1_buf_append_extend()
2. tpm2_buf_append_pcr_extend()

These changes make the fallback more informative of the situation, as the
underlying programming error is catched at the call site, instead of
masking it as a tpm_transmit() failure.

Further, decoupling the build of the command bodies for extending PCRs
will be mandatory for the Trenchboot early boot code.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v3:
- No changes.
v2:
- A new patch.
---
 drivers/char/tpm/tpm-buf.c  | 67 +++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm1-cmd.c | 15 +++++----
 drivers/char/tpm/tpm2-cmd.c | 13 ++++---
 include/linux/tpm.h         |  4 +++
 include/linux/tpm_command.h |  5 +--
 5 files changed, 88 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 1b9dee0d0681..c9e6e5d097ca 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -244,4 +244,71 @@ u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
 
+static bool tpm1_buf_is_command(struct tpm_buf *buf, u32 ordinal)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return !(buf->flags & TPM_BUF_TPM2B) &&
+	       be16_to_cpu(head->tag) == TPM_TAG_RQU_COMMAND &&
+	       be32_to_cpu(head->ordinal) == ordinal;
+}
+
+/**
+ * tpm1_buf_append_extend() - Append command body for TPM_Extend
+ * @buf:	&tpm_buf instance
+ * @pcr_idx:	index of the PCR
+ * @hash:	SHA1 hash
+ */
+void tpm1_buf_append_extend(struct tpm_buf *buf, u32 pcr_idx, const u8 *hash)
+{
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
+	if (!tpm1_buf_is_command(buf, TPM_ORD_EXTEND)) {
+		WARN(1, "tpm_buf: invalid TPM_Extend command\n");
+		buf->flags |= TPM_BUF_INVALID;
+		return;
+	}
+
+	tpm_buf_append_u32(buf, pcr_idx);
+	tpm_buf_append(buf, hash, TPM_DIGEST_SIZE);
+}
+
+static bool tpm2_buf_is_command(struct tpm_buf *buf, u32 ordinal)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u16 tag = be16_to_cpu(head->tag);
+
+	return !(buf->flags & TPM_BUF_TPM2B) &&
+	       (tag == TPM2_ST_SESSIONS || tag == TPM2_ST_NO_SESSIONS) &&
+	       be32_to_cpu(head->ordinal) == ordinal;
+}
+
+/**
+ * tpm2_buf_append_pcr_extend() - Append command body for TPM2_PCR_Extend
+ * @buf:	&tpm_buf instance
+ * @digests:	list of PCR digests
+ * @banks:	PCR bank descriptors
+ * @nr_banks:	number of PCR banks
+ */
+void tpm2_buf_append_pcr_extend(struct tpm_buf *buf, struct tpm_digest *digests,
+				struct tpm_bank_info *banks,
+				unsigned int nr_banks)
+{
+	int i;
 
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
+	if (!tpm2_buf_is_command(buf, TPM2_CC_PCR_EXTEND)) {
+		WARN(1, "tpm_buf: invalid TPM2_PCR_Extend command\n");
+		buf->flags |= TPM_BUF_INVALID;
+		return;
+	}
+
+	tpm_buf_append_u32(buf, nr_banks);
+	for (i = 0; i < nr_banks; i++) {
+		tpm_buf_append_u16(buf, digests[i].alg_id);
+		tpm_buf_append(buf, digests[i].digest, banks[i].digest_size);
+	}
+}
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 5c49bdff33de..4f1af8beeed4 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -18,8 +18,8 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/freezer.h>
+#include <linux/tpm_command.h>
 #include <linux/tpm_eventlog.h>
-
 #include "tpm.h"
 
 #define TPM_MAX_ORDINAL 243
@@ -459,21 +459,23 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 	return 0;
 }
 
-#define TPM_ORD_PCR_EXTEND 20
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
 	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_EXTEND);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, pcr_idx);
-	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
+	tpm1_buf_append_extend(&buf, pcr_idx, hash);
+
+	if (buf.flags & TPM_BUF_INVALID)
+		rc = -EINVAL;
+	else
+		rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, log_msg);
 
-	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, log_msg);
 	tpm_buf_destroy(&buf);
 	return rc;
 }
@@ -511,7 +513,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-#define TPM_ORD_GET_RANDOM 70
 struct tpm1_get_random_out {
 	__be32 rng_data_len;
 	u8 rng_data[TPM_MAX_RNG_DATA];
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index b69ff7266450..d5a22fba32a8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -171,7 +171,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 {
 	struct tpm_buf buf;
 	int rc;
-	int i;
 
 	if (!disable_pcr_integrity) {
 		rc = tpm2_start_auth_session(chip);
@@ -194,12 +193,12 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
-	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
+	tpm2_buf_append_pcr_extend(&buf, digests, chip->allocated_banks,
+				   chip->nr_allocated_banks);
 
-	for (i = 0; i < chip->nr_allocated_banks; i++) {
-		tpm_buf_append_u16(&buf, digests[i].alg_id);
-		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
-			       chip->allocated_banks[i].digest_size);
+	if (buf.flags & TPM_BUF_INVALID) {
+		rc = -EINVAL;
+		goto out;
 	}
 
 	if (!disable_pcr_integrity)
@@ -208,8 +207,8 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	if (!disable_pcr_integrity)
 		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 
+out:
 	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b2d89df70c18..6c7349dce871 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -424,6 +424,10 @@ u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
 void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
+void tpm1_buf_append_extend(struct tpm_buf *buf, u32 pcr_idx, const u8 *hash);
+void tpm2_buf_append_pcr_extend(struct tpm_buf *buf, struct tpm_digest *digests,
+				struct tpm_bank_info *banks,
+				unsigned int nr_banks);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index f5c03e9c3913..02038972a05f 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -16,11 +16,12 @@
 #define TPM_TAG_RSP_AUTH2_COMMAND       198
 
 /* Command Ordinals */
-#define TPM_ORD_GETRANDOM               70
-#define TPM_ORD_OSAP                    11
 #define TPM_ORD_OIAP                    10
+#define TPM_ORD_OSAP                    11
+#define TPM_ORD_EXTEND			20
 #define TPM_ORD_SEAL                    23
 #define TPM_ORD_UNSEAL                  24
+#define TPM_ORD_GET_RANDOM              70
 
 /* Other constants */
 #define SRKHANDLE                       0x40000000
-- 
2.39.5


