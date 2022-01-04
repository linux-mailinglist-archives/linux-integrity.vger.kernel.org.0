Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A05484693
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiADRFV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235658AbiADRE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GRmid006498;
        Tue, 4 Jan 2022 17:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cbj7vLN8jyV+8IXCX4Sue9aqdVGZqiyS8o+93S5bSVc=;
 b=nm7MJt48Sc+xCV7Z/+14tFWyHU1QOhQP4z3g5rbBhHli2JhSLwcl10A6NIQj3LIF1ywD
 nZ3YlHmjsjSfqYk434v5zJ7mLrHMVoIY0BWgMfdZAbcT5FSG0eXpf9eCrvur4tED8yIo
 UWdv+IcthhAgG9l1WkURQHjE8ivtja5AyVlsDMxRhuFBB7NOcd6s1Z8lG2w0023l66Gz
 Up4IaI3Nxi4CG6igKXU4h8bPYwAc3g6Al4J9V4dY+LG5F05Ao/WFKnWfMCO2HZGJjvCx
 ZftI6KLxyZHEpOwYLou+RVrYMWZTip1kUnDlc3jiRsAvS6Wm+ghD4STYfMzXo3LgHRXS ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcmaw7h14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204Gr61C005471;
        Tue, 4 Jan 2022 17:04:33 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcmaw7h0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H2eaC019359;
        Tue, 4 Jan 2022 17:04:32 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3daekbaey8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:32 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4Uog44106122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5C09AC064;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A73BCAC05B;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 14/19] integrity/ima: Define ns_status for storing namespaced iint data
Date:   Tue,  4 Jan 2022 12:04:11 -0500
Message-Id: <20220104170416.1923685-15-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3yxltoYmj4g8s7txNE0Fof82GTrnd1s6
X-Proofpoint-ORIG-GUID: JE9kl3ylUWLOseH34VYPWUDBXdO88dlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

Add an rbtree to the IMA namespace structure that stores a namespaced
version of iint->flags in ns_status struct. Similar to the
integrity_iint_cache, both the iint and ns_status are looked up using the
inode pointer value. The lookup, allocate, and insertion code is also
similar.

In subsequent patches we will have to find all ns_status entries an iint
is being used in and reset flags there. To do this, connect a list of
ns_status to the integrity_iint_cache and provide a reader-writer
lock in the integrity_iint_cache to lock access to the list.

When getting an ns_status first try to find it in the RB tree. Here we can
run into the situation that an ns_status found in the RB tree has a
different iint associated with it for the same inode. In this case we need
to delete the ns_status structure and get a new one.

There are two cases for freeing:
- when the iint is freed (inode deletion): Walk the list of ns_status
  entries and disconnect each ns_status from the list; take the
  writer lock to protect access to the list; also, take the item off the
  per-namespace rbtree

- when the ima_namepace is freed: While walking the rbtree, remove the
  ns_status from the list while also holding the iint's writer lock;
  to be able to grab the lock we have to have a pointer to the iint on
  the ns_status structure.

To avoid an ns_status to be freed by the two cases concurrently, prevent
these two cases to run concurrently. Therefore, groups of threads
deleting either inodes or ima_namespaces are allowed to run concurrenty
but no two threads may run and one delete an inode and the other an
ima_namespace.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      |   3 +
 security/integrity/iint.c                |  13 +
 security/integrity/ima/Makefile          |   2 +-
 security/integrity/ima/ima.h             |  29 ++
 security/integrity/ima/ima_init_ima_ns.c |   5 +
 security/integrity/ima/ima_ns.c          |   1 +
 security/integrity/ima/ima_ns_status.c   | 335 +++++++++++++++++++++++
 security/integrity/integrity.h           |   4 +
 8 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/ima/ima_ns_status.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 06c88cb17b21..e236eef5b486 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -231,6 +231,9 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 
 void free_ima_ns(struct user_namespace *ns);
 
