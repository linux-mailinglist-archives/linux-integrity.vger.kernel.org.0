Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0923F103B
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 04:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhHSCMi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 22:12:38 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:38340 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhHSCMi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 22:12:38 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9E27F72C8F8;
        Thu, 19 Aug 2021 05:12:01 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 859304A46F1;
        Thu, 19 Aug 2021 05:12:01 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils v2] Use secure heap for private keys and passwords
Date:   Thu, 19 Aug 2021 05:11:36 +0300
Message-Id: <20210819021136.664597-1-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After CRYPTO_secure_malloc_init OpenSSL will store private keys in
secure heap. This facility is only available since OpenSSL_1_1_0-pre1.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Change from v1:
- Do not use setfbuf to disable buffering as this is not proven to be
  meaningful.
- Use secure heap for passwords too as suggested by Mimi Zohar.
- Fallback to OPENSSL_malloc for old OpenSSL as suggested by Mimi Zohar.
- Simplify logic of calling CRYPTO_secure_malloc_init (call it always on
  OpenSSL init.)
- Should be applied after Bruno Meneguele's "evmctl: fix memory leak in
  get_password" patch v2.

 src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 25 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 5f7c2b8..a27e0b9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -59,6 +59,7 @@
 #include <assert.h>
 
 #include <openssl/asn1.h>
+#include <openssl/crypto.h>
 #include <openssl/sha.h>
 #include <openssl/pem.h>
 #include <openssl/hmac.h>
