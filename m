Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7A366FDE
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbhDUQUm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 12:20:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2898 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244254AbhDUQUi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 12:20:38 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FQQc91b4hz6wjrk;
        Thu, 22 Apr 2021 00:14:33 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 18:20:00 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 3/6] security: Pass xattrs allocated by LSMs to the inode_init_security hook
Date:   Wed, 21 Apr 2021 18:19:22 +0200
Message-ID: <20210421161925.968825-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210421161925.968825-1-roberto.sassu@huawei.com>
References: <20210421161925.968825-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In preparation for moving EVM to the LSM infrastructure, this patch
replaces the name, value, len triple with the xattr array pointer provided
by security_inode_init_security(). LSMs are expected to call the new
function lsm_find_xattr_slot() to find the first unused slot of the array
where the xattr should be written.

This patch modifies also SELinux and Smack to search for an unused slot, to
have a consistent behavior across LSMs (the unmodified version would
overwrite the xattr set by the first LSM in the chain). It is also
desirable to have the modification in those LSMs, as they are likely used
as a reference for the development of new LSMs.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/lsm_hooks.h     | 18 +++++++++++++++---
 security/security.c           | 13 +++++++------
 security/selinux/hooks.c      | 13 ++++++-------
 security/smack/smack_lsm.c    | 20 +++++++++-----------
 5 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 477a597db013..afb9dd122f60 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -111,8 +111,8 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
 LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, const char **name,
-	 void **value, size_t *len)
+	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
+	 void *fs_data)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c5498f5174ce..e8c9bac29b9d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -27,6 +27,7 @@
 
 #include <linux/security.h>
 #include <linux/init.h>
+#include <linux/xattr.h>
 #include <linux/rculist.h>
 
 /**
@@ -227,9 +228,11 @@
  *	@inode contains the inode structure of the newly created inode.
  *	@dir contains the inode structure of the parent directory.
  *	@qstr contains the last path component of the new object
- *	@name will be set to the allocated name suffix (e.g. selinux).
- *	@value will be set to the allocated attribute value.
- *	@len will be set to the length of the value.
+ *	@xattrs contains the full array of xattrs allocated by LSMs where
+ *	->name will be set to the allocated name suffix (e.g. selinux).
+ *	->value will be set to the allocated attribute value.
+ *	->len will be set to the length of the value.
+ *	@fs_data contains filesystem-specific data.
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
@@ -1661,4 +1664,13 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+static inline struct xattr *lsm_find_xattr_slot(struct xattr *xattrs)
+{
+	struct xattr *slot;
+
+	for (slot = xattrs; slot && slot->name != NULL; slot++)
+		;
+
+	return slot;
+}
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 7f14e59c4f8e..2c1fe1496069 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1037,18 +1037,16 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+				     dir, qstr, NULL, fs_data);
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
 	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
+			    lsm_xattr, fs_data);
 	if (ret)
 		goto out;
 
 	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
 	if (ret)
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
@@ -1071,10 +1069,13 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct xattr xattr = { .name = NULL, .value = NULL, .value_len = 0 };
+	struct xattr *lsm_xattr = (name && value && len) ? &xattr : NULL;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
-			     qstr, name, value, len);
+			     qstr, lsm_xattr, NULL);
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ddd097790d47..806827eb132a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2916,11 +2916,11 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
-				       const char **name,
-				       void **value, size_t *len)
+				       struct xattr *xattrs, void *fs_data)
 {
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
+	struct xattr *xattr = lsm_find_xattr_slot(xattrs);
 	u32 newsid, clen;
 	int rc;
 	char *context;
@@ -2947,16 +2947,15 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	if (name)
-		*name = XATTR_SELINUX_SUFFIX;
+	if (xattr) {
+		xattr->name = XATTR_SELINUX_SUFFIX;
 
-	if (value && len) {
 		rc = security_sid_to_context_force(&selinux_state, newsid,
 						   &context, &clen);
 		if (rc)
 			return rc;
-		*value = context;
-		*len = clen;
+		xattr->value = context;
+		xattr->value_len = clen;
 	}
 
 	return 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 12a45e61c1a5..af7eee0fee52 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -962,26 +962,24 @@ static int smack_inode_alloc_security(struct inode *inode)
  * @inode: the newly created inode
  * @dir: containing directory object
  * @qstr: unused
- * @name: where to put the attribute name
- * @value: where to put the attribute value
- * @len: where to put the length of the attribute
+ * @xattrs: where to put the attribute
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
-				     const struct qstr *qstr, const char **name,
-				     void **value, size_t *len)
+				     const struct qstr *qstr,
+				     struct xattr *xattrs, void *fs_data)
 {
 	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
+	struct xattr *xattr = lsm_find_xattr_slot(xattrs);
 	int may;
 
-	if (name)
-		*name = XATTR_SMACK_SUFFIX;
+	if (xattr) {
+		xattr->name = XATTR_SMACK_SUFFIX;
 
-	if (value && len) {
 		rcu_read_lock();
 		may = smk_access_entry(skp->smk_known, dsp->smk_known,
 				       &skp->smk_rules);
@@ -999,11 +997,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 			issp->smk_flags |= SMK_INODE_CHANGED;
 		}
 
-		*value = kstrdup(isp->smk_known, GFP_NOFS);
-		if (*value == NULL)
+		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
+		if (xattr->value == NULL)
 			return -ENOMEM;
 
-		*len = strlen(isp->smk_known);
+		xattr->value_len = strlen(isp->smk_known);
 	}
 
 	return 0;
-- 
2.25.1

