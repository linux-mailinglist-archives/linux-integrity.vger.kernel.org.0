Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C5466FFB
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378194AbhLCCgY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:36:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378262AbhLCCf0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:26 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31pag1004663;
        Fri, 3 Dec 2021 02:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xg5kDWc9Kp4SyVw7rqPYRdlVcO/7iFUpiqr1cpCcPXI=;
 b=oDfxErxyN66wBEAGOdpzlr8aaftENNDXSgXgQjANnyGgsX5Lhdt+RSboEhnQpa55lgjN
 ShLxqh+TcI2c5iKxLA/IAFZtDOEaGVAa5hwqLha8G3N0ccav9ChWsU4MQgVCysA/OHRi
 RIO5vLMTV262DnIe4282DaeOnBg04G+ax3yISSZ1+pc/GKZMdovgdGgJQ4lsJ4JIAF9Z
 iyjmzfo1jUUc7/HInx3beSDDhQRbMewVr7UTanIERHRFCyOGfUiz6aFM/CS4cl8TZK5+
 jL8vSYJVuFbRMgm+McFJ7xHxtZGiZhszdpAu2iwZCYWvt+tbpi9YrD650FNjHTFSZDyF +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9xrrk9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:53 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32Vq9k001453;
        Fri, 3 Dec 2021 02:31:52 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9xrrk9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:52 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32RU4D004579;
        Fri, 3 Dec 2021 02:31:51 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne3mut2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:51 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32VnNu27460298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:49 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99A0A6E06E;
        Fri,  3 Dec 2021 02:31:49 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 797B56E05E;
        Fri,  3 Dec 2021 02:31:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:48 +0000 (GMT)
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
Subject: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Date:   Thu,  2 Dec 2021 21:31:18 -0500
Message-Id: <20211203023118.1447229-20-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qcU251NIVPE2RPqeXmaguESIE_nP2mdL
X-Proofpoint-ORIG-GUID: VxKwY_cTRMeL0E085G-64JEnc9nET2ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Setup securityfs with symlinks, directories, and files for IMA
namespacing support. The same directory structure that IMA uses on the
host is also created for the namespacing case.

Increment the user namespace's refcount_teardown value by '1' once
securityfs has been successfully setup since the initialization of the
filesystem causes an additional reference to the user namespace to be
taken. The early teardown function will delete the file system and release
the additional reference.

The securityfs file and directory ownerships cannot be set when the
IMA namespace is initialized. Therefore, delay the setup of the file
system to a later point when securityfs initializes the fs_context.

This filesystem can now be mounted as follows:

mount -t securityfs /sys/kernel/security/ /sys/kernel/security/

The following directories, symlinks, and files are then available.

$ ls -l sys/kernel/security/
total 0
lr--r--r--. 1 root root 0 Dec  2 00:18 ima -> integrity/ima
drwxr-xr-x. 3 root root 0 Dec  2 00:18 integrity

