Return-Path: <linux-integrity+bounces-6576-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A56AEEB1C
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jul 2025 02:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BAAF7AC37A
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jul 2025 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE77DF49;
	Tue,  1 Jul 2025 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGtWK/AW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F3B660;
	Tue,  1 Jul 2025 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751328722; cv=none; b=AiCi4wuozjw9XJoFQVEXbmEmGdAMT256Ozr9himdSfLHeSVO8bZTneteIPTl+tdWWHovenHfsUV0tlUIj/aw3ln0qfNjJI1BB/YezICTTp0NEFsqTBxEZfkYn3XvS8t4EttPJJvBDomVXpjJd22LpFbFUPEMoEllQzl7e7fN8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751328722; c=relaxed/simple;
	bh=6KJOT2RCFsUmbOSG+HJyXBa4FLGr06lcFoY7kVHbJxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GeE2ktwhA1U7eMco/9WtF6hyU2P7ysxCbbXnncxduHdtxAUKKDXIG+wNRjUT5Ue/LvRiQ87u5KwfR8gVttdBsz/2UZV0qB6aUlYTGz5vZCR1HcI7uOmmF7Rc1llXvuN8kLCjAGoTWvaiBEQRU4/Di7P9+/AJctRl/en1Kr+6Z3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGtWK/AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B514FC4CEE3;
	Tue,  1 Jul 2025 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751328721;
	bh=6KJOT2RCFsUmbOSG+HJyXBa4FLGr06lcFoY7kVHbJxI=;
	h=From:To:Cc:Subject:Date:From;
	b=YGtWK/AWF70i6XrI9A5qkkRnDACJ5ecDlCIgfCuGJmN42s4076W/I2lsMilos5xYg
	 BSNOlQQcze0ccbkdP5m795df4504PT20e4oKgMwVExn0USwAVidQHyqkSnlKujX67y
	 hpmH/KBRdKOoWcUoRIyz+Y6NZMs0e5IwphfxrUXaedHf5je6nQwdeL9ipWM7kkZ0rS
	 FHRnMOkHLj/rOgeLwERly3djZTrqyzzcn1U8/ur7ruZDYA0RJJ8JSMUgrV6ri9UcSq
	 1t2LO+RJ6HJvEhdPjWiaw0o6Ll2Lenp7kYwFkOr4Qb7mZFrrzSDPTkvBXwIWez3lFS
	 P/lSBRNVbNZsg==
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
Subject: [PATCH v3] tpm: Repeal and replace tpm_buf_init*() and tpm_buf_destroy()
Date: Tue,  1 Jul 2025 03:11:51 +0300
Message-Id: <20250701001153.769030-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Repeal and replace tpm_buf_init() and tpm_buf_init_sized() with
tpm_buf_alloc(), which returns PAGE_SIZE of memory with the struct tpm_buf
header in the beginning of the returned buffer. This leaves 4088 bytes of
free space for data.

Given that kfree() is now the destructor for struct tpm_buf instances,
tpm_buf_destroy() is obsolete, and can (and should) be wiped off.

The gist of this patch is that now a tpm_buf can be now declared using
__free(kfree) declared in linux/slab.h:

	struct tpm_buf *buf __free(kfree) = NULL;

	/* ... */

	buf = tpm_buf_alloc();

This makes TPM driver and other subsystems using struct tpm_buf more
memory-safe as there is no to worry about freeing up these temporary
scratch buffers.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

v3:
- Removed the cleanup class and moved on using __free(kfree) instead.
- Removed `buf_size` (James).
- I'm open for the idea of splitting still (Jason) but I'll hold
  at least this revision just to check that my core idea here
  is correct.
v2:
- Implement also memory allocation using the cleanup class.
- Rewrote the commit message.
- Implemented CLASS_TPM_BUF() helper macro.
---
 drivers/char/tpm/tpm-buf.c                |  52 ++---
 drivers/char/tpm/tpm-sysfs.c              |  20 +-
 drivers/char/tpm/tpm1-cmd.c               | 150 ++++++------
 drivers/char/tpm/tpm2-cmd.c               | 272 ++++++++++------------
 drivers/char/tpm/tpm2-sessions.c          | 122 +++++-----
 drivers/char/tpm/tpm2-space.c             |  44 ++--
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 ++-
 include/linux/tpm.h                       |  15 +-
 security/keys/trusted-keys/trusted_tpm1.c |  35 +--
 security/keys/trusted-keys/trusted_tpm2.c | 157 ++++++-------
 10 files changed, 414 insertions(+), 483 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index dc882fc9fa9e..e874bb57600c 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -8,23 +8,28 @@
 #include <linux/tpm.h>
 
 /**
- * tpm_buf_init() - Allocate and initialize a TPM command
- * @buf:	A &tpm_buf
- * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
- * @ordinal:	A command ordinal
+ * tpm_buf_alloc() - Allocate a TPM buffer
+ *
+ * Allocates `PAGE_SIZE` of memory and places &tpm_buf to the beginning of the
+ * allocated buffer. For that reason the total capacity can be at most 4088
+ * bytes. If a caller tries to surpass the maximum capacity, `TPM_BUF_OVERFLOW`
+ * will be set and any future operations will be ignored.
  *
- * Return: 0 or -ENOMEM
+ * Return:
+ * * &tpm_buf:	success
+ * * NULL:	out of memory
  */
-int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+struct tpm_buf *tpm_buf_alloc(void)
 {
-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!buf->data)
-		return -ENOMEM;
+	struct tpm_buf *buf;
 
-	tpm_buf_reset(buf, tag, ordinal);
-	return 0;
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	return buf;
 }
