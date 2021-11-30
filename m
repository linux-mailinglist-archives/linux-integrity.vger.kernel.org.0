Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7529463AFF
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbhK3QKi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:10:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232416AbhK3QKh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:10:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFqa0r016474;
        Tue, 30 Nov 2021 16:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rO4xW9VBkBHxY3zLtka6KyWZdlXzfeiQ0hg5qgkdeV8=;
 b=Lgupuxv8ktUWLSuQTxcQCe9+VYzHj5QyT8eRyepbqvSdzzZvcIdmbVgz1u/ELz0e7MPr
 d2jFjuFVa5NnpyiRWvMVbhOrq/PDP41nXrwZ1fO45aCVduZNGYWmJ9gUv15gzQI67xCb
 hZN/b5gyHW/hybDimOay8wV9jx+YqbVhqdZz7sLJQKO5bbsj/tS3mU8mv40dyHaQKtuL
 4WtwLbIY2cEA8rES2vAjlzz2tva14mIlksN4FeluCoN2xKdxa0aBEnRrJvyCVLlcg+Yv
 a7AseQKkQYLyApDBM4iFUwBQOyJBcBrvrRDSlnJ9tEJIrxTtpXZudGu3Zb9YyS9WWQrs 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpyygb84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:16 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFtpN4025005;
        Tue, 30 Nov 2021 16:07:16 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpyygb7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG2j2D009847;
        Tue, 30 Nov 2021 16:07:14 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcab7tka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7EFN18285020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0348B209F;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1EF4B20AC;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
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
Subject: [RFC 20/20] ima: Setup securityfs_ns for IMA namespace
Date:   Tue, 30 Nov 2021 11:06:54 -0500
Message-Id: <20211130160654.1418231-21-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Oo7cAhv30aGK1GQOktjuac2vf1c93onh
X-Proofpoint-GUID: _NyztsU0zZtWt3tfAKqv2cfNJkt02PwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Setup securityfs_ns with symlinks, directories, and files for IMA
namespacing support. The same directory structure that IMA uses on the
host is also created for the namespacing case.

Increment the user namespace's refcount_teardown value by '1' once
securityfs_ns has been successfully setup since the initialization of the
filesystem causes an additional reference to the user namespace to be
taken. The early teardown function will delete the file system and release
the additional reference.

The securityfs_ns file and directory ownerships cannot be set when the
filesystem is setup since at this point the user namespace has not been
configured yet by the user and therefore the ownership mappings are not
available, yet. Therefore, adjust the file and directory ownerships when
an inode's function for determining the permissions of a file or directory
is accessed.

This filesystem can now be mounted as follows:

mount -t securityfs_ns /sys/kernel/security/ /sys/kernel/security/

The following directories, symlinks, and files are then available.

$ ls -l sys/kernel/security/
total 0
lr--r--r--. 1 nobody nobody 0 Nov 27 06:44 ima -> integrity/ima
drwxr-xr-x. 3 nobody nobody 0 Nov 27 06:44 integrity

