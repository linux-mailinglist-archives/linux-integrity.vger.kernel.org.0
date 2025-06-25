Return-Path: <linux-integrity+bounces-6534-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C7AE9039
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 23:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0510169890
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 21:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64E824A049;
	Wed, 25 Jun 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQpAaTq+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D823C4FD;
	Wed, 25 Jun 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887486; cv=none; b=gPKCxQb7wU9uWmglv0py8huasFMRG4KmvSpLJS9UYDV0m9nqKRFW/oyyffnV3t87n/Vb9ce/gSZUSA241v+jMlfEft7sB1bo0jRbcyT/iGFoJuqOS5q2DmLC0jBLN6CUP/Cz4TDSQGqSUX3c/BcVjb47u3uj3Q/lFJu6Y0MS/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887486; c=relaxed/simple;
	bh=c0QgtNTYPMejWrhTIF49QsnpcmLmk/Z1O0zSJUCQpjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=knvsox5Sh5P4ABUIGYR9llV4QRLZWWNGL2nTs4CwC/l2xoMrVhiKcERKPl0ERDvat6zm21dxWFInDfVssw7U7v+RB2CHHI/DCUM52b1sUS/EOFx3nEhlvVae3jN/h+1cQ69T3lMjDaSqUT5fLyIhFrO2UKMiHKEsbRjBue8+QUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQpAaTq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB65C4CEEA;
	Wed, 25 Jun 2025 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750887486;
	bh=c0QgtNTYPMejWrhTIF49QsnpcmLmk/Z1O0zSJUCQpjg=;
	h=From:To:Cc:Subject:Date:From;
	b=cQpAaTq+0GoCyH1KhQMAdi2aI1yP8b4fwimdBzHYRA+LJonD9FsfjBY9ZSQXB7+do
	 P40aRtkM1Ddp0v8+C+RvYlr8ngMfZ+eXUQKsiHlzDT/52+MTbzEcVxj7milT16/OFI
	 kscydg372LFQIwi0hAcKtDJBvUtO7Cz4E0bHkpDaywsmT6kyGfzfOCNZB2WjK/lc3z
	 om8Vgp0GqzBLv2PmGhNXQ8i1IhYmoqmfDypO/3DJYn2Aunc1/3KSw3JOfmlvIQvOIE
	 kLPvDc9cw+5Hfj0ArWvpetZ0Cu/X2pO2BpSQesQ4gG/6Zohtc7hL7CADoYQUrGziaS
	 JBeAUqLn+E/0A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] tpm: Create cleanup class for tpm_buf
Date: Thu, 26 Jun 2025 00:37:56 +0300
Message-Id: <20250625213757.1236570-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Define a cleanup for tpm_buf, which will caused tpm_buf_destroy()
automatically called at the end of a function scope. This will
significantly decrease the likelihood of memory leaks.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm1-cmd.c               | 47 +++++-----------
 drivers/char/tpm/tpm2-cmd.c               | 67 ++++++++---------------
 drivers/char/tpm/tpm2-sessions.c          | 19 ++-----
 drivers/char/tpm/tpm2-space.c             | 15 +----
 drivers/char/tpm/tpm_vtpm_proxy.c         | 11 +---
 include/linux/tpm.h                       |  2 +
 security/keys/trusted-keys/trusted_tpm1.c |  6 +-
 security/keys/trusted-keys/trusted_tpm2.c | 26 +++------
 8 files changed, 59 insertions(+), 134 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cf64c7385105..c7421f3f4187 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -323,7 +323,7 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
  */
 static int tpm1_startup(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
@@ -335,7 +335,6 @@ static int tpm1_startup(struct tpm_chip *chip)
 	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
@@ -463,7 +462,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
@@ -474,7 +473,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
 
 	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, log_msg);
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
@@ -482,7 +480,7 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
@@ -506,7 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 	rc = tpm_transmit_cmd(chip, &buf, min_cap_length, desc);
 	if (!rc)
 		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
