Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491025E820
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 17:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCPu6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 11:50:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41670 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCPu5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 11:50:57 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7F28872CC6C;
        Wed,  3 Jul 2019 18:50:55 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 54C744A4A29;
        Wed,  3 Jul 2019 18:50:55 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v8 4/9] ima-evm-utils: Convert verify_hash_v2 and find_keyid to EVP_PKEY API
Date:   Wed,  3 Jul 2019 18:50:10 +0300
Message-Id: <20190703155015.14262-5-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190703155015.14262-1-vt@altlinux.org>
References: <20190703155015.14262-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rely on OpenSSL API to verify v2 signatures instead of manual PKCS1
decoding. Also, convert find_keyid() to return EVP_PKEY because
verify_hash_v2() is sole user of it.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 94 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 707b2e9..4c98cb0 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -452,11 +452,11 @@ struct public_key_entry {
 	struct public_key_entry *next;
 	uint32_t keyid;
 	char name[9];
-	RSA *key;
+	EVP_PKEY *key;
 };
 static struct public_key_entry *public_keys = NULL;
 
-static RSA *find_keyid(uint32_t keyid)
+static EVP_PKEY *find_keyid(uint32_t keyid)
 {
 	struct public_key_entry *entry;
 
@@ -489,13 +489,13 @@ void init_public_keys(const char *keyfiles)
 			break;
 		}
 
-		entry->key = read_pub_key(keyfile, 1);
+		entry->key = read_pub_pkey(keyfile, 1);
 		if (!entry->key) {
 			free(entry);
 			continue;
 		}
 
-		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
+		calc_pkeyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
 		entry->next = public_keys;
@@ -503,14 +503,18 @@ void init_public_keys(const char *keyfiles)
 	}
 }
 
+/*
+ * Return: 0 verification good, 1 verification bad, -1 error.
+ */
 int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		   unsigned char *sig, int siglen, const char *keyfile)
 {
-	int err, len;
-	unsigned char out[1024];
-	RSA *key;
+	int ret = -1;
+	EVP_PKEY *pkey, *pkey_free = NULL;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
-	const struct RSA_ASN1_template *asn1;
+	EVP_PKEY_CTX *ctx;
+	const EVP_MD *md;
+	const char *st;
 
 	if (params.verbose > LOG_INFO) {
 		log_info("hash: ");
@@ -518,45 +522,51 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	}
 
 	if (public_keys) {
-		key = find_keyid(hdr->keyid);
-		if (!key) {
+		pkey = find_keyid(hdr->keyid);
+		if (!pkey) {
 			log_err("%s: unknown keyid: %x\n", file,
 				__be32_to_cpup(&hdr->keyid));
 			return -1;
 		}
 	} else {
-		key = read_pub_key(keyfile, 1);
-		if (!key)
-			return 1;
-	}
-
-
-	err = RSA_public_decrypt(siglen - sizeof(*hdr), sig + sizeof(*hdr),
-				 out, key, RSA_PKCS1_PADDING);
-	if (err < 0) {
-		log_err("%s: RSA_public_decrypt() failed: %d\n", file, err);
-		return 1;
-	}
-
-	len = err;
-
-	asn1 = &RSA_ASN1_templates[hdr->hash_algo];
-
-	if (len < asn1->size || memcmp(out, asn1->data, asn1->size)) {
-		log_err("%s: verification failed: %d (asn1 mismatch)\n",
-			file, err);
-		return -1;
-	}
-
-	len -= asn1->size;
-
-	if (len != size || memcmp(out + asn1->size, hash, len)) {
-		log_err("%s: verification failed: %d (digest mismatch)\n",
-			file, err);
-		return -1;
-	}
-
-	return 0;
+		pkey = read_pub_pkey(keyfile, 1);
+		if (!pkey)
+			return -1;
+		pkey_free = pkey;
+	}
+
+	st = "EVP_PKEY_CTX_new";
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	st = "EVP_PKEY_verify_init";
+	if (!EVP_PKEY_verify_init(ctx))
+		goto err;
+	st = "EVP_get_digestbyname";
+	if (!(md = EVP_get_digestbyname(params.hash_algo)))
+		goto err;
+	st = "EVP_PKEY_CTX_set_signature_md";
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
+	st = "EVP_PKEY_verify";
+	ret = EVP_PKEY_verify(ctx, sig + sizeof(*hdr),
+			      siglen - sizeof(*hdr), hash, size);
+	if (ret == 1)
+		ret = 0;
+	else if (ret == 0) {
+		log_err("%s: verification failed: %d (%s)\n",
+			file, ret, ERR_reason_error_string(ERR_get_error()));
+		ret = 1;
+	}
+err:
+	if (ret < 0 || ret > 1) {
+		log_err("%s: verification failed: %d (%s) in %s\n",
+			file, ret, ERR_reason_error_string(ERR_peek_error()),
+			st);
+		ret = -1;
+	}
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey_free);
+	return ret;
 }
 
 int get_hash_algo(const char *algo)
-- 
2.11.0

