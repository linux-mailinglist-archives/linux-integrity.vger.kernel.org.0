Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356F5468FDA
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 05:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhLFEcE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Dec 2021 23:32:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54014 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237190AbhLFEcD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Dec 2021 23:32:03 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B63QRkx011823;
        Mon, 6 Dec 2021 04:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=kVF4Nym4es2SH7epPF4khO9QOfp69Jtja20AQxIlHqA=;
 b=rILqeMuovIZ5AlmyRcmgohWPfw/hsgInWQLYikZpcfl0ktf5rLSgOW4Iou1cdbb4VcbJ
 L3a3/ytvZzarpQj4klE+mHXPzk9t7nGNpWLKWvGG9+URKOkjciCSv56KX/DBSmRTDdqo
 XbZr07gWZVaj6kI0PjiNIRae+nWonA4ox7Kzn10tWskwx2fk4wo8egOOLrEV/IUKOwjr
 wdvFckv+TuCk7Y3geSJhvnKdCIj5aDyz09yC3mr/EAl+0tql4tXXABWQlCXLvvfeBiJi
 f3jIKT+cJA+Z+OXsYZSdfsPqQc5E1fpJ40nmX/Cl5ag7OdnV+vAfZzCVthlC/HpqSeMv aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cs7ur2yq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 04:28:01 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B64LC3s022510;
        Mon, 6 Dec 2021 04:28:00 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cs7ur2yq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 04:28:00 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B64PfRp009995;
        Mon, 6 Dec 2021 04:27:59 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyy9htfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 04:27:59 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B64Rwvs46137680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 04:27:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2609C78066;
        Mon,  6 Dec 2021 04:27:58 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96C1E78060;
        Mon,  6 Dec 2021 04:27:55 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 04:27:55 +0000 (GMT)
Message-ID: <084e6522e1e778408cf6b3581d75f7349d336006.camel@linux.ibm.com>
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Sun, 05 Dec 2021 23:27:54 -0500
In-Reply-To: <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
         <20211203023118.1447229-20-stefanb@linux.ibm.com>
         <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
         <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
         <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
         <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C2xhVhmEe0x51AE3BpLUkdkjd-0cF3At
X-Proofpoint-ORIG-GUID: u5LNue-tg2midAl1DAACqY-TboE1n203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060023
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-12-03 at 14:11 -0500, Stefan Berger wrote:
> On 12/3/21 13:50, James Bottomley wrote:
> > On Fri, 2021-12-03 at 13:06 -0500, Stefan Berger wrote:
[...]
> > > I suppose any late filesystem init callchain would have to be
> > > connected to the user_namespace somehow?
> >  
> > I don't think so; I think just moving some securityfs entries into
> > the user_namespace and managing the notifier chain from within
> > securityfs will do for now.  [although I'd have to spec this out in
> > code before I knew for sure].
> 
> It doesn't have to be right in the user_namespace. The IMA namespace
> is  connected to the user namespace and holds the dentries now...
> 
> Please spec it out...

