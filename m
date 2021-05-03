Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA33723A1
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhECXgF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 19:36:05 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57822 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhECXgF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 19:36:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A23C072C8BA;
        Tue,  4 May 2021 02:35:10 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id E8BFC4A46E8;
        Tue,  4 May 2021 02:35:09 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima-evm-utils: Allow manual setting keyid from a cert file
Date:   Tue,  4 May 2021 02:34:52 +0300
Message-Id: <20210503233452.4048462-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210503233452.4048462-1-vt@altlinux.org>
References: <20210503233452.4048462-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

User can specify `--keyid @/path/to/cert.pem' to extract keyid from
SKID of the certificate file. PEM or DER format is auto-detected.

I decided to reuse `--keyid' option instead of adding a new option (like
`--cert') to signify to the user it's just keyid extraction and nothing
more.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 README                 |  1 +
 src/evmctl.c           | 81 ++++++++++++++++++++++++++++++++++++++++++++++----
 tests/sign_verify.test |  1 +
 3 files changed, 78 insertions(+), 5 deletions(-)

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
index 7983299..434e1b6 100644
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
@@ -2567,12 +2571,70 @@ static char *get_password(void)
 	return pwd;
 }
 
+/* Return true if FILE is possibly PEM encoded (otherwise DER). */
+static int is_encoding_pem(FILE *in)
+{
+	char buf[6]; /* Room for the 5 minus signs and '\0'. */
+	int pem = 0;
+
+	if (fgets(buf, sizeof(buf), in) &&
+	    strspn(buf, "-") == sizeof(buf) - 1)
+		pem = 1;
+	rewind(in);
+	return pem;
+}
+
+/* Extract keyid from SKID of the cert. No return on error. */
+static unsigned long int extract_keyid(const char *certfile)
+{
+	uint32_t keyid_raw;
+	const ASN1_OCTET_STRING *skid;
+	int skid_len;
+	X509 *x = NULL;
+	int pem;
+	FILE *in;
+
+	if (!(in = fopen(certfile, "r"))) {
+		log_err("Cannot open cert file %s: %s\n", certfile,
+			strerror(errno));
+		exit(1);
+	}
+	if ((pem = is_encoding_pem(in)))
+		x = PEM_read_X509(in, &x, NULL, NULL);
+	else
+		x = d2i_X509_fp(in, &x);
+	if (!x) {
+		ERR_print_errors_fp(stderr);
+		log_err("Cannot read x509 cert from %s file %s\n",
+			pem? "PEM" : "DER", certfile);
+		fclose(in);
+		exit(1);
+	}
+	fclose(in);
+
+	if (!(skid = X509_get0_subject_key_id(x))) {
+		log_err("%s: SKID not found\n", certfile);
+		goto err_free;
+	}
+	skid_len = ASN1_STRING_length(skid);
+	if (skid_len < 4) {
+		log_err("%s: SKID too short (len %d)\n", certfile, skid_len);
+		goto err_free;
+	}
+	memcpy(&keyid_raw, ASN1_STRING_get0_data(skid) + skid_len - 4, 4);
+	log_info("keyid %04x (from %s)\n", ntohl(keyid_raw), certfile);
+	return ntohl(keyid_raw);
+
+err_free:
+	X509_free(x);
+	exit(1);
+}
+
 int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
 	ENGINE *eng = NULL;
 	unsigned long int keyid;
-	char *eptr;
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
@@ -2718,10 +2780,19 @@ int main(int argc, char *argv[])
 			pcrfile[npcrfile++] = optarg;
 			break;
 		case 143:
-			errno = 0;
-			keyid = strtoul(optarg, &eptr, 16);
-			if (errno || eptr - optarg != strlen(optarg) ||
-			    keyid > UINT_MAX || keyid == 0) {
+			if (optarg[0] == '@') {
+				keyid = extract_keyid(optarg + 1);
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
+			if (keyid > UINT_MAX || keyid == 0) {
 				log_err("Invalid keyid value.\n");
 				exit(1);
 			}
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

