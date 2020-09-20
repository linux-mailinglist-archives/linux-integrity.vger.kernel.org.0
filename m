Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65DF2715E2
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Sep 2020 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgITQWO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Sep 2020 12:22:14 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47448 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgITQWA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Sep 2020 12:22:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0U9VME2p_1600618867;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U9VME2p_1600618867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 00:21:07 +0800
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
Subject: [PATCH v7 06/10] crypto: testmgr - Fix potential memory leak in test_akcipher_one()
Date:   Mon, 21 Sep 2020 00:20:59 +0800
Message-Id: <20200920162103.83197-7-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
References: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When the 'key' allocation fails, the 'req' will not be released,
which will cause memory leakage on this path. This patch adds a
'free_req' tag used to solve this problem, and two new err values
are added to reflect the real reason of the error.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/testmgr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index cd002a030af5..ed8e29efe280 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -3954,7 +3954,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 	key = kmalloc(vecs->key_len + sizeof(u32) * 2 + vecs->param_len,
 		      GFP_KERNEL);
 	if (!key)
-		goto free_xbuf;
+		goto free_req;
 	memcpy(key, vecs->key, vecs->key_len);
 	ptr = key + vecs->key_len;
 	ptr = test_pack_u32(ptr, vecs->algo);
@@ -3966,7 +3966,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 	else
 		err = crypto_akcipher_set_priv_key(tfm, key, vecs->key_len);
 	if (err)
-		goto free_req;
+		goto free_key;
 
 	/*
 	 * First run test which do not require a private key, such as
@@ -3976,7 +3976,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 	out_len_max = crypto_akcipher_maxsize(tfm);
 	outbuf_enc = kzalloc(out_len_max, GFP_KERNEL);
 	if (!outbuf_enc)
-		goto free_req;
+		goto free_key;
 
 	if (!vecs->siggen_sigver_test) {
 		m = vecs->m;
@@ -3995,6 +3995,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		op = "verify";
 	}
 
+	err = -E2BIG;
 	if (WARN_ON(m_size > PAGE_SIZE))
 		goto free_all;
 	memcpy(xbuf[0], m, m_size);
@@ -4061,6 +4062,7 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 		c_size = req->dst_len;
 	}
 
+	err = -E2BIG;
 	op = vecs->siggen_sigver_test ? "sign" : "decrypt";
 	if (WARN_ON(c_size > PAGE_SIZE))
 		goto free_all;
@@ -4097,9 +4099,10 @@ static int test_akcipher_one(struct crypto_akcipher *tfm,
 free_all:
 	kfree(outbuf_dec);
 	kfree(outbuf_enc);
+free_key:
+	kfree(key);
 free_req:
 	akcipher_request_free(req);
-	kfree(key);
 free_xbuf:
 	testmgr_free_buf(xbuf);
 	return err;
-- 
2.19.1.3.ge56e4f7