OK, this is what I have.  fill_super turned out to be a locking
nightmare, so I triggered it from free context instead (which doesn't
have the once per keyed superblock property, so I added a flag in the
user namespace).  I've got it to the point where the event is triggered
on mount and unmount, so all the entries for the namespace are added
when the filesystem is mounted and remove when it's unmounted.  This
style of addition no longer needs the simple_pin_fs, because the
add/remove callbacks substitute (plus, if we pinned, the free_super
wouldn't trigger on unmount).  The default behaviour still does pinning
and unpinning, but that can be keyed off the current user_namespace.

This is all on top of your current series ... some of the functions
should probably be renamed, but I kept them to show how the code was
migrating in this sketch.

James

---

From 59c45daa8698c66c3bcebfb194123977d548a9a6 Mon Sep 17 00:00:00 2001
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 4 Dec 2021 16:38:37 +0000
Subject: [PATCH] rework securityfs

---
 include/linux/security.h                 |  28 +--
 include/linux/user_namespace.h           |  21 +-
 security/inode.c                         | 292 ++++++++---------------
 security/integrity/ima/ima.h             |   3 +-
 security/integrity/ima/ima_fs.c          | 174 +++++---------
 security/integrity/ima/ima_init_ima_ns.c |   2 -
 security/integrity/ima/ima_ns.c          |   7 -
 7 files changed, 166 insertions(+), 361 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 83b3af3c2959..2f37651da6e5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/notifier.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 
@@ -1919,6 +1920,13 @@ static inline void security_audit_rule_free(void *lsmrule)
 
 #ifdef CONFIG_SECURITYFS
 
+enum {
+	SECURITYFS_NS_ADD,
+	SECURITYFS_NS_REMOVE,
+};
+
+extern int securityfs_register_ns_notifier(struct notifier_block *nb);
+extern int securityfs_unregister_ns_notifier(struct notifier_block *nb);
 extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
 					     struct dentry *parent, void *data,
 					     const struct file_operations *fops);
@@ -1929,20 +1937,6 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const struct inode_operations *iops);
 extern void securityfs_remove(struct dentry *dentry);
 
-extern struct dentry *securityfs_ns_create_file(const char *name, umode_t mode,
-						struct dentry *parent, void *data,
-						const struct file_operations *fops,
-						struct vfsmount **mount, int *mount_count);
-extern struct dentry *securityfs_ns_create_dir(const char *name, struct dentry *parent,
-					       struct vfsmount **mount, int *mount_count);
-struct dentry *securityfs_ns_create_symlink(const char *name,
-					    struct dentry *parent,
-					    const char *target,
-					    const struct inode_operations *iops,
-					    struct vfsmount **mount, int *mount_count);
-extern void securityfs_ns_remove(struct dentry *dentry,
-				 struct vfsmount **mount, int *mount_count);
-struct vfsmount *securityfs_ns_create_mount(struct user_namespace *user_ns);
 
 #else /* CONFIG_SECURITYFS */
 
