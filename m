Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07F739127F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 May 2021 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhEZInr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 May 2021 04:43:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39348 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232097AbhEZInr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 May 2021 04:43:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ua9lZQc_1622018535;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ua9lZQc_1622018535)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 16:42:15 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v3] ima-evm-utils: Support SM2 algorithm for sign and verify
Date:   Wed, 26 May 2021 16:42:15 +0800
Message-Id: <20210526084215.55118-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The combination of SM2 and SM3 algorithms has been implemented in the
kernel. At present, the ima-evm-utils signature tool does not support
this combination of algorithms. Because in the current version of
OpenSSL 1.1.1, the SM2 algorithm and the public key using the EC
algorithm share the same ID 'EVP_PKEY_EC', and the specific algorithm
can only be distinguished by the curve name used. This patch supports
this feature.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c        | 20 ++++++++++++++++++++
 tests/gen-keys.sh      | 22 ++++++++++++++++++++++
 tests/ima_hash.test    |  3 +--
 tests/sign_verify.test |  2 ++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..589dd09 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -518,6 +518,16 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		return -1;
 	}
 
+#ifdef EVP_PKEY_SM2
+	/* If EC key are used, check whether it is SM2 key */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
+		if (curve == NID_sm2)
+			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
+	}
+#endif
+
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
 		goto err;
@@ -932,6 +942,16 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
+#ifdef EVP_PKEY_SM2
+	/* If EC key are used, check whether it is SM2 key */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
+		if (curve == NID_sm2)
+			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
+	}
+#endif
+
 	calc_keyid_v2(&keyid, name, pkey);
 	hdr->keyid = keyid;
 
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 46130cf..a75dc2e 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -112,6 +112,28 @@ for m in \
     fi
 done
 
+# SM2
+for curve in sm2; do
+  if [ "$1" = clean ] || [ "$1" = force ]; then
+    rm -f test-$curve.cer test-$curve.key test-$curve.pub
+  fi
+  if [ "$1" = clean ]; then
+    continue
+  fi
+  if [ ! -e test-$curve.key ]; then
+    log openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 \
+      -sm3 -sigopt "distid:1234567812345678" \
+      -config test-ca.conf \
+      -copy_extensions copyall \
+      -newkey $curve \
+      -out test-$curve.cer -outform DER \
+      -keyout test-$curve.key
+    if [ -s test-$curve.key ]; then
+      log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
+    fi
+  fi
+done
+
 # This script leaves test-ca.conf, *.cer, *.pub, *.key files for sing/verify tests.
 # They are never deleted except by `make distclean'.
 
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
index 8d66e59..46de4c9 100755
--- a/tests/ima_hash.test
+++ b/tests/ima_hash.test
@@ -70,8 +70,7 @@ expect_pass check  sha256     0x0404 e3b0c44298fc1c149afbf4c8996fb92427ae41e4649
 expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b
 expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
 expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
-expect_fail check  sm3        0x01
-expect_fail check  sm3-256    0x01
+expect_pass check  sm3        0x01 1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
 _enable_gost_engine
 expect_pass check  md_gost12_256 0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
 expect_pass check  streebog256   0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 3d7aa51..7ad2d96 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -387,6 +387,8 @@ sign_verify  prime256v1 sha256 0x030204:K:004[345678]
 sign_verify  prime256v1 sha384 0x030205:K:004[345678]
 sign_verify  prime256v1 sha512 0x030206:K:004[345678]
 
+sign_verify  sm2        sm3    0x030211:K:004[345678]
+
 # Test v2 signatures with EC-RDSA
 _enable_gost_engine
 sign_verify  gost2012_256-A md_gost12_256 0x030212:K:0040
-- 
2.19.1.3.ge56e4f7

