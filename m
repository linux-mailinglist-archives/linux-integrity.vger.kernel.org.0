Return-Path: <linux-integrity+bounces-6573-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BAAEDD69
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 14:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88796189B469
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376AE289830;
	Mon, 30 Jun 2025 12:47:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA82853E9;
	Mon, 30 Jun 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287661; cv=none; b=JGl3rbkD+1Zv8Ig6RILxny6Eg2l8LfDAFOKtYOkNrjGq+a6MlHdl27W1pco/9TQAvU8HUC1wuE92+SASXt011b2qu6DnjgGZgoNYIeykphjlKa7He623L4I4XOo7+4QqtetUD2SGDC0t3GY4wNiUTXSSj5B6grWUxjPoDDfRvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287661; c=relaxed/simple;
	bh=fcznj8YsQE0z4pBvxWodQlSbyp5XLZvc0hSVIZs44us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uut6xZS/D2XZ7aX65FSqNTri4vseRkVuKd7zfy8ZmPR0QaL14ZaxU4m60kd9CmnFP1wPGiHAotswAuVRKQk/qD76Iw7UFtzOJemsN4ZbAz3FOBHTPUjNsyy9mSFs1tZrscHAL/v2kTWeVdb25pg4JZbAhdZ1EMRqiixGVXIU72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bW5Rh6gfYzCsMc;
	Mon, 30 Jun 2025 20:43:12 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id B00E5140156;
	Mon, 30 Jun 2025 20:47:34 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 20:47:33 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	Lu Jialin <lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH -next RFC 2/4] ima: rot: Prepare TPM as an RoT
Date: Mon, 30 Jun 2025 20:59:26 +0800
Message-ID: <20250630125928.765285-3-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630125928.765285-1-gongruiqi1@huawei.com>
References: <20250630125928.765285-1-gongruiqi1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Adapt TPM devices into the RoT framework, mostly by separating
TPM-specific logic from the IMA code into the new ima_tpm.c file.

Note that although TPM has been set up for the RoT framework, at this
moment the framework doesn't start working yet, and in practice IMA
still runs the same way as before.

No functional change intended for this patch.

Co-developed-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
Signed-off-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 security/integrity/ima/Makefile           |   1 +
 security/integrity/ima/ima.h              |   3 +-
 security/integrity/ima/ima_crypto.c       | 109 +--------------
 security/integrity/ima/ima_init.c         |   4 +-
 security/integrity/ima/ima_queue.c        |  14 +-
 security/integrity/ima/ima_rot.c          |  10 ++
 security/integrity/ima/ima_template_lib.c |   3 +-
 security/integrity/ima/ima_tpm.c          | 154 ++++++++++++++++++++++
 security/integrity/ima/ima_tpm.h          |  21 +++
 9 files changed, 196 insertions(+), 123 deletions(-)
 create mode 100644 security/integrity/ima/ima_tpm.c
 create mode 100644 security/integrity/ima/ima_tpm.h

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b3c8436d941c..1237847f2e60 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_TCG_TPM) += ima_tpm.o
 
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d3375427dc24..07752e7227b6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -269,7 +269,8 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 			 struct ima_digest_data *hash);
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_entry *entry);
-int ima_calc_boot_aggregate(struct ima_digest_data *hash);
+struct crypto_shash *ima_alloc_tfm(enum hash_algo algo);
+void ima_free_tfm(struct crypto_shash *tfm);
 void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct ima_iint_cache *iint, const char *op,
 		       const char *cause);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 6f5696d999d0..492d7bc56510 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -21,6 +21,7 @@
 #include <crypto/hash.h>
 
 #include "ima.h"
+#include "ima_tpm.h"
 
 /* minimum file size for ahash use */
 static unsigned long ima_ahash_minsize;
@@ -83,7 +84,7 @@ static int __init ima_init_ima_crypto(void)
 	return 0;
 }
 
-static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
+struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 {
 	struct crypto_shash *tfm = ima_shash_tfm;
 	int rc, i;
@@ -206,7 +207,7 @@ int __init ima_init_crypto(void)
 	return rc;
 }
 
