Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE56D68E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 23:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfGRVfZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 17:35:25 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53228 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRVfZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 17:35:25 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9365872CA65;
        Fri, 19 Jul 2019 00:35:22 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 689C54A4A29;
        Fri, 19 Jul 2019 00:35:22 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 3/3] ima-evm-utils: Improve OpenSSL error reporting
Date:   Fri, 19 Jul 2019 00:35:10 +0300
Message-Id: <20190718213510.10829-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190718213510.10829-1-vt@altlinux.org>
References: <20190718213510.10829-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Previously OpenSSL errors was delayed until evmctl exit (sometimes not).
Since we try to make libimaevm more robust, there could be many errors
accumulated, so it's useful to output OpenSSL errors as they happen.
This will also make output more understandable as you can see which
openssl error correspond to which libimaevm error.

Additionally, change spelling of read_pub_pkey and read_priv_pkey to
include key file name.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index b153f1b..2a0486f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -116,6 +116,18 @@ const char *get_hash_algo_by_id(int algo)
 	return "unknown";
 }
 
+/* Output all remaining openssl error messages. */
+static void output_openssl_errors(void)
+{
+	while (ERR_peek_error()) {
+		char buf[256];
+		/* buf must be at least 256 bytes long according to man */
+
+		ERR_error_string(ERR_get_error(), buf);
+		log_err("openssl: %s\n", buf);
+	}
+}
+
 static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 {
 	uint8_t *data;
@@ -191,6 +203,7 @@ static int add_dir_hash(const char *file, EVP_MD_CTX *ctx)
 		err |= EVP_DigestUpdate(ctx, &type, sizeof(type));
 		if (!err) {
 			log_err("EVP_DigestUpdate() failed\n");
+			output_openssl_errors();
 			result = 1;
 			break;
 		}
@@ -290,6 +303,8 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	}
 	err = mdlen;
 err:
+	if (err == 1)
+		output_openssl_errors();
 #if OPENSSL_VERSION_NUMBER >= 0x10100000
 	EVP_MD_CTX_free(pctx);
 #endif
@@ -299,7 +314,6 @@ err:
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
-	X509 *crt = NULL;
 	EVP_PKEY *pkey = NULL;
 
 	if (!keyfile)
@@ -312,24 +326,30 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 	}
 
 	if (x509) {
-		crt = d2i_X509_fp(fp, NULL);
+		X509 *crt = d2i_X509_fp(fp, NULL);
+
 		if (!crt) {
-			log_err("d2i_X509_fp() failed\n");
+			log_err("Failed to d2i_X509_fp key file: %s\n",
+				keyfile);
 			goto out;
 		}
 		pkey = X509_extract_key(crt);
 		X509_free(crt);
 		if (!pkey) {
-			log_err("X509_extract_key() failed\n");
+			log_err("Failed to X509_extract_key key file: %s\n",
+				keyfile);
 			goto out;
 		}
 	} else {
 		pkey = PEM_read_PUBKEY(fp, NULL, NULL, NULL);
 		if (!pkey)
-			log_err("PEM_read_PUBKEY() failed\n");
+			log_err("Failed to PEM_read_PUBKEY key file: %s\n",
+				keyfile);
 	}
 
 out:
+	if (!pkey)
+		output_openssl_errors();
 	fclose(fp);
 	return pkey;
 }
@@ -346,6 +366,7 @@ RSA *read_pub_key(const char *keyfile, int x509)
 	EVP_PKEY_free(pkey);
 	if (!key) {
 		log_err("read_pub_key: unsupported key type\n");
+		output_openssl_errors();
 		return NULL;
 	}
 	return key;
@@ -379,6 +400,7 @@ int verify_hash_v1(const char *file, const unsigned char *hash, int size,
 	RSA_free(key);
 	if (err < 0) {
 		log_err("%s: RSA_public_decrypt() failed: %d\n", file, err);
+		output_openssl_errors();
 		return 1;
 	}
 
@@ -496,6 +518,7 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	else if (ret == 0) {
 		log_err("%s: verification failed: %d (%s)\n",
 			file, ret, ERR_reason_error_string(ERR_get_error()));
+		output_openssl_errors();
 		ret = 1;
 	}
 err:
@@ -503,6 +526,7 @@ err:
 		log_err("%s: verification failed: %d (%s) in %s\n",
 			file, ret, ERR_reason_error_string(ERR_peek_error()),
 			st);
+		output_openssl_errors();
 		ret = -1;
 	}
 	EVP_PKEY_CTX_free(ctx);
@@ -715,10 +739,9 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 	ERR_load_crypto_strings();
 	pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
 	if (!pkey) {
-		char str[256];
-
-		ERR_error_string(ERR_get_error(), str);
-		log_err("PEM_read_PrivateKey() failed: %s\n", str);
+		log_err("Failed to PEM_read_PrivateKey key file: %s\n",
+			keyfile);
+		output_openssl_errors();
 	}
 
 	fclose(fp);
@@ -737,6 +760,7 @@ static RSA *read_priv_key(const char *keyfile, const char *keypass)
 	EVP_PKEY_free(pkey);
 	if (!key) {
 		log_err("read_priv_key: unsupported key type\n");
+		output_openssl_errors();
 		return NULL;
 	}
 	return key;
@@ -820,6 +844,7 @@ int sign_hash_v1(const char *hashalgo, const unsigned char *hash, int size, cons
 	len = RSA_private_encrypt(sizeof(sighash), sighash, sig + sizeof(*hdr) + 2, key, RSA_PKCS1_PADDING);
 	if (len < 0) {
 		log_err("RSA_private_encrypt() failed: %d\n", len);
+		output_openssl_errors();
 		goto out;
 	}
 
@@ -908,9 +933,11 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	log_info("evm/ima signature: %d bytes\n", len);
 
 err:
-	if (len == -1)
+	if (len == -1) {
 		log_err("sign_hash_v2: signing failed: (%s) in %s\n",
 			ERR_reason_error_string(ERR_peek_error()), st);
+		output_openssl_errors();
+	}
 	EVP_PKEY_CTX_free(ctx);
 	EVP_PKEY_free(pkey);
 	return len;
-- 
2.11.0

