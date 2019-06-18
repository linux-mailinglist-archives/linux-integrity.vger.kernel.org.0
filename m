Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467124A2F0
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfFRN6A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:58:00 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53658 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRN57 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:57:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9098472CCD8;
        Tue, 18 Jun 2019 16:57:56 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 22BE34A4A14;
        Tue, 18 Jun 2019 16:57:56 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 09/11] ima-evm-utils: Convert sign_hash_v2 to use EVP_PKEY API
Date:   Tue, 18 Jun 2019 16:56:21 +0300
Message-Id: <20190618135623.6861-10-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618135623.6861-1-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
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
 src/libimaevm.c | 51 +++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 3b646e5..7b8ce92 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -905,14 +905,16 @@ out:
 	return len;
 }
 
+/* @sig is assumed to be of MAX_SIGNATURE_SIZE size */
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
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -937,8 +939,8 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	log_info("hash: ");
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, params.keypass);
-	if (!key)
+	pkey = read_priv_pkey(keyfile, params.keypass);
+	if (!pkey)
 		return -1;
 
 	hdr = (struct signature_v2_hdr *)sig;
@@ -946,32 +948,33 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
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
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	if (!EVP_PKEY_sign_init(ctx))
+		goto err;
+	if (!(md = EVP_get_digestbyname(params.hash_algo)))
+		goto err;
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
+	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr);
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
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
 	return len;
+err:
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
+	return -1;
 }
 
 
-- 
2.11.0