@@ -1962,9 +1956,9 @@ static inline struct dentry *securityfs_create_file(const char *name,
 }
 
 static inline struct dentry *securityfs_create_symlink(const char *name,
-					struct dentry *parent,
-					const char *target,
-					const struct inode_operations *iops)
+						       struct dentry *parent,
+						       const char *target,
+						       const struct inode_operations *iops)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 8f7870b37c73..6b8bd060d8c4 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -103,11 +103,10 @@ struct user_namespace {
 #ifdef CONFIG_IMA
 	struct ima_namespace	*ima_ns;
 #endif
-	/* The refcount at which to start tearing down dependent namespaces
-	 * (currently only IMA) that may hold additional references to the
-	 * user namespace.
-	 */
-	unsigned int            refcount_teardown;
+#ifdef CONFIG_SECURITYFS
+	struct vfsmount		*securityfs_mount;
+	bool			securityfs_notifier_sent;
+#endif
 } __randomize_layout;
 
 struct ucounts {
@@ -158,19 +157,11 @@ static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 extern int create_user_ns(struct cred *new);
 extern int unshare_userns(unsigned long unshare_flags, struct cred **new_cred);
 extern void __put_user_ns(struct user_namespace *ns);
-extern void ima_ns_userns_early_teardown(struct ima_namespace *ns);
 
 static inline void put_user_ns(struct user_namespace *ns)
 {
-	if (ns) {
-		if (refcount_dec_and_test(&ns->ns.count))
-			__put_user_ns(ns);
-		else if (refcount_read(&ns->ns.count) == ns->refcount_teardown) {
-#ifdef CONFIG_IMA_NS
-			ima_ns_userns_early_teardown(ns->ima_ns);
-#endif
-		}
-	}
+	if (ns && refcount_dec_and_test(&ns->ns.count))
+		__put_user_ns(ns);
 }
 
 struct seq_operations;
diff --git a/security/inode.c b/security/inode.c
index 6223f1d838f6..62ab4630dc31 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -18,15 +18,17 @@
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/namei.h>
+#include <linux/notifier.h>
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 #include <linux/user_namespace.h>
 #include <linux/ima.h>
 
-static struct vfsmount *securityfs_mount;
 static int securityfs_mount_count;
 
+static BLOCKING_NOTIFIER_HEAD(securityfs_ns_notifier);
+
 static void securityfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
@@ -39,6 +41,31 @@ static const struct super_operations securityfs_super_operations = {
 	.free_inode	= securityfs_free_inode,
 };
 
+static struct file_system_type fs_type;
+
+static void securityfs_free_context(struct fs_context *fc)
+{
+	struct user_namespace *ns = fc->user_ns;
+	if (ns == &init_user_ns ||
+	    ns->securityfs_notifier_sent)
+		return;
+
+	ns->securityfs_notifier_sent = true;
+
+	ns->securityfs_mount = vfs_kern_mount(&fs_type, SB_KERNMOUNT,
+					      fs_type.name, NULL);
+	if (IS_ERR(ns->securityfs_mount)) {
+		printk(KERN_ERR "kern mount on securityfs ERROR: %ld\n",
+		       PTR_ERR(ns->securityfs_mount));
+		ns->securityfs_mount = NULL;
+		return;
+	}
+
+	blocking_notifier_call_chain(&securityfs_ns_notifier,
+				     SECURITYFS_NS_ADD, fc->user_ns);
+	mntput(ns->securityfs_mount);
+}
+
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
@@ -60,52 +87,44 @@ static int securityfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations securityfs_context_ops = {
 	.get_tree	= securityfs_get_tree,
+	.free		= securityfs_free_context,
 };
 
 static int securityfs_init_fs_context(struct fs_context *fc)
 {
-	int rc;
-
-	if (fc->user_ns->ima_ns->late_fs_init) {
-		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
-		if (rc)
-			return rc;
-	}
 	fc->ops = &securityfs_context_ops;
 	return 0;
 }
 
+static void securityfs_kill_super(struct super_block *sb)
+{
+	struct user_namespace *ns = sb->s_fs_info;
+
+	if (ns != &init_user_ns)
+		blocking_notifier_call_chain(&securityfs_ns_notifier,
+					     SECURITYFS_NS_REMOVE,
+					     sb->s_fs_info);
+	ns->securityfs_notifier_sent = false;
+	ns->securityfs_mount = NULL;
+	kill_litter_super(sb);
+}
+
 static struct file_system_type fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	securityfs_kill_super,
 	.fs_flags =	FS_USERNS_MOUNT,
 };
 
-/**
- * securityfs_ns_create_mount - create instance of securityfs in given user namespace
- *
- * @user_ns: the user namespace to create the vfsmount in
- *
- * This function returns a pointer to the vfsmount or an error code. The vfsmount
- * has to be used when creating or removing filesystem dentries.
- */
-struct vfsmount *securityfs_ns_create_mount(struct user_namespace *user_ns)
+int securityfs_register_ns_notifier(struct notifier_block *nb)
 {
-	struct fs_context *fc;
-	struct vfsmount *mnt;
-
-	fc = fs_context_for_mount(&fs_type, SB_KERNMOUNT);
-	if (IS_ERR(fc))
-		return ERR_CAST(fc);
-
-	put_user_ns(fc->user_ns);
-	fc->user_ns = get_user_ns(user_ns);
+	return blocking_notifier_chain_register(&securityfs_ns_notifier, nb);
+}
 