@@ -529,9 +526,9 @@ struct tpm1_get_random_out {
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
+	CLASS(tpm_buf, buf)();
 	struct tpm1_get_random_out *out;
 	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
-	struct tpm_buf buf;
 	u32 total = 0;
 	int retries = 5;
 	u32 recd;
@@ -549,22 +546,18 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		if (rc) {
 			if (rc > 0)
 				rc = -EIO;
-			goto out;
+			return rc;
 		}
 
 		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
 
 		recd = be32_to_cpu(out->rng_data_len);
-		if (recd > num_bytes) {
-			rc = -EFAULT;
-			goto out;
-		}
+		if (recd > num_bytes)
+			return -EFAULT;
 
 		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE +
-					   sizeof(out->rng_data_len) + recd) {
-			rc = -EFAULT;
-			goto out;
-		}
+					   sizeof(out->rng_data_len) + recd)
+			return -EFAULT;
 		memcpy(dest, out->rng_data, recd);
 
 		dest += recd;
@@ -575,15 +568,13 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	} while (retries-- && total < max);
 
 	rc = total ? (int)total : -EIO;
-out:
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
 #define TPM_ORD_PCRREAD 21
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
@@ -595,17 +586,12 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE,
 			      "attempting to read a pcr value");
 	if (rc)
-		goto out;
+		return rc;
 
-	if (tpm_buf_length(&buf) < TPM_DIGEST_SIZE) {
-		rc = -EFAULT;
-		goto out;
-	}
+	if (tpm_buf_length(&buf) < TPM_DIGEST_SIZE)
+		return -EFAULT;
 
 	memcpy(res_buf, &buf.data[TPM_HEADER_SIZE], TPM_DIGEST_SIZE);