-static void ima_free_tfm(struct crypto_shash *tfm)
+void ima_free_tfm(struct crypto_shash *tfm)
 {
 	int i;
 
@@ -771,107 +772,3 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 
 	return calc_buffer_shash(buf, len, hash);
 }
-
-static void ima_pcrread(u32 idx, struct tpm_digest *d)
-{
-	if (!ima_tpm_chip)
-		return;
-
-	if (tpm_pcr_read(ima_tpm_chip, idx, d) != 0)
-		pr_err("Error Communicating to TPM chip\n");
-}
-
-/*
- * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
- * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but with
- * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
- * allowing firmware to configure and enable different banks.
- *
- * Knowing which TPM bank is read to calculate the boot_aggregate digest
- * needs to be conveyed to a verifier.  For this reason, use the same
- * hash algorithm for reading the TPM PCRs as for calculating the boot
- * aggregate digest as stored in the measurement list.
- */
-static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
-				       struct crypto_shash *tfm)
-{
-	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} };
-	int rc;
-	u32 i;
-	SHASH_DESC_ON_STACK(shash, tfm);
-
-	shash->tfm = tfm;
-
-	pr_devel("calculating the boot-aggregate based on TPM bank: %04x\n",
-		 d.alg_id);
-
-	rc = crypto_shash_init(shash);
-	if (rc != 0)
-		return rc;
-
-	/* cumulative digest over TPM registers 0-7 */
-	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
-		ima_pcrread(i, &d);
-		/* now accumulate with current aggregate */
-		rc = crypto_shash_update(shash, d.digest,
-					 crypto_shash_digestsize(tfm));
-		if (rc != 0)
-			return rc;
-	}
-	/*
-	 * Extend cumulative digest over TPM registers 8-9, which contain
-	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
-	 * in a typical PCR allocation. Registers 8-9 are only included in
-	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
-	 */
-	if (alg_id != TPM_ALG_SHA1) {
-		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
-			ima_pcrread(i, &d);
-			rc = crypto_shash_update(shash, d.digest,
-						crypto_shash_digestsize(tfm));
-		}
-	}
-	if (!rc)
-		crypto_shash_final(shash, digest);
-	return rc;
-}
-
-int ima_calc_boot_aggregate(struct ima_digest_data *hash)
-{
-	struct crypto_shash *tfm;
-	u16 crypto_id, alg_id;
-	int rc, i, bank_idx = -1;
-
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
-		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
-		if (crypto_id == hash->algo) {
-			bank_idx = i;
-			break;
-		}
-
-		if (crypto_id == HASH_ALGO_SHA256)
-			bank_idx = i;
-
-		if (bank_idx == -1 && crypto_id == HASH_ALGO_SHA1)
-			bank_idx = i;
-	}
-
-	if (bank_idx == -1) {
-		pr_err("No suitable TPM algorithm for boot aggregate\n");
-		return 0;
-	}
-
-	hash->algo = ima_tpm_chip->allocated_banks[bank_idx].crypto_id;
-
-	tfm = ima_alloc_tfm(hash->algo);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	hash->length = crypto_shash_digestsize(tfm);
-	alg_id = ima_tpm_chip->allocated_banks[bank_idx].alg_id;
-	rc = ima_calc_boot_aggregate_tfm(hash->digest, alg_id, tfm);
-
-	ima_free_tfm(tfm);
-
-	return rc;
-}
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 15c51e1b369c..8651b11c1edf 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -19,10 +19,10 @@
 #include <generated/utsrelease.h>
 
 #include "ima.h"
+#include "ima_tpm.h"
 
 /* name for boot aggregate entry */
 const char boot_aggregate_name[] = "boot_aggregate";
