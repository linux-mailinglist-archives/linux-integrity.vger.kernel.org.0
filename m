Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3345168
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 03:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFNByr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 21:54:47 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41234 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNByr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 21:54:47 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B521172CA65;
        Fri, 14 Jun 2019 04:54:30 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 85A3B4A4AE7;
        Fri, 14 Jun 2019 04:54:30 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 4/5] ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY API
Date:   Fri, 14 Jun 2019 04:54:09 +0300
Message-Id: <20190614015410.26039-5-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190614015410.26039-1-vt@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Convert sign_v2 and related to using more generic EVP_PKEY API instead
of RSA API. This enables more signatures to work out of the box.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    |  25 ++++++----
 src/imaevm.h    |   2 +-
 src/libimaevm.c | 145 ++++++++++++++++++++++++++++++--------------------------
 3 files changed, 93 insertions(+), 79 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index b6333bf..7c398f8 100644
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
+		calc_keyid_v2((uint32_t *)keyid, name, pkey);
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
index 6d5eabd..8c6aeea 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -219,7 +219,7 @@ RSA *read_pub_key(const char *keyfile, int x509);
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
-void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key);
+void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key);
 int key2bin(RSA *key, unsigned char *pub);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index c620c1e..f9bafe3 100644
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
 
@@ -489,7 +489,7 @@ void init_public_keys(const char *keyfiles)
 			break;
 		}
 
-		entry->key = read_pub_key(keyfile, 1);
+		entry->key = read_pub_pkey(keyfile, 1);
 		if (!entry->key) {
 			free(entry);
 			continue;
@@ -506,11 +506,11 @@ void init_public_keys(const char *keyfiles)
 int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		   unsigned char *sig, int siglen, const char *keyfile)
 {
-	int err, len;
-	unsigned char out[1024];
-	RSA *key;
+	int err;
+	EVP_PKEY *pkey;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
-	const struct RSA_ASN1_template *asn1;
+	EVP_PKEY_CTX *ctx;
+	const EVP_MD *md;
 
 	if (params.verbose > LOG_INFO) {
 		log_info("hash: ");
@@ -518,45 +518,39 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
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
+		pkey = read_pub_pkey(keyfile, 1);
+		if (!pkey)
 			return 1;
 	}
 
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	if (!EVP_PKEY_verify_init(ctx))
+		goto err;
+	if (!(md = EVP_get_digestbyname(params.hash_algo)))
+		goto err;
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
+	err = EVP_PKEY_verify(ctx, sig + sizeof(*hdr),
+			      siglen - sizeof(*hdr), hash, size);
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
 
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
+	return err != 1;
+err:
+#ifdef USE_FPRINTF
+	ERR_print_errors_fp(stderr);
+#endif
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
+	return -1;
 }
 
 int get_hash_algo(const char *algo)
@@ -731,16 +725,25 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len
 		log_info("keyid-v1: %s\n", str);
 }
 
-void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
+void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *key)
 {
+	X509_PUBKEY *pk = NULL;
 	uint8_t sha1[SHA_DIGEST_LENGTH];
-	unsigned char *pkey = NULL;
+	const unsigned char *pkey = NULL;
 	int len;
 
-	len = i2d_RSAPublicKey(key, &pkey);
-
+	/* This is more general than i2d_PublicKey() */
+	if (!X509_PUBKEY_set(&pk, key) ||
+	    !X509_PUBKEY_get0_param(NULL, &pkey, &len, NULL, pk) ||
+	    len <= 0) {
+#ifdef USE_FPRINTF
+		ERR_print_errors_fp(stderr);
+#endif
+		/* Produce invalid keyid in case of error. */
+		*keyid = 0;
+		return;
+	}
 	SHA1(pkey, len, sha1);
-
 	/* sha1[12 - 19] is exactly keyid from gpg file */
 	memcpy(keyid, sha1 + 16, 4);
 	log_debug("keyid: ");
@@ -750,7 +753,7 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	if (params.verbose > LOG_INFO)
 		log_info("keyid: %s\n", str);
 
-	free(pkey);
+	X509_PUBKEY_free(pk);
 }
 
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
@@ -889,14 +892,16 @@ out:
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
@@ -921,8 +926,8 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	log_info("hash: ");
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, params.keypass);
-	if (!key)
+	pkey = read_priv_pkey(keyfile, params.keypass);
+	if (!pkey)
 		return -1;
 
 	hdr = (struct signature_v2_hdr *)sig;
@@ -930,32 +935,36 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 	hdr->hash_algo = get_hash_algo(algo);
 
-	calc_keyid_v2(&hdr->keyid, name, key);
-
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
+	calc_keyid_v2(&hdr->keyid, name, pkey);
+
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
+#ifdef USE_FPRINTF
+	ERR_print_errors_fp(stderr);
+#endif
+	EVP_PKEY_CTX_free(ctx);
+	EVP_PKEY_free(pkey);
+	return -1;
 }
 
 
-- 
2.11.0

