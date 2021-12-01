Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C82464EBD
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbhLAN0w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 08:26:52 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36158 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234027AbhLAN00 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 08:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638364985;
        bh=AgIqGIVJPVmJaUalLJrmEoayqaIgaOaJPZtjej4mGVo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=VFMrKiTOd7HI/pEOvsCLxvdm2Tto9LkcPWr/AAHsu9j1M2KyBp9f7j8E54fKSUA7d
         vptMmHRysjuIrAjv6eBV9tL8qT4sS508sxDxSprN/tB4Ph4u/oboV67uIoXqzZyd+O
         akkILQ9fj5xEbls6Oxuj1ESlui2GkvrSydJMWeAY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5D8F41280403;
        Wed,  1 Dec 2021 08:23:05 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HHeb-mYfWY1z; Wed,  1 Dec 2021 08:23:05 -0500 (EST)
Received: from rainbow.int.hansenpartnership.com (unknown [153.66.140.204])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0410C12803C3;
        Wed,  1 Dec 2021 08:23:03 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     containers@lists.linux.dev, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC v2 3/3] ima: make the integrity inode cache per namespace
Date:   Wed,  1 Dec 2021 13:20:44 +0000
Message-Id: <20211201132044.566371-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211201132044.566371-1-James.Bottomley@HansenPartnership.com>
References: <20211201132044.566371-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently we get one entry in the IMA log per unique file event.  So,
if you have a measurement policy and it measures a particular binary
it will not get measured again if it is subsequently executed. For
Namespaced IMA, the correct behaviour seems to be to log once per
inode per namespace (so every unique execution in a namespace gets a
separate log entry).  The reason for this are 1. principle of least
surprise, so the container log always contains deterministic entries
based on runtime independent of any preceding execution and
2. security: a malicious namespace admin could infer hidden entries in
the log simply by executing various file operations and seeing if they
show up in the log or not.  Since logging once per inode per namespace
is different from current behaviour, it is only activated if the
namespace appears in the log template (so there's no behaviour change
for any of the original templates).

Expand the iint cache to have a list of namespaces, per iint entry,
the inode has been seen in by moving the action flags and the
measured_pcrs into a per-namespace structure.  The lifetime of these
additional list entries is tied to the lifetime of the iint entry and
the namespace, so if either is deleted, the new entry is.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/user_namespace.h            |  3 +
 kernel/user.c                             |  2 +-
 security/integrity/iint.c                 |  4 +-
 security/integrity/ima/ima.h              | 18 ++++-
 security/integrity/ima/ima_api.c          |  7 +-
 security/integrity/ima/ima_main.c         | 21 ++---
 security/integrity/ima/ima_ns.c           | 96 +++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |  2 +-
 security/integrity/ima/ima_template_lib.c |  3 +
 security/integrity/integrity.h            | 11 ++-
 10 files changed, 150 insertions(+), 17 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 88d2a39596ba..52f62bf7523d 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/rwsem.h>
+#include <linux/rwlock.h>
 #include <linux/sysctl.h>
 #include <linux/err.h>
 
@@ -102,6 +103,8 @@ struct user_namespace {
 	long ucount_max[UCOUNT_COUNTS];
 #ifdef CONFIG_IMA
 	struct ima_ns_info	*ima_ns_info;
+	struct list_head	ima_inode_list;
+	rwlock_t		ima_inode_list_lock;
 #endif
 } __randomize_layout;
 
diff --git a/kernel/user.c b/kernel/user.c
index 40c0fb44ecad..fea2ac611037 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -67,7 +67,7 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
-	/* ima_ns_info is initialized in user_namespaces_init() */
+	/* all ima fields initialized in user_namespaces_init() */
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..f714532feb7d 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -71,6 +71,7 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
 static void iint_free(struct integrity_iint_cache *iint)
 {
 	kfree(iint->ima_hash);
+	ima_ns_iint_list_free(iint);
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
@@ -81,7 +82,7 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
-	iint->measured_pcrs = 0;
+	INIT_LIST_HEAD(&iint->ns_list);
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -170,6 +171,7 @@ static void init_once(void *foo)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	mutex_init(&iint->mutex);
+	INIT_LIST_HEAD(&iint->ns_list);
 }
 
 static int __init integrity_iintcache_init(void)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b3f90971a4f7..49f5377d2d24 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -119,6 +119,16 @@ struct ima_kexec_hdr {
 	u64 count;
 };
 
+/* IMA cache of per-user-namespace flags */
+struct ima_ns_cache {
+	struct user_namespace *ns;
+	struct integrity_iint_cache *iint;
+	struct list_head ns_list;
+	struct list_head iint_list;
+	unsigned long measured_pcrs;
+	unsigned long flags;
+};
+
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
@@ -263,7 +273,8 @@ int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
 			    enum hash_algo algo, struct modsig *modsig);
