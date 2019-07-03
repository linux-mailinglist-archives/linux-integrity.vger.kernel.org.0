Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7E5E824
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCPvZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 11:51:25 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42048 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPvY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 11:51:24 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9CAB572CC6C;
        Wed,  3 Jul 2019 18:51:21 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7E08E4A4AF1;
        Wed,  3 Jul 2019 18:51:21 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v8 8/9] ima-evm-utils: Pass status codes from sign and hash functions to the callers
Date:   Wed,  3 Jul 2019 18:50:14 +0300
Message-Id: <20190703155015.14262-9-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190703155015.14262-1-vt@altlinux.org>
References: <20190703155015.14262-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move sign_hash()/ima_calc_hash()/calc_evm_hmac()/calc_evm_hash() status
checking before assert()'ing of their return values, so it can be passed
to the upper level callers. Especially useful for showing errors.

Fixes: 1d9c279279 ("Define hash and sig buffer sizes and add asserts")
Fixes: 9643544701 ("Fix hash buffer overflow in verify_evm and hmac_evm")
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

ima-evm-utils: Fix assert after ima_calc_hash
---
 src/evmctl.c    | 16 ++++++++--------
 src/libimaevm.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 354d731..4e0a831 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -514,14 +514,14 @@ static int sign_evm(const char *file, const char *key)
 	int len, err;
 
 	len = calc_evm_hash(file, hash);
-	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len <= sizeof(hash));
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
-	assert(len < sizeof(sig));
 	if (len <= 1)
 		return len;
+	assert(len < sizeof(sig));
 
 	/* add header */
 	len++;
@@ -563,9 +563,9 @@ static int hash_ima(const char *file)
 	}
 
 	len = ima_calc_hash(file, hash + offset);
-	assert(len + offset <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len + offset <= sizeof(hash));
 
 	len += offset;
 
@@ -593,14 +593,14 @@ static int sign_ima(const char *file, const char *key)
 	int len, err;
 
 	len = ima_calc_hash(file, hash);
-	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len <= sizeof(hash));
 
 	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
-	assert(len < sizeof(sig));
 	if (len <= 1)
 		return len;
+	assert(len < sizeof(sig));
 
 	/* add header */
 	len++;
@@ -724,9 +724,9 @@ static int cmd_sign_hash(struct command *cmd)
 		hex2bin(hash, line, hashlen / 2);
 		siglen = sign_hash(params.hash_algo, hash, hashlen/2,
 				 key, NULL, sig + 1);
-		assert(siglen < sizeof(sig));
 		if (siglen <= 1)
 			return siglen;
+		assert(siglen < sizeof(sig));
 
 		fwrite(line, len, 1, stdout);
 		fprintf(stdout, " ");
@@ -778,9 +778,9 @@ static int verify_evm(const char *file)
 	int len;
 
 	mdlen = calc_evm_hash(file, hash);
-	assert(mdlen <= sizeof(hash));
 	if (mdlen <= 1)
 		return mdlen;
+	assert(mdlen <= sizeof(hash));
 
 	len = lgetxattr(file, xattr_evm, sig, sizeof(sig));
 	if (len < 0) {
@@ -1160,9 +1160,9 @@ static int hmac_evm(const char *file, const char *key)
 	int len, err;
 
 	len = calc_evm_hmac(file, key, hash);
-	assert(len <= sizeof(hash));
 	if (len <= 1)
 		return len;
+	assert(len <= sizeof(hash));
 
 	log_info("hmac: ");
 	log_dump(hash, len);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index d8e23a3..caf1237 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -618,9 +618,9 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	    return verify_hash(file, digest, digestlen, sig + 1, siglen - 1);
 
 	hashlen = ima_calc_hash(file, hash);
-	assert(hashlen <= sizeof(hash));
 	if (hashlen <= 1)
 		return hashlen;
+	assert(hashlen <= sizeof(hash));
 
 	return verify_hash(file, hash, hashlen, sig + 1, siglen - 1);
 }
-- 
2.11.0

