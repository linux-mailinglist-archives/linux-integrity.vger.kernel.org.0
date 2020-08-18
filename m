Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434BF248A4A
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHRPov (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:44:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726971AbgHRPoe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:44:34 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F38319593CBDEE2F0A10;
        Tue, 18 Aug 2020 16:44:32 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:44:31 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:44:33 +0200
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
Subject: [RFC PATCH 14/30] ima: Add per namespace view of the measurement list
Date:   Tue, 18 Aug 2020 17:42:14 +0200
Message-ID: <20200818154230.14016-5-krzysztof.struczynski@huawei.com>
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

Modify ima securityfs interface, so that only measurement list entries
that belong to the given ima namespace are visible/counted. The initial
ima namespace is an exception, its processes have access to all
measurement list entries.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h                |  1 +
 security/integrity/ima/ima_fs.c    | 57 ++++++++++++++++++++++++++----
 security/integrity/ima/ima_init.c  |  1 +
 security/integrity/ima/ima_ns.c    |  1 +
 security/integrity/ima/ima_queue.c |  8 +++++
 5 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index df22143ffe30..d59ed38a4305 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -203,6 +203,7 @@ struct ima_namespace {
 	struct ima_policy_data *policy_data;
 	struct integrity_iint_tree *iint_tree;
 	struct list_head *measurements;
+	atomic_long_t ml_len; /* number of stored measurements in the list */
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 4758e14c4a7b..e2893f0b0f31 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -63,7 +63,9 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	return ima_show_htable_value(buf, count, ppos, &ima_ns->ml_len);
 
 }
 
@@ -77,10 +79,36 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
+	struct ima_namespace *ima_ns = get_current_ns();
+	unsigned int ns_id = get_ns_id(ima_ns);
+
+	if (ima_ns == &init_ima_ns) {
+		/* we need a lock since pos could point beyond last element */
+		rcu_read_lock();
+		list_for_each_entry_rcu(qe, &ima_measurements, later) {
+			if (!l--) {
+				rcu_read_unlock();
+				return qe;
+			}
+		}
+		rcu_read_unlock();
+		return NULL;
+	}
 
-	/* we need a lock since pos could point beyond last element */
 	rcu_read_lock();
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	qe = list_next_or_null_rcu(&ima_measurements,
+				   ima_ns->measurements,
+				   struct ima_queue_entry,
+				   later);
+	if (!qe) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	list_for_each_entry_from_rcu(qe, &ima_measurements, later) {
+		if (ns_id != qe->entry->ns_id)
+			continue;
+
 		if (!l--) {
 			rcu_read_unlock();
 			return qe;
@@ -93,12 +121,27 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct ima_queue_entry *qe = v;
+	struct ima_namespace *ima_ns = get_current_ns();
+	unsigned int ns_id = get_ns_id(ima_ns);
+
+	if (ima_ns == &init_ima_ns) {
+		/* lock protects when reading beyond last element
+		 * against concurrent list-extension
+		 */
+		rcu_read_lock();
+		qe = list_entry_rcu(qe->later.next, struct ima_queue_entry,
+				    later);
+		rcu_read_unlock();
+		(*pos)++;
+
+		return (&qe->later == &ima_measurements) ? NULL : qe;
+	}
 
-	/* lock protects when reading beyond last element
-	 * against concurrent list-extension
-	 */
 	rcu_read_lock();
-	qe = list_entry_rcu(qe->later.next, struct ima_queue_entry, later);
+	list_for_each_entry_continue_rcu(qe, &ima_measurements, later) {
+		if (ns_id == qe->entry->ns_id)
+			break;
+	}
 	rcu_read_unlock();
 	(*pos)++;
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 2100ee341dfc..ac9509d8c0f0 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -36,6 +36,7 @@ struct ima_namespace init_ima_ns = {
 	.policy_data = &init_policy_data,
 	.iint_tree = &init_iint_tree,
 	.measurements = &ima_measurements,
+	.ml_len = ATOMIC_LONG_INIT(0),
 };
 EXPORT_SYMBOL(init_ima_ns);
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index f331187a4d3c..81de492baa99 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -126,6 +126,7 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->frozen = false;
+	atomic_long_set(&ns->ml_len, 0);
 
 	rwlock_init(&ns->iint_tree->lock);
 	ns->iint_tree->root = RB_ROOT;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index bd890778c5be..ec5b3ca3ef92 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -227,6 +227,14 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 		goto out;
 	}
 
+	/* Initial ima namespace has access to all measurement list entries,
+	 * therefore always increment its measurement list length. Other
+	 * namespaces can see only their own entries.
+	 */
+	if (ima_ns != &init_ima_ns)
+		atomic_long_inc(&ima_ns->ml_len);
+	atomic_long_inc(&init_ima_ns.ml_len);
+
 	if (violation)		/* invalidate pcr */
 		digests_arg = digests;
 
-- 
2.20.1

