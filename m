Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00F53CB538
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhGPJZe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 05:25:34 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36630 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232743AbhGPJZe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 05:25:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UfxpCpK_1626427357;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UfxpCpK_1626427357)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 17:22:37 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH ima-evm-utils v5] ima-evm-utils: Support SM2/3 algorithm for sign and verify
Date:   Fri, 16 Jul 2021 17:22:37 +0800
Message-Id: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keep in sync with the kernel IMA, IMA signature tool supports SM2/3
algorithm combination. Because in the current version of OpenSSL 1.1.1,
the SM2 algorithm and the public key using the EC algorithm share the
same ID 'EVP_PKEY_EC', and the specific algorithm can only be
distinguished by the curve name used. This patch supports this feature.

Secondly, the openssl 1.1.1 tool does not fully support the signature
of SM2/3 algorithm combination, so the openssl3 tool is used in the
test case, and there is no this problem with directly calling the
openssl 1.1.1 API in evmctl.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 .github/workflows/ci.yml  |  7 +++++++
 .travis.yml               |  8 ++++----
 ci/fedora.sh              |  4 +++-
 src/libimaevm.c           | 20 ++++++++++++++++++++
 tests/gen-keys.sh         | 25 +++++++++++++++++++++++++
 tests/ima_hash.test       |  3 +--
 tests/install-openssl3.sh | 17 +++++++++++++++++
 tests/sign_verify.test    | 10 ++++++++++
 8 files changed, 87 insertions(+), 7 deletions(-)
 create mode 100755 tests/install-openssl3.sh

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 088c041..17407ff 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -17,6 +17,7 @@ jobs:
               ARCH: i386
               TSS: tpm2-tss
               VARIANT: i386
+              OPENSSL3: true
 
           # cross compilation builds
           - container: "debian:stable"
@@ -51,6 +52,7 @@ jobs:
             env:
               CC: clang
               TSS: ibmtss
+              OPENSSL3: true
 
           - container: "opensuse/leap"
             env:
@@ -61,6 +63,7 @@ jobs:
             env:
               CC: gcc
               TSS: ibmtss
+              OPENSSL3: true
 
           - container: "ubuntu:xenial"
             env:
@@ -115,6 +118,7 @@ jobs:
         INSTALL="${INSTALL%%/*}"
         if [ "$VARIANT" ]; then ARCH="$ARCH" ./ci/$INSTALL.$VARIANT.sh; fi
         ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
+        if [ "$OPENSSL3" ]; then ./tests/install-openssl3.sh; fi
 
     - name: Build swtpm
       run: |
@@ -128,5 +132,8 @@ jobs:
     - name: Compiler version
       run: $CC --version
 
+    - name: Default OpenSSL version
+      run: openssl version
+
     - name: Compile
       run: CC="$CC" VARIANT="$VARIANT" ./build.sh
diff --git a/.travis.yml b/.travis.yml
index 7a76273..2dab231 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,7 +9,7 @@ matrix:
     include:
         # 32 bit build
         - os: linux
-          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss
+          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss OPENSSL3=true
           compiler: gcc
 
         # cross compilation builds
@@ -32,7 +32,7 @@ matrix:
 
         # glibc (gcc/clang)
         - os: linux
-          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host"
+          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host" OPENSSL3=true
           compiler: clang
 
         - os: linux
@@ -40,7 +40,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:groovy TSS=ibmtss
+          env: DISTRO=ubuntu:groovy TSS=ibmtss OPENSSL3=true
           compiler: gcc
 
         - os: linux
@@ -97,4 +97,4 @@ before_install:
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
+    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ "$OPENSSL3" ]; then ./tests/install-openssl3.sh; fi && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 2d80915..898d614 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -38,7 +38,9 @@ yum -y install \
 	sudo \
 	vim-common \
 	wget \
-	which
+	which \
+	perl \
+	perl-IPC-Cmd
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6591d20..f18c016 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -447,6 +447,16 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		return -1;
 	}
 
