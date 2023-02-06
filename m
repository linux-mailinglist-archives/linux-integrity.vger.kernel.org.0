Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B790668BF8D
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjBFOGv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjBFOFU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:05:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F228D30;
        Mon,  6 Feb 2023 06:04:17 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqMEK022765;
        Mon, 6 Feb 2023 14:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=PFxGIpDllx9p3i6Uz9ij+BGoduIOgzVZ0R9XjHCEPUE=;
 b=nVg5/9HTzCDOhi3caPoAZ5ZOlvHr1Lwf41xOVKdj7CWDCA+s5JBK5yHtNBd8R+hmhleG
 JHxZpFoohsmxiYdaT0rtlGotVru1162goWRC6/8ZzEsWnAL1BK5W89EBJkCW/HiVE7/E
 ifOhu2ZsBRSC9sy5skr37ynLurDadopEdjsoNM4RzknRB6sUCgGYe/82tBTjFnk1S4eD
 JF6andcYsRgA9bAsFZM55lqCpJDdcaeEkO1rifInKj5rIB1PHoOTgGuvh51cFYB/SqDU
 R+jZdpGaHos10O7fmqlV35fbX9XYcXewj2ZSXSxTIMG+WNFfjI2Tw5+3IyxenNARWXZy Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tf0cv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:39 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DqQDK023899;
        Mon, 6 Feb 2023 14:03:38 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2tf0cuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316C7brV017679;
        Mon, 6 Feb 2023 14:03:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf07dq6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3acm8520286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27DBC5805D;
        Mon,  6 Feb 2023 14:03:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D10858058;
        Mon,  6 Feb 2023 14:03:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:34 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Denis Semakin <denis.semakin@huawei.com>,
        Ilya Hanov <ilya.hanov@huawei-partners.com>
Subject: [PATCH v15 17/26] integrity/ima: Define ns_status for storing namespaced iint data
Date:   Mon,  6 Feb 2023 09:02:44 -0500
Message-Id: <20230206140253.3755945-18-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JAQmok1E3liWutrCq5GfI-bHsHgk773Y
X-Proofpoint-ORIG-GUID: seROBH5f-1nJ4Db2VTRXntJtZeOu2Ou4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Ilya Hanov <ilya.hanov@huawei-partners.com>

---

Design discussion:
 - https://lore.kernel.org/linux-integrity/20220201203735.164593-1-stefanb@linux.ibm.com/T/#m500a621141c52dc0e34cf11ba37b4032a2de84fd

v15:
 - Free ns_status_cache in case of error

v9:
 - Move ns_status into integrity.h and embedded it into integrity_iint_cache
   for the non-CONFIG_IMA_NS case
---
 include/linux/ima.h                      |   7 +
 security/integrity/iint.c                |   7 +
 security/integrity/ima/Makefile          |   2 +-
 security/integrity/ima/ima.h             |  18 ++
 security/integrity/ima/ima_init_ima_ns.c |  11 +-
 security/integrity/ima/ima_ns.c          |   1 +
 security/integrity/ima/ima_ns_status.c   | 344 +++++++++++++++++++++++
 security/integrity/integrity.h           |  35 ++-
 8 files changed, 422 insertions(+), 3 deletions(-)
 create mode 100644 security/integrity/ima/ima_ns_status.c

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 1b1fc643b371..20f9b95090f4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -254,12 +254,19 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
 
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
index 9dc199a20fc0..3206d8cb8ca4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -127,6 +127,10 @@ struct ima_namespace {
 /* Bit numbers for above flags; use BIT() to get flag */
 #define IMA_NS_LSM_UPDATE_RULES		0
 
+	struct rb_root ns_status_tree;
+	rwlock_t ns_tree_lock;
+	struct kmem_cache *ns_status_cache;
+
 	/* policy rules */
 	struct list_head ima_default_rules; /* Kconfig, builtin & arch rules */
 	struct list_head ima_policy_rules;  /* arch & custom rules */
@@ -512,6 +516,12 @@ static inline struct ima_namespace
 
 struct ima_namespace *create_ima_ns(void);
 
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode,
+				    struct integrity_iint_cache *iint);
+
+void ima_free_ns_status_tree(struct ima_namespace *ns);
+
 #else
 
 static inline struct ima_namespace *create_ima_ns(void)
@@ -520,6 +530,14 @@ static inline struct ima_namespace *create_ima_ns(void)
 	return ERR_PTR(-EFAULT);
 }
 
+static inline struct ns_status *ima_get_ns_status
+					(struct ima_namespace *ns,
+					 struct inode *inode,
+					 struct integrity_iint_cache *iint)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index b497062090cf..e841302cada9 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -12,6 +12,11 @@ int ima_init_namespace(struct ima_namespace *ns)
 {
 	int ret;
 
+	ns->ns_status_tree = RB_ROOT;
+	rwlock_init(&ns->ns_tree_lock);
+	/* Use KMEM_CACHE for simplicity */
+	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
+
 	INIT_LIST_HEAD(&ns->ima_default_rules);
 	INIT_LIST_HEAD(&ns->ima_policy_rules);
 	INIT_LIST_HEAD(&ns->ima_temp_rules);
@@ -38,10 +43,14 @@ int ima_init_namespace(struct ima_namespace *ns)
 		ret = register_blocking_lsm_notifier
 						(&ns->ima_lsm_policy_notifier);
 		if (ret)
-			return ret;
+			goto err_destroy_cache;
 	}
 
 	return 0;
+
+err_destroy_cache:
+	kmem_cache_destroy(ns->ns_status_cache);
+	return ret;
 }
 
 int __init ima_ns_init(void)
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
index 000000000000..9c753caad6ac
--- /dev/null
+++ b/security/integrity/ima/ima_ns_status.c
@@ -0,0 +1,344 @@
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
+/*
+ * Any number of concurrent threads may free ns_status's in either one of the
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
+			/*
+			 * After some progress yield to any waiting ns_list
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
+	bool get_new = true;
+
+	/*
+	 * Prevent finding the status via the list (inode/iint deletion) since
+	 * we may free it.
+	 */
+	lock_group(GRP_NS_STATUS_TREE);
+
+	write_lock(&ns->ns_tree_lock);
+
+	ns_status = ns_status_find(ns, inode);
+	if (ns_status) {
+		if (unlikely(ns_status->iint != iint)) {
+			/* Same inode but stale iint: free it and get new */
+			ns_status_unlink(ns, ns_status);
+			ns_status_free(ns, ns_status);
+		} else if (inode->i_ino == ns_status->i_ino &&
+			   inode->i_generation == ns_status->i_generation) {
+			goto unlock;
+		} else {
+			/* Reuse of ns_status is possible but need reset */
+			ns_status_reset(ns_status);
+			get_new = false;
+		}
+	}
+
+	if (get_new) {
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
index 7167a6e99bdc..112836d9b33a 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -155,13 +155,39 @@ struct ima_file_id {
 	__u8 hash[HASH_MAX_DIGESTSIZE];
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
@@ -171,6 +197,13 @@ struct integrity_iint_cache {
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
2.37.3

