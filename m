Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40FE4FAD5
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Jun 2019 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfFWJBE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 05:01:04 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41574 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfFWJBE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 05:01:04 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 709C872CC6C;
        Sun, 23 Jun 2019 12:01:01 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 483194A4A29;
        Sun, 23 Jun 2019 12:01:01 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 05/11] ima-evm-utils: Convert verify_hash_v2 to EVP_PKEY API
Date:   Sun, 23 Jun 2019 12:00:21 +0300
Message-Id: <20190623090027.11852-6-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190623090027.11852-1-vt@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Rely on OpenSSL API to verify v2 signatures instead of manual PKCS1
decoding.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 74 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index ae18005..c24c67f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -519,14 +519,17 @@ void init_public_keys(const char *keyfiles)
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
+	EVP_PKEY *pkey;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
-	const struct RSA_ASN1_template *asn1;
+	EVP_PKEY_CTX *ctx;
+	const EVP_MD *md;
 
 	if (params.verbose > LOG_INFO) {
 		log_info("hash: ");
@@ -534,45 +537,44 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	}
 
 	if (public_keys) {
-		key = find_keyid(hdr->keyid);
-		if (!key) {
+		pkey = find_keyid_pkey(hdr->keyid);
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
+		pkey = read_pub_pkey(keyfile, 1);
+		if (!pkey)
+			return -1;
 	}
 
-	return 0;
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	if (!EVP_PKEY_verify_init(ctx))
+		goto err;
+	if (!(md = EVP_get_digestbyname(params.hash_algo)))
+		goto err;
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
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
+		log_err("%s: verification failed: %d (%s)\n",
+			file, ret, ERR_reason_error_string(ERR_peek_error()));
+		ret = -1;
+	}
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
+	return ret;
 }
 
 int get_hash_algo(const char *algo)
-- 
2.11.0

