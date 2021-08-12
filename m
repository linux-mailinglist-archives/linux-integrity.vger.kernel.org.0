Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5983EAC54
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhHLVWX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 17:22:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59124 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHLVWW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 17:22:22 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8CAE772C8FB;
        Fri, 13 Aug 2021 00:21:55 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 6DE3C4A46F1;
        Fri, 13 Aug 2021 00:21:55 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils] Improve memory handling for private keys and passwords
Date:   Fri, 13 Aug 2021 00:21:43 +0300
Message-Id: <20210812212143.2223183-1-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After CRYPTO_secure_malloc_init OpenSSL will store private keys in
secure heap. This facility is only available since OpenSSL_1_1_0-pre1
and enabled for 'ima_sign', 'sign', 'sign_hash', and 'hmac'.

setvbuf(3) _IONBF is used to hopefully avoid private key and password
being stored inside of stdio buffers.

Unfortunately, secure heap is not used for the passwords (`-p') due to
absence of its support in the older OpenSSL where ima-evem-utils still
should work, thus simple cleansing of password memory is used where
possible to shorten its lifespan.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Perhaps, it will conflict with Bruno's patch, we should decide which
one goes first if this will be accepted.

 src/evmctl.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++---
 src/libimaevm.c | 14 ++++++++-
 2 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a8065bb..3275464 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -59,6 +59,7 @@
 #include <assert.h>
 
 #include <openssl/asn1.h>
+#include <openssl/crypto.h>
 #include <openssl/sha.h>
 #include <openssl/pem.h>
 #include <openssl/hmac.h>
@@ -165,6 +166,23 @@ struct tpm_bank_info {
 static char *pcrfile[MAX_PCRFILE];
 static unsigned npcrfile;
 
+static void init_openssl_secure_memory(void)
+{
+#if OPENSSL_VERSION_NUMBER > 0x10100000
+	/*
+	 * man CRYPTO_secure_malloc_init for explanation of the values.
+	 * 8192 is chosen to be big enough, so that any single key data could fit.
+	 */
+# define SECURE_HEAP_SIZE 8192
+# define SECURE_HEAP_MINSIZE 64
+	/*
+	 * Enable secure storage when working with private keys.
+	 * This facility is available since OpenSSL_1_1_0-pre1.
+	 */
+	CRYPTO_secure_malloc_init(SECURE_HEAP_SIZE, SECURE_HEAP_MINSIZE);
+#endif
+}
+
 static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
 {
 	FILE *fp;
@@ -221,6 +239,8 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 		fclose(fp);
 		return NULL;
 	}
+	/* Disable buffering because it's used to read private HMAC key too. */
+	setvbuf(fp, NULL, _IONBF, 0);
 	if (fread(data, len, 1, fp) != 1) {
 		log_err("Failed to fread %zu bytes: %s\n", len, name);
 		fclose(fp);
@@ -723,6 +743,7 @@ static int sign_ima_file(const char *file)
 
 static int cmd_sign_ima(struct command *cmd)
 {
+	init_openssl_secure_memory();
 	return do_cmd(cmd, sign_ima_file);
 }
 
@@ -737,6 +758,7 @@ static int cmd_sign_hash(struct command *cmd)
 	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
 	int siglen;
 
+	init_openssl_secure_memory();
 	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	/* support reading hash (eg. output of shasum) */
@@ -796,6 +818,7 @@ static int sign_evm_path(const char *file)
 
 static int cmd_sign_evm(struct command *cmd)
 {
+	init_openssl_secure_memory();
 	return do_cmd(cmd, sign_evm_path);
 }
 
@@ -1104,6 +1127,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 
 	if (keylen > sizeof(evmkey)) {
 		log_err("key is too long: %d\n", keylen);
+		OPENSSL_cleanse(key, keylen);
 		goto out;
 	}
 
@@ -1111,6 +1135,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	memcpy(evmkey, key, keylen);
 	if (keylen < sizeof(evmkey))
 		memset(evmkey + keylen, 0, sizeof(evmkey) - keylen);
+	OPENSSL_cleanse(key, keylen);
 
 	if (lstat(file, &st)) {
 		log_err("Failed to stat: %s\n", file);
@@ -1148,6 +1173,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	}
 
 	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
+	OPENSSL_cleanse(evmkey, sizeof(evmkey));
 	if (err) {
 		log_err("HMAC_Init() failed\n");
 		goto out;
@@ -1259,6 +1285,7 @@ static int cmd_hmac_evm(struct command *cmd)
 	const char *key, *file = g_argv[optind++];
 	int err;
 
+	init_openssl_secure_memory();
 	if (!file) {
 		log_err("Parameters missing\n");
 		print_usage(cmd);
@@ -2592,6 +2619,32 @@ static struct option opts[] = {
 
 };
 
+/*
+ * Copy password from optarg into malloc'd memory, so it could be
+ * freed in the same way as a result of get_password.
+ */
+static char *optarg_password(char *optarg)
+{
+	size_t len;
+	char *keypass;
+
+	if (!optarg)
+		return NULL;
+	len = strlen(optarg);
+	keypass = malloc(len + 1);
+	if (keypass)
+		memcpy(keypass, optarg, len + 1);
+	else
+		perror("malloc");
+	/*
+	 * This memset does not add real security, just increases
+	 * the chance of password being obscured in ps output.
+	 */
+	memset(optarg, 'X', len);
+	return keypass;
+}
+
+/* Read password from TTY. */
 static char *get_password(void)
 {
 	struct termios flags, tmp_flags;
@@ -2614,6 +2667,7 @@ static char *get_password(void)
 		free(password);
 		return NULL;
 	}
+	setvbuf(stdin, NULL, _IONBF, 0);
 
 	printf("PEM password: ");
 	pwd = fgets(password, passlen, stdin);
@@ -2621,8 +2675,10 @@ static char *get_password(void)
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
 
 	return pwd;
@@ -2634,6 +2690,7 @@ int main(int argc, char *argv[])
 	ENGINE *eng = NULL;
 	unsigned long keyid;
 	char *eptr;
+	char *keypass = NULL;
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
@@ -2673,10 +2730,19 @@ int main(int argc, char *argv[])
 			imaevm_params.hash_algo = optarg;
 			break;
 		case 'p':
+			if (keypass) {
+				OPENSSL_cleanse(keypass, strlen(keypass));
+				free(keypass);
+			}
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
@@ -2833,6 +2899,15 @@ int main(int argc, char *argv[])
 			err = 125;
 	}
 
+quit:
+	if (keypass) {
+		OPENSSL_cleanse(keypass, strlen(keypass));
+		free(keypass);
+	}
+#if OPENSSL_VERSION_NUMBER > 0x10100000
+	CRYPTO_secure_malloc_done();
+#endif
+
 	if (eng) {
 		ENGINE_finish(eng);
 		ENGINE_free(eng);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 19f1041..7bf3ba9 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -726,6 +726,10 @@ static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile, int tr
 		log_err("Cannot open %s: %s\n", certfile, strerror(errno));
 		return -1;
 	}
+
+	/* There could be private key, thus disable buffering. */
+	setvbuf(fp, NULL, _IONBF, 0);
+
 	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
 		if (ERR_GET_REASON(ERR_peek_last_error()) == PEM_R_NO_START_LINE) {
 			ERR_clear_error();
@@ -799,6 +803,7 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 		log_err("Failed to open keyfile: %s\n", keyfile);
 		return NULL;
 	}
+	setvbuf(fp, NULL, _IONBF, 0);
 	pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
 	if (!pkey) {
 		log_err("Failed to PEM_read_PrivateKey key file: %s\n",
@@ -1021,8 +1026,15 @@ err:
 
 int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
 {
-	if (keypass)
+	if (keypass && keypass != imaevm_params.keypass) {
+		/*
+		 * Cannot cleanse previous imaevm_params.keypass value, due to
+		 * it's being const, but can warn user.
+		 */
+		if (imaevm_params.keypass)
+			log_err("Overwriting non-empty imaevm_params.keypass\n");
 		imaevm_params.keypass = keypass;
+	}
 
 	return imaevm_params.x509 ?
 		sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
-- 
2.29.3

