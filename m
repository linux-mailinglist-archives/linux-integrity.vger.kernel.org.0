Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A791D360687
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Apr 2021 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhDOKG2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Apr 2021 06:06:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2865 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhDOKG1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 06:06:27 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FLZVJ3cf5z689tm;
        Thu, 15 Apr 2021 17:56:08 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 12:06:02 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <jmorris@namei.org>, <paul@paul-moore.com>,
        <casey@schaufler-ca.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        <reiserfs-devel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 5/5] evm: Support multiple LSMs providing an xattr
Date:   Thu, 15 Apr 2021 12:04:35 +0200
Message-ID: <20210415100435.18619-6-roberto.sassu@huawei.com>
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

Currently, evm_inode_init_security() takes as input a single LSM xattr,
passed by security_inode_init_security(), and calculates the HMAC on it and
other inode metadata.

Given that initxattrs(), called by security_inode_init_security(), expects
that this array is terminated when the xattr name is set to NULL, this
patch reuses the same assumption for evm_inode_init_security() to scan all
xattrs and to calculate the HMAC on all of them.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm.h        |  2 ++
 security/integrity/evm/evm_crypto.c |  9 ++++++++-
 security/integrity/evm/evm_main.c   | 15 +++++++++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index ae590f71ce7d..24eac42b9f32 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -49,6 +49,8 @@ struct evm_digest {
 	char digest[IMA_MAX_DIGEST_SIZE];
 } __packed;
 
+int evm_protected_xattr(const char *req_xattr_name);
+
 int evm_init_key(void);
 int __init evm_init_crypto(void);
 int evm_update_evmxattr(struct dentry *dentry,
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index b66264b53d5d..35c5eec0517d 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -358,6 +358,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 		  char *hmac_val)
 {
 	struct shash_desc *desc;
+	const struct xattr *xattr;
 
 	desc = init_desc(EVM_XATTR_HMAC, evm_hash_algo);
 	if (IS_ERR(desc)) {
@@ -365,7 +366,13 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 		return PTR_ERR(desc);
 	}
 
-	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
+	for (xattr = lsm_xattr; xattr->name != NULL; xattr++) {
+		if (!evm_protected_xattr(xattr->name))
+			continue;
+
+		crypto_shash_update(desc, xattr->value, xattr->value_len);
+	}
+
 	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
 	kfree(desc);
 	return 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index a5069d69a893..fde366149499 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -260,7 +260,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	return evm_status;
 }
 
-static int evm_protected_xattr(const char *req_xattr_name)
+int evm_protected_xattr(const char *req_xattr_name)
 {
 	int namelen;
 	int found = 0;
@@ -712,14 +712,21 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    void **value, size_t *len,
 			    struct xattr *lsm_xattrs)
 {
+	struct xattr *xattr;
 	struct evm_xattr *xattr_data;
-	int rc;
+	int rc, evm_protected_xattrs = 0;
 
 	if (!name || !value || !len || !lsm_xattrs)
 		return 0;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) ||
-	    !evm_protected_xattr(lsm_xattrs->name))
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return -EOPNOTSUPP;
+
+	for (xattr = lsm_xattrs; xattr && xattr->name != NULL; xattr++)
+		if (evm_protected_xattr(xattr->name))
+			evm_protected_xattrs++;
+
+	if (!evm_protected_xattrs)
 		return -EOPNOTSUPP;
 
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
-- 
2.26.2

