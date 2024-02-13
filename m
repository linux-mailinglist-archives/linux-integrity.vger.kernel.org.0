Return-Path: <linux-integrity+bounces-1184-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C4853749
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5243B1F2349E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335425FDB5;
	Tue, 13 Feb 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="N2SCqywr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD05FDD8;
	Tue, 13 Feb 2024 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845029; cv=none; b=qw//lpaHLpHnn2nGBWOw9hsPWlgHQoGpwSQQrSyBOj3/8QlMRJoid53bcvfnE0JQ9+t+fB3HTi3PPBHMVJNwaJ/DfPoPRISgvjdQ3I6o1Sjl9YhMPrzXb1WI5gb61oUhS0XJuC6Es/8jbFIWF7g3yHiLRqfzfo1M696nOR72vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845029; c=relaxed/simple;
	bh=Uco9el8x7+mOayx+8z5i5DfBkqWn1LaE6BiIlMrR4rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvyKBhrtL3cr9NO1timNbL0votyfJX/GBtoYm1ef7j2AvgojJfliFQCPZTdeGZskMXPuRiFPigD9XxtS1cYf5F1df4UJ0iThWdtCFOcm9w9Mri4B/m240qU6BNtzQu+o9L2K+r/tE7tD2L1zVUV/dVKJ6F9dHoNjomXU/+xsRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=N2SCqywr; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707845025;
	bh=Uco9el8x7+mOayx+8z5i5DfBkqWn1LaE6BiIlMrR4rA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=N2SCqywrpOD5IoAvZF/RxnaPiSi48o1q2LUzaznfDsPHgej8Lxl1EQ2xqlobZ+p1G
	 TOBThb4k5SMlxNqCvoxA5hKT+1p4Vsiy3NuAHNmhAGSeRAvnmrc+Y6KzQjv6BAVScg
	 4UPQAQbPLc5b/BnqGG/xrNMpr3pdoJrCF0cWiaBc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CB9AB1281DF8;
	Tue, 13 Feb 2024 12:23:45 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id AS5y-vryk_2n; Tue, 13 Feb 2024 12:23:45 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2A8AB1281B09;
	Tue, 13 Feb 2024 12:23:45 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 21/21] tpm: disable the TPM if NULL name changes
Date: Tue, 13 Feb 2024 12:13:34 -0500
Message-Id: <20240213171334.30479-22-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update tpm2_load_context() to return -EINVAL on integrity failures and
use this as a signal when loading the NULL context that something
might be wrong.  If the signal fails, check the name of the NULL
primary against the one stored in the chip data and if there is a
mismatch disable the TPM because it is likely to have suffered a reset
attack.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-chip.c      |  3 ++
 drivers/char/tpm/tpm2-sessions.c | 65 ++++++++++++++++++++++++++------
 drivers/char/tpm/tpm2-space.c    |  3 ++
 include/linux/tpm.h              |  4 +-
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index d93937326b2e..854546000c92 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -158,6 +158,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
 {
 	int rc = -EIO;
 
+	if (chip->flags & TPM_CHIP_FLAG_DISABLE)
+		return rc;
+
 	get_device(&chip->dev);
 
 	down_read(&chip->ops_sem);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 9d6da0c9652f..60a1a8746563 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -87,6 +87,9 @@
 #define AES_KEYBITS	(AES_KEYBYTES*8)
 #define AUTH_MAX_NAMES	3
 
+static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
+			       u32 *handle, u8 *name);
+
 /*
  * This is the structure that carries all the auth information (like
  * session handle, nonces, session key and auth) from use to use it is
@@ -847,6 +850,37 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 	return 0;
 }
 
+static int tpm2_load_null(struct tpm_chip *chip, u32 *nullkey)
+{
+	int rc;
+	unsigned int offset = 0; /* dummy offset for null seed context */
+	u8 name[SHA256_DIGEST_SIZE + 2];
+
+	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
+			       nullkey);
+	if (rc != -EINVAL)
+		return rc;
+
+	/* an integrity failure may mean the TPM has been reset */
+	dev_err(&chip->dev, "NULL key integrity failure!\n");
+	/* check the null name against what we know */
+	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
+	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
+		/* name unchanged, assume transient integrity failure */
+		return rc;
+	/*
+	 * Fatal TPM failure: the NULL seed has actually changed, so
+	 * the TPM must have been illegally reset.  All in-kernel TPM
+	 * operations will fail because the NULL primary can't be
+	 * loaded to salt the sessions, but disable the TPM anyway so
+	 * userspace programms can't be compromised by it.
+	 */
+	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
+	chip->flags |= TPM_CHIP_FLAG_DISABLE;
+
+	return rc;
+}
+
 /**
  * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
  * @chip: the TPM chip structure to create the session with
@@ -864,11 +898,9 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	struct tpm_buf buf;
 	struct tpm2_auth *auth = chip->auth;
 	int rc;
-	unsigned int offset = 0; /* dummy offset for null seed context */
 	u32 nullkey;
 
