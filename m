Return-Path: <linux-integrity+bounces-1175-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F355085371E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B891F29E7B
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A25FEFA;
	Tue, 13 Feb 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UWQqsMlC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B585FBAB;
	Tue, 13 Feb 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844763; cv=none; b=Rz/6Vbn1bYDNCjk1S3HqnC4M1XIFuwm9+1nNx3LLc07uTa5tYJr49x22QDPvc6nSM3ZSbTEDLWT2wuuhiMDd1FaeTsouOTHBJPt4lDzxg0++NIUDHcwmq4hJ/x+VUT8g/rCw/sAZsOGNdOK06PMylJTYf00xBVjeTGo85jd6aak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844763; c=relaxed/simple;
	bh=Yx0c4/gZ6ZD99ltC63QAll+WhdS9g53kRSxoyu29k0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ve9OlIuLQ4rkvZ6ZvpG/8AsCKE8ZHLpIh4qECsLTJbfDBryqTmljimYgToOur4egyA09IeJUWGUbRvStswlBqlBPxDBmf4fljvn5RSJYB3L87ZBm+bY/QyQgdyHkkVXAMQ4JgW+zpW3Adzja6VKHphhpkEC4/8Dq4HTKWtUXJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UWQqsMlC; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844760;
	bh=Yx0c4/gZ6ZD99ltC63QAll+WhdS9g53kRSxoyu29k0w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=UWQqsMlChOiLUaeTU6WA45hZrsOKyV6qjfNZwoT8vo6odTcFfYoFYNUF+pJAYAwCi
	 VInw3+FF2mcNruzzhrhoLD7X7lBBeWo2f8FcobW2P6WVGH+Igu0KZXq3kyiDWBRE6Q
	 4qfMq3z2uFXRYhxKli1e1qOWItCglCzAnDgcKuG8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B5E401280D89;
	Tue, 13 Feb 2024 12:19:20 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id oLgJ2PVQqXIO; Tue, 13 Feb 2024 12:19:20 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2890B1280CB7;
	Tue, 13 Feb 2024 12:19:20 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 12/21] tpm: Add NULL primary creation
Date: Tue, 13 Feb 2024 12:13:25 -0500
Message-Id: <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
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

The session handling code uses a "salted" session, meaning a session
whose salt is encrypted to the public part of another TPM key so an
observer cannot obtain it (and thus deduce the session keys).  This
patch creates and context saves in the tpm_chip area the primary key
of the NULL hierarchy for this purpose.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v6: split out of original HMAC patch update config name
v7: rename null seed parameters
---
 drivers/char/tpm/Kconfig         |  11 ++
 drivers/char/tpm/Makefile        |   1 +
 drivers/char/tpm/tpm.h           |  10 ++
 drivers/char/tpm/tpm2-cmd.c      |   5 +
 drivers/char/tpm/tpm2-sessions.c | 276 +++++++++++++++++++++++++++++++
 include/linux/tpm.h              |  49 ++++++
 6 files changed, 352 insertions(+)
 create mode 100644 drivers/char/tpm/tpm2-sessions.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 927088b2c3d3..e3c39a83171b 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -27,6 +27,17 @@ menuconfig TCG_TPM
 
 if TCG_TPM
 
+config TCG_TPM2_HMAC
+	bool "Use encrypted and HMACd transactions on the TPM bus"
+	default y
+	help
+          Setting this causes us to deploy a scheme which uses request
+	  and response HMACs in addition to encryption for
+	  communicating with the TPM to prevent or detect bus snooping
+	  and interposer attacks (see tpm-security.rst).  Saying Y
+	  here adds some encryption overhead to all kernel to TPM
+	  transactions.
+
 config HW_RANDOM_TPM
 	bool "TPM HW Random Number Generator support"
 	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index ad3594e383e1..4c695b0388f3 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -17,6 +17,7 @@ tpm-y += eventlog/tpm1.o
 tpm-y += eventlog/tpm2.o
 tpm-y += tpm-buf.o
 
