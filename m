Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E9523A93B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 17:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgHCPP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbgHCPP5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 11:15:57 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DDDC8B0F2CA1B972FFBF;
        Mon,  3 Aug 2020 16:15:54 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 16:15:54 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 3 Aug 2020 17:15:54 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
Subject: [RFC][PATCH 1/3] ima: Add support for measurement with digest lists
Date:   Mon, 3 Aug 2020 17:13:11 +0200
Message-ID: <20200803151313.17510-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
In-Reply-To: <20200803151313.17510-1-roberto.sassu@huawei.com>
References: <20200803151313.17510-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA-Measure creates a new measurement entry every time a file is measured,
unless the same entry is already in the measurement list.

This patch introduces a new type of measurement list, recognizable by the
PCR number specified with the new ima_digest_list_pcr= kernel option. This
type of measurement list includes measurements of digest lists and files
not found in those lists.

The benefit of this patch is the availability of a predictable PCR that
can be used to seal data or TPM keys to the OS software. Unlike standard
measurements, digest list measurements only indicate that files with a
digest in those lists could have been accessed, but not if and when. With
standard measurements, however, the chosen PCR is unlikely predictable.

Both standard and digest list measurements can be generated at the same
time by adding '+' as a prefix to the value of ima_digest_list_pcr=
(example: with ima_digest_list_pcr=+11, IMA generates standard measurements
with PCR 10 and digest list measurements with PCR 11).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++
 security/integrity/ima/ima.h                  |  9 ++--
 security/integrity/ima/ima_api.c              | 42 +++++++++++++++----
 security/integrity/ima/ima_digest_list.c      | 25 +++++++++++
 security/integrity/ima/ima_init.c             |  2 +-
 security/integrity/ima/ima_main.c             | 18 +++++++-
 security/integrity/ima/ima_policy.c           |  3 +-
 security/integrity/integrity.h                |  1 +
 8 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2647c5622f0f..6a44594c10d7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1696,6 +1696,15 @@
 			Use the canonical format for the binary runtime
 			measurements, instead of host native format.
 
+	ima_digest_list_pcr=
+			[IMA]
+			Specify which PCR is extended when file digests are
+			not found in the loaded digest lists. If '+' is not
+			specified, no measurement entry is created if the
+			digest is found. Otherwise, IMA creates also entries
+			with PCR 10, according to the existing behavior.
+			Format: { [+]<unsigned int> }
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0a5d1f813f36..7af7620b770a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -57,6 +57,8 @@ extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern int ima_digest_list_pcr;
+extern bool ima_plus_standard_pcr;
 extern const char boot_aggregate_name[];
 extern int ima_digest_list_actions;
 
@@ -250,7 +252,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc);
+			   struct ima_template_desc *template_desc,
+			   struct ima_digest *digest);
 void process_buffer_measurement(const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
 				int pcr, const char *keyring);
@@ -260,8 +263,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry,
 			    struct ima_template_desc *template_desc);
 int ima_store_template(struct ima_template_entry *entry, int violation,
-		       struct inode *inode,
-		       const unsigned char *filename, int pcr);
+		       struct inode *inode, const unsigned char *filename,
+		       int pcr, struct ima_digest *digest);
 void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index bf22de8b7ce0..45a2ce2f1fe2 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -101,11 +101,13 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
  */
 int ima_store_template(struct ima_template_entry *entry,
 		       int violation, struct inode *inode,
-		       const unsigned char *filename, int pcr)
+		       const unsigned char *filename, int pcr,
+		       struct ima_digest *digest)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "hashing_error";
 	char *template_name = entry->template_desc->name;
+	struct ima_template_entry *duplicated_entry = NULL;
 	int result;
 
 	if (!violation) {
@@ -118,8 +120,26 @@ int ima_store_template(struct ima_template_entry *entry,
 			return result;
 		}
 	}
+
+	if (ima_plus_standard_pcr && !digest) {
+		duplicated_entry = kmemdup(entry,
+			sizeof(*entry) + entry->template_desc->num_fields *
+			sizeof(struct ima_field_data), GFP_KERNEL);
+		if (duplicated_entry)
+			duplicated_entry->pcr = ima_digest_list_pcr;
+	} else if (!ima_plus_standard_pcr && ima_digest_list_pcr >= 0) {
+		pcr = ima_digest_list_pcr;
+	}
+
 	entry->pcr = pcr;
 	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	if (!result && duplicated_entry) {
+		result = ima_add_template_entry(duplicated_entry, violation, op,
+						inode, filename);
+		if (result < 0)
+			kfree(duplicated_entry);
+	}
+
 	return result;
 }
 
@@ -151,8 +171,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		result = -ENOMEM;
 		goto err_out;
 	}
-	result = ima_store_template(entry, violation, inode,
-				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
+	result = ima_store_template(entry, violation, inode, filename,
+				    CONFIG_IMA_MEASURE_PCR_IDX, NULL);
 	if (result < 0)
 		ima_free_template_entry(entry);
 err_out:
@@ -297,13 +317,14 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
-			   struct ima_template_desc *template_desc)
+			   struct ima_template_desc *template_desc,
+			   struct ima_digest *digest)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
 	int result = -ENOMEM;
 	struct inode *inode = file_inode(file);
