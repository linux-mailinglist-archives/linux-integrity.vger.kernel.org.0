Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6611157265
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 11:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJKDt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 05:03:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2397 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgBJKDt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 05:03:49 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3D9FA2D9A8F8BC6A5F0D;
        Mon, 10 Feb 2020 10:03:47 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 10 Feb 2020 10:03:39 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>,
        <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 5/8] ima: Switch to dynamically allocated buffer for template digests
Date:   Mon, 10 Feb 2020 11:02:44 +0100
Message-ID: <20200210100244.21728-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch dynamically allocates the array of tpm_digest structures in
ima_alloc_init_template() and ima_restore_template_data(). The size of the
array is equal to the number of PCR banks plus ima_extra_slots, to make
room for SHA1 and the IMA default algorithm, when PCR banks with those
algorithms are not allocated.

Calculating the SHA1 digest is mandatory, as SHA1 still remains the default
hash algorithm for the measurement list. When IMA will support the Crypto
Agile format, remaining digests will be also provided.

The position in the measurement entry array of the SHA1 digest is stored in
the ima_sha1_idx global variable and is determined at IMA initialization
time.

Changelog

v2:
- add NR_BANKS macro to return zero if ima_tpm_chip is NULL
- replace ima_num_template_digests with
  NR_BANKS(ima_tpm_chip) + ima_extra_slots (suggested by Mimi)
- add __ro_after_init to declaration of ima_sha1_idx and ima_extra_slots
  (suggested by Mimi)

v1:
- move ima_sha1_idx to ima_crypto.c
- introduce ima_num_template_digests (suggested by Mimi)

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  6 +++++-
 security/integrity/ima/ima_api.c      |  8 ++++++++
 security/integrity/ima/ima_crypto.c   |  7 ++++++-
 security/integrity/ima/ima_fs.c       |  4 ++--
 security/integrity/ima/ima_queue.c    | 10 ++++++----
 security/integrity/ima/ima_template.c | 12 ++++++++++--
 6 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2f380fb92a7a..f04bec2ab83f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -45,11 +45,15 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
 #define IMA_TEMPLATE_IMA_NAME "ima"
 #define IMA_TEMPLATE_IMA_FMT "d|n"
 
+#define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
 /* set during initialization */
 extern int ima_hash_algo;
+extern int ima_sha1_idx __ro_after_init;
+extern int ima_extra_slots __ro_after_init;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 
@@ -92,7 +96,7 @@ struct ima_template_desc {
 
 struct ima_template_entry {
 	int pcr;
-	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
+	struct tpm_digest *digests;
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
 	struct ima_field_data template_data[0];	/* template related data */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 51f562111864..ea6d834a5fab 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -27,6 +27,7 @@ void ima_free_template_entry(struct ima_template_entry *entry)
 	for (i = 0; i < entry->template_desc->num_fields; i++)
 		kfree(entry->template_data[i].data);
 
+	kfree(entry->digests);
 	kfree(entry);
 }
 
@@ -50,6 +51,13 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	if (!*entry)
 		return -ENOMEM;
 
+	(*entry)->digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+				    sizeof(*(*entry)->digests), GFP_NOFS);
+	if (!(*entry)->digests) {
+		result = -ENOMEM;
+		goto out;
+	}
+
 	(*entry)->template_desc = template_desc;
 	for (i = 0; i < template_desc->num_fields; i++) {
 		const struct ima_template_field *field =
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 2d356ae8e823..ea24d2f6b513 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -59,6 +59,10 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
 static struct crypto_shash *ima_shash_tfm;
 static struct crypto_ahash *ima_ahash_tfm;
 
+int ima_sha1_idx __ro_after_init;
+/* Additional number of slots to be reserved for SHA1 and IMA default algo */
+int ima_extra_slots __ro_after_init = 1;
+
 int __init ima_init_crypto(void)
 {
 	long rc;
@@ -502,7 +506,8 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
 	}
 
 	if (!rc)
-		rc = crypto_shash_final(shash, entry->digest);
+		rc = crypto_shash_final(shash,
+					entry->digests[ima_sha1_idx].digest);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2000e8df0301..2b79581d0e25 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -152,7 +152,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -235,7 +235,7 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	seq_printf(m, "%2d ", e->pcr);
 
 	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digest, TPM_DIGEST_SIZE);
+	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..bcd99db9722c 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -57,7 +57,8 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 	key = ima_hash_key(digest_value);
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
-		rc = memcmp(qe->entry->digest, digest_value, TPM_DIGEST_SIZE);
+		rc = memcmp(qe->entry->digests[ima_sha1_idx].digest,
+			    digest_value, TPM_DIGEST_SIZE);
 		if ((rc == 0) && (qe->entry->pcr == pcr)) {
 			ret = qe;
 			break;
@@ -77,7 +78,7 @@ static int get_binary_runtime_size(struct ima_template_entry *entry)
 	int size = 0;
 
 	size += sizeof(u32);	/* pcr */
-	size += sizeof(entry->digest);
+	size += TPM_DIGEST_SIZE;
 	size += sizeof(int);	/* template name size field */
 	size += strlen(entry->template_desc->name);
 	size += sizeof(entry->template_data_len);
@@ -109,7 +110,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 
 	atomic_long_inc(&ima_htable.len);
 	if (update_htable) {
-		key = ima_hash_key(entry->digest);
+		key = ima_hash_key(entry->digests[ima_sha1_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
 	}
 
@@ -173,7 +174,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 
 	mutex_lock(&ima_extend_list_mutex);
 	if (!violation) {
-		memcpy(digest, entry->digest, sizeof(digest));
+		memcpy(digest, entry->digests[ima_sha1_idx].digest,
+		       sizeof(digest));
 		if (ima_lookup_digest_entry(digest, entry->pcr)) {
 			audit_cause = "hash_exists";
 			result = -EEXIST;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 6aa6408603e3..586e9fd9fc12 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -311,11 +311,19 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	if (!*entry)
 		return -ENOMEM;
 
+	(*entry)->digests = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
+				    sizeof(*(*entry)->digests), GFP_NOFS);
+	if (!(*entry)->digests) {
+		kfree(*entry);
+		return -ENOMEM;
+	}
+
 	ret = ima_parse_buf(template_data, template_data + template_data_size,
 			    NULL, template_desc->num_fields,
 			    (*entry)->template_data, NULL, NULL,
 			    ENFORCE_FIELDS | ENFORCE_BUFEND, "template data");
 	if (ret < 0) {
+		kfree((*entry)->digests);
 		kfree(*entry);
 		return ret;
 	}
@@ -447,8 +455,8 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		if (ret < 0)
 			break;
 
-		memcpy(entry->digest, hdr[HDR_DIGEST].data,
-		       hdr[HDR_DIGEST].len);
+		memcpy(entry->digests[ima_sha1_idx].digest,
+		       hdr[HDR_DIGEST].data, hdr[HDR_DIGEST].len);
 		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
 			     le32_to_cpu(*(hdr[HDR_PCR].data));
 		ret = ima_restore_measurement_entry(entry);
-- 
2.17.1

