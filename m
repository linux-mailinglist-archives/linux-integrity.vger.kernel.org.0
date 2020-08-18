Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62459248A48
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHRPoi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:44:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2635 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbgHRPo3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:44:29 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 18D40206AA534787B55C;
        Tue, 18 Aug 2020 16:44:28 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:44:26 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:44:28 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 12/30] ima: Check ima namespace ID during digest entry lookup
Date:   Tue, 18 Aug 2020 17:42:12 +0200
Message-ID: <20200818154230.14016-3-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Add ima namespace ID to the template entry data. It is not yet
included in the hash calculation and should be compared separately.
If template entry with the matching digest, pcr ID and ima namespace ID
is found, check if it belongs to the active ima namespace. This is
necessary because ima IDs are unique only among the active namespaces.
It is possible that the already destroyed namespace had added entry
with the same ID. In that case, create the new entry nontheless.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima.h       |  6 ++-
 security/integrity/ima/ima_api.c   | 12 ++++--
 security/integrity/ima/ima_init.c  |  3 +-
 security/integrity/ima/ima_main.c  |  2 +-
 security/integrity/ima/ima_queue.c | 60 ++++++++++++++++++++++++++----
 5 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7b7252d35d5a..e08f88aab0b5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -155,7 +155,8 @@ int ima_init(void);
 int ima_fs_init(void);
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
-			   const unsigned char *filename);
+			   const unsigned char *filename,
+			   struct ima_namespace *ima_ns);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
 int ima_calc_buffer_hash(const void *buf, loff_t len,
 			 struct ima_digest_data *hash);
@@ -294,7 +295,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_desc *template_desc);
 int ima_store_template(struct ima_template_entry *entry, int violation,
 		       struct inode *inode,
-		       const unsigned char *filename, int pcr);
+		       const unsigned char *filename, int pcr,
+		       struct ima_namespace *ima_ns);
 void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 1f4411fffa45..b01451b34a98 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -103,7 +103,8 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
  */
 int ima_store_template(struct ima_template_entry *entry,
 		       int violation, struct inode *inode,
-		       const unsigned char *filename, int pcr)
+		       const unsigned char *filename, int pcr,
+		       struct ima_namespace *ima_ns)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "hashing_error";
@@ -121,7 +122,8 @@ int ima_store_template(struct ima_template_entry *entry,
 		}
 	}
 	entry->pcr = pcr;
-	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	result = ima_add_template_entry(entry, violation, op, inode, filename,
+					ima_ns);
 	return result;
 }
 
@@ -157,7 +159,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		goto err_out;
 	}
 	result = ima_store_template(entry, violation, inode,
-				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
+				    filename, CONFIG_IMA_MEASURE_PCR_IDX,
+				    ima_ns);
 	if (result < 0)
 		ima_free_template_entry(entry);
 err_out:
@@ -337,7 +340,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		return;
 	}
 
-	result = ima_store_template(entry, violation, inode, filename, pcr);
+	result = ima_store_template(entry, violation, inode, filename, pcr,
+				    ima_ns);
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index aece357286b8..2100ee341dfc 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -105,7 +105,8 @@ static int __init ima_add_boot_aggregate(void)
 
 	result = ima_store_template(entry, violation, NULL,
 				    boot_aggregate_name,
-				    CONFIG_IMA_MEASURE_PCR_IDX);
+				    CONFIG_IMA_MEASURE_PCR_IDX,
+				    &init_ima_ns);
 	if (result < 0) {
 		ima_free_template_entry(entry);
 		audit_cause = "store_entry";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fa63780ae76e..b933c7e6c8e1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -930,7 +930,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		goto out;
 	}
 
-	ret = ima_store_template(entry, violation, NULL, buf, pcr);
+	ret = ima_store_template(entry, violation, NULL, buf, pcr, ima_ns);
 	if (ret < 0) {
 		audit_cause = "store_entry";
 		ima_free_template_entry(entry);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index fb4ec270f620..bd890778c5be 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -46,7 +46,7 @@ static DEFINE_MUTEX(ima_extend_list_mutex);
 
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
-						       int pcr)
+						       int pcr, int ns_id)
 {
 	struct ima_queue_entry *qe, *ret = NULL;
 	unsigned int key;
@@ -57,7 +57,8 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
 		rc = memcmp(qe->entry->digests[ima_hash_algo_idx].digest,
 			    digest_value, hash_digest_size[ima_hash_algo]);
-		if ((rc == 0) && (qe->entry->pcr == pcr)) {
+		if ((rc == 0) && (qe->entry->pcr == pcr) &&
+		    (qe->entry->ns_id == ns_id)) {
 			ret = qe;
 			break;
 		}
@@ -148,6 +149,38 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 	return result;
 }
 
+#ifdef CONFIG_IMA_NS
+static bool ima_is_active_entry(const struct ima_queue_entry *qe,
+				const struct ima_namespace *ima_ns)
+{
+	bool found = false;
+	struct ima_queue_entry *ns_qe;
+
+	rcu_read_lock();
+	ns_qe = list_next_or_null_rcu(&ima_measurements, ima_ns->measurements,
+				      struct ima_queue_entry, later);
+	if (ns_qe) {
+		list_for_each_entry_from_rcu(ns_qe, &ima_measurements, later) {
+			found = memcmp(ns_qe->entry->digests[ima_hash_algo_idx].digest,
+				       qe->entry->digests[ima_hash_algo_idx].digest,
+				       hash_digest_size[ima_hash_algo]) == 0;
+			if (found)
+				break;
+
+		}
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+#else
+static bool ima_is_active_entry(const struct ima_queue_entry *qe,
+				const struct ima_namespace *ima_ns)
+{
+	return true;
+}
+#endif /* CONFIG_IMA_NS */
+
 /*
  * Add template entry to the measurement list and hash table, and
  * extend the pcr.
@@ -158,7 +191,8 @@ static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
  */
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
-			   const unsigned char *filename)
+			   const unsigned char *filename,
+			   struct ima_namespace *ima_ns)
 {
 	u8 *digest = entry->digests[ima_hash_algo_idx].digest;
 	struct tpm_digest *digests_arg = entry->digests;
@@ -166,17 +200,27 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	char tpm_audit_cause[AUDIT_CAUSE_LEN_MAX];
 	int audit_info = 1;
 	int result = 0, tpmresult = 0;
+	struct ima_queue_entry *qe = NULL;
 
 	mutex_lock(&ima_extend_list_mutex);
 	if (!violation) {
-		if (ima_lookup_digest_entry(digest, entry->pcr)) {
-			audit_cause = "hash_exists";
-			result = -EEXIST;
-			goto out;
+		qe = ima_lookup_digest_entry(digest, entry->pcr, entry->ns_id);
+		if (qe) {
+			/* IMA ns IDs are guaranteed to be unique only among
+			 * active namespaces. It may happen that there is an
+			 * entry with matching ID for one of the destroyed
+			 * namespaces. Check if entry belongs to the active
+			 * namespace.
+			 */
+			if (ima_is_active_entry(qe, ima_ns)) {
+				audit_cause = "hash_exists";
+				result = -EEXIST;
+				goto out;
+			}
 		}
 	}
 
-	result = ima_add_digest_entry(entry, 1);
+	result = ima_add_digest_entry(entry, !qe);
 	if (result < 0) {
 		audit_cause = "ENOMEM";
 		audit_info = 0;
-- 
2.20.1