-	struct ima_template_entry *entry;
+	struct ima_template_entry *entry = NULL;
 	struct ima_event_data event_data = { .iint = iint,
 					     .file = file,
 					     .filename = filename,
@@ -321,6 +342,11 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
 		return;
 
+	if (digest && !ima_plus_standard_pcr && ima_digest_list_pcr >= 0) {
+		result = -EEXIST;
+		goto out;
+	}
+
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
@@ -328,12 +354,14 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		return;
 	}
 
-	result = ima_store_template(entry, violation, inode, filename, pcr);
+	result = ima_store_template(entry, violation, inode, filename, pcr,
+				    digest);
+out:
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
 	}
-	if (result < 0)
+	if (result < 0 && entry)
 		ima_free_template_entry(entry);
 }
 
diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index 607a33ba52ee..7e901bdb4340 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -28,6 +28,31 @@ struct ima_h_table ima_digests_htable = {
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
+static int __init digest_list_pcr_setup(char *str)
+{
+	int pcr, ret;
+
+	ret = kstrtouint(str, 10, &pcr);
+	if (ret) {
+		pr_err("Invalid PCR number %s\n", str);
+		return 1;
+	}
+
+	if (pcr == CONFIG_IMA_MEASURE_PCR_IDX) {
+		pr_err("Default PCR cannot be used for digest lists\n");
+		return 1;
+	}
+
+	ima_digest_list_pcr = pcr;
+	ima_digest_list_actions |= IMA_MEASURE;
+
+	if (*str == '+')
+		ima_plus_standard_pcr = true;
+
+	return 1;
+}
+__setup("ima_digest_list_pcr=", digest_list_pcr_setup);
+
 /*************************
  * Get/add/del functions *
  *************************/
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 4902fe7bd570..5b5edd3a6b9e 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -86,7 +86,7 @@ static int __init ima_add_boot_aggregate(void)
 
 	result = ima_store_template(entry, violation, NULL,
 				    boot_aggregate_name,
-				    CONFIG_IMA_MEASURE_PCR_IDX);
+				    CONFIG_IMA_MEASURE_PCR_IDX, NULL);
 	if (result < 0) {
 		ima_free_template_entry(entry);
 		audit_cause = "store_entry";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e14632cf5c1b..ca80e7c5b885 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 
 #include "ima.h"
+#include "ima_digest_list.h"
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
@@ -38,6 +39,10 @@ int ima_hash_algo = HASH_ALGO_SHA1;
 
 /* Actions (measure/appraisal) for which digest lists can be used */
 int ima_digest_list_actions;
+/* PCR used for digest list measurements */
+int ima_digest_list_pcr = -1;
+/* Flag to include standard measurement if digest list PCR is specified */
+bool ima_plus_standard_pcr;
 
 static int hash_setup_done;
 
@@ -162,6 +167,8 @@ static enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
 			return ima_hash_algo;
 		return sig->hash_algo;
 		break;
+	case EVM_IMA_XATTR_DIGEST_LIST:
+		fallthrough;
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
 		ret = xattr_value->data[0];
@@ -255,6 +262,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	const char *pathname = NULL;
 	int rc = 0, action, must_appraise = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_digest *found_digest;
 	struct evm_ima_xattr_data *xattr_value = NULL;
 	struct modsig *modsig = NULL;
 	int xattr_len = 0;
@@ -384,10 +392,16 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	found_digest = ima_lookup_digest(iint->ima_hash->digest, hash_algo,
+					 COMPACT_FILE);
+
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
+				      template_desc,
+				      ima_digest_allow(found_digest,
+						       IMA_MEASURE));
+
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
@@ -858,7 +872,7 @@ void process_buffer_measurement(const void *buf, int size,
 	if (ret < 0)
 		goto out;
 
-	ret = ima_store_template(entry, violation, NULL, buf, pcr);
+	ret = ima_store_template(entry, violation, NULL, buf, pcr, NULL);
 
 	if (ret < 0)
 		ima_free_template_entry(entry);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index dd7f22a846a2..4af9c1613c8e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1305,7 +1305,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			ima_log_string(ab, "pcr", args[0].from);
 
 			result = kstrtoint(args[0].from, 10, &entry->pcr);
-			if (result || INVALID_PCR(entry->pcr))
+			if (result || INVALID_PCR(entry->pcr) ||
+			    entry->pcr == ima_digest_list_pcr)
 				result = -EINVAL;
 			else
 				entry->flags |= IMA_PCR;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 041edd217829..3525f2d185b3 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -78,6 +78,7 @@ enum evm_ima_xattr_type {
 	EVM_IMA_XATTR_DIGSIG,
 	IMA_XATTR_DIGEST_NG,
 	EVM_XATTR_PORTABLE_DIGSIG,
+	EVM_IMA_XATTR_DIGEST_LIST,
 	IMA_XATTR_LAST
 };
 
-- 
2.27.GIT