-	mnt = fc_mount(fc);
-	put_fs_context(fc);
-	return mnt;
+int securityfs_unregister_ns_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&securityfs_ns_notifier, nb);
 }
 
 /**
@@ -147,24 +166,27 @@ struct vfsmount *securityfs_ns_create_mount(struct user_namespace *user_ns)
 static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const struct file_operations *fops,
-					const struct inode_operations *iops,
-					struct vfsmount **mount, int *mount_count)
+					const struct inode_operations *iops)
 {
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
+	struct user_namespace *ns = current_user_ns();
 
 	if (!(mode & S_IFMT))
 		mode = (mode & S_IALLUGO) | S_IFREG;
 
-	pr_debug("securityfs: creating file '%s'\n",name);
+	pr_debug("securityfs: creating file '%s', ns=%u\n",name, ns->ns.inum);
 
-	error = simple_pin_fs(&fs_type, mount, mount_count);
-	if (error)
-		return ERR_PTR(error);
+	if (ns == &init_user_ns) {
+		error = simple_pin_fs(&fs_type, &ns->securityfs_mount,
+				      &securityfs_mount_count);
+		if (error)
+			return ERR_PTR(error);
+	}
 
 	if (!parent)
-		parent = (*mount)->mnt_root;
+		parent = ns->securityfs_mount->mnt_root;
 
 	dir = d_inode(parent);
 
@@ -209,7 +231,9 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(mount, mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&ns->securityfs_mount,
+				  &securityfs_mount_count);
 	return dentry;
 }
 
@@ -242,46 +266,10 @@ struct dentry *securityfs_create_file(const char *name, umode_t mode,
 				      struct dentry *parent, void *data,
 				      const struct file_operations *fops)
 {
-	return securityfs_create_dentry(name, mode, parent, data, fops, NULL,
-					&securityfs_mount,
-					&securityfs_mount_count);
+	return securityfs_create_dentry(name, mode, parent, data, fops, NULL);
 }
 EXPORT_SYMBOL_GPL(securityfs_create_file);
 
-/**
- * securityfs_ns_create_file - create a file in the securityfs_ns filesystem
- *
- * @name: a pointer to a string containing the name of the file to create.
- * @mode: the permission that the file should have
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
- *          file will be created in the root of the securityfs_ns filesystem.
- * @data: a pointer to something that the caller will want to get to later
- *        on.  The inode.i_private pointer will point to this value on
- *        the open() call.
- * @fops: a pointer to a struct file_operations that should be used for
- *        this file.
- * @mount: Pointer to a pointer of a an existing vfsmount
- * @mount_count: The mount_count that goes along with the @mount
- *
- * This function creates a file in securityfs_ns with the given @name.
- *
- * This function returns a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the securityfs_ns_remove() function when the file
- * is to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here).  If an error occurs, the function will return
- * the error value (via ERR_PTR).
- */
-struct dentry *securityfs_ns_create_file(const char *name, umode_t mode,
-					 struct dentry *parent, void *data,
-					 const struct file_operations *fops,
-					 struct vfsmount **mount, int *mount_count)
-{
-	return securityfs_create_dentry(name, mode, parent, data, fops, NULL,
-					mount, mount_count);
-}
-EXPORT_SYMBOL_GPL(securityfs_ns_create_file);
-
 /**
  * securityfs_create_dir - create a directory in the securityfs filesystem
  *
@@ -308,55 +296,6 @@ struct dentry *securityfs_create_dir(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(securityfs_create_dir);
 
-/**
- * securityfs_ns_create_dir - create a directory in the securityfs_ns filesystem
- *
- * @name: a pointer to a string containing the name of the directory to
- *        create.
- * @parent: a pointer to the parent dentry for this file.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
- *          directory will be created in the root of the securityfs_ns filesystem.
- * @mount: Pointer to a pointer of a an existing vfsmount
- * @mount_count: The mount_count that goes along with the @mount
- *
- * This function creates a directory in securityfs_ns with the given @name.
- *
- * This function returns a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the securityfs_ns_remove() function when the file
- * is to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here).  If an error occurs, the function will return
- * the error value (via ERR_PTR).
- */
-struct dentry *securityfs_ns_create_dir(const char *name, struct dentry *parent,
-					struct vfsmount **mount, int *mount_count)
-{
-	return securityfs_ns_create_file(name, S_IFDIR | 0755, parent, NULL, NULL,
-					 mount, mount_count);
-}
-EXPORT_SYMBOL_GPL(securityfs_ns_create_dir);
-
-static struct dentry *_securityfs_create_symlink(const char *name,
-						 struct dentry *parent,
-						 const char *target,
-						 const struct inode_operations *iops,
-						 struct vfsmount **mount, int *mount_count)
-{
-	struct dentry *dent;
-	char *link = NULL;
-
-	if (target) {
-		link = kstrdup(target, GFP_KERNEL);
-		if (!link)
-			return ERR_PTR(-ENOMEM);
-	}
-	dent = securityfs_create_dentry(name, S_IFLNK | 0444, parent,
-					link, NULL, iops, mount, mount_count);
-	if (IS_ERR(dent))
-		kfree(link);
-
-	return dent;
-}
-
 /**
  * securityfs_create_symlink - create a symlink in the securityfs filesystem
  *
@@ -388,48 +327,40 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const char *target,
 					 const struct inode_operations *iops)
 {
-	return _securityfs_create_symlink(name, parent, target, iops,
-					  &securityfs_mount, &securityfs_mount_count);
+	struct dentry *dent;
+	char *link = NULL;
+
+	if (target) {
+		link = kstrdup(target, GFP_KERNEL);
+		if (!link)
+			return ERR_PTR(-ENOMEM);
+	}
+	dent = securityfs_create_dentry(name, S_IFLNK | 0444, parent,
+					link, NULL, iops);
+	if (IS_ERR(dent))
+		kfree(link);
+
+	return dent;
 }
-EXPORT_SYMBOL_GPL(securityfs_create_symlink);
+EXPORT_SYMBOL(securityfs_create_symlink);
 
 /**
- * securityfs_ns_create_symlink - create a symlink in the securityfs_ns filesystem
+ * securityfs_remove - removes a file or directory from the securityfs filesystem
  *
- * @name: a pointer to a string containing the name of the symlink to
- *        create.
- * @parent: a pointer to the parent dentry for the symlink.  This should be a
- *          directory dentry if set.  If this parameter is %NULL, then the
- *          directory will be created in the root of the securityfs_ns filesystem.
- * @target: a pointer to a string containing the name of the symlink's target.
- *          If this parameter is %NULL, then the @iops parameter needs to be
- *          setup to handle .readlink and .get_link inode_operations.
- * @mount: Pointer to a pointer of a an existing vfsmount
- * @mount_count: The mount_count that goes along with the @mount
+ * @dentry: a pointer to a the dentry of the file or directory to be removed.
  *
- * This function creates a symlink in securityfs_ns with the given @name.
+ * This function removes a file or directory in securityfs that was previously
+ * created with a call to another securityfs function (like
+ * securityfs_create_file() or variants thereof.)
  *
- * This function returns a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the securityfs_ns_remove() function when the file
- * is to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here).  If an error occurs, the function will return
- * the error value (via ERR_PTR).
+ * This function is required to be called in order for the file to be
+ * removed. No automatic cleanup of files will happen when a module is
+ * removed; you are responsible here.
  */