-EXPORT_SYMBOL_GPL(tpm_buf_init);
+EXPORT_SYMBOL_GPL(tpm_buf_alloc);
 
 /**
  * tpm_buf_reset() - Initialize a TPM command
@@ -48,23 +53,6 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
-/**
- * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
- * @buf:	A @tpm_buf
- *
- * Return: 0 or -ENOMEM
- */
-int tpm_buf_init_sized(struct tpm_buf *buf)
-{
-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!buf->data)
-		return -ENOMEM;
-
-	tpm_buf_reset_sized(buf);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
-
 /**
  * tpm_buf_reset_sized() - Initialize a sized buffer
  * @buf:	A &tpm_buf
@@ -78,12 +66,6 @@ void tpm_buf_reset_sized(struct tpm_buf *buf)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
 
-void tpm_buf_destroy(struct tpm_buf *buf)
-{
-	free_page((unsigned long)buf->data);
-}
-EXPORT_SYMBOL_GPL(tpm_buf_destroy);
-
 /**
  * tpm_buf_length() - Return the number of bytes consumed by the data
  * @buf:	A &tpm_buf
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..9aaebd8057d4 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -32,28 +32,30 @@ struct tpm_readpubek_out {
 static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct tpm_buf tpm_buf;
+	struct tpm_buf *tpm_buf __free(kfree) = NULL;
 	struct tpm_readpubek_out *out;
 	int i;
 	char *str = buf;
 	struct tpm_chip *chip = to_tpm_chip(dev);
 	char anti_replay[20];
 
+	tpm_buf = tpm_buf_alloc();
+	if (!tpm_buf)
+		return -ENOMEM;
+
 	memset(&anti_replay, 0, sizeof(anti_replay));
 
 	if (tpm_try_get_ops(chip))
 		return 0;
 
-	if (tpm_buf_init(&tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK))
-		goto out_ops;
-
-	tpm_buf_append(&tpm_buf, anti_replay, sizeof(anti_replay));
+	tpm_buf_reset(tpm_buf, TPM_TAG_RQU_COMMAND, TPM_ORD_READPUBEK);
+	tpm_buf_append(tpm_buf, anti_replay, sizeof(anti_replay));
 
-	if (tpm_transmit_cmd(chip, &tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
+	if (tpm_transmit_cmd(chip, tpm_buf, READ_PUBEK_RESULT_MIN_BODY_SIZE,
 			     "attempting to read the PUBEK"))
-		goto out_buf;
+		goto out_ops;
 
-	out = (struct tpm_readpubek_out *)&tpm_buf.data[10];
+	out = (struct tpm_readpubek_out *)&tpm_buf->data[10];
 	str +=
 	    sprintf(str,
 		    "Algorithm: %4ph\n"
@@ -71,8 +73,6 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 	for (i = 0; i < 256; i += 16)
 		str += sprintf(str, "%16ph\n", &out->modulus[i]);
 
-out_buf:
-	tpm_buf_destroy(&tpm_buf);
 out_ops:
 	tpm_put_ops(chip);
 	return str - buf;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index cf64c7385105..974894013287 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -323,19 +323,19 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
  */
 static int tpm1_startup(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 
-	dev_info(&chip->dev, "starting up the TPM manually\n");
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
-	if (rc < 0)
-		return rc;
+	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	tpm_buf_append_u16(&buf, TPM_ST_CLEAR);
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
+	tpm_buf_append_u16(buf, TPM_ST_CLEAR);
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
-	tpm_buf_destroy(&buf);
+	rc = tpm_transmit_cmd(chip, buf, 0, "attempting to start the TPM");
 	return rc;
 }
 
@@ -463,18 +463,18 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 		    const char *log_msg)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	tpm_buf_append_u32(&buf, pcr_idx);
-	tpm_buf_append(&buf, hash, TPM_DIGEST_SIZE);
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_EXTEND);
+	tpm_buf_append_u32(buf, pcr_idx);
+	tpm_buf_append(buf, hash, TPM_DIGEST_SIZE);
 
-	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE, log_msg);
-	tpm_buf_destroy(&buf);
+	rc = tpm_transmit_cmd(chip, buf, TPM_DIGEST_SIZE, log_msg);
 	return rc;
 }
 
@@ -482,31 +482,32 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_CAP);
 
 	if (subcap_id == TPM_CAP_VERSION_1_1 ||
 	    subcap_id == TPM_CAP_VERSION_1_2) {
-		tpm_buf_append_u32(&buf, subcap_id);
-		tpm_buf_append_u32(&buf, 0);
+		tpm_buf_append_u32(buf, subcap_id);
+		tpm_buf_append_u32(buf, 0);
 	} else {
 		if (subcap_id == TPM_CAP_FLAG_PERM ||
 		    subcap_id == TPM_CAP_FLAG_VOL)
-			tpm_buf_append_u32(&buf, TPM_CAP_FLAG);
+			tpm_buf_append_u32(buf, TPM_CAP_FLAG);
 		else
-			tpm_buf_append_u32(&buf, TPM_CAP_PROP);
+			tpm_buf_append_u32(buf, TPM_CAP_PROP);
 
-		tpm_buf_append_u32(&buf, 4);
-		tpm_buf_append_u32(&buf, subcap_id);
+		tpm_buf_append_u32(buf, 4);
+		tpm_buf_append_u32(buf, subcap_id);
 	}
-	rc = tpm_transmit_cmd(chip, &buf, min_cap_length, desc);
+	rc = tpm_transmit_cmd(chip, buf, min_cap_length, desc);
 	if (!rc)
-		*cap = *(cap_t *)&buf.data[TPM_HEADER_SIZE + 4];
-	tpm_buf_destroy(&buf);
+		*cap = *(cap_t *)&buf->data[TPM_HEADER_SIZE + 4];
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
@@ -529,83 +530,76 @@ struct tpm1_get_random_out {
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm1_get_random_out *out;
 	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
-	struct tpm_buf buf;
 	u32 total = 0;
 	int retries = 5;
 	u32 recd;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
 
 	do {
-		tpm_buf_append_u32(&buf, num_bytes);
+		tpm_buf_append_u32(buf, num_bytes);
 
-		rc = tpm_transmit_cmd(chip, &buf, sizeof(out->rng_data_len),
+		rc = tpm_transmit_cmd(chip, buf, sizeof(out->rng_data_len),
 				      "attempting get random");
 		if (rc) {
 			if (rc > 0)
 				rc = -EIO;
-			goto out;
+			return rc;
 		}
 
-		out = (struct tpm1_get_random_out *)&buf.data[TPM_HEADER_SIZE];
+		out = (struct tpm1_get_random_out *)&buf->data[TPM_HEADER_SIZE];
 
 		recd = be32_to_cpu(out->rng_data_len);
-		if (recd > num_bytes) {
-			rc = -EFAULT;
-			goto out;
-		}
+		if (recd > num_bytes)
+			return -EFAULT;
+
+		if (buf->length < TPM_HEADER_SIZE +
+				  sizeof(out->rng_data_len) + recd)
+			return -EFAULT;
 
-		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE +
-					   sizeof(out->rng_data_len) + recd) {
-			rc = -EFAULT;
-			goto out;
-		}
 		memcpy(dest, out->rng_data, recd);
 
 		dest += recd;
 		total += recd;
 		num_bytes -= recd;
 
-		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
+		tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
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
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	tpm_buf_append_u32(&buf, pcr_idx);
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
+	tpm_buf_append_u32(buf, pcr_idx);
 
-	rc = tpm_transmit_cmd(chip, &buf, TPM_DIGEST_SIZE,
+	rc = tpm_transmit_cmd(chip, buf, TPM_DIGEST_SIZE,
 			      "attempting to read a pcr value");
 	if (rc)
-		goto out;
-
-	if (tpm_buf_length(&buf) < TPM_DIGEST_SIZE) {
-		rc = -EFAULT;
-		goto out;
-	}
+		return rc;
 
-	memcpy(res_buf, &buf.data[TPM_HEADER_SIZE], TPM_DIGEST_SIZE);
+	if (buf->length < TPM_DIGEST_SIZE)
+		return -EFAULT;
 
-out:
-	tpm_buf_destroy(&buf);
+	memcpy(res_buf, &buf->data[TPM_HEADER_SIZE], TPM_DIGEST_SIZE);
 	return rc;
 }
 
@@ -619,15 +613,15 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
  */
 static int tpm1_continue_selftest(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "continue selftest");
-	tpm_buf_destroy(&buf);
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_CONTINUE_SELFTEST);
+	rc = tpm_transmit_cmd(chip, buf, 0, "continue selftest");
 	return rc;
 }
 
