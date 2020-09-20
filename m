Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEE52715C2
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Sep 2020 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgITQVY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Sep 2020 12:21:24 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55245 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgITQVU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Sep 2020 12:21:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0U9VT-20_1600618864;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U9VT-20_1600618864)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 00:21:04 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephan Mueller <smueller@chronox.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Colin Ian King <colin.king@canonical.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Gilad Ben-Yossef" <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v7 01/10] crypto: sm3 - export crypto_sm3_final function
Date:   Mon, 21 Sep 2020 00:20:54 +0800
Message-Id: <20200920162103.83197-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
References: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Both crypto_sm3_update and crypto_sm3_finup have been
exported, exporting crypto_sm3_final, to avoid having to
use crypto_sm3_finup(desc, NULL, 0, dgst) to calculate
the hash in some cases.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
---
 crypto/sm3_generic.c | 7 ++++---
 include/crypto/sm3.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/crypto/sm3_generic.c b/crypto/sm3_generic.c
index 3468975215ca..193c4584bd00 100644
--- a/crypto/sm3_generic.c
+++ b/crypto/sm3_generic.c
@@ -149,17 +149,18 @@ int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
 }
 EXPORT_SYMBOL(crypto_sm3_update);
 
-static int sm3_final(struct shash_desc *desc, u8 *out)
+int crypto_sm3_final(struct shash_desc *desc, u8 *out)
 {
 	sm3_base_do_finalize(desc, sm3_generic_block_fn);
 	return sm3_base_finish(desc, out);
 }
+EXPORT_SYMBOL(crypto_sm3_final);
 
 int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *hash)
 {
 	sm3_base_do_update(desc, data, len, sm3_generic_block_fn);
-	return sm3_final(desc, hash);
+	return crypto_sm3_final(desc, hash);
 }
 EXPORT_SYMBOL(crypto_sm3_finup);
 
@@ -167,7 +168,7 @@ static struct shash_alg sm3_alg = {
 	.digestsize	=	SM3_DIGEST_SIZE,
 	.init		=	sm3_base_init,
 	.update		=	crypto_sm3_update,
-	.final		=	sm3_final,
+	.final		=	crypto_sm3_final,
 	.finup		=	crypto_sm3_finup,
 	.descsize	=	sizeof(struct sm3_state),
 	.base		=	{
diff --git a/include/crypto/sm3.h b/include/crypto/sm3.h
index 1438942dc773..42ea21289ba9 100644
--- a/include/crypto/sm3.h
+++ b/include/crypto/sm3.h
@@ -35,6 +35,8 @@ struct shash_desc;
 extern int crypto_sm3_update(struct shash_desc *desc, const u8 *data,
 			      unsigned int len);
 
+extern int crypto_sm3_final(struct shash_desc *desc, u8 *out);
+
 extern int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
 			     unsigned int len, u8 *hash);
 #endif
-- 
2.19.1.3.ge56e4f7

