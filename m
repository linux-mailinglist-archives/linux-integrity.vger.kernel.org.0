Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51916374E21
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 05:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhEFDsY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 23:48:24 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:49854 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhEFDsY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 23:48:24 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BCC0172C8B5;
        Thu,  6 May 2021 06:47:25 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9AF774A46E8;
        Thu,  6 May 2021 06:47:25 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 2/3] ima-evm-utils: Allow manual setting keyid from a cert file
Date:   Thu,  6 May 2021 06:47:01 +0300
Message-Id: <20210506034702.216842-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210506034702.216842-1-vt@altlinux.org>
References: <20210506034702.216842-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow user to specify `--keyid @/path/to/cert.pem' to extract keyid from
SKID of the certificate file. PEM or DER format is auto-detected.

`--keyid' option is reused instead of adding a new option (like possible
`--cert') to signify to the user it's only keyid extraction and nothing
more.

This commit creates ABI change for libimaevm, due to adding new function
ima_read_keyid(). Newer clients cannot work with older libimaevm.
Together with previous commit it creates backward-incompatible ABI
change, thus soname should be incremented on release.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 README                 |  1 +
 src/evmctl.c           | 22 ++++++++++---
 src/imaevm.h           |  1 +
 src/libimaevm.c        | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/sign_verify.test |  1 +
 5 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 8cd66e0..0e1f6ba 100644
--- a/README
+++ b/README
@@ -49,6 +49,7 @@ OPTIONS
       --rsa          use RSA key type and signing scheme v1
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
       --keyid val    overwrite signature keyid with a value (for signing)
+                     val is a x509 cert file if prefixed with '@'
   -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
   -r, --recursive    recurse into directories (sign)
diff --git a/src/evmctl.c b/src/evmctl.c
index 8ae5488..46653e1 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -42,6 +42,7 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
+#include <arpa/inet.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -57,12 +58,14 @@
 #include <termios.h>
 #include <assert.h>
 
+#include <openssl/asn1.h>
 #include <openssl/sha.h>
 #include <openssl/pem.h>
 #include <openssl/hmac.h>
 #include <openssl/err.h>
 #include <openssl/rsa.h>
 #include <openssl/engine.h>
+#include <openssl/x509v3.h>
 #include "hash_info.h"
 #include "pcr.h"
 #include "utils.h"
@@ -2447,6 +2450,7 @@ static void usage(void)
 		"      --rsa          use RSA key type and signing scheme v1\n"
 		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
 		"      --keyid val    overwrite signature keyid with a value (for signing)\n"
+		"                     val is a x509 cert file if prefixed with '@'\n"
 		"  -o, --portable     generate portable EVM signatures\n"
 		"  -p, --pass         password for encrypted signing key\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
@@ -2572,7 +2576,6 @@ int main(int argc, char *argv[])
 	int err = 0, c, lind;
 	ENGINE *eng = NULL;
 	unsigned long keyid;
-	char *eptr;
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
@@ -2718,10 +2721,19 @@ int main(int argc, char *argv[])
 			pcrfile[npcrfile++] = optarg;
 			break;
 		case 143:
-			errno = 0;
-			keyid = strtoul(optarg, &eptr, 16);
-			if (errno || eptr - optarg != strlen(optarg) ||
-			    keyid == ULONG_MAX || keyid > UINT_MAX ||
+			if (optarg[0] == '@') {
+				keyid = ima_read_keyid(optarg + 1);
+			} else {
+				char *eptr;
+
+				errno = 0;
+				keyid = strtoul(optarg, &eptr, 16);
+				if (eptr - optarg != strlen(optarg) || errno) {
+					log_err("Invalid keyid value.\n");
+					exit(1);
+				}
+			}
+			if (keyid == ULONG_MAX || keyid > UINT_MAX ||
 			    keyid == 0) {
 				log_err("Invalid keyid value.\n");
 				exit(1);
diff --git a/src/imaevm.h b/src/imaevm.h
index 9f38059..786faae 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -219,6 +219,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
 void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
 int key2bin(RSA *key, unsigned char *pub);
+uint32_t ima_read_keyid(const char *certfile);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 481d29d..ea8ef5e 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -57,6 +57,7 @@
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
+#include <openssl/x509v3.h>
 #include <openssl/err.h>
 
 #include "imaevm.h"
@@ -748,6 +749,94 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
 	X509_PUBKEY_free(pk);
 }
 
+enum keyid_file_type {
+	KEYID_FILE_PEM_KEY = 0,
+	KEYID_FILE_UNK_CERT,
+};
+
+/*
+ * @keyid:	Pointer to 32-bit value in network order, can be unaligned.
+ * @file_type:	KEYID_FILE_PEM_KEY - PEM encoded private key file with possible
+ *		appended x509 cert;
+ *		KEYID_FILE_UNK_CERT - x509 cert file (maybe PEM, maybe DER
+ *		encoded).
+ * Return:	0 on error; 1 on success.
+ */
+static int __read_keyid(uint32_t *keyid, const char *certfile,
+			enum keyid_file_type file_type)
+{
+	uint32_t keyid_raw;
+	const ASN1_OCTET_STRING *skid;
+	int skid_len;
+	X509 *x = NULL;
+	FILE *fp;
+
+	if (!(fp = fopen(certfile, "r"))) {
+		log_err("read keyid: %s: Cannot open: %s\n", certfile,
+			strerror(errno));
+		return 0;
+	}
+	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
+		if (ERR_GET_REASON(ERR_peek_last_error()) == PEM_R_NO_START_LINE) {
+			ERR_clear_error();
+			if (file_type == KEYID_FILE_PEM_KEY) {
+				log_debug("%s: x509 certificate not found\n",
+					  certfile);
+				fclose(fp);
+				return 0;
+			}
+			rewind(fp);
+			d2i_X509_fp(fp, &x);
+		}
+		if (!x) {
+			ERR_print_errors_fp(stderr);
+			log_err("read keyid: %s: Error reading x509 certificate\n",
+				certfile);
+			fclose(fp);
+			return 0;
+		}
+	}
+	fclose(fp);
+
+	if (!(skid = X509_get0_subject_key_id(x))) {
+		log_err("read keyid: %s: SKID not found\n", certfile);
+		goto err_free;
+	}
+	skid_len = ASN1_STRING_length(skid);
+	if (skid_len < sizeof(keyid_raw)) {
+		log_err("read keyid: %s: SKID too short (len %d)\n", certfile,
+			skid_len);
+		goto err_free;
+	}
+	memcpy(&keyid_raw, ASN1_STRING_get0_data(skid) + skid_len
+	       - sizeof(keyid_raw), sizeof(keyid_raw));
+	log_info("keyid %04x (from %s)\n", ntohl(keyid_raw), certfile);
+	memcpy(keyid, &keyid_raw, sizeof(*keyid));
+	return 1;
+
+err_free:
+	X509_free(x);
+	return 0;
+}
+
+/**
+ * ima_read_keyid() - Read 32-bit keyid from the cert file.
+ * @certfile:	File possibly containing certificate in DER/PEM format.
+ *
+ * Try to read keyid from Subject Key Identifier (SKID) of certificate.
+ * Autodetect if cert is in PEM or DER encoding.
+ *
+ * Return: 0 on error;
+ *         32-bit keyid as unsigned integer in host order.
+ */
+uint32_t ima_read_keyid(const char *certfile)
+{
+	uint32_t keyid_raw = 0;
+
+	__read_keyid(&keyid_raw, certfile, KEYID_FILE_UNK_CERT);
+	return ntohl(keyid_raw);
+}
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 2c21812..52ea33a 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -360,6 +360,7 @@ sign_verify  rsa1024  md5     0x030201:K:0080
 sign_verify  rsa1024  sha1    0x030202:K:0080
 sign_verify  rsa1024  sha224  0x030207:K:0080
 expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
+expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204:K:0080 OPTS=--keyid=@test-rsa1024.cer
 sign_verify  rsa1024  sha256  0x030204:K:0080
   try_different_keys
   try_different_sigs
-- 
2.11.0

