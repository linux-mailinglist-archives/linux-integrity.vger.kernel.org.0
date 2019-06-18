Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16564A2EB
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFRN5j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:57:39 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53282 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFRN5j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:57:39 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2E9D972CCD8;
        Tue, 18 Jun 2019 16:57:36 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id B2ACE4A4A14;
        Tue, 18 Jun 2019 16:57:35 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 04/11] ima-evm-utils: Start converting calc keyid v2 to EVP_PKEY API
Date:   Tue, 18 Jun 2019 16:56:16 +0300
Message-Id: <20190618135623.6861-5-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618135623.6861-1-vt@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce calc_pkeyid_v2() to replace calc_keyid_v2() when we switch to
EVP_PKEY from RSA keys.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/imaevm.h    |  1 +
 src/libimaevm.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/src/imaevm.h b/src/imaevm.h
index 6d5eabd..48d2663 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -220,6 +220,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
 
 void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
 void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key);
+void calc_pkeyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
 int key2bin(RSA *key, unsigned char *pub);
 
 int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 23fa804..707b2e9 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -753,6 +753,36 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	free(pkey);
 }
 
+/*
+ * Calculate keyid of the public_key part of EVP_PKEY
+ */
+void calc_pkeyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
+{
+	X509_PUBKEY *pk = NULL;
+	const unsigned char *public_key = NULL;
+	int len;
+
+	/* This is more generic than i2d_PublicKey() */
+	if (X509_PUBKEY_set(&pk, pkey) &&
+	    X509_PUBKEY_get0_param(NULL, &public_key, &len, NULL, pk)) {
+		uint8_t sha1[SHA_DIGEST_LENGTH];
+
+		SHA1(public_key, len, sha1);
+		/* sha1[12 - 19] is exactly keyid from gpg file */
+		memcpy(keyid, sha1 + 16, 4);
+	} else
+		*keyid = 0;
+
+	log_debug("keyid: ");
+	log_debug_dump(keyid, 4);
+	sprintf(str, "%x", __be32_to_cpup(keyid));
+
+	if (params.verbose > LOG_INFO)
+		log_info("keyid: %s\n", str);
+
+	X509_PUBKEY_free(pk);
+}
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
-- 
2.11.0

