Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9661892
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 01:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfGGXtC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 19:49:02 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43070 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGGXtC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 19:49:02 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5A94372CC6C;
        Mon,  8 Jul 2019 02:49:00 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 368574A4AE8;
        Mon,  8 Jul 2019 02:49:00 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 1/5] ima-evm-utils: Fix EVP_MD_CTX leak in ima_calc_hash
Date:   Mon,  8 Jul 2019 02:48:33 +0300
Message-Id: <20190707234837.4866-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190707234837.4866-1-vt@altlinux.org>
References: <20190707234837.4866-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When pctx is allocated using EVP_MD_CTX_new() it should be freed.
Found with ASan.

Fixes: 81010f0 ("ima-evm-utils: Add backward compatible support for openssl 1.1")
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 51d6c33..fe1962b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -252,19 +252,21 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	err = lstat(file, &st);
 	if (err < 0) {
 		log_err("Failed to stat: %s\n", file);
-		return err;
+		goto err;
 	}
 
 	md = EVP_get_digestbyname(params.hash_algo);
 	if (!md) {
 		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
-		return 1;
+		err = 1;
+		goto err;
 	}
 
 	err = EVP_DigestInit(pctx, md);
 	if (!err) {
 		log_err("EVP_DigestInit() failed\n");
-		return 1;
+		err = 1;
+		goto err;
 	}
 
 	switch (st.st_mode & S_IFMT) {
@@ -283,19 +285,25 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		break;
 	default:
 		log_errno("Unsupported file type");
-		return -1;
+		err = -1;
+		goto err;
 	}
 
 	if (err)
-		return err;
+		goto err;
 
 	err = EVP_DigestFinal(pctx, hash, &mdlen);
 	if (!err) {
 		log_err("EVP_DigestFinal() failed\n");
-		return 1;
+		err = 1;
+		goto err;
 	}
-
-	return mdlen;
+	err = mdlen;
+err:
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	EVP_MD_CTX_free(pctx);
+#endif
+	return err;
 }
 
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
-- 
2.11.0