@@ -165,6 +166,24 @@ struct tpm_bank_info {
 static char *pcrfile[MAX_PCRFILE];
 static unsigned npcrfile;
 
+#if OPENSSL_VERSION_NUMBER <= 0x10100000
+#warning Your OpenSSL version is too old to have OPENSSL_secure_malloc, \
+	falling back to use plain OPENSSL_malloc.
+#define OPENSSL_secure_malloc	  OPENSSL_malloc
+#define OPENSSL_secure_free	  OPENSSL_free
+/*
+ * Secure heap memory automatically cleared on free, but
+ * OPENSSL_secure_clear_free will be used in case of fallback
+ * to plain OPENSSL_malloc.
+ */
+#define OPENSSL_secure_clear_free OPENSSL_clear_free
+#define OPENSSL_clear_free(ptr, num)		\
+	do {					\
+		OPENSSL_cleanse(ptr, num);	\
+		OPENSSL_free(ptr);		\
+	} while (0)
+#endif
+
 static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
 {
 	FILE *fp;
@@ -188,7 +207,9 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
 	return err;
 }
 
-static unsigned char *file2bin(const char *file, const char *ext, int *size)
+/* Return data in OpenSSL secure heap if 'secure' is true. */
+static unsigned char *file2bin(const char *file, const char *ext, int *size,
+			       int secure)
 {
 	FILE *fp;
 	size_t len;
@@ -215,7 +236,10 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 	}
 	len = stats.st_size;
 
-	data = malloc(len);
+	if (secure)
+		data = OPENSSL_secure_malloc(len);
+	else
+		data = malloc(len);
 	if (!data) {
 		log_err("Failed to malloc %zu bytes: %s\n", len, name);
 		fclose(fp);
@@ -224,7 +248,10 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 	if (fread(data, len, 1, fp) != 1) {
 		log_err("Failed to fread %zu bytes: %s\n", len, name);
 		fclose(fp);
-		free(data);
+		if (secure)
+			OPENSSL_secure_clear_free(data, len);
+		else
+			free(data);
 		return NULL;
 	}
 	fclose(fp);
@@ -872,7 +899,7 @@ static int verify_ima(const char *file)
 	int len;
 
 	if (sigfile) {
-		void *tmp = file2bin(file, "sig", &len);
+		void *tmp = file2bin(file, "sig", &len, 0);
 
 		if (!tmp) {
 			log_err("Failed reading: %s\n", file);
@@ -1001,7 +1028,7 @@ static int cmd_import(struct command *cmd)
 
 		if (!pkey)
 			return 1;
-		pub = file2bin(inkey, NULL, &len);
+		pub = file2bin(inkey, NULL, &len, 0);
 		if (!pub) {
 			EVP_PKEY_free(pkey);
 			return 1;
@@ -1040,9 +1067,9 @@ static int setxattr_ima(const char *file, char *sig_file)
 	int len, err;
 
 	if (sig_file)
-		sig = file2bin(sig_file, NULL, &len);
+		sig = file2bin(sig_file, NULL, &len, 0);
 	else
-		sig = file2bin(file, "sig", &len);
+		sig = file2bin(file, "sig", &len, 0);
 	if (!sig)
 		return 0;
 
@@ -1082,9 +1109,9 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	unsigned int mdlen;
 	char **xattrname;
 	unsigned char xattr_value[1024];
-	unsigned char *key;
+	unsigned char *key; /* @secure heap */
 	int keylen;
-	unsigned char evmkey[MAX_KEY_SIZE];
+	unsigned char *evmkey; /* @secure heap */
 	char list[1024];
 	ssize_t list_size;
 	struct h_misc_64 hmac_misc;
@@ -1096,21 +1123,30 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	pctx = HMAC_CTX_new();
 #endif
 
-	key = file2bin(keyfile, NULL, &keylen);
+	key = file2bin(keyfile, NULL, &keylen, 1);
 	if (!key) {
 		log_err("Failed to read a key: %s\n", keyfile);
 		return -1;
 	}
 
-	if (keylen > sizeof(evmkey)) {
+	evmkey = OPENSSL_secure_malloc(MAX_KEY_SIZE);
+	if (!evmkey) {
+		log_err("Failed to allocate %d bytes\n", MAX_KEY_SIZE);
+		goto out;
+	}
+
+	if (keylen > MAX_KEY_SIZE) {
 		log_err("key is too long: %d\n", keylen);
 		goto out;
 	}
 
 	/* EVM key is 128 bytes */
 	memcpy(evmkey, key, keylen);
-	if (keylen < sizeof(evmkey))
-		memset(evmkey + keylen, 0, sizeof(evmkey) - keylen);
+	if (keylen < MAX_KEY_SIZE)
+		memset(evmkey + keylen, 0, MAX_KEY_SIZE - keylen);
+
+	/* Shorten lifetime of key data. */
+	OPENSSL_cleanse(key, keylen);
 
 	if (lstat(file, &st)) {
 		log_err("Failed to stat: %s\n", file);
@@ -1147,12 +1183,15 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		goto out;
 	}
 
-	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
+	err = !HMAC_Init_ex(pctx, evmkey, MAX_KEY_SIZE, md, NULL);
 	if (err) {
 		log_err("HMAC_Init() failed\n");
 		goto out;
 	}
 
+	/* Shorten lifetime of evmkey data. */
+	OPENSSL_cleanse(evmkey, MAX_KEY_SIZE);
+
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
 		err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
 		if (err < 0) {
@@ -1222,7 +1261,9 @@ out_ctx_cleanup:
 	HMAC_CTX_free(pctx);
 #endif
 out:
-	free(key);
+	if (evmkey)
+		OPENSSL_secure_clear_free(evmkey, MAX_KEY_SIZE);
+	OPENSSL_secure_clear_free(key, keylen);
 	return err ?: mdlen;
 }
 
@@ -2596,15 +2637,41 @@ static struct option opts[] = {
 
 };
 
+/*
+ * Copy password from optarg into secure heap, so it could be
+ * freed in the same way as a result of get_password().
+ */
+static char *optarg_password(char *optarg)
+{
+	size_t len;
+	char *keypass;
+
+	if (!optarg)
+		return NULL;
+	len = strlen(optarg);
+	keypass = OPENSSL_secure_malloc(len + 1);
+	if (keypass)
+		memcpy(keypass, optarg, len + 1);
+	else
+		perror("OPENSSL_secure_malloc");
+	/*
+	 * This memset does not add real security, just increases
+	 * the chance of password being obscured in ps output.
+	 */
+	memset(optarg, 'X', len);
+	return keypass;
+}
+
+/* Read from TTY into secure heap. */
 static char *get_password(void)
 {
 	struct termios flags, tmp_flags;
 	char *password, *pwd;
-	int passlen = 64;
+	const int passlen = 64;
 
-	password = malloc(passlen);
+	password = OPENSSL_secure_malloc(passlen);
 	if (!password) {
-		perror("malloc");
+		perror("OPENSSL_secure_malloc");
 		return NULL;
 	}
 
@@ -2615,7 +2682,7 @@ static char *get_password(void)
 
 	if (tcsetattr(fileno(stdin), TCSANOW, &tmp_flags) != 0) {
 		perror("tcsetattr");
-		free(password);
+		OPENSSL_secure_free(password);
 		return NULL;
 	}
 
@@ -2625,12 +2692,14 @@ static char *get_password(void)
 	/* restore terminal */
 	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
 		perror("tcsetattr");
-		free(password);
-		return NULL;
+		/*
+		 * Password is already here, so there is no point
+		 * to stop working on this petty error.
+		 */
 	}
 
 	if (pwd == NULL) {
-		free(password);
+		OPENSSL_secure_free(password);
 		return NULL;
 	}
 
@@ -2643,6 +2712,7 @@ int main(int argc, char *argv[])
 	ENGINE *eng = NULL;
 	unsigned long keyid;
 	char *eptr;
+	char *keypass = NULL; /* @secure heap */
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
@@ -2651,6 +2721,16 @@ int main(int argc, char *argv[])
 #endif
 			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
 #endif
+#if OPENSSL_VERSION_NUMBER > 0x10100000
+	/*
+	 * This facility is available since OpenSSL_1_1_0-pre1.
+	 * 'Heap size' 8192 is chosen to be big enough, so that any single key
+	 * data could fit. 'Heap minsize' 64 is just to be efficient for small
+	 * buffers.
+	 */
+       CRYPTO_secure_malloc_init(8192, 64);
+#endif
+
 	g_argv = argv;
 	g_argc = argc;
 
@@ -2682,10 +2762,18 @@ int main(int argc, char *argv[])
 			imaevm_params.hash_algo = optarg;
 			break;
 		case 'p':
+			if (keypass)
+				OPENSSL_secure_clear_free(keypass,
+							  strlen(keypass));
 			if (optarg)
-				imaevm_params.keypass = optarg;
+				keypass = optarg_password(optarg);
 			else
-				imaevm_params.keypass = get_password();
+				keypass = get_password();
+			if (!keypass) {
+				log_err("Cannot read password\n");
+				goto quit;
+			}
+			imaevm_params.keypass = keypass;
 			break;
 		case 'f':
 			sigfile = 1;
@@ -2841,7 +2929,9 @@ int main(int argc, char *argv[])
 		if (err < 0)
 			err = 125;
 	}
-
+quit:
+	if (keypass)
+		OPENSSL_secure_clear_free(keypass, strlen(keypass));
 	if (eng) {
 		ENGINE_finish(eng);
 		ENGINE_free(eng);
@@ -2849,6 +2939,9 @@ int main(int argc, char *argv[])
 		ENGINE_cleanup();
 #endif
 	}
+#if OPENSSL_VERSION_NUMBER > 0x10100000
+	CRYPTO_secure_malloc_done();
+#endif
 	ERR_free_strings();
 	EVP_cleanup();
 	BIO_free(NULL);
-- 
2.29.3

