Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE449BF05
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jan 2022 23:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiAYWrt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 17:47:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234230AbiAYWra (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 17:47:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PKAYEA008922;
        Tue, 25 Jan 2022 22:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KBMRAlHqbaq34yIQdl6nAq6Rioh+rNG5BNvB7eK4kx0=;
 b=oEXPc7l5xGPvLOJcRi6WU3d5IbegVKmGVJs+lyc3vGCcSz9jsXY9fQpT01b1ciPrBbIu
 UxUPZp2s7UzLyyIeYoZpYugcs9vqT6A1qQyPagbPYN3cwn+fSWbBth5PuVlYObye/UNF
 dY97QjRbWb3ZqZSrEgWRCE3sVl4x1uSW+CfGRzxPERC7I39eXog5nFZFh8KeuHdNfVLh
 zvSj90MS3vbRJCXgZwhYAr25zERuDtfk/oykBnq9NFTbgeYFPuAcKaoftuK6TeYk5tlL
 tLu/YzCMXEiAi/20NgbUPcj7tRXW/WtFXiA437Qa7uLu2uHF7jo4ak6+f6gudqeSkidT Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtqp0jxrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:04 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20PMSFXn020945;
        Tue, 25 Jan 2022 22:47:03 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtqp0jxqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:03 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20PMhsCV010557;
        Tue, 25 Jan 2022 22:47:02 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3dtbch8rgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 22:47:02 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20PMkxDp35127760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:46:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1496DAC05F;
        Tue, 25 Jan 2022 22:46:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFA76AC064;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 22:46:58 +0000 (GMT)
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
Subject: [PATCH v9 18/23] integrity/ima: Define ns_status for storing namespaced iint data
Date:   Tue, 25 Jan 2022 17:46:40 -0500
Message-Id: <20220125224645.79319-19-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G2EHsF9bJAy9xmeCQBG3PiPxFMaLp8ch
X-Proofpoint-ORIG-GUID: ewwq64XwFyumiQrassf_CG3fkY_kj_oh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_05,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250135
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

To simplify the code in the non-namespaces case embed an ns_status in
the integrity_iint_cache and have it linked into the iint's ns_status list
when calling ima_get_ns_status().

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
deleting either inodes or ima_namespaces are allowed to run concurrently
but no two threads may run and one delete an inode and the other an
ima_namespace.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v9:
 - Move ns_status into integrity.h and embedded it into integrity_iint_cache
   for the non-CONFIG_IMA_NS case
---
 include/linux/ima.h                      |   7 +
 security/integrity/iint.c                |   7 +
 security/integrity/ima/Makefile          |   2 +-
 security/integrity/ima/ima.h             |  17 ++
 security/integrity/ima/ima_init_ima_ns.c |   5 +
 security/integrity/ima/ima_ns.c          |   1 +
 security/integrity/ima/ima_ns_status.c   | 340 +++++++++++++++++++++++
 security/integrity/integrity.h           |  35 ++-
 8 files changed, 412 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns_status.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 964a08702573..2fe32f1bf84b 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -225,12 +225,19 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 
 void free_ima_ns(struct user_namespace *ns);
 
+void ima_free_ns_status_list(struct list_head *head, rwlock_t *ns_list_lock);
+
 #else
 
 static inline void free_ima_ns(struct user_namespace *user_ns)
 {
 }
 
+static inline void ima_free_ns_status_list(struct list_head *head,
+					   rwlock_t *ns_list_lock)
+{
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #endif /* _LINUX_IMA_H */
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..371cbceaf479 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
+#include <linux/ima.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
@@ -82,6 +83,8 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+	rwlock_init(&iint->ns_list_lock);
+	INIT_LIST_HEAD(&iint->ns_list);
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -155,6 +158,8 @@ void integrity_inode_free(struct inode *inode)
 	rb_erase(&iint->rb_node, &integrity_iint_tree);
 	write_unlock(&integrity_iint_lock);
 
+	ima_free_ns_status_list(&iint->ns_list, &iint->ns_list_lock);
+
 	iint_free(iint);
 }
 
@@ -170,6 +175,8 @@ static void init_once(void *foo)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	mutex_init(&iint->mutex);
+	rwlock_init(&iint->ns_list_lock);
+	INIT_LIST_HEAD(&iint->ns_list);
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
index 751e936a6311..4af8f2c4df40 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -123,6 +123,10 @@ struct ima_h_table {
 };
 
 struct ima_namespace {
+	struct rb_root ns_status_tree;
+	rwlock_t ns_tree_lock;
+	struct kmem_cache *ns_status_cache;
+
 	/* policy rules */
 	struct list_head ima_default_rules;
 	struct list_head ima_policy_rules;
@@ -507,6 +511,12 @@ static inline struct ima_namespace
 
 struct ima_namespace *create_ima_ns(void);
 
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode,
+				    struct integrity_iint_cache *iint);
+
+void ima_free_ns_status_tree(struct ima_namespace *ns);
+
 #else
 
 static inline struct ima_namespace *create_ima_ns(void)
@@ -515,6 +525,13 @@ static inline struct ima_namespace *create_ima_ns(void)
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
index 166dab4a3126..d4ddfd1de60b 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -12,6 +12,11 @@ int ima_init_namespace(struct ima_namespace *ns)
 {
 	int rc;
 
+	ns->ns_status_tree = RB_ROOT;
+	rwlock_init(&ns->ns_tree_lock);
+	/* Use KMEM_CACHE for simplicity */
+	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
+
 	INIT_LIST_HEAD(&ns->ima_default_rules);
 	INIT_LIST_HEAD(&ns->ima_policy_rules);
 	INIT_LIST_HEAD(&ns->ima_temp_rules);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index b3b81a1e313e..29af6fea2d74 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -29,6 +29,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	unregister_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
 	kfree(ns->arch_policy_entry);
 	ima_free_policy_rules(ns);
+	ima_free_ns_status_tree(ns);
 }
 
 void free_ima_ns(struct user_namespace *user_ns)
diff --git a/security/integrity/ima/ima_ns_status.c b/security/integrity/ima/ima_ns_status.c
new file mode 100644
index 000000000000..061adb114417
--- /dev/null
+++ b/security/integrity/ima/ima_ns_status.c
@@ -0,0 +1,340 @@
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
+
+static atomic_t lg_ctr[2] = {
+	ATOMIC_INIT(0),
+	ATOMIC_INIT(0)
+};
+
+static DEFINE_SPINLOCK(lg_ctr_lock);
+
+static struct wait_queue_head lg_wq[2] = {
+	__WAIT_QUEUE_HEAD_INITIALIZER(lg_wq[0]),
+	__WAIT_QUEUE_HEAD_INITIALIZER(lg_wq[1])
+};
+
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
+			wait_event_interruptible
+			    (lg_wq[GRP_NS_STATUS_LIST],
+			     atomic_read(&lg_ctr[GRP_NS_STATUS_TREE]) == 0);
+			break;
+		case GRP_NS_STATUS_TREE:
+			wait_event_interruptible
+			    (lg_wq[GRP_NS_STATUS_TREE],
+			     atomic_read(&lg_ctr[GRP_NS_STATUS_LIST]) == 0 &&
+			     atomic_read(&ns_list_waiters) == 0);
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
+static void ns_status_free(struct ima_namespace *ns,
+			   struct ns_status *ns_status)
+{
+	pr_debug("FREE ns_status: %p\n", ns_status);
+
+	kmem_cache_free(ns->ns_status_cache, ns_status);
+}
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
+	struct ns_status *ns_status, *next;
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
+		rbtree_postorder_for_each_entry_safe(ns_status, next,
+						     &ns->ns_status_tree,
+						     rb_node) {
+			write_lock(&ns_status->iint->ns_list_lock);
+			if (!list_empty(&ns_status->ns_next)) {
+				list_del_init(&ns_status->ns_next);
+				llist_add(&ns_status->gc_llist, &garbage);
+				ctr++;
+			}
+			write_unlock(&ns_status->iint->ns_list_lock);
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
+	llist_for_each_entry_safe(ns_status, next, node, gc_llist)
+		ns_status_free(ns, ns_status);
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
+	struct ns_status *ns_status;
+
+	lock_group(GRP_NS_STATUS_LIST);
+
+	while (1) {
+		write_lock(ns_list_lock);
+		ns_status = list_first_entry_or_null(head, struct ns_status,
+						     ns_next);
+		if (ns_status)
+			list_del_init(&ns_status->ns_next);
+		write_unlock(ns_list_lock);
+
+		if (!ns_status)
+			break;
+
+		write_lock(&ns_status->ns->ns_tree_lock);
+
+		rb_erase(&ns_status->rb_node, &ns_status->ns->ns_status_tree);
+		RB_CLEAR_NODE(&ns_status->rb_node);
+
+		write_unlock(&ns_status->ns->ns_tree_lock);
+
+		ns_status_free(ns_status->ns, ns_status);
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
+	struct ns_status *ns_status;
+	struct rb_node *n = ns->ns_status_tree.rb_node;
+
+	while (n) {
+		ns_status = rb_entry(n, struct ns_status, rb_node);
+
+		if (inode < ns_status->inode)
+			n = n->rb_left;
+		else if (inode > ns_status->inode)
+			n = n->rb_right;
+		else
+			break;
+	}
+	if (!n)
+		return NULL;
+
+	return ns_status;
+}
+
+static void insert_ns_status(struct ima_namespace *ns, struct inode *inode,
+			     struct ns_status *ns_status)
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
+	node = &ns_status->rb_node;
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, &ns->ns_status_tree);
+}
+
+static void ns_status_unlink(struct ima_namespace *ns,
+			     struct ns_status *ns_status)
+{
+	write_lock(&ns_status->iint->ns_list_lock);
+	if (!list_empty(&ns_status->ns_next))
+		list_del_init(&ns_status->ns_next);
+	write_unlock(&ns_status->iint->ns_list_lock);
+
+	rb_erase(&ns_status->rb_node, &ns->ns_status_tree);
+	RB_CLEAR_NODE(&ns_status->rb_node);
+}
+
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode,
+				    struct integrity_iint_cache *iint)
+{
+	struct ns_status *ns_status;
+
+	/* Prevent finding the status via the list (inode/iint deletion) since
+	 * we may free it.
+	 */
+	lock_group(GRP_NS_STATUS_TREE);
+
+	write_lock(&ns->ns_tree_lock);
+
+	ns_status = ns_status_find(ns, inode);
+	if (ns_status) {
+		/* Check for ns_status with same inode but a stale iint.
+		 */
+		if (unlikely(ns_status->iint != iint)) {
+			ns_status_unlink(ns, ns_status);
+			ns_status_free(ns, ns_status);
+			goto get_new;
+		} else if (inode->i_ino == ns_status->i_ino &&
+			   inode->i_generation == ns_status->i_generation) {
+			goto unlock;
+		}
+
+		/* Same inode number is reused, overwrite the ns_status */
+		ns_status_reset(ns_status);
+	} else {
+get_new:
+		ns_status = kmem_cache_alloc(ns->ns_status_cache, GFP_NOFS);
+		if (!ns_status) {
+			ns_status = ERR_PTR(-ENOMEM);
+			goto unlock;
+		}
+
+		pr_debug("NEW  ns_status: %p\n", ns_status);
+
+		ns_status_init(ns_status);
+		insert_ns_status(ns, inode, ns_status);
+	}
+
+	ns_status->iint = iint;
+	ns_status->inode = inode;
+	ns_status->ns = ns;
+	ns_status->i_ino = inode->i_ino;
+	ns_status->i_generation = inode->i_generation;
+
+	/* make visible on list */
+	write_lock(&iint->ns_list_lock);
+	if (list_empty(&ns_status->ns_next))
+		list_add_tail(&ns_status->ns_next, &iint->ns_list);
+	write_unlock(&iint->ns_list_lock);
+
+unlock:
+	write_unlock(&ns->ns_tree_lock);
+
+	unlock_group(GRP_NS_STATUS_TREE);
+
+	return ns_status;
+}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..b7d5ca108900 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -122,13 +122,39 @@ struct signature_v2_hdr {
 	uint8_t sig[];		/* signature payload */
 } __packed;
 
