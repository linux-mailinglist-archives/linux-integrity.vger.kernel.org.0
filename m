Return-Path: <linux-integrity+bounces-6572-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4A2AEDD66
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 14:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F12175ECC
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE14286D7E;
	Mon, 30 Jun 2025 12:47:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8D2701DF;
	Mon, 30 Jun 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287660; cv=none; b=FmYQ1wQVMYZSF/FKc2riRpT7T2W3VyO6bXqDbxH3X1bUIp3qM+wp8uhlSsDEGMP6l61WPJcETWK5jwwlCyoP8FD8KR4YUJysZgRYPOwp42h//iKHE0v1qchaqC2swAvkAHQ8SrecfcYu22v40uPAnedeFzb1iHCrxzhKfFJKk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287660; c=relaxed/simple;
	bh=i6/164pcR4NLefGrudZewZCUwIEFmxRK5pIjFusqjK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0UjzY5MbMYB2CtcnzmzcIo/LmVQ5Iukw0pXrsoQDZXWaC9sZexdJ1QixIhwYHpCwVXMFx0JI8V3CQgseJHWY9ALhWxT09a7RPUpszZGp19VKSSO8btzET04I7OD7t5OXfncXMuuMgxE+pes8gTr3WZPec8A+NB152dZsYnTGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bW5RM4FgRz14Lqf;
	Mon, 30 Jun 2025 20:42:55 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 38329180486;
	Mon, 30 Jun 2025 20:47:35 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 20:47:34 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	Lu Jialin <lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH -next RFC 3/4] ima: rot: Make RoT kick in
Date: Mon, 30 Jun 2025 20:59:27 +0800
Message-ID: <20250630125928.765285-4-gongruiqi1@huawei.com>
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

From now on the RoT framework starts to work, achieved by replacing
multiple variables and function calls to their RoT counterparts.
Specifically,

- Replace ima_tpm_chip with ima_rot_inst at all places related to
  ->{nr_,}allocated_banks, and use the latter to indicate RoT's
  availability;

- Make ima_tpm_chip static in ima_tpm.c;

- Replace ima_pcr_extend() & ima_calc_boot_aggregate() with
  corresponding RoT hooks;

- Initialize RoT with ima_rot_init() instead of tpm_default_chip() in
  ima_init();

Co-developed-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
Signed-off-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
---
 security/integrity/ima/ima.h              |  3 +--
 security/integrity/ima/ima_api.c          |  2 +-
 security/integrity/ima/ima_crypto.c       | 30 +++++++++++------------
 security/integrity/ima/ima_fs.c           |  4 +--
 security/integrity/ima/ima_init.c         | 11 ++++-----
 security/integrity/ima/ima_queue.c        | 27 ++++++++++----------
 security/integrity/ima/ima_template.c     |  2 +-
 security/integrity/ima/ima_template_lib.c |  5 ++--
 security/integrity/ima/ima_tpm.c          |  4 +--
 security/integrity/ima/ima_tpm.h          |  2 --
 10 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 07752e7227b6..31e3f76cdda6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -42,7 +42,7 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 #define IMA_TEMPLATE_IMA_NAME "ima"
 #define IMA_TEMPLATE_IMA_FMT "d|n"
 
-#define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
+#define NR_BANKS(rot) ((rot != NULL) ? rot->nr_allocated_banks : 0)
 
 /* current content of the policy */
 extern int ima_policy_flag;
@@ -64,7 +64,6 @@ extern int ima_extra_slots __ro_after_init;
 extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 
 extern int ima_appraise;
-extern struct tpm_chip *ima_tpm_chip;
 extern struct ima_rot *ima_rot_inst;
 extern const char boot_aggregate_name[];
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8..65cf5b2400f2 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -52,7 +52,7 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	if (!*entry)
 		return -ENOMEM;
 
-	digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+	digests = kcalloc(NR_BANKS(ima_rot_inst) + ima_extra_slots,
 			  sizeof(*digests), GFP_NOFS);
 	if (!digests) {
 		kfree(*entry);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 492d7bc56510..ee53f44b1a30 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -95,7 +95,7 @@ struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 	if (algo == ima_hash_algo)
 		return tfm;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++)
+	for (i = 0; i < NR_BANKS(ima_rot_inst) + ima_extra_slots; i++)
 		if (ima_algo_array[i].tfm && ima_algo_array[i].algo == algo)
 			return ima_algo_array[i].tfm;
 
@@ -121,8 +121,8 @@ int __init ima_init_crypto(void)
 	ima_sha1_idx = -1;
 	ima_hash_algo_idx = -1;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
