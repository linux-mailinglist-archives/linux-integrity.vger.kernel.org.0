Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2418366FEA
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbhDUQUp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 12:20:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2899 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244256AbhDUQUi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 12:20:38 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FQQVg2LKKz6wjbk;
        Thu, 22 Apr 2021 00:09:47 +0800 (CST)
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
Subject: [PATCH v2 4/6] security: Support multiple LSMs implementing the inode_init_security hook
Date:   Wed, 21 Apr 2021 18:19:23 +0200
Message-ID: <20210421161925.968825-5-roberto.sassu@huawei.com>
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

The current implementation of security_inode_init_security() is capable of
handling only one LSM providing an xattr to be set at inode creation. That
xattr is then passed to EVM to calculate the HMAC.

To support multiple LSMs, each providing an xattr, this patch makes the
following modifications:

security_inode_init_security():
- dynamically allocates new_xattrs, based on the number of
  inode_init_security hooks registered by LSMs;
- replaces the call_int_hook() macro with its definition, to correctly
  handle the case of an LSM returning -EOPNOTSUPP (the loop should not be
  stopped).

security_old_inode_init_security():
- replaces the call_int_hook() macro with its definition, to stop the loop
  at the first LSM providing an xattr, to avoid a memory leak (due to
  overwriting the *value pointer).

The modifications necessary for EVM to calculate the HMAC on all xattrs
will be done in a separate patch.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/security.c | 93 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/security/security.c b/security/security.c
index 2c1fe1496069..2ab67fa4422e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,8 +30,6 @@
 #include <linux/msg.h>
 #include <net/flow.h>
 
-#define MAX_LSM_EVM_XATTR	2
-
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 
@@ -1028,9 +1026,10 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
+	struct xattr *new_xattrs;
 	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	struct security_hook_list *P;
+	int ret, max_new_xattrs = 0;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -1038,14 +1037,52 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
 				     dir, qstr, NULL, fs_data);
-	memset(new_xattrs, 0, sizeof(new_xattrs));
+
+	/* Determine at run-time the max number of xattr structs to allocate. */
+	hlist_for_each_entry(P, &security_hook_heads.inode_init_security, list)
+		max_new_xattrs++;
+
+	if (!max_new_xattrs)
+		return 0;
+
+	/* Allocate +1 for EVM and +1 as terminator. */
+	new_xattrs = kcalloc(max_new_xattrs + 2, sizeof(*new_xattrs), GFP_NOFS);
+	if (!new_xattrs)
+		return -ENOMEM;
+
 	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-			    lsm_xattr, fs_data);
-	if (ret)
+	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
+			     list) {
+		ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs,
+						  fs_data);
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				goto out;
+
+			continue;
+		}
+
+		/* LSM implementation error. */
+		if (lsm_xattr->name == NULL || lsm_xattr->value == NULL) {
+			WARN_ONCE(
+				"LSM %s: ret = 0 but xattr name/value = NULL\n",
+				P->lsm);
+			ret = -ENOENT;
+			goto out;
+		}
+
+		lsm_xattr++;
+
+		if (!--max_new_xattrs)
+			break;
+	}
+
+	if (!new_xattrs->name) {
+		ret = -EOPNOTSUPP;
 		goto out;
+	}
 
-	evm_xattr = lsm_xattr + 1;
+	evm_xattr = lsm_xattr;
 	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
 	if (ret)
 		goto out;
@@ -1053,6 +1090,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 out:
 	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
 		kfree(xattr->value);
+	kfree(new_xattrs);
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 EXPORT_SYMBOL(security_inode_init_security);
@@ -1071,11 +1109,44 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	struct xattr xattr = { .name = NULL, .value = NULL, .value_len = 0 };
 	struct xattr *lsm_xattr = (name && value && len) ? &xattr : NULL;
+	struct security_hook_list *P;
+	int ret;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
-			     qstr, lsm_xattr, NULL);
+
+	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
+			     list) {
+		ret = P->hook.inode_init_security(inode, dir, qstr, lsm_xattr,
+						  NULL);
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				return ret;
+
+			continue;
+		}
+
+		if (!lsm_xattr)
+			continue;
+
+		/* LSM implementation error. */
+		if (lsm_xattr->name == NULL || lsm_xattr->value == NULL) {
+			WARN_ONCE(
+				"LSM %s: ret = 0 but xattr name/value = NULL\n",
+				P->lsm);
+
+			/* Callers should do the cleanup. */
+			return -ENOENT;
+		}
+
+		*name = lsm_xattr->name;
+		*value = lsm_xattr->value;
+		*len = lsm_xattr->value_len;
+
+		return ret;
+	}
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
-- 
2.25.1

