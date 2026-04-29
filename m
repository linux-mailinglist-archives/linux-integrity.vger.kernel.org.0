Return-Path: <linux-integrity+bounces-9373-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOLKH3Ex8mkjowEAu9opvQ
	(envelope-from <linux-integrity+bounces-9373-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:27:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F6E497B69
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF5E301CA70
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281B40FDA9;
	Wed, 29 Apr 2026 16:20:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4340F8F4;
	Wed, 29 Apr 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479618; cv=none; b=FGQlHzYn3A0RuuLiDemgmRoL0va8sWxQAT+zOvpoWKAnMC+o81cPIUbvTFz7yFnNRMuS0w+SfGXBpSy1r9rUPsvJIi6U32xtRPtgxTFniy3ehMflpKSKVBRYWbZLhIvWIebViRb+SxS3vHmHA0600eAElNtnLK2zyrF2+rBUQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479618; c=relaxed/simple;
	bh=MP9+scg3dwoUSuqETp6ePAjChlt97Y7yrh+Xbl1cumQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIIGw8yZV9Zwl5aYK+2kgcWvphL7AmNjuWhfv8kK4G+ViXd5AOitUVMYcNvdqThPC97HK1Vx46OltmwBIN0uGpM44jq6IkxbQe7V+RTdOao/h5/jxZwMLBZVeZ7a9K/LVrC5PQdVpOrHf49O1Okz0Yg73XZRNRjTmcdWNJ6a3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4g5MSD2wKbzpTvM;
	Wed, 29 Apr 2026 23:59:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 989D44056A;
	Thu, 30 Apr 2026 00:03:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHPmrYK_JpRQ1BAA--.12298S3;
	Wed, 29 Apr 2026 17:03:54 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v5 01/13] ima: Remove ima_h_table structure
Date: Wed, 29 Apr 2026 18:03:07 +0200
Message-ID: <20260429160319.4162918-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwBHPmrYK_JpRQ1BAA--.12298S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4rXFW5Zw1fXFWUuw17Jrb_yoWxtw1kpa
	nFga42kF48XFyI9ryDAayqkrWrW3yUKr17Wws8Gw1Fk3ZrXr12gF15AFy2kFyfGrZYyF1I
	qrs0qrn0kwsYyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGnx6jgGGgAAsB
X-Rspamd-Queue-Id: 24F6E497B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9373-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.882];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid,huawei.com:email]

From: Roberto Sassu <roberto.sassu@huawei.com>

With the upcoming change of dynamically allocating and replacing the hash
table, the ima_h_table structure would have been replaced with a new one.

However, since the ima_h_table structure contains also the counters for
number of measurements entries and violations, we would have needed to
preserve their values in the new ima_h_table structure.

Instead, separate those counters from the hash table, remove the
ima_h_table structure, and just replace the hash table pointer.

Finally, rename ima_show_htable_value(), ima_show_htable_violations()
and ima_htable_violations_ops respectively to ima_show_counter(),
ima_show_num_violations() and ima_num_violations_ops.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h       |  9 +++------
 security/integrity/ima/ima_api.c   |  2 +-
 security/integrity/ima/ima_fs.c    | 19 +++++++++----------
 security/integrity/ima/ima_kexec.c |  2 +-
 security/integrity/ima/ima_queue.c | 17 ++++++++++-------
 5 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 69e9bf0b82c6..51a8a582df56 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -324,12 +324,9 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  */
 extern spinlock_t ima_queue_lock;
 
-struct ima_h_table {
-	atomic_long_t len;	/* number of stored measurements in the list */
-	atomic_long_t violations;
-	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
-};
-extern struct ima_h_table ima_htable;
+extern atomic_long_t ima_num_entries;
+extern atomic_long_t ima_num_violations;
+extern struct hlist_head ima_htable[IMA_MEASURE_HTABLE_SIZE];
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 0916f24f005f..122d127e108d 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -146,7 +146,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	int result;
 
 	/* can overflow, only indicator */
-	atomic_long_inc(&ima_htable.violations);
+	atomic_long_inc(&ima_num_violations);
 
 	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ca4931a95098..aaa460d70ff7 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -38,8 +38,8 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
-static ssize_t ima_show_htable_value(char __user *buf, size_t count,
-				     loff_t *ppos, atomic_long_t *val)
+static ssize_t ima_show_counter(char __user *buf, size_t count, loff_t *ppos,
+				atomic_long_t *val)
 {
 	char tmpbuf[32];	/* greater than largest 'long' string value */
 	ssize_t len;
@@ -48,15 +48,14 @@ static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 
-static ssize_t ima_show_htable_violations(struct file *filp,
-					  char __user *buf,
-					  size_t count, loff_t *ppos)
+static ssize_t ima_show_num_violations(struct file *filp, char __user *buf,
+				       size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
+	return ima_show_counter(buf, count, ppos, &ima_num_violations);
 }
 
-static const struct file_operations ima_htable_violations_ops = {
-	.read = ima_show_htable_violations,
+static const struct file_operations ima_num_violations_ops = {
+	.read = ima_show_num_violations,
 	.llseek = generic_file_llseek,
 };
 
@@ -64,7 +63,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
+	return ima_show_counter(buf, count, ppos, &ima_num_entries);
 
 }
 
@@ -545,7 +544,7 @@ int __init ima_fs_init(void)
 	}
 
 	dentry = securityfs_create_file("violations", S_IRUSR | S_IRGRP,
-				   ima_dir, NULL, &ima_htable_violations_ops);
+				   ima_dir, NULL, &ima_num_violations_ops);
 	if (IS_ERR(dentry)) {
 		ret = PTR_ERR(dentry);
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 36a34c54de58..5801649fbbef 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -43,7 +43,7 @@ void ima_measure_kexec_event(const char *event_name)
 	int n;
 
 	buf_size = ima_get_binary_runtime_size();
-	len = atomic_long_read(&ima_htable.len);
+	len = atomic_long_read(&ima_num_entries);
 
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
 		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 319522450854..1f6515f7d015 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -32,11 +32,14 @@ static unsigned long binary_runtime_size;
 static unsigned long binary_runtime_size = ULONG_MAX;
 #endif
 
+/* num of stored measurements in the list */
+atomic_long_t ima_num_entries = ATOMIC_LONG_INIT(0);
+/* num of violations in the list */
+atomic_long_t ima_num_violations = ATOMIC_LONG_INIT(0);
+
 /* key: inode (before secure-hashing a file) */
-struct ima_h_table ima_htable = {
-	.len = ATOMIC_LONG_INIT(0),
-	.violations = ATOMIC_LONG_INIT(0),
-	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
+struct hlist_head ima_htable[IMA_MEASURE_HTABLE_SIZE] = {
+	[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
 /* mutex protects atomicity of extending measurement list
@@ -61,7 +64,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 
 	key = ima_hash_key(digest_value);
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
+	hlist_for_each_entry_rcu(qe, &ima_htable[key], hnext) {
 		rc = memcmp(qe->entry->digests[ima_hash_algo_idx].digest,
 			    digest_value, hash_digest_size[ima_hash_algo]);
 		if ((rc == 0) && (qe->entry->pcr == pcr)) {
@@ -113,10 +116,10 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	INIT_LIST_HEAD(&qe->later);
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
-	atomic_long_inc(&ima_htable.len);
+	atomic_long_inc(&ima_num_entries);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
-		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
+		hlist_add_head_rcu(&qe->hnext, &ima_htable[key]);
 	}
 
 	if (binary_runtime_size != ULONG_MAX) {
-- 
2.43.0


