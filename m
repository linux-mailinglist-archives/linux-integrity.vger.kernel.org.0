Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1252C4FAD9
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Jun 2019 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFWJBR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 05:01:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41866 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfFWJBR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 05:01:17 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D672472CC6C;
        Sun, 23 Jun 2019 12:01:14 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 84E944A4A29;
        Sun, 23 Jun 2019 12:01:14 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v7 09/11] ima-evm-utils: Remove RSA_ASN1_templates
Date:   Sun, 23 Jun 2019 12:00:25 +0300
Message-Id: <20190623090027.11852-10-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190623090027.11852-1-vt@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

RSA_ASN1_templates[] are not needed anymore, because we switched to the
generic EVP_PKEY OpenSSL API to generate v2 signatures instead of
constructing PKCS1 ourselves.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/imaevm.h    |  1 -
 src/libimaevm.c | 57 ---------------------------------------------------------
 2 files changed, 58 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 9af43a2..dc81a3a 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -207,7 +207,6 @@ struct RSA_ASN1_template {
 #define	NUM_PCRS 20
 #define DEFAULT_PCR 10
 
-extern const struct RSA_ASN1_template RSA_ASN1_templates[PKEY_HASH__LAST];
 extern struct libevm_params params;
 
 void do_dump(FILE *fp, const void *ptr, int len, bool cr);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index b5b70f7..158b9d1 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -81,63 +81,6 @@ const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
 	[PKEY_HASH_STREEBOG_512] = "streebog512",
 };
 
-/*
- * Hash algorithm OIDs plus ASN.1 DER wrappings [RFC4880 sec 5.2.2].
- */
-static const uint8_t RSA_digest_info_MD5[] = {
-	0x30, 0x20, 0x30, 0x0C, 0x06, 0x08,
-	0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x02, 0x05, /* OID */
-	0x05, 0x00, 0x04, 0x10
-};
-
-static const uint8_t RSA_digest_info_SHA1[] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
-	0x2B, 0x0E, 0x03, 0x02, 0x1A,
-	0x05, 0x00, 0x04, 0x14
-};
-
-static const uint8_t RSA_digest_info_RIPE_MD_160[] = {
-	0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
-	0x2B, 0x24, 0x03, 0x02, 0x01,
-	0x05, 0x00, 0x04, 0x14
-};
-
-static const uint8_t RSA_digest_info_SHA224[] = {
-	0x30, 0x2d, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x04,
-	0x05, 0x00, 0x04, 0x1C
-};
-
-static const uint8_t RSA_digest_info_SHA256[] = {
-	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01,
-	0x05, 0x00, 0x04, 0x20
-};
-
-static const uint8_t RSA_digest_info_SHA384[] = {
-	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02,
-	0x05, 0x00, 0x04, 0x30
-};
-
-static const uint8_t RSA_digest_info_SHA512[] = {
-	0x30, 0x51, 0x30, 0x0d, 0x06, 0x09,
-	0x60, 0x86, 0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x03,
-	0x05, 0x00, 0x04, 0x40
-};
-
-const struct RSA_ASN1_template RSA_ASN1_templates[PKEY_HASH__LAST] = {
-#define _(X) { RSA_digest_info_##X, sizeof(RSA_digest_info_##X) }
-	[PKEY_HASH_MD5]		= _(MD5),
-	[PKEY_HASH_SHA1]	= _(SHA1),
-	[PKEY_HASH_RIPE_MD_160]	= _(RIPE_MD_160),
-	[PKEY_HASH_SHA256]	= _(SHA256),
-	[PKEY_HASH_SHA384]	= _(SHA384),
-	[PKEY_HASH_SHA512]	= _(SHA512),
-	[PKEY_HASH_SHA224]	= _(SHA224),
-#undef _
-};
-
 struct libevm_params params = {
 	.verbose = LOG_INFO - 1,
 	.x509 = 1,
-- 
2.11.0