+tpm-$(CONFIG_TCG_TPM2_HMAC) += tpm2-sessions.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
 tpm-$(CONFIG_EFI) += eventlog/efi.o
 tpm-$(CONFIG_OF) += eventlog/of.o
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index cbc9d1e2974d..6b8b9956ba69 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -321,4 +321,14 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
 int tpm_dev_common_init(void);
 void tpm_dev_common_exit(void);
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+int tpm2_sessions_init(struct tpm_chip *chip);
+#else
+static inline int tpm2_sessions_init(struct tpm_chip *chip)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 93545be190a5..b0e72fb563d9 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -759,6 +759,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 		rc = 0;
 	}
 
+	if (rc)
+		goto out;
+
+	rc = tpm2_sessions_init(chip);
+
 out:
 	/*
 	 * Infineon TPM in field upgrade mode will return no data for the number
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
new file mode 100644
index 000000000000..9fc263ee02c2
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
+ *
+ */
+
+#include "tpm.h"
+
+#include <asm/unaligned.h>
+
+#include <crypto/aes.h>
+
+/* if you change to AES256, you only need change this */
+#define AES_KEYBYTES	AES_KEYSIZE_128
+
+#define AES_KEYBITS	(AES_KEYBYTES*8)
+
+static int tpm2_parse_create_primary(struct tpm_chip *chip, struct tpm_buf *buf,
+				     u32 *nullkey)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	off_t offset_r = TPM_HEADER_SIZE, offset_t;
+	u16 len = TPM_HEADER_SIZE;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val, parm_len;
+
+	*nullkey = tpm_buf_read_u32(buf, &offset_r);
+	parm_len = tpm_buf_read_u32(buf, &offset_r);
+	/*
+	 * parm_len doesn't include the header, but all the other
+	 * lengths and offsets do, so add it to parm len to make
+	 * the comparisons easier
+	 */
+	parm_len += TPM_HEADER_SIZE;
+
+	if (parm_len + 8 > tot_len)
+		return -EINVAL;
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_t = offset_r;
+	/* now we have the public area, compute the name of the object */
+	put_unaligned_be16(TPM_ALG_SHA256, chip->null_key_name);
+	sha256(&buf->data[offset_r], len, chip->null_key_name + 2);
+
+	/* validate the public key */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	/* key type (must be what we asked for) */
+	if (val != TPM_ALG_ECC)
+		return -EINVAL;
+	val = tpm_buf_read_u16(buf, &offset_t);
+	/* name algorithm */
+	if (val != TPM_ALG_SHA256)
+		return -EINVAL;
+	val = tpm_buf_read_u32(buf, &offset_t);
+	/* object properties */
+	if (val != (TPM2_OA_NO_DA |
+		    TPM2_OA_FIXED_TPM |
+		    TPM2_OA_FIXED_PARENT |
+		    TPM2_OA_SENSITIVE_DATA_ORIGIN |
+		    TPM2_OA_USER_WITH_AUTH |
+		    TPM2_OA_DECRYPT |
+		    TPM2_OA_RESTRICTED))
+		return -EINVAL;
+	/* auth policy (empty) */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != 0)
+		return -EINVAL;
+	/* symmetric key parameters */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_AES)
+		return -EINVAL;
+	/* symmetric key length */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != AES_KEYBITS)
+		return -EINVAL;
+	/* symmetric encryption scheme */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_CFB)
+		return -EINVAL;
+	/* signing scheme */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	/* ECC Curve */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM2_ECC_NIST_P256)
+		return -EINVAL;
+	/* KDF Scheme */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != TPM_ALG_NULL)
+		return -EINVAL;
+	/* x point */
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != EC_PT_SZ)
+		return -EINVAL;
+	memcpy(chip->null_ec_key_x, &buf->data[offset_t], val);
+	offset_t += val;
+	val = tpm_buf_read_u16(buf, &offset_t);
+	if (val != EC_PT_SZ)
+		return -EINVAL;
+	memcpy(chip->null_ec_key_y, &buf->data[offset_t], val);
+	offset_t += val;
+
+	/* original length of the whole TPM2B */
+	offset_r += len;
+
+	/* should have exactly consumed the TPM2B public structure */
+	if (offset_t != offset_r)
+		return -EINVAL;
+	if (offset_r > parm_len)
+		return -EINVAL;
+	/* creation data (skip) */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_r += len;
+	if (offset_r > parm_len)
+		return -EINVAL;
+	/* creation digest (must be sha256) */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_r += len;
+	if (len != SHA256_DIGEST_SIZE || offset_r > parm_len)
+		return -EINVAL;
+	/* TPMT_TK_CREATION follows */
+	/* tag, must be TPM_ST_CREATION (0x8021) */
+	val = tpm_buf_read_u16(buf, &offset_r);
+	if (val != TPM2_ST_CREATION || offset_r > parm_len)
+		return -EINVAL;
+	/* hierarchy (must be NULL) */
+	val = tpm_buf_read_u32(buf, &offset_r);
+	if (val != TPM2_RH_NULL || offset_r > parm_len)
+		return -EINVAL;
+	/* the ticket digest HMAC (might not be sha256) */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	offset_r += len;
+	if (offset_r > parm_len)
+		return -EINVAL;
+	/*
+	 * finally we have the name, which is a sha256 digest plus a 2
+	 * byte algorithm type
+	 */
+	len = tpm_buf_read_u16(buf, &offset_r);
+	if (offset_r + len != parm_len + 8)
+		return -EINVAL;
+	if (len != SHA256_DIGEST_SIZE + 2)
+		return -EINVAL;
+
+	if (memcmp(chip->null_key_name, &buf->data[offset_r],
+		   SHA256_DIGEST_SIZE + 2) != 0) {
+		dev_err(&chip->dev, "NULL Seed name comparison failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy, u32 *handle)
+{
+	int rc;
+	struct tpm_buf buf;
+	struct tpm_buf template;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
+	if (rc)
+		return rc;
+
+	rc = tpm_buf_init_sized(&template);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		return rc;
+	}
+
+	/*
+	 * create the template.  Note: in order for userspace to
+	 * verify the security of the system, it will have to create
+	 * and certify this NULL primary, meaning all the template
+	 * parameters will have to be identical, so conform exactly to
+	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
+	 * key
+	 */
+
+	/* key type */
+	tpm_buf_append_u16(&template, TPM_ALG_ECC);
+	/* name algorithm */
+	tpm_buf_append_u16(&template, TPM_ALG_SHA256);
+	/* object properties */
+	tpm_buf_append_u32(&template, TPM2_OA_NO_DA |
+			   TPM2_OA_FIXED_TPM |
+			   TPM2_OA_FIXED_PARENT |
+			   TPM2_OA_SENSITIVE_DATA_ORIGIN |
+			   TPM2_OA_USER_WITH_AUTH |
+			   TPM2_OA_DECRYPT |
+			   TPM2_OA_RESTRICTED);
+	/* sauth policy (empty) */
+	tpm_buf_append_u16(&template, 0);
+
+	/* BEGIN parameters: key specific; for ECC*/
+	/* symmetric algorithm */
+	tpm_buf_append_u16(&template, TPM_ALG_AES);
+	/* bits for symmetric algorithm */
+	tpm_buf_append_u16(&template, 128);
+	/* algorithm mode (must be CFB) */
+	tpm_buf_append_u16(&template, TPM_ALG_CFB);
+	/* scheme (NULL means any scheme) */
+	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	/* ECC Curve ID */
+	tpm_buf_append_u16(&template, TPM2_ECC_NIST_P256);
+	/* KDF Scheme */
+	tpm_buf_append_u16(&template, TPM_ALG_NULL);
+	/* unique: key specific; for ECC it is two points */
+	tpm_buf_append_u16(&template, 0);
+	tpm_buf_append_u16(&template, 0);
+	/* END parameters */
+
+	/* primary handle */
+	tpm_buf_append_u32(&buf, hierarchy);
+	tpm_buf_append_empty_auth(&buf, TPM2_RS_PW);
+	/* sensitive create size is 4 for two empty buffers */
+	tpm_buf_append_u16(&buf, 4);
+	/* sensitive create auth data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* sensitive create sensitive data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* the public template */
+	tpm_buf_append(&buf, template.data, template.length);
+	tpm_buf_destroy(&template);
+	/* outside info (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* creation PCR (none) */
+	tpm_buf_append_u32(&buf, 0);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0,
+			      "attempting to create NULL primary");
+
+	if (rc == TPM2_RC_SUCCESS)
+		rc = tpm2_parse_create_primary(chip, &buf, handle);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+static int tpm2_create_null_primary(struct tpm_chip *chip)
+{
+	u32 nullkey;
+	int rc;
+
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &nullkey);
+
+	if (rc == TPM2_RC_SUCCESS) {
+		unsigned int offset = 0; /* dummy offset for null key context */
+
+		rc = tpm2_save_context(chip, nullkey, chip->null_key_context,
+				       sizeof(chip->null_key_context), &offset);
+		tpm2_flush_context(chip, nullkey);
+	}
+
+	return rc;
+}
+
+/**
+ * tpm2_sessions_init() - start of day initialization for the sessions code
+ * @chip: TPM chip
+ *
+ * Derive and context save the null primary and allocate memory in the
+ * struct tpm_chip for the authorizations.
+ */
+int tpm2_sessions_init(struct tpm_chip *chip)
+{
+	int rc;
+
+	rc = tpm2_create_null_primary(chip);
+	if (rc)
+		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+
+	return rc;
+}
+EXPORT_SYMBOL(tpm2_sessions_init);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6be263509e81..3060ab794afb 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -35,12 +35,15 @@ struct trusted_key_options;
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
 	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_AES		= 0x0006,
 	TPM_ALG_KEYEDHASH	= 0x0008,
 	TPM_ALG_SHA256		= 0x000B,
 	TPM_ALG_SHA384		= 0x000C,
 	TPM_ALG_SHA512		= 0x000D,
 	TPM_ALG_NULL		= 0x0010,
 	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_ECC		= 0x0023,
