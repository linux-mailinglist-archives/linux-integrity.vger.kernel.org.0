Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3181B7809
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2020 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgDXOJ1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Apr 2020 10:09:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726993AbgDXOJ1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Apr 2020 10:09:27 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E89B111AB5F90280ABA8;
        Fri, 24 Apr 2020 15:09:25 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.487.0; Fri, 24 Apr 2020 15:09:25 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 24 Apr 2020 16:09:25 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: [PATCH] ima: Add stats interface
Date:   Fri, 24 Apr 2020 16:07:01 +0200
Message-ID: <20200424140701.32582-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch introduces the stats interface in securityfs to return useful
information about the measurement list and the hash table. It provides the
following output:

Runtime measurements: <value>
Violations: <value>
Slots (used/available): <value>/<value>
Max depth hash table: <value>

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h       |  2 +
 security/integrity/ima/ima_fs.c    | 74 ++++++++++++++++++------------
 security/integrity/ima/ima_queue.c |  7 +++
 3 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 04cf9b2d7167..55ef51cf9cda 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -175,6 +175,8 @@ extern spinlock_t ima_queue_lock;
 struct ima_h_table {
 	atomic_long_t len;	/* number of stored measurements in the list */
 	atomic_long_t violations;
+	int used_slots;
+	int max_depth;
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 extern struct ima_h_table ima_htable;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ff12c564c710..17738cbbb4cb 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -25,6 +25,15 @@
 
 static DEFINE_MUTEX(ima_write_mutex);
 
+static struct dentry *ima_dir;
+static struct dentry *ima_symlink;
+static struct dentry *binary_runtime_measurements;
+static struct dentry *ascii_runtime_measurements;
+static struct dentry *runtime_measurements_count;
+static struct dentry *violations;
+static struct dentry *ima_policy;
+static struct dentry *stats;
+
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -37,38 +46,44 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
-static ssize_t ima_show_htable_value(char __user *buf, size_t count,
-				     loff_t *ppos, atomic_long_t *val)
+static ssize_t ima_show_htable_value(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos)
 {
-	char tmpbuf[32];	/* greater than largest 'long' string value */
-	ssize_t len;
+	char tmpbuf[512];	/* greater than largest 'long' string value */
+	ssize_t len = 0;
+
+	if (file_dentry(filp) == runtime_measurements_count)
+		len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n",
+				atomic_long_read(&ima_htable.len));
+	else if (file_dentry(filp) == violations)
+		len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n",
+				atomic_long_read(&ima_htable.violations));
+	else if (file_dentry(filp) == stats)
+		len = scnprintf(tmpbuf, sizeof(tmpbuf),
+				"Runtime measurements: %li\n"
+				"Violations: %li\n"
+				"Slots (used/available): %i/%i\n"
+				"Max depth hash table: %i\n",
+				atomic_long_read(&ima_htable.len),
+				atomic_long_read(&ima_htable.violations),
+				ima_htable.used_slots, IMA_MEASURE_HTABLE_SIZE,
+				ima_htable.max_depth);
 
-	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 
-static ssize_t ima_show_htable_violations(struct file *filp,
-					  char __user *buf,
-					  size_t count, loff_t *ppos)
-{
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
-}
-
 static const struct file_operations ima_htable_violations_ops = {
-	.read = ima_show_htable_violations,
+	.read = ima_show_htable_value,
 	.llseek = generic_file_llseek,
 };
 
-static ssize_t ima_show_measurements_count(struct file *filp,
-					   char __user *buf,
-					   size_t count, loff_t *ppos)
-{
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
-
-}
-
 static const struct file_operations ima_measurements_count_ops = {
-	.read = ima_show_measurements_count,
+	.read = ima_show_htable_value,
+	.llseek = generic_file_llseek,
+};
+
+static const struct file_operations ima_measurements_stats_ops = {
+	.read = ima_show_htable_value,
 	.llseek = generic_file_llseek,
 };
 
@@ -355,14 +370,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	return result;
 }
 
-static struct dentry *ima_dir;
-static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
-
 enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
@@ -487,6 +494,12 @@ int __init ima_fs_init(void)
 	if (IS_ERR(violations))
 		goto out;
 
+	stats = securityfs_create_file("stats", S_IRUSR | S_IRGRP,
+				       ima_dir, NULL,
+				       &ima_measurements_stats_ops);
+	if (IS_ERR(stats))
+		goto out;
+
 	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
@@ -495,6 +508,7 @@ int __init ima_fs_init(void)
 
 	return 0;
 out:
+	securityfs_remove(stats);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index fb4ec270f620..d5443f5c3ee4 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -95,6 +95,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 {
 	struct ima_queue_entry *qe;
 	unsigned int key;
+	int cur_max_depth = 0;
 
 	qe = kmalloc(sizeof(*qe), GFP_KERNEL);
 	if (qe == NULL) {
@@ -109,7 +110,13 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	atomic_long_inc(&ima_htable.len);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
+		if (hlist_empty(&ima_htable.queue[key]))
+			ima_htable.used_slots++;
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
+		hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext)
+			cur_max_depth++;
+		ima_htable.max_depth = max(ima_htable.max_depth,
+					    cur_max_depth);
 	}
 
 	if (binary_runtime_size != ULONG_MAX) {
-- 
2.17.1

