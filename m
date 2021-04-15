Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6995360675
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Apr 2021 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhDOKFU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Apr 2021 06:05:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2864 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhDOKFQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 06:05:16 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FLZZF44m0z68BH0;
        Thu, 15 Apr 2021 17:59:33 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 12:04:51 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 4/5] evm: Align evm_inode_init_security() definition with LSM infrastructure
Date:   Thu, 15 Apr 2021 12:04:34 +0200
Message-ID: <20210415100435.18619-5-roberto.sassu@huawei.com>
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

This patch changes the evm_inode_init_security() definition to align with
the LSM infrastructure, in preparation for moving IMA and EVM to that
infrastructure.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/evm.h               | 21 ++++++++++++++-------
 security/integrity/evm/evm_main.c | 24 +++++++++++++++---------
 security/security.c               |  7 +++++--
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 8cad46bcec9d..5d8b29d80296 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -34,9 +34,11 @@ extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
 				       const char *xattr_name);
-extern int evm_inode_init_security(struct inode *inode,
-				   const struct xattr *xattr_array,
-				   struct xattr *evm);
+extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
+				   const struct qstr *qstr,
+				   const char **name,
+				   void **value, size_t *len,
+				   struct xattr *lsm_xattrs);
 extern bool evm_status_revalidate(const char *xattr_name);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
@@ -102,11 +104,16 @@ static inline void evm_inode_post_removexattr(struct dentry *dentry,
 	return;
 }
 
-static inline int evm_inode_init_security(struct inode *inode,
-					  const struct xattr *xattr_array,
-					  struct xattr *evm)
+static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
+					  const struct qstr *qstr,
+					  const char **name,
+					  void **value, size_t *len,
+					  struct xattr *lsm_xattrs)
 {
-	return 0;
+	if (!name || !value || !len || !lsm_xattrs)
+		return 0;
+
+	return -EOPNOTSUPP;
 }
 
 static inline bool evm_status_revalidate(const char *xattr_name)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 84a9b7a69b1f..a5069d69a893 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -706,29 +706,35 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 /*
  * evm_inode_init_security - initializes security.evm HMAC value
  */
-int evm_inode_init_security(struct inode *inode,
-				 const struct xattr *lsm_xattr,
-				 struct xattr *evm_xattr)
+int evm_inode_init_security(struct inode *inode, struct inode *dir,
+			    const struct qstr *qstr,
+			    const char **name,
+			    void **value, size_t *len,
+			    struct xattr *lsm_xattrs)
 {
 	struct evm_xattr *xattr_data;
 	int rc;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) ||
-	    !evm_protected_xattr(lsm_xattr->name))
+	if (!name || !value || !len || !lsm_xattrs)
 		return 0;
 
+	if (!(evm_initialized & EVM_INIT_HMAC) ||
+	    !evm_protected_xattr(lsm_xattrs->name))
+		return -EOPNOTSUPP;
+
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
 	if (!xattr_data)
 		return -ENOMEM;
 
 	xattr_data->data.type = EVM_XATTR_HMAC;
-	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
+	rc = evm_init_hmac(inode, lsm_xattrs, xattr_data->digest);
 	if (rc < 0)
 		goto out;
 
-	evm_xattr->value = xattr_data;
-	evm_xattr->value_len = hash_digest_size[evm_hash_algo] + 1;
-	evm_xattr->name = XATTR_EVM_SUFFIX;
+	*name = XATTR_EVM_SUFFIX;
+	*value = xattr_data;
+	*len = hash_digest_size[evm_hash_algo] + 1;
+
 	return 0;
 out:
 	kfree(xattr_data);
diff --git a/security/security.c b/security/security.c
index 8aabbc0f0dfc..e16ce150b111 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1080,8 +1080,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		goto out;
 	}
 
-	ret = evm_inode_init_security(inode, new_xattrs, lsm_xattr);
-	if (ret)
+	ret = evm_inode_init_security(inode, dir, qstr,
+				      &lsm_xattr->name,
+				      &lsm_xattr->value,
+				      &lsm_xattr->value_len, new_xattrs);
+	if (ret && ret != -EOPNOTSUPP)
 		goto out;
 	ret = initxattrs(inode, new_xattrs, fs_data);
 out:
-- 
2.26.2

