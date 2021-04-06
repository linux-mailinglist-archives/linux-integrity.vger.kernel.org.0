Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334B03554A2
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Apr 2021 15:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbhDFNMS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 09:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbhDFNMR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 09:12:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A2C06174A;
        Tue,  6 Apr 2021 06:12:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a12so10397174pfc.7;
        Tue, 06 Apr 2021 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4855aNw2LatAHXTXuzuJc1nAQQQ5xJZ+1xXY2jTJQsE=;
        b=XXZGmLcVT68sBY3mzO2g0lCHyn+uHYijiqN0FsTYMbKR7OwptN+Xb2dLC635oWHPO+
         yCbIy2vCr8RbCFO/wF94xUUJQxqJaFaFc4TuOnB5nUHY4X19Iy6oHoHxJZIBu6JULYlZ
         0F6yBjGRLKgoerSnlGu3V+x3DOEeHW1+WgtQ9XylrDoIYaPYVE3MbyGJr10RPBdW7IND
         2sizdCUmFjJAH7zRAhEvt5GTMuHaArxblA0FH9tXsSSUfvm1Onsng7blkTIvj09rHHqF
         0FtPttOAehjdf9x97p9mZh2BEQ4UhtNobNcBXxjWrl2aYyXMsFOmL0zTA/Q4PpVB0jxO
         mPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4855aNw2LatAHXTXuzuJc1nAQQQ5xJZ+1xXY2jTJQsE=;
        b=q91IwXh7/cNx+QTYrEdZO9ogozQEvH+9Rvk0n0kr1twi5yOCPWfpunYxRHgeetoZhc
         ZYp9JQV4wtJPTD1KelcfWHnXMRoXwp1oVAW6EIDVqw58n6PS+GuiGPAYVmY37LvYPX+r
         PdHgYXETqFXwVtcRNhZop0mlXuAW/q14U4zPe92y/PlCnbALru6jMRttp6Mloit8O32b
         6eNXenygKYl48N4PNTZMou2t065F9GUePhkNMAT6+kxV8glJCDFUYWRSm5HQgDwFh5VS
         1D6H3QovnaenqQRldf88H4a+SiFs4iEKywHEPWkHnszCAdhQdBk8zL9NBwNMFyuyenOi
         ibKg==
X-Gm-Message-State: AOAM533Z6djdhHoEDpp7O7ZbqWlaLcqzEYPoxKkSf9ueSsVAHbXxAEBK
        bjWtCeFsu0ISk3RvW6s8gzjRe/QtPkygPQ==
X-Google-Smtp-Source: ABdhPJxXjgT+ZSCUEazm+W2pAtrVbVyGAT4XZO5RsU2AI+6/F3+eOMRHjn2PSM3IkG728+8F4dsD3w==
X-Received: by 2002:a63:4944:: with SMTP id y4mr27461331pgk.9.1617714728748;
        Tue, 06 Apr 2021 06:12:08 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id i73sm13801351pgc.9.2021.04.06.06.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:12:08 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH 1/5] x509: add support for rsa-pss
Date:   Tue,  6 Apr 2021 21:11:22 +0800
Message-Id: <1617714686-25754-2-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
References: <1617714686-25754-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This patch make x509 support rsa-pss, because the sha algo is
in signature, so we need to parse the sha parameter, and skip
other params.

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 crypto/asymmetric_keys/Makefile           |  7 ++-
 crypto/asymmetric_keys/public_key.c       |  5 +++
 crypto/asymmetric_keys/x509_cert_parser.c | 71 +++++++++++++++++++++++++++++--
 include/linux/oid_registry.h              |  2 +
 4 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 28b91ad..9092de7 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -20,15 +20,20 @@ obj-$(CONFIG_X509_CERTIFICATE_PARSER) += x509_key_parser.o
 x509_key_parser-y := \
 	x509.asn1.o \
 	x509_akid.asn1.o \
+	x509_rsapss_params.asn1.o \
 	x509_cert_parser.o \
 	x509_public_key.o
 
 $(obj)/x509_cert_parser.o: \
 	$(obj)/x509.asn1.h \
-	$(obj)/x509_akid.asn1.h
+	$(obj)/x509_akid.asn1.h \
+	$(obj)/x509_rsapss_params.asn1.h
+
 
 $(obj)/x509.asn1.o: $(obj)/x509.asn1.c $(obj)/x509.asn1.h
 $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
+$(obj)/x509_rsapss_params.asn1.o: \
+	$(obj)/x509_rsapss_params.asn1.c $(obj)/x509_rsapss_params.asn1.h
 
 #
 # PKCS#8 private key handling
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 788a4ba..cf049fd 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -83,6 +83,11 @@ int software_key_determine_akcipher(const char *encoding,
 				     "pkcs1pad(%s,%s)",
 				     pkey->pkey_algo, hash_algo);
 		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