-struct tpm_chip *ima_tpm_chip;
 struct ima_rot *ima_rot_inst;
 
 /* Add the boot aggregate to the IMA measurement list and extend
@@ -73,7 +73,7 @@ static int __init ima_add_boot_aggregate(void)
 	 * is not found.
 	 */
 	if (ima_tpm_chip) {
-		result = ima_calc_boot_aggregate(hash_hdr);
+		result = ima_tpm_calc_boot_aggregate(hash_hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
 			goto err_out;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 590637e81ad1..b91167ef27dc 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -19,6 +19,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include "ima.h"
+#include "ima_tpm.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
@@ -142,19 +143,6 @@ unsigned long ima_get_binary_runtime_size(void)
 		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
 }
 
-static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
-{
-	int result = 0;
-
-	if (!ima_tpm_chip)
-		return result;
-
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
-	if (result != 0)
-		pr_err("Error Communicating to TPM chip, result: %d\n", result);
-	return result;
-}
-
 /*
  * Add template entry to the measurement list and hash table, and
  * extend the pcr.
diff --git a/security/integrity/ima/ima_rot.c b/security/integrity/ima/ima_rot.c
index 7a1ae056ea5d..0083d9c4e64e 100644
--- a/security/integrity/ima/ima_rot.c
+++ b/security/integrity/ima/ima_rot.c
@@ -14,6 +14,7 @@
 #include <linux/gfp_types.h>
 
 #include "ima.h"
+#include "ima_tpm.h"
 
 /*
  * Meaning of preferred_rot_name's value:
@@ -34,6 +35,15 @@ static const char *preferred_rot_name;
  * IOW, RoT device that owns higher priority should be placed at the front.
  */
 static struct ima_rot ima_rots[] = {
+#ifdef CONFIG_TCG_TPM
+	{
+		.name = "tpm",
+		.default_pcr = CONFIG_IMA_MEASURE_PCR_IDX,
+		.init = ima_tpm_init,
+		.extend = ima_tpm_extend,
+		.calc_boot_aggregate = ima_tpm_calc_boot_aggregate,
+	},
+#endif
 };
 
 /**
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 0e627eac9c33..67b43e4e4222 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -10,6 +10,7 @@
  */
 
 #include "ima_template_lib.h"
+#include "ima_tpm.h"
 #include <linux/xattr.h>
 #include <linux/evm.h>
 
@@ -366,7 +367,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	if ((const char *)event_data->filename == boot_aggregate_name) {
 		if (ima_tpm_chip) {
 			hash.hdr.algo = HASH_ALGO_SHA1;
-			result = ima_calc_boot_aggregate(hash_hdr);
+			result = ima_tpm_calc_boot_aggregate(hash_hdr);
 
 			/* algo can change depending on available PCR banks */
 			if (!result && hash.hdr.algo != HASH_ALGO_SHA1)
diff --git a/security/integrity/ima/ima_tpm.c b/security/integrity/ima/ima_tpm.c
new file mode 100644
index 000000000000..6ff7ed8ef322
--- /dev/null
+++ b/security/integrity/ima/ima_tpm.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Huawei Technologies Co., Ltd.
+ *
+ * Authors:
+ * GONG Ruiqi <gongruiqi1@huawei.com>
+ *
+ * File: ima_rot_tpm.c
+ *	TPM implementation of IMA RoT
+ */
+
+#include <linux/tpm.h>
+#include <linux/module.h>
+
+#include "ima.h"
+#include "ima_tpm.h"
+
+struct tpm_chip *ima_tpm_chip;
+
+int ima_tpm_init(struct ima_rot *rot)
+{
+	ima_tpm_chip = tpm_default_chip();
+	if (!ima_tpm_chip)
+		return -ENODEV;
+
+	rot->nr_allocated_banks = ima_tpm_chip->nr_allocated_banks;
+	rot->allocated_banks = ima_tpm_chip->allocated_banks;
+
+	return 0;
+}
+
+int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
+{
+	int result = 0;
+
+	if (!ima_tpm_chip)
+		return result;
+
+	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
+	if (result != 0)
+		pr_err("Error Communicating to TPM chip, result: %d\n", result);
+	return result;
+}
+
+int ima_tpm_extend(struct tpm_digest *digests_arg, const void *args)
+{
+	const int pcr = *(const int *)args;
+
+	return ima_pcr_extend(digests_arg, pcr);
+}
+
+static void ima_pcrread(u32 idx, struct tpm_digest *d)
+{
+	if (!ima_tpm_chip)
+		return;
+
+	if (tpm_pcr_read(ima_tpm_chip, idx, d) != 0)
+		pr_err("Error Communicating to TPM chip\n");
+}
+
+/*
+ * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
+ * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but with
+ * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
+ * allowing firmware to configure and enable different banks.
+ *
+ * Knowing which TPM bank is read to calculate the boot_aggregate digest
+ * needs to be conveyed to a verifier.  For this reason, use the same
+ * hash algorithm for reading the TPM PCRs as for calculating the boot
+ * aggregate digest as stored in the measurement list.
+ */
+static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
+				       struct crypto_shash *tfm)
+{
+	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} };
+	int rc;
+	u32 i;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+
+	pr_devel("calculating the boot-aggregate based on TPM bank: %04x\n",
+		 d.alg_id);
+
+	rc = crypto_shash_init(shash);
+	if (rc != 0)
+		return rc;
+
+	/* cumulative digest over TPM registers 0-7 */
+	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
+		ima_pcrread(i, &d);
+		/* now accumulate with current aggregate */
+		rc = crypto_shash_update(shash, d.digest,
+					 crypto_shash_digestsize(tfm));
+		if (rc != 0)
+			return rc;
+	}
+	/*
+	 * Extend cumulative digest over TPM registers 8-9, which contain
+	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
+	 * in a typical PCR allocation. Registers 8-9 are only included in
+	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
+	 */
+	if (alg_id != TPM_ALG_SHA1) {
+		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
+			ima_pcrread(i, &d);
+			rc = crypto_shash_update(shash, d.digest,
+						crypto_shash_digestsize(tfm));
+		}
+	}
+	if (!rc)
+		crypto_shash_final(shash, digest);
+	return rc;
+}
+
+int ima_tpm_calc_boot_aggregate(struct ima_digest_data *hash)
+{
+	struct crypto_shash *tfm;
+	u16 crypto_id, alg_id;
+	int rc, i, bank_idx = -1;
+
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
+		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
+		if (crypto_id == hash->algo) {
+			bank_idx = i;
+			break;
+		}
+
+		if (crypto_id == HASH_ALGO_SHA256)
+			bank_idx = i;
+
+		if (bank_idx == -1 && crypto_id == HASH_ALGO_SHA1)
+			bank_idx = i;
+	}
+
+	if (bank_idx == -1) {
+		pr_err("No suitable TPM algorithm for boot aggregate\n");
+		return 0;
+	}
+
+	hash->algo = ima_tpm_chip->allocated_banks[bank_idx].crypto_id;
+
+	tfm = ima_alloc_tfm(hash->algo);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	hash->length = crypto_shash_digestsize(tfm);
+	alg_id = ima_tpm_chip->allocated_banks[bank_idx].alg_id;
+	rc = ima_calc_boot_aggregate_tfm(hash->digest, alg_id, tfm);
+
+	ima_free_tfm(tfm);
+
+	return rc;
+}
diff --git a/security/integrity/ima/ima_tpm.h b/security/integrity/ima/ima_tpm.h
new file mode 100644
index 000000000000..fa2946073ceb
--- /dev/null
+++ b/security/integrity/ima/ima_tpm.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Huawei Technologies Co., Ltd.
+ *
+ * Authors:
+ * GONG Ruiqi <gongruiqi1@huawei.com>
+ *
+ * File: ima_tpm.h
+ *	Hooks of TPM for IMA RoT
+ */
+
+#ifndef __IMA_IMA_TPM_H
+#define __IMA_IMA_TPM_H
+
+int ima_tpm_init(struct ima_rot *rot);
+int ima_tpm_extend(struct tpm_digest *digests_arg, const void *args);
+int ima_tpm_calc_boot_aggregate(struct ima_digest_data *hash);
+
+int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr);
+
+#endif /* __IMA_IMA_TPM_H */
-- 
2.25.1


