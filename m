Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6775525D501
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 11:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgIDJaW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 05:30:22 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730271AbgIDJaT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 05:30:19 -0400
Received: from lhreml725-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A917BA43DD5EB9595847;
        Fri,  4 Sep 2020 10:30:17 +0100 (IST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 lhreml725-chm.china.huawei.com (10.201.108.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 10:30:17 +0100
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.160)
 by fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 4 Sep 2020 11:30:16 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 09/12] evm: Allow setxattr() and setattr() if metadata digest won't change
Date:   Fri, 4 Sep 2020 11:26:40 +0200
Message-ID: <20200904092643.20013-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.27.GIT
In-Reply-To: <20200904092339.19598-1-roberto.sassu@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.160]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the patch to allow xattr/attr operations if a portable signature
verification fails, cp and tar can copy all xattrs/attrs so that at the
end of the process verification succeeds.

However, it might happen that xattrs/attrs are already set to the correct
value (taken at signing time) and signature verification succeeds before
the copy is completed. For example, an archive might contains files owned
by root and the archive is extracted by root.

Then, since portable signatures are immutable, all subsequent operations
fail (e.g. fchown()), even if the operation is legitimate (does not alter
the current value).

This patch avoids this problem by reporting successful operation to user
space when that operation does not alter the current value of xattrs/attrs.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm_main.c | 94 +++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index a5dab1ac9374..f43780ae8ae4 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -18,6 +18,7 @@
 #include <linux/integrity.h>
 #include <linux/evm.h>
 #include <linux/magic.h>
+#include <linux/posix_acl_xattr.h>
 
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
@@ -314,6 +315,78 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
 	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
 }
 
+/*
+ * evm_xattr_acl_change - check if passed ACL changes the inode mode
+ * @dentry: pointer to the affected dentry
+ * @xattr_name: requested xattr
+ * @xattr_value: requested xattr value
+ * @xattr_value_len: requested xattr value length
+ *
+ * Check if passed ACL changes the inode mode, which is protected by EVM.
+ *
+ * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
+ */
+static int evm_xattr_acl_change(struct dentry *dentry, const char *xattr_name,
+				const void *xattr_value, size_t xattr_value_len)
+{
+	umode_t mode;
+	struct posix_acl *acl = NULL, *acl_res;
+	struct inode *inode = d_backing_inode(dentry);
+	int rc;
+
+	/* UID/GID in ACL have been already converted from user to init ns */
+	acl = posix_acl_from_xattr(&init_user_ns, xattr_value, xattr_value_len);
+	if (!acl)
+		return 1;
+
+	acl_res = acl;
+	rc = posix_acl_update_mode(inode, &mode, &acl_res);
+
+	posix_acl_release(acl);
+
+	if (rc)
+		return 1;
+
+	if (acl_res && inode->i_mode != mode)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * evm_xattr_change - check if passed xattr value differs from current value
+ * @dentry: pointer to the affected dentry
+ * @xattr_name: requested xattr
+ * @xattr_value: requested xattr value
+ * @xattr_value_len: requested xattr value length
+ *
+ * Check if passed xattr value differs from current value.
+ *
+ * Returns 1 if passed xattr value differs from current value, 0 otherwise.
+ */
+static int evm_xattr_change(struct dentry *dentry, const char *xattr_name,
+			    const void *xattr_value, size_t xattr_value_len)
+{
+	char *xattr_data = NULL;
+	int rc = 0;
+
+	if (posix_xattr_acl(xattr_name))
+		return evm_xattr_acl_change(dentry, xattr_name, xattr_value,
+					    xattr_value_len);
+
+	rc = vfs_getxattr_alloc(dentry, xattr_name, &xattr_data, 0, GFP_NOFS);
+	if (rc < 0)
+		return 1;
+
+	if (rc == xattr_value_len)
+		rc = memcmp(xattr_value, xattr_data, rc);
+	else
+		rc = 1;
+
+	kfree(xattr_data);
+	return rc;
+}
+
 /*
  * evm_protect_xattr - protect the EVM extended attribute
  *
@@ -370,6 +443,10 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
 		return 0;
 
+	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
+	    !evm_xattr_change(dentry, xattr_name, xattr_value, xattr_value_len))
+		return 0;
+
 	if (evm_status != INTEGRITY_PASS)
 		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 				    dentry->d_name.name, "appraise_metadata",
@@ -490,6 +567,19 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
+static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	unsigned int ia_valid = attr->ia_valid;
+
+	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid)) &&
+	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
+	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
+		return 0;
+
+	return 1;
+}
+
 /**
  * evm_inode_setattr - prevent updating an invalid EVM extended attribute
  * @dentry: pointer to the affected dentry
@@ -519,6 +609,10 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
 	    (evm_status == INTEGRITY_FAIL_IMMUTABLE))
 		return 0;
 
+	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
+	    !evm_attr_change(dentry, attr))
+		return 0;
+
 	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
 			    dentry->d_name.name, "appraise_metadata",
 			    integrity_status_msg[evm_status], -EPERM, 0);
-- 
2.27.GIT

