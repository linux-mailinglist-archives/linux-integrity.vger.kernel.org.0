Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255952AFC0
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 03:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiERBQQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 21:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiERBQP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 21:16:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DDEBCA5;
        Tue, 17 May 2022 18:16:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L2w576wKrz1JCGK;
        Wed, 18 May 2022 09:14:51 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 09:16:12 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <gustavoars@kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [RESEND] evm: Refector struct evm_xattr
Date:   Wed, 18 May 2022 09:14:39 +0800
Message-ID: <20220518011439.184809-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

struct evm_xattr is only used for EVM_XATTR_HMAC type evm digest and is
glued together one flexible array and one fixed length array. The
original intention seems to be shortening the code as the "data" field
would always be a SHA1 digest.

This implementation is not complying with GCC's specification about
flexible array and spars yield the following warning:

security/integrity/evm/evm_main.c:852:30: warning: using sizeof on a flexible
structure
security/integrity/evm/evm_main.c:862:32: warning: using sizeof on a flexible
structure

Fix it by:
1. Remove struct evm_xattr and use struct evm_ima_xattr_data directly.
2. Get array size with struct_size instead of sizeof.

Reference: https://github.com/KSPP/linux/issues/174

Fixes: 6be5cc5246f80 ("evm: add support for different security.evm data types")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/evm/evm_main.c | 14 ++++++++------
 security/integrity/integrity.h    |  6 ------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 7d87772f0ce6..f2c4501a287a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -211,7 +211,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	/* check value type */
 	switch (xattr_data->type) {
 	case EVM_XATTR_HMAC:
-		if (xattr_len != sizeof(struct evm_xattr)) {
+		if (xattr_len != struct_size(*xattr_data, data,
+					     SHA1_DIGEST_SIZE)) {
 			evm_status = INTEGRITY_FAIL;
 			goto out;
 		}
@@ -842,24 +843,25 @@ int evm_inode_init_security(struct inode *inode,
 				 const struct xattr *lsm_xattr,
 				 struct xattr *evm_xattr)
 {
-	struct evm_xattr *xattr_data;
+	struct evm_ima_xattr_data *xattr_data;
 	int rc;
 
 	if (!(evm_initialized & EVM_INIT_HMAC) ||
 	    !evm_protected_xattr(lsm_xattr->name))
 		return 0;
 
-	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
+	xattr_data = kzalloc(struct_size(*xattr_data, data,
+			     SHA1_DIGEST_SIZE), GFP_NOFS);
 	if (!xattr_data)
 		return -ENOMEM;
 
-	xattr_data->data.type = EVM_XATTR_HMAC;
-	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
+	xattr_data->type = EVM_XATTR_HMAC;
+	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->data);
 	if (rc < 0)
 		goto out;
 
 	evm_xattr->value = xattr_data;
-	evm_xattr->value_len = sizeof(*xattr_data);
+	evm_xattr->value_len = struct_size(*xattr_data, data, SHA1_DIGEST_SIZE);
 	evm_xattr->name = XATTR_EVM_SUFFIX;
 	return 0;
 out:
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 3510e413ea17..91b16d620dd9 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -86,12 +86,6 @@ struct evm_ima_xattr_data {
 	u8 data[];
 } __packed;
 
-/* Only used in the EVM HMAC code. */
-struct evm_xattr {
-	struct evm_ima_xattr_data data;
-	u8 digest[SHA1_DIGEST_SIZE];
-} __packed;
-
 #define IMA_MAX_DIGEST_SIZE	64
 
 struct ima_digest_data {
-- 
2.36.0

