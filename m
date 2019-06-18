Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC91E4A2EA
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFRN5d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:57:33 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53230 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFRN5d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:57:33 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A45D472CCD8;
        Tue, 18 Jun 2019 16:57:31 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5E7394A4A14;
        Tue, 18 Jun 2019 16:57:31 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 03/11] ima-evm-utils: Change read_priv_key to use EVP_PKEY API
Date:   Tue, 18 Jun 2019 16:56:15 +0300
Message-Id: <20190618135623.6861-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618135623.6861-1-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce read_priv_pkey() to read keys using EVP_PKEY, and change
read_priv_key() to be wrapper for it.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index da0f422..23fa804 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -753,10 +753,10 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	free(pkey);
 }
 
-static RSA *read_priv_key(const char *keyfile, const char *keypass)
+static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
-	RSA *key;
+	EVP_PKEY *pkey;
 
 	fp = fopen(keyfile, "r");
 	if (!fp) {
@@ -764,15 +764,32 @@ static RSA *read_priv_key(const char *keyfile, const char *keypass)
 		return NULL;
 	}
 	ERR_load_crypto_strings();
-	key = PEM_read_RSAPrivateKey(fp, NULL, NULL, (void *)keypass);
-	if (!key) {
+	pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
+	if (!pkey) {
 		char str[256];
 
 		ERR_error_string(ERR_get_error(), str);
-		log_err("PEM_read_RSAPrivateKey() failed: %s\n", str);
+		log_err("PEM_read_PrivateKey() failed: %s\n", str);
 	}
 
 	fclose(fp);
+	return pkey;
+}
+
+static RSA *read_priv_key(const char *keyfile, const char *keypass)
+{
+	EVP_PKEY *pkey;
+	RSA *key;
+
+	pkey = read_priv_pkey(keyfile, keypass);
+	if (!pkey)
+		return NULL;
+	key = EVP_PKEY_get1_RSA(pkey);
+	EVP_PKEY_free(pkey);
+	if (!key) {
+		log_err("read_priv_key: unsupported key type\n");
+		return NULL;
+	}
 	return key;
 }
 
-- 
2.11.0