+extern void ima_free_ns_status_list(struct list_head *head,
+				    rwlock_t *ns_list_lock);
+
 #else
 
 static inline void free_ima_ns(struct user_namespace *user_ns)
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..9d8db7d4358c 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
+#include <linux/ima.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
@@ -82,6 +83,10 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+#ifdef CONFIG_IMA_NS
+	rwlock_init(&iint->ns_list_lock);
+	INIT_LIST_HEAD(&iint->ns_list);
+#endif
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -155,6 +160,10 @@ void integrity_inode_free(struct inode *inode)
 	rb_erase(&iint->rb_node, &integrity_iint_tree);
 	write_unlock(&integrity_iint_lock);
 
+#ifdef CONFIG_IMA_NS
+	ima_free_ns_status_list(&iint->ns_list, &iint->ns_list_lock);
+#endif
+
 	iint_free(iint);
 }
 
@@ -170,6 +179,10 @@ static void init_once(void *foo)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	mutex_init(&iint->mutex);
+#ifdef CONFIG_IMA_NS
+	rwlock_init(&iint->ns_list_lock);
+	INIT_LIST_HEAD(&iint->ns_list);
+#endif
 }
 
 static int __init integrity_iintcache_init(void)
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b86a35fbed60..edfb0c30a063 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,7 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
-ima-$(CONFIG_IMA_NS) += ima_ns.o
+ima-$(CONFIG_IMA_NS) += ima_ns.o ima_ns_status.o
 
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4255301e5b96..e4804be6b524 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -123,6 +123,10 @@ struct ima_h_table {
 };
 
 struct ima_namespace {
+	struct rb_root ns_status_tree;
+	rwlock_t ns_tree_lock;
+	struct kmem_cache *ns_status_cache;
+
 	struct list_head ima_default_rules;
 	/* ns's policy rules */
 	struct list_head ima_policy_rules;
@@ -159,6 +163,18 @@ static inline void ima_load_kexec_buffer(void) {}
  */
 extern bool ima_canonical_fmt;
 
+struct ns_status {
+	struct list_head ns_next;
+	struct rb_node rb_node;
+	struct integrity_iint_cache *iint;
+	struct inode *inode;
+	struct ima_namespace *ns;
+	ino_t i_ino;
+	u32 i_generation;
+	unsigned long flags;
+	struct llist_node gc_llist; /* used while freeing */
+};
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
@@ -508,6 +524,12 @@ static inline struct ima_namespace *get_current_ns(void)
 
 struct ima_namespace *create_ima_ns(struct user_namespace *user_ns);
 
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode,
+				    struct integrity_iint_cache *iint);
+
+void ima_free_ns_status_tree(struct ima_namespace *ns);
+
 #else
 
 static inline struct ima_namespace *
@@ -517,6 +539,13 @@ create_ima_ns(struct user_namespace *user_ns)
 	return ERR_PTR(-EFAULT);
 }
 
+static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+						  struct inode *inode,
+						  struct integrity_iint_cache *iint)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 6eac998781c3..f8ffa07d6edc 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -10,6 +10,11 @@
 
 int ima_init_namespace(struct ima_namespace *ns)
 {
+	ns->ns_status_tree = RB_ROOT;
+	rwlock_init(&ns->ns_tree_lock);
+	/* Use KMEM_CACHE for simplicity */
+	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
+
 	INIT_LIST_HEAD(&ns->ima_default_rules);
 	INIT_LIST_HEAD(&ns->ima_policy_rules);
 	INIT_LIST_HEAD(&ns->ima_temp_rules);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 675466d292e8..5a79fb6c10c0 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -40,6 +40,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	pr_debug("DESTROY ima_ns: %p\n", ns);
 	ima_free_policy_rules(ns);
+	ima_free_ns_status_tree(ns);
 	kmem_cache_free(imans_cachep, ns);
 }
 
