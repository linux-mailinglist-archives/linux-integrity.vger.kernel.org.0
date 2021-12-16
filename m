Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079594769CD
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 06:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhLPFoK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 00:44:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233813AbhLPFoA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 00:44:00 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG4UrXA018665;
        Thu, 16 Dec 2021 05:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A0Y0wY5ZaOD20UWh5eWa3yIGfFT7T8aSemwDkCyysXo=;
 b=Z84eaUZQza3FklMQ3YDQDovesx85A9d8yQCm+I9gkEZnHtAQ77Qf7dz/aD4zGA97hGmR
 QZBZ4fr8VhziZgLqXAjSKQieJ7jBr0dcDZJESfBxZ1XW2uz25gnIOREOpXorTLNnNM4q
 65ij+z06YIdzwg2ggi+m+x/yiKsAgvsrkoE8977cAGl+zIgO1rMzpuwEvkOYAa4TS7FZ
 N2UG8W9MCfyvKpqcHvARxiWKhTGRppGcNQqAukpyeVcswYp6ftT78zMnAioPgKRkbUB2
 oRLOuZdqLO5F+YIlr4A4aqLSt9zcu3dwqo7M612cuL7Ig3PnJvbZrH32KKKsTMNIxYoW 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm99c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:42 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG5f2tw011494;
        Thu, 16 Dec 2021 05:43:41 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm994-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:41 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5fuDl032272;
        Thu, 16 Dec 2021 05:43:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3cy7hf9br7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:40 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG5hd3834341258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 05:43:39 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E516F6E056;
        Thu, 16 Dec 2021 05:43:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0C496E050;
        Thu, 16 Dec 2021 05:43:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 05:43:37 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v7 10/14] securityfs: Extend securityfs with namespacing support
Date:   Thu, 16 Dec 2021 00:43:19 -0500
Message-Id: <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rZz3Qz6sWxz4j3vYh6iNCkTm17OqCL55
X-Proofpoint-GUID: m3jpDq9NyWRgJXw1vWb8NO5vgKpqbklw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=924
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160033
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Extend 'securityfs' for support of IMA namespacing so that each
IMA (user) namespace can have its own front-end for showing the currently
active policy, the measurement list, number of violations and so on.

Drop the addition dentry reference to enable simple cleanup of dentries
upon umount.

Prevent mounting of an instance of securityfs in another user namespace
than it belongs to. Also, prevent accesses to directories when another
user namespace is active than the one that the instance of securityfs
belongs to.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 security/inode.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index fee01ff4d831..a0d9f086e3d5 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -26,6 +26,29 @@
 static struct vfsmount *init_securityfs_mount;
 static int init_securityfs_mount_count;
 
+static int securityfs_permission(struct user_namespace *mnt_userns,
+				 struct inode *inode, int mask)
+{
+	int err;
+
+	err = generic_permission(&init_user_ns, inode, mask);
+	if (!err) {
+		if (inode->i_sb->s_user_ns != current_user_ns())
+			err = -EACCES;
+	}
+
+	return err;
+}
+
+const struct inode_operations securityfs_dir_inode_operations = {
+	.permission	= securityfs_permission,
+	.lookup		= simple_lookup,
+};
+
+const struct inode_operations securityfs_file_inode_operations = {
+	.permission	= securityfs_permission,
+};
+
 static void securityfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
@@ -41,20 +64,25 @@ static const struct super_operations securityfs_super_operations = {
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
+	struct user_namespace *ns = fc->user_ns;
 	int error;
 
+	if (WARN_ON(ns != current_user_ns()))
+		return -EINVAL;
+
 	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
 	if (error)
 		return error;
 
 	sb->s_op = &securityfs_super_operations;
+	sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;
 
 	return 0;
 }
 
 static int securityfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, securityfs_fill_super);
+	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
 }
 
 static const struct fs_context_operations securityfs_context_ops = {
@@ -72,6 +100,7 @@ static struct file_system_type fs_type = {
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_USERNS_MOUNT,
 };
 
 /**
@@ -157,7 +186,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
-		inode->i_op = &simple_dir_inode_operations;
+		inode->i_op = &securityfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		inc_nlink(inode);
 		inc_nlink(dir);
@@ -165,10 +194,10 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_op = iops ? iops : &simple_symlink_inode_operations;
 		inode->i_link = data;
 	} else {
+		inode->i_op = &securityfs_file_inode_operations;
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -316,10 +345,12 @@ void securityfs_remove(struct dentry *dentry)
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
+		dget(dentry);
 		if (d_is_dir(dentry))
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.31.1