$ ls -l sys/kernel/security/ima/
total 0
-r--r-----. 1 root root 0 Nov 27 06:44 ascii_runtime_measurements
-r--r-----. 1 root root 0 Nov 27 06:44 binary_runtime_measurements
-rw-------. 1 root root 0 Nov 27 06:44 policy
-r--r-----. 1 root root 0 Nov 27 06:44 runtime_measurements_count
-r--r-----. 1 root root 0 Nov 27 06:44 violations

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      |  17 +++
 security/integrity/ima/ima.h             |   2 +
 security/integrity/ima/ima_fs.c          | 178 ++++++++++++++++++++++-
 security/integrity/ima/ima_init_ima_ns.c |   6 +-
 security/integrity/ima/ima_ns.c          |   4 +-
 5 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index fe08919df326..a2c5e516f706 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -221,6 +221,18 @@ struct ima_h_table {
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 
+enum {
+	IMAFS_DENTRY_INTEGRITY_DIR = 0,
+	IMAFS_DENTRY_DIR,
+	IMAFS_DENTRY_SYMLINK,
+	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
+	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
+	IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT,
+	IMAFS_DENTRY_VIOLATIONS,
+	IMAFS_DENTRY_IMA_POLICY,
+	IMAFS_DENTRY_LAST
+};
+
 struct ima_namespace {
 	struct kref kref;
 	struct user_namespace *user_ns;
@@ -267,6 +279,11 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *dentry[IMAFS_DENTRY_LAST];
+	struct vfsmount *mount;
+	int mount_count;
+	bool file_ownership_fixes_done;
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index bb9763cd5fb1..9bcd71bb716c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -139,6 +139,8 @@ struct ns_status {
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
+int ima_fs_ns_init(struct ima_namespace *ns);
+void ima_fs_ns_free(struct ima_namespace *ns);
 int ima_add_template_entry(struct ima_namespace *ns,
 			   struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 6766bb8262f2..9a14be520268 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -22,6 +22,7 @@
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
 #include <linux/ima.h>
+#include <linux/namei.h>
 
 #include "ima.h"
 
@@ -436,8 +437,13 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	if (ns == &init_ima_ns) {
+		securityfs_remove(ima_policy);
+		ima_policy = NULL;
+	} else {
+		securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_POLICY]);
+		ns->dentry[IMAFS_DENTRY_POLICY] = NULL;
+	}
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -509,3 +515,171 @@ int __init ima_fs_init(void)
 	securityfs_remove(ima_policy);
 	return -1;
 }
+
+/*
+ * Fix the ownership (uid/gid) of the dentry's that couldn't be set at the
+ * time of their creation because the user namespace wasn't configured, yet.
+ */
+static void ima_fs_ns_fixup_uid_gid(struct ima_namespace *ns)
+{
+	struct inode *inode;
+	size_t i;
+
+	if (ns->file_ownership_fixes_done ||
+	    ns->user_ns->uid_map.nr_extents == 0)
+		return;
+
+	ns->file_ownership_fixes_done = true;
+	for (i = 0; i < IMAFS_DENTRY_LAST; i++) {
+		if (!ns->dentry[i])
+			continue;
+		inode = ns->dentry[i]->d_inode;
+		inode->i_uid = make_kuid(ns->user_ns, 0);
+		inode->i_gid = make_kgid(ns->user_ns, 0);
+	}
+}
+
+/* Fix the permissions when a file is opened */
+int ima_fs_ns_permission(struct user_namespace *mnt_userns, struct inode *inode,
+			 int mask)
+{
+	ima_fs_ns_fixup_uid_gid(get_current_ns());
+	return generic_permission(mnt_userns, inode, mask);
+}
+
+const struct inode_operations ima_fs_ns_inode_operations = {
+	.lookup		= simple_lookup,
+	.permission	= ima_fs_ns_permission,
+};
+
+int ima_fs_ns_init(struct ima_namespace *ns)
+{
+	struct dentry *parent;
+
+	ns->mount = securityfs_ns_create_mount(ns->user_ns);
+	if (IS_ERR(ns->mount)) {
+		ns->mount = NULL;
+		return -1;
+	}
+	ns->mount_count += 1;
+
+	ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
+	    securityfs_ns_create_dir("integrity", NULL,
+				     &ima_fs_ns_inode_operations,
+				     &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])) {
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_DIR] =
+	    securityfs_ns_create_dir("ima", ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR],
+				     &ima_fs_ns_inode_operations,
+				     &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR])) {
+		ns->dentry[IMAFS_DENTRY_DIR] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_SYMLINK] =
+	    securityfs_ns_create_symlink("ima", NULL, "integrity/ima", NULL,
+				     &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK])) {
+		ns->dentry[IMAFS_DENTRY_SYMLINK] = NULL;
+		goto out;
+	}
+
+	parent = ns->dentry[IMAFS_DENTRY_DIR];
+	ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] =
+	    securityfs_ns_create_file("binary_runtime_measurements",
+				   S_IRUSR | S_IRGRP, parent, NULL,
+				   &ima_measurements_ops,
+				   &ima_fs_ns_inode_operations,
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS])) {
+		ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] =
+	    securityfs_ns_create_file("ascii_runtime_measurements",
+				   S_IRUSR | S_IRGRP, parent, NULL,
+				   &ima_ascii_measurements_ops,
+				   &ima_fs_ns_inode_operations,
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS])) {
+		ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] =
+	    securityfs_ns_create_file("runtime_measurements_count",
+				   S_IRUSR | S_IRGRP, parent, NULL,
+				   &ima_measurements_count_ops,
+				   &ima_fs_ns_inode_operations,
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT])) {
+		ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_VIOLATIONS] =
+	    securityfs_ns_create_file("violations", S_IRUSR | S_IRGRP,
+				   parent, NULL, &ima_htable_violations_ops,
+				   &ima_fs_ns_inode_operations,
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_VIOLATIONS])) {
+		ns->dentry[IMAFS_DENTRY_VIOLATIONS] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_IMA_POLICY] =
+	    securityfs_ns_create_file("policy", POLICY_FILE_FLAGS,
+				   parent, NULL,
+				   &ima_measure_policy_ops,
+				   &ima_fs_ns_inode_operations,
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_IMA_POLICY])) {
+		ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
+		goto out;
+	}
+
+	/* Adjust the trigger for user namespace's early teardown of dependent
+	 * namespaces. Due to the filesystem there's an additional reference
+	 * to the user namespace.
+	 */
+	ns->user_ns->refcount_teardown += 1;
+
+	return 0;
+
+out:
+	ima_fs_ns_free(ns);
+
+	return -1;
+}
+
+void ima_fs_ns_free(struct ima_namespace *ns)
+{
+	size_t i;
+
+	for (i = 0; i < IMAFS_DENTRY_LAST; i++) {
+		switch (i) {
+		case IMAFS_DENTRY_DIR:
+		case IMAFS_DENTRY_INTEGRITY_DIR:
+			/* files first */
+			continue;
+		}
+		securityfs_ns_remove(ns->dentry[i], &ns->mount, &ns->mount_count);
+		ns->dentry[i] = NULL;
+	}
+	securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_DIR], &ns->mount, &ns->mount_count);
+	ns->dentry[IMAFS_DENTRY_DIR] = NULL;
+	securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR], &ns->mount, &ns->mount_count);
+	ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = NULL;
+
+	if (ns->mount) {
+		mntput(ns->mount);
+		ns->mount_count -= 1;
+	}
+	ns->mount = NULL;
+}
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 22ff74e85a5f..86a89502c0c5 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -20,6 +20,8 @@
 
 int ima_init_namespace(struct ima_namespace *ns)
 {
+	int rc = 0;
+
 	ns->ns_status_tree = RB_ROOT;
 	rwlock_init(&ns->ns_status_lock);
 	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
@@ -52,8 +54,10 @@ int ima_init_namespace(struct ima_namespace *ns)
 	mutex_init(&ns->ima_write_mutex);
 	ns->valid_policy = 1;
 	ns->ima_fs_flags = 0;
+	if (ns != &init_ima_ns)
+		rc = ima_fs_ns_init(ns);
 
-	return 0;
+	return rc;
 }
 
 int __init ima_ns_init(void)
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index e7ad52b79f99..c687e840441a 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -67,7 +67,9 @@ struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
 
 void ima_ns_userns_early_teardown(struct ima_namespace *ns)
 {
-}
+	pr_debug("%s: ns=0x%lx\n", __func__, (unsigned long)ns);
+	ima_fs_ns_free(ns);
+};
 EXPORT_SYMBOL(ima_ns_userns_early_teardown);
 
 static void destroy_ima_ns(struct ima_namespace *ns)
-- 
2.31.1

