Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB02715E0
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Sep 2020 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgITQVX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Sep 2020 12:21:23 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37975 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgITQVW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Sep 2020 12:21:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0U9VME2v_1600618867;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U9VME2v_1600618867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 00:21:08 +0800
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
Subject: [PATCH v7 07/10] crypto: sm2 - add SM2 test vectors to testmgr
Date:   Mon, 21 Sep 2020 00:21:00 +0800
Message-Id: <20200920162103.83197-8-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
References: <20200920162103.83197-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add testmgr test vectors for SM2 algorithm. These vectors come
from `openssl pkeyutl -sign` and libgcrypt.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
---
 crypto/testmgr.c |  6 +++++
 crypto/testmgr.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index ed8e29efe280..1317a63172d0 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5384,6 +5384,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(sha512_tv_template)
 		}
+	}, {
+		.alg = "sm2",
+		.test = alg_test_akcipher,
+		.suite = {
+			.akcipher = __VECS(sm2_tv_template)
+		}
 	}, {
 		.alg = "sm3",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index b9a2d73d9f8d..8c83811c0e35 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -3792,6 +3792,65 @@ static const struct hash_testvec hmac_streebog512_tv_template[] = {
 	},
 };
 
+/*
+ * SM2 test vectors.
+ */
+static const struct akcipher_testvec sm2_tv_template[] = {
+	{ /* Generated from openssl */
+	.key =
+	"\x04"
+	"\x8e\xa0\x33\x69\x91\x7e\x3d\xec\xad\x8e\xf0\x45\x5e\x13\x3e\x68"
+	"\x5b\x8c\xab\x5c\xc6\xc8\x50\xdf\x91\x00\xe0\x24\x73\x4d\x31\xf2"
+	"\x2e\xc0\xd5\x6b\xee\xda\x98\x93\xec\xd8\x36\xaa\xb9\xcf\x63\x82"
+	"\xef\xa7\x1a\x03\xed\x16\xba\x74\xb8\x8b\xf9\xe5\x70\x39\xa4\x70",
+	.key_len = 65,
+	.param_len = 0,
+	.c =
+	"\x30\x45"
+	"\x02\x20"
+	"\x70\xab\xb6\x7d\xd6\x54\x80\x64\x42\x7e\x2d\x05\x08\x36\xc9\x96"
+	"\x25\xc2\xbb\xff\x08\xe5\x43\x15\x5e\xf3\x06\xd9\x2b\x2f\x0a\x9f"
+	"\x02\x21"
+	"\x00"
+	"\xbf\x21\x5f\x7e\x5d\x3f\x1a\x4d\x8f\x84\xc2\xe9\xa6\x4c\xa4\x18"
+	"\xb2\xb8\x46\xf4\x32\x96\xfa\x57\xc6\x29\xd4\x89\xae\xcc\xda\xdb",
+	.c_size = 71,
+	.algo = OID_SM2_with_SM3,
+	.m =
+	"\x47\xa7\xbf\xd3\xda\xc4\x79\xee\xda\x8b\x4f\xe8\x40\x94\xd4\x32"
+	"\x8f\xf1\xcd\x68\x4d\xbd\x9b\x1d\xe0\xd8\x9a\x5d\xad\x85\x47\x5c",
+	.m_size = 32,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+	{ /* From libgcrypt */
+	.key =
+	"\x04"
+	"\x87\x59\x38\x9a\x34\xaa\xad\x07\xec\xf4\xe0\xc8\xc2\x65\x0a\x44"
+	"\x59\xc8\xd9\x26\xee\x23\x78\x32\x4e\x02\x61\xc5\x25\x38\xcb\x47"
+	"\x75\x28\x10\x6b\x1e\x0b\x7c\x8d\xd5\xff\x29\xa9\xc8\x6a\x89\x06"
+	"\x56\x56\xeb\x33\x15\x4b\xc0\x55\x60\x91\xef\x8a\xc9\xd1\x7d\x78",
+	.key_len = 65,
+	.param_len = 0,
+	.c =
+	"\x30\x44"
+	"\x02\x20"
+	"\xd9\xec\xef\xe8\x5f\xee\x3c\x59\x57\x8e\x5b\xab\xb3\x02\xe1\x42"
+	"\x4b\x67\x2c\x0b\x26\xb6\x51\x2c\x3e\xfc\xc6\x49\xec\xfe\x89\xe5"
+	"\x02\x20"
+	"\x43\x45\xd0\xa5\xff\xe5\x13\x27\x26\xd0\xec\x37\xad\x24\x1e\x9a"
+	"\x71\x9a\xa4\x89\xb0\x7e\x0f\xc4\xbb\x2d\x50\xd0\xe5\x7f\x7a\x68",
+	.c_size = 70,
+	.algo = OID_SM2_with_SM3,
+	.m =
+	"\x11\x22\x33\x44\x55\x66\x77\x88\x99\xaa\xbb\xcc\xdd\xee\xff\x00"
+	"\x12\x34\x56\x78\x9a\xbc\xde\xf0\x12\x34\x56\x78\x9a\xbc\xde\xf0",
+	.m_size = 32,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+};
+
 /* Example vectors below taken from
  * http://www.oscca.gov.cn/UpFile/20101222141857786.pdf
  *
-- 
2.19.1.3.ge56e4f7

