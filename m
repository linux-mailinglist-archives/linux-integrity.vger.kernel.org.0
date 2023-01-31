Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC66821CA
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 03:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAaCDJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 21:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjAaCDI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 21:03:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577C1A97B;
        Mon, 30 Jan 2023 18:03:07 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P5SxX6FM0zfYrx;
        Tue, 31 Jan 2023 10:02:56 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 10:03:05 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] evm: call dump_security_xattr() in all cases to remove code duplication
Date:   Tue, 31 Jan 2023 10:00:31 +0800
Message-ID: <20230131020031.114086-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently dump_security_xattr() is used to dump security xattr value
which is larger than 64 bytes, otherwise, pr_debug() is used. In order
to remove code duplication, refator dump_security_xattr() and call it in
all cases.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/integrity/evm/evm_crypto.c | 33 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index fa5ff13fa8c9..0fe6c9cd8eab 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -183,8 +183,8 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
  * Dump large security xattr values as a continuous ascii hexademical string.
  * (pr_debug is limited to 64 bytes.)
  */
-static void dump_security_xattr(const char *prefix, const void *src,
-				size_t count)
+static void dump_security_xattr_l(const char *prefix, const void *src,
+				  size_t count)
 {
 #if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
 	char *asciihex, *p;
@@ -200,6 +200,16 @@ static void dump_security_xattr(const char *prefix, const void *src,
 #endif
 }
 
+static void dump_security_xattr(const char *name, const char *value,
+				size_t value_len)
+{
+	if (value_len < 64)
+		pr_debug("%s: (%zu) [%*phN]\n", name, value_len,
+			 (int)value_len, value);
+	else
+		dump_security_xattr_l(name, value, value_len);
+}
+
 /*
  * Calculate the HMAC value across the set of protected security xattrs.
  *
@@ -254,15 +264,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 			if (is_ima)
 				ima_present = true;
 
-			if (req_xattr_value_len < 64)
-				pr_debug("%s: (%zu) [%*phN]\n", req_xattr_name,
-					 req_xattr_value_len,
-					 (int)req_xattr_value_len,
-					 req_xattr_value);
-			else
-				dump_security_xattr(req_xattr_name,
-						    req_xattr_value,
-						    req_xattr_value_len);
+			dump_security_xattr(req_xattr_name,
+					    req_xattr_value,
+					    req_xattr_value_len);
 			continue;
 		}
 		size = vfs_getxattr_alloc(&init_user_ns, dentry, xattr->name,
@@ -286,12 +290,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (is_ima)
 			ima_present = true;
 
-		if (xattr_size < 64)
-			pr_debug("%s: (%zu) [%*phN]", xattr->name, xattr_size,
-				 (int)xattr_size, xattr_value);
-		else
-			dump_security_xattr(xattr->name, xattr_value,
-					    xattr_size);
+		dump_security_xattr(xattr->name, xattr_value, xattr_size);
 	}
 	hmac_add_misc(desc, inode, type, data->digest);
 
-- 
2.17.1