diff --git a/security/integrity/ima/ima_ns_status.c b/security/integrity/ima/ima_ns_status.c
new file mode 100644
index 000000000000..78c1ace49ccd
--- /dev/null
+++ b/security/integrity/ima/ima_ns_status.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 IBM Corporation
+ * Author:
+ *  Yuqiong Sun <suny@us.ibm.com>
+ *  Stefan Berger <stefanb@linux.vnet.ibm.com>
+ */
+
+#include <linux/user_namespace.h>
+#include <linux/ima.h>
+
+#include "ima.h"
+
+/*
+ * An ns_status must be on a per-namespace rbtree and on a per-iint list.
+ *
+ * Locking order for ns_status:
+ * 1) ns->ns_tree_lock  : Lock the rbtree
+ * 2) iint->ns_list_lock: Lock the list
+ *
+ * An ns_status can be freed either by walking the rbtree (namespace deletion)
+ * or by walking the linked list of ns_status (inode/iint deletion). There are
+ * two functions that implement each one of the cases. To avoid concurrent
+ * freeing of the same ns_status, the two freeing paths cannot be run
+ * concurrently but each path can be run by multiple threads since no two
+ * threads will free the same inode/iint and no two threads will free the same
+ * namespace. Grouping threads like this ensures that:
+ * - while walking the rbtree: all ns_status will be on their list and the iint
+ *                             will still exist
+ * - while walking the list:   all ns_status will be on their rbtree
+ */
+enum lk_group {
+	GRP_NS_STATUS_LIST = 0,
+	GRP_NS_STATUS_TREE
+};
+static atomic_t lg_ctr[2] = {
+	ATOMIC_INIT(0),
+	ATOMIC_INIT(0)
+};
+static DEFINE_SPINLOCK(lg_ctr_lock);
+static struct wait_queue_head lg_wq[2] = {
+	__WAIT_QUEUE_HEAD_INITIALIZER(lg_wq[0]),
+	__WAIT_QUEUE_HEAD_INITIALIZER(lg_wq[1])
+};
+static atomic_t ns_list_waiters = ATOMIC_INIT(0);
+
+/* Any number of concurrent threads may free ns_status's in either one of the
+ * groups but the groups must not run concurrently. The GRP_NS_STATUS_TREE
+ * group yields to waiters in the GRP_NS_STATUS_LIST group since namespace
+ * deletion has more time.
+ */
+static void lock_group(enum lk_group group)
+{
+	unsigned long flags;
+	bool done = false;
+	int announced = 0;
+
+	while (1) {
+		spin_lock_irqsave(&lg_ctr_lock, flags);
+
+		switch (group) {
+		case GRP_NS_STATUS_LIST:
+			if (atomic_read(&lg_ctr[GRP_NS_STATUS_TREE]) == 0) {
+				if (announced)
+					atomic_dec(&ns_list_waiters);
+				done = true;
+				atomic_inc(&lg_ctr[GRP_NS_STATUS_LIST]);
+			} else {
+				/* rbtree being deleted; announce waiting */
+				if (!announced) {
+					atomic_inc(&ns_list_waiters);
+					announced = 1;
+				}
+			}
+			break;
+		case GRP_NS_STATUS_TREE:
+			if (atomic_read(&lg_ctr[GRP_NS_STATUS_LIST]) == 0 &&
+			    atomic_read(&ns_list_waiters) == 0) {
+				done = true;
+				atomic_inc(&lg_ctr[GRP_NS_STATUS_TREE]);
+			}
+			break;
+		}
+
+		spin_unlock_irqrestore(&lg_ctr_lock, flags);
+
+		if (done)
+			break;
+
+		/* wait until opposite group is done */
+		switch (group) {
+		case GRP_NS_STATUS_LIST:
+			wait_event_interruptible(
+				lg_wq[GRP_NS_STATUS_LIST],
+				atomic_read(&lg_ctr[GRP_NS_STATUS_TREE]) == 0);
+			break;
+		case GRP_NS_STATUS_TREE:
+			wait_event_interruptible(
+				lg_wq[GRP_NS_STATUS_TREE],
+				atomic_read(&lg_ctr[GRP_NS_STATUS_LIST]) == 0 &&
+				atomic_read(&ns_list_waiters) == 0);
+			break;
+		}
+	}
+}
+
+static void unlock_group(enum lk_group group)
+{
+	switch (group) {
+	case GRP_NS_STATUS_LIST:
+		if (atomic_dec_and_test(&lg_ctr[GRP_NS_STATUS_LIST]))
+			wake_up_interruptible_all(&lg_wq[GRP_NS_STATUS_TREE]);
+		break;
+	case GRP_NS_STATUS_TREE:
+		if (atomic_dec_and_test(&lg_ctr[GRP_NS_STATUS_TREE]))
+			wake_up_interruptible_all(&lg_wq[GRP_NS_STATUS_LIST]);
+		break;
+	}
+}
+
+static void ns_status_free(struct ima_namespace *ns, struct ns_status *status)
+{
+	pr_debug("FREE ns_status: %p\n", status);
+
+	kmem_cache_free(ns->ns_status_cache, status);
+}
+
+
+/*
+ * ima_free_ns_status_tree - free all items on the ns_status_tree and take each
+ *                           one off the list; yield to ns_list free'ers
+ *
+ * This function is called when an ima_namespace is freed. All entries in the
+ * rbtree will be taken off their list and collected in a garbage collection
+ * list and freed at the end. This allows to walk the rbtree again.
+ */
+void ima_free_ns_status_tree(struct ima_namespace *ns)
+{
+	struct ns_status *status, *next;
+	struct llist_node *node;
+	LLIST_HEAD(garbage);
+	unsigned int ctr;
+	bool restart;
+
+	do {
+		ctr = 0;
+		restart = false;
+
+		lock_group(GRP_NS_STATUS_TREE);
+		write_lock(&ns->ns_tree_lock);
+
+		rbtree_postorder_for_each_entry_safe(status, next,
+						&ns->ns_status_tree, rb_node) {
+			write_lock(&status->iint->ns_list_lock);
+			if (!list_empty(&status->ns_next)) {
+				list_del_init(&status->ns_next);
+				llist_add(&status->gc_llist, &garbage);
+				ctr++;
+			}
+			write_unlock(&status->iint->ns_list_lock);
+
+			/* After some progress yield to any waiting ns_list
+			 * free'ers.
+			 */
+			if (atomic_read(&ns_list_waiters) > 0 && ctr >= 5) {
+				restart = true;
+				break;
+			}
+		}
+
+		write_unlock(&ns->ns_tree_lock);
+		unlock_group(GRP_NS_STATUS_TREE);
+	} while (restart);
+
+	node = llist_del_all(&garbage);
+	llist_for_each_entry_safe(status, next, node, gc_llist)
+		ns_status_free(ns, status);
+
+	kmem_cache_destroy(ns->ns_status_cache);
+}
+
+/*
+ * ima_free_ns_status_list: free the list of ns_status items and take
+ *                          each one off its namespace rbtree
+ */
+void ima_free_ns_status_list(struct list_head *head, rwlock_t *ns_list_lock)
+{
+	struct ns_status *status;
+
+	lock_group(GRP_NS_STATUS_LIST);
+
+	while (1) {
+		write_lock(ns_list_lock);
+		status = list_first_entry_or_null(head,
+						  struct ns_status, ns_next);
+		if (status)
+			list_del_init(&status->ns_next);
+		write_unlock(ns_list_lock);
+
+		if (!status)
+			break;
+
+		write_lock(&status->ns->ns_tree_lock);
+
+		rb_erase(&status->rb_node, &status->ns->ns_status_tree);
+		RB_CLEAR_NODE(&status->rb_node);
+
+		write_unlock(&status->ns->ns_tree_lock);
+
+		ns_status_free(status->ns, status);
+	}
+
+	unlock_group(GRP_NS_STATUS_LIST);
+}
+
+/*
+ * ns_status_find - return the ns_status associated with an inode;
+ *                  caller must hold lock for tree
+ */
+static struct ns_status *ns_status_find(struct ima_namespace *ns,
+					struct inode *inode)
+{
+	struct ns_status *status;
+	struct rb_node *n = ns->ns_status_tree.rb_node;
+
+	while (n) {
+		status = rb_entry(n, struct ns_status, rb_node);
+
+		if (inode < status->inode)
+			n = n->rb_left;
+		else if (inode > status->inode)
+			n = n->rb_right;
+		else
+			break;
+	}
+	if (!n)
+		return NULL;
+
+	return status;
+}
+
+static void insert_ns_status(struct ima_namespace *ns, struct inode *inode,
+			     struct ns_status *status)
+{
+	struct rb_node **p;
+	struct rb_node *node, *parent = NULL;
+	struct ns_status *test_status;
+
+	p = &ns->ns_status_tree.rb_node;
+	while (*p) {
+		parent = *p;
+		test_status = rb_entry(parent, struct ns_status, rb_node);
+		if (inode < test_status->inode)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	node = &status->rb_node;
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, &ns->ns_status_tree);
+}
+
+static void ns_status_unlink(struct ima_namespace *ns,
+				 struct ns_status *status)
+{
+	write_lock(&status->iint->ns_list_lock);
+	if (!list_empty(&status->ns_next))
+		list_del_init(&status->ns_next);
+	write_unlock(&status->iint->ns_list_lock);
+
+	rb_erase(&status->rb_node, &ns->ns_status_tree);
+	RB_CLEAR_NODE(&status->rb_node);
+}
+
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode,
+				    struct integrity_iint_cache *iint)
+{
+	struct ns_status *status;
+
+	/* Prevent finding the status via the list (inode/iint deletion) since
+	 * we may free it.
+	 */
+	lock_group(GRP_NS_STATUS_TREE);
+
+	write_lock(&ns->ns_tree_lock);
+
+	status = ns_status_find(ns, inode);
+	if (status) {
+		/* Check for ns_status with same inode but a stale iint.
+		 */
+		if (unlikely(status->iint != iint)) {
+			ns_status_unlink(ns, status);
+			ns_status_free(ns, status);
+			goto get_new;
+		} else if (inode->i_ino == status->i_ino &&
+			   inode->i_generation == status->i_generation) {
+			goto unlock;
+		}
+
+		/* Same inode number is reused, overwrite the ns_status */
+	} else {
+get_new:
+		status = kmem_cache_alloc(ns->ns_status_cache, GFP_NOFS);
+		if (!status) {
+			status = ERR_PTR(-ENOMEM);
+			goto unlock;
+		}
+
+		pr_debug("NEW  ns_status: %p\n", status);
+
+		INIT_LIST_HEAD(&status->ns_next);
+		insert_ns_status(ns, inode, status);
+	}
+
+	status->iint = iint;
+	status->inode = inode;
+	status->ns = ns;
+	status->i_ino = inode->i_ino;
+	status->i_generation = inode->i_generation;
+	status->flags = 0UL;
+
+	/* make visible on list */
+	write_lock(&iint->ns_list_lock);
+	if (list_empty(&status->ns_next))
+		list_add_tail(&status->ns_next, &iint->ns_list);
+	write_unlock(&iint->ns_list_lock);
+
+unlock:
+	write_unlock(&ns->ns_tree_lock);
+
+	unlock_group(GRP_NS_STATUS_TREE);
+
+	return status;
+}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..201a9d46d6e1 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -138,6 +138,10 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+#ifdef CONFIG_IMA_NS
+	rwlock_t ns_list_lock;
+	struct list_head ns_list;
+#endif
 };
 
 /* rbtree tree calls to lookup, insert, delete
-- 
2.31.1

