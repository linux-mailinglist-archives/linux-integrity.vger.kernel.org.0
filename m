Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093D34FAD1
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Jun 2019 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfFWJAs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 05:00:48 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41146 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfFWJAs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 05:00:48 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2358C72CC6C;
        Sun, 23 Jun 2019 12:00:45 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8D3B94A4A29;
        Sun, 23 Jun 2019 12:00:44 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 01/11] ima-evm-utils: Convert read_pub_key to EVP_PKEY API
Date:   Sun, 23 Jun 2019 12:00:17 +0300
Message-Id: <20190623090027.11852-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190623090027.11852-1-vt@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce read_pub_pkey() to read keys using EVP_PKEY, and change
read_pub_key() to be wrapper for it.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/imaevm.h    |  1 +
 src/libimaevm.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index c81bf21..6d5eabd 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -216,6 +216,7 @@ int get_filesize(const char *filename);
 int ima_calc_hash(const char *file, uint8_t *hash);
 int get_hash_algo(const char *algo);
 RSA *read_pub_key(const char *keyfile, int x509);
+EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
 void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 3a9ab63..da0f422 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -355,10 +355,9 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 	return mdlen;
 }
 
-RSA *read_pub_key(const char *keyfile, int x509)
+EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
-	RSA *key = NULL;
 	X509 *crt = NULL;
 	EVP_PKEY *pkey = NULL;
 
@@ -375,24 +374,36 @@ RSA *read_pub_key(const char *keyfile, int x509)
 			goto out;
 		}
 		pkey = X509_extract_key(crt);
+		X509_free(crt);
 		if (!pkey) {
 			log_err("X509_extract_key() failed\n");
 			goto out;
 		}
-		key = EVP_PKEY_get1_RSA(pkey);
 	} else {
-		key = PEM_read_RSA_PUBKEY(fp, NULL, NULL, NULL);
+		pkey = PEM_read_PUBKEY(fp, NULL, NULL, NULL);
+		if (!pkey)
+			log_err("PEM_read_PUBKEY() failed\n");
 	}
 
-	if (!key)
-		log_err("PEM_read_RSA_PUBKEY() failed\n");
-
 out:
-	if (pkey)
-		EVP_PKEY_free(pkey);
-	if (crt)
-		X509_free(crt);
 	fclose(fp);
+	return pkey;
+}
+
+RSA *read_pub_key(const char *keyfile, int x509)
+{
+	EVP_PKEY *pkey;
+	RSA *key;
+
+	pkey = read_pub_pkey(keyfile, x509);
+	if (!pkey)
+		return NULL;
+	key = EVP_PKEY_get1_RSA(pkey);
+	EVP_PKEY_free(pkey);
+	if (!key) {
+		log_err("read_pub_key: unsupported key type\n");
+		return NULL;
+	}
 	return key;
 }
 
-- 
2.11.0

