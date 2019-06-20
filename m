Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5F4C7F2
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 09:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfFTHNv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 03:13:51 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40530 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFTHNv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 03:13:51 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3E75C72CC64;
        Thu, 20 Jun 2019 10:13:49 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 1ADBE4A4A29;
        Thu, 20 Jun 2019 10:13:49 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v6 07/11] ima-evm-utils: Replace find_keyid with find_keyid_pkey
Date:   Thu, 20 Jun 2019 10:13:00 +0300
Message-Id: <20190620071304.24495-8-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190620071304.24495-1-vt@altlinux.org>
References: <20190620071304.24495-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Finish conversion of find_keyid to EVP_PKEY API. After verify_hash_v2()
is switched to EVP_PKEY API (in previous commit) old RSA-specific
find_keyid() does not needed anymore and can be replaced with
find_keyid_pkey().

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index c24c67f..d8223e0 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -456,7 +456,7 @@ struct public_key_entry {
 };
 static struct public_key_entry *public_keys = NULL;
 
-static EVP_PKEY *find_keyid_pkey(uint32_t keyid)
+static EVP_PKEY *find_keyid(uint32_t keyid)
 {
 	struct public_key_entry *entry;
 
@@ -467,22 +467,6 @@ static EVP_PKEY *find_keyid_pkey(uint32_t keyid)
 	return NULL;
 }
 
-static RSA *find_keyid(uint32_t keyid)
-{
-	EVP_PKEY *pkey;
-	RSA *key;
-
-	pkey = find_keyid_pkey(keyid);
-	if (!pkey)
-		return NULL;
-	key = EVP_PKEY_get0_RSA(pkey);
-	if (!key) {
-		log_err("find_keyid: unsupported key type\n");
-		return NULL;
-	}
-	return key;
-}
-
 void init_public_keys(const char *keyfiles)
 {
 	struct public_key_entry *entry;
@@ -537,7 +521,7 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	}
 
 	if (public_keys) {
-		pkey = find_keyid_pkey(hdr->keyid);
+		pkey = find_keyid(hdr->keyid);
 		if (!pkey) {
 			log_err("%s: unknown keyid: %x\n", file,
 				__be32_to_cpup(&hdr->keyid));
-- 
2.11.0

