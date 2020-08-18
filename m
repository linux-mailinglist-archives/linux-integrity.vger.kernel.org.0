Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E52489CF
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgHRP0z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbgHRP0L (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:11 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 225CE751D64D2FEE2140;
        Tue, 18 Aug 2020 16:26:10 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:08 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:10 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 02/30] ima: Add a list of the installed ima namespaces
Date:   Tue, 18 Aug 2020 17:20:09 +0200
Message-ID: <20200818152037.11869-3-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
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

Add a list of the installed ima namespaces. IMA namespace is considered
installed, if there is at least one process born in that namespace.

This list will be used to check the read-write violations and to detect
any object related changes relevant across namespaces.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h               |   8 ++-
 security/integrity/ima/ima.h      |  11 ++++
 security/integrity/ima/ima_init.c |   5 ++
 security/integrity/ima/ima_main.c |   3 +
 security/integrity/ima/ima_ns.c   | 101 ++++++++++++++++++++++++++++--
 5 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 4a9c29d4d056..5b6235b97603 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -10,10 +10,12 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
-struct linux_binprm;
 
+struct linux_binprm;
 struct nsproxy;
 struct task_struct;
+struct list_head;
+struct llist_node;
 
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
@@ -176,6 +178,10 @@ struct ima_namespace {
 	struct ns_common ns;
 	struct ucounts *ucounts;
 	struct user_namespace *user_ns;
+	struct list_head list;
+	struct llist_node cleanup_list; /* namespaces on a death row */
+	atomic_t inactive; /* set only when ns is added to the cleanup list */
+	bool frozen;
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 603da5b2db08..092e87190c6d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -372,12 +372,23 @@ static inline int ima_read_xattr(struct dentry *dentry,
 
 #endif /* CONFIG_IMA_APPRAISE */
 
+extern struct list_head ima_ns_list;
+extern struct rw_semaphore ima_ns_list_lock;
+
 #ifdef CONFIG_IMA_NS
+int __init ima_init_namespace(void);
+
 static inline struct ima_namespace *get_current_ns(void)
 {
 	return current->nsproxy->ima_ns;
 }
 #else
+static inline int __init ima_init_namespace(void)
+{
+	list_add_tail(&init_ima_ns.list, &ima_ns_list);
+	return 0;
+}
+
 static inline struct ima_namespace *get_current_ns(void)
 {
 	return &init_ima_ns;
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 013bbec16849..0ba04a1a68cc 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -32,6 +32,7 @@ struct ima_namespace init_ima_ns = {
 #ifdef CONFIG_IMA_NS
 	.ns.ops = &imans_operations,
 #endif
+	.frozen = true
 };
 EXPORT_SYMBOL(init_ima_ns);
 
@@ -154,6 +155,10 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
+	rc = ima_init_namespace();
+	if (rc != 0)
+		return rc;
+
 	rc = ima_fs_init();
 	if (rc != 0)
 		return rc;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8a91711ca79b..d800e73c8b62 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -37,6 +37,9 @@ int ima_appraise;
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
+DECLARE_RWSEM(ima_ns_list_lock);
+LIST_HEAD(ima_ns_list);
+
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 8f5f301406a2..3a98cd536d05 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -21,9 +21,20 @@
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
 #include <linux/sched.h>
+#include <linux/list.h>
+#include <linux/llist.h>
+#include <linux/rwsem.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
 
 #include "ima.h"
 
+static LLIST_HEAD(cleanup_list);
+static struct workqueue_struct *imans_wq;
+
+/* Protects tasks entering the same, not yet active namespace */
+static DEFINE_MUTEX(frozen_lock);
+
 static struct ucounts *inc_ima_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_IMA_NAMESPACES);
@@ -78,6 +89,7 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	ns->ns.ops = &imans_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
+	ns->frozen = false;
 
 	return ns;
 
@@ -109,6 +121,19 @@ struct ima_namespace *copy_ima_ns(unsigned long flags,
 	return clone_ima_ns(user_ns, old_ns);
 }
 
+int __init ima_init_namespace(void)
+{
+	/* Create workqueue for cleanup */
+	imans_wq = create_singlethread_workqueue("imans");
+	if (unlikely(!imans_wq))
+		return -ENOMEM;
+
+	/* No other reader or writer at this stage */
+	list_add_tail(&init_ima_ns.list, &ima_ns_list);
+
+	return 0;
+}
+
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	dec_ima_namespaces(ns->ucounts);
@@ -117,13 +142,46 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	kfree(ns);
 }
 
+static void cleanup_ima(struct work_struct *work)
+{
+	struct ima_namespace *ima_ns, *tmp;
+	struct llist_node *ima_kill_list;
+
+	/* Atomically snapshot the list of namespaces to cleanup */
+	ima_kill_list = llist_del_all(&cleanup_list);
+
+	/* Remove ima namespace from the namespace list */
+	down_write(&ima_ns_list_lock);
+	llist_for_each_entry(ima_ns, ima_kill_list, cleanup_list)
+		list_del(&ima_ns->list);
+	up_write(&ima_ns_list_lock);
+
+	/* After removing ima namespace from the ima_ns_list, memory can be
+	 * freed. At this stage nothing should keep a reference to the given
+	 * namespace.
+	 */
+	llist_for_each_entry_safe(ima_ns, tmp, ima_kill_list, cleanup_list)
+		destroy_ima_ns(ima_ns);
+}
+
+static DECLARE_WORK(ima_cleanup_work, cleanup_ima);
+
 void free_ima_ns(struct kref *kref)
 {
-	struct ima_namespace *ns;
+	struct ima_namespace *ima_ns;
 
-	ns = container_of(kref, struct ima_namespace, kref);
+	ima_ns = container_of(kref, struct ima_namespace, kref);
+	/* Namespace can be destroyed instantly if no process ever was born
+	 * into it - it was never added to the ima_ns_list.
+	 */
+	if (!ima_ns->frozen) {
+		destroy_ima_ns(ima_ns);
+		return;
+	}
 
-	destroy_ima_ns(ns);
+	atomic_set(&ima_ns->inactive, 1);
+	if (llist_add(&ima_ns->cleanup_list, &cleanup_list))
+		queue_work(imans_wq, &ima_cleanup_work);
 }
 
 static inline struct ima_namespace *to_ima_ns(struct ns_common *ns)
@@ -168,8 +226,32 @@ static void imans_put(struct ns_common *ns)
 	put_ima_ns(to_ima_ns(ns));
 }
 