-struct dentry *securityfs_ns_create_symlink(const char *name,
-					    struct dentry *parent,
-					    const char *target,
-					    const struct inode_operations *iops,
-					    struct vfsmount **mount, int *mount_count)
-{
-	return _securityfs_create_symlink(name, parent, target, iops,
-					  mount, mount_count);
-}
-EXPORT_SYMBOL_GPL(securityfs_ns_create_symlink);
-
-static void _securityfs_remove(struct dentry *dentry,
-			       struct vfsmount **mount, int *mount_count)
+void securityfs_remove(struct dentry *dentry)
 {
 	struct inode *dir;
+	struct user_namespace *ns = current_user_ns();
 
 	if (!dentry || IS_ERR(dentry))
 		return;
@@ -444,49 +375,12 @@ static void _securityfs_remove(struct dentry *dentry,
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(mount, mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&ns->securityfs_mount,
+				  &securityfs_mount_count);
 }
+EXPORT_SYMBOL(securityfs_remove);
 
-/**
- * securityfs_remove - removes a file or directory from the securityfs filesystem
- *
- * @dentry: a pointer to a the dentry of the file or directory to be removed.
- *
- * This function removes a file or directory in securityfs that was previously
- * created with a call to another securityfs function (like
- * securityfs_create_file() or variants thereof.)
- *
- * This function is required to be called in order for the file to be
- * removed. No automatic cleanup of files will happen when a module is
- * removed; you are responsible here.
- */
-void securityfs_remove(struct dentry *dentry)
-{
-	_securityfs_remove(dentry, &securityfs_mount, &securityfs_mount_count);
-}
-
-EXPORT_SYMBOL_GPL(securityfs_remove);
-
-/**
- * securityfs_ns_remove - removes a file or directory from the securityfs_ns filesystem
- *
- * @dentry: a pointer to a the dentry of the file or directory to be removed.
- * @mount: Pointer to a pointer of a an existing vfsmount
- * @mount_count: The mount_count that goes along with the @mount
- *
- * This function removes a file or directory in securityfs_ns that was previously
- * created with a call to another securityfs_ns function (like
- * securityfs_ns_create_file() or variants thereof.)
- *
- * This function is required to be called in order for the file to be
- * removed. No automatic cleanup of files will happen when a module is
- * removed; you are responsible here.
- */
-void securityfs_ns_remove(struct dentry *dentry, struct vfsmount **mount, int *mount_count)
-{
-	_securityfs_remove(dentry, mount, mount_count);
-}
-EXPORT_SYMBOL_GPL(securityfs_ns_remove);
 
 #ifdef CONFIG_SECURITY
 static struct dentry *lsm_dentry;
@@ -511,6 +405,8 @@ static int __init securityfs_init(void)
 	if (retval)
 		return retval;
 
+	init_user_ns.securityfs_mount = NULL;
+
 	retval = register_filesystem(&fs_type);
 	if (retval) {
 		sysfs_remove_mount_point(kernel_kobj, "security");
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9bcd71bb716c..12b7df65a5ff 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -139,8 +139,7 @@ struct ns_status {
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
-int ima_fs_ns_init(struct ima_namespace *ns);
-void ima_fs_ns_free(struct ima_namespace *ns);
+void ima_fs_ns_free(void);
 int ima_add_template_entry(struct ima_namespace *ns,
 			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 65b2af7c14dd..26f26e8756a8 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -26,6 +26,8 @@
 
 #include "ima.h"
 
+int ima_fs_ns_init(void);
+
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -360,14 +362,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
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
@@ -437,14 +431,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	if (ns == &init_ima_ns) {
-		securityfs_remove(ima_policy);
-		ima_policy = NULL;
-	} else {
-		securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_POLICY],
-				     &ns->mount, &ns->mount_count);
-		ns->dentry[IMAFS_DENTRY_POLICY] = NULL;
-	}
+	securityfs_remove(ns->dentry[IMAFS_DENTRY_POLICY]);
+	ns->dentry[IMAFS_DENTRY_POLICY] = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -461,60 +449,32 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-int __init ima_fs_init(void)
+static int ima_fs_ns_late_init(struct user_namespace *user_ns);
+static void ima_fs_ns_free_dentries(struct ima_namespace *ns);
+static int ima_ns_notify(struct notifier_block *this, unsigned long msg,
+			    void *data)
 {
-	ima_dir = securityfs_create_dir("ima", integrity_dir);
-	if (IS_ERR(ima_dir))
-		return -1;
-
-	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
-						NULL);
-	if (IS_ERR(ima_symlink))
-		goto out;
-
-	binary_runtime_measurements =
-	    securityfs_create_file("binary_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_ops);
-	if (IS_ERR(binary_runtime_measurements))
-		goto out;
-
-	ascii_runtime_measurements =
-	    securityfs_create_file("ascii_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_ascii_measurements_ops);
-	if (IS_ERR(ascii_runtime_measurements))
-		goto out;
-
-	runtime_measurements_count =
-	    securityfs_create_file("runtime_measurements_count",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_count_ops);
-	if (IS_ERR(runtime_measurements_count))
-		goto out;
-
-	violations =
-	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
-				   ima_dir, NULL, &ima_htable_violations_ops);
-	if (IS_ERR(violations))
-		goto out;
+	struct user_namespace *ns = data;
+
+	switch (msg) {
+	case SECURITYFS_NS_ADD:
+		ima_fs_ns_late_init(ns);
+		break;
+	case SECURITYFS_NS_REMOVE:
+		ima_fs_ns_free_dentries(ns->ima_ns);
+		break;
+	}
+	return 0;
+}
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
-					    ima_dir, NULL,
-					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy))
-		goto out;
+static struct notifier_block ima_ns_notifier = {
+	.notifier_call = ima_ns_notify,
+};
 