+	TPM_ALG_CFB		= 0x0043,
 };
 
 /*
@@ -49,6 +52,11 @@ enum tpm_algorithms {
  */
 #define TPM_MAX_HASHES	5
 
+enum tpm2_curves {
+	TPM2_ECC_NONE		= 0x0000,
+	TPM2_ECC_NIST_P256	= 0x0003,
+};
+
 struct tpm_digest {
 	u16 alg_id;
 	u8 digest[TPM_MAX_DIGEST_SIZE];
@@ -116,6 +124,20 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
+/* fixed define for the curve we use which is NIST_P256 */
+#define EC_PT_SZ	32
+
+/*
+ * fixed define for the size of a name.  This is actually HASHALG size
+ * plus 2, so 32 for SHA256
+ */
+#define TPM2_NAME_SIZE	34
+
+/*
+ * The maximum size for an object context
+ */
+#define TPM2_MAX_CONTEXT_SIZE 4096
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -170,6 +192,14 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+	/* details for communication security via sessions */
+	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE]; /* context for NULL seed */
+	u8 null_key_name[TPM2_NAME_SIZE];	 /* name of NULL seed */
+	u8 null_ec_key_x[EC_PT_SZ];
+	u8 null_ec_key_y[EC_PT_SZ];
+#endif
 };
 
 #define TPM_HEADER_SIZE		10
