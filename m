Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54B4C802
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 09:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFTHOM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 03:14:12 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40930 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTHOL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 03:14:11 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B576672CC64;
        Thu, 20 Jun 2019 10:14:08 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 92CDE4A4A29;
        Thu, 20 Jun 2019 10:14:08 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v6 11/11] ima-evm-utils: Pass status codes from sign and hash functions to the callers
Date:   Thu, 20 Jun 2019 10:13:04 +0300
Message-Id: <20190620071304.24495-12-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190620071304.24495-1-vt@altlinux.org>
References: <20190620071304.24495-1-vt@altlinux.org>
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
---
 src/evmctl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index ded18c6..63ae1a6 100644
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
-	assert(len <= MAX_SIGNATURE_SIZE);
 	if (len <= 1)
 		return len;
+	assert(len <= MAX_SIGNATURE_SIZE);
 
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
-- 
2.11.0