-	return 0;
-out:
-	securityfs_remove(violations);
-	securityfs_remove(runtime_measurements_count);
-	securityfs_remove(ascii_runtime_measurements);
-	securityfs_remove(binary_runtime_measurements);
-	securityfs_remove(ima_symlink);
-	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
-	return -1;
+int __init ima_fs_init(void)
+{
+	ima_fs_ns_init();
+	return ima_fs_ns_late_init(&init_user_ns);
 }
 
 static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
@@ -528,12 +488,10 @@ static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 			/* files first */
 			continue;
 		}
-		securityfs_ns_remove(ns->dentry[i], &ns->mount, &ns->mount_count);
+		securityfs_remove(ns->dentry[i]);
 	}
-	securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_DIR],
-			     &ns->mount, &ns->mount_count);
-	securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR],
-			     &ns->mount, &ns->mount_count);
+	securityfs_remove(ns->dentry[IMAFS_DENTRY_DIR]);
+	securityfs_remove(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR]);
 
 	memset(ns->dentry, 0, sizeof(ns->dentry));
 
@@ -551,25 +509,27 @@ static int ima_fs_ns_late_init(struct user_namespace *user_ns)
 	if (ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])
 		return 0;
 
-	ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
-	    securityfs_ns_create_dir("integrity", NULL,
-				     &ns->mount, &ns->mount_count);
+	/* FIXME: update when evm and integrity are namespaced */
+	if (user_ns != &init_user_ns)
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
+			securityfs_create_dir("integrity", NULL);
+	else
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = integrity_dir;
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])) {
 		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = NULL;
 		goto out;
 	}
 
 	ns->dentry[IMAFS_DENTRY_DIR] =
