Return-Path: <linux-integrity+bounces-7642-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5F4C71296
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3DC24E1B22
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 21:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982D30C36C;
	Wed, 19 Nov 2025 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WhnOO2+j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D53002BD;
	Wed, 19 Nov 2025 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588102; cv=none; b=iOhAktsZtOWiSWYGtD2Znl9daDbo/83lW7hYj++L4J13AWBUEhEz00qZvQ8E6oKgq6sZP0P67hwEve2vrD4J7FTMgfqbHtxNGjWlj+b2NZN5kVxOjQPiT8/bGTKl/aG+4BBhkdOpmMPnljeXQQcc/Pus4+jtMf1e8vq8bryAyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588102; c=relaxed/simple;
	bh=z7XADx5fFBRRwmREpeqO4+11e/gQ3Qc7bb8rsselPPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPOAVbhoeu/HtDMPQNVtKa28BJVTWLjuTRqEiB8DMepP8irLz8x0JKwoGntZ/PtLhidoGL7XoGlr20Bb4vfgBuF2trchrOujWx9S9/uD8/ObujdjNmlovKW+NUcXTXl/5XLbJWYiNKg/LIM7EL8JDJNYKen1zkcPXnWUSsBEXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WhnOO2+j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from denali.. (unknown [71.238.18.239])
	by linux.microsoft.com (Postfix) with ESMTPSA id DBA3D211FEDC;
	Wed, 19 Nov 2025 13:34:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBA3D211FEDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763588098;
	bh=PSazwdI3mnnhsYtI8IhXMQ7bmhSq5/C0vPSzmahsMZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhnOO2+jWsJDGuywP179gvlRnKTQ7WKLv1rGi4AKDdtIhiiCtltpyQeTvizga3sqe
	 WKfWB7kH/HUYFnw/WcQKkI2k8vIjB8iZb4hdczWPQjbCP5zMGqGp/o991D9g23IvJC
	 sSy7Mj6FdAfwvXN+z2gCrR2QbJCQT1NIze/jUMHM=
From: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	Anirudh Venkataramanan <anirudhve@linux.microsoft.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Gregory Lumen <gregorylumen@linux.microsoft.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Sush Shringarputale <sushring@linux.microsoft.com>
Subject: [RFC v1 1/1] ima: Implement IMA event log trimming
Date: Wed, 19 Nov 2025 13:33:18 -0800
Message-ID: <20251119213359.39397-2-anirudhve@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
References: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Chen <chenste@linux.microsoft.com>

Implement a PCR value based method for IMA event log trimming by
exposing a new pseudo file /sys/kernel/config/ima/pcrs. This
pseudo file allows userspace to:

 - read IMA starting PCR values.
 - write trim-to PCR values to trigger IMA log trimming.

If a trimming operation is successful, one or more entries will be
purged from the IMA measurements list in the kernel.

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Signed-off-by: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>
---
 drivers/Kconfig                       |   2 +
 drivers/Makefile                      |   1 +
 drivers/ima/Kconfig                   |  13 +
 drivers/ima/Makefile                  |   2 +
 drivers/ima/ima_config_pcrs.c         | 291 ++++++++++++++++++
 include/linux/ima.h                   |  27 ++
 security/integrity/ima/Makefile       |   4 +
 security/integrity/ima/ima.h          |   8 +
 security/integrity/ima/ima_init.c     |  44 +++
 security/integrity/ima/ima_log_trim.c | 421 ++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c   |   7 +-
 security/integrity/ima/ima_queue.c    |   5 +-
 12 files changed, 821 insertions(+), 4 deletions(-)
 create mode 100644 drivers/ima/Kconfig
 create mode 100644 drivers/ima/Makefile
 create mode 100644 drivers/ima/ima_config_pcrs.c
 create mode 100644 security/integrity/ima/ima_log_trim.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 4915a63866b0..35b83be86c42 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
 
 source "drivers/cdx/Kconfig"
 
+source "drivers/ima/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 8e1ffa4358d5..3aad6096d416 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -197,3 +197,4 @@ obj-$(CONFIG_DPLL)		+= dpll/
 
 obj-$(CONFIG_DIBS)		+= dibs/
 obj-$(CONFIG_S390)		+= s390/
