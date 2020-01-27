Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2428514A8AC
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 18:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgA0RHQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 12:07:16 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgA0RHQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 12:07:16 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9A8BFAB328A26817DD6D;
        Mon, 27 Jan 2020 17:07:14 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.33) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 27 Jan 2020 17:07:05 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jarkko.sakkinen@linux.intel.com>,
        <james.bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 7/8] ima: use ima_hash_algo for collision detection in the measurement list
Date:   Mon, 27 Jan 2020 18:04:42 +0100
Message-ID: <20200127170443.21538-8-roberto.sassu@huawei.com>
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

Before calculating a digest for each PCR bank, collisions were detected
with a SHA1 digest. This patch includes ima_hash_algo among the algorithms
used to calculate the template digest and checks collisions on that digest.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_api.c      |  2 +-
 security/integrity/ima/ima_crypto.c   | 25 ++++++++++++++++++-------
 security/integrity/ima/ima_main.c     |  1 +
 security/integrity/ima/ima_queue.c    |  8 ++++----
 security/integrity/ima/ima_template.c |  2 +-
 6 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d959dab5bcce..3e1afa5150bc 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -51,6 +51,7 @@ extern int ima_policy_flag;
 /* set during initialization */
 extern int ima_hash_algo;
 extern int ima_sha1_idx;
+extern int ima_hash_algo_idx;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index ebaf0056735c..a9bb45de6db9 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -51,7 +51,7 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 	if (!*entry)
 		return -ENOMEM;
 
-	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 1,
+	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 2,
 				    sizeof(*(*entry)->digests), GFP_NOFS);
 	if (!(*entry)->digests) {
 		result = -ENOMEM;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 786340feebbb..f84dfd8fc5ca 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -93,7 +93,7 @@ static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 	if (algo == ima_hash_algo)
 		return tfm;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++)
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 2; i++)
 		if (ima_algo_array[i].algo == algo && ima_algo_array[i].tfm)
 			return ima_algo_array[i].tfm;
 
@@ -116,19 +116,20 @@ int __init ima_init_crypto(void)
 	if (rc)
 		return rc;
 
-	ima_algo_array = kmalloc_array(ima_tpm_chip->nr_allocated_banks + 1,
+	ima_algo_array = kmalloc_array(ima_tpm_chip->nr_allocated_banks + 2,
 				       sizeof(*ima_algo_array), GFP_KERNEL);
 	if (!ima_algo_array) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++) {
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 2; i++) {
 		ima_algo_array[i].tfm = NULL;
 		ima_algo_array[i].algo = HASH_ALGO__LAST;
 	}
 
 	ima_sha1_idx = -1;
+	ima_hash_algo_idx = -1;
 
 	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
@@ -143,6 +144,7 @@ int __init ima_init_crypto(void)
 
 		if (algo == ima_hash_algo) {
 			ima_algo_array[i].tfm = ima_shash_tfm;
+			ima_hash_algo_idx = i;
 			continue;
 		}
 
@@ -166,12 +168,21 @@ int __init ima_init_crypto(void)
 		}
 
 		ima_sha1_idx = i;
-		ima_algo_array[i].algo = HASH_ALGO_SHA1;
+		if (ima_hash_algo == HASH_ALGO_SHA1)
+			ima_hash_algo_idx = i;
+
+		ima_algo_array[i++].algo = HASH_ALGO_SHA1;
+	}
+
+	if (ima_hash_algo_idx < 0) {
+		ima_algo_array[i].tfm = ima_shash_tfm;
+		ima_algo_array[i].algo = ima_hash_algo;
+		ima_hash_algo_idx = i;
 	}
 
 	return 0;
 out_array:
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++) {
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 2; i++) {
 		if (!ima_algo_array[i].tfm ||
 		    ima_algo_array[i].tfm == ima_shash_tfm)
 			continue;
@@ -190,7 +201,7 @@ static void ima_free_tfm(struct crypto_shash *tfm)
 	if (tfm == ima_shash_tfm)
 		return;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++)
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 2; i++)
 		if (ima_algo_array[i].tfm == tfm)
 			return;
 
@@ -619,7 +630,7 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 
 	entry->digests[ima_sha1_idx].alg_id = TPM_ALG_SHA1;
 
-	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 1; i++) {
+	for (i = 0; i < ima_tpm_chip->nr_allocated_banks + 2; i++) {
 		if (i == ima_sha1_idx)
 			continue;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c068067a0c47..6963d6c31bf1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -31,6 +31,7 @@
 #include "ima.h"
 
 int ima_sha1_idx;
+int ima_hash_algo_idx;
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 7f7509774b85..58983d0f0214 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -57,8 +57,8 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 	key = ima_hash_key(digest_value);
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
-		rc = memcmp(qe->entry->digests[ima_sha1_idx].digest,
-			    digest_value, TPM_DIGEST_SIZE);
+		rc = memcmp(qe->entry->digests[ima_hash_algo_idx].digest,
+			    digest_value, hash_digest_size[ima_hash_algo]);
 		if ((rc == 0) && (qe->entry->pcr == pcr)) {
 			ret = qe;
 			break;
@@ -110,7 +110,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 
 	atomic_long_inc(&ima_htable.len);
 	if (update_htable) {
-		key = ima_hash_key(entry->digests[ima_sha1_idx].digest);
+		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
 	}
 
@@ -162,7 +162,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename)
 {
-	u8 *digest = entry->digests[ima_sha1_idx].digest;
+	u8 *digest = entry->digests[ima_hash_algo_idx].digest;
 	struct tpm_digest *digests_arg = entry->digests;
 	const char *audit_cause = "hash_added";
 	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index a9e1390c8e12..f71b5ee44179 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -311,7 +311,7 @@ static int ima_restore_template_data(struct ima_template_desc *template_desc,
 	if (!*entry)
 		return -ENOMEM;
 
-	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 1,
+	(*entry)->digests = kcalloc(ima_tpm_chip->nr_allocated_banks + 2,
 				    sizeof(*(*entry)->digests), GFP_NOFS);
 	if (!(*entry)->digests) {
 		kfree(*entry);
-- 
2.17.1

