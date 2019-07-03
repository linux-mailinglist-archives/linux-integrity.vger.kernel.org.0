Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E035E822
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCPvM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 11:51:12 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41870 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCPvM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 11:51:12 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3ED9E72CC6C;
        Wed,  3 Jul 2019 18:51:09 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 19CC94A4A29;
        Wed,  3 Jul 2019 18:51:09 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v8 6/9] ima-evm-utils: Replace calc_keyid_v2 with calc_pkeyid_v2
Date:   Wed,  3 Jul 2019 18:50:12 +0300
Message-Id: <20190703155015.14262-7-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190703155015.14262-1-vt@altlinux.org>
References: <20190703155015.14262-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Finish conversion of calc keyid v2 to EVP_PKEY API. After sign_hash_v2()
is switched to EVP_PKEY API (in previous commit), older RSA-specific
calc_keyid_v2() does not needed anymore and can be replaced with
calc_pkeyid_v2().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    |  2 +-
 src/imaevm.h    |  3 +--
 src/libimaevm.c | 28 +++-------------------------
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index eed8f9a..354d731 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -934,7 +934,7 @@ static int cmd_import(struct command *cmd)
 			EVP_PKEY_free(pkey);
 			return 1;
 		}
-		calc_pkeyid_v2((uint32_t *)keyid, name, pkey);
+		calc_keyid_v2((uint32_t *)keyid, name, pkey);
 		EVP_PKEY_free(pkey);
 	} else {
 		RSA *key = read_pub_key(inkey, params.x509);
diff --git a/src/imaevm.h b/src/imaevm.h
index 48d2663..9af43a2 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -219,8 +219,7 @@ RSA *read_pub_key(const char *keyfile, int x509);
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
-void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key);
-void calc_pkeyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
+void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
 int key2bin(RSA *key, unsigned char *pub);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 213855c..25d5a00 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -495,7 +495,7 @@ void init_public_keys(const char *keyfiles)
 			continue;
 		}
 
-		calc_pkeyid_v2(&entry->keyid, entry->name, entry->key);
+		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
 		entry->next = public_keys;
@@ -741,32 +741,10 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 		log_info("keyid-v1: %s\n", str);
 }
 
-void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
-{
-	uint8_t sha1[SHA_DIGEST_LENGTH];
-	unsigned char *pkey = NULL;
-	int len;
-
-	len = i2d_RSAPublicKey(key, &pkey);
-
-	SHA1(pkey, len, sha1);
-
-	/* sha1[12 - 19] is exactly keyid from gpg file */
-	memcpy(keyid, sha1 + 16, 4);
-	log_debug("keyid: ");
-	log_debug_dump(keyid, 4);
-	sprintf(str, "%x", __be32_to_cpup(keyid));
-
-	if (params.verbose > LOG_INFO)
-		log_info("keyid: %s\n", str);
-
-	free(pkey);
-}
-
 /*
  * Calculate keyid of the public_key part of EVP_PKEY
  */
-void calc_pkeyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
+void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
 {
 	X509_PUBKEY *pk = NULL;
 	const unsigned char *public_key = NULL;
@@ -971,7 +949,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 	hdr->hash_algo = get_hash_algo(algo);
 
-	calc_pkeyid_v2(&hdr->keyid, name, pkey);
+	calc_keyid_v2(&hdr->keyid, name, pkey);
 
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
-- 
2.11.0

