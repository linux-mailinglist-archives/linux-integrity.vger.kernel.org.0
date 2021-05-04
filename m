Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE7372523
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 06:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhEDEgK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 00:36:10 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:35652 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhEDEgK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 00:36:10 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4067F72C8BA;
        Tue,  4 May 2021 07:35:15 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id 24D404A46E8;
        Tue,  4 May 2021 07:35:15 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter0@gmail.com>
Subject: [PATCH v2 3/3] ima-evm-utils: Read keyid from the cert appended to the key file
Date:   Tue,  4 May 2021 07:33:57 +0300
Message-Id: <20210504043357.4093409-4-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210504043357.4093409-1-vt@altlinux.org>
References: <20210504043357.4093409-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow to have certificate appended to the private key of `--key'
specified (PEM) file (for v2 signing) to facilitate reading of keyid
from the associated cert. This will allow users to have private and
public key as a single file. There is no check that public key form the
cert matches associated private key.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 README          |  2 ++
 src/libimaevm.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 0e1f6ba..2c21ba6 100644
--- a/README
+++ b/README
@@ -127,6 +127,8 @@ for signing and importing the key.
 Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
 in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
 
+For v2 signatures x509 certificate with the public key could be appended to the private
+key (both are in PEM format) to properly determine its Subject Key Identifier SKID.
 
 Integrity keyrings
 ----------------
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 481d29d..3607a76 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -57,6 +57,7 @@
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #include <openssl/x509.h>
+#include <openssl/x509v3.h>
 #include <openssl/err.h>
 
 #include "imaevm.h"
@@ -748,6 +749,47 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
 	X509_PUBKEY_free(pk);
 }
 
+/* Try to read keyid from key file (in case it have appended cert). */
+static int read_keyid(const char *keyfile, uint32_t *keyid)
+{
+	int skid_len;
+	const ASN1_OCTET_STRING *skid;
+	X509 *x = NULL;
+	FILE *fp;
+
+	fp = fopen(keyfile, "r");
+	if (!fp) {
+		log_err("Failed to open keyfile: %s\n", keyfile);
+		return 0;
+	}
+	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
+		long error = ERR_GET_REASON(ERR_peek_last_error());
+
+		if (error == PEM_R_NO_START_LINE) {
+			log_debug("No cert in keyfile %s\n", keyfile);
+			ERR_clear_error();
+		} else {
+			log_err("Error reading cert from keyfile %s: %s\n",
+				keyfile, ERR_reason_error_string(error));
+		}
+		fclose(fp);
+		return 0;
+	}
+	fclose(fp);
+	if (!(skid = X509_get0_subject_key_id(x)))
+		return 0;
+	skid_len = ASN1_STRING_length(skid);
+	if (skid_len < sizeof(keyid))
+		return 0;
+	/* keyid is the last 4 bytes of SKID. */
+	memcpy(keyid, ASN1_STRING_get0_data(skid) + skid_len - sizeof(*keyid),
+	       sizeof(*keyid));
+	log_debug("keyid: ");
+	log_debug_dump(keyid, 4);
+	return 1;
+
+}
+
 static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
@@ -932,10 +974,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	if (imaevm_params.keyid)
+	if (imaevm_params.keyid) {
 		hdr->keyid = htonl(imaevm_params.keyid);
-	else
-		calc_keyid_v2(&hdr->keyid, name, pkey);
+	} else {
+		if (!read_keyid(keyfile, &hdr->keyid))
+			calc_keyid_v2(&hdr->keyid, name, pkey);
+	}
 
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
-- 
2.11.0

