Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BED3B8BB1
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jul 2021 03:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhGABQ1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 21:16:27 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48438 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbhGABQX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 21:16:23 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3971D72C8C6;
        Thu,  1 Jul 2021 04:13:52 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id EE0084A46ED;
        Thu,  1 Jul 2021 04:13:51 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 3/3] ima-evm-utils: Read keyid from the cert appended to the key file
Date:   Thu,  1 Jul 2021 04:13:23 +0300
Message-Id: <20210701011323.2377251-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210701011323.2377251-1-vt@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
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
 src/libimaevm.c        | 32 +++++++++++++++++++++++++++++---
 tests/gen-keys.sh      | 25 +++++++++++++++++++++----
 tests/sign_verify.test |  1 +
 4 files changed, 54 insertions(+), 7 deletions(-)

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
index c8a320e..15f702b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -852,6 +852,28 @@ uint32_t imaevm_read_keyid(const char *certfile)
 	return ntohl(keyid_be);
 }
 
+/**
+ * read_keyid_from_key() - Read 32-bit keyid from the key file
+ * @keyid_be:   Pointer to 32-bit value in network order (BE, unaligned).
+ * @keyfile:    PEM file with private key with optionally appended x509 cert.
+ * Return:      0 on success and keyid_be is written;
+ *              -1 on error, logged error message, and keyid_be isn't written.
+ */
+static int read_keyid_from_key(uint32_t *keyid_be, const char *keyfile)
+{
+	X509 *x;
+
+	/* false: to try to read optional PEM cert. */
+	if (!(x = read_cert(keyfile, false)))
+		return -1;
+	if (extract_keyid(keyid_be, x, keyfile)) {
+		X509_free(x);
+		return -1;
+	}
+	X509_free(x);
+	return 0;
+}
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
@@ -1036,10 +1058,14 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	if (imaevm_params.keyid)
+	if (imaevm_params.keyid) {
 		hdr->keyid = htonl(imaevm_params.keyid);
-	else
-		calc_keyid_v2(&hdr->keyid, name, pkey);
+	} else {
+		int keyid_read_failed = read_keyid_from_key(&hdr->keyid, keyfile);
+
+		if (keyid_read_failed)
+			calc_keyid_v2(&hdr->keyid, name, pkey);
+	}
 
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 46130cf..d604c96 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -20,7 +20,7 @@ PATH=../src:$PATH
 type openssl
 
 log() {
-  echo - "$*"
+  echo >&2 - "$*"
   eval "$@"
 }
 
@@ -43,26 +43,43 @@ cat > test-ca.conf <<- EOF
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
+for m in 1024 1024_skid 2048; do
   if [ "$1" = clean ] || [ "$1" = force ]; then
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
2.11.0