+	} else if (strcmp(encoding, "pss") == 0) {
+		n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+			     "psspad(%s)",
+			     pkey->pkey_algo);
+		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
 	}
 
 	if (strcmp(encoding, "raw") == 0) {
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 52c9b45..ec3428d 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -15,6 +15,7 @@
 #include "x509_parser.h"
 #include "x509.asn1.h"
 #include "x509_akid.asn1.h"
+#include "x509_rsapss_params.asn1.h"
 
 struct x509_parse_context {
 	struct x509_certificate	*cert;		/* Certificate being constructed */
@@ -115,6 +116,17 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 	cert->pub->paramlen = ctx->params_size;
 	cert->pub->algo = ctx->key_algo;
 
+	if (!strcmp(cert->sig->pkey_algo, "rsa") &&
+	    !strcmp(cert->sig->encoding, "pss") &&
+	    cert->pub->paramlen) {
+		ret = asn1_ber_decoder(&x509_rsapss_params_decoder, ctx,
+				       cert->pub->params, cert->pub->paramlen);
+		if (ret < 0) {
+			pr_warn("Couldn't decode rsapss params\n");
+			goto error_decode;
+		}
+	}
+
 	/* Grab the signature bits */
 	ret = x509_get_sig_params(cert);
 	if (ret < 0)
@@ -211,6 +223,10 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 		ctx->cert->sig->hash_algo = "sha1";
 		goto rsa_pkcs1;
 
+	case OID_rsa_pss:
+		ctx->cert->sig->hash_algo = "sha1";
+		goto rsa_pss;
+
 	case OID_sha256WithRSAEncryption:
 		ctx->cert->sig->hash_algo = "sha256";
 		goto rsa_pkcs1;
@@ -245,6 +261,11 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 	ctx->cert->sig->encoding = "pkcs1";
 	ctx->algo_oid = ctx->last_oid;
 	return 0;
+rsa_pss:
+	ctx->cert->sig->pkey_algo = "rsa";
+	ctx->cert->sig->encoding = "pss";
+	ctx->algo_oid = ctx->last_oid;
+	return 0;
 ecrdsa:
 	ctx->cert->sig->pkey_algo = "ecrdsa";
 	ctx->cert->sig->encoding = "raw";
@@ -440,17 +461,59 @@ int x509_note_params(void *context, size_t hdrlen,
 	struct x509_parse_context *ctx = context;
 
 	/*
-	 * AlgorithmIdentifier is used three times in the x509, we should skip
-	 * first and ignore third, using second one which is after subject and
-	 * before subjectPublicKey.
+	 * AlgorithmIdentifier is used three times in the x509,
+	 * rsapss:
+	 * we skip first(same as third) and second(may omit params).
+	 * others:
+	 * we should skip first and ignore third, using second one
+	 * which is after subject and before subjectPublicKey.
 	 */
-	if (!ctx->cert->raw_subject || ctx->key)
+	if (!ctx->cert->raw_subject) {
+		return 0;
+	} else if (strcmp(ctx->cert->sig->pkey_algo, "rsa") ||
+		   strcmp(ctx->cert->sig->encoding, "pss")) {
+		if (ctx->key)
+			return 0;
+	} else if (!ctx->key) {
 		return 0;
+	}
+
 	ctx->params = value - hdrlen;
 	ctx->params_size = vlen + hdrlen;
 	return 0;
 }
 
+int x509_note_rsapss_hash(void *context, size_t hdrlen,
+			  unsigned char tag,
+			  const void *value, size_t vlen)
+{
+	struct x509_parse_context *ctx = context;
+	enum OID oid;
+
+	oid = look_up_OID(value, vlen);
+	switch (oid) {
+	case OID_sha1:
+		ctx->cert->sig->hash_algo = "sha1";
+		break;
+	case OID_sha224:
+		ctx->cert->sig->hash_algo = "sha224";
+		break;
+	case OID_sha256:
+		ctx->cert->sig->hash_algo = "sha256";
+		break;
+	case OID_sha384:
+		ctx->cert->sig->hash_algo = "sha384";
+		break;
+	case OID_sha512:
+		ctx->cert->sig->hash_algo = "sha512";
+		break;
+	default:
+		return -ENOPKG;
+	}
+
+	return 0;
+}
+
 /*
  * Extract the data for the public key algorithm
  */
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 4462ed2..bb22b84 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -28,6 +28,8 @@ enum OID {
 	OID_md3WithRSAEncryption,	/* 1.2.840.113549.1.1.3 */
 	OID_md4WithRSAEncryption,	/* 1.2.840.113549.1.1.4 */
 	OID_sha1WithRSAEncryption,	/* 1.2.840.113549.1.1.5 */
+	OID_rsa_mgf1,			/* 1.2.840.113549.1.1.8 */
+	OID_rsa_pss,			/* 1.2.840.113549.1.1.10 */
 	OID_sha256WithRSAEncryption,	/* 1.2.840.113549.1.1.11 */
 	OID_sha384WithRSAEncryption,	/* 1.2.840.113549.1.1.12 */
 	OID_sha512WithRSAEncryption,	/* 1.2.840.113549.1.1.13 */
-- 
1.8.3.1

