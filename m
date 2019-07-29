Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45183784E0
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jul 2019 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfG2GSK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Jul 2019 02:18:10 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52484 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2GSK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Jul 2019 02:18:10 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 962E472CC6C;
        Mon, 29 Jul 2019 09:18:08 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 73F384A4A29;
        Mon, 29 Jul 2019 09:18:08 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Allow EVM verify to determine hash algo
Date:   Mon, 29 Jul 2019 09:18:07 +0300
Message-Id: <20190729061807.3278-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Previously for EVM verify you should specify `--hashalgo' option while
for IMA ima_verify you didn't.

Allow EVM verify to determine hash algo from signature.

Also, this makes two previously static functions to become exportable
and renamed:

  get_hash_algo_from_sig -> imaevm_hash_algo_from_sig
  get_hash_algo_by_id    -> imaevm_hash_algo_by_id

This is needed because EVM hash is calculated (in calc_evm_hash) outside
of library.

imaevm_hash_algo_by_id() will now return NULL if algo is not found.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c    | 18 +++++++++++++-----
 src/imaevm.h    |  2 ++
 src/libimaevm.c | 10 +++++-----
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0f821e4..e7e5fbf 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -810,14 +810,10 @@ static int verify_evm(const char *file)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
+	int sig_hash_algo;
 	int mdlen;
 	int len;
 
-	mdlen = calc_evm_hash(file, hash);
-	if (mdlen <= 1)
-		return mdlen;
-	assert(mdlen <= sizeof(hash));
-
 	len = lgetxattr(file, xattr_evm, sig, sizeof(sig));
 	if (len < 0) {
 		log_err("getxattr failed: %s\n", file);
@@ -829,6 +825,18 @@ static int verify_evm(const char *file)
 		return -1;
 	}
 
+	sig_hash_algo = imaevm_hash_algo_from_sig(sig + 1);
+	if (sig_hash_algo < 0) {
+		log_err("unknown hash algo: %s\n", file);
+		return -1;
+	}
+	imaevm_params.hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
+
+	mdlen = calc_evm_hash(file, hash);
+	if (mdlen <= 1)
+		return mdlen;
+	assert(mdlen <= sizeof(hash));
+
 	return verify_hash(file, hash, mdlen, sig + 1, len - 1);
 }
 
diff --git a/src/imaevm.h b/src/imaevm.h
index b881d92..30e9730 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -223,5 +223,7 @@ int sign_hash(const char *algo, const unsigned char *hash, int size, const char
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
 int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsigned char *digest, int digestlen);
 void init_public_keys(const char *keyfiles);
+int imaevm_hash_algo_from_sig(unsigned char *sig);
+const char *imaevm_hash_algo_by_id(int algo);
 
 #endif
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 4f4b207..c35a47d 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -105,7 +105,7 @@ void imaevm_hexdump(const void *ptr, int len)
 	imaevm_do_hexdump(stdout, ptr, len, true);
 }
 
-static const char *get_hash_algo_by_id(int algo)
+const char *imaevm_hash_algo_by_id(int algo)
 {
 	if (algo < PKEY_HASH__LAST)
 		return pkey_hash_algo[algo];
@@ -113,7 +113,7 @@ static const char *get_hash_algo_by_id(int algo)
 		return hash_algo_name[algo];
 
 	log_err("digest %d not found\n", algo);
-	return "unknown";
+	return NULL;
 }
 
 /* Output all remaining openssl error messages. */
@@ -575,7 +575,7 @@ int imaevm_get_hash_algo(const char *algo)
 	return -1;
 }
 
-static int get_hash_algo_from_sig(unsigned char *sig)
+int imaevm_hash_algo_from_sig(unsigned char *sig)
 {
 	uint8_t hashalgo;
 
@@ -632,13 +632,13 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 		return -1;
 	}
 
-	sig_hash_algo = get_hash_algo_from_sig(sig + 1);
+	sig_hash_algo = imaevm_hash_algo_from_sig(sig + 1);
 	if (sig_hash_algo < 0) {
 		log_err("Invalid signature\n");
 		return -1;
 	}
 	/* Use hash algorithm as retrieved from signature */
-	imaevm_params.hash_algo = get_hash_algo_by_id(sig_hash_algo);
+	imaevm_params.hash_algo = imaevm_hash_algo_by_id(sig_hash_algo);
 
 	/*
 	 * Validate the signature based on the digest included in the
-- 
2.11.0