$ ls -l sys/kernel/security/ima/
total 0
-r--r-----. 1 root root 0 Dec  2 00:18 ascii_runtime_measurements
-r--r-----. 1 root root 0 Dec  2 00:18 binary_runtime_measurements
-rw-------. 1 root root 0 Dec  2 00:18 policy
-r--r-----. 1 root root 0 Dec  2 00:18 runtime_measurements_count
-r--r-----. 1 root root 0 Dec  2 00:18 violations

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      |  17 +++
 security/inode.c                         |   8 ++
 security/integrity/ima/ima.h             |   2 +
 security/integrity/ima/ima_fs.c          | 157 ++++++++++++++++++++++-
 security/integrity/ima/ima_init_ima_ns.c |   6 +-
 security/integrity/ima/ima_ns.c          |   2 +
 6 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 889e9c70cbfb..a13f934f15fc 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -220,6 +220,18 @@ struct ima_h_table {
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
@@ -266,6 +278,11 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *dentry[IMAFS_DENTRY_LAST];
+	struct vfsmount *mount;
+	int mount_count;
+	int (*late_fs_init)(struct user_namespace *user_ns);
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/inode.c b/security/inode.c
index 2738a7b31469..6223f1d838f6 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 #include <linux/user_namespace.h>
+#include <linux/ima.h>
 
 static struct vfsmount *securityfs_mount;
 static int securityfs_mount_count;
@@ -63,6 +64,13 @@ static const struct fs_context_operations securityfs_context_ops = {
 
 static int securityfs_init_fs_context(struct fs_context *fc)
 {
+	int rc;
+
+	if (fc->user_ns->ima_ns->late_fs_init) {
+		rc = fc->user_ns->ima_ns->late_fs_init(fc->user_ns);
+		if (rc)
+			return rc;
+	}
 	fc->ops = &securityfs_context_ops;
 	return 0;
 }
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
index 6766bb8262f2..65b2af7c14dd 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -22,6 +22,7 @@
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
 #include <linux/ima.h>
+#include <linux/namei.h>
 
 #include "ima.h"
 
@@ -436,8 +437,14 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	if (ns == &init_ima_ns) {
+		securityfs_remove(ima_policy);
+		ima_policy = NULL;
+	} else {
+		securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_POLICY],
+				     &ns->mount, &ns->mount_count);
+		ns->dentry[IMAFS_DENTRY_POLICY] = NULL;
+	}
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -509,3 +516,149 @@ int __init ima_fs_init(void)
 	securityfs_remove(ima_policy);
 	return -1;
 }
+
+static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
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
+	}
+	securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_DIR],
+			     &ns->mount, &ns->mount_count);
+	securityfs_ns_remove(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR],
+			     &ns->mount, &ns->mount_count);
+
+	memset(ns->dentry, 0, sizeof(ns->dentry));
+
+}
+
+/* Function to populeate namespace SecurityFS once user namespace
+ * has been configured.
+ */
+static int ima_fs_ns_late_init(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns = user_ns->ima_ns;
+	struct dentry *parent;
+
+	/* already initialized? */
+	if (ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])
+		return 0;
+
+	ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
+	    securityfs_ns_create_dir("integrity", NULL,
+				     &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])) {
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_DIR] =
+	    securityfs_ns_create_dir("ima", ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR],
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
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT])) {
+		ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_VIOLATIONS] =
+	    securityfs_ns_create_file("violations", S_IRUSR | S_IRGRP,
+				   parent, NULL, &ima_htable_violations_ops,
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_VIOLATIONS])) {
+		ns->dentry[IMAFS_DENTRY_VIOLATIONS] = NULL;
+		goto out;
+	}
+
+	ns->dentry[IMAFS_DENTRY_IMA_POLICY] =
+	    securityfs_ns_create_file("policy", POLICY_FILE_FLAGS,
+				   parent, NULL, &ima_measure_policy_ops,
+				   &ns->mount, &ns->mount_count);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_IMA_POLICY])) {
+		ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
+		goto out;
+	}
+
+
+	return 0;
+
+out:
+	ima_fs_ns_free_dentries(ns);
+
+	return -1;
+}
+
+int ima_fs_ns_init(struct ima_namespace *ns)
+{
+	ns->mount = securityfs_ns_create_mount(ns->user_ns);
+	if (IS_ERR(ns->mount)) {
+		ns->mount = NULL;
+		return -1;
+	}
+	ns->mount_count = 1;
+
+	/* Adjust the trigger for user namespace's early teardown of dependent
+	 * namespaces. Due to the filesystem there's an additional reference
+	 * to the user namespace.
+	 */
+	ns->user_ns->refcount_teardown += 1;
+
+	ns->late_fs_init = ima_fs_ns_late_init;
+
+	return 0;
+}
+
+void ima_fs_ns_free(struct ima_namespace *ns)
+{
+	ima_fs_ns_free_dentries(ns);
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
index 4260f96c4eca..9d5917c97fcc 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -67,6 +67,8 @@ struct ima_namespace *copy_ima_ns(struct ima_namespace *old_ns,
 
 void ima_ns_userns_early_teardown(struct ima_namespace *ns)
 {
+	pr_debug("%s: ns=0x%p\n", __func__, ns);
+	ima_fs_ns_free(ns);
 }
 EXPORT_SYMBOL(ima_ns_userns_early_teardown);
 
-- 
2.31.1

