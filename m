Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECB2489CC
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHRP0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbgHRP0X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:23 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 0B4381ACF16B75453D57;
        Tue, 18 Aug 2020 16:26:22 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:20 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:23 +0200
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
Subject: [RFC PATCH 07/30] ima: Extend the APIs in the integrity subsystem
Date:   Tue, 18 Aug 2020 17:20:14 +0200
Message-ID: <20200818152037.11869-8-krzysztof.struczynski@huawei.com>
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

Inode integrity cache will be maintained per ima namespace. Add new
functions that allow to specify the iint tree to use.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/integrity.h      |  31 ++++++++
 security/integrity/iint.c      | 126 ++++++++++++++++++++++++++-------
 security/integrity/integrity.h |  11 +++
 3 files changed, 144 insertions(+), 24 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 2271939c5c31..5019fedaa17a 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -8,6 +8,10 @@
 #define _LINUX_INTEGRITY_H
 
 #include <linux/fs.h>
+#include <linux/rwlock_types.h>
+
+struct rb_root;
+struct integrity_iint_tree;
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -21,8 +25,15 @@ enum integrity_status {
 /* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
 extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
+extern struct integrity_iint_cache *integrity_inode_rb_get(struct
+							   integrity_iint_tree
+							   *iint_tree,
+							   struct inode *inode);
 extern void integrity_inode_free(struct inode *inode);
+extern void integrity_inode_rb_free(struct integrity_iint_tree *iint_tree,
+				    struct inode *inode);
 extern void __init integrity_load_keys(void);
+extern void integrity_iint_tree_free(struct integrity_iint_tree *iint_tree);
 
 #else
 static inline struct integrity_iint_cache *
@@ -31,14 +42,34 @@ static inline struct integrity_iint_cache *
 	return NULL;
 }
 
+static inline struct integrity_iint_cache *
+				integrity_inode_rb_get(struct
+						       integrity_iint_tree
+						       *iint_tree,
+						       struct inode *inode)
+{
+	return NULL;
+}
+
 static inline void integrity_inode_free(struct inode *inode)
 {
 	return;
 }
 
+static inline void integrity_inode_rb_free(struct integrity_iint_tree
+					   *iint_tree,
+					   struct inode *inode)
+{
+}
+
 static inline void integrity_load_keys(void)
 {
 }
+
+static inline void integrity_iint_tree_free(struct integrity_iint_tree
+					    *iint_tree)
+{
+}
 #endif /* CONFIG_INTEGRITY */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 1d20003243c3..34a36f298f92 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -21,19 +21,29 @@
 #include <linux/lsm_hooks.h>
 #include "integrity.h"
 
-static struct rb_root integrity_iint_tree = RB_ROOT;
-static DEFINE_RWLOCK(integrity_iint_lock);
+struct integrity_iint_tree init_iint_tree = {
+	.lock = __RW_LOCK_UNLOCKED(init_iint_tree.lock),
+	.root = RB_ROOT
+};
+
 static struct kmem_cache *iint_cache __read_mostly;
 
 struct dentry *integrity_dir;
 
 /*
- * __integrity_iint_find - return the iint associated with an inode
+ * __integrity_iint_rb_find - return the iint associated with an inode
+ * @iint_rb_root: pointer to the root of the iint tree
+ * @inode: pointer to the inode
+ * @return: pointer to the iint if found, NULL otherwise
  */
-static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
+static struct integrity_iint_cache *
+				__integrity_iint_rb_find(const struct rb_root
+							 *iint_rb_root,
+							 const struct inode
+							 *inode)
 {
 	struct integrity_iint_cache *iint;
-	struct rb_node *n = integrity_iint_tree.rb_node;
+	struct rb_node *n = iint_rb_root->rb_node;
 
 	while (n) {
 		iint = rb_entry(n, struct integrity_iint_cache, rb_node);
@@ -52,22 +62,37 @@ static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
 }
 
 /*
- * integrity_iint_find - return the iint associated with an inode
+ * integrity_iint_rb_find - return the iint associated with an inode
+ * @iint_tree: pointer to the iint tree root node and the associated lock
+ * @inode: pointer to the inode
+ * @return: pointer to the iint if found, NULL otherwise
  */
-struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
+struct integrity_iint_cache *integrity_iint_rb_find(struct integrity_iint_tree
+						    *iint_tree,
+						    const struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
 
 	if (!IS_IMA(inode))
 		return NULL;
 
-	read_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	read_unlock(&integrity_iint_lock);
+	read_lock(&iint_tree->lock);
+	iint = __integrity_iint_rb_find(&iint_tree->root, inode);
+	read_unlock(&iint_tree->lock);
 
 	return iint;
 }
 
+/*
+ * integrity_iint_find - return the iint associated with an inode
+ * @inode: pointer to the inode
+ * @return: pointer to the iint if found, NULL otherwise
+ */
+struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
+{
+	return integrity_iint_rb_find(&init_iint_tree, inode);
+}
+
 static void iint_free(struct integrity_iint_cache *iint)
 {
 	kfree(iint->ima_hash);
@@ -86,19 +111,42 @@ static void iint_free(struct integrity_iint_cache *iint)
 }
 
 /**
- * integrity_inode_get - find or allocate an iint associated with an inode
+ * integrity_iint_tree_free - traverse the tree and free all nodes
+ * @iint_tree: pointer to the iint tree root node and the associated lock
+ *
+ * The tree cannot be in use. This function should be called only from the
+ * destructor when no locks are required.
+ */
+void integrity_iint_tree_free(struct integrity_iint_tree *iint_tree)
+{
+	struct rb_root *root = &iint_tree->root;
+	struct integrity_iint_cache *iint, *tmp;
+
+	rbtree_postorder_for_each_entry_safe(iint, tmp, root, rb_node) {
+		iint_free(iint);
+	}
+
+	iint_tree->root = RB_ROOT;
+}
+
+/**
+ * integrity_inode_rb_get - find or allocate an iint associated with an inode
+ * @iint_tree: pointer to the iint tree root node and the associated lock
  * @inode: pointer to the inode
- * @return: allocated iint
+ * @return: pointer to the existing iint if found, pointer to the allocated iint
+ * if it didn't exist, NULL in case of error
  *
  * Caller must lock i_mutex
  */
-struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
+struct integrity_iint_cache *integrity_inode_rb_get(struct integrity_iint_tree
+						    *iint_tree,
+						    struct inode *inode)
 {
 	struct rb_node **p;
 	struct rb_node *node, *parent = NULL;
 	struct integrity_iint_cache *iint, *test_iint;
 
-	iint = integrity_iint_find(inode);
+	iint = integrity_iint_rb_find(iint_tree, inode);
 	if (iint)
 		return iint;
 
@@ -106,9 +154,9 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
-	write_lock(&integrity_iint_lock);
+	write_lock(&iint_tree->lock);
 
-	p = &integrity_iint_tree.rb_node;
+	p = &iint_tree->root.rb_node;
 	while (*p) {
 		parent = *p;
 		test_iint = rb_entry(parent, struct integrity_iint_cache,
@@ -123,33 +171,63 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	node = &iint->rb_node;
 	inode->i_flags |= S_IMA;
 	rb_link_node(node, parent, p);
-	rb_insert_color(node, &integrity_iint_tree);
+	rb_insert_color(node, &iint_tree->root);
 
-	write_unlock(&integrity_iint_lock);
+	write_unlock(&iint_tree->lock);
 	return iint;
 }
 
 /**
- * integrity_inode_free - called on security_inode_free
+ * integrity_inode_get - find or allocate an iint associated with an inode
+ * @inode: pointer to the inode
+ * @return: pointer to the existing iint if found, pointer to the allocated iint
+ * if it didn't exist, NULL in case of error
+ *
+ * Caller must lock i_mutex
+ */
+struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
+{
+	return integrity_inode_rb_get(&init_iint_tree, inode);
+}
+
+/**
+ * integrity_inode_rb_free - called on security_inode_free
+ * @iint_tree: pointer to the iint tree root node and the associated lock
  * @inode: pointer to the inode
  *
  * Free the integrity information(iint) associated with an inode.
  */
-void integrity_inode_free(struct inode *inode)
+void integrity_inode_rb_free(struct integrity_iint_tree *iint_tree,
+			     struct inode *inode)
 {
 	struct integrity_iint_cache *iint;
 
 	if (!IS_IMA(inode))
 		return;
 
-	write_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	rb_erase(&iint->rb_node, &integrity_iint_tree);
-	write_unlock(&integrity_iint_lock);
+	write_lock(&iint_tree->lock);
+	iint = __integrity_iint_rb_find(&iint_tree->root, inode);
+	if (!iint) {
+		write_unlock(&iint_tree->lock);
+		return;
+	}
+	rb_erase(&iint->rb_node, &iint_tree->root);
+	write_unlock(&iint_tree->lock);
 
 	iint_free(iint);
 }
 
+/**
+ * integrity_inode_free - called on security_inode_free
+ * @inode: pointer to the inode
+ *
+ * Free the integrity information(iint) associated with an inode.
+ */
+void integrity_inode_free(struct inode *inode)
+{
+	integrity_inode_rb_free(&init_iint_tree, inode);
+}
+
 static void init_once(void *foo)
 {
 	struct integrity_iint_cache *iint = foo;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 413c803c5208..721d1850e4f9 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -140,11 +140,20 @@ struct integrity_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
+struct integrity_iint_tree {
+	rwlock_t lock;
+	struct rb_root root;
+};
+
 /* rbtree tree calls to lookup, insert, delete
  * integrity data associated with an inode.
  */
 struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
 
+struct integrity_iint_cache *integrity_iint_rb_find(struct integrity_iint_tree
+						    *iint_tree,
+						    const struct inode *inode);
+
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
 
@@ -155,6 +164,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 
 extern struct dentry *integrity_dir;
 
+extern struct integrity_iint_tree init_iint_tree;
+
 struct modsig;
 
 #ifdef CONFIG_INTEGRITY_SIGNATURE
-- 
2.20.1