+#if defined(EVP_PKEY_SM2) && OPENSSL_VERSION_NUMBER < 0x30000000
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
@@ -861,6 +871,16 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
+#if defined(EVP_PKEY_SM2) && OPENSSL_VERSION_NUMBER < 0x30000000
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
index 46130cf..dbc1a0d 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -112,6 +112,31 @@ for m in \
     fi
 done
 
+# SM2, If openssl 3.0 is installed, gen SM2 keys using
+if [ -x /opt/openssl3/bin/openssl ]; then
+  (PATH=/opt/openssl3/bin:$PATH LD_LIBRARY_PATH=/opt/openssl3/lib
+  for curve in sm2; do
+    if [ "$1" = clean ] || [ "$1" = force ]; then
+      rm -f test-$curve.cer test-$curve.key test-$curve.pub
+    fi
+    if [ "$1" = clean ]; then
+      continue
+    fi
+    if [ ! -e test-$curve.key ]; then
+      log openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 \
+        -sm3 -sigopt "distid:1234567812345678" \
+        -config test-ca.conf \
+        -copy_extensions copyall \
+        -newkey $curve \
+        -out test-$curve.cer -outform DER \
+        -keyout test-$curve.key
+      if [ -s test-$curve.key ]; then
+        log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
+      fi
+    fi
+  done)
+fi
+
 # This script leaves test-ca.conf, *.cer, *.pub, *.key files for sing/verify tests.
 # They are never deleted except by `make distclean'.
 
diff --git a/tests/ima_hash.test b/tests/ima_hash.test
index 8d66e59..6e0e463 100755
--- a/tests/ima_hash.test
+++ b/tests/ima_hash.test
@@ -70,8 +70,7 @@ expect_pass check  sha256     0x0404 e3b0c44298fc1c149afbf4c8996fb92427ae41e4649
 expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b
 expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
 expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
-expect_fail check  sm3        0x01
-expect_fail check  sm3-256    0x01
+expect_pass check  sm3        0x0411 1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
 _enable_gost_engine
 expect_pass check  md_gost12_256 0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
 expect_pass check  streebog256   0x0412 3f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
diff --git a/tests/install-openssl3.sh b/tests/install-openssl3.sh
new file mode 100755
index 0000000..3fd8842
--- /dev/null
+++ b/tests/install-openssl3.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+set -ex
+
+# The latest version in July 2021
+wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0-beta1.tar.gz
+tar --no-same-owner -xzf openssl-3.0.0-beta1.tar.gz
+cd openssl-openssl-3.0.0-beta1
+
+./Configure --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
+make -j$(nproc)
+# only install apps and library
+sudo make install_sw
+
+cd ..
+rm -rf openssl-3.0.0-beta1.tar.gz
+rm -rf openssl-openssl-3.0.0-beta1
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 3d7aa51..3ea551b 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -199,6 +199,10 @@ check_sign() {
   # This is all we can do for evm.
   [[ "$TYPE" =~ evm ]] && return "$OK"
 
+  # When using the SM2/3 algorithm, the openssl tool uses USERID for verify,
+  # which is incompatible with calling API directly, so skip it.
+  [[ "$ALG" == sm3 ]] && return "$OK"
+
   # Extract signature to a file
   _extract_xattr "$FILE" "$(_xattr "$TYPE")" "$FILE.sig2" "$PREFIX"
 
@@ -387,6 +391,12 @@ sign_verify  prime256v1 sha256 0x030204:K:004[345678]
 sign_verify  prime256v1 sha384 0x030205:K:004[345678]
 sign_verify  prime256v1 sha512 0x030206:K:004[345678]
 
+# If openssl 3.0 is installed, test the SM2/3 algorithm combination
+if [ -x /opt/openssl3/bin/openssl ]; then
+  PATH=/opt/openssl3/bin:$PATH LD_LIBRARY_PATH=/opt/openssl3/lib \
+    sign_verify  sm2    sm3    0x030211:K:004[345678]
+fi
+
 # Test v2 signatures with EC-RDSA
 _enable_gost_engine
 sign_verify  gost2012_256-A md_gost12_256 0x030212:K:0040
-- 
2.19.1.3.ge56e4f7