@@ -741,23 +735,25 @@ int tpm1_auto_startup(struct tpm_chip *chip)
  */
 int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
-	struct tpm_buf buf;
 	unsigned int try;
 	int rc;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
 	/* for buggy tpm, flush pcrs with extend to selected dummy */
 	if (tpm_suspend_pcr)
 		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
 				     "extending dummy pcr before suspend");
 
-	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
-	if (rc)
-		return rc;
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
+
 	/* now do the actual savestate */
 	for (try = 0; try < TPM_RETRY; try++) {
-		rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
+		rc = tpm_transmit_cmd(chip, buf, 0, NULL);
 		/*
 		 * If the TPM indicates that it is too busy to respond to
 		 * this command then retry before giving up.  It can take
@@ -772,7 +768,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 			break;
 		tpm_msleep(TPM_TIMEOUT_RETRY);
 
-		tpm_buf_reset(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
+		tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
 	}
 
 	if (rc)
@@ -782,8 +778,6 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
 		dev_warn(&chip->dev, "TPM savestate took %dms\n",
 			 try * TPM_TIMEOUT_RETRY);
 
-	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 524d802ede26..86b961f4027b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -165,14 +165,18 @@ struct tpm2_pcr_read_out {
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int i;
 	int rc;
-	struct tpm_buf buf;
 	struct tpm2_pcr_read_out *out;
 	u8 pcr_select[TPM2_PCR_SELECT_MIN] = {0};
 	u16 digest_size;
 	u16 expected_digest_size = 0;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	if (pcr_idx >= TPM2_PLATFORM_PCR)
 		return -EINVAL;
 
@@ -187,23 +191,21 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		expected_digest_size = chip->allocated_banks[i].digest_size;
 	}
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
-	if (rc)
-		return rc;
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_PCR_READ);
 
 	pcr_select[pcr_idx >> 3] = 1 << (pcr_idx & 0x7);
 
-	tpm_buf_append_u32(&buf, 1);
-	tpm_buf_append_u16(&buf, digest->alg_id);
-	tpm_buf_append_u8(&buf, TPM2_PCR_SELECT_MIN);
-	tpm_buf_append(&buf, (const unsigned char *)pcr_select,
+	tpm_buf_append_u32(buf, 1);
+	tpm_buf_append_u16(buf, digest->alg_id);
+	tpm_buf_append_u8(buf, TPM2_PCR_SELECT_MIN);
+	tpm_buf_append(buf, (const unsigned char *)pcr_select,
 		       sizeof(pcr_select));
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to read a pcr value");
+	rc = tpm_transmit_cmd(chip, buf, 0, "attempting to read a pcr value");
 	if (rc)
 		goto out;
 
-	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
+	out = (struct tpm2_pcr_read_out *)&buf->data[TPM_HEADER_SIZE];
 	digest_size = be16_to_cpu(out->digest_size);
 	if (digest_size > sizeof(digest->digest) ||
 	    (!digest_size_ptr && digest_size != expected_digest_size)) {
@@ -216,7 +218,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 
 	memcpy(digest->digest, out->digest, digest_size);
 out:
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
@@ -232,46 +233,43 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		    struct tpm_digest *digests)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 	int i;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	if (!disable_pcr_integrity) {
 		rc = tpm2_start_auth_session(chip);
 		if (rc)
 			return rc;
 	}
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
-	if (rc) {
-		if (!disable_pcr_integrity)
-			tpm2_end_auth_session(chip);
-		return rc;
-	}
+	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 
 	if (!disable_pcr_integrity) {
-		tpm_buf_append_name(chip, &buf, pcr_idx, NULL);
-		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
+		tpm_buf_append_name(chip, buf, pcr_idx, NULL);
+		tpm_buf_append_hmac_session(chip, buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
-		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+		tpm_buf_append_handle(chip, buf, pcr_idx);
+		tpm_buf_append_auth(chip, buf, 0, NULL, 0);
 	}
 
-	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
+	tpm_buf_append_u32(buf, chip->nr_allocated_banks);
 
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
-		tpm_buf_append_u16(&buf, digests[i].alg_id);
-		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
+		tpm_buf_append_u16(buf, digests[i].alg_id);
+		tpm_buf_append(buf, (const unsigned char *)&digests[i].digest,
 			       chip->allocated_banks[i].digest_size);
 	}
 
 	if (!disable_pcr_integrity)
-		tpm_buf_fill_hmac_session(chip, &buf);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting extend a PCR value");
+		tpm_buf_fill_hmac_session(chip, buf);
+	rc = tpm_transmit_cmd(chip, buf, 0, "attempting extend a PCR value");
 	if (!disable_pcr_integrity)
-		rc = tpm_buf_check_hmac_response(chip, &buf, rc);
-
-	tpm_buf_destroy(&buf);
+		rc = tpm_buf_check_hmac_response(chip, buf, rc);
 
 	return rc;
 }
@@ -294,9 +292,9 @@ struct tpm2_get_random_out {
  */
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm2_get_random_out *out;
 	struct tpm_header *head;
-	struct tpm_buf buf;
 	u32 recd;
 	u32 num_bytes = max;
 	int err;
@@ -308,43 +306,41 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	err = tpm2_start_auth_session(chip);
 	if (err)
 		return err;
 
-	err = tpm_buf_init(&buf, 0, 0);
-	if (err) {
-		tpm2_end_auth_session(chip);
-		return err;
-	}
-
 	do {
-		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
+		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_hmac_session_opt(chip, buf, TPM2_SA_ENCRYPT
 						| TPM2_SA_CONTINUE_SESSION,
 						NULL, 0);
-		tpm_buf_append_u16(&buf, num_bytes);
-		tpm_buf_fill_hmac_session(chip, &buf);
-		err = tpm_transmit_cmd(chip, &buf,
+		tpm_buf_append_u16(buf, num_bytes);
+		tpm_buf_fill_hmac_session(chip, buf);
+		err = tpm_transmit_cmd(chip, buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       "attempting get random");
-		err = tpm_buf_check_hmac_response(chip, &buf, err);
+		err = tpm_buf_check_hmac_response(chip, buf, err);
 		if (err) {
 			if (err > 0)
 				err = -EIO;
 			goto out;
 		}
 
-		head = (struct tpm_header *)buf.data;
+		head = (struct tpm_header *)buf->data;
 		offset = TPM_HEADER_SIZE;
 		/* Skip the parameter size field: */
 		if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
 			offset += 4;
 
-		out = (struct tpm2_get_random_out *)&buf.data[offset];
+		out = (struct tpm2_get_random_out *)&buf->data[offset];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
-		if (tpm_buf_length(&buf) <
+		if (tpm_buf_length(buf) <
 		    TPM_HEADER_SIZE +
 		    offsetof(struct tpm2_get_random_out, buffer) +
 		    recd) {
@@ -358,11 +354,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
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
@@ -374,20 +368,19 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
  */
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 {
-	struct tpm_buf buf;
-	int rc;
+	struct tpm_buf *buf __free(kfree) = NULL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
-	if (rc) {
+	buf = tpm_buf_alloc();
+	if (!buf) {
 		dev_warn(&chip->dev, "0x%08x was not flushed, out of memory\n",
 			 handle);
 		return;
 	}
 
-	tpm_buf_append_u32(&buf, handle);
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_FLUSH_CONTEXT);
+	tpm_buf_append_u32(buf, handle);
 
-	tpm_transmit_cmd(chip, &buf, 0, "flushing context");
-	tpm_buf_destroy(&buf);
+	tpm_transmit_cmd(chip, buf, 0, "flushing context");
 }
 EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
@@ -413,20 +406,22 @@ struct tpm2_get_cap_out {
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 			const char *desc)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm2_get_cap_out *out;
-	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		return rc;
-	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
-	tpm_buf_append_u32(&buf, property_id);
-	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	tpm_buf_append_u32(buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(buf, property_id);
+	tpm_buf_append_u32(buf, 1);
+	rc = tpm_transmit_cmd(chip, buf, 0, NULL);
 	if (!rc) {
 		out = (struct tpm2_get_cap_out *)
-			&buf.data[TPM_HEADER_SIZE];
+			&buf->data[TPM_HEADER_SIZE];
 		/*
 		 * To prevent failing boot up of some systems, Infineon TPM2.0
 		 * returns SUCCESS on TPM2_Startup in field upgrade mode. Also
@@ -438,7 +433,6 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
 		else
 			rc = -ENODATA;
 	}
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
@@ -455,15 +449,15 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
  */
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 {
-	struct tpm_buf buf;
-	int rc;
+	struct tpm_buf *buf __free(kfree) = NULL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
-	if (rc)
+	buf = tpm_buf_alloc();
+	if (!buf)
 		return;
-	tpm_buf_append_u16(&buf, shutdown_type);
-	tpm_transmit_cmd(chip, &buf, 0, "stopping the TPM");
-	tpm_buf_destroy(&buf);
+
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
+	tpm_buf_append_u16(buf, shutdown_type);
+	tpm_transmit_cmd(chip, buf, 0, "stopping the TPM");
 }
 
 /**
@@ -481,19 +475,19 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int full;
 	int rc;
 
-	for (full = 0; full < 2; full++) {
-		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
-		if (rc)
-			return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-		tpm_buf_append_u8(&buf, full);
-		rc = tpm_transmit_cmd(chip, &buf, 0,
+	for (full = 0; full < 2; full++) {
+		tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+		tpm_buf_append_u8(buf, full);
+		rc = tpm_transmit_cmd(chip, buf, 0,
 				      "attempting the self test");
-		tpm_buf_destroy(&buf);
 
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
@@ -518,24 +512,25 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm_header *out;
-	struct tpm_buf buf;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		return rc;
-	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
-	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
-	tpm_buf_append_u32(&buf, 1);
-	rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	tpm_buf_append_u32(buf, TPM2_CAP_TPM_PROPERTIES);
+	tpm_buf_append_u32(buf, TPM_PT_TOTAL_COMMANDS);
+	tpm_buf_append_u32(buf, 1);
+	rc = tpm_transmit_cmd(chip, buf, 0, NULL);
 	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
-		out = (struct tpm_header *)buf.data;
+		out = (struct tpm_header *)buf->data;
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 			chip->flags |= TPM_CHIP_FLAG_TPM2;
 	}
-	tpm_buf_destroy(&buf);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
@@ -574,8 +569,8 @@ struct tpm2_pcr_selection {
 
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm2_pcr_selection pcr_selection;
-	struct tpm_buf buf;
 	void *marker;
 	void *end;
 	void *pcr_select_offset;
@@ -587,41 +582,39 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	int rc;
 	int i = 0;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	tpm_buf_append_u32(&buf, TPM2_CAP_PCRS);
-	tpm_buf_append_u32(&buf, 0);
-	tpm_buf_append_u32(&buf, 1);
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	tpm_buf_append_u32(buf, TPM2_CAP_PCRS);
+	tpm_buf_append_u32(buf, 0);
+	tpm_buf_append_u32(buf, 1);
 
-	rc = tpm_transmit_cmd(chip, &buf, 9, "get tpm pcr allocation");
+	rc = tpm_transmit_cmd(chip, buf, 9, "get tpm pcr allocation");
 	if (rc)
-		goto out;
+		return rc;
 
 	nr_possible_banks = be32_to_cpup(
-		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
+		(__be32 *)&buf->data[TPM_HEADER_SIZE + 5]);
 
 	chip->allocated_banks = kcalloc(nr_possible_banks,
 					sizeof(*chip->allocated_banks),
 					GFP_KERNEL);
-	if (!chip->allocated_banks) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!chip->allocated_banks)
+		return -ENOMEM;
 
-	marker = &buf.data[TPM_HEADER_SIZE + 9];
+	marker = &buf->data[TPM_HEADER_SIZE + 9];
 
-	rsp_len = be32_to_cpup((__be32 *)&buf.data[2]);
-	end = &buf.data[rsp_len];
+	rsp_len = be32_to_cpup((__be32 *)&buf->data[2]);
+	end = &buf->data[rsp_len];
 
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
@@ -633,7 +626,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 
 			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
 			if (rc < 0)
-				break;
+				return rc;
 
 			nr_alloc_banks++;
 		}
@@ -645,21 +638,22 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
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
+	struct tpm_buf *buf __free(kfree) = NULL;
 	u32 nr_commands;
 	__be32 *attrs;
 	u32 cc;
 	int i;
 	int rc;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	rc = tpm2_get_tpm_pt(chip, TPM_PT_TOTAL_COMMANDS, &nr_commands, NULL);
 	if (rc)
 		goto out;
@@ -676,30 +670,24 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 		goto out;
 	}
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
-	if (rc)
-		goto out;
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
+	tpm_buf_append_u32(buf, TPM2_CAP_COMMANDS);
+	tpm_buf_append_u32(buf, TPM2_CC_FIRST);
+	tpm_buf_append_u32(buf, nr_commands);
 
-	tpm_buf_append_u32(&buf, TPM2_CAP_COMMANDS);
-	tpm_buf_append_u32(&buf, TPM2_CC_FIRST);
-	tpm_buf_append_u32(&buf, nr_commands);
-
-	rc = tpm_transmit_cmd(chip, &buf, 9 + 4 * nr_commands, NULL);
-	if (rc) {
-		tpm_buf_destroy(&buf);
+	rc = tpm_transmit_cmd(chip, buf, 9 + 4 * nr_commands, NULL);
+	if (rc)
 		goto out;
-	}
 
 	if (nr_commands !=
-	    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5])) {
+	    be32_to_cpup((__be32 *)&buf->data[TPM_HEADER_SIZE + 5])) {
 		rc = -EFAULT;
-		tpm_buf_destroy(&buf);
 		goto out;
 	}
 
 	chip->nr_commands = nr_commands;
 
-	attrs = (__be32 *)&buf.data[TPM_HEADER_SIZE + 9];
+	attrs = (__be32 *)&buf->data[TPM_HEADER_SIZE + 9];
 	for (i = 0; i < nr_commands; i++, attrs++) {
 		chip->cc_attrs_tbl[i] = be32_to_cpup(attrs);
 		cc = chip->cc_attrs_tbl[i] & 0xFFFF;
@@ -711,8 +699,6 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 		}
 	}
 
-	tpm_buf_destroy(&buf);
-
 out:
 	if (rc > 0)
 		rc = -ENODEV;
@@ -733,20 +719,18 @@ EXPORT_SYMBOL_GPL(tpm2_get_cc_attrs_tbl);
 
 static int tpm2_startup(struct tpm_chip *chip)
 {
-	struct tpm_buf buf;
-	int rc;
+	struct tpm_buf *buf __free(kfree) = NULL;
 
-	dev_info(&chip->dev, "starting up the TPM manually\n");
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
-	if (rc < 0)
-		return rc;
+	dev_info(&chip->dev, "starting up the TPM manually\n");
 
-	tpm_buf_append_u16(&buf, TPM2_SU_CLEAR);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to start the TPM");
-	tpm_buf_destroy(&buf);
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
+	tpm_buf_append_u16(buf, TPM2_SU_CLEAR);
 
-	return rc;
+	return tpm_transmit_cmd(chip, buf, 0, "attempting to start the TPM");
 }
 
 /**
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 7b5049b3d476..50c481c7c947 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -182,19 +182,18 @@ static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
 
 static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	tpm_buf_append_u32(&buf, handle);
-	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
+	tpm_buf_append_u32(buf, handle);
+	rc = tpm_transmit_cmd(chip, buf, 0, "read public");
 	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_read_public(name, &buf);
-
-	tpm_buf_destroy(&buf);
+		rc = tpm2_parse_read_public(name, buf);
 
 	return rc;
 }
@@ -968,8 +967,8 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
  */
 int tpm2_start_auth_session(struct tpm_chip *chip)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm2_auth *auth;
-	struct tpm_buf buf;
 	u32 null_key;
 	int rc;
 
@@ -978,6 +977,10 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 		return 0;
 	}
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	auth = kzalloc(sizeof(*auth), GFP_KERNEL);
 	if (!auth)
 		return -ENOMEM;
@@ -988,41 +991,36 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
 	auth->session = TPM_HEADER_SIZE;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
-	if (rc)
-		goto out;
-
+	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
 	/* salt key handle */
-	tpm_buf_append_u32(&buf, null_key);
+	tpm_buf_append_u32(buf, null_key);
 	/* bind key handle */
-	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	tpm_buf_append_u32(buf, TPM2_RH_NULL);
 	/* nonce caller */
 	get_random_bytes(auth->our_nonce, sizeof(auth->our_nonce));
-	tpm_buf_append_u16(&buf, sizeof(auth->our_nonce));
-	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
+	tpm_buf_append_u16(buf, sizeof(auth->our_nonce));
+	tpm_buf_append(buf, auth->our_nonce, sizeof(auth->our_nonce));
 
 	/* append encrypted salt and squirrel away unencrypted in auth */
-	tpm_buf_append_salt(&buf, chip, auth);
+	tpm_buf_append_salt(buf, chip, auth);
 	/* session type (HMAC, audit or policy) */
-	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
+	tpm_buf_append_u8(buf, TPM2_SE_HMAC);
 
 	/* symmetric encryption parameters */
 	/* symmetric algorithm */
-	tpm_buf_append_u16(&buf, TPM_ALG_AES);
+	tpm_buf_append_u16(buf, TPM_ALG_AES);
 	/* bits for symmetric algorithm */
-	tpm_buf_append_u16(&buf, AES_KEY_BITS);
+	tpm_buf_append_u16(buf, AES_KEY_BITS);
 	/* symmetric algorithm mode (must be CFB) */
-	tpm_buf_append_u16(&buf, TPM_ALG_CFB);
+	tpm_buf_append_u16(buf, TPM_ALG_CFB);
 	/* hash algorithm for session */
-	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+	tpm_buf_append_u16(buf, TPM_ALG_SHA256);
 
-	rc = tpm_ret_to_err(tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession"));
+	rc = tpm_ret_to_err(tpm_transmit_cmd(chip, buf, 0, "StartAuthSession"));
 	tpm2_flush_context(chip, null_key);
 
 	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_start_auth_session(auth, &buf);
-
-	tpm_buf_destroy(&buf);
+		rc = tpm2_parse_start_auth_session(auth, buf);
 
 	if (rc == TPM2_RC_SUCCESS) {
 		chip->auth = auth;
@@ -1243,19 +1241,20 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 			       u32 *handle, u8 *name)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
+	struct tpm_buf *template __free(kfree) = NULL;
 	int rc;
-	struct tpm_buf buf;
-	struct tpm_buf template;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
-	if (rc)
-		return rc;
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
 
-	rc = tpm_buf_init_sized(&template);
-	if (rc) {
-		tpm_buf_destroy(&buf);
-		return rc;
-	}
+	template = tpm_buf_alloc();
+	if (!template)
+		return -ENOMEM;
+
+	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
+	tpm_buf_reset_sized(template);
 
 	/*
 	 * create the template.  Note: in order for userspace to
@@ -1267,75 +1266,72 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 	 */
 
 	/* key type */
-	tpm_buf_append_u16(&template, TPM_ALG_ECC);
+	tpm_buf_append_u16(template, TPM_ALG_ECC);
 
 	/* name algorithm */
-	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
+	tpm_buf_append_u16(template, TPM_ALG_SHA256);
 
 	/* object properties */
-	tpm_buf_append_u32(&template, TPM2_OA_NULL_KEY);
+	tpm_buf_append_u32(template, TPM2_OA_NULL_KEY);
 
 	/* sauth policy (empty) */
-	tpm_buf_append_u16(&template, 0);
+	tpm_buf_append_u16(template, 0);
 
 	/* BEGIN parameters: key specific; for ECC*/
 
 	/* symmetric algorithm */
-	tpm_buf_append_u16(&template, TPM_ALG_AES);
+	tpm_buf_append_u16(template, TPM_ALG_AES);
 
 	/* bits for symmetric algorithm */
-	tpm_buf_append_u16(&template, AES_KEY_BITS);
+	tpm_buf_append_u16(template, AES_KEY_BITS);
 
 	/* algorithm mode (must be CFB) */
-	tpm_buf_append_u16(&template, TPM_ALG_CFB);
+	tpm_buf_append_u16(template, TPM_ALG_CFB);
 
 	/* scheme (NULL means any scheme) */
-	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	tpm_buf_append_u16(template, TPM_ALG_NULL);
 
 	/* ECC Curve ID */
-	tpm_buf_append_u16(&template, TPM2_ECC_NIST_P256);
+	tpm_buf_append_u16(template, TPM2_ECC_NIST_P256);
 
 	/* KDF Scheme */
-	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	tpm_buf_append_u16(template, TPM_ALG_NULL);
 
 	/* unique: key specific; for ECC it is two zero size points */
-	tpm_buf_append_u16(&template, 0);
-	tpm_buf_append_u16(&template, 0);
+	tpm_buf_append_u16(template, 0);
+	tpm_buf_append_u16(template, 0);
 
 	/* END parameters */
 
 	/* primary handle */
-	tpm_buf_append_u32(&buf, hierarchy);
-	tpm_buf_append_empty_auth(&buf, TPM2_RS_PW);
+	tpm_buf_append_u32(buf, hierarchy);
+	tpm_buf_append_empty_auth(buf, TPM2_RS_PW);
 
 	/* sensitive create size is 4 for two empty buffers */
-	tpm_buf_append_u16(&buf, 4);
+	tpm_buf_append_u16(buf, 4);
 
 	/* sensitive create auth data (empty) */
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(buf, 0);
 
 	/* sensitive create sensitive data (empty) */
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(buf, 0);
 
 	/* the public template */
-	tpm_buf_append(&buf, template.data, template.length);
-	tpm_buf_destroy(&template);
+	tpm_buf_append(buf, template->data, template->length);
 
 	/* outside info (empty) */
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(buf, 0);
 
 	/* creation PCR (none) */
-	tpm_buf_append_u32(&buf, 0);
+	tpm_buf_append_u32(buf, 0);
 
-	rc = tpm_transmit_cmd(chip, &buf, 0,
+	rc = tpm_transmit_cmd(chip, buf, 0,
 			      "attempting to create NULL primary");
 
 	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_create_primary(chip, &buf, handle, hierarchy,
+		rc = tpm2_parse_create_primary(chip, buf, handle, hierarchy,
 					       name);
 
-	tpm_buf_destroy(&buf);
-
 	return rc;
 }
 
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..818b6f4084c7 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -71,24 +71,25 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 		      unsigned int *offset, u32 *handle)
 {
-	struct tpm_buf tbuf;
+	struct tpm_buf *tbuf __free(kfree) = NULL;
 	struct tpm2_context *ctx;
 	unsigned int body_size;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
-	if (rc)
-		return rc;
+	tbuf = tpm_buf_alloc();
+	if (!tbuf)
+		return -ENOMEM;
+
+	tpm_buf_reset(tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_LOAD);
 
 	ctx = (struct tpm2_context *)&buf[*offset];
 	body_size = sizeof(*ctx) + be16_to_cpu(ctx->blob_size);
-	tpm_buf_append(&tbuf, &buf[*offset], body_size);
+	tpm_buf_append(tbuf, &buf[*offset], body_size);
 
-	rc = tpm_transmit_cmd(chip, &tbuf, 4, NULL);
+	rc = tpm_transmit_cmd(chip, tbuf, 4, NULL);
 	if (rc < 0) {
 		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
 			 __func__, rc);
-		tpm_buf_destroy(&tbuf);
 		return -EFAULT;
 	} else if (tpm2_rc_value(rc) == TPM2_RC_HANDLE ||
 		   rc == TPM2_RC_REFERENCE_H0) {
@@ -103,64 +104,55 @@ int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
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
 
-	*handle = be32_to_cpup((__be32 *)&tbuf.data[TPM_HEADER_SIZE]);
+	*handle = be32_to_cpup((__be32 *)&tbuf->data[TPM_HEADER_SIZE]);
 	*offset += body_size;
-
-	tpm_buf_destroy(&tbuf);
 	return 0;
 }
 
 int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
 		      unsigned int buf_size, unsigned int *offset)
 {
-	struct tpm_buf tbuf;
+	struct tpm_buf *tbuf __free(kfree) = NULL;
 	unsigned int body_size;
 	int rc;
 
-	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
-	if (rc)
-		return rc;
+	tbuf = tpm_buf_alloc();
+	if (!tbuf)
+		return -ENOMEM;
 
-	tpm_buf_append_u32(&tbuf, handle);
+	tpm_buf_reset(tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
+	tpm_buf_append_u32(tbuf, handle);
 
-	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
+	rc = tpm_transmit_cmd(chip, tbuf, 0, NULL);
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
 
-	body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
+	body_size = tpm_buf_length(tbuf) - TPM_HEADER_SIZE;
 	if ((*offset + body_size) > buf_size) {
 		dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
-		tpm_buf_destroy(&tbuf);
 		return -ENOMEM;
 	}
 
-	memcpy(&buf[*offset], &tbuf.data[TPM_HEADER_SIZE], body_size);
+	memcpy(&buf[*offset], &tbuf->data[TPM_HEADER_SIZE], body_size);
 	*offset += body_size;
-	tpm_buf_destroy(&tbuf);
 	return 0;
 }
 
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 0818bb517805..6d76fe28826a 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -395,40 +395,36 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
 
 static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 	const struct tpm_header *header;
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS,
-				  TPM2_CC_SET_LOCALITY);
+		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
 	else
-		rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND,
-				  TPM_ORD_SET_LOCALITY);
-	if (rc)
-		return rc;
-	tpm_buf_append_u8(&buf, locality);
+		tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SET_LOCALITY);
+
+	tpm_buf_append_u8(buf, locality);
 
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");
+	rc = tpm_transmit_cmd(chip, buf, 0, "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
 
-	if (rc < 0) {
-		locality = rc;
-		goto out;
-	}
+	if (rc < 0)
+		return rc;
 
-	header = (const struct tpm_header *)buf.data;
+	header = (const struct tpm_header *)buf->data;
 	rc = be32_to_cpu(header->return_code);
 	if (rc)
 		locality = -1;
 
-out:
-	tpm_buf_destroy(&buf);
-
 	return locality;
 }
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 804fbbe3873d..463174182701 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -375,13 +375,14 @@ enum tpm_buf_flags {
 };
 
 /*
- * A string buffer type for constructing TPM commands.
+ * A buffer for constructing and parsing TPM commands, responses and sized
+ * (TPM2B) buffers.
  */
 struct tpm_buf {
-	u32 flags;
-	u32 length;
-	u8 *data;
-	u8 handles;
+	u16 flags;
+	u16 length;
+	u16 handles;
+	u8 data[];
 };
 
 enum tpm2_object_attributes {
@@ -412,11 +413,9 @@ struct tpm2_hash {
 	unsigned int tpm_id;
 };
 
-int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
+struct tpm_buf *tpm_buf_alloc(void);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
-int tpm_buf_init_sized(struct tpm_buf *buf);
 void tpm_buf_reset_sized(struct tpm_buf *buf);
-void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 89c9798d1800..106496c68625 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -356,21 +356,24 @@ static int TSS_checkhmac2(unsigned char *buffer,
  */
 int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	int rc;
 
 	if (!chip)
 		return -ENODEV;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	rc = tpm_try_get_ops(chip);
 	if (rc)
 		return rc;
 
-	buf.flags = 0;
-	buf.length = buflen;
-	buf.data = cmd;
+	tpm_buf_append(buf, cmd, buflen);
+
 	dump_tpm_buf(cmd);
-	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
+	rc = tpm_transmit_cmd(chip, buf, 4, "sending data");
 	dump_tpm_buf(cmd);
 
 	if (rc > 0)
@@ -672,23 +675,22 @@ static int tpm_unseal(struct tpm_buf *tb,
 static int key_seal(struct trusted_key_payload *p,
 		    struct trusted_key_options *o)
 {
-	struct tpm_buf tb;
+	struct tpm_buf *tb __free(kfree) = NULL;
 	int ret;
 
-	ret = tpm_buf_init(&tb, 0, 0);
-	if (ret)
-		return ret;
+	tb = tpm_buf_alloc();
+	if (!tb)
+		return -ENOMEM;
 
 	/* include migratable flag at end of sealed key */
 	p->key[p->key_len] = p->migratable;
 
-	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
+	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
 	if (ret < 0)
 		pr_info("srkseal failed (%d)\n", ret);
 
-	tpm_buf_destroy(&tb);
 	return ret;
 }
 
@@ -698,14 +700,14 @@ static int key_seal(struct trusted_key_payload *p,
 static int key_unseal(struct trusted_key_payload *p,
 		      struct trusted_key_options *o)
 {
-	struct tpm_buf tb;
+	struct tpm_buf *tb __free(kfree) = NULL;
 	int ret;
 
-	ret = tpm_buf_init(&tb, 0, 0);
-	if (ret)
-		return ret;
+	tb = tpm_buf_alloc();
+	if (!tb)
+		return -ENOMEM;
 
-	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
+	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
 			 o->blobauth, p->key, &p->key_len);
 	if (ret < 0)
 		pr_info("srkunseal failed (%d)\n", ret);
@@ -713,7 +715,6 @@ static int key_unseal(struct trusted_key_payload *p,
 		/* pull migratable flag out of sealed key */
 		p->migratable = p->key[--p->key_len];
 
-	tpm_buf_destroy(&tb);
 	return ret;
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 024be262702f..54bcd8d0621e 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -241,14 +241,23 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	struct tpm_buf *buf __free(kfree) = NULL;
+	struct tpm_buf *sized __free(kfree) = NULL;
 	off_t offset = TPM_HEADER_SIZE;
-	struct tpm_buf buf, sized;
 	int blob_len = 0;
 	u32 hash;
 	u32 flags;
 	int i;
 	int rc;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
+	sized = tpm_buf_alloc();
+	if (!sized)
+		return -ENOMEM;
+
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
 		if (options->hash == tpm2_hash_map[i].crypto_id) {
 			hash = tpm2_hash_map[i].tpm_id;
@@ -270,89 +279,76 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		goto out_put;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
-	if (rc) {
-		tpm2_end_auth_session(chip);
-		goto out_put;
-	}
-
-	rc = tpm_buf_init_sized(&sized);
-	if (rc) {
-		tpm_buf_destroy(&buf);
-		tpm2_end_auth_session(chip);
-		goto out_put;
-	}
-
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
-	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
+	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	tpm_buf_reset_sized(sized);
+	tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(chip, buf, TPM2_SA_DECRYPT,
 				    options->keyauth, TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&sized, options->blobauth_len);
+	tpm_buf_append_u16(sized, options->blobauth_len);
 
 	if (options->blobauth_len)
-		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
+		tpm_buf_append(sized, options->blobauth, options->blobauth_len);
 
-	tpm_buf_append_u16(&sized, payload->key_len);
-	tpm_buf_append(&sized, payload->key, payload->key_len);
-	tpm_buf_append(&buf, sized.data, sized.length);
+	tpm_buf_append_u16(sized, payload->key_len);
+	tpm_buf_append(sized, payload->key, payload->key_len);
+	tpm_buf_append(buf, sized->data, sized->length);
 
 	/* public */
-	tpm_buf_reset_sized(&sized);
-	tpm_buf_append_u16(&sized, TPM_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&sized, hash);
+	tpm_buf_reset_sized(sized);
+	tpm_buf_append_u16(sized, TPM_ALG_KEYEDHASH);
+	tpm_buf_append_u16(sized, hash);
 
 	/* key properties */
 	flags = 0;
 	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
 	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
-	tpm_buf_append_u32(&sized, flags);
+	tpm_buf_append_u32(sized, flags);
 
 	/* policy */
-	tpm_buf_append_u16(&sized, options->policydigest_len);
+	tpm_buf_append_u16(sized, options->policydigest_len);
 	if (options->policydigest_len)
-		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
+		tpm_buf_append(sized, options->policydigest, options->policydigest_len);
 
 	/* public parameters */
-	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
-	tpm_buf_append_u16(&sized, 0);
+	tpm_buf_append_u16(sized, TPM_ALG_NULL);
+	tpm_buf_append_u16(sized, 0);
 
-	tpm_buf_append(&buf, sized.data, sized.length);
+	tpm_buf_append(buf, sized->data, sized->length);
 
 	/* outside info */
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(buf, 0);
 
 	/* creation PCR */
-	tpm_buf_append_u32(&buf, 0);
+	tpm_buf_append_u32(buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf->flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
-	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
-	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+	tpm_buf_fill_hmac_session(chip, buf);
+	rc = tpm_transmit_cmd(chip, buf, 4, "sealing data");
+	rc = tpm_buf_check_hmac_response(chip, buf, rc);
 	if (rc)
 		goto out;
 
-	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	blob_len = tpm_buf_read_u32(buf, &offset);
+	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_BOUNDARY_ERROR) {
 		rc = -E2BIG;
 		goto out;
 	}
-	if (buf.length - offset < blob_len) {
+	if (buf->length - offset < blob_len) {
 		rc = -EFAULT;
 		goto out;
 	}
 
-	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
+	blob_len = tpm2_key_encode(payload, options, &buf->data[offset],
+				   blob_len);
 
 out:
-	tpm_buf_destroy(&sized);
-	tpm_buf_destroy(&buf);
-
 	if (rc > 0) {
 		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
 			rc = -EINVAL;
@@ -387,7 +383,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
@@ -395,6 +391,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	int rc;
 	u32 attrs;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	rc = tpm2_key_decode(payload, options, &blob);
 	if (rc) {
 		/* old form */
@@ -438,35 +438,29 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
-	if (rc) {
-		tpm2_end_auth_session(chip);
-		return rc;
-	}
-
-	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
-	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
+	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(chip, buf, 0, options->keyauth,
 				    TPM_DIGEST_SIZE);
 
-	tpm_buf_append(&buf, blob, blob_len);
+	tpm_buf_append(buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf->flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
-	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
-	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+	tpm_buf_fill_hmac_session(chip, buf);
+	rc = tpm_transmit_cmd(chip, buf, 4, "loading blob");
+	rc = tpm_buf_check_hmac_response(chip, buf, rc);
 	if (!rc)
 		*blob_handle = be32_to_cpup(
-			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
+			(__be32 *)&buf->data[TPM_HEADER_SIZE]);
 
 out:
 	if (blob != payload->blob)
 		kfree(blob);
-	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
 		rc = -EPERM;
@@ -491,25 +485,24 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
-	struct tpm_buf buf;
+	struct tpm_buf *buf __free(kfree) = NULL;
 	u16 data_len;
 	u8 *data;
 	int rc;
 
+	buf = tpm_buf_alloc();
+	if (!buf)
+		return -ENOMEM;
+
 	rc = tpm2_start_auth_session(chip);
 	if (rc)
 		return rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
-	if (rc) {
-		tpm2_end_auth_session(chip);
-		return rc;
-	}
-
-	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
+	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	tpm_buf_append_name(chip, buf, blob_handle, NULL);
 
 	if (!options->policyhandle) {
-		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
+		tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
 					    options->blobauth,
 					    options->blobauth_len);
 	} else {
@@ -524,32 +517,28 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		 * could repeat our actions with the exfiltrated
 		 * password.
 		 */
-		tpm2_buf_append_auth(&buf, options->policyhandle,
+		tpm2_buf_append_auth(buf, options->policyhandle,
 				     NULL /* nonce */, 0, 0,
 				     options->blobauth, options->blobauth_len);
-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
+		tpm_buf_append_hmac_session_opt(chip, buf, TPM2_SA_ENCRYPT,
 						NULL, 0);
 	}
 
-	tpm_buf_fill_hmac_session(chip, &buf);
-	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
-	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
+	tpm_buf_fill_hmac_session(chip, buf);
+	rc = tpm_transmit_cmd(chip, buf, 6, "unsealing");
+	rc = tpm_buf_check_hmac_response(chip, buf, rc);
 	if (rc > 0)
 		rc = -EPERM;
 
 	if (!rc) {
 		data_len = be16_to_cpup(
-			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
-		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE) {
-			rc = -EFAULT;
-			goto out;
-		}
+			(__be16 *)&buf->data[TPM_HEADER_SIZE + 4]);
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE)
+			return -EFAULT;
 
-		if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 6 + data_len) {
-			rc = -EFAULT;
-			goto out;
-		}
-		data = &buf.data[TPM_HEADER_SIZE + 6];
+		if (tpm_buf_length(buf) < TPM_HEADER_SIZE + 6 + data_len)
+			return -EFAULT;
+		data = &buf->data[TPM_HEADER_SIZE + 6];
 
 		if (payload->old_format) {
 			/* migratable flag is at the end of the key */
@@ -566,8 +555,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		}
 	}
 
-out:
-	tpm_buf_destroy(&buf);
 	return rc;
 }
 
-- 
2.39.5


