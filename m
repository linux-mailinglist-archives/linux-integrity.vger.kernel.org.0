Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E2463B1D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhK3QLS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:11:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243428AbhK3QK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:10:59 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFwm63001599;
        Tue, 30 Nov 2021 16:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XHDx7UdQiacDIyoRj9REkK48bjlrza6iLsK3SdP+asw=;
 b=NtRDpjLHifqbeRYVpYCrF83O3ZtekvaCGOkX9E4NfplvmKuUE+lnrRiQGRM7v/Fn5UG2
 BLyqea0V0cP0E3u2DSBo7rjvyTJBtPdrjqo7xdRj9Us4THt+4Bb9ZPq8l/T6sE/dnQcu
 nEwQ84sFGJEKGirO1LL2VTUGDmu17CTVnwJjI1VhlCpO79REy+Hx80ITsoj8O9apaFsj
 ckvKTYVdoAT/nAEGAovGig65KvtBJ1mqQ50gRlXnv76rvUuxNyXlzZv+l3dSFfpTm1sU
 9svEr/tp7/krk0BO50cuJUoC9pBJNRjFzRB0iLLQI76F/wG2aZTrzNTOtWkju0i/K2pO qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnq2tg74q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:16 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUG1c0e015672;
        Tue, 30 Nov 2021 16:07:16 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnq2tg73u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:16 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG4BYV003706;
        Tue, 30 Nov 2021 16:07:14 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcaayt9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7CFQ54919660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7782DB2099;
        Tue, 30 Nov 2021 16:07:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E9B1B20AB;
        Tue, 30 Nov 2021 16:07:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:12 +0000 (GMT)
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
Subject: [RFC 12/20] securityfs: Pass static variables as parameters from top level functions
Date:   Tue, 30 Nov 2021 11:06:46 -0500
Message-Id: <20211130160654.1418231-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hb-f_ErIIfmDCMsYp0rKOLRlJ6Mvg7TO
X-Proofpoint-ORIG-GUID: 3MsJDVwPzPblJM5bZQD5SckRyV7Z42Gf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Pass the securityfs_-prefixed static variables from current top level
functions so that new APIs allow callers to pass in similar parameters and
thus share most of the existing functions.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/inode.c | 95 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 34 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index e523829c22cb..429744ff4ab3 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -88,6 +88,11 @@ static struct file_system_type securityfs_type = {
  *        this file.
  * @iops: a point to a struct of inode_operations that should be used for
  *        this file/dir
+ * @mount: a pointer to a pointer for existing vfsmount to use or for
+ *         one to create
+ * @mount_count: pointer to integer for mount_count that goes along with
+ *               @mount
+ *
  *
  * This is the basic "create a file/dir/symlink" function for
  * securityfs.  It allows for a wide range of flexibility in creating
@@ -107,7 +112,9 @@ static struct file_system_type securityfs_type = {
 static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const struct file_operations *fops,
-					const struct inode_operations *iops)
+					const struct inode_operations *iops,
+					struct file_system_type *fs_type,
+					struct vfsmount **mount, int *mount_count)
 {
 	struct dentry *dentry;
 	struct inode *dir, *inode;
@@ -118,12 +125,12 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&securityfs_type, &securityfs_mount, &securityfs_mount_count);
+	error = simple_pin_fs(fs_type, mount, mount_count);
 	if (error)
 		return ERR_PTR(error);
 
 	if (!parent)
-		parent = securityfs_mount->mnt_root;
+		parent = (*mount)->mnt_root;
 
 	dir = d_inode(parent);
 
@@ -168,7 +175,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&securityfs_mount, &securityfs_mount_count);
+	simple_release_fs(mount, mount_count);
 	return dentry;
 }
 
@@ -201,7 +208,9 @@ struct dentry *securityfs_create_file(const char *name, umode_t mode,
 				      struct dentry *parent, void *data,
 				      const struct file_operations *fops)
 {
-	return securityfs_create_dentry(name, mode, parent, data, fops, NULL);
+	return securityfs_create_dentry(name, mode, parent, data, fops, NULL,
+					&securityfs_type, &securityfs_mount,
+					&securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_create_file);
 
@@ -231,6 +240,29 @@ struct dentry *securityfs_create_dir(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(securityfs_create_dir);
 
+struct dentry *_securityfs_create_symlink(const char *name,
+					  struct dentry *parent,
+					  const char *target,
+					  const struct inode_operations *iops,
+					  struct file_system_type *fs_type,
+					  struct vfsmount **mount, int *mount_count)
+{
+	struct dentry *dent;
+	char *link = NULL;
+
+	if (target) {
+		link = kstrdup(target, GFP_KERNEL);
+		if (!link)
+			return ERR_PTR(-ENOMEM);
+	}
+	dent = securityfs_create_dentry(name, S_IFLNK | 0444, parent,
+					link, NULL, iops, fs_type,
+					mount, mount_count);
+	if (IS_ERR(dent))
+		kfree(link);
+
+	return dent;
+}
 /**
  * securityfs_create_symlink - create a symlink in the securityfs filesystem
  *
@@ -262,37 +294,13 @@ struct dentry *securityfs_create_symlink(const char *name,
 					 const char *target,
 					 const struct inode_operations *iops)
 {
-	struct dentry *dent;
-	char *link = NULL;
-
-	if (target) {
-		link = kstrdup(target, GFP_KERNEL);
-		if (!link)
-			return ERR_PTR(-ENOMEM);
-	}
-	dent = securityfs_create_dentry(name, S_IFLNK | 0444, parent,
-					link, NULL, iops);
-	if (IS_ERR(dent))
-		kfree(link);
-
-	return dent;
+	return _securityfs_create_symlink(name, parent, target, iops,
+					  &securityfs_type, &securityfs_mount,
+					  &securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_create_symlink);
 
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
+void _securityfs_remove(struct dentry *dentry, struct vfsmount **mount, int *mount_count)
 {
 	struct inode *dir;
 
@@ -309,8 +317,27 @@ void securityfs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&securityfs_mount, &securityfs_mount_count);
+	simple_release_fs(mount, mount_count);
+}
+
+/**
+ * securityfs_remove - removes a file or directory from the securityfs filesystem
+ *
+ * @dentry: a pointer to a the dentry of the file or directory to be removed.
+ *
+ * This function removes a file or directory in securityfs that was previously
+ * created with a call to another securityfs function (like
+ * securityfs_create_file() or variants thereof.)
+ *
+ * This function is required to be called in order for the file to be
+ * removed. No automatic cleanup of files will happen when a module is
+ * removed; you are responsible here.
+ */
+void securityfs_remove(struct dentry *dentry)
+{
+	_securityfs_remove(dentry, &securityfs_mount, &securityfs_mount_count);
 }
+
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
 #ifdef CONFIG_SECURITY
-- 
2.31.1

