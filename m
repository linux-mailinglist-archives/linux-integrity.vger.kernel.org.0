Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98939508A1E
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379372AbiDTOLb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379382AbiDTOKO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BF443E3;
        Wed, 20 Apr 2022 07:07:18 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KDlZsJ005554;
        Wed, 20 Apr 2022 14:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FEyE80DP4RkZye0StgibPiO3aqxGjXU0clj63ZA79ME=;
 b=NrxhliOdTwywoWPKMdnaHiAOUpfYHdlTIG/K7UFAi3IL74pV/IjysqlKcv7tT8C/0Ls5
 Caoa9+R8gYGABcPP+gfyZtlvzsifLdLTD2kWuw5rNvj4ew6CTaSvNFuP8DlF0pXFI1w3
 SxFXJwfx79VnswX9PBmqzih72O1K0QgBd1PbP28X7S2I1ttUXDdJxVMBRlxuuMEMNQOl
 OzosaHJdEo+4zMbyPvuoSUB3MSWDOBMuh5KZOkhoCjjBcKjLBGdfa1EXyEVNkZwZAt06
 +SXHGDLS2qwJ+ag+DRy6x5o7DrQLqpzjdUBTJdKCB6P4G884tLxtsGqW6ln6RR33yTn0 EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjer7xy0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:43 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KCp2Tm021032;
        Wed, 20 Apr 2022 14:06:43 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjer7xxyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:43 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE37ID025284;
        Wed, 20 Apr 2022 14:06:41 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3ffnea4sgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6fxh45941026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECAD6AE05C;
        Wed, 20 Apr 2022 14:06:40 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C92E6AE063;
        Wed, 20 Apr 2022 14:06:40 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:40 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v12 02/26] securityfs: Extend securityfs with namespacing support
Date:   Wed, 20 Apr 2022 10:06:09 -0400
Message-Id: <20220420140633.753772-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yrDtbq0syCejZ2HRgYm8iwD8y8toDRTm
X-Proofpoint-ORIG-GUID: VBtMWcCp10aSJNxZFBpJhKaU37iwWPuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_03,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Enable multiple instances of securityfs by keying each instance with a
pointer to the user namespace it belongs to.

Since we do not need the pinning of the filesystem for the virtualization
case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
case when the init_user_ns is active. This simplifies the cleanup for the
virtualization case where usage of securityfs_remove() to free dentries
is therefore not needed anymore.

For the initial securityfs, i.e. the one mounted in the host userns mount,
nothing changes. The rules for securityfs_remove() are as before and it is
still paired with securityfs_create(). Specifically, a file created via
securityfs_create_dentry() in the initial securityfs mount still needs to
be removed by a call to securityfs_remove(). Creating a new dentry in the
initial securityfs mount still pins the filesystem like it always did.
Consequently, the initial securityfs mount is not destroyed on
umount/shutdown as long as at least one user of it still has dentries that
it hasn't removed with a call to securityfs_remove().

Prevent mounting of an instance of securityfs in another user namespace
than it belongs to. Also, prevent accesses to files and directories by
a user namespace that is neither the user namespace it belongs to
nor an ancestor of the user namespace that the instance of securityfs
belongs to. Do not prevent access if securityfs was bind-mounted and
therefore the init_user_ns is the owning user namespace.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v11:
 - Formatted comment's first line to be '/*'
---
 security/inode.c | 73 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 13e6780c4444..84c9396792a9 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,9 +21,38 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/user_namespace.h>
 
-static struct vfsmount *mount;
-static int mount_count;
+static struct vfsmount *init_securityfs_mount;
+static int init_securityfs_mount_count;
+
+static int securityfs_permission(struct user_namespace *mnt_userns,
+				 struct inode *inode, int mask)
+{
+	int err;
+
+	err = generic_permission(&init_user_ns, inode, mask);
+	if (!err) {
+		/*
+		 * Unless bind-mounted, deny access if current_user_ns() is not
+		 * ancestor.
+		 */
+		if (inode->i_sb->s_user_ns != &init_user_ns &&
+		    !in_userns(current_user_ns(), inode->i_sb->s_user_ns))
+			err = -EACCES;
+	}
+
+	return err;
+}
+
+static const struct inode_operations securityfs_dir_inode_operations = {
+	.permission	= securityfs_permission,
+	.lookup		= simple_lookup,
+};
+
+static const struct inode_operations securityfs_file_inode_operations = {
+	.permission	= securityfs_permission,
+};
 
 static void securityfs_free_inode(struct inode *inode)
 {
@@ -40,20 +69,25 @@ static const struct super_operations securityfs_super_operations = {
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
@@ -71,6 +105,7 @@ static struct file_system_type fs_type = {
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_USERNS_MOUNT,
 };
 
 /**
@@ -109,6 +144,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					const struct file_operations *fops,
 					const struct inode_operations *iops)
 {
+	struct user_namespace *ns = current_user_ns();
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
@@ -118,12 +154,19 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
-	if (error)
-		return ERR_PTR(error);
+	if (ns == &init_user_ns) {
+		error = simple_pin_fs(&fs_type, &init_securityfs_mount,
+				      &init_securityfs_mount_count);
+		if (error)
+			return ERR_PTR(error);
+	}
 
-	if (!parent)
-		parent = mount->mnt_root;
+	if (!parent) {
+		if (ns == &init_user_ns)
+			parent = init_securityfs_mount->mnt_root;
+		else
+			return ERR_PTR(-EINVAL);
+	}
 
 	dir = d_inode(parent);
 
@@ -148,7 +191,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
-		inode->i_op = &simple_dir_inode_operations;
+		inode->i_op = &securityfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		inc_nlink(inode);
 		inc_nlink(dir);
@@ -156,6 +199,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_op = iops ? iops : &simple_symlink_inode_operations;
 		inode->i_link = data;
 	} else {
+		inode->i_op = &securityfs_file_inode_operations;
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
@@ -167,7 +211,9 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&init_securityfs_mount,
+				  &init_securityfs_mount_count);
 	return dentry;
 }
 
@@ -293,11 +339,14 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
  */
 void securityfs_remove(struct dentry *dentry)
 {
+	struct user_namespace *ns;
 	struct inode *dir;
 
 	if (!dentry || IS_ERR(dentry))
 		return;
 
+	ns = dentry->d_sb->s_user_ns;
+
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
@@ -310,7 +359,9 @@ void securityfs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&init_securityfs_mount,
+				  &init_securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
-- 
2.34.1

