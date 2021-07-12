Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69A3C438B
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 07:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhGLFr7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 01:47:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34600 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGLFr6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 01:47:58 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D63A872C8B4;
        Mon, 12 Jul 2021 08:45:09 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id C0B984A46ED;
        Mon, 12 Jul 2021 08:45:09 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils v8 2/3] Allow manual setting keyid from a cert file
Date:   Mon, 12 Jul 2021 08:44:47 +0300
Message-Id: <20210712054448.2471236-3-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <20210712054448.2471236-1-vt@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
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
 src/evmctl.c           |  14 +++++
 src/imaevm.h           |   1 +
 src/libimaevm.c        | 114 +++++++++++++++++++++++++++++++++++++++++
 tests/sign_verify.test |   1 +
 5 files changed, 132 insertions(+)

diff --git README README
index 20fa009..a130519 100644
--- README
+++ README
@@ -49,6 +49,8 @@ OPTIONS
       --rsa          use RSA key type and signing scheme v1
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
       --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)
+      --keyid-from-cert file
+                     read keyid value from SKID of a x509 cert file
   -o, --portable     generate portable EVM signatures
   -p, --pass         password for encrypted signing key
   -r, --recursive    recurse into directories (sign)
diff --git src/evmctl.c src/evmctl.c
index f272250..78be387 100644
--- src/evmctl.c
+++ src/evmctl.c
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
diff --git src/imaevm.h src/imaevm.h
index fe244f1..491f136 100644
--- src/imaevm.h
+++ src/imaevm.h
@@ -219,6 +219,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
 void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
 int key2bin(RSA *key, unsigned char *pub);
+uint32_t imaevm_read_keyid(const char *certfile);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
diff --git src/libimaevm.c src/libimaevm.c
index c59082b..ce1e276 100644
--- src/libimaevm.c
+++ src/libimaevm.c
@@ -53,10 +53,12 @@
 #include <assert.h>
 #include <ctype.h>
 
+#include <openssl/asn1.h>
 #include <openssl/crypto.h>
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
+#include <openssl/x509v3.h>
 #include <openssl/err.h>
 
 #include "imaevm.h"
@@ -745,6 +747,118 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
 	X509_PUBKEY_free(pk);
 }
 
+/*
+ * Extract SKID from x509 in openssl portable way.
+ */
+static const unsigned char *x509_get_skid(X509 *x, int *len)
+{
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	ASN1_STRING *skid;
+
+	/*
+	 * This will cache extensions.
+	 * OpenSSL uses this method itself.
+	 */
+	if (X509_check_purpose(x, -1, -1) != 1)
+		return NULL;
+	skid = x->skid;
+#else
+	const ASN1_OCTET_STRING *skid = X509_get0_subject_key_id(x);
+#endif
+	if (len)
+		*len = ASN1_STRING_length(skid);
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	return ASN1_STRING_data(x->skid);
+#else
+	return ASN1_STRING_get0_data(skid);
+#endif
+}
+
+/*
+ * read_keyid_from_cert() - Read keyid from SKID from x509 certificate file
+ * @keyid_be:	Output 32-bit keyid in network order (BE);
+ * @certfile:	Input filename.
+ * @try_der:	true:  try to read in DER from if there is no PEM,
+ *		       cert is considered mandatory and error will be issued
+ *		       if there is no cert;
+ *		false: only try to read in PEM form, cert is considered
+ *		       optional.
+ * Return:	0 on success, -1 on error.
+ */
+static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile, int try_der)
+{
+	X509 *x = NULL;
+	FILE *fp;
+	const unsigned char *skid;
+	int skid_len;
+
+	if (!(fp = fopen(certfile, "r"))) {
+		log_err("Cannot open %s: %s\n", certfile, strerror(errno));
+		return -1;
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
+				return -1;
+			}
+		}
+	}
+	fclose(fp);
+	if (!x) {
+		ERR_print_errors_fp(stderr);
+		log_err("read keyid: %s: Error reading x509 certificate\n",
+			certfile);
+	}
+
+	if (!(skid = x509_get_skid(x, &skid_len))) {
+		log_err("read keyid: %s: SKID not found\n", certfile);
+		goto err_free;
+	}
+	if (skid_len < sizeof(*keyid_be)) {
+		log_err("read keyid: %s: SKID too short (len %d)\n", certfile,
+			skid_len);
+		goto err_free;
+	}
+	memcpy(keyid_be, skid + skid_len - sizeof(*keyid_be), sizeof(*keyid_be));
+	log_info("keyid %04x (from %s)\n", ntohl(*keyid_be), certfile);
+	X509_free(x);
+	return 0;
+
+err_free:
+	X509_free(x);
+	return -1;
+}
+
+/*
+ * imaevm_read_keyid() - Read 32-bit keyid from the cert file
+ * @certfile:	File with certificate in PEM or DER form.
+ *
+ * Try to read keyid from Subject Key Identifier (SKID) of x509 certificate.
+ * Autodetect if cert is in PEM (tried first) or DER encoding.
+ *
+ * Return: 0 on error or 32-bit keyid in host order otherwise.
+ */
+uint32_t imaevm_read_keyid(const char *certfile)
+{
+	uint32_t keyid_be = 0;
+
+	read_keyid_from_cert(&keyid_be, certfile, true);
+	/* On error keyid_be will not be set, returning 0. */
+	return ntohl(keyid_be);
+}
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
diff --git tests/sign_verify.test tests/sign_verify.test
index eccf5fa..1fdd786 100755
--- tests/sign_verify.test
+++ tests/sign_verify.test
@@ -366,6 +366,7 @@ sign_verify  rsa1024  md5     0x030201:K:0080
 sign_verify  rsa1024  sha1    0x030202:K:0080
 sign_verify  rsa1024  sha224  0x030207:K:0080
 expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
+expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204:K:0080 OPTS=--keyid-from-cert=test-rsa1024.cer
 sign_verify  rsa1024  sha256  0x030204:K:0080
   try_different_keys
   try_different_sigs
-- 
2.29.3

