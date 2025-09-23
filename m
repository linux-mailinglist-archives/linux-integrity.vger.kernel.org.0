Return-Path: <linux-integrity+bounces-7246-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45EB96F30
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 19:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 116F24E2E73
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99944280CF1;
	Tue, 23 Sep 2025 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npKIbs8e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C747280305;
	Tue, 23 Sep 2025 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647339; cv=none; b=Pcq4kh/sYfmB7NCvBWmH70F/+m77yT6upB10RV05EpuFggYhggRsTW4BRNcY+Xp42dqDzICcMkc7vmLBiGA2HtPOVek3xrKPjFTYBJAFOIkLOYJoiOIiaYu6EgpGb+ZGYECJPhXt6PKLZYDNy1rNoa02q3bSlB8UZ7qC635iizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647339; c=relaxed/simple;
	bh=5PG896fZDTaxxHBn4xIGdlCN8+eXXNOqJlmIsNLlG70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OueIwHl2TGkdJ262VsiRlVKhNciZLTbuUAlngU4ZAGNub9pinjeC9MPNYzlxsLNPzhZOHR9fzobVXn49/unlAC69Djzm95zgX8mVTxFi0z0Kd50S4+bxvopXOfj4XLVm2zJaKgyq9/MBCcLBGa/Z0iESBg2CQ6mnyC8CzWXENSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npKIbs8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60F8C116D0;
	Tue, 23 Sep 2025 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647339;
	bh=5PG896fZDTaxxHBn4xIGdlCN8+eXXNOqJlmIsNLlG70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npKIbs8emukbFcnGjF/uhvIftucT/16sOjs/DR5rftO63kxHNlGAfZgkVJ0rghm3M
	 UiKdxZBj2TYTw4Sp3uuVajJ8XQX2YkCrQjoNjWNL5w/poTWS/4tSSIs+Tsvj+Fr8nl
	 rfn9T1Bm4enArY3obtXiAGwpI7yw99xiiV2GCqfeS8qKlU7FhEOyCeVDAcu+Sdexf+
	 rUo8re2M3dLlap7TtRe4joOUkXengSK61/EQ97jVxt3D3kC5e47tNkrRgdhl2fdfTK
	 2JgRqxZyYWx0dp9yXcRc0zEbP6OP3E/u6oNWxJ9b4KNb74umaTXxeAlJrDCNquSOS5
	 NMG36pKrrw2Ow==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
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
Subject: [PATCH v11 3/3] tpm orchestrate tpm_get_random() in the function
Date: Tue, 23 Sep 2025 20:07:44 +0300
Message-Id: <20250923170744.1749132-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923170744.1749132-1-jarkko@kernel.org>
References: <20250923170744.1749132-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

