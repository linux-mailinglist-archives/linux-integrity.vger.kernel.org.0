Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C78FA4FAD0
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Jun 2019 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfFWJAm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 05:00:42 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41056 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFWJAl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 05:00:41 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AB59A72CC6C;
        Sun, 23 Jun 2019 12:00:38 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 69E024A4A29;
        Sun, 23 Jun 2019 12:00:38 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 00/11] ima-evm-utils: Convert v2 signatures from RSA to EVP_PKEY API
Date:   Sun, 23 Jun 2019 12:00:16 +0300
Message-Id: <20190623090027.11852-1-vt@altlinux.org>
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

Vitaly Chikunov (11):
  ima-evm-utils: Convert read_pub_key to EVP_PKEY API
  ima-evm-utils: Convert read_priv_key to EVP_PKEY API
  ima-evm-utils: Convert cmd_import and calc keyid v2 to EVP_PKEY API
  ima-evm-utils: Start converting find_keyid to EVP_PKEY API
  ima-evm-utils: Convert verify_hash_v2 to EVP_PKEY API
  ima-evm-utils: Replace find_keyid with find_keyid_pkey
  ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API
  ima-evm-utils: Replace calc_keyid_v2 with calc_pkeyid_v2
  ima-evm-utils: Remove RSA_ASN1_templates
  ima-evm-utils: Pass status codes from sign and hash functions to the
    callers
  ima-evm-utils: Log hash_algo with hash value in verbose mode

 src/evmctl.c    |  41 +++++----
 src/imaevm.h    |   4 +-
 src/libimaevm.c | 281 +++++++++++++++++++++++++++-----------------------------
 3 files changed, 159 insertions(+), 167 deletions(-)

-- 
2.11.0

---
Diff from v6:

diff --git a/src/evmctl.c b/src/evmctl.c
index 63ae1a6..4e0a831 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 static int sign_evm(const char *file, const char *key)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
-	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len, err;
 
 	len = calc_evm_hash(file, hash);
@@ -521,7 +521,7 @@ static int sign_evm(const char *file, const char *key)
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
 	if (len <= 1)
 		return len;
-	assert(len <= MAX_SIGNATURE_SIZE);
+	assert(len < sizeof(sig));
 
 	/* add header */
 	len++;
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 9e90d07..5bff414 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -459,7 +459,7 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	const EVP_MD *md;
 
 	if (params.verbose > LOG_INFO) {
-		log_info("hash: ");
+		log_info("hash(%s): ", params.hash_algo);
 		log_dump(hash, size);
 	}
 
@@ -838,7 +838,7 @@ out:
 }
 
 /*
- * @sig is assumed to be of MAX_SIGNATURE_SIZE size
+ * @sig is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
  * Return: -1 signing error, >0 length of signature
  */
 int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const char *keyfile, unsigned char *sig)
@@ -871,7 +871,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 		return -1;
 	}
 
-	log_info("hash: ");
+	log_info("hash(%s): ", params.hash_algo);
 	log_dump(hash, size);
 
 	pkey = read_priv_pkey(keyfile, params.keypass);
@@ -893,7 +893,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 		goto err;
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
 		goto err;
-	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr);
+	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
 	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
 		goto err;
 	len = (int)sigsize;
