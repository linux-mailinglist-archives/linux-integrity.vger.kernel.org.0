Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05F74FAD3
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Jun 2019 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFWJA5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 05:00:57 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41334 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFWJA5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 05:00:57 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 215D672CC6C;
        Sun, 23 Jun 2019 12:00:54 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8A5D74A4A29;
        Sun, 23 Jun 2019 12:00:53 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 03/11] ima-evm-utils: Convert cmd_import and calc keyid v2 to EVP_PKEY API
Date:   Sun, 23 Jun 2019 12:00:19 +0300
Message-Id: <20190623090027.11852-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190623090027.11852-1-vt@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce calc_pkeyid_v2() (which accepts EVP_PKEY) to replace
calc_keyid_v2() (which accepts RSA) in the future and use it in
cmd_import().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    | 25 +++++++++++++++----------
 src/imaevm.h    |  1 +
 src/libimaevm.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 15a7226..eed8f9a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -891,7 +891,6 @@ static int cmd_import(struct command *cmd)
 	int id, len, err = 0;
 	char name[20];
 	uint8_t keyid[8];
-	RSA *key;
 
 	inkey = g_argv[optind++];
 	if (!inkey) {
@@ -925,18 +924,26 @@ static int cmd_import(struct command *cmd)
 		}
 	}
 
-	key = read_pub_key(inkey, params.x509);
-	if (!key)
-		return 1;
-
 	if (params.x509) {
+		EVP_PKEY *pkey = read_pub_pkey(inkey, params.x509);
+
+		if (!pkey)
+			return 1;
 		pub = file2bin(inkey, NULL, &len);
-		if (!pub)
-			goto out;
-		calc_keyid_v2((uint32_t *)keyid, name, key);
+		if (!pub) {
+			EVP_PKEY_free(pkey);
+			return 1;
+		}
+		calc_pkeyid_v2((uint32_t *)keyid, name, pkey);
+		EVP_PKEY_free(pkey);
 	} else {
+		RSA *key = read_pub_key(inkey, params.x509);
+
+		if (!key)
+			return 1;
 		len = key2bin(key, pub);
 		calc_keyid_v1(keyid, name, pub, len);
+		RSA_free(key);
 	}
 
 	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
@@ -951,8 +958,6 @@ static int cmd_import(struct command *cmd)
 	}
 	if (params.x509)
 		free(pub);
-out:
-	RSA_free(key);
 	return err;
 }
 
diff --git a/src/imaevm.h b/src/imaevm.h
index 6d5eabd..48d2663 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -220,6 +220,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
 void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key);
+void calc_pkeyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
 int key2bin(RSA *key, unsigned char *pub);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 23fa804..707b2e9 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -753,6 +753,36 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	free(pkey);
 }
 
+/*
+ * Calculate keyid of the public_key part of EVP_PKEY
+ */
+void calc_pkeyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
+{
+	X509_PUBKEY *pk = NULL;
+	const unsigned char *public_key = NULL;
+	int len;
+
+	/* This is more generic than i2d_PublicKey() */
+	if (X509_PUBKEY_set(&pk, pkey) &&
+	    X509_PUBKEY_get0_param(NULL, &public_key, &len, NULL, pk)) {
+		uint8_t sha1[SHA_DIGEST_LENGTH];
+
+		SHA1(public_key, len, sha1);
+		/* sha1[12 - 19] is exactly keyid from gpg file */
+		memcpy(keyid, sha1 + 16, 4);
+	} else
+		*keyid = 0;
+
+	log_debug("keyid: ");
+	log_debug_dump(keyid, 4);
+	sprintf(str, "%x", __be32_to_cpup(keyid));
+
+	if (params.verbose > LOG_INFO)
+		log_info("keyid: %s\n", str);
+
+	X509_PUBKEY_free(pk);
+}
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
-- 
2.11.0

