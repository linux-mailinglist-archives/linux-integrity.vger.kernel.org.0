Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC23C438A
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhGLFrw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 01:47:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34428 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhGLFrv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 01:47:51 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CDB2E72C8B4;
        Mon, 12 Jul 2021 08:45:02 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id ACC024A46ED;
        Mon, 12 Jul 2021 08:45:02 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter0@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v8 1/3] Allow manual setting keyid for signing
Date:   Mon, 12 Jul 2021 08:44:46 +0300
Message-Id: <20210712054448.2471236-2-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <20210712054448.2471236-1-vt@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 src/evmctl.c           | 20 ++++++++++++++++++++
 src/imaevm.h           |  1 +
 src/libimaevm.c        |  6 +++++-
 tests/sign_verify.test |  1 +
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git README README
index 321045d..20fa009 100644
--- README
+++ README
@@ -48,6 +48,7 @@ OPTIONS
       --xattr-user   store xattrs in user namespace (for testing purposes)
       --rsa          use RSA key type and signing scheme v1
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
+      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)
   -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
   -r, --recursive    recurse into directories (sign)
diff --git src/evmctl.c src/evmctl.c
index 7a6f202..f272250 100644
--- src/evmctl.c
+++ src/evmctl.c
@@ -2514,6 +2514,7 @@ static void usage(void)
 		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
 		"      --rsa          use RSA key type and signing scheme v1\n"
 		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
+		"      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)\n"
 		"  -o, --portable     generate portable EVM signatures\n"
 		"  -p, --pass         password for encrypted signing key\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
@@ -2594,6 +2595,7 @@ static struct option opts[] = {
 	{"ignore-violations", 0, 0, 141},
 	{"pcrs", 1, 0, 142},
 	{"verify-bank", 2, 0, 143},
+	{"keyid", 1, 0, 144},
 	{}
 
 };
@@ -2638,6 +2640,8 @@ int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
 	ENGINE *eng = NULL;
+	unsigned long keyid;
+	char *eptr;
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
@@ -2785,6 +2789,22 @@ int main(int argc, char *argv[])
 		case 143:
 			verify_bank = optarg;
 			break;
+		case 144:
+			errno = 0;
+			keyid = strtoul(optarg, &eptr, 16);
+			/*
+			 * ULONG_MAX is error from strtoul(3),
+			 * UINT_MAX is `imaevm_params.keyid' maximum value,
+			 * 0 is reserved for keyid being unset.
+			 */
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
diff --git src/imaevm.h src/imaevm.h
index 4503919..fe244f1 100644
--- src/imaevm.h
+++ src/imaevm.h
@@ -196,6 +196,7 @@ struct libimaevm_params {
 	const char *hash_algo;
 	const char *keyfile;
 	const char *keypass;
+	uint32_t keyid;		/* keyid overriding value, unless 0. (Host order.) */
 };
 
 struct RSA_ASN1_template {
diff --git src/libimaevm.c src/libimaevm.c
index 2856270..c59082b 100644
--- src/libimaevm.c
+++ src/libimaevm.c
@@ -45,6 +45,7 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <asm/byteorder.h>
+#include <arpa/inet.h>
 #include <unistd.h>
 #include <dirent.h>
 #include <string.h>
@@ -929,7 +930,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	calc_keyid_v2(&keyid, name, pkey);
+	if (imaevm_params.keyid)
+		keyid = htonl(imaevm_params.keyid);
+	else
+		calc_keyid_v2(&keyid, name, pkey);
 	hdr->keyid = keyid;
 
 	st = "EVP_PKEY_CTX_new";
diff --git tests/sign_verify.test tests/sign_verify.test
index 3d7aa51..eccf5fa 100755
--- tests/sign_verify.test
+++ tests/sign_verify.test
@@ -365,6 +365,7 @@ sign_verify  rsa1024  sha256  0x0301 --rsa
 sign_verify  rsa1024  md5     0x030201:K:0080
 sign_verify  rsa1024  sha1    0x030202:K:0080
 sign_verify  rsa1024  sha224  0x030207:K:0080
+expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
 sign_verify  rsa1024  sha256  0x030204:K:0080
   try_different_keys
   try_different_sigs
-- 
2.29.3

