Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D8466FEB
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378334AbhLCCfk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:35:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1378141AbhLCCfS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B32GuXH007115;
        Fri, 3 Dec 2021 02:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YDvotpnt68rRm/feKofNRUZjCVuXVfE9Q5eUBBJXwGA=;
 b=SPFhNuzGBJF+cpsup8qQp7uehrT07PxqPSVa00HCuZh/nzM4hnGp84DLBNMIIlHxN0oo
 OwgE9G/aCgCLmYdHTzokgZnTJhvjp8CWaCPRc5wxQMIaqjej+vVRgE8d0xD14Wwx27hM
 GR1zM+/EypB5JAs2IHhJe3Sxs5cohjHiSSTOXsROHqTa1ZY8ei+TD4fsdEcIE0XGh+Eh
 nx1Z1wAJNUJJtq/xp8BoRDPIR8yXso7F4w8BhQ9EHl9YAXkTKYA4LI9hIWX+NsX46TqW
 qzqsmKKCjkZGDuhtxu1ZDRDd9iJpVcYU7d3X7gN+yJOVBmG9B5oRMLryk8m7vv2aVZ5n sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqaaj86ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:45 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32V3s0028969;
        Fri, 3 Dec 2021 02:31:44 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cqaaj86e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:44 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32SLBT014558;
        Fri, 3 Dec 2021 02:31:43 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 3cn3k3k5by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:43 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32Vgbq31130214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:42 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1F986E08C;
        Fri,  3 Dec 2021 02:31:41 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFD0C6E085;
        Fri,  3 Dec 2021 02:31:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:40 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC v2 13/19] securityfs: Extend securityfs with namespacing support
Date:   Thu,  2 Dec 2021 21:31:12 -0500
Message-Id: <20211203023118.1447229-14-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ywihtBwY22VVeTFTVpOXGP6QjjX8GRef
X-Proofpoint-ORIG-GUID: 5m5nWm2oxzEsq6P-gZSDe7WmeaWvASff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_16,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend 'securityfs' for support of IMA namespacing so that each
IMA (user) namespace can have its own front-end for showing the currently
active policy, the measurement list, number of violations and so on. This
filesystem adds a new API call securityfs_ns_create_mount() for creating
a new instance of the filesystem.

The API calls the namespaced SecurityFS have the prefix securityfs_ns_ and
take additional parameters struct vfsmount ** and int *mount_count that
allow for access to different instances of this filesystem.

The filesystem can be mounted to the usual securityfs mount point like
this:

mount -t securityfs /sys/kernel/security /sys/kernel/security

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/security.h |  15 ++++
 security/inode.c         | 145 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7e0ba63b5dde..13fdb09d86b2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1929,6 +1929,21 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const struct inode_operations *iops);
 extern void securityfs_remove(struct dentry *dentry);
 