-void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
+void ima_store_measurement(struct integrity_iint_cache *iint,
+			   struct ima_ns_cache *nsc, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -306,8 +317,13 @@ struct ima_ns_info {
 	char label[40];		/* UUIDs are 37 ascii characters */
 	struct list_head entry;
 };
+extern bool ima_ns_in_template;
+void ima_init_ns(void);
 const char *ima_ns_info_get_label(struct user_namespace *ns);
 int ima_ns_info_set_label(struct user_namespace *ns, const char *label);
+struct ima_ns_cache *ima_ns_cache_get(struct integrity_iint_cache *iint,
+				      struct user_namespace *ns);
+void ima_ns_cache_clear(struct integrity_iint_cache *iint);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index a64fb0130b01..d613ea1ee378 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -298,6 +298,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
  * Must be called with iint->mutex held.
  */
 void ima_store_measurement(struct integrity_iint_cache *iint,
+			   struct ima_ns_cache *nsc,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
@@ -322,7 +323,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	 * appraisal, but a file measurement from earlier might already exist in
 	 * the measurement list.
 	 */
-	if (iint->measured_pcrs & (0x1 << pcr) && !modsig)
+	if (nsc->measured_pcrs & (0x1 << pcr) && !modsig)
 		return;
 
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
@@ -334,8 +335,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 
 	result = ima_store_template(entry, violation, inode, filename, pcr);
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
-		iint->flags |= IMA_MEASURED;
-		iint->measured_pcrs |= (0x1 << pcr);
+		nsc->flags |= IMA_MEASURED;
+		nsc->measured_pcrs |= (0x1 << pcr);
 	}
 	if (result < 0)
 		ima_free_template_entry(entry);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 465865412100..049710203fac 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -168,8 +168,8 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 		if (!IS_I_VERSION(inode) ||
 		    !inode_eq_iversion(inode, iint->version) ||
 		    (iint->flags & IMA_NEW_FILE)) {
-			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
-			iint->measured_pcrs = 0;
+			iint->flags &= ~IMA_NEW_FILE;
+			ima_ns_cache_clear(iint);
 			if (update)
 				ima_update_xattr(iint, file);
 		}
@@ -204,6 +204,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
+	struct ima_ns_cache *nsc = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
@@ -274,20 +275,20 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
 	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
 	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
-		iint->flags &= ~IMA_DONE_MASK;
-		iint->measured_pcrs = 0;
+		ima_ns_cache_clear(iint);
 	}
+	nsc = ima_ns_cache_get(iint, current_user_ns());
 
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
 	 */
-	iint->flags |= action;
+	nsc->flags |= action;
 	action &= IMA_DO_MASK;
