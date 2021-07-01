Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256BF3B8BB0
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Jul 2021 03:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbhGABQ1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 21:16:27 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48332 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbhGABQP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 21:16:15 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9A22972C8B4;
        Thu,  1 Jul 2021 04:13:44 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9B4A94A46EE;
        Thu,  1 Jul 2021 04:13:43 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 2/3] ima-evm-utils: Allow manual setting keyid from a cert file
Date:   Thu,  1 Jul 2021 04:13:22 +0300
Message-Id: <20210701011323.2377251-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210701011323.2377251-1-vt@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow user to specify `--keyid-from-cert cert.pem' to extract keyid from
SKID of the certificate file. PEM or DER format is auto-detected.

This commit creates ABI change for libimaevm, due to adding new function
ima_read_keyid(). Newer clients cannot work with older libimaevm.
Together with previous commit it creates backward-incompatible ABI
change, thus soname should be incremented on release.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 README                 |   2 +
 src/evmctl.c           |  14 +++++++
 src/imaevm.h           |   1 +
 src/libimaevm.c        | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/sign_verify.test |   1 +
 5 files changed, 125 insertions(+)

diff --git a/README b/README
index 20fa009..a130519 100644
--- a/README
+++ b/README
@@ -49,6 +49,8 @@ OPTIONS
       --rsa          use RSA key type and signing scheme v1
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
       --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)
+      --keyid-from-cert file
+                     read keyid value from SKID of a x509 cert file
   -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
   -r, --recursive    recurse into directories (sign)
diff --git a/src/evmctl.c b/src/evmctl.c
index f272250..78be387 100644
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
@@ -2515,6 +2518,8 @@ static void usage(void)
 		"      --rsa          use RSA key type and signing scheme v1\n"
 		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
 		"      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)\n"
+		"      --keyid-from-cert file\n"
+		"                     read keyid value from SKID of a x509 cert file\n"
 		"  -o, --portable     generate portable EVM signatures\n"
 		"  -p, --pass         password for encrypted signing key\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
@@ -2596,6 +2601,7 @@ static struct option opts[] = {
 	{"pcrs", 1, 0, 142},
 	{"verify-bank", 2, 0, 143},
 	{"keyid", 1, 0, 144},
+	{"keyid-from-cert", 1, 0, 145},
 	{}
 
 };
@@ -2805,6 +2811,14 @@ int main(int argc, char *argv[])
 			}
 			imaevm_params.keyid = keyid;
 			break;
+		case 145:
+			keyid = imaevm_read_keyid(optarg);
+			if (keyid == 0) {
+				log_err("Error reading keyid.\n");
+				exit(1);
+			}
+			imaevm_params.keyid = keyid;
+			break;
 		case '?':
 			exit(1);
 			break;
diff --git a/src/imaevm.h b/src/imaevm.h
index fe244f1..491f136 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -219,6 +219,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
 void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
 int key2bin(RSA *key, unsigned char *pub);
+uint32_t imaevm_read_keyid(const char *certfile);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index e8e0d0e..c8a320e 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -57,6 +57,7 @@
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
+#include <openssl/x509v3.h>
 #include <openssl/err.h>
 
 #include "imaevm.h"
@@ -745,6 +746,112 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
 	X509_PUBKEY_free(pk);
 }
 
+/**
+ * extract_keyid - extract keyid from x509 SKID
+ * @keyid_be:	output 32-bit keyid in network order (BE);
+ * @x:		input x509 cert;
+ * @infile:	input filename for logging;
+ * Return:	0 on success, keyid_be is written;
+ *		-1 on error, keyid_be is not written, error logged.
+ */
+static int extract_keyid(uint32_t *keyid_be, X509 *x, const char *infile)
+{
+	uint32_t keyid_tmp; /* BE */
+	const ASN1_OCTET_STRING *skid;
+	int skid_len;
+
+	if (!(skid = X509_get0_subject_key_id(x))) {
+		log_err("read keyid: %s: SKID not found\n", infile);
+		goto err_free;
+	}
+	skid_len = ASN1_STRING_length(skid);
+	if (skid_len < sizeof(keyid_tmp)) {
+		log_err("read keyid: %s: SKID too short (len %d)\n", infile,
+			skid_len);
+		goto err_free;
+	}
+	memcpy(&keyid_tmp, ASN1_STRING_get0_data(skid) + skid_len
+	       - sizeof(keyid_tmp), sizeof(keyid_tmp));
+	log_info("keyid %04x (from %s)\n", ntohl(keyid_tmp), infile);
+	memcpy(keyid_be, &keyid_tmp, sizeof(*keyid_be));
+	return 0;
+
+err_free:
+	X509_free(x);
+	return -1;
+}
+
+/**
+ * read_cert() - Read x509 certificate
+ * @certfile:	Input filename.
+ * @try_der:	true:  try to read in DER from if there is no PEM,
+ *		       cert is considered mandatory and error will be issued
+ *		       if there is no cert;
+ *		false: only try to read in PEM form, cert is considered
+ *		       optional.
+ * Return:	X509 cert or NULL.
+ */
+static X509 *read_cert(const char *certfile, int try_der)
+{
+	X509 *x = NULL;
+	FILE *fp;
+
+	if (!(fp = fopen(certfile, "r"))) {
+		log_err("Cannot open %s: %s\n", certfile, strerror(errno));
+		return NULL;
+	}
+	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
+		if (ERR_GET_REASON(ERR_peek_last_error()) == PEM_R_NO_START_LINE) {
+			ERR_clear_error();
+			if (try_der) {
+				rewind(fp);
+				d2i_X509_fp(fp, &x);
+			} else {
+				/*
+				 * Cert is optional and there is just no PEM
+				 * header, then issue debug message and stop
+				 * trying.
+				 */
+				log_debug("%s: x509 certificate not found\n",
+					  certfile);
+				fclose(fp);
+				return NULL;
+			}
+		}
+	}
+	fclose(fp);
+	if (!x) {
+		ERR_print_errors_fp(stderr);
+		log_err("read keyid: %s: Error reading x509 certificate\n",
+			certfile);
+	}
+	return x;
+}
+
+/**
+ * imaevm_read_keyid() - Read 32-bit keyid from the cert file
+ * @certfile:	File with certificate in PEM or DER form.
+ *
+ * Try to read keyid from Subject Key Identifier (SKID) of x509 certificate.
+ * Autodetect if cert is in PEM (tried first) or DER encoding.
+ *
+ * Return: 0 on error, logged error message;
+ *         32-bit keyid in host order.
+ */
+uint32_t imaevm_read_keyid(const char *certfile)
+{
+	uint32_t keyid_be = 0;
+	X509 *x;
+
+	/* true: to load in DER form too. */
+	if (!(x = read_cert(certfile, true)))
+		return -1;
+	extract_keyid(&keyid_be, x, certfile);
+	/* On error keyid_be will not be set, returning 0. */
+	X509_free(x);
+	return ntohl(keyid_be);
+}
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index eccf5fa..1fdd786 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -366,6 +366,7 @@ sign_verify  rsa1024  md5     0x030201:K:0080
 sign_verify  rsa1024  sha1    0x030202:K:0080
 sign_verify  rsa1024  sha224  0x030207:K:0080
 expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
+expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204:K:0080 OPTS=--keyid-from-cert=test-rsa1024.cer
 sign_verify  rsa1024  sha256  0x030204:K:0080
   try_different_keys
   try_different_sigs
-- 
2.11.0

