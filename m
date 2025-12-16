Return-Path: <linux-integrity+bounces-8062-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0095CC1C86
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 10:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5367030CEAA1
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387F33B968;
	Tue, 16 Dec 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etg3G4Ex"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1633A038;
	Tue, 16 Dec 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876928; cv=none; b=OiEYCpTfpSJJqzgBAJiXbbcqJLwdgIGgsK9qmmOdcHESP7XhMUVdK5QLPMunU2iW3AJtGxD2sxxoZ5Msi1EfaJ0FdDrc9VhdrhCnvWXVY7jI7YbcNYseNK4h5UE4Q2+T4Fu9NZnNVznobWupRiqiPLhSlfoVRaREBQEs3YK8+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876928; c=relaxed/simple;
	bh=+q63Dykj9CBrFS559Np3GfEfcy21EWR9pv9OV8t+sYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgibkoBb95PB2/uekcqkWEQxKW+O0m0XYpDSyrquD/KUv+IVmFqaoQvLAUhiBZyKja212VLnUZezqpaP+XRo2dUT+rP6EKJmA00B868++jt38qyjbCL71v9cU/0N86edabMfXNk4URbk56fNmwc12tng/a192TwBNovLG0a2SHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etg3G4Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA35C4CEF1;
	Tue, 16 Dec 2025 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876927;
	bh=+q63Dykj9CBrFS559Np3GfEfcy21EWR9pv9OV8t+sYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etg3G4ExSDXxOWFoin/cpKef2QhlRcM2cXQVmWUSBVkMpHIe8HnGj5SrXPW7nxo7F
	 d/pgjK+PlvpWeL3FhXEaxgk1pWahJuukdg+TIDbPqWktqlChUgw1D3V+5Y9OXW3B6T
	 3dQZPqd25ulKFU1BAX9qquhKhr5jMczVujWm+S9CUfVMlwDCXTYnLJ1Jwzl9n8LXty
	 L8cQnCT5cZI70zxPXp/QRinyV+Om9/e3DBDSSX+/sE2IxEtCPu+VdCb7nyOvDGBCRq
	 GmpAK+kHpLNNotMAdQ1Rqz1RaQt1+aNVLklddxhpfd1R76YmuAhdiN4AuDKiN/1TLi
	 rcm6xU0ydDPzg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v8 03/12] tpm: Orchestrate TPM commands in tpm_get_random()
Date: Tue, 16 Dec 2025 11:21:37 +0200
Message-Id: <20251216092147.2326606-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216092147.2326606-1-jarkko@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm1_get_random() and tpm2_get_random() contain duplicate orchestration
code. Consolidate orchestration to tpm_get_random().

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-interface.c | 175 +++++++++++++++++++++++++++++--
 drivers/char/tpm/tpm.h           |   2 -
 drivers/char/tpm/tpm1-cmd.c      |  69 ------------
 drivers/char/tpm/tpm2-cmd.c      | 104 ------------------
 4 files changed, 164 insertions(+), 186 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f745a098908b..d157be738612 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -26,7 +26,7 @@
 #include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/tpm_eventlog.h>