-	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
-			       &nullkey);
+	rc = tpm2_load_null(chip, &nullkey);
 	if (rc)
 		goto out;
 
@@ -919,15 +951,19 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 EXPORT_SYMBOL(tpm2_start_auth_session);
 
 static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
-				     u32 *nullkey)
+				     u32 *handle, u8 *name)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
 	off_t offset_r = TPM_HEADER_SIZE, offset_t;
 	u16 len = TPM_HEADER_SIZE;
 	u32 tot_len = be32_to_cpu(head->length);
-	u32 val, parm_len;
+	u32 val, parm_len, keyhandle;
+	keyhandle = tpm_buf_read_u32(buf, &offset_r);
+	if (handle)
+		*handle = keyhandle;
+	else
+		tpm2_flush_context(chip, keyhandle);
 
-	*nullkey = tpm_buf_read_u32(buf, &offset_r);
 	parm_len = tpm_buf_read_u32(buf, &offset_r);
 	/*
 	 * parm_len doesn't include the header, but all the other
@@ -940,9 +976,12 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 		return -EINVAL;
 	len = tpm_buf_read_u16(buf, &offset_r);
 	offset_t = offset_r;
-	/* now we have the public area, compute the name of the object */
-	put_unaligned_be16(TPM_ALG_SHA256, chip->null_key_name);
-	sha256(&buf->data[offset_r], len, chip->null_key_name + 2);
+	if (name) {
+		/* now we have the public area, compute the name of
+		 * the object */
+		put_unaligned_be16(TPM_ALG_SHA256, name);
+		sha256(&buf->data[offset_r], len, name + 2);
+	}
 
 	/* validate the public key */
 	val = tpm_buf_read_u16(buf, &offset_t);
@@ -1054,7 +1093,8 @@ static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
 	return 0;
 }
 
-static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy, u32 *handle)
+static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
+			       u32 *handle, u8 *name)
 {
 	int rc;
 	struct tpm_buf buf;
@@ -1133,7 +1173,7 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy, u32 *handle
 			      "attempting to create NULL primary");
 
 	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_create_primary(chip, &buf, handle);
+		rc = tpm2_parse_create_primary(chip, &buf, handle, name);
 
 	tpm_buf_destroy(&buf);
 
@@ -1145,7 +1185,8 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
 	u32 nullkey;
 	int rc;
 
-	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey,
+				 chip->null_key_name);
 
 	if (rc == TPM2_RC_SUCCESS) {
 		unsigned int offset = 0; /* dummy offset for null key context */
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 24479a81c23c..4892d491da8d 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -105,6 +105,9 @@ int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 		*handle = 0;
 		tpm_buf_destroy(&tbuf);
 		return -ENOENT;
+	} else if (tpm2_rc_value(rc) == TPM2_RC_INTEGRITY) {
+		tpm_buf_destroy(&tbuf);
+		return -EINVAL;
 	} else if (rc > 0) {
 		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
 			 __func__, rc);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 9c608fac8935..4474dabfb69d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -244,6 +244,7 @@ enum tpm2_return_codes {
 	TPM2_RC_SUCCESS		= 0x0000,
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
+	TPM2_RC_INTEGRITY	= 0x009F,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
@@ -342,6 +343,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
+	TPM_CHIP_FLAG_DISABLE			= BIT(10),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -428,7 +430,7 @@ static inline bool tpm_is_firmware_upgrade(struct tpm_chip *chip)
 
 static inline u32 tpm2_rc_value(u32 rc)
 {
-	return (rc & BIT(7)) ? rc & 0xff : rc;
+	return (rc & BIT(7)) ? rc & 0xbf : rc;
 }
 
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
-- 
2.35.3


