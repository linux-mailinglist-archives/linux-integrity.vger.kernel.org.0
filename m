Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF91192648
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 11:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCYK4H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 06:56:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgCYK4H (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 06:56:07 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F025C1F99A62E89AD8C8;
        Wed, 25 Mar 2020 10:56:05 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Mar 2020 10:55:59 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <James.Bottomley@HansenPartnership.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 7/7] ima: Use ima_hash_algo for collision detection in the measurement list
Date:   Wed, 25 Mar 2020 11:54:24 +0100
Message-ID: <20200325105424.26665-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325104712.25694-1-roberto.sassu@huawei.com>
References: <20200325104712.25694-1-roberto.sassu@huawei.com>
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

The position in the measurement entry array of the template digest
calculated with the IMA default hash algorithm is stored in the
ima_hash_algo_idx global variable and is determined at IMA initialization
time.

Changelog

v2:
- add __ro_after_init to declaration of ima_hash_algo_idx (suggested by
  Mimi)
- replace ima_num_template_digests with
  NR_BANKS(ima_tpm_chip) + ima_extra_slots(suggested by Mimi)
- use ima_hash_algo_idx to access ima_algo_array elements in
  ima_init_crypto()

v1:
- increment ima_num_template_digests before kcalloc() (suggested by Mimi)
- check if ima_tpm_chip is NULL

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c | 19 ++++++++++++++++++-
 security/integrity/ima/ima_queue.c  |  8 ++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2a7ed68e6414..467dfdbea25c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,6 +53,7 @@ extern int ima_policy_flag;
 /* set during initialization */
 extern int ima_hash_algo;
 extern int ima_sha1_idx __ro_after_init;
+extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index a94972d3f929..5201f5ec2ce4 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -63,6 +63,7 @@ struct ima_algo_desc {
 };
 
 int ima_sha1_idx __ro_after_init;
+int ima_hash_algo_idx __ro_after_init;
 /*
  * Additional number of slots reserved, as needed, for SHA1
  * and IMA default algo.
@@ -122,15 +123,25 @@ int __init ima_init_crypto(void)
 		return rc;
 
 	ima_sha1_idx = -1;
+	ima_hash_algo_idx = -1;
 
 	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
 		if (algo == HASH_ALGO_SHA1)
 			ima_sha1_idx = i;
+
+		if (algo == ima_hash_algo)
+			ima_hash_algo_idx = i;
 	}
 
-	if (ima_sha1_idx < 0)
+	if (ima_sha1_idx < 0) {
 		ima_sha1_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
+		if (ima_hash_algo == HASH_ALGO_SHA1)
+			ima_hash_algo_idx = ima_sha1_idx;
+	}
+
+	if (ima_hash_algo_idx < 0)
+		ima_hash_algo_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
 
 	ima_algo_array = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
 				 sizeof(*ima_algo_array), GFP_KERNEL);
@@ -179,6 +190,12 @@ int __init ima_init_crypto(void)
 		ima_algo_array[ima_sha1_idx].algo = HASH_ALGO_SHA1;
 	}
 
+	if (ima_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
+	    ima_hash_algo_idx != ima_sha1_idx) {
+		ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
+		ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
+	}
+
 	return 0;
 out_array:
 	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 82a9ca43b989..fb4ec270f620 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -55,8 +55,8 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
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
@@ -108,7 +108,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 
 	atomic_long_inc(&ima_htable.len);
 	if (update_htable) {
-		key = ima_hash_key(entry->digests[ima_sha1_idx].digest);
+		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
 	}
 
@@ -160,7 +160,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
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