+extern struct dentry *securityfs_ns_create_file(const char *name, umode_t mode,
+						struct dentry *parent, void *data,
+						const struct file_operations *fops,
+						struct vfsmount **mount, int *mount_count);
+extern struct dentry *securityfs_ns_create_dir(const char *name, struct dentry *parent,
+					       struct vfsmount **mount, int *mount_count);
+struct dentry *securityfs_ns_create_symlink(const char *name,
+					    struct dentry *parent,
+					    const char *target,
+					    const struct inode_operations *iops,
+					    struct vfsmount **mount, int *mount_count);
+extern void securityfs_ns_remove(struct dentry *dentry,
+				 struct vfsmount **mount, int *mount_count);
+struct vfsmount *securityfs_ns_create_mount(struct user_namespace *user_ns);
+
 #else /* CONFIG_SECURITYFS */
 
 static inline struct dentry *securityfs_create_dir(const char *name,
diff --git a/security/inode.c b/security/inode.c
index 9299f134877f..2738a7b31469 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,6 +21,7 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/user_namespace.h>
 
 static struct vfsmount *securityfs_mount;
 static int securityfs_mount_count;
@@ -53,7 +54,7 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int securityfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, securityfs_fill_super);
+	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
 }
 
 static const struct fs_context_operations securityfs_context_ops = {
@@ -71,8 +72,34 @@ static struct file_system_type fs_type = {
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_USERNS_MOUNT,
 };
 
+/**
+ * securityfs_ns_create_mount - create instance of securityfs in given user namespace
+ *
+ * @user_ns: the user namespace to create the vfsmount in
+ *
+ * This function returns a pointer to the vfsmount or an error code. The vfsmount
+ * has to be used when creating or removing filesystem dentries.
+ */
+struct vfsmount *securityfs_ns_create_mount(struct user_namespace *user_ns)
+{
+	struct fs_context *fc;
+	struct vfsmount *mnt;
+
+	fc = fs_context_for_mount(&fs_type, SB_KERNMOUNT);
+	if (IS_ERR(fc))
+		return ERR_CAST(fc);
+
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(user_ns);
+
+	mnt = fc_mount(fc);
+	put_fs_context(fc);
+	return mnt;
+}
+
 /**
  * securityfs_create_dentry - create a dentry in the securityfs filesystem
  *
@@ -213,6 +240,40 @@ struct dentry *securityfs_create_file(const char *name, umode_t mode,
 }
 EXPORT_SYMBOL_GPL(securityfs_create_file);
 
+/**
+ * securityfs_ns_create_file - create a file in the securityfs_ns filesystem
+ *
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the securityfs_ns filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fops: a pointer to a struct file_operations that should be used for
+ *        this file.
+ * @mount: Pointer to a pointer of a an existing vfsmount
+ * @mount_count: The mount_count that goes along with the @mount
+ *
+ * This function creates a file in securityfs_ns with the given @name.
+ *
+ * This function returns a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the securityfs_ns_remove() function when the file
+ * is to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here).  If an error occurs, the function will return
+ * the error value (via ERR_PTR).
+ */
+struct dentry *securityfs_ns_create_file(const char *name, umode_t mode,
+					 struct dentry *parent, void *data,
+					 const struct file_operations *fops,
+					 struct vfsmount **mount, int *mount_count)
+{
+	return securityfs_create_dentry(name, mode, parent, data, fops, NULL,
+					mount, mount_count);
+}
+EXPORT_SYMBOL_GPL(securityfs_ns_create_file);
+
 /**
  * securityfs_create_dir - create a directory in the securityfs filesystem
  *
@@ -239,6 +300,33 @@ struct dentry *securityfs_create_dir(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(securityfs_create_dir);
 
+/**
+ * securityfs_ns_create_dir - create a directory in the securityfs_ns filesystem
+ *
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          directory will be created in the root of the securityfs_ns filesystem.
+ * @mount: Pointer to a pointer of a an existing vfsmount
+ * @mount_count: The mount_count that goes along with the @mount
+ *
+ * This function creates a directory in securityfs_ns with the given @name.
+ *
+ * This function returns a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the securityfs_ns_remove() function when the file
+ * is to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here).  If an error occurs, the function will return
+ * the error value (via ERR_PTR).
+ */
+struct dentry *securityfs_ns_create_dir(const char *name, struct dentry *parent,
+					struct vfsmount **mount, int *mount_count)
+{
+	return securityfs_ns_create_file(name, S_IFDIR | 0755, parent, NULL, NULL,
+					 mount, mount_count);
+}
+EXPORT_SYMBOL_GPL(securityfs_ns_create_dir);
+
 static struct dentry *_securityfs_create_symlink(const char *name,
 						 struct dentry *parent,
 						 const char *target,
@@ -260,6 +348,7 @@ static struct dentry *_securityfs_create_symlink(const char *name,
 
 	return dent;
 }
+
 /**
  * securityfs_create_symlink - create a symlink in the securityfs filesystem
  *
@@ -296,6 +385,39 @@ struct dentry *securityfs_create_symlink(const char *name,
 }
 EXPORT_SYMBOL_GPL(securityfs_create_symlink);
 
+/**
+ * securityfs_ns_create_symlink - create a symlink in the securityfs_ns filesystem
+ *
+ * @name: a pointer to a string containing the name of the symlink to
+ *        create.
+ * @parent: a pointer to the parent dentry for the symlink.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          directory will be created in the root of the securityfs_ns filesystem.
+ * @target: a pointer to a string containing the name of the symlink's target.
+ *          If this parameter is %NULL, then the @iops parameter needs to be
+ *          setup to handle .readlink and .get_link inode_operations.
+ * @mount: Pointer to a pointer of a an existing vfsmount
+ * @mount_count: The mount_count that goes along with the @mount
+ *
+ * This function creates a symlink in securityfs_ns with the given @name.
+ *
+ * This function returns a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the securityfs_ns_remove() function when the file
+ * is to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here).  If an error occurs, the function will return
+ * the error value (via ERR_PTR).
+ */
+struct dentry *securityfs_ns_create_symlink(const char *name,
+					    struct dentry *parent,
+					    const char *target,
+					    const struct inode_operations *iops,
+					    struct vfsmount **mount, int *mount_count)
+{
+	return _securityfs_create_symlink(name, parent, target, iops,
+					  mount, mount_count);
+}
+EXPORT_SYMBOL_GPL(securityfs_ns_create_symlink);
+
 static void _securityfs_remove(struct dentry *dentry,
 			       struct vfsmount **mount, int *mount_count)
 {
@@ -337,6 +459,27 @@ void securityfs_remove(struct dentry *dentry)
 
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
+/**
+ * securityfs_ns_remove - removes a file or directory from the securityfs_ns filesystem
+ *
+ * @dentry: a pointer to a the dentry of the file or directory to be removed.
+ * @mount: Pointer to a pointer of a an existing vfsmount
+ * @mount_count: The mount_count that goes along with the @mount
+ *
+ * This function removes a file or directory in securityfs_ns that was previously
+ * created with a call to another securityfs_ns function (like
+ * securityfs_ns_create_file() or variants thereof.)
+ *
+ * This function is required to be called in order for the file to be
+ * removed. No automatic cleanup of files will happen when a module is
+ * removed; you are responsible here.
+ */
+void securityfs_ns_remove(struct dentry *dentry, struct vfsmount **mount, int *mount_count)
+{
+	_securityfs_remove(dentry, mount, mount_count);
+}
+EXPORT_SYMBOL_GPL(securityfs_ns_remove);
+
 #ifdef CONFIG_SECURITY
 static struct dentry *lsm_dentry;
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
-- 
2.31.1

