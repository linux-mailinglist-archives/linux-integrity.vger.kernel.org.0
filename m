Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FB45166
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 03:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfFNBya (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 21:54:30 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41174 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNBya (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 21:54:30 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8E7E672CCD6;
        Fri, 14 Jun 2019 04:54:28 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 6BB924A4AE7;
        Fri, 14 Jun 2019 04:54:28 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 3/5] ima-avm-utils: Change read_priv_key to use EVP_PKEY API
Date:   Fri, 14 Jun 2019 04:54:08 +0300
Message-Id: <20190614015410.26039-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190614015410.26039-1-vt@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce read_priv_pkey() to read keys using EVP_PKEY, and change
read_priv_key() to be wrapper for it.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index da0f422..c620c1e 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -753,10 +753,10 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	free(pkey);
 }
 
-static RSA *read_priv_key(const char *keyfile, const char *keypass)
+static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
-	RSA *key;
+	EVP_PKEY *key;
 
 	fp = fopen(keyfile, "r");
 	if (!fp) {
@@ -764,18 +764,40 @@ static RSA *read_priv_key(const char *keyfile, const char *keypass)
 		return NULL;
 	}
 	ERR_load_crypto_strings();
-	key = PEM_read_RSAPrivateKey(fp, NULL, NULL, (void *)keypass);
+	key = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
 	if (!key) {
 		char str[256];
 
-		ERR_error_string(ERR_get_error(), str);
-		log_err("PEM_read_RSAPrivateKey() failed: %s\n", str);
+		ERR_error_string(ERR_peek_error(), str);
+		log_err("PEM_read_PrivateKey() failed: %s\n", str);
+#ifdef USE_FPRINTF
+		ERR_print_errors_fp(stderr);
+#else
+		ERR_clear_error();
+#endif
 	}
 
 	fclose(fp);
 	return key;
 }
 
+static RSA *read_priv_key(const char *keyfile, const char *keypass)
+{
+	EVP_PKEY *pkey;
+	RSA *key;
+
+	pkey = read_priv_pkey(keyfile, keypass);
+	if (!pkey)
+		return NULL;
+	key = EVP_PKEY_get1_RSA(pkey);
+	EVP_PKEY_free(pkey);
+	if (!key) {
+		log_err("sign_hash_v1: unsupported key type\n");
+		return NULL;
+	}
+	return key;
+}
+
 static int get_hash_algo_v1(const char *algo)
 {
 
-- 
2.11.0

