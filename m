Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80B6D68D
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfGRVfW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 17:35:22 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53152 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRVfV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 17:35:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 001EF72CA65;
        Fri, 19 Jul 2019 00:35:19 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id AF8E14A4A29;
        Fri, 19 Jul 2019 00:35:18 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/3] ima-evm-utils: Remove not needed argument from verify_hash_v2
Date:   Fri, 19 Jul 2019 00:35:09 +0300
Message-Id: <20190718213510.10829-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190718213510.10829-1-vt@altlinux.org>
References: <20190718213510.10829-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since we now always call verify_hash_v2() with NULL keyfile (assuming
all keys are already loaded into public_keys list), remove keyfile
argument and its handling from verify_hash_v2().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 97b7167..b153f1b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -453,7 +453,7 @@ void init_public_keys(const char *keyfiles)
  * Return: 0 verification good, 1 verification bad, -1 error.
  */
 int verify_hash_v2(const char *file, const unsigned char *hash, int size,
-		   unsigned char *sig, int siglen, const char *keyfile)
+		   unsigned char *sig, int siglen)
 {
 	int ret = -1;
 	EVP_PKEY *pkey, *pkey_free = NULL;
@@ -467,20 +467,13 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		log_dump(hash, size);
 	}
 
-	if (public_keys) {
+	pkey = find_keyid(hdr->keyid);
+	if (!pkey) {
 		uint32_t keyid = hdr->keyid;
 
-		pkey = find_keyid(keyid);
-		if (!pkey) {
-			log_err("%s: unknown keyid: %x\n", file,
-				__be32_to_cpup(&keyid));
-			return -1;
-		}
-	} else {
-		pkey = read_pub_pkey(keyfile, 1);
-		if (!pkey)
-			return -1;
-		pkey_free = pkey;
+		log_err("%s: unknown keyid: %x\n", file,
+			__be32_to_cpup(&keyid));
+		return -1;
 	}
 
 	st = "EVP_PKEY_CTX_new";
@@ -581,7 +574,7 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
 			key = "/etc/keys/pubkey_evm.pem";
 		return verify_hash_v1(file, hash, size, sig, siglen, key);
 	} else if (sig[0] == DIGSIG_VERSION_2) {
-		return verify_hash_v2(file, hash, size, sig, siglen, NULL);
+		return verify_hash_v2(file, hash, size, sig, siglen);
 	} else
 		return -1;
 }
-- 
2.11.0

