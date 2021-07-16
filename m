Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51723CB984
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhGPPT2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 11:19:28 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57430 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbhGPPT1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 11:19:27 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DE63172C8B4;
        Fri, 16 Jul 2021 18:16:30 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id A6C324A46E9;
        Fri, 16 Jul 2021 18:16:30 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils v9 3/3] Read keyid from the cert appended to the key file
Date:   Fri, 16 Jul 2021 18:16:02 +0300
Message-Id: <20210716151602.3575106-4-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <20210716151602.3575106-1-vt@altlinux.org>
References: <20210716151602.3575106-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow to have certificate appended to the private key of `--key'
specified (PEM) file (for v2 signing) to facilitate reading of keyid
from the associated cert. This will allow users to have private and
public key as a single file and avoid the need of manually specifying
keyid. There is no check that public key form the cert matches
associated private key.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 README                 |  3 +++
 src/libimaevm.c        |  8 ++++++--
 tests/gen-keys.sh      | 31 +++++++++++++++++++++++++------
 tests/sign_verify.test |  1 +
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/README b/README
index a130519..23e7d17 100644
--- a/README
+++ b/README
@@ -128,6 +128,9 @@ for signing and importing the key.
 Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
 in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
 
+For v2 signatures x509 certificate (containing the public key) could be appended to the
+private key (they both are in PEM format) to automatically extract keyid from its Subject
+Key Identifier (SKID).
 
 Integrity keyrings
 ----------------
diff --git a/src/libimaevm.c b/src/libimaevm.c
index ce1e276..7d5cbe0 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -1046,8 +1046,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 
 	if (imaevm_params.keyid)
 		keyid = htonl(imaevm_params.keyid);
-	else
-		calc_keyid_v2(&keyid, name, pkey);
+	else {
+		int keyid_read_failed = read_keyid_from_cert(&keyid, keyfile, false);
+
+		if (keyid_read_failed)
+			calc_keyid_v2(&keyid, name, pkey);
+	}
 	hdr->keyid = keyid;
 
 	st = "EVP_PKEY_CTX_new";
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 46130cf..d2c2f80 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -20,13 +20,14 @@ PATH=../src:$PATH
 type openssl
 
 log() {
-  echo - "$*"
+  echo >&2 - "$*"
   eval "$@"
 }
 
 if [ "$1" = clean ]; then
   rm -f test-ca.conf
-elif [ "$1" = force ] || [ ! -e test-ca.conf ]; then
+elif [ "$1" = force ] || [ ! -e test-ca.conf ] \
+	|| [ gen-keys.sh -nt test-ca.conf ]; then
 cat > test-ca.conf <<- EOF
 	[ req ]
 	distinguished_name = req_distinguished_name
@@ -43,26 +44,44 @@ cat > test-ca.conf <<- EOF
 	basicConstraints=CA:TRUE
 	subjectKeyIdentifier=hash
 	authorityKeyIdentifier=keyid:always,issuer
+
+	[ skid ]
+	basicConstraints=CA:TRUE
+	subjectKeyIdentifier=12345678
+	authorityKeyIdentifier=keyid:always,issuer
 EOF
 fi
 
 # RSA
 # Second key will be used for wrong key tests.
-for m in 1024 2048; do
-  if [ "$1" = clean ] || [ "$1" = force ]; then
+for m in 1024 1024_skid 2048; do
+  if [ "$1" = clean ] || [ "$1" = force ] \
+	  || [ gen-keys.sh -nt test-rsa$m.key ]; then
     rm -f test-rsa$m.cer test-rsa$m.key test-rsa$m.pub
   fi
   if [ "$1" = clean ]; then
     continue
   fi
+  if [ -z "${m%%*_*}" ]; then
+    # Add named extension.
+    bits=${m%_*}
+    ext="-extensions ${m#*_}"
+  else
+    bits=$m
+    ext=
+  fi
   if [ ! -e test-rsa$m.key ]; then
-    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 \
+    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 $ext \
       -config test-ca.conf \
-      -newkey rsa:$m \
+      -newkey rsa:$bits \
       -out test-rsa$m.cer -outform DER \
       -keyout test-rsa$m.key
     # for v1 signatures
     log openssl pkey -in test-rsa$m.key -out test-rsa$m.pub -pubout
+    if [ $m = 1024_skid ]; then
+      # Create combined key+cert.
+      log openssl x509 -inform DER -in test-rsa$m.cer >> test-rsa$m.key
+    fi
   fi
 done
 
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 1fdd786..df4304a 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -367,6 +367,7 @@ sign_verify  rsa1024  sha1    0x030202:K:0080
 sign_verify  rsa1024  sha224  0x030207:K:0080
 expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
 expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204:K:0080 OPTS=--keyid-from-cert=test-rsa1024.cer
+expect_pass check_sign TYPE=ima KEY=rsa1024_skid ALG=sha256 PREFIX=0x030204123456780080
 sign_verify  rsa1024  sha256  0x030204:K:0080
   try_different_keys
   try_different_sigs
-- 
2.29.3