-	    securityfs_ns_create_dir("ima", ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR],
-				     &ns->mount, &ns->mount_count);
+		securityfs_create_dir("ima",
+				      ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR]);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR])) {
 		ns->dentry[IMAFS_DENTRY_DIR] = NULL;
 		goto out;
 	}
 
 	ns->dentry[IMAFS_DENTRY_SYMLINK] =
-	    securityfs_ns_create_symlink("ima", NULL, "integrity/ima", NULL,
-				     &ns->mount, &ns->mount_count);
+		securityfs_create_symlink("ima", NULL, "integrity/ima", NULL);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK])) {
 		ns->dentry[IMAFS_DENTRY_SYMLINK] = NULL;
 		goto out;
@@ -577,88 +537,62 @@ static int ima_fs_ns_late_init(struct user_namespace *user_ns)
 
 	parent = ns->dentry[IMAFS_DENTRY_DIR];
 	ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] =
-	    securityfs_ns_create_file("binary_runtime_measurements",
+	    securityfs_create_file("binary_runtime_measurements",
 				   S_IRUSR | S_IRGRP, parent, NULL,
-				   &ima_measurements_ops,
-				   &ns->mount, &ns->mount_count);
+				   &ima_measurements_ops);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS])) {
 		ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] = NULL;
 		goto out;
 	}
 
 	ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] =
