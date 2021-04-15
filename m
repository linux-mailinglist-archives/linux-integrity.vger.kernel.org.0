Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94DA360673
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Apr 2021 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhDOKFS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Apr 2021 06:05:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2863 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhDOKFP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 06:05:15 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FLZSw2vvJz689d5;
        Thu, 15 Apr 2021 17:54:56 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 12:04:50 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 3/5] security: Pass xattrs allocated by LSMs to the inode_init_security hook
Date:   Thu, 15 Apr 2021 12:04:33 +0200
Message-ID: <20210415100435.18619-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210415100435.18619-1-roberto.sassu@huawei.com>
References: <20210415100435.18619-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In preparation for moving EVM to the LSM infrastructure, this patch adds
the full array of xattrs allocated by LSMs as a new parameter of the
inode_init_security hook. It will be used by EVM to calculate the HMAC on
all xattrs.

This solution has been preferred to directly replacing the xattr name,
value and len with the full array, as LSMs would have had to scan it to
find an empty slot.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/lsm_hooks.h     | 1 +
 security/security.c           | 7 ++++---
 security/selinux/hooks.c      | 3 ++-
 security/smack/smack_lsm.c    | 4 +++-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 477a597db013..45a0b8cbb974 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -112,7 +112,7 @@ LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, const char **name,
-	 void **value, size_t *len)
+	 void **value, size_t *len, struct xattr *lsm_xattrs)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c5498f5174ce..1dd79e2f02ad 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -230,6 +230,7 @@
  *	@name will be set to the allocated name suffix (e.g. selinux).
  *	@value will be set to the allocated attribute value.
  *	@len will be set to the length of the value.
+ *	@lsm_xattrs contains the full array of xattrs allocated by LSMs.
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
diff --git a/security/security.c b/security/security.c
index 65624357b335..8aabbc0f0dfc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1036,7 +1036,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+				     dir, qstr, NULL, NULL, NULL, NULL);
 
 	/* Determine at run-time the max number of xattr structs to allocate. */
 	hlist_for_each_entry(P, &security_hook_heads.inode_init_security, list)
@@ -1056,7 +1056,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		ret = P->hook.inode_init_security(inode, dir, qstr,
 						  &lsm_xattr->name,
 						  &lsm_xattr->value,
-						  &lsm_xattr->value_len);
+						  &lsm_xattr->value_len,
+						  new_xattrs);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
 
@@ -1112,7 +1113,7 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
 			     list) {
 		ret = P->hook.inode_init_security(inode, dir, qstr,
-						  name, value, len);
+						  name, value, len, NULL);
 		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ddd097790d47..2fe9c39414d0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2917,7 +2917,8 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
 				       const char **name,
-				       void **value, size_t *len)
+				       void **value, size_t *len,
+				       struct xattr *lsm_xattrs)
 {
 	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 12a45e61c1a5..9d562ea576ca 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -965,12 +965,14 @@ static int smack_inode_alloc_security(struct inode *inode)
  * @name: where to put the attribute name
  * @value: where to put the attribute value
  * @len: where to put the length of the attribute
+ * @lsm_xattrs: unused
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
-				     void **value, size_t *len)
+				     void **value, size_t *len,
+				     struct xattr *lsm_xattrs)
 {
 	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_current();
-- 
2.26.2