-
-out:
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
@@ -619,7 +605,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
  */
 static int tpm1_continue_selftest(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
@@ -627,7 +613,6 @@ static int tpm1_continue_selftest(struct tpm_chip *chip)
 		return rc;
 
 	rc = tpm_transmit_cmd(chip, &buf, 0, "continue selftest");
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
@@ -742,7 +727,7 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 {
 	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	unsigned int try;
 	int rc;
 
@@ -782,8 +767,6 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		dev_warn(&chip->dev, "TPM savestate took %dms\n",
 			 try * TPM_TIMEOUT_RETRY);
 
-	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 524d802ede26..8b702c529794 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -165,9 +165,9 @@ struct tpm2_pcr_read_out {
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr)
 {
+	CLASS(tpm_buf, buf)();
 	int i;
 	int rc;
-	struct tpm_buf buf;
 	struct tpm2_pcr_read_out *out;
 	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
 	u16 digest_size;
@@ -216,7 +216,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 
 	memcpy(digest->digest, out->digest, digest_size);
 out:
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
@@ -232,7 +231,7 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 	int i;
 
@@ -271,8 +270,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	if (!disable_pcr_integrity)
 		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 
-	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
@@ -294,9 +291,9 @@ struct tpm2_get_random_out {
  */
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
+	CLASS(tpm_buf, buf)();
 	struct tpm2_get_random_out *out;
 	struct tpm_header *head;
-	struct tpm_buf buf;
 	u32 recd;
 	u32 num_bytes = max;
 	int err;
@@ -358,11 +355,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		num_bytes -= recd;
 	} while (retries-- && total < max);
 
-	tpm_buf_destroy(&buf);
-
 	return total ? total : -EIO;
+
 out:
-	tpm_buf_destroy(&buf);
 	tpm2_end_auth_session(chip);
 	return err;
 }
@@ -374,7 +369,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
  */
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
@@ -387,7 +382,6 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 	tpm_buf_append_u32(&buf, handle);
 
 	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
-	tpm_buf_destroy(&buf);
 }
 EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
@@ -413,8 +407,8 @@ struct tpm2_get_cap_out {
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 			const char *desc)
 {
+	CLASS(tpm_buf, buf)();
 	struct tpm2_get_cap_out *out;
-	struct tpm_buf buf;
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
@@ -438,7 +432,6 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 		else
 			rc = -ENODATA;
 	}
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
@@ -455,7 +448,7 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
  */
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
@@ -463,7 +456,6 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 		return;
 	tpm_buf_append_u16(&buf, shutdown_type);
 	tpm_transmit_cmd(chip, &buf, 0, "stopping the TPM");
-	tpm_buf_destroy(&buf);
 }
 
 /**
@@ -481,7 +473,7 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int full;
 	int rc;
 
@@ -493,7 +485,6 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
 		tpm_buf_append_u8(&buf, full);
 		rc = tpm_transmit_cmd(chip, &buf, 0,
 				      "attempting the self test");
-		tpm_buf_destroy(&buf);
 
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
@@ -518,8 +509,8 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
+	CLASS(tpm_buf, buf)();
 	struct tpm_header *out;
-	struct tpm_buf buf;
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
@@ -535,7 +526,6 @@ int tpm2_probe(struct tpm_chip *chip)
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 			chip->flags |= TPM_CHIP_FLAG_TPM2;
 	}
-	tpm_buf_destroy(&buf);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
@@ -574,8 +564,8 @@ struct tpm2_pcr_selection {
 
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
+	CLASS(tpm_buf, buf)();
 	struct tpm2_pcr_selection pcr_selection;
-	struct tpm_buf buf;
 	void *marker;
 	void *end;
 	void *pcr_select_offset;
@@ -597,7 +587,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 
 	rc = tpm_transmit_cmd(chip, &buf, 9, "get tpm pcr allocation");
 	if (rc)
-		goto out;
+		return rc;
 
 	nr_possible_banks = be32_to_cpup(
 		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
@@ -605,23 +595,20 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	chip->allocated_banks = kcalloc(nr_possible_banks,
 					sizeof(*chip->allocated_banks),
 					GFP_KERNEL);
-	if (!chip->allocated_banks) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!chip->allocated_banks)
+		return -ENOMEM;
 
 	marker = &buf.data[TPM_HEADER_SIZE + 9];
 
 	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
 	end = &buf.data[rsp_len];
 
+	return rc;
 	for (i = 0; i < nr_possible_banks; i++) {
 		pcr_select_offset = marker +
 			offsetof(struct tpm2_pcr_selection, size_of_select);
-		if (pcr_select_offset >= end) {
-			rc = -EFAULT;
-			break;
-		}
+		if (pcr_select_offset >= end)
+			return -EFAULT;
 
 		memcpy(&pcr_selection, marker, sizeof(pcr_selection));
 		hash_alg = be16_to_cpu(pcr_selection.hash_alg);
@@ -633,7 +620,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 
 			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
 			if (rc < 0)
-				break;
+				return rc;
 
 			nr_alloc_banks++;
 		}
@@ -645,15 +632,12 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	}
 
 	chip->nr_allocated_banks = nr_alloc_banks;
-out:
-	tpm_buf_destroy(&buf);
-
-	return rc;
+	return 0;
 }
 
 int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	u32 nr_commands;
 	__be32 *attrs;
 	u32 cc;
@@ -685,15 +669,12 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 	tpm_buf_append_u32(&buf, nr_commands);
 
 	rc = tpm_transmit_cmd(chip, &buf, 9 + 4 * nr_commands, NULL);
-	if (rc) {
-		tpm_buf_destroy(&buf);
+	if (rc)
 		goto out;
-	}
 
 	if (nr_commands !=
 	    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5])) {
 		rc = -EFAULT;
-		tpm_buf_destroy(&buf);
 		goto out;
 	}
 
@@ -711,8 +692,6 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 		}
 	}
 
-	tpm_buf_destroy(&buf);
-
 out:
 	if (rc > 0)
 		rc = -ENODEV;
@@ -733,7 +712,7 @@ EXPORT_SYMBOL_GPL(tpm2_get_cc_attrs_tbl);
 
 static int tpm2_startup(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	dev_info(&chip->dev, "starting up the TPM manually\n");
@@ -743,10 +722,8 @@ static int tpm2_startup(struct tpm_chip *chip)
 		return rc;
 
 	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
-	tpm_buf_destroy(&buf);
 
-	return rc;
+	return tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
 }
 
 /**
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 7b5049b3d476..94af69a66252 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -182,7 +182,7 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 
 static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
@@ -194,8 +194,6 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
 	if (rc == TPM2_RC_SUCCESS)
 		rc = tpm2_parse_read_public(name, &buf);
 
-	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */
@@ -968,8 +966,8 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
  */
 int tpm2_start_auth_session(struct tpm_chip *chip)
 {
+	CLASS(tpm_buf, buf)();
 	struct tpm2_auth *auth;
-	struct tpm_buf buf;
 	u32 null_key;
 	int rc;
 
@@ -1022,8 +1020,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	if (rc == TPM2_RC_SUCCESS)
 		rc = tpm2_parse_start_auth_session(auth, &buf);
 
-	tpm_buf_destroy(&buf);
-
 	if (rc == TPM2_RC_SUCCESS) {
 		chip->auth = auth;
 		return 0;
@@ -1243,19 +1239,17 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 			       u32 *handle, u8 *name)
 {
+	CLASS(tpm_buf, buf)();
+	CLASS(tpm_buf, template)();
 	int rc;
-	struct tpm_buf buf;
-	struct tpm_buf template;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
 	if (rc)
 		return rc;
 
 	rc = tpm_buf_init_sized(&template);
-	if (rc) {
-		tpm_buf_destroy(&buf);
+	if (rc)
 		return rc;
-	}
 
 	/*
 	 * create the template.  Note: in order for userspace to
@@ -1319,7 +1313,6 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 
 	/* the public template */
 	tpm_buf_append(&buf, template.data, template.length);
-	tpm_buf_destroy(&template);
 
 	/* outside info (empty) */
 	tpm_buf_append_u16(&buf, 0);
@@ -1334,8 +1327,6 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 		rc = tpm2_parse_create_primary(chip, &buf, handle, hierarchy,
 					       name);
 
-	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..c549111b60e4 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -71,7 +71,7 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 		      unsigned int *offset, u32 *handle)
 {
-	struct tpm_buf tbuf;
+	CLASS(tpm_buf, tbuf)();
 	struct tpm2_context *ctx;
 	unsigned int body_size;
 	int rc;
@@ -88,7 +88,6 @@ int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
 		return -EFAULT;
 	} else if (tpm2_rc_value(rc) == TPM2_RC_HANDLE ||
 		   rc == TPM2_RC_REFERENCE_H0) {
@@ -103,29 +102,24 @@ int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 		 * flushed outside the space
 		 */
 		*handle = 0;
-		tpm_buf_destroy(&tbuf);
 		return -ENOENT;
 	} else if (tpm2_rc_value(rc) == TPM2_RC_INTEGRITY) {
-		tpm_buf_destroy(&tbuf);
 		return -EINVAL;
 	} else if (rc > 0) {
 		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
 		return -EFAULT;
 	}
 
 	*handle = be32_to_cpup((__be32 *)&tbuf.data[TPM_HEADER_SIZE]);
 	*offset += body_size;
-
-	tpm_buf_destroy(&tbuf);
 	return 0;
 }
 
 int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 		      unsigned int buf_size, unsigned int *offset)
 {
-	struct tpm_buf tbuf;
+	CLASS(tpm_buf, tbuf)();
 	unsigned int body_size;
 	int rc;
 
@@ -139,28 +133,23 @@ int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
 		return -EFAULT;
 	} else if (tpm2_rc_value(rc) == TPM2_RC_REFERENCE_H0) {
-		tpm_buf_destroy(&tbuf);
 		return -ENOENT;
 	} else if (rc) {
 		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
 		return -EFAULT;
 	}
 
 	body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
 	if ((*offset + body_size) > buf_size) {
 		dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
-		tpm_buf_destroy(&tbuf);
 		return -ENOMEM;
 	}
 
 	memcpy(&buf[*offset], &tbuf.data[TPM_HEADER_SIZE], body_size);
 	*offset += body_size;