+obj-$(CONFIG_IMA_PCRS)		+= ima/
diff --git a/drivers/ima/Kconfig b/drivers/ima/Kconfig
new file mode 100644
index 000000000000..9e465fbe3adb
--- /dev/null
+++ b/drivers/ima/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config IMA_PCRS
+	bool "IMA Event Log Trimming"
+	default n
+	help
+	  Say Y here if you want support for IMA Event Log Trimming.
+
+	  This creates the configfs file /sys/kernel/config/ima/pcrs.
+	  Userspace
+	  - writes to this file to trigger IMA event log trimming
+	  - reads this file to get IMA starting PCR values
+
+	  If unsure, say N.
diff --git a/drivers/ima/Makefile b/drivers/ima/Makefile
new file mode 100644
index 000000000000..ac9b9b96b5cb
--- /dev/null
+++ b/drivers/ima/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_IMA_PCRS)	+= ima_config_pcrs.o
diff --git a/drivers/ima/ima_config_pcrs.c b/drivers/ima/ima_config_pcrs.c
new file mode 100644
index 000000000000..f329665f2b90
--- /dev/null
+++ b/drivers/ima/ima_config_pcrs.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Microsoft Corporation
+ *
+ * Authors:
+ * Steven Chen <chenste@linux.microsoft.com>
+ *
+ * File: ima_config_pcrs.c
+ *
+ * Implements IMA interface to allow userspace to read IMA starting PCR
+ * values and trigger IMA event log trimming.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/configfs.h>
+#include <linux/printk.h>
+#include <linux/tpm.h>
+#include <linux/ima.h>
+/*
+ * The IMA PCR configfs is a childless subsystem.  It cannot create
+ * any config_items.  It just has attribute pcrs for read and write.
+ */
+
+#define MAX_HASH_ALGO_NAME_LENGTH 16 /*sha1, sha256, ...*/
+#define PCR_NAME_LEN 6  /*pcrxx:*/
+#define MIN_PCR_RECORD_LENGTH 20
+#define OFFSET_IDX_1 3
+#define OFFSET_IDX_2 4
+#define OFFSET_COLON 5
+
+/*
+ * mutex protects atomicity of trimming measurement list
+ * and updating ima_start_point_pcr_values
+ * protects concurrent writes to the IMA PCR values
+ * This also not allow memory allocation while waiting the mutex
+ */
+static DEFINE_MUTEX(ima_pcr_write_mutex);
+
+/* show current IMA Start Point PCR values in ascii format */
+static ssize_t ima_config_pcrs_ascii_show(struct config_item *item, char *page)
+{
+	int len = 0;
+
+	for (int i = 0; i < num_tpm_banks; i++) {
+		for (int j = 0; j < num_pcr_configured; j++) {
+			int algorithm_id = ima_start_point_pcr_values[i].alg_id;
+
+			/*
+			 * Write "pcrXX:AAA:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+			 * where XX is the PCR index (00-23),
+			 * where AAA is the algorithm name, such as sha1, sha256, sha384..
+			 * and x...x is the digest data in hex format
+			 */
+			len += sprintf(page + len, "pcr%02d:", digests_pcr_map[j]);
+			len += sprintf(page + len, "%s:", hash_algo_name[algorithm_id]);
+			for (int k = 0; k < hash_digest_size[algorithm_id]; k++)
+				len += sprintf(page + len, "%02x",
+					ima_start_point_pcr_values[i].digests[j][k]);
+			len += sprintf(page + len, "\n");
+		}
+	}
+	return len;
+}
+
+/* show current IMA Start Point PCR values */
+static ssize_t ima_config_pcrs_show(struct config_item *item, char *page)
+{
+	int len = 0;
+
+	for (int i = 0; i < num_tpm_banks; i++) {
+		int algorithm_id = ima_start_point_pcr_values[i].alg_id;
+
+		for (int j = 0; j < TPM2_PLATFORM_PCR; ++j) {
+			int digest_index = pcr_digests_map[j];
+
+			if (digest_index == -1)
+				continue;
+			/*
+			 * Write "pcrXX:AAA:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+			 * where XX is the PCR index (00-23),
+			 * where AAA is the algorithm name, such as sha1, sha256, sha384..
+			 * and x...x is the digest data in raw format
+			 */
+			len += sprintf(page + len, "pcr%02d:", j);
+			len += sprintf(page + len, "%s:", hash_algo_name[algorithm_id]);
+
+			memcpy(page + len, ima_start_point_pcr_values[i].digests[digest_index],
+			       hash_digest_size[algorithm_id]);
+
+			len += hash_digest_size[algorithm_id];
+		}
+	}
+
+	return len;
+}
+
+/* get PCR index from input string */
+static int get_pcr_idx(char *p, int offset)
+{
+	/* validate digits first */
+	if (!isdigit((unsigned char)p[offset + OFFSET_IDX_1]) ||
+	    !isdigit((unsigned char)p[offset + OFFSET_IDX_2]))
+		return -EINVAL;
+
+	return (p[offset + OFFSET_IDX_1] - '0') * 10 + (p[offset + OFFSET_IDX_2] - '0');
+}
+
+/*
+ * Parse the input data
+ * Get new PCR values and trim IMA event log
+ */
+static ssize_t ima_config_pcrs_store(struct config_item *item, const char *page, size_t count)
+{
+	struct ima_pcr_value *ima_pcr_values;
+	unsigned long pcr_found = 0;
+	char *p = (char *)page;
+	int pcr_count;
+	int offset = 0;
+	int ret = -EINVAL;
+
+	if (count <= 0)
+		return ret;
+
+	if (num_pcr_configured <= 0)
+		return -ENOMEM;
+
+	/*
+	 * Only one thread can write to the PCRs at a time
+	 * Not allocate memory while waiting the mutex
+	 */
+
+	mutex_lock(&ima_pcr_write_mutex);
+
+	pcr_count = num_pcr_configured;
+
+	ima_pcr_values = kcalloc(num_pcr_configured, sizeof(*ima_pcr_values), GFP_KERNEL);
+
+	if (!ima_pcr_values) {
+		ret = -ENOMEM;
+		goto out_notrim_unlock;
+	}
+
+	/*
+	 * parse the input data
+	 * each entry is like: pcrX:AAA:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
+	 * where XX is the PCR index (00-23),
+	 * where AAA is the algorithm name, e.g. sha1, sha256, sha384..
+	 * and x...x is the digest data in binary format
+	 * multiple entries are concatenated together
+	 */
+	while (offset < count) {
+		int index, mapped_index, algo_id, algo_name_len = 0;
+		char algo_name[MAX_HASH_ALGO_NAME_LENGTH];
+		u8 digest_len;
+
+		/* Need at least "pcrXX:AAA:" */
+		if (offset + MIN_PCR_RECORD_LENGTH > count)
+			goto out_nottrim;
+
+		if (memcmp(p + offset, "pcr", 3) != 0 || p[offset + OFFSET_COLON] != ':') {
+			pr_alert("invalid input format\n");
+			goto out_nottrim;
+		}
+
+		/* Get the PCR index*/
+		index = get_pcr_idx(p, offset);
+		if (index < 0 || index >= TPM2_PLATFORM_PCR) {
+			pr_alert("invalid PCR index: %d\n", index);
+			goto out_nottrim;
+		}
+
+		offset += PCR_NAME_LEN;
+
+		while (offset + algo_name_len < count && p[offset + algo_name_len] != ':')
+			++algo_name_len;
+
+		/* Check actual algo name length */
+		if (algo_name_len == 0 || algo_name_len >= MAX_HASH_ALGO_NAME_LENGTH) {
+			pr_err("ima pcr configuration: invalid algorithm name length\n");
+			goto out_nottrim;
+		}
+
+		memcpy(algo_name, p + offset, algo_name_len);
+		algo_name[algo_name_len] = '\0';
+
+		algo_id = match_string(hash_algo_name, HASH_ALGO__LAST, algo_name);
+		/* validate algo_id */
+		if (algo_id < HASH_ALGO_SHA1 || algo_id >= HASH_ALGO__LAST) {
+			pr_err("ima pcr configuration: invalid algorithm ID\n");
+			goto out_nottrim;
+		}
+		digest_len = hash_digest_size[algo_id];
+		offset += algo_name_len + 1;
+		/* validate we have enough data for the digest */
+		if (offset + digest_len > count)
+			goto out_nottrim;
+
+		mapped_index = pcr_digests_map[index];
+
+		if (pcr_digests_map[index] != -1 && !test_bit(index, &pcr_found)) {
+			ima_pcr_values[mapped_index].algo_id = algo_id;
+			set_bit(index, &pcr_found);
+			memcpy(ima_pcr_values[mapped_index].digest, p + offset, digest_len);
+			--pcr_count;
+		} else {
+			pr_alert("invalid PCR index or duplicate PCR set index: %d\n", index);
+			goto out_nottrim;
+		}
+		offset += digest_len;
+	}
+
+	if (pcr_count != 0) {
+		/* not all PCRs are provided */
+		pr_alert("not all PCRs are provided\n");
+		goto out_nottrim;
+	}
+
+	/*
+	 * all configured PCRs values are provided, now recalculate the IMA PCRs
+	 * and check if they can match the these PCR values
+	 * Trim the IMA event logs if the given PCR values match
+	 */
+	ret = ima_trim_event_log((const void *)ima_pcr_values);
+	if (ret >= 0)
+		ret = count;
+
+out_nottrim:
+	kfree(ima_pcr_values);
+out_notrim_unlock:
+	mutex_unlock(&ima_pcr_write_mutex);
+	return ret;
+}
+
+CONFIGFS_ATTR(ima_config_, pcrs);
+CONFIGFS_ATTR_RO(ima_config_, pcrs_ascii);
+
+static struct configfs_attribute *ima_config_pcr_attrs[] = {
+	&ima_config_attr_pcrs,
+	&ima_config_attr_pcrs_ascii,
+	NULL,
+};
+
+static const struct config_item_type ima_config_pcr_type = {
+	.ct_attrs	= ima_config_pcr_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct configfs_subsystem config_ima_pcrs = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "ima",
+			.ci_type = &ima_config_pcr_type,
+		},
+	},
+};
+
+static int __init configfs_ima_pcrs_init(void)
+{
+	struct tpm_chip *tpm_chip;
+	int ret;
+
+	tpm_chip = tpm_default_chip();
+	if (!tpm_chip) {
+		pr_err("No TPM chip found, IMA PCR configfs disabled\n");
+		return -ENODEV;
+	}
+
+	config_group_init(&config_ima_pcrs.su_group);
+	mutex_init(&config_ima_pcrs.su_mutex);
+	ret = configfs_register_subsystem(&config_ima_pcrs);
+	if (ret) {
+		pr_err("Error %d while registering subsystem %s\n",
+		       ret, config_ima_pcrs.su_group.cg_item.ci_namebuf);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit configfs_ima_pcrs_exit(void)
+{
+	configfs_unregister_subsystem(&config_ima_pcrs);
+}
+
+module_init(configfs_ima_pcrs_init);
+module_exit(configfs_ima_pcrs_exit);
+MODULE_DESCRIPTION("IMA PCRS configfs module");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8e29cb4e6a01..f8a6209b9423 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -12,6 +12,8 @@
 #include <linux/security.h>
 #include <linux/kexec.h>
 #include <crypto/hash_info.h>
+#include <linux/tpm.h>
+
 struct linux_binprm;
 
 #ifdef CONFIG_IMA
@@ -24,6 +26,31 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
 
+#ifdef CONFIG_IMA_PCRS
+struct ima_pcr_value {
+	u8 digest[HASH_MAX_DIGESTSIZE];	/* PCR value */
+	u8 algo_id;                     /* Hash algorithm ID */
+};
+
+struct tpm_bank_pcr_values {
+	u16 alg_id;
+	u8 **digests; /* Array of pointers, one per configured PCR */
+};
+
+extern u8 num_tpm_banks;
+extern u8 num_pcr_configured;
+
+extern signed char algo_pcr_bank_map[HASH_ALGO__LAST];
+extern signed char pcr_digests_map[TPM2_PLATFORM_PCR];
+extern signed char digests_pcr_map[TPM2_PLATFORM_PCR];
+
+extern struct tpm_bank_pcr_values *ima_start_point_pcr_values;
+
+extern int ima_trim_event_log(const void *bin);
+#else
+static inline int ima_trim_event_log(const void *bin) { return 0; }
+#endif /* CONFIG_IMA_PCRS */
+
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
 #else
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b376d38b4ee6..ae9ce210638d 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -18,3 +18,7 @@ ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
 endif
+
+ifeq ($(CONFIG_IMA_PCRS),y)
+ima-y += ima_log_trim.o
+endif
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..d9accf504e42 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -55,6 +55,8 @@ struct ima_algo_desc {
 	enum hash_algo algo;
 };
 
+extern struct mutex ima_extend_list_mutex; /* protects extending measurement list */
+
 /* set during initialization */
 extern int ima_hash_algo __ro_after_init;
 extern int ima_sha1_idx __ro_after_init;
@@ -250,6 +252,12 @@ void ima_measure_kexec_event(const char *event_name);
 static inline void ima_measure_kexec_event(const char *event_name) {}
 #endif
 
+#ifdef CONFIG_IMA_PCRS
+extern int ima_add_configured_pcr(int new_pcr_index);
+#else
+static inline int ima_add_configured_pcr(int new_pcr_index) { return 0; }
+#endif /* CONFIG_IMA_PCRS */
+
 /*
  * The default binary_runtime_measurements list format is defined as the
  * platform native format.  The canonical format is defined as little-endian.
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a2f34f2d8ad7..1102d2073336 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -24,6 +24,16 @@
 const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
 
+#ifdef CONFIG_IMA_PCRS
+u8 num_tpm_banks;
+u8 num_pcr_configured;
+signed char algo_pcr_bank_map[HASH_ALGO__LAST];
+signed char digests_pcr_map[TPM2_PLATFORM_PCR];
+signed char pcr_digests_map[TPM2_PLATFORM_PCR];
+
+struct tpm_bank_pcr_values *ima_start_point_pcr_values;
+#endif
+
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
  *
@@ -134,6 +144,40 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
+#ifdef CONFIG_IMA_PCRS
+
+	num_tpm_banks = 0;
+	num_pcr_configured = 0;
+
+	for (int i = 0; i < TPM2_PLATFORM_PCR; i++) {
+		pcr_digests_map[i] = -1;
+		digests_pcr_map[i] = -1;
+	}
+
+	for (int i = 0; i < HASH_ALGO__LAST; i++)
+		algo_pcr_bank_map[i] = -1;
+
+	if (ima_tpm_chip) {
+		num_tpm_banks = ima_tpm_chip->nr_allocated_banks;
+		/* Allocate memory for the ima start point PCR values */
+		ima_start_point_pcr_values = kcalloc(num_tpm_banks,
+						     sizeof(*ima_start_point_pcr_values),
+						     GFP_KERNEL);
+
+		if (!ima_start_point_pcr_values)
+			return -ENOMEM;
+
+		for (int i = 0; i < num_tpm_banks; i++) {
+			int algo_id = ima_tpm_chip->allocated_banks[i].crypto_id;
+
+			ima_start_point_pcr_values[i].alg_id = algo_id;
+			algo_pcr_bank_map[algo_id] = i;
+		}
+
+		ima_add_configured_pcr(CONFIG_IMA_MEASURE_PCR_IDX);
+	}
+#endif
+
 	/* It can be called before ima_init_digests(), it does not use TPM. */
 	ima_load_kexec_buffer();
 
diff --git a/security/integrity/ima/ima_log_trim.c b/security/integrity/ima/ima_log_trim.c
new file mode 100644
index 000000000000..85025d502db2
--- /dev/null
+++ b/security/integrity/ima/ima_log_trim.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Microsoft Corporation
+ *
+ * Authors:
+ * Steven Chen <chenste@linux.microsoft.com>
+ *
+ * File: ima_log_trim.c
+ *	Implements PCR value based IMA Event Log Trimming
+ */
+
+#include <linux/fcntl.h>
+#include <linux/kernel_read_file.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/vmalloc.h>
+#include <linux/ima.h>
+#include <crypto/hash_info.h>
+
+#include "ima.h"
+
+struct digest_value {
+	u8 digest[HASH_MAX_DIGESTSIZE];	/* digest value */
+};
+
+/* Average IMA event log data length */
+#define EXTEND_BUF_LEN 300
+
+static struct digest_value *ima_extended_pcr;
+static struct ima_pcr_value *target_pcr_values;
+static unsigned long pcr_matched;
+static int pcr_match_needed;
+
+/* Calculate the hash digest for the given data using the specified algorithm */
+static int ima_calculate_pcr(const void *data, size_t len, u8 *md, int algo)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	int ret = 0, size;
+
+	tfm = crypto_alloc_shash(hash_algo_name[algo], 0, 0);
+
+	if (IS_ERR(tfm)) {
+		ret = -ENOMEM;
+		goto out_nocleanup;
+	}
+
+	/* Allocate memory for the shash_desc structure and initialize it */
+	size = sizeof(struct shash_desc) + crypto_shash_descsize(tfm);
+
+	desc = kzalloc(size, GFP_KERNEL);
+	if (!desc) {
+		crypto_free_shash(tfm);
+		ret = -ENOMEM;
+		goto out_nocleanup;
+	}
+
+	desc->tfm = tfm;
+
+	if (crypto_shash_init(desc)) {
+		ret = -EINVAL;
+		goto out_cleanup;
+	}
+
+	/* Update the hash with the input data */
+	if (crypto_shash_update(desc, data, len)) {
+		ret = -EINVAL;
+		goto out_cleanup;
+	}
+
+	/* Finalize the hash and retrieve the digest */
+	ret = crypto_shash_final(desc, md);
+	if (ret)
+		goto out_cleanup;
+
+	ret = crypto_shash_digestsize(tfm);
+
+out_cleanup:
+	kfree(desc);
+	crypto_free_shash(tfm);
+out_nocleanup:
+	return ret;
+}
+
+/* Add a new configured PCR */
+int ima_add_configured_pcr(int new_pcr_index)
+{
+	if (!ima_tpm_chip)
+		return -1;
+
+	if (new_pcr_index < 0 || new_pcr_index >= TPM2_PLATFORM_PCR)
+		return -1;
+
+	if (pcr_digests_map[new_pcr_index] != -1)
+		return 0;
+
+	/*
+	 * For each TPM bank, expand one more entry for the new PCR
+	 * Allocate new PCR digest buffers for the new PCR
+	 */
+	for (int i = 0; i < num_tpm_banks; ++i) {
+		int length = hash_digest_size[ima_start_point_pcr_values[i].alg_id];
+		u8 *new_pcr = kmalloc(sizeof(u8) * length, GFP_KERNEL);
+		u8 **new_buf;
+
+		if (!new_pcr)
+			return -ENOMEM;
+		memset(new_pcr, 0, sizeof(u8) * length);
+		new_buf = (u8 **)krealloc(ima_start_point_pcr_values[i].digests,
+					(num_pcr_configured + 1) * sizeof(u8 *), GFP_KERNEL);
+		if (!new_buf) {
+			kfree(new_pcr);
+			return -ENOMEM;
+		}
+		new_buf[num_pcr_configured] = new_pcr;
+		ima_start_point_pcr_values[i].digests = new_buf;
+	}
+
+	pcr_digests_map[new_pcr_index] = num_pcr_configured;
+	digests_pcr_map[num_pcr_configured] = new_pcr_index;
+
+	++num_pcr_configured;
+	return 0;
+}
+
+/* Delete the IMA event logs */
+static int ima_purge_event_log(int number_logs)
+{
+	struct ima_queue_entry *qe;
+	int cur = 0;
+
+	mutex_lock(&ima_extend_list_mutex);
+	rcu_read_lock();
+
+	/*
+	 * Remove this entry from both hash table and the measurement list
+	 * When removing from hash table, decrease the length counter
+	 * so that the hash table re-sizing logic works correctly
+	 */
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		/* if CONFIG_IMA_DISABLE_HTABLE is set, the hash table is not used */
+		if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE))
+			hlist_del_rcu(&qe->hnext);
+
+		atomic_long_dec(&ima_htable.len);
+		list_del_rcu(&qe->later);
+		++cur;
+		if (cur >= number_logs)
+			break;
+	}
+
+	rcu_read_unlock();
+	mutex_unlock(&ima_extend_list_mutex);
+	return cur;
+}
+
+/* compare the target PCR values with IMA Start Point PCR Values */
+static int ima_compare_pcr_values(struct ima_pcr_value *target_pcr_val)
+{
+	int count_not_matched = 0;
+
+	for (int i = 0; i < num_pcr_configured; ++i) {
+		int algo_id_tmp;
+		int bank_id_tmp;
+		int hash_size;
+
+		algo_id_tmp = target_pcr_val[i].algo_id;
+		bank_id_tmp = algo_pcr_bank_map[algo_id_tmp];
+		hash_size = hash_digest_size[algo_id_tmp];
+
+		if (bank_id_tmp < 0 || bank_id_tmp >= num_tpm_banks)
+			return -EINVAL;
+
+		/* already matched this PCR, skip it */
+		if (memcmp(ima_start_point_pcr_values[bank_id_tmp].digests[i],
+			   target_pcr_val[i].digest, hash_size) == 0) {
+			set_bit(i, &pcr_matched);
+			continue;
+		}
+		count_not_matched++;
+	}
+	return count_not_matched;
+}
+
+static int ima_recalculate_check_pcrs(int pcr_map_index, char *org_pointer, char *digest_pointer,
+				      int total_length, bool digest_zero)
+{
+	int ret = 0;
+
+	/* Recalculate the PCR for each bank */
+	for (int i = 0; i < num_tpm_banks; i++) {
+		int digest_len, crypto_id, hash_size, idx, len;
+		u8 digest[HASH_MAX_DIGESTSIZE];
+
+		crypto_id = ima_start_point_pcr_values[i].alg_id;
+		hash_size = hash_digest_size[crypto_id];
+		digest_len = 0;
+		/* Prepare digest buffer */
+		if (digest_zero) {
+			/* all zero digest, use 0xFF to extend */
+			memset(digest, 0xFF, HASH_MAX_DIGESTSIZE);
+			digest_len = hash_size;
+		} else {
+			memcpy(digest_pointer, org_pointer, total_length);
+			digest_len = ima_calculate_pcr(digest_pointer, total_length, digest,
+						       crypto_id);
+			if (digest_len < 0) {
+				ret = digest_len;
+				break;
+			}
+		}
+
+		len = digest_len + hash_size;
+
+		idx = i * num_pcr_configured + pcr_map_index;
+		memcpy(digest_pointer, ima_extended_pcr[idx].digest, hash_size);
+		memcpy(digest_pointer + hash_size, digest, digest_len);
+
+		/* Recalculate the PCR starting with the IMA Start Point PCR value */
+		digest_len = ima_calculate_pcr(digest_pointer, len, ima_extended_pcr[idx].digest,
+					       crypto_id);
+
+		if (digest_len < 0) {
+			ret = digest_len;
+			break;
+		}
+
+		/*
+		 * Check if the extended PCR value matches the target PCR value
+		 * if matched, mark this PCR as matched
+		 * if all PCRs matched, set the entry_found flag
+		 */
+		if (crypto_id == target_pcr_values[pcr_map_index].algo_id) {
+			if (memcmp(ima_extended_pcr[idx].digest,
+				   target_pcr_values[pcr_map_index].digest, hash_size) == 0) {
+				set_bit(pcr_map_index, &pcr_matched);
+				--pcr_match_needed;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int ima_get_log_count(void)
+{
+	u8 algo_digest_buffer[EXTEND_BUF_LEN];
+	u8 digest_buffer[EXTEND_BUF_LEN];
+	struct ima_queue_entry *qe;
+	int count = 0;
+	int ret = 0;
+	unsigned int hash_digest_length;
+
+	/* Event log digests algorithm is SHA1 */
+	hash_digest_length = hash_digest_size[HASH_ALGO_SHA1];
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		char *org_digest_pointer, *digest_pointer;
+		int pcr_idx, pcr_map_index, total_length;
+		struct ima_template_entry *e = qe->entry;
+		bool digest_zero;
+
+		if (!qe->entry) {
+			ret = -EINVAL;
+			break;
+		}
+		pcr_idx = e->pcr;
+		pcr_map_index = pcr_digests_map[pcr_idx];
+
+		if (test_bit(pcr_map_index, &pcr_matched) || pcr_digests_map[pcr_idx] == -1) {
+			/* already matched this PCR, something wrong */
+			ret = -EINVAL;
+			break;
+		}
+		/* The original digest buffer is used to save data for multiple banks/algorithms */
+		org_digest_pointer = digest_buffer;
+		digest_pointer = algo_digest_buffer;
+
+		total_length = e->template_data_len;
+
+		/* Allocate large memory for the original and digest buffers if needed */
+		if (total_length > EXTEND_BUF_LEN) {
+			org_digest_pointer = kzalloc(total_length, GFP_KERNEL);
+			if (!org_digest_pointer) {
+				ret = -ENOMEM;
+				break;
+			}
+			digest_pointer = kzalloc(total_length, GFP_KERNEL);
+			if (!digest_pointer) {
+				kfree(org_digest_pointer);
+				ret = -ENOMEM;
+				break;
+			}
+		}
+
+		digest_zero = true;
+		/*
+		 * Check if the original digest is all zeros or not
+		 * if not all zero, use template data to recalculate PCR
+		 */
+		if (memchr_inv(e->digests->digest, 0, hash_digest_length) != NULL) {
+			int offset = 0;
+
+			for (int i = 0; i < e->template_desc->num_fields; i++) {
+				memcpy(org_digest_pointer + offset, &e->template_data[i].len,
+				       sizeof(e->template_data[i].len));
+				offset += sizeof(e->template_data[i].len);
+				memcpy(org_digest_pointer + offset, e->template_data[i].data,
+				       e->template_data[i].len);
+				offset += e->template_data[i].len;
+			}
+			digest_zero = false;
+		}
+
+		count++;
+
+		/* Check if this log entry can match the target PCRs */
+		ret = ima_recalculate_check_pcrs(pcr_map_index, org_digest_pointer,
+						 digest_pointer, total_length, digest_zero);
+
+		if (total_length > EXTEND_BUF_LEN) {
+			kfree(org_digest_pointer);
+			kfree(digest_pointer);
+		}
+
+		/* If entry found or error occurred, break the loop */
+		if (ret < 0 || pcr_match_needed <= 0)
+			break;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	if (pcr_match_needed <= 0)
+		return count;
+	else
+		return 0;
+}
+
+/*
+ * Trim the IMA event log to match the given PCR values
+ * Return:
+ *  >0: number of log entries removed
+ *   0: no log entries removed
+ *  -1: error
+ *  -ENOENT: no matching log entry found
+ *  -EIO: I/O error when removing log entries
+ *  -EINVAL: invalid parameter
+ *  -ENOMEM: memory allocation failure
+ */
+int ima_trim_event_log(const void *bin)
+{
+	int count, ret = -1;
+
+	count = 0;
+	target_pcr_values = (struct ima_pcr_value *)bin;
+	pcr_matched = 0;
+
+	pcr_match_needed = ima_compare_pcr_values(target_pcr_values);
+
+	/* No need to trim */
+	if (pcr_match_needed <= 0) {
+		ret = 0;
+		goto out_nofree;
+	}
+
+	ima_extended_pcr = kcalloc(num_tpm_banks * num_pcr_configured,
+				   sizeof(*ima_extended_pcr), GFP_KERNEL);
+
+	if (!ima_extended_pcr) {
+		ret = -ENOMEM;
+		goto out_nofree;
+	}
+
+	/* Initialize ima_extended_pcr with ima_start_point_pcr_values */
+	for (int i = 0; i < num_tpm_banks; i++) {
+		int length = hash_digest_size[ima_start_point_pcr_values[i].alg_id];
+
+		for (int j = 0; j < num_pcr_configured; ++j) {
+			int record_index = i * num_pcr_configured + j;
+
+			memcpy(ima_extended_pcr[record_index].digest,
+			       ima_start_point_pcr_values[i].digests[j], length);
+		}
+	}
+
+	ret = ima_get_log_count();
+
+	if (ret <= 0)
+		goto out_notrim;
+
+	count = ret;
+
+	/* Remove logs from the IMA log list */
+	ret = ima_purge_event_log(count);
+
+	if (ret == count) {
+		/* Update the IMA Start Point PCR values */
+		for (int i = 0; i < num_tpm_banks; i++) {
+			int algorithm_id = ima_start_point_pcr_values[i].alg_id;
+			int hash_size = hash_digest_size[algorithm_id];
+
+			for (int j = 0; j < num_pcr_configured; j++) {
+				int ext_idx = i * num_pcr_configured + j;
+
+				memcpy(ima_start_point_pcr_values[i].digests[j],
+				       ima_extended_pcr[ext_idx].digest, hash_size);
+			}
+		}
+	} else {
+		/* something wrong, should not happen */
+		ret = -EIO;
+	}
+
+out_notrim:
+	kfree(ima_extended_pcr);
+
+out_nofree:
+	return ret;
+}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7468afaab686..fe537827ac1f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1895,10 +1895,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			ima_log_string(ab, "pcr", args[0].from);
 
 			result = kstrtoint(args[0].from, 10, &entry->pcr);
-			if (result || INVALID_PCR(entry->pcr))
+			if (result || INVALID_PCR(entry->pcr)) {
 				result = -EINVAL;
-			else
+			} else {
 				entry->flags |= IMA_PCR;
+				if (ima_add_configured_pcr(entry->pcr) < 0)
+					result = -EINVAL;
+			}
 
 			break;
 		case Opt_template:
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 590637e81ad1..7bbfdd2ce3b0 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -39,11 +39,12 @@ struct ima_h_table ima_htable = {
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
-/* mutex protects atomicity of extending measurement list
+/*
+ * This mutex protects atomicity of extending measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
  */
-static DEFINE_MUTEX(ima_extend_list_mutex);
+DEFINE_MUTEX(ima_extend_list_mutex);
 
 /*
  * Used internally by the kernel to suspend measurements.
-- 
2.43.0


