Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A13765723B
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Dec 2022 04:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiL1DF5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Dec 2022 22:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiL1DFy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Dec 2022 22:05:54 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC41A102A;
        Tue, 27 Dec 2022 19:05:51 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nhbw10XnQzRqLt;
        Wed, 28 Dec 2022 11:04:17 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 11:05:38 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] evm: Use __vfs_setxattr() to update security.evm
Date:   Wed, 28 Dec 2022 11:02:48 +0800
Message-ID: <20221228030248.94285-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently it uses __vfs_setxattr_noperm() to update "security.evm",
however there are two lsm hooks(inode_post_setxattr and inode_setsecurity)
being called inside this function, which don't make any sense for xattr
"security.evm", because the handlers of these two hooks, such as selinux
and smack, only care about their own xattr.

On the other hand, there is a literally rather than actually cyclical
callchain as follows:
security_inode_post_setxattr
  ->evm_inode_post_setxattr
    ->evm_update_evmxattr
      ->__vfs_setxattr_noperm
        ->security_inode_post_setxattr

So use __vfs_setxattr() to update "security.evm".

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/integrity/evm/evm_crypto.c   | 7 +++----
 security/integrity/ima/ima_appraise.c | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index fa5ff13fa8c9..d8275dfa49ef 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -376,10 +376,9 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			   xattr_value_len, &data);
 	if (rc == 0) {
 		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
-		rc = __vfs_setxattr_noperm(&init_user_ns, dentry,
-					   XATTR_NAME_EVM,
-					   &data.hdr.xattr.data[1],
-					   SHA1_DIGEST_SIZE + 1, 0);
+		rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
+				    XATTR_NAME_EVM, &data.hdr.xattr.data[1],
+				    SHA1_DIGEST_SIZE + 1, 0);
 	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
 		rc = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_EVM);
 	}
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ee6f7e237f2e..d2de9dc6c345 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -98,10 +98,10 @@ static int ima_fix_xattr(struct dentry *dentry,
 		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
 		iint->ima_hash->xattr.ng.algo = algo;
 	}
-	rc = __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_IMA,
-				   &iint->ima_hash->xattr.data[offset],
-				   (sizeof(iint->ima_hash->xattr) - offset) +
-				   iint->ima_hash->length, 0);
+	rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
+			    XATTR_NAME_IMA, &iint->ima_hash->xattr.data[offset],
+			    (sizeof(iint->ima_hash->xattr) - offset) +
+			    iint->ima_hash->length, 0);
 	return rc;
 }
 
-- 
2.17.1

