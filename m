Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B6D248ADD
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgHRP5z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:57:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2640 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727956AbgHRPpl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:45:41 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 73998FDD20F951A0F884;
        Tue, 18 Aug 2020 16:45:40 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:45:38 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:45:40 +0200
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
Subject: [RFC PATCH 17/30] ima: Add the violation counter to the namespace
Date:   Tue, 18 Aug 2020 17:42:17 +0200
Message-ID: <20200818154230.14016-8-krzysztof.struczynski@huawei.com>
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

The violations are now tracked per namespace.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima.h       |  1 -
 security/integrity/ima/ima_api.c   |  2 +-
 security/integrity/ima/ima_fs.c    | 18 +++++++++++++++---
 security/integrity/ima/ima_init.c  |  1 +
 security/integrity/ima/ima_ns.c    |  1 +
 security/integrity/ima/ima_queue.c |  1 -
 7 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index d59ed38a4305..7eb7a008c5fe 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -204,6 +204,7 @@ struct ima_namespace {
 	struct integrity_iint_tree *iint_tree;
 	struct list_head *measurements;
 	atomic_long_t ml_len; /* number of stored measurements in the list */
+	atomic_long_t violations;
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7318fff3ccaa..ef95522cc710 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -193,7 +193,6 @@ extern spinlock_t ima_queue_lock;
 
 struct ima_h_table {
 	atomic_long_t len;	/* number of stored measurements in the list */
-	atomic_long_t violations;
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 extern struct ima_h_table ima_htable;
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b01451b34a98..f91516885033 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -151,7 +151,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	event_data.ns_id = get_ns_id(ima_ns);
 
 	/* can overflow, only indicator */
-	atomic_long_inc(&ima_htable.violations);
+	atomic_long_inc(&ima_ns->violations);
 
 	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 6d370874d80f..b71c2552ac15 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -51,10 +51,23 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	return ima_show_htable_value(buf, count, ppos, &ima_ns->violations);
+}
+
+static int ima_open_htable_violations(struct inode *inode, struct file *file)
+{
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return 0;
 }
 
 static const struct file_operations ima_htable_violations_ops = {
+	.open = ima_open_htable_violations,
 	.read = ima_show_htable_violations,
 	.llseek = generic_file_llseek,
 };
@@ -76,7 +89,6 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 	struct ima_namespace *ima_ns = get_current_ns();
 
 	return ima_show_htable_value(buf, count, ppos, &ima_ns->ml_len);
-
 }
 
 static const struct file_operations ima_measurements_count_ops = {
@@ -552,7 +564,7 @@ int __init ima_fs_init(void)
 		goto out;
 
 	violations =
-	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
+	    securityfs_create_file("violations", S_IRUSR | S_IRGRP | S_IROTH,
 				   ima_dir, NULL, &ima_htable_violations_ops);
 	if (IS_ERR(violations))
 		goto out;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index ac9509d8c0f0..f7b25b3f95de 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -37,6 +37,7 @@ struct ima_namespace init_ima_ns = {
 	.iint_tree = &init_iint_tree,
 	.measurements = &ima_measurements,
 	.ml_len = ATOMIC_LONG_INIT(0),
+	.violations = ATOMIC_LONG_INIT(0),
 };
 EXPORT_SYMBOL(init_ima_ns);
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 81de492baa99..3012287b22d2 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -127,6 +127,7 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	ns->ucounts = ucounts;
 	ns->frozen = false;
 	atomic_long_set(&ns->ml_len, 0);
+	atomic_long_set(&ns->violations, 0);
 
 	rwlock_init(&ns->iint_tree->lock);
 	ns->iint_tree->root = RB_ROOT;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index ec5b3ca3ef92..912e6097af5b 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -34,7 +34,6 @@ static unsigned long binary_runtime_size = ULONG_MAX;
 /* key: inode (before secure-hashing a file) */
 struct ima_h_table ima_htable = {
 	.len = ATOMIC_LONG_INIT(0),
-	.violations = ATOMIC_LONG_INIT(0),
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
-- 
2.20.1