-	    securityfs_ns_create_file("ascii_runtime_measurements",
+	    securityfs_create_file("ascii_runtime_measurements",
 				   S_IRUSR | S_IRGRP, parent, NULL,
-				   &ima_ascii_measurements_ops,
-				   &ns->mount, &ns->mount_count);
+				   &ima_ascii_measurements_ops);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS])) {
 		ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] = NULL;
 		goto out;
 	}
 
 	ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] =
-	    securityfs_ns_create_file("runtime_measurements_count",
+	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, parent, NULL,
-				   &ima_measurements_count_ops,
-				   &ns->mount, &ns->mount_count);
+				   &ima_measurements_count_ops);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT])) {
 		ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] = NULL;
 		goto out;
 	}
 
 	ns->dentry[IMAFS_DENTRY_VIOLATIONS] =
-	    securityfs_ns_create_file("violations", S_IRUSR | S_IRGRP,
-				   parent, NULL, &ima_htable_violations_ops,
-				   &ns->mount, &ns->mount_count);
+	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
+				   parent, NULL, &ima_htable_violations_ops);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_VIOLATIONS])) {
 		ns->dentry[IMAFS_DENTRY_VIOLATIONS] = NULL;
 		goto out;
 	}
 
 	ns->dentry[IMAFS_DENTRY_IMA_POLICY] =
-	    securityfs_ns_create_file("policy", POLICY_FILE_FLAGS,
-				   parent, NULL, &ima_measure_policy_ops,
-				   &ns->mount, &ns->mount_count);
+	    securityfs_create_file("policy", POLICY_FILE_FLAGS,
+				   parent, NULL, &ima_measure_policy_ops);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_IMA_POLICY])) {
 		ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
 		goto out;
 	}
 
-
 	return 0;
 
 out:
-	ima_fs_ns_free_dentries(ns);
+	ima_fs_ns_free_dentries(user_ns->ima_ns);
 
 	return -1;
 }
 
-int ima_fs_ns_init(struct ima_namespace *ns)
+int ima_fs_ns_init(void)
 {
-	ns->mount = securityfs_ns_create_mount(ns->user_ns);
-	if (IS_ERR(ns->mount)) {
-		ns->mount = NULL;
-		return -1;
-	}
-	ns->mount_count = 1;
-
-	/* Adjust the trigger for user namespace's early teardown of dependent
-	 * namespaces. Due to the filesystem there's an additional reference
-	 * to the user namespace.
-	 */
-	ns->user_ns->refcount_teardown += 1;
-
-	ns->late_fs_init = ima_fs_ns_late_init;
-
-	return 0;
+	return securityfs_register_ns_notifier(&ima_ns_notifier);
 }
 
-void ima_fs_ns_free(struct ima_namespace *ns)
+void ima_fs_ns_free(void)
 {
-	ima_fs_ns_free_dentries(ns);
-	if (ns->mount) {
-		mntput(ns->mount);
-		ns->mount_count -= 1;
-	}
-	ns->mount = NULL;
+	securityfs_unregister_ns_notifier(&ima_ns_notifier);
 }
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 86a89502c0c5..38d075a2c38d 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -54,8 +54,6 @@ int ima_init_namespace(struct ima_namespace *ns)
 	mutex_init(&ns->ima_write_mutex);
 	ns->valid_policy = 1;
 	ns->ima_fs_flags = 0;
-	if (ns != &init_ima_ns)
-		rc = ima_fs_ns_init(ns);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 9d5917c97fcc..4c147e0c1801 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -65,13 +65,6 @@ struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
 	return create_ima_ns(user_ns);
 }
 
-void ima_ns_userns_early_teardown(struct ima_namespace *ns)
-{
-	pr_debug("%s: ns=0x%p\n", __func__, ns);
-	ima_fs_ns_free(ns);
-}
-EXPORT_SYMBOL(ima_ns_userns_early_teardown);
-
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	pr_debug("DESTROY ima_ns: 0x%p\n", ns);
-- 
2.33.0


