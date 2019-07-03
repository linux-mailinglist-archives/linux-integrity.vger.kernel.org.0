Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF25E821
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCPvD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 11:51:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41770 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCPvD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 11:51:03 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3580372CC6C;
        Wed,  3 Jul 2019 18:51:01 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 128064A4A29;
        Wed,  3 Jul 2019 18:51:01 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v8 5/9] ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API
Date:   Wed,  3 Jul 2019 18:50:11 +0300
Message-Id: <20190703155015.14262-6-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190703155015.14262-1-vt@altlinux.org>
References: <20190703155015.14262-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Convert sign_hash_v2() to use more generic EVP_PKEY API instead of RSA
API. This enables generation of more signatures out of the box, such as
EC-RDSA (GOST) and any other that OpenSSL supports. This conversion also
fixes generation of MD4 signatures, because it didn't have proper
RSA_ASN1_template.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 60 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 4c98cb0..213855c 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -924,14 +924,20 @@ out:
 	return len;
 }
 
+/*
+ * @sig is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
+ * Return: -1 signing error, >0 length of signature
+ */
 int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const char *keyfile, unsigned char *sig)
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
-	RSA *key;
+	EVP_PKEY *pkey;
 	char name[20];
-	unsigned char *buf;
-	const struct RSA_ASN1_template *asn1;
+	EVP_PKEY_CTX *ctx = NULL;
+	const EVP_MD *md;
+	size_t sigsize;
+	const char *st;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -956,8 +962,8 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	log_info("hash: ");
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, params.keypass);
-	if (!key)
+	pkey = read_priv_pkey(keyfile, params.keypass);
+	if (!pkey)
 		return -1;
 
 	hdr = (struct signature_v2_hdr *)sig;
@@ -965,31 +971,37 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 	hdr->hash_algo = get_hash_algo(algo);
 
-	calc_keyid_v2(&hdr->keyid, name, key);
+	calc_pkeyid_v2(&hdr->keyid, name, pkey);
 
-	asn1 = &RSA_ASN1_templates[hdr->hash_algo];
-
-	buf = malloc(size + asn1->size);
-	if (!buf)
-		goto out;
-
-	memcpy(buf, asn1->data, asn1->size);
-	memcpy(buf + asn1->size, hash, size);
-	len = RSA_private_encrypt(size + asn1->size, buf, hdr->sig,
-				  key, RSA_PKCS1_PADDING);
-	if (len < 0) {
-		log_err("RSA_private_encrypt() failed: %d\n", len);
-		goto out;
-	}
+	st = "EVP_PKEY_CTX_new";
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	st = "EVP_PKEY_sign_init";
+	if (!EVP_PKEY_sign_init(ctx))
+		goto err;
+	st = "EVP_get_digestbyname";
+	if (!(md = EVP_get_digestbyname(params.hash_algo)))
+		goto err;
+	st = "EVP_PKEY_CTX_set_signature_md";
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
+	st = "EVP_PKEY_sign";
+	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
+	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
+		goto err;
+	len = (int)sigsize;
 
 	/* we add bit length of the signature to make it gnupg compatible */
 	hdr->sig_size = __cpu_to_be16(len);
 	len += sizeof(*hdr);
 	log_info("evm/ima signature: %d bytes\n", len);
-out:
-	if (buf)
-		free(buf);
-	RSA_free(key);
+
+err:
+	if (len == -1)
+		log_err("sign_hash_v2: signing failed: (%s) in %s\n",
+			ERR_reason_error_string(ERR_peek_error()), st);
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
 	return len;
 }
 
-- 
2.11.0