@@ -194,6 +224,7 @@ enum tpm2_timeouts {
 enum tpm2_structures {
 	TPM2_ST_NO_SESSIONS	= 0x8001,
 	TPM2_ST_SESSIONS	= 0x8002,
+	TPM2_ST_CREATION	= 0x8021,
 };
 
 /* Indicates from what layer of the software stack the error comes from */
@@ -243,6 +274,7 @@ enum tpm2_command_codes {
 };
 
 enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
 
@@ -318,7 +350,11 @@ struct tpm_buf {
 enum tpm2_object_attributes {
 	TPM2_OA_FIXED_TPM		= BIT(1),
 	TPM2_OA_FIXED_PARENT		= BIT(4),
+	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
 	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+	TPM2_OA_NO_DA			= BIT(10),
+	TPM2_OA_RESTRICTED		= BIT(16),
+	TPM2_OA_DECRYPT			= BIT(17),
 };
 
 enum tpm2_session_attributes {
@@ -373,6 +409,15 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
+static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
+{
+	/* simple authorization for empty auth */
+	tpm_buf_append_u32(buf, 9);		/* total length of auth */
+	tpm_buf_append_u32(buf, handle);
+	tpm_buf_append_u16(buf, 0);		/* nonce len */
+	tpm_buf_append_u8(buf, 0);		/* attributes */
+	tpm_buf_append_u16(buf, 0);		/* hmac len */
+}
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -399,5 +444,9 @@ static inline struct tpm_chip *tpm_default_chip(void)
 {
 	return NULL;
 }
+
+static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
+{
+}
 #endif
 #endif
-- 
2.35.3