tpm1_get_random() and tpm2_get_random() repeat the same orchestration.
Move the orchestration into tpm_get_random(). This is especially
useful for TPM 1.2 as the code for that does not get exercised a
lot these days.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v11:
- A new patch.
---
 drivers/char/tpm/tpm-interface.c | 32 ++++++++++--
 drivers/char/tpm/tpm.h           |  6 ++-
 drivers/char/tpm/tpm1-cmd.c      | 54 +++++++++-----------
 drivers/char/tpm/tpm2-cmd.c      | 84 ++++++++++++--------------------
 drivers/char/tpm/tpm2-sessions.c |  6 +++
 5 files changed, 90 insertions(+), 92 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b0d5098fb92b..0c6d25cf7cac 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -487,22 +487,44 @@ EXPORT_SYMBOL_GPL(tpm_pm_resume);
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
+	u32 num_bytes = max;
+	u8 *dest_ptr = out;
+	int retries = 5;
+	int total = 0;
 	int rc;
 
 	if (!out || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
+
 	chip = tpm_find_get_ops(chip);
 	if (!chip)
 		return -ENODEV;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm2_get_random(chip, out, max);
-	else
-		rc = tpm1_get_random(chip, out, max);
+	rc = tpm2_start_auth_session(chip);
+	if (rc)
+		return rc;
 
+	do {
+		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+			rc = tpm2_get_random(chip, buf, out, max);
+		else
+			rc = tpm1_get_random(chip, buf, out, max);
+
+		if (rc < 0)
+			break;
+
+		dest_ptr += rc;
+		total += rc;
+		num_bytes -= rc;
+	} while (retries-- && total < max);
+
+	tpm2_end_auth_session(chip);
 	tpm_put_ops(chip);
-	return rc;
+	return total ? total : -EIO;
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index df426e281f88..0dc2397bc55a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -249,7 +249,8 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
-int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
+int tpm1_get_random(struct tpm_chip *chip, struct tpm_buf *buf, u8 *out,
+		    size_t max);
 int tpm1_get_pcr_allocation(struct tpm_chip *chip);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
@@ -290,7 +291,8 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
-int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
+int tpm2_get_random(struct tpm_chip *chip, struct tpm_buf *buf, u8 *dest,
+		    size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index fdb55dab80e1..fa807e0f335c 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -517,6 +517,7 @@ struct tpm1_get_random_out {
 /**
  * tpm1_get_random() - get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance
+ * @buf:	a &tpm_buf instance
  * @dest:	destination buffer for the random bytes
  * @max:	the maximum number of bytes to write to @dest
  *
@@ -524,49 +525,38 @@ struct tpm1_get_random_out {
  * *  number of bytes read
  * * -errno (positive TPM return codes are masked to -EIO)
  */
-int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
+int tpm1_get_random(struct tpm_chip *chip, struct tpm_buf *buf, u8 *dest,
+		    size_t max)
 {
-	u8 buf_data[TPM_BUF_MIN_SIZE];
-	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	struct tpm1_get_random_out *out;
-	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
-	u32 total = 0;
-	int retries = 5;
 	u32 recd;
 	int rc;
 
-	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
-	do {
-		tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
-		tpm_buf_append_u32(buf, num_bytes);
-
-		rc = tpm_transmit_cmd(chip, buf, sizeof(out->rng_data_len),
-				      "attempting get random");
-		if (rc) {
-			if (rc > 0)
-				rc = -EIO;
-			return rc;
-		}
+	if (!max || max > TPM_MAX_RNG_DATA)
+		return -EINVAL;
 
-		out = (struct tpm1_get_random_out *)&buf->data[TPM_HEADER_SIZE];
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
+	tpm_buf_append_u32(buf, max);
 
-		recd = be32_to_cpu(out->rng_data_len);
-		if (recd > num_bytes)
-			return -EFAULT;
+	rc = tpm_transmit_cmd(chip, buf, sizeof(out->rng_data_len),
+			      "attempting get random");
+	if (rc) {
+		if (rc > 0)
+			rc = -EIO;
+		return rc;
+	}
 
-		if (buf->length < TPM_HEADER_SIZE +
-				  sizeof(out->rng_data_len) + recd)
-			return -EFAULT;
+	out = (struct tpm1_get_random_out *)&buf->data[TPM_HEADER_SIZE];
 
-		memcpy(dest, out->rng_data, recd);
+	recd = be32_to_cpu(out->rng_data_len);
+	if (recd > max)
+		return -EFAULT;
 
-		dest += recd;
-		total += recd;
-		num_bytes -= recd;
-	} while (retries-- && total < max);
+	if (buf->length < TPM_HEADER_SIZE + sizeof(out->rng_data_len) + recd)
+		return -EFAULT;
 
-	rc = total ? (int)total : -EIO;
-	return rc;
+	memcpy(dest, out->rng_data, recd);
+	return recd ? recd : -EIO;
 }
 
 #define TPM_ORD_PCRREAD 21
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 320dc6ae6af2..c98873f4bee6 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -217,6 +217,7 @@ struct tpm2_get_random_out {
  * tpm2_get_random() - get random bytes from the TPM RNG
  *
  * @chip:	a &tpm_chip instance
+ * @buf:	a &tpm_buf instance
  * @dest:	destination buffer
  * @max:	the max number of random bytes to pull
  *
@@ -224,73 +225,50 @@ struct tpm2_get_random_out {
  *   size of the buffer on success,
  *   -errno otherwise (positive TPM return codes are masked to -EIO)
  */
-int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
+int tpm2_get_random(struct tpm_chip *chip, struct tpm_buf *buf, u8 *dest,
+		    size_t max)
 {
-	u8 buf_data[TPM_BUF_MIN_SIZE];
-	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	struct tpm2_get_random_out *out;
 	struct tpm_header *head;
 	u32 recd;
-	u32 num_bytes = max;
 	int err;
-	int total = 0;
-	int retries = 5;
-	u8 *dest_ptr = dest;
 	off_t offset;
 
-	if (!num_bytes || max > TPM_MAX_RNG_DATA)
+	if (!max || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm2_start_auth_session(chip);
-	if (err)
+	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+	tpm_buf_append_hmac_session_opt(chip, buf, TPM2_SA_ENCRYPT
+					| TPM2_SA_CONTINUE_SESSION,
+					NULL, 0);
+	tpm_buf_append_u16(buf, max);
+	tpm_buf_fill_hmac_session(chip, buf);
+	err = tpm_transmit_cmd(chip, buf, offsetof(struct tpm2_get_random_out, buffer),
+			       "attempting get random");
+	err = tpm_buf_check_hmac_response(chip, buf, err);
+	if (err) {
+		if (err > 0)
+			err = -EIO;
 		return err;
+	}
 
-	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
-	do {
-		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
-		tpm_buf_append_hmac_session_opt(chip, buf, TPM2_SA_ENCRYPT
-						| TPM2_SA_CONTINUE_SESSION,
-						NULL, 0);
-		tpm_buf_append_u16(buf, num_bytes);
-		tpm_buf_fill_hmac_session(chip, buf);
-		err = tpm_transmit_cmd(chip, buf,
-				       offsetof(struct tpm2_get_random_out,
-						buffer),
-				       "attempting get random");
-		err = tpm_buf_check_hmac_response(chip, buf, err);
-		if (err) {
-			if (err > 0)
-				err = -EIO;
-			goto out;
-		}
-
-		head = (struct tpm_header *)buf->data;
-		offset = TPM_HEADER_SIZE;
-		/* Skip the parameter size field: */
-		if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
-			offset += 4;
-
-		out = (struct tpm2_get_random_out *)&buf->data[offset];
-		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
-		if (tpm_buf_length(buf) <
-		    TPM_HEADER_SIZE +
-		    offsetof(struct tpm2_get_random_out, buffer) +
-		    recd) {
-			err = -EFAULT;
-			goto out;
-		}
-		memcpy(dest_ptr, out->buffer, recd);
+	head = (struct tpm_header *)buf->data;
+	offset = TPM_HEADER_SIZE;
 
-		dest_ptr += recd;
-		total += recd;
-		num_bytes -= recd;
-	} while (retries-- && total < max);
+	/* Skip the parameter size field: */
+	if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
+		offset += 4;
 
-	return total ? total : -EIO;
+	out = (struct tpm2_get_random_out *)&buf->data[offset];
+	recd = min_t(u32, be16_to_cpu(out->size), max);
+	if (tpm_buf_length(buf) <
+	    TPM_HEADER_SIZE +
+	    offsetof(struct tpm2_get_random_out, buffer) +
+	    recd)
+		return -EFAULT;
 
-out:
-	tpm2_end_auth_session(chip);
-	return err;
+	memcpy(dest, out->buffer, recd);
+	return recd ? recd : -EIO;
 }
 
 /**
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index fd0f56e0018b..654b3e326292 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -837,6 +837,9 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
 {
 	struct tpm2_auth *auth = chip->auth;
 
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return;
+
 	if (!auth)
 		return;
 
@@ -927,6 +930,9 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	u32 null_key;
 	int rc;
 
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
+		return 0;
+
 	if (chip->auth) {
 		dev_dbg_once(&chip->dev, "auth session is active\n");
 		return 0;
-- 
2.39.5