-		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+	for (i = 0; i < NR_BANKS(ima_rot_inst); i++) {
+		algo = ima_rot_inst->allocated_banks[i].crypto_id;
 		if (algo == HASH_ALGO_SHA1)
 			ima_sha1_idx = i;
 
@@ -131,23 +131,23 @@ int __init ima_init_crypto(void)
 	}
 
 	if (ima_sha1_idx < 0) {
-		ima_sha1_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
+		ima_sha1_idx = NR_BANKS(ima_rot_inst) + ima_extra_slots++;
 		if (ima_hash_algo == HASH_ALGO_SHA1)
 			ima_hash_algo_idx = ima_sha1_idx;
 	}
 
 	if (ima_hash_algo_idx < 0)
-		ima_hash_algo_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
+		ima_hash_algo_idx = NR_BANKS(ima_rot_inst) + ima_extra_slots++;
 
-	ima_algo_array = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+	ima_algo_array = kcalloc(NR_BANKS(ima_rot_inst) + ima_extra_slots,
 				 sizeof(*ima_algo_array), GFP_KERNEL);
 	if (!ima_algo_array) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
-		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+	for (i = 0; i < NR_BANKS(ima_rot_inst); i++) {
+		algo = ima_rot_inst->allocated_banks[i].crypto_id;
 		ima_algo_array[i].algo = algo;
 
 		/* unknown TPM algorithm */
@@ -171,7 +171,7 @@ int __init ima_init_crypto(void)
 		}
 	}
 
