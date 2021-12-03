Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A3466FDC
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378210AbhLCCfX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:35:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378155AbhLCCfS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31qPTn008161;
        Fri, 3 Dec 2021 02:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KK53tBUKl1BhRAg26/l3a5POBARot8jPd4kxd3J+ijs=;
 b=hy9Tksxu1bIHtwtWXTfPYoE9qWq4cXUZ/PuO5/o5lIr/N87A80v/PD+U/jNb15gxW/Z5
 tjAkqOu3IKBysJDw24sU2w3bQ+sJ9MxDEQmuPc1dLZE2x0rtfvu+J4/1swNoclCbAb2X
 CkQTh5T0N1U4XRbHqCvIRHzGFE33Ervsqkn3JSfP0hBkS/Prt2g7MV9rV5sRK2czrehd
 46ixbHLDArVGBkwGTkPcedF8A+Z83AwAphy1N8fdNbZ83LkK9Ri6QFCc3e7iEnk5PkpH
 sDHNt8h1jtHrAUD2Uwj+LH8gytJUpJpBwqE5i1iMxcssItuaMUY+XTX+C2pRudHUBfFW YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9y40h32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:44 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32Rrvg016710;
        Fri, 3 Dec 2021 02:31:44 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq9y40h2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:44 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32Rkck025381;
        Fri, 3 Dec 2021 02:31:42 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcacuf18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:42 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32VebL17957122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:40 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE3CF6E068;
        Fri,  3 Dec 2021 02:31:40 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A81146E056;
        Fri,  3 Dec 2021 02:31:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:39 +0000 (GMT)
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
Subject: [RFC v2 12/19] securityfs: Pass static variables as parameters from top level functions
Date:   Thu,  2 Dec 2021 21:31:11 -0500
Message-Id: <20211203023118.1447229-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3-Fl6qVWvPUtKE1LmatthEwIBZ6djiO6
X-Proofpoint-GUID: v6n4HsigtHY7q0BuPvQRu5VkqqP-95pE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112030014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Pass the securityfs_-prefixed static variables from current top level
functions so that new APIs allow callers to pass in similar parameters and
thus share most of the existing functions.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/inode.c | 92 ++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 34 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 71d93108de55..9299f134877f 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -88,6 +88,11 @@ static struct file_system_type fs_type = {
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
@@ -107,7 +112,8 @@ static struct file_system_type fs_type = {
 static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const struct file_operations *fops,
-					const struct inode_operations *iops)
+					const struct inode_operations *iops,
+					struct vfsmount **mount, int *mount_count)
 {
 	struct dentry *dentry;
 	struct inode *dir, *inode;
@@ -118,12 +124,12 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &securityfs_mount, &securityfs_mount_count);
+	error = simple_pin_fs(&fs_type, mount, mount_count);
 	if (error)
 		return ERR_PTR(error);
 
 	if (!parent)
-		parent = securityfs_mount->mnt_root;
+		parent = (*mount)->mnt_root;
 
 	dir = d_inode(parent);
 
@@ -168,7 +174,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&securityfs_mount, &securityfs_mount_count);
+	simple_release_fs(mount, mount_count);
 	return dentry;
 }
 
@@ -201,7 +207,9 @@ struct dentry *securityfs_create_file(const char *name, umode_t mode,
 				      struct dentry *parent, void *data,
 				      const struct file_operations *fops)
 {
-	return securityfs_create_dentry(name, mode, parent, data, fops, NULL);
+	return securityfs_create_dentry(name, mode, parent, data, fops, NULL,
+					&securityfs_mount,
+					&securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_create_file);
 
@@ -231,6 +239,27 @@ struct dentry *securityfs_create_dir(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(securityfs_create_dir);
 
+static struct dentry *_securityfs_create_symlink(const char *name,
+						 struct dentry *parent,
+						 const char *target,
+						 const struct inode_operations *iops,
+						 struct vfsmount **mount, int *mount_count)
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
+					link, NULL, iops, mount, mount_count);
+	if (IS_ERR(dent))
+		kfree(link);
+
+	return dent;
+}
 /**
  * securityfs_create_symlink - create a symlink in the securityfs filesystem
  *
@@ -262,37 +291,13 @@ struct dentry *securityfs_create_symlink(const char *name,
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
+					  &securityfs_mount, &securityfs_mount_count);
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
+static void _securityfs_remove(struct dentry *dentry,
+			       struct vfsmount **mount, int *mount_count)
 {
 	struct inode *dir;
 
@@ -309,8 +314,27 @@ void securityfs_remove(struct dentry *dentry)
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