+static int imans_activate(struct ima_namespace *ima_ns)
+{
+	if (ima_ns == &init_ima_ns)
+		return 0;
+
+	if (ima_ns->frozen)
+		return 0;
+
+	mutex_lock(&frozen_lock);
+	if (ima_ns->frozen)
+		goto out;
+
+	ima_ns->frozen = true;
+
+	down_write(&ima_ns_list_lock);
+	list_add_tail(&ima_ns->list, &ima_ns_list);
+	up_write(&ima_ns_list_lock);
+out:
+	mutex_unlock(&frozen_lock);
+
+	return 0;
+}
+
 static int imans_install(struct nsset *nsset, struct ns_common *new)
 {
+	int res;
 	struct nsproxy *nsproxy = nsset->nsproxy;
 	struct ima_namespace *ns = to_ima_ns(new);
 
@@ -180,6 +262,10 @@ static int imans_install(struct nsset *nsset, struct ns_common *new)
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	res = imans_activate(ns);
+	if (res)
+		return res;
+
 	get_ima_ns(ns);
 	put_ima_ns(nsproxy->ima_ns);
 	nsproxy->ima_ns = ns;
@@ -188,11 +274,12 @@ static int imans_install(struct nsset *nsset, struct ns_common *new)
 	put_ima_ns(nsproxy->ima_ns_for_children);
 	nsproxy->ima_ns_for_children = ns;
 
-	return 0;
+	return res;
 }
 
 int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
+	int res;
 	struct ns_common *nsc = &nsproxy->ima_ns_for_children->ns;
 	struct ima_namespace *ns = to_ima_ns(nsc);
 
@@ -200,11 +287,15 @@ int imans_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 	if (nsproxy->ima_ns == nsproxy->ima_ns_for_children)
 		return 0;
 
+	res = imans_activate(ns);
+	if (res)
+		return res;
+
 	get_ima_ns(ns);
 	put_ima_ns(nsproxy->ima_ns);
 	nsproxy->ima_ns = ns;
 
-	return 0;
+	return res;
 }
 
 static struct user_namespace *imans_owner(struct ns_common *ns)
-- 
2.20.1

