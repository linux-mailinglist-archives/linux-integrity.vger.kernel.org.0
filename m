Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36143155468
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2020 10:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGJW3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Feb 2020 04:22:29 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45133 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgBGJW3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Feb 2020 04:22:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TpLhKLk_1581067342;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TpLhKLk_1581067342)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Feb 2020 17:22:23 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
Date:   Fri,  7 Feb 2020 17:22:18 +0800
Message-Id: <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
References: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The name sm3-256 is defined in hash_algo_name in hash_info, but the
algorithm name implemented in sm3_generic.c is sm3, which will cause
the sm3-256 algorithm to be not found in some application scenarios of
the hash algorithm, and an ENOENT error will occur. For example,
IMA, keys, and other subsystems that reference hash_algo_name cannot use
the hash algorithm of sm3. This patch adds an alias name sm3-256 to sm3,
which can better solve the above problems.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/sm3_generic.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/crypto/sm3_generic.c b/crypto/sm3_generic.c
index 3468975215ca..ded41031bd5f 100644
--- a/crypto/sm3_generic.c
+++ b/crypto/sm3_generic.c
@@ -163,7 +163,7 @@ int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 }
 EXPORT_SYMBOL(crypto_sm3_finup);
 
-static struct shash_alg sm3_alg = {
+static struct shash_alg sm3_algs[2] = { {
 	.digestsize	=	SM3_DIGEST_SIZE,
 	.init		=	sm3_base_init,
 	.update		=	crypto_sm3_update,
@@ -176,16 +176,28 @@ static struct shash_alg sm3_alg = {
 		.cra_blocksize	 =	SM3_BLOCK_SIZE,
 		.cra_module	 =	THIS_MODULE,
 	}
-};
+}, {
+	.digestsize	=	SM3_DIGEST_SIZE,
+	.init		=	sm3_base_init,
+	.update		=	crypto_sm3_update,
+	.final		=	sm3_final,
+	.finup		=	crypto_sm3_finup,
+	.descsize	=	sizeof(struct sm3_state),
+	.base		=	{
+		.cra_name	 =	"sm3-256",
+		.cra_blocksize	 =	SM3_BLOCK_SIZE,
+		.cra_module	 =	THIS_MODULE,
+	}
+} };
 
 static int __init sm3_generic_mod_init(void)
 {
-	return crypto_register_shash(&sm3_alg);
+	return crypto_register_shashes(sm3_algs, ARRAY_SIZE(sm3_algs));
 }
 
 static void __exit sm3_generic_mod_fini(void)
 {
-	crypto_unregister_shash(&sm3_alg);
+	crypto_unregister_shashes(sm3_algs, ARRAY_SIZE(sm3_algs));
 }
 
 subsys_initcall(sm3_generic_mod_init);
@@ -196,3 +208,4 @@ MODULE_DESCRIPTION("SM3 Secure Hash Algorithm");
 
 MODULE_ALIAS_CRYPTO("sm3");
 MODULE_ALIAS_CRYPTO("sm3-generic");
+MODULE_ALIAS_CRYPTO("sm3-256");
-- 
2.17.1