-	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip)) {
+	if (ima_sha1_idx >= NR_BANKS(ima_rot_inst)) {
 		if (ima_hash_algo == HASH_ALGO_SHA1) {
 			ima_algo_array[ima_sha1_idx].tfm = ima_shash_tfm;
 		} else {
@@ -186,7 +186,7 @@ int __init ima_init_crypto(void)
 		ima_algo_array[ima_sha1_idx].algo = HASH_ALGO_SHA1;
 	}
 
-	if (ima_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
+	if (ima_hash_algo_idx >= NR_BANKS(ima_rot_inst) &&
 	    ima_hash_algo_idx != ima_sha1_idx) {
 		ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
 		ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
@@ -194,7 +194,7 @@ int __init ima_init_crypto(void)
 
 	return 0;
 out_array:
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+	for (i = 0; i < NR_BANKS(ima_rot_inst) + ima_extra_slots; i++) {
 		if (!ima_algo_array[i].tfm ||
 		    ima_algo_array[i].tfm == ima_shash_tfm)
 			continue;
@@ -214,7 +214,7 @@ void ima_free_tfm(struct crypto_shash *tfm)
 	if (tfm == ima_shash_tfm)
 		return;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++)
+	for (i = 0; i < NR_BANKS(ima_rot_inst) + ima_extra_slots; i++)
 		if (ima_algo_array[i].tfm == tfm)
 			return;
 
@@ -632,12 +632,12 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 
 	entry->digests[ima_sha1_idx].alg_id = TPM_ALG_SHA1;
 
-	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+	for (i = 0; i < NR_BANKS(ima_rot_inst) + ima_extra_slots; i++) {
 		if (i == ima_sha1_idx)
 			continue;
 
-		if (i < NR_BANKS(ima_tpm_chip)) {
-			alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
+		if (i < NR_BANKS(ima_rot_inst)) {
+			alg_id = ima_rot_inst->allocated_banks[i].alg_id;
 			entry->digests[i].alg_id = alg_id;
 		}
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 87045b09f120..b4a9bb5468be 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -394,9 +394,9 @@ static const struct seq_operations ima_policy_seqops = {
 
 static int __init create_securityfs_measurement_lists(void)
 {
-	int count = NR_BANKS(ima_tpm_chip);
+	int count = NR_BANKS(ima_rot_inst);
 
-	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
+	if (ima_sha1_idx >= NR_BANKS(ima_rot_inst))
 		count++;
 
 	for (int i = 0; i < count; i++) {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 8651b11c1edf..096eaa7a7666 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -19,7 +19,6 @@
 #include <generated/utsrelease.h>
 
 #include "ima.h"
-#include "ima_tpm.h"
 
 /* name for boot aggregate entry */
 const char boot_aggregate_name[] = "boot_aggregate";
@@ -72,8 +71,8 @@ static int __init ima_add_boot_aggregate(void)
 	 * Ultimately select SHA1 also for TPM 2.0 if the SHA256 PCR bank
 	 * is not found.
 	 */
-	if (ima_tpm_chip) {
-		result = ima_tpm_calc_boot_aggregate(hash_hdr);
+	if (ima_rot_inst) {
+		result = ima_rot_inst->calc_boot_aggregate(hash_hdr);
 		if (result < 0) {
 			audit_cause = "hashing_error";
 			goto err_out;
@@ -120,9 +119,9 @@ int __init ima_init(void)
 {
 	int rc;
 
-	ima_tpm_chip = tpm_default_chip();
-	if (!ima_tpm_chip)
-		pr_info("No TPM chip found, activating TPM-bypass!\n");
+	ima_rot_inst = ima_rot_init();
+	if (!ima_rot_inst)
+		pr_info("No RoT found, activating RoT-bypass!\n");
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index b91167ef27dc..05ed90d6a608 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -19,7 +19,6 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include "ima.h"
-#include "ima_tpm.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
@@ -158,9 +157,9 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	u8 *digest = entry->digests[ima_hash_algo_idx].digest;
 	struct tpm_digest *digests_arg = entry->digests;
 	const char *audit_cause = "hash_added";
-	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
+	char rot_audit_cause[AUDIT_CAUSE_LEN_MAX];
 	int audit_info = 1;
-	int result = 0, tpmresult = 0;
+	int result = 0, rotresult = 0;
 
 	mutex_lock(&ima_extend_list_mutex);
 
@@ -194,11 +193,11 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	if (violation)		/* invalidate pcr */
 		digests_arg = digests;
 
-	tpmresult = ima_pcr_extend(digests_arg, entry->pcr);
-	if (tpmresult != 0) {
-		snprintf(tpm_audit_cause, AUDIT_CAUSE_LEN_MAX, "TPM_error(%d)",
-			 tpmresult);
-		audit_cause = tpm_audit_cause;
+	rotresult = ima_rot_inst->extend(digests_arg, &entry->pcr);
+	if (rotresult != 0) {
+		snprintf(rot_audit_cause, AUDIT_CAUSE_LEN_MAX, "%s_error(%d)",
+			 ima_rot_inst->name, rotresult);
+		audit_cause = rot_audit_cause;
 		audit_info = 0;
 	}
 out:
@@ -254,18 +253,18 @@ int __init ima_init_digests(void)
 	u16 crypto_id;
 	int i;
 
-	if (!ima_tpm_chip)
+	if (!ima_rot_inst)
 		return 0;
 
-	digests = kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*digests),
+	digests = kcalloc(ima_rot_inst->nr_allocated_banks, sizeof(*digests),
 			  GFP_NOFS);
 	if (!digests)
 		return -ENOMEM;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
-		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
-		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
-		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
+	for (i = 0; i < ima_rot_inst->nr_allocated_banks; i++) {
+		digests[i].alg_id = ima_rot_inst->allocated_banks[i].alg_id;
+		digest_size = ima_rot_inst->allocated_banks[i].digest_size;
+		crypto_id = ima_rot_inst->allocated_banks[i].crypto_id;
 
 		/* for unmapped TPM algorithms digest is still a padded SHA1 */
 		if (crypto_id == HASH_ALGO__LAST)
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 04c49f05cb74..a6ece3557267 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -367,7 +367,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	if (!*entry)
 		return -ENOMEM;
 
-	digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+	digests = kcalloc(NR_BANKS(ima_rot_inst) + ima_extra_slots,
 			  sizeof(*digests), GFP_NOFS);
 	if (!digests) {
 		kfree(*entry);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 67b43e4e4222..e5581bf47601 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -10,7 +10,6 @@
  */
 
 #include "ima_template_lib.h"
-#include "ima_tpm.h"
 #include <linux/xattr.h>
 #include <linux/evm.h>
 
@@ -365,9 +364,9 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	}
 
 	if ((const char *)event_data->filename == boot_aggregate_name) {
-		if (ima_tpm_chip) {
+		if (ima_rot_inst) {
 			hash.hdr.algo = HASH_ALGO_SHA1;
-			result = ima_tpm_calc_boot_aggregate(hash_hdr);
+			result = ima_rot_inst->calc_boot_aggregate(hash_hdr);
 
 			/* algo can change depending on available PCR banks */
 			if (!result && hash.hdr.algo != HASH_ALGO_SHA1)
diff --git a/security/integrity/ima/ima_tpm.c b/security/integrity/ima/ima_tpm.c
index 6ff7ed8ef322..836b7832e2eb 100644
--- a/security/integrity/ima/ima_tpm.c
+++ b/security/integrity/ima/ima_tpm.c
@@ -15,7 +15,7 @@
 #include "ima.h"
 #include "ima_tpm.h"
 
-struct tpm_chip *ima_tpm_chip;
+static struct tpm_chip *ima_tpm_chip;
 
 int ima_tpm_init(struct ima_rot *rot)
 {
@@ -29,7 +29,7 @@ int ima_tpm_init(struct ima_rot *rot)
 	return 0;
 }
 
-int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
+static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
 	int result = 0;
 
diff --git a/security/integrity/ima/ima_tpm.h b/security/integrity/ima/ima_tpm.h
index fa2946073ceb..0fb0e80ea1e7 100644
--- a/security/integrity/ima/ima_tpm.h
+++ b/security/integrity/ima/ima_tpm.h
@@ -16,6 +16,4 @@ int ima_tpm_init(struct ima_rot *rot);
 int ima_tpm_extend(struct tpm_digest *digests_arg, const void *args);
 int ima_tpm_calc_boot_aggregate(struct ima_digest_data *hash);
 
-int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr);
-
 #endif /* __IMA_IMA_TPM_H */
-- 
2.25.1


