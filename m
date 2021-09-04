Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD891400AE9
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Sep 2021 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351110AbhIDKwD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Sep 2021 06:52:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:36564 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351095AbhIDKwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Sep 2021 06:52:01 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7A7A472C8B0;
        Sat,  4 Sep 2021 13:50:58 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 52B9F4A46FC;
        Sat,  4 Sep 2021 13:50:58 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Bruno Meneguele <bmeneg@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private keys and passwords
Date:   Sat,  4 Sep 2021 13:50:54 +0300
Message-Id: <20210904105054.3388329-1-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After CRYPTO_secure_malloc_init OpenSSL will automatically store private
keys in secure heap. OPENSSL_secure_malloc(3):

  If a secure heap is used, then private key BIGNUM values are stored
  there. This protects long-term storage of private keys, but will not
  necessarily put all intermediate values and computations there.

Additionally, we try to keep user passwords in secure heap too.
This facility is only available since OpenSSL_1_1_0-pre1.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
---
Change since v3:
- Undo secure heap handling from (file2bin and) calc_evm_hmac since this
  is debugging tool only. Add comment about this.
- Since there is only code removals and new comments I keep Reviewed-by
  tag.

 src/evmctl.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 5f7c2b8..7bd20f8 100644
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
@@ -1072,6 +1091,7 @@ static int cmd_setxattr_ima(struct command *cmd)
 
 #define MAX_KEY_SIZE 128
 
+/* This function is debugging tool and should not be used for real private data. */
 static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
 {
         const EVP_MD *md;
@@ -2596,15 +2616,41 @@ static struct option opts[] = {
 
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
+		log_err("OPENSSL_secure_malloc(%zu) failed\n", len + 1);
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
+		log_err("OPENSSL_secure_malloc(%u) failed\n", passlen);
 		return NULL;
 	}
 
@@ -2614,8 +2660,8 @@ static char *get_password(void)
 	tmp_flags.c_lflag |= ECHONL;
 
 	if (tcsetattr(fileno(stdin), TCSANOW, &tmp_flags) != 0) {
-		perror("tcsetattr");
-		free(password);
+		log_err("tcsetattr: %s\n", strerror(errno));
+		OPENSSL_secure_free(password);
 		return NULL;
 	}
 
@@ -2624,13 +2670,15 @@ static char *get_password(void)
 
 	/* restore terminal */
 	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
-		perror("tcsetattr");
-		free(password);
-		return NULL;
+		log_err("tcsetattr: %s\n", strerror(errno));
+		/*
+		 * Password is already here, so there is no reason
+		 * to stop working on this petty error.
+		 */
 	}
 
 	if (pwd == NULL) {
-		free(password);
+		OPENSSL_secure_free(password);
 		return NULL;
 	}
 
@@ -2643,6 +2691,7 @@ int main(int argc, char *argv[])
 	ENGINE *eng = NULL;
 	unsigned long keyid;
 	char *eptr;
+	char *keypass = NULL; /* @secure heap */
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
@@ -2651,6 +2700,17 @@ int main(int argc, char *argv[])
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
+	if (!CRYPTO_secure_malloc_init(8192, 64))
+		log_err("CRYPTO_secure_malloc_init() failed\n");
+#endif
+
 	g_argv = argv;
 	g_argc = argc;
 
@@ -2682,10 +2742,18 @@ int main(int argc, char *argv[])
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
@@ -2841,7 +2909,9 @@ int main(int argc, char *argv[])
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
@@ -2849,6 +2919,9 @@ int main(int argc, char *argv[])
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

