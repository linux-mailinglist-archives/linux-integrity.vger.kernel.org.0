Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5D277F06A
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Aug 2023 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbjHQGOW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Aug 2023 02:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348142AbjHQGOH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Aug 2023 02:14:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D81FCE
        for <linux-integrity@vger.kernel.org>; Wed, 16 Aug 2023 23:14:04 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRF3g3ZkPztSNr;
        Thu, 17 Aug 2023 14:10:23 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 14:14:00 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <corbet@lwn.net>,
        <dmitry.kasatkin@gmail.com>
CC:     <linux-integrity@vger.kernel.org>
Subject: [RFC PATCH -next] ima: Make tpm hash configurable
Date:   Thu, 17 Aug 2023 14:13:34 +0800
Message-ID: <20230817061334.1910-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM2 chips supports algorithms other than SHA1. However, the original
IMA design hardcode template hash to be SHA1.

This patch added CONFIG_IMA_TEMPLATE_HASH as well as ima_tpm_hash=
cmdline argument for configurating template hash. The usage is simuliar
to CONFIG_IMA_DEFAULT_HASH and ima_hash=. The configured hash is checked
against TPM and make sure that the hash algorithm is supported by
ima_tpm_chip.

To accommodate the change, we must put a digest length into binary
measurement list items. The binary measurement list item format is
changed to this:
	16bit-le=pcr#
	16bit-le=template digest size
	char[n]=template digest
	32bit-le=template name size
	char[n]=template name
	[eventdata length]
	eventdata[n]=template specific data
The first element is now a 16bit pcr number and a 16bit template digest
size, instead of the original 32bit pcr number.

The format of ascii_measurement_list is also changed. For sha1 template
hash, the format is the same as before. For other hash algorithms, a
hash name is prepended as such:
"sha256:30ee3e25620478759600be00e06fda7b4fe23bbf575621d480400d536cf54f5b"

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++
 security/integrity/ima/Kconfig                | 36 ++++++++++++-
 security/integrity/ima/ima.h                  |  2 +
 security/integrity/ima/ima_crypto.c           | 51 ++++++++++---------
 security/integrity/ima/ima_fs.c               | 43 +++++++++++-----
 security/integrity/ima/ima_init.c             | 44 +++++++++++++++-
 security/integrity/ima/ima_main.c             |  1 +
 7 files changed, 144 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 647a55fcba27..33ab98d52062 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1987,6 +1987,13 @@
 			The list of supported hash algorithms is defined
 			in crypto/hash_info.h.
 
+	ima_tpm_hash=	[IMA]
+			Format: { sha1 | sha256 | sha512 | ... }
+			default: "sha1"
+
+			The algorithm configured will be checked against the
+			supported algorithm of the TPM chip should it exists.
+
 	ima_policy=	[IMA]
 			The builtin policies to load during IMA setup.
 			Format: "tcb | appraise_tcb | secure_boot |
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index c17660bf5f34..b0e6da3ee257 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -121,9 +121,43 @@ config IMA_DEFAULT_HASH
 	default "sha1" if IMA_DEFAULT_HASH_SHA1
 	default "sha256" if IMA_DEFAULT_HASH_SHA256
 	default "sha512" if IMA_DEFAULT_HASH_SHA512
-	default "wp512" if IMA_DEFAULT_HASH_WP512
 	default "sm3" if IMA_DEFAULT_HASH_SM3
 
+choice
+	prompt "Default template hash algorithm"
+	default IMA_TEMPLATE_HASH_SHA1
+	depends on IMA
+	help
+	   Select the hash algorithm used for the template hash,
+	   and PCR extension.  The compiled default hash algorithm
+	   can be overwritten using the kernel command line
+	   'ima_tpm_hash=' option. The configured algorithm is
+	   checked against the TPM chip used.
+
+	config IMA_TEMPLATE_HASH_SHA1
+		bool "SHA1 (default)"
+		depends on CRYPTO_SHA1=y
+
+	config IMA_TEMPLATE_HASH_SHA256
+		bool "SHA256"
+		depends on CRYPTO_SHA256=y
+
+	config IMA_TEMPLATE_HASH_SHA512
+		bool "SHA512"
+		depends on CRYPTO_SHA512=y
+
+	config IMA_TEMPLATE_HASH_SM3
+		bool "SM3"
+		depends on CRYPTO_SM3_GENERIC=y
+endchoice
+
+config IMA_TEMPLATE_HASH
+	string
+	depends on IMA
+	default "sha1" if IMA_TEMPLATE_HASH_SHA1
+	default "sha256" if IMA_TEMPLATE_HASH_SHA256
+	default "sha512" if IMA_TEMPLATE_HASH_SHA512
+
 config IMA_WRITE_POLICY
 	bool "Enable multiple writes to the IMA policy"
 	depends on IMA
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..a280062abbf8 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -51,8 +51,10 @@ extern atomic_t ima_setxattr_allowed_hash_algorithms;
 
 /* set during initialization */
 extern int ima_hash_algo __ro_after_init;
