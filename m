Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C81B4A2F1
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFRN6D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:58:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53694 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfFRN6C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:58:02 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C88B272CCD9;
        Tue, 18 Jun 2019 16:57:59 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id A2F4B4A4A14;
        Tue, 18 Jun 2019 16:57:59 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 10/11] ima-evm-utils: Finish converting calc keyid v2 to EVP_PKEY API
Date:   Tue, 18 Jun 2019 16:56:22 +0300
Message-Id: <20190618135623.6861-11-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618135623.6861-1-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace RSA-specific calc_keyid_v2() with calc_pkeyid_v2() which accepts
EVP_PKEY.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    |  2 +-
 src/imaevm.h    |  3 +--
 src/libimaevm.c | 28 +++-------------------------
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 224cb1f..ded18c6 100644
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
index 7b8ce92..008cf4a 100644
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
@@ -722,32 +722,10 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
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
@@ -948,7 +926,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 	hdr->hash_algo = get_hash_algo(algo);
 
-	calc_pkeyid_v2(&hdr->keyid, name, pkey);
+	calc_keyid_v2(&hdr->keyid, name, pkey);
 
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
 		goto err;
-- 
2.11.0

