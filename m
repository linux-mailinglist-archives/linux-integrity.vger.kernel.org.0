Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88915294B
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2020 11:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgBEKgo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Feb 2020 05:36:44 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2373 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727562AbgBEKgo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Feb 2020 05:36:44 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5B0A0A50E481B9D7D2A2;
        Wed,  5 Feb 2020 10:36:42 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 5 Feb 2020 10:36:35 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>,
        <jarkko.sakkinen@linux.intel.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 8/8] ima: Use ima_hash_algo for collision detection in the measurement list
Date:   Wed, 5 Feb 2020 11:33:17 +0100
Message-ID: <20200205103317.29356-9-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205103317.29356-1-roberto.sassu@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
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

Changelog

v1:
- increment ima_num_template_digests before kcalloc() (suggested by Mimi)
- check if ima_tpm_chip is NULL

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c | 20 ++++++++++++++++++--
 security/integrity/ima/ima_queue.c  |  8 ++++----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4843077dc9e8..23d63bb96d2c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -51,6 +51,7 @@ extern int ima_policy_flag;
 /* set during initialization */
 extern int ima_hash_algo;
 extern int ima_sha1_idx;
+extern int ima_hash_algo_idx;
 extern int ima_num_template_digests;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 1ee813d33bdc..f391ee3412b9 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -65,6 +65,7 @@ struct ima_algo_desc {
 };
 
 int ima_sha1_idx;
+int ima_hash_algo_idx;
 int ima_num_template_digests;
 
 static struct ima_algo_desc *ima_algo_array;
@@ -123,16 +124,26 @@ int __init ima_init_crypto(void)
 		nr_allocated_banks = ima_tpm_chip->nr_allocated_banks;
 
 	ima_sha1_idx = -1;
+	ima_hash_algo_idx = -1;
 	ima_num_template_digests = nr_allocated_banks;
 
 	for (i = 0; i < nr_allocated_banks; i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
 		if (algo == HASH_ALGO_SHA1)
 			ima_sha1_idx = i;
+
+		if (algo == ima_hash_algo)
+			ima_hash_algo_idx = i;
 	}
 
-	if (ima_sha1_idx < 0)
+	if (ima_sha1_idx < 0) {
 		ima_sha1_idx = ima_num_template_digests++;
+		if (ima_hash_algo == HASH_ALGO_SHA1)
+			ima_hash_algo_idx = ima_sha1_idx;
+	}
+
+	if (ima_hash_algo_idx < 0)
+		ima_hash_algo_idx = ima_num_template_digests++;
 
 	ima_algo_array = kcalloc(ima_num_template_digests,
 				 sizeof(*ima_algo_array), GFP_KERNEL);
@@ -173,7 +184,12 @@ int __init ima_init_crypto(void)
 			goto out_array;
 		}
 
-		ima_algo_array[i].algo = HASH_ALGO_SHA1;
+		ima_algo_array[i++].algo = HASH_ALGO_SHA1;
+	}
+
+	if (ima_hash_algo_idx >= nr_allocated_banks) {
+		ima_algo_array[i].tfm = ima_shash_tfm;
+		ima_algo_array[i].algo = ima_hash_algo;
 	}
 
 	return 0;
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
-- 
2.17.1