+/* integrity status of an inode in a namespace */
+struct ns_status {
+	struct list_head ns_next;
+	unsigned long flags;		/* flags split with iint */
+#ifdef CONFIG_IMA_NS
+	struct rb_node rb_node;
+	struct integrity_iint_cache *iint;
+	struct inode *inode;
+	struct ima_namespace *ns;
+	ino_t i_ino;
+	u32 i_generation;
+	struct llist_node gc_llist;	/* used while freeing */
+#endif
+};
+
+static inline void ns_status_reset(struct ns_status *ns_status)
+{
+	ns_status->flags = 0;
+}
+
+static inline void ns_status_init(struct ns_status *ns_status)
+{
+	INIT_LIST_HEAD(&ns_status->ns_next);
+	ns_status_reset(ns_status);
+}
+
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
 	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
 	struct mutex mutex;	/* protects: version, flags, digest */
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
-	unsigned long flags;
+	unsigned long flags;	/* flags split with ns_status */
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
 	enum integrity_status ima_file_status:4;
@@ -138,6 +164,13 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+
+	/*
+	 * Lock and list of ns_status for files shared by different
+	 * namespaces
+	 */
+	rwlock_t ns_list_lock;
+	struct list_head ns_list;
 };
 
 /* rbtree tree calls to lookup, insert, delete
-- 
2.31.1

