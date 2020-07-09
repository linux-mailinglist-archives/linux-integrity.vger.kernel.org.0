Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE08219B34
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGIIk2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 04:40:28 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36098 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgGIIk1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 04:40:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U2BK-9F_1594284020;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U2BK-9F_1594284020)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Jul 2020 16:40:21 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, vt@altlinux.org, gilad@benyossef.com,
        pvanleeuwen@rambus.com, zhang.jia@linux.alibaba.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH v5 5/8] crypto: testmgr - support test with different ciphertext per encryption
Date:   Thu,  9 Jul 2020 16:40:12 +0800
Message-Id: <20200709084015.21886-6-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
References: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some asymmetric algorithms will get different ciphertext after
each encryption, such as SM2, and let testmgr support the testing
of such algorithms.

In struct akcipher_testvec, set c and c_size to be empty, skip
the comparison of the ciphertext, and compare the decrypted
plaintext with m to achieve the test purpose.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/testmgr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 6863f911fcee..0dc94461c437 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4025,7 +4025,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		pr_err("alg: akcipher: %s test failed. err %d\n", op, err);
 		goto free_all;
 	}
-	if (!vecs->siggen_sigver_test) {
+	if (!vecs->siggen_sigver_test && c) {
 		if (req->dst_len != c_size) {
 			pr_err("alg: akcipher: %s test failed. Invalid output len\n",
 			       op);
@@ -4056,6 +4056,11 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		goto free_all;
 	}
 
+	if (!vecs->siggen_sigver_test && !c) {
+		c = outbuf_enc;
+		c_size = req->dst_len;
+	}
+
 	op = vecs->siggen_sigver_test ? "sign" : "decrypt";
 	if (WARN_ON(c_size > PAGE_SIZE))
 		goto free_all;
-- 
2.17.1

