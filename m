Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC735E81C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfGCPub (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 11:50:31 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41156 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPub (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 11:50:31 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D0FBB72CC6C;
        Wed,  3 Jul 2019 18:50:28 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8D41B4A4A29;
        Wed,  3 Jul 2019 18:50:28 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v8 0/9] ima-evm-utils: Convert v2 signatures from RSA to EVP_PKEY API
Date:   Wed,  3 Jul 2019 18:50:06 +0300
Message-Id: <20190703155015.14262-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Convert sign v2 from RSA API (with manual formatting PKCS1) to more generic
EVP_PKEY API, allowing to generate more types of OpenSSL supported signatures.
This is done to enable EC-RDSA signatures, which are already supported in the
Kernel. With some small fixes.

All patches tested on x86_64 to not break anything.

Changes since v7:
- Fix freeing pkey returned by find_keyid() in verify_hash_v2.
- Fix assert after ima_calc_hash() before its return status check.
- More verbose error log for sign and verify hash v2.
- Diff from v7 is below.

Changes since v6:
- Remove "Make sure sig buffer is always MAX_SIGNATURE_SIZE" commit. Instead,
  change assumption of sign_hash_v2() about @sig size.
- Add "Log hash_algo with hash value in verbose mode".
- Diff from v6 is below.

Changes since v5:
- Squash calc keyid v2 with cmd_import patch.
- Add log_err messages to verify_hash_v2 and sign_hash_v2.
- Fix sign and hash generation error processing to show errors instead
  of assert failures.

Changes since v4:
- Split conversion into more patches, as suggested by Mimi Zohar.
- Small fixes suggested by Mimi Zohar.

Changes since v3:
- As suggested by Mimi Zohar this is v3 splitted into several patches to
  simplify review. No code changes.

Changes since v2:
- Just rebase over newer commits.

Changes since v1:
- More key neutral code in calc_keyid_v1().
- Fix uninitialized sigsize for EVP_PKEY_sign().
- Fix memory leaks for openssl types.

Vitaly Chikunov (9):
  ima-evm-utils: Convert read_pub_key to EVP_PKEY API
  ima-evm-utils: Convert read_priv_key to EVP_PKEY API
  ima-evm-utils: Convert cmd_import and calc keyid v2 to EVP_PKEY API
  ima-evm-utils: Convert verify_hash_v2 and find_keyid to EVP_PKEY API
  ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API
  ima-evm-utils: Replace calc_keyid_v2 with calc_pkeyid_v2
  ima-evm-utils: Remove RSA_ASN1_templates
  ima-evm-utils: Pass status codes from sign and hash functions to the
    callers
  ima-evm-utils: Log hash_algo with hash value in verbose mode

 src/evmctl.c    |  41 ++++----
 src/imaevm.h    |   4 +-
 src/libimaevm.c | 301 ++++++++++++++++++++++++++++----------------------------
 3 files changed, 176 insertions(+), 170 deletions(-)

-- 
2.11.0

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 5bff414..51d6c33 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -453,10 +453,11 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		   unsigned char *sig, int siglen, const char *keyfile)
 {
 	int ret = -1;
-	EVP_PKEY *pkey;
+	EVP_PKEY *pkey, *pkey_free = NULL;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
 	EVP_PKEY_CTX *ctx;
 	const EVP_MD *md;
+	const char *st;
 
 	if (params.verbose > LOG_INFO) {
 		log_info("hash(%s): ", params.hash_algo);
@@ -474,16 +475,22 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		pkey = read_pub_pkey(keyfile, 1);
 		if (!pkey)
 			return -1;
+		pkey_free = pkey;
 	}
 
+	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
 		goto err;
+	st = "EVP_PKEY_verify_init";
 	if (!EVP_PKEY_verify_init(ctx))
 		goto err;
+	st = "EVP_get_digestbyname";
 	if (!(md = EVP_get_digestbyname(params.hash_algo)))
 		goto err;
+	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
 		goto err;
+	st = "EVP_PKEY_verify";
 	ret = EVP_PKEY_verify(ctx, sig + sizeof(*hdr),
 			      siglen - sizeof(*hdr), hash, size);
 	if (ret == 1)
@@ -495,12 +502,13 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	}
 err:
 	if (ret < 0 || ret > 1) {
-		log_err("%s: verification failed: %d (%s)\n",
-			file, ret, ERR_reason_error_string(ERR_peek_error()));
+		log_err("%s: verification failed: %d (%s) in %s\n",
+			file, ret, ERR_reason_error_string(ERR_peek_error()),
+			st);
 		ret = -1;
 	}
 	EVP_PKEY_CTX_free(ctx);
-	EVP_PKEY_free(pkey);
+	EVP_PKEY_free(pkey_free);
 	return ret;
 }
 
@@ -610,9 +618,9 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	    return verify_hash(file, digest, digestlen, sig + 1, siglen - 1);
 
 	hashlen = ima_calc_hash(file, hash);
-	assert(hashlen <= sizeof(hash));
 	if (hashlen <= 1)
 		return hashlen;
+	assert(hashlen <= sizeof(hash));
 
 	return verify_hash(file, hash, hashlen, sig + 1, siglen - 1);
 }
@@ -850,6 +858,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 	EVP_PKEY_CTX *ctx = NULL;
 	const EVP_MD *md;
 	size_t sigsize;
+	const char *st;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -885,14 +894,19 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 	calc_keyid_v2(&hdr->keyid, name, pkey);
 
+	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
 		goto err;
+	st = "EVP_PKEY_sign_init";
 	if (!EVP_PKEY_sign_init(ctx))
 		goto err;
+	st = "EVP_get_digestbyname";
 	if (!(md = EVP_get_digestbyname(params.hash_algo)))
 		goto err;
+	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
 		goto err;
+	st = "EVP_PKEY_sign";
 	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
 	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
 		goto err;
@@ -905,8 +919,8 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 
 err:
 	if (len == -1)
-		log_err("sign_hash_v2: signing failed: (%s)\n",
-			ERR_reason_error_string(ERR_peek_error()));
+		log_err("sign_hash_v2: signing failed: (%s) in %s\n",
+			ERR_reason_error_string(ERR_peek_error()), st);
 	EVP_PKEY_CTX_free(ctx);
 	EVP_PKEY_free(pkey);
 	return len;