-	action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
+	action &= ~((nsc->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
 
 	/* If target pcr is already measured, unset IMA_MEASURE action */
-	if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
+	if ((action & IMA_MEASURE) && (nsc->measured_pcrs & (0x1 << pcr)))
 		action ^= IMA_MEASURE;
 
 	/* HASH sets the digital signature and update flags, nothing else */
@@ -297,7 +298,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		if ((xattr_value && xattr_len > 2) &&
 		    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
 			set_bit(IMA_DIGSIG, &iint->atomic_flags);
-		iint->flags |= IMA_HASHED;
+		nsc->flags |= IMA_HASHED;
 		action ^= IMA_HASH;
 		set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
 	}
@@ -342,7 +343,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
 	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
+		ima_store_measurement(iint, nsc, file, pathname,
 				      xattr_value, xattr_len, modsig, pcr,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
@@ -1047,6 +1048,8 @@ static int __init init_ima(void)
 	if (error)
 		return error;
 
+	ima_init_ns();
+
 	error = register_blocking_lsm_notifier(&ima_lsm_policy_notifier);
 	if (error)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index a0358806149b..e5c4e1348e3d 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -13,6 +13,13 @@
 static struct kmem_cache *ima_ns_info_cache __read_mostly;
 static DEFINE_MUTEX(ns_info_list_lock);
 static LIST_HEAD(ima_ns_info_list);
+static struct kmem_cache *ns_cache __read_mostly;
+bool ima_ns_in_template __read_mostly;
+
+void __init ima_init_ns(void)
+{
+	ns_cache = KMEM_CACHE(ima_ns_cache, SLAB_PANIC);
+}
 
 int ima_ns_info_set_label(struct user_namespace *ns, const char *label)
 {
@@ -66,8 +73,97 @@ void ima_init_user_ns(struct user_namespace *ns)
 	mutex_lock(&ns_info_list_lock);
 	list_add_tail(&insi->entry, &ima_ns_info_list);
 	mutex_unlock(&ns_info_list_lock);
+	INIT_LIST_HEAD(&ns->ima_inode_list);
 }
 
 void ima_free_user_ns(struct user_namespace *ns)
 {
+	struct ima_ns_cache *entry;
+
+	/* no refs to ns left, so no need to lock */
+	while (!list_empty(&ns->ima_inode_list)) {
+		entry = list_entry(ns->ima_inode_list.next, struct ima_ns_cache,
+				   ns_list);
+
+		/* iint cache entry is still active to lock to delete */
+		write_lock(&entry->iint->ns_list_lock);
+		list_del(&entry->iint_list);
+		write_unlock(&entry->iint->ns_list_lock);
+
+		list_del(&entry->ns_list);
+		kmem_cache_free(ns_cache, entry);
+	}
+}
+
+struct ima_ns_cache *ima_ns_cache_get(struct integrity_iint_cache *iint,
+				      struct user_namespace *ns)
+{
+	struct ima_ns_cache *entry = NULL;
+
+	if (!ima_ns_in_template)
+		/*
+		 * if we're not logging the namespace, don't separate the
+		 * iint cache per namespace.  This preserves original
+		 * behaviour for the non-ns case.
+		 */
+		ns = &init_user_ns;
+
+	read_lock(&iint->ns_list_lock);
+	list_for_each_entry(entry, &iint->ns_list, ns_list)
+		if (entry->ns == ns)
+			break;
+	read_unlock(&iint->ns_list_lock);
+
+	if (entry && entry->ns == ns)
+		return entry;
+
+	entry = kmem_cache_zalloc(ns_cache, GFP_NOFS);
+	if (!entry)
+		return NULL;
+
+	/* no refs taken: entry is freed on either ns delete or iint delete */
+	entry->ns = ns;
+	entry->iint = iint;
+
+	write_lock(&iint->ns_list_lock);
+	list_add_tail(&entry->iint_list, &iint->ns_list);
+	write_unlock(&iint->ns_list_lock);
+
+	write_lock(&ns->ima_inode_list_lock);
+	list_add_tail(&entry->ns_list, &ns->ima_inode_list);
+	write_unlock(&ns->ima_inode_list_lock);
+
+	return entry;
+}
+
+/* clear the flags and measured PCR for every entry in the iint  */
+void ima_ns_cache_clear(struct integrity_iint_cache *iint)
+{
+	struct ima_ns_cache *entry;
+
+	read_lock(&iint->ns_list_lock);
+	list_for_each_entry(entry, &iint->ns_list, ns_list) {
+		entry->flags = 0;
+		entry->measured_pcrs = 0;
+	}
+	read_unlock(&iint->ns_list_lock);
+}
+
+void ima_ns_iint_list_free(struct integrity_iint_cache *iint)
+{
+	struct ima_ns_cache *entry;
+
+	/* iint locking unnecessary; no-one should have access to the list */
+	while (!list_empty(&iint->ns_list)) {
+		entry = list_entry(iint->ns_list.next, struct ima_ns_cache,
+				   iint_list);
+
+		/* namespace is still active so lock to delete */
+		write_lock(&entry->ns->ima_inode_list_lock);
+		list_del(&entry->ns_list);
+		write_unlock(&entry->ns->ima_inode_list_lock);
+
+		list_del(&entry->iint_list);
+		kmem_cache_free(ns_cache, entry);
+	}
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 320ca80aacab..9434a1064da6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -50,7 +50,7 @@
 #define DONT_HASH	0x0200
 
 #define INVALID_PCR(a) (((a) < 0) || \
-	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))
+	(a) >= (sizeof_field(struct ima_ns_cache, measured_pcrs) * 8))
 
 int ima_policy_flag;
 static int temp_ima_appraise;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 0a3125727534..559b0fb239d7 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -695,6 +695,9 @@ int ima_ns_label_init(struct ima_event_data *event_data,
 {
 	const char *label = ima_ns_info_get_label(current_user_ns());
 
+	if (unlikely(!ima_ns_in_template))
+		ima_ns_in_template = true;
+
 	return ima_write_template_field_data(label, strlen(label),
 					     DATA_FMT_STRING,
 					     field_data);
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..8755635da3ff 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -129,7 +129,6 @@ struct integrity_iint_cache {
 	struct inode *inode;	/* back pointer to inode in question */
 	u64 version;		/* track inode changes */
 	unsigned long flags;
-	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
@@ -138,6 +137,8 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+	struct list_head ns_list; /* list of namespaces inode seen in */
+	rwlock_t ns_list_lock;
 };
 
 /* rbtree tree calls to lookup, insert, delete
@@ -225,6 +226,14 @@ static inline void ima_load_x509(void)
 }
 #endif
 
+#ifdef CONFIG_IMA
+void ima_ns_iint_list_free(struct integrity_iint_cache *iint);
+#else
+void ima_ns_iint_list_free(struct integrity_iint_cache *iint)
+{
+}
+#endif
+
 #ifdef CONFIG_EVM_LOAD_X509
 void __init evm_load_x509(void);
 #else
-- 
2.33.0