-	tpm_buf_destroy(&tbuf);
 	return 0;
 }
 
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 0818bb517805..e21cf709481e 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -395,7 +395,7 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
 
 static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	int rc;
 	const struct tpm_header *header;
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
@@ -416,19 +416,14 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
 
-	if (rc < 0) {
-		locality = rc;
-		goto out;
-	}
+	if (rc < 0)
+		return rc;
 
 	header = (const struct tpm_header *)buf.data;
 	rc = be32_to_cpu(header->return_code);
 	if (rc)
 		locality = -1;
 
-out:
-	tpm_buf_destroy(&buf);
-
 	return locality;
 }
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 804fbbe3873d..b39cd7ca7471 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -427,6 +427,8 @@ u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
 void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
 
+DEFINE_CLASS(tpm_buf, struct tpm_buf, tpm_buf_destroy(&_T), (struct tpm_buf) {}, void)
+
 /*
  * Check if TPM device is in the firmware upgrade mode.
  */
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 89c9798d1800..fabd8ee12aee 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -672,7 +672,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 static int key_seal(struct trusted_key_payload *p,
 		    struct trusted_key_options *o)
 {
-	struct tpm_buf tb;
+	CLASS(tpm_buf, tb)();
 	int ret;
 
 	ret = tpm_buf_init(&tb, 0, 0);
@@ -688,7 +688,6 @@ static int key_seal(struct trusted_key_payload *p,
 	if (ret < 0)
 		pr_info("srkseal failed (%d)\n", ret);
 
-	tpm_buf_destroy(&tb);
 	return ret;
 }
 
@@ -698,7 +697,7 @@ static int key_seal(struct trusted_key_payload *p,
 static int key_unseal(struct trusted_key_payload *p,
 		      struct trusted_key_options *o)
 {
-	struct tpm_buf tb;
+	CLASS(tpm_buf, tb)();
 	int ret;
 
 	ret = tpm_buf_init(&tb, 0, 0);
@@ -713,7 +712,6 @@ static int key_unseal(struct trusted_key_payload *p,
 		/* pull migratable flag out of sealed key */
 		p->migratable = p->key[--p->key_len];
 
-	tpm_buf_destroy(&tb);
 	return ret;
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 024be262702f..6d787e2fdc19 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -241,8 +241,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	CLASS(tpm_buf, buf)();
+	CLASS(tpm_buf, sized)();
 	off_t offset = TPM_HEADER_SIZE;
-	struct tpm_buf buf, sized;
 	int blob_len = 0;
 	u32 hash;
 	u32 flags;
@@ -278,7 +279,6 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	rc = tpm_buf_init_sized(&sized);
 	if (rc) {
-		tpm_buf_destroy(&buf);
 		tpm2_end_auth_session(chip);
 		goto out_put;
 	}
@@ -350,9 +350,6 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
 
 out:
-	tpm_buf_destroy(&sized);
-	tpm_buf_destroy(&buf);
-
 	if (rc > 0) {
 		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
 			rc = -EINVAL;
@@ -387,7 +384,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
@@ -466,7 +463,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 out:
 	if (blob != payload->blob)
 		kfree(blob);
-	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
 		rc = -EPERM;
@@ -491,7 +487,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
-	struct tpm_buf buf;
+	CLASS(tpm_buf, buf)();
 	u16 data_len;
 	u8 *data;
 	int rc;
@@ -540,15 +536,11 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	if (!rc) {
 		data_len = be16_to_cpup(
 			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
-		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE) {
-			rc = -EFAULT;
-			goto out;
-		}
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE)
+			return -EFAULT;
 
-		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
-			rc = -EFAULT;
-			goto out;
-		}
+		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len)
+			return -EFAULT;
 		data = &buf.data[TPM_HEADER_SIZE + 6];
 
 		if (payload->old_format) {
@@ -566,8 +558,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		}
 	}
 
-out:
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
-- 
2.39.5


