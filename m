Return-Path: <linux-integrity+bounces-7245-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F77B96F67
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5737B4E61
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399D27E06C;
	Tue, 23 Sep 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9xvuuZS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C5275B0D;
	Tue, 23 Sep 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647335; cv=none; b=MINepO83nkgKk8KMPS+vJKZ0Gw9REDOxrPSP/jO3Ia3WANa6Xs8fZe74L1CUE5YaPddV/q4CvFHsdDjN1IdlFu5KjeDYNsejM8eIN8+vx195wSJHEFG2Jo1tDT5t0hrK/ghZ4ZNXAPa6Z4pXkANTcNGQm8EFmu/4IOjre/n4css=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647335; c=relaxed/simple;
	bh=fFC0hhrO8MvuHkhNKifLIxG0xpNWqwu3w0WUPqm0RbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCR5w4wvxej+x52vjrWkHDEi8lPpAn5MegNWQtmnSIVT5LlkgU/ZkG+lblFmCOGMbbeDsKZLVmKTuPaNSglQJKXMHaJ2NJHQxto4zzARbuUfJLOcChdHvi+jQbgg6A/++ijmUvsE8Lz5H435QEjJmp8r/fFVt1f7fj9AYjcfTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9xvuuZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A8CC4CEF5;
	Tue, 23 Sep 2025 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647334;
	bh=fFC0hhrO8MvuHkhNKifLIxG0xpNWqwu3w0WUPqm0RbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9xvuuZSE/RkCysit0eGrTmwrysZScC5J2QUgrBff4BGTDCXDQnuHqXdp8fr0QjCM
	 LFHYt7d6GUYu3Wbae4QGx+BaNOnYgZZlkNIZt8DahbLgeTTdQEmWj8EG35t987RB3o
	 OTmbhzBfVt64jOnXFIPeKcky1LVyTBsF3Adc2rPbCtC5yt7zGYxQkyW4z/mSPyinC2
	 KmIok1ZiqwX4GWe2kA/rdtjELYRsRmDj4lafn6zg8Zhq2xIBBaIH7aObeePH23eEBf
	 oYX8tg38v84Rrm0eBQiJGUp4qvPWAnCu0AU2K59JN8m+LRxC7f7/PwOfHsPPMadU6D
	 G2IEX4J16AKKQ==
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
Subject: [PATCH v11 2/3] tpm: Use TPM_MIN_BUF_SIZE in driver commands
Date: Tue, 23 Sep 2025 20:07:43 +0300
Message-Id: <20250923170744.1749132-3-jarkko@kernel.org>
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

Use TPM_BUF_MIN_SIZE and stack allocation in the following commands:

1. tpm1_startup
2. tpm2_shutdown
3. tpm1_get_random
4. tpm2_do_selftest
5. tpm2_probe
6. tpm2_startup
7. tpm2_get_random
8. vtpm_proxy_request_locality

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v11:
- A new patch that squashes previous stack updates. It's in the end of
  day easier review like this. Thus, also the sanity check list in the
  commit message in order to catch up unintended changes if there were
  any.
---
 drivers/char/tpm/tpm.h            |  9 ++---
 drivers/char/tpm/tpm1-cmd.c       | 22 ++++-------
 drivers/char/tpm/tpm2-cmd.c       | 65 ++++++++++++-------------------
 drivers/char/tpm/tpm_vtpm_proxy.c | 12 +++---
 4 files changed, 42 insertions(+), 66 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 1a4abe54db15..df426e281f88 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -223,11 +223,10 @@ enum tpm2_pt_props {
 	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
 };
 
-/* 128 bytes is an arbitrary cap. This could be as large as TPM_BUF_MAX_SIZE - 18
- * bytes, but 128 is still a relatively large number of random bytes and
- * anything much bigger causes users of struct tpm_cmd_t to start getting
- * compiler warnings about stack frame size. */
-#define TPM_MAX_RNG_DATA	128
+/*
+ * The parameter is capped to fit to a stack allocated TPM buffer.
+ */
+#define TPM_MAX_RNG_DATA	(TPM_BUF_MIN_SIZE / 2)
 
 extern const struct class tpm_class;
 extern const struct class tpmrm_class;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ca3e7f9a105d..fdb55dab80e1 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -323,19 +323,15 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
  */
 static int tpm1_startup(struct tpm_chip *chip)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	dev_info(&chip->dev, "starting up the TPM manually\n");
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	dev_info(&chip->dev, "TPM_Startup\n");
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_STARTUP);
 	tpm_buf_append_u16(buf, TPM_ST_CLEAR);
