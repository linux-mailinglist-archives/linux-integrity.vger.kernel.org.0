Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6E14A8A1
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 18:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgA0RGq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 12:06:46 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgA0RGq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:06:46 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 33F51C280A4E7B1B8816;
        Mon, 27 Jan 2020 17:06:44 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 27 Jan 2020 17:06:35 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>,
        <james.bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 4/8] ima: switch to dynamically allocated buffer for template digests
Date:   Mon, 27 Jan 2020 18:04:39 +0100
Message-ID: <20200127170443.21538-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127170443.21538-1-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch dynamically allocates the array of tpm_digest structures in
ima_alloc_init_template() and ima_restore_template_data(). It also
allocates an item in addition to the number of allocated PCR banks, to
store a SHA1 digest when the SHA1 PCR bank is not allocated.

Calculating the SHA1 digest is mandatory, as SHA1 still remains the default
hash algorithm for the measurement list. When IMA will support the Crypto
Agile format, remaining digests will be also provided.

The position in the array of the SHA1 digest is stored in the ima_sha1_idx
global variable and it is determined at IMA initialization time.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  3 ++-
 security/integrity/ima/ima_api.c      |  8 ++++++++
 security/integrity/ima/ima_crypto.c   |  3 ++-
 security/integrity/ima/ima_fs.c       |  4 ++--
 security/integrity/ima/ima_main.c     |  2 ++
 security/integrity/ima/ima_queue.c    | 10 ++++++----
 security/integrity/ima/ima_template.c | 12 ++++++++++--
 7 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6238c50ae44e..d959dab5bcce 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -50,6 +50,7 @@ extern int ima_policy_flag;
 
 /* set during initialization */
 extern int ima_hash_algo;
+extern int ima_sha1_idx;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 
@@ -92,7 +93,7 @@ struct ima_template_desc {
 
 struct ima_template_entry {
 	int pcr;
-	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
+	struct tpm_digest *digests;
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
 	struct ima_field_data template_data[0];	/* template related data */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 2ef5a40c7ca5..ebaf0056735c 100644
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
 
+	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 1,
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
index f2d9d4b18499..57b06321d5c8 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -504,7 +504,8 @@ static int ima_calc_field_array_hash_tfm(struct ima_field_data *field_data,
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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2f95b133f246..c068067a0c47 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -30,6 +30,8 @@
 
 #include "ima.h"
 
+int ima_sha1_idx;
+
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
 #else
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
index 6aa6408603e3..2e9c5d99e70e 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -311,11 +311,19 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	if (!*entry)
 		return -ENOMEM;
 
+	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 1,
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