+extern int ima_tpm_algo __ro_after_init;
 extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
+extern int ima_tpm_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 51ad29940f05..0c748646d000 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -64,6 +64,7 @@ struct ima_algo_desc {
 
 int ima_sha1_idx __ro_after_init;
 int ima_hash_algo_idx __ro_after_init;
+int ima_tpm_algo_idx __ro_after_init;
 /*
  * Additional number of slots reserved, as needed, for SHA1
  * and IMA default algo.
@@ -122,22 +123,22 @@ int __init ima_init_crypto(void)
 	if (rc)
 		return rc;
 
-	ima_sha1_idx = -1;
 	ima_hash_algo_idx = -1;
+	ima_tpm_algo_idx = -1;
 
 	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
-		if (algo == HASH_ALGO_SHA1)
-			ima_sha1_idx = i;
-
 		if (algo == ima_hash_algo)
 			ima_hash_algo_idx = i;
+
+		if (algo == ima_tpm_algo)
+			ima_tpm_algo_idx = i;
 	}
 
-	if (ima_sha1_idx < 0) {
-		ima_sha1_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
+	if (ima_tpm_algo_idx < 0) {
+		ima_tpm_algo_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
 		if (ima_hash_algo == HASH_ALGO_SHA1)
-			ima_hash_algo_idx = ima_sha1_idx;
+			ima_hash_algo_idx = ima_tpm_algo_idx;
 	}
 
 	if (ima_hash_algo_idx < 0)
@@ -160,6 +161,8 @@ int __init ima_init_crypto(void)
 
 		if (algo == ima_hash_algo) {
 			ima_algo_array[i].tfm = ima_shash_tfm;
+			if (ima_tpm_algo == ima_hash_algo)
+				ima_algo_array[i].tfm = ima_shash_tfm;
 			continue;
 		}
 
@@ -175,23 +178,24 @@ int __init ima_init_crypto(void)
 		}
 	}
 
-	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip)) {
-		if (ima_hash_algo == HASH_ALGO_SHA1) {
-			ima_algo_array[ima_sha1_idx].tfm = ima_shash_tfm;
+	if (ima_tpm_algo_idx >= NR_BANKS(ima_tpm_chip)) {
+		if (ima_tpm_algo == ima_hash_algo) {
+			ima_algo_array[ima_tpm_algo_idx].tfm = ima_shash_tfm;
 		} else {
-			ima_algo_array[ima_sha1_idx].tfm =
-						ima_alloc_tfm(HASH_ALGO_SHA1);
-			if (IS_ERR(ima_algo_array[ima_sha1_idx].tfm)) {
-				rc = PTR_ERR(ima_algo_array[ima_sha1_idx].tfm);
+			ima_algo_array[ima_tpm_algo_idx].tfm =
+						ima_alloc_tfm(ima_tpm_algo);
+			if (IS_ERR(ima_algo_array[ima_tpm_algo_idx].tfm)) {
+				rc = PTR_ERR(
+					ima_algo_array[ima_tpm_algo_idx].tfm);
 				goto out_array;
 			}
 		}
 
-		ima_algo_array[ima_sha1_idx].algo = HASH_ALGO_SHA1;
+		ima_algo_array[ima_tpm_algo_idx].algo = ima_tpm_algo;
 	}
 
 	if (ima_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
-	    ima_hash_algo_idx != ima_sha1_idx) {
+	    ima_hash_algo_idx != ima_tpm_algo_idx) {
 		ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
 		ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
 	}
@@ -630,26 +634,25 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 	u16 alg_id;
 	int rc, i;
 
-	rc = ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_idx);
+	rc = ima_calc_field_array_hash_tfm(field_data, entry, ima_tpm_algo_idx);
 	if (rc)
 		return rc;
 
-	entry->digests[ima_sha1_idx].alg_id = TPM_ALG_SHA1;
-
 	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
-		if (i == ima_sha1_idx)
-			continue;
 
 		if (i < NR_BANKS(ima_tpm_chip)) {
 			alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
 			entry->digests[i].alg_id = alg_id;
 		}
 
-		/* for unmapped TPM algorithms digest is still a padded SHA1 */
+		if (i == ima_tpm_algo_idx)
+			continue;
+
+		/* for unmapped TPM algorithms digest full length digest */
 		if (!ima_algo_array[i].tfm) {
 			memcpy(entry->digests[i].digest,
-			       entry->digests[ima_sha1_idx].digest,
-			       TPM_DIGEST_SIZE);
+			       entry->digests[ima_tpm_algo_idx].digest,
+			       TPM_MAX_DIGEST_SIZE);
 			continue;
 		}
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..036eb80c338b 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -117,8 +117,9 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 }
 
 /* print format:
- *       32bit-le=pcr#
- *       char[20]=template digest
+ *       16bit-le=pcr#
+ *       16bit-le=template digest size
+ *       char[n]=template digest
  *       32bit-le=template name size
  *       char[n]=template name
  *       [eventdata length]
@@ -130,7 +131,8 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	u32 pcr, namelen, template_data_len; /* temporary fields */
+	u32 namelen, template_data_len; /* temporary fields */
+	u16 pcr, template_hash_len;
 	bool is_ima_template = false;
 	int i;
 