-
-	rc = tpm_transmit_cmd(chip, buf, 0, "attempting to start the TPM");
+	rc = tpm_transmit_cmd(chip, buf, 0, "TPM_Startup");
 	return rc;
 }
 
@@ -530,6 +526,8 @@ struct tpm1_get_random_out {
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	struct tpm1_get_random_out *out;
 	u32 num_bytes =  min_t(u32, max, TPM_MAX_RNG_DATA);
 	u32 total = 0;
@@ -537,11 +535,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	u32 recd;
 	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	do {
 		tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
 		tpm_buf_append_u32(buf, num_bytes);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 245c7c952e82..320dc6ae6af2 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -226,6 +226,8 @@ struct tpm2_get_random_out {
  */
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	struct tpm2_get_random_out *out;
 	struct tpm_header *head;
 	u32 recd;
@@ -239,15 +241,11 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	err = tpm2_start_auth_session(chip);
 	if (err)
 		return err;
 
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	do {
 		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
 		tpm_buf_append_hmac_session_opt(chip, buf, TPM2_SA_ENCRYPT
@@ -382,14 +380,13 @@ EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
  */
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
 {
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return;
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
 	tpm_buf_append_u16(buf, shutdown_type);
-	tpm_transmit_cmd(chip, buf, 0, "stopping the TPM");
+	tpm_transmit_cmd(chip, buf, 0, "TPM2_Shutdown");
 }
 
 /**
@@ -407,58 +404,49 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
  */
 static int tpm2_do_selftest(struct tpm_chip *chip)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	int full;
 	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
-	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	for (full = 0; full < 2; full++) {
 		tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SELF_TEST);
 		tpm_buf_append_u8(buf, full);
-		rc = tpm_transmit_cmd(chip, buf, 0,
-				      "attempting the self test");
-
+		rc = tpm_transmit_cmd(chip, buf, 0, "TPM2_SelfTest");
 		if (rc == TPM2_RC_TESTING)
 			rc = TPM2_RC_SUCCESS;
 		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
 			return rc;
 	}
-
 	return rc;
 }
 
 /**
- * tpm2_probe() - probe for the TPM 2.0 protocol
+ * tpm2_probe() - Probe for the TPM 2.0 protocol
  * @chip:	a &tpm_chip instance
  *
- * Send an idempotent TPM 2.0 command and see whether there is TPM2 chip in the
- * other end based on the response tag. The flag TPM_CHIP_FLAG_TPM2 is set by
- * this function if this is the case.
+ * Sends an idempotent TPM 2.0 command, and based on the response tag deduces
+ * whether a functional TPM2 chip is on the other side. When the result is
+ * positive, TPM_CHIP_FLAG_TPM2 is append to the chip's flags.
  *
  * Return:
- *   0 on success,
- *   -errno otherwise
+ * * 0 on success,
+ * * -errno otherwise
  */
 int tpm2_probe(struct tpm_chip *chip)
 {
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 	struct tpm_header *out;
 	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
 	tpm_buf_append_u32(buf, TPM2_CAP_TPM_PROPERTIES);
 	tpm_buf_append_u32(buf, TPM_PT_TOTAL_COMMANDS);
 	tpm_buf_append_u32(buf, 1);
 	rc = tpm_transmit_cmd(chip, buf, 0, NULL);
-	/* We ignore TPM return codes on purpose. */
 	if (rc >=  0) {
 		out = (struct tpm_header *)buf->data;
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
@@ -651,17 +639,14 @@ EXPORT_SYMBOL_GPL(tpm2_get_cc_attrs_tbl);
 
 static int tpm2_startup(struct tpm_chip *chip)
 {
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
 
-	dev_info(&chip->dev, "starting up the TPM manually\n");
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	dev_info(&chip->dev, "TPM2_Startup\n");
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	tpm_buf_reset(buf, TPM2_ST_NO_SESSIONS, TPM2_CC_STARTUP);
 	tpm_buf_append_u16(buf, TPM2_SU_CLEAR);
-
-	return tpm_transmit_cmd(chip, buf, 0, "attempting to start the TPM");
+	return tpm_transmit_cmd(chip, buf, 0, "TPM2_Startup");
 }
 
 /**
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index e5de14379eb2..0f1b1b67ed4e 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -395,15 +395,13 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
 
 static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 {
-	int rc;
-	const struct tpm_header *header;
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
+	u8 buf_data[TPM_BUF_MIN_SIZE];
+	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
+	const struct tpm_header *header;
+	int rc;
 
-	struct tpm_buf *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	tpm_buf_init(buf, TPM_BUF_MAX_SIZE);
+	tpm_buf_init(buf, TPM_BUF_MIN_SIZE);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_SET_LOCALITY);
 	else
-- 
2.39.5


