Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A17373511
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhEEGu0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 02:50:26 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59556 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhEEGu0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 02:50:26 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1CA7A72C8B5;
        Wed,  5 May 2021 09:49:29 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id F0E214A46E8;
        Wed,  5 May 2021 09:49:28 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 1/3] ima-evm-utils: Allow manual setting keyid for signing
Date:   Wed,  5 May 2021 09:48:41 +0300
Message-Id: <20210505064843.111900-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210505064843.111900-1-vt@altlinux.org>
References: <20210505064843.111900-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow user to set signature's keyid using `--keyid' option. Keyid should
correspond to SKID in certificate, when keyid is calculated using SHA-1
in libimaevm it may mismatch keyid extracted by the kernel from SKID of
certificate (the way public key is presented to the kernel), thus making
signatures not verifiable. This may happen when certificate is using non
SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
As a last resort user may specify arbitrary keyid using the new option.

This commit creates ABI change for libimaevm, because of adding
additional parameter to imaevm_params - newer libimaevm cannot work
with older clients.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Reported-by: Elvira Khabirova <lineprinter0@gmail.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README                 |  1 +
 src/evmctl.c           | 15 +++++++++++++++
 src/imaevm.h           |  1 +
 src/libimaevm.c        |  8 +++++---
 tests/sign_verify.test |  1 +
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 321045d..8cd66e0 100644
--- a/README
+++ b/README
@@ -48,6 +48,7 @@ OPTIONS
       --xattr-user   store xattrs in user namespace (for testing purposes)
       --rsa          use RSA key type and signing scheme v1
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
+      --keyid val    overwrite signature keyid with a value (for signing)
   -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
   -r, --recursive    recurse into directories (sign)
diff --git a/src/evmctl.c b/src/evmctl.c
index 1815f55..8ae5488 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2446,6 +2446,7 @@ static void usage(void)
 		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
 		"      --rsa          use RSA key type and signing scheme v1\n"
 		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
+		"      --keyid val    overwrite signature keyid with a value (for signing)\n"
 		"  -o, --portable     generate portable EVM signatures\n"
 		"  -p, --pass         password for encrypted signing key\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
@@ -2525,6 +2526,7 @@ static struct option opts[] = {
 	{"xattr-user", 0, 0, 140},
 	{"ignore-violations", 0, 0, 141},
 	{"pcrs", 1, 0, 142},
+	{"keyid", 1, 0, 143},
 	{}
 
 };
@@ -2569,6 +2571,8 @@ int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
 	ENGINE *eng = NULL;
+	unsigned long keyid;
+	char *eptr;
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
@@ -2713,6 +2717,17 @@ int main(int argc, char *argv[])
 			}
 			pcrfile[npcrfile++] = optarg;
 			break;
+		case 143:
+			errno = 0;
+			keyid = strtoul(optarg, &eptr, 16);
+			if (errno || eptr - optarg != strlen(optarg) ||
+			    keyid == ULONG_MAX || keyid > UINT_MAX ||
+			    keyid == 0) {
+				log_err("Invalid keyid value.\n");
+				exit(1);
+			}
+			imaevm_params.keyid = keyid;
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/src/imaevm.h b/src/imaevm.h
index 4503919..9f38059 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -196,6 +196,7 @@ struct libimaevm_params {
 	const char *hash_algo;
 	const char *keyfile;
 	const char *keypass;
+	uint32_t keyid;		/* keyid overriding value, unless 0. */
 };
 
 struct RSA_ASN1_template {
diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..481d29d 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -45,6 +45,7 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <asm/byteorder.h>
+#include <arpa/inet.h>
 #include <unistd.h>
 #include <dirent.h>
 #include <string.h>
@@ -894,7 +895,6 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	const EVP_MD *md;
 	size_t sigsize;
 	const char *st;
-	uint32_t keyid;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -932,8 +932,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	calc_keyid_v2(&keyid, name, pkey);
-	hdr->keyid = keyid;
+	if (imaevm_params.keyid)
+		hdr->keyid = htonl(imaevm_params.keyid);
+	else
+		calc_keyid_v2(&hdr->keyid, name, pkey);
 
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 288e133..2c21812 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -359,6 +359,7 @@ sign_verify  rsa1024  sha256  0x0301 --rsa
 sign_verify  rsa1024  md5     0x030201:K:0080
 sign_verify  rsa1024  sha1    0x030202:K:0080
 sign_verify  rsa1024  sha224  0x030207:K:0080
+expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
 sign_verify  rsa1024  sha256  0x030204:K:0080
   try_different_keys
   try_different_sigs
-- 
2.11.0