-
+#include <linux/tpm_command.h>
 #include "tpm.h"
 
 /*
@@ -486,19 +486,153 @@ int tpm_pm_resume(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
+struct tpm1_get_random_out {
+	__be32 rng_data_len;
+	u8 rng_data[TPM_MAX_RNG_DATA];
+} __packed;
+
+static int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+{
+	struct tpm1_get_random_out *resp;
+	struct tpm_buf buf;
+	u32 recd;
+	int rc;
+
+	if (!out || !max || max > TPM_MAX_RNG_DATA)
+		return -EINVAL;
+
+	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GETRANDOM);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, max);
+
+	rc = tpm_transmit_cmd(chip, &buf, sizeof(resp->rng_data_len), "TPM_GetRandom");
+	if (rc) {
+		if (rc > 0)
+			rc = -EIO;
+		goto err;
+	}
+
+	resp = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
+
+	recd = be32_to_cpu(resp->rng_data_len);
+	if (recd > max) {
+		rc = -EIO;
+		goto err;
+	}
+
+	if (buf.length < TPM_HEADER_SIZE + sizeof(resp->rng_data_len) + recd) {
+		rc = -EIO;
+		goto err;
+	}
+
+	memcpy(out, resp->rng_data, recd);
+	tpm_buf_destroy(&buf);
+	return recd;
+
+err:
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
+struct tpm2_get_random_out {
+	__be16 size;
+	u8 buffer[TPM_MAX_RNG_DATA];
+} __packed;
+
+static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+{
+	struct tpm2_get_random_out *resp;
+	struct tpm_header *head;
+	struct tpm_buf buf;
+	off_t offset;
+	u32 recd;
+	int ret;
+
+	if (!out || !max || max > TPM_MAX_RNG_DATA)
+		return -EINVAL;
+
+	ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+	if (ret)
+		return ret;
+
+	if (tpm2_chip_auth(chip)) {
+		tpm_buf_append_hmac_session(chip, &buf,
+					    TPM2_SA_ENCRYPT | TPM2_SA_CONTINUE_SESSION,
+					    NULL, 0);
+	} else  {
+		head = (struct tpm_header *)buf.data;
+		head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+	}
+	tpm_buf_append_u16(&buf, max);
+
+	ret = tpm_buf_fill_hmac_session(chip, &buf);
+	if (ret) {
+		tpm_buf_destroy(&buf);
+		return ret;
+	}
+
+	ret = tpm_transmit_cmd(chip, &buf, offsetof(struct tpm2_get_random_out, buffer),
+			       "TPM2_GetRandom");
+
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		if (ret > 0)
+			ret = -EIO;
+
+		goto out;
+	}
+
+	head = (struct tpm_header *)buf.data;
+	offset = TPM_HEADER_SIZE;
+
+	/* Skip the parameter size field: */
+	if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
+		offset += 4;
+
+	resp = (struct tpm2_get_random_out *)&buf.data[offset];
+	recd = min_t(u32, be16_to_cpu(resp->size), max);
+
+	if (tpm_buf_length(&buf) <
+	    TPM_HEADER_SIZE + offsetof(struct tpm2_get_random_out, buffer) + recd) {
+		ret = -EIO;
+		goto out;
+	}
+
+	memcpy(out, resp->buffer, recd);
+	return recd;
+
+out:
+	tpm2_end_auth_session(chip);
+	tpm_buf_destroy(&buf);
+	return ret;
+}
+
 /**
- * tpm_get_random() - get random bytes from the TPM's RNG
- * @chip:	a &struct tpm_chip instance, %NULL for the default chip
- * @out:	destination buffer for the random bytes
- * @max:	the max number of bytes to write to @out
+ * tpm_get_random() - Get random bytes from the TPM's RNG
+ * @chip:	A &tpm_chip instance. Whenset to %NULL, the default chip is used.
+ * @out:	Destination buffer for the acquired random bytes.
+ * @max:	The maximum number of bytes to write to @out.
+ *
+ * Iterates pulling more bytes from TPM up until all of the @max bytes have been
+ * received.
  *
- * Return: number of random bytes read or a negative error value.
+ * Returns the number of random bytes read on success.
+ * Returns -EINVAL when @out is NULL, or @max is not between zero and
+ * %TPM_MAX_RNG_DATA.
+ * Returns tpm_transmit_cmd() error codes when the TPM command results an
+ * error.
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
+	u32 num_bytes = max;
+	u8 *out_ptr = out;
+	int retries = 5;
+	int total = 0;
 	int rc;
 
-	if (!out || max > TPM_MAX_RNG_DATA)
+	if (!out || !max || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
 	if (!chip)
@@ -508,11 +642,30 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (rc)
 		return rc;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm2_get_random(chip, out, max);
-	else
-		rc = tpm1_get_random(chip, out, max);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		rc = tpm2_start_auth_session(chip);
+		if (rc)
+			return rc;
+	}
+
+	do {
+		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+			rc = tpm2_get_random(chip, out_ptr, num_bytes);
+		else
+			rc = tpm1_get_random(chip, out_ptr, num_bytes);
+
+		if (rc < 0)
+			goto err;
+
+		out_ptr += rc;
+		total += rc;
+		num_bytes -= rc;
+	} while (retries-- && total < max);
+
+	tpm_put_ops(chip);
+	return total ? total : -EIO;
 
+err:
 	tpm_put_ops(chip);
 	return rc;
 }
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 02c07fef41ba..f698d01401de 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -251,7 +251,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length);
-int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
 int tpm1_get_pcr_allocation(struct tpm_chip *chip);
 unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm_pm_suspend(struct device *dev);
@@ -291,7 +290,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests);
-int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
 
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index b49a790f1bd5..0604e11c9778 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -511,75 +511,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-#define TPM_ORD_GET_RANDOM 70
-struct tpm1_get_random_out {
-	__be32 rng_data_len;
-	u8 rng_data[TPM_MAX_RNG_DATA];
-} __packed;
-
-/**
- * tpm1_get_random() - get random bytes from the TPM's RNG
- * @chip:	a &struct tpm_chip instance
- * @dest:	destination buffer for the random bytes
- * @max:	the maximum number of bytes to write to @dest
- *
- * Return:
- * *  number of bytes read
- * * -errno (positive TPM return codes are masked to -EIO)
- */
-int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
-{
-	struct tpm1_get_random_out *out;
-	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
-	struct tpm_buf buf;
-	u32 total = 0;
-	int retries = 5;
-	u32 recd;
-	int rc;
-
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
-	if (rc)
-		return rc;
-
-	do {
-		tpm_buf_append_u32(&buf, num_bytes);
-
-		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
-				      "attempting get random");
-		if (rc) {
-			if (rc > 0)
-				rc = -EIO;
-			goto out;
-		}
-
-		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
-
-		recd = be32_to_cpu(out->rng_data_len);
-		if (recd > num_bytes) {
-			rc = -EFAULT;
-			goto out;
-		}
-
-		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE +
-					   sizeof(out->rng_data_len) + recd) {
-			rc = -EFAULT;
-			goto out;
-		}
-		memcpy(dest, out->rng_data, recd);
-
-		dest += recd;
-		total += recd;
-		num_bytes -= recd;
-
-		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
-	} while (retries-- && total < max);
-
-	rc = total ? (int)total : -EIO;
-out:
-	tpm_buf_destroy(&buf);
-	return rc;
-}
-
 #define TPM_ORD_PCRREAD 21
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 3a77be7ebf4a..34168d5f9c78 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -238,110 +238,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
-struct tpm2_get_random_out {
-	__be16 size;
-	u8 buffer[TPM_MAX_RNG_DATA];
-} __packed;
-
-/**
- * tpm2_get_random() - get random bytes from the TPM RNG
- *
- * @chip:	a &tpm_chip instance
- * @dest:	destination buffer
- * @max:	the max number of random bytes to pull
- *
- * Return:
- *   size of the buffer on success,
- *   -errno otherwise (positive TPM return codes are masked to -EIO)
- */
-int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
-{
-	struct tpm2_get_random_out *out;
-	struct tpm_header *head;
-	struct tpm_buf buf;
-	u32 recd;
-	u32 num_bytes = max;
-	int err;
-	int total = 0;
-	int retries = 5;
-	u8 *dest_ptr = dest;
-	off_t offset;
-
-	if (!num_bytes || max > TPM_MAX_RNG_DATA)
-		return -EINVAL;
-
-	err = tpm2_start_auth_session(chip);
-	if (err)
-		return err;
-
-	err = tpm_buf_init(&buf, 0, 0);
-	if (err) {
-		tpm2_end_auth_session(chip);
-		return err;
-	}
-
-	do {
-		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
-		if (tpm2_chip_auth(chip)) {
-			tpm_buf_append_hmac_session(chip, &buf,
-						    TPM2_SA_ENCRYPT |
-						    TPM2_SA_CONTINUE_SESSION,
-						    NULL, 0);
-		} else  {
-			offset = buf.handles * 4 + TPM_HEADER_SIZE;
-			head = (struct tpm_header *)buf.data;
-			if (tpm_buf_length(&buf) == offset)
-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-		}
-		tpm_buf_append_u16(&buf, num_bytes);
-		err = tpm_buf_fill_hmac_session(chip, &buf);
-		if (err) {
-			tpm_buf_destroy(&buf);
-			return err;
-		}
-
-		err = tpm_transmit_cmd(chip, &buf,
-				       offsetof(struct tpm2_get_random_out,
-						buffer),
-				       "attempting get random");
-		err = tpm_buf_check_hmac_response(chip, &buf, err);
-		if (err) {
-			if (err > 0)
-				err = -EIO;
-			goto out;
-		}
-
-		head = (struct tpm_header *)buf.data;
-		offset = TPM_HEADER_SIZE;
-		/* Skip the parameter size field: */
-		if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
-			offset += 4;
-
-		out = (struct tpm2_get_random_out *)&buf.data[offset];
-		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
-		if (tpm_buf_length(&buf) <
-		    TPM_HEADER_SIZE +
-		    offsetof(struct tpm2_get_random_out, buffer) +
-		    recd) {
-			err = -EFAULT;
-			goto out;
-		}
-		memcpy(dest_ptr, out->buffer, recd);
-
-		dest_ptr += recd;
-		total += recd;
-		num_bytes -= recd;
-	} while (retries-- && total < max);
-
-	tpm_buf_destroy(&buf);
-
-	return total ? total : -EIO;
-out:
-	tpm_buf_destroy(&buf);
-	tpm2_end_auth_session(chip);
-	return err;
-}
-
 /**
  * tpm2_flush_context() - execute a TPM2_FlushContext command
  * @chip:	TPM chip to use
-- 
2.39.5