@@ -147,21 +149,30 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	 * PCR used defaults to the same (config option) in
 	 * little-endian format, unless set in policy
 	 */
-	pcr = !ima_canonical_fmt ? e->pcr : (__force u32)cpu_to_le32(e->pcr);
-	ima_putc(m, &pcr, sizeof(e->pcr));
-
-	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
-
-	/* 3rd: template name size */
+	pcr = !ima_canonical_fmt ? (u16)e->pcr :
+				   (__force u16)cpu_to_le16(e->pcr);
+	ima_putc(m, &pcr, sizeof(pcr));
+
+	/* 2nd: template digest size */
+	template_hash_len = (u16)hash_digest_size[ima_tpm_algo];
+	if (ima_canonical_fmt)
+		template_hash_len =
+			(__force u16)cpu_to_le16(template_hash_len);
+	ima_putc(m, &template_hash_len, sizeof(template_hash_len));
+
+	/* 3rd: template digest */
+	ima_putc(m, e->digests[ima_tpm_algo_idx].digest,
+		 hash_digest_size[ima_tpm_algo]);
+
+	/* 4th: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
 		(__force u32)cpu_to_le32(strlen(template_name));
 	ima_putc(m, &namelen, sizeof(namelen));
 
-	/* 4th:  template name */
+	/* 5th:  template name */
 	ima_putc(m, template_name, strlen(template_name));
 
-	/* 5th:  template length (except for 'ima' template) */
+	/* 6th:  template length (except for 'ima' template) */
 	if (strcmp(template_name, IMA_TEMPLATE_IMA_NAME) == 0)
 		is_ima_template = true;
 
@@ -171,7 +182,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 		ima_putc(m, &template_data_len, sizeof(e->template_data_len));
 	}
 
-	/* 6th:  template specific data */
+	/* 7th:  template specific data */
 	for (i = 0; i < e->template_desc->num_fields; i++) {
 		enum ima_show_type show = IMA_SHOW_BINARY;
 		const struct ima_template_field *field =
@@ -233,8 +244,12 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	/* 1st: PCR used (config option) */
 	seq_printf(m, "%2d ", e->pcr);
 
+	if (ima_tpm_algo != HASH_ALGO_SHA1)
+		seq_printf(m, "%s:", hash_algo_name[ima_tpm_algo]);
+
 	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	ima_print_digest(m, e->digests[ima_tpm_algo_idx].digest,
+			 hash_digest_size[ima_tpm_algo]);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 63979aefc95f..cc54229cb5ae 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -23,6 +23,40 @@
 /* name for boot aggregate entry */
 const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
+static int ima_tpm_algo_tmp = -1;
+
+static bool __init ima_tpm_support_algo(int algo)
+{
+	int j;
+
+	if (algo < 0 || algo > HASH_ALGO__LAST)
+		return false;
+
+	for (j = 0; j < NR_BANKS(ima_tpm_chip); j++) {
+		if (ima_tpm_chip->allocated_banks[j].crypto_id == algo)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * This funciton setup hash algorithm used by TPM extension.
+ * The hash algorithm is checked against supported algorithms
+ * of the chip.
+ *
+ * This function would be called by cmdline handling and ima_init.
+ * A possible situation is when the first time this is called,
+ * ima_tpm_chip has not been initialized yet.
+ */
+static int __init tpm_hash_setup(char *str)
+{
+	ima_tpm_algo_tmp = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (ima_tpm_algo_tmp < 0)
+		pr_err("invalid template hash algorithm \"%s\"", str);
+
+	return 1;
+}
+__setup("ima_tpm_hash=", tpm_hash_setup);
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -117,9 +151,17 @@ int __init ima_init(void)
 {
 	int rc;
 
+	if (ima_tpm_algo_tmp < 0)
+		tpm_hash_setup(CONFIG_IMA_TEMPLATE_HASH);
+
 	ima_tpm_chip = tpm_default_chip();
-	if (!ima_tpm_chip)
+	if (!ima_tpm_chip) {
 		pr_info("No TPM chip found, activating TPM-bypass!\n");
+		ima_tpm_algo = ima_tpm_algo_tmp;
+	} else if (ima_tpm_support_algo(ima_tpm_algo_tmp))
+		ima_tpm_algo = ima_tpm_algo_tmp;
+	else
+		ima_tpm_algo = HASH_ALGO_SHA1;
 
 	rc = integrity_init_keyring(INTEGRITY_KEYRING_IMA);
 	if (rc)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 365db0e43d7c..fa4f6c261cd7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -35,6 +35,7 @@ int ima_appraise;
 #endif
 
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
+int __ro_after_init ima_tpm_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
 static struct notifier_block ima_lsm_policy_notifier = {
-- 
2.17.1

