Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D37F356D8E
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347443AbhDGNmg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbhDGNmf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 09:42:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3EC061756;
        Wed,  7 Apr 2021 06:42:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so1321360pjh.1;
        Wed, 07 Apr 2021 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RXpGoECnABbMM22hK5o6CXh2/bHEcLBFgoj8YgTixjA=;
        b=nl5NFcitWCoBzwYHym0fZm2hGaD5qW56FYM/AHAUPiBmu+/CofUaxc6E3lLsE43Pog
         RG/mWjn/wGBUL29tjlqTWU3m2eMTBocU2KcjRhx4mxXm7WL3N4ZLH/a4EOVc9DRGyVFK
         2rQ4FAbqk1Mo/cv2PuG+Ij7Q5EsfVk+7JPyB1xv3c6A/PDRqiSQJL2tUDZm0blCs4JVC
         cDGKPFTk/02jGVf5l+8WNfJ2sAkWzokoyO04e2mRK4wgF8qE2fQX1oE8RVQjAIgPAuLI
         O469YOw8PgRBv92iZrmVzWE8qpIeufyWeUsnxFB2YjjypO3KclC3rVSuNI7q17pCvD1g
         G8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RXpGoECnABbMM22hK5o6CXh2/bHEcLBFgoj8YgTixjA=;
        b=i8UF2XfyozfpgTakTHjYv7SHPmN9Baq+OCa43UQ3s0RxDjxvxQEsq/5FYuUqElXbW+
         9jan9rnfPhHEVICNT7CpTVZrvAcSOaCUWyd0FupINOi29hFXvR7YhxbdKQRN2LBmCVVl
         lOoI9eGQ967DFJO9h3vmlLxsYZb0eYshn1at3VvLZ8ZJsy/qIawt7KICrm9ZAiCR+bqt
         yKrH6HzEMEGLBQmeUsYk/GpONi8keLG4rQoShscgacH1nRABsGiqXsQg35SfwDa5XuLl
         /ZswordJAc15DXmyF644xWWEnIEYlGgsMrH/ollXvMx/1H/rudooqYkWmWNIJa+G4HHZ
         BpQQ==
X-Gm-Message-State: AOAM531AKAjCP3Q51ubj+Vu65AF17JhpyzUk9L4Ugb9YowoUvrEP8N5O
        bGajUsxXVEBJOovpg54Go1Os4KkfTM5hIw==
X-Google-Smtp-Source: ABdhPJy9xRtv0NPaQ6RJLLPVJua7XL8kZepnx8Mw8O4lNfPEQPDKnB2Cxplri6xJajmcG2MOpRnkww==
X-Received: by 2002:a17:902:8641:b029:e4:7e05:c916 with SMTP id y1-20020a1709028641b02900e47e05c916mr2950997plt.57.1617802945172;
        Wed, 07 Apr 2021 06:42:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id t65sm1547350pfd.5.2021.04.07.06.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 06:42:24 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        herbert.tencent@gmail.com
Subject: [PATCH v4 1/4] x509: add support for rsa-pss
Date:   Wed,  7 Apr 2021 21:41:43 +0800
Message-Id: <1617802906-30513-2-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617802906-30513-1-git-send-email-herbert.tencent@gmail.com>
References: <1617802906-30513-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch make x509 support rsa with pss encoding. The sha algo is
in the RSASSA-PSS-params, so we need to parse the sha parameter, and
could skip other params.

Also add two oids used by rsa-pss.

Signed-off-by: Hongbo Li <herbert.tencent@gmail.com>
---
 crypto/asymmetric_keys/Makefile                |  7 ++-
 crypto/asymmetric_keys/public_key.c            |  5 ++
 crypto/asymmetric_keys/x509_cert_parser.c      | 71 ++++++++++++++++++++++++--
 crypto/asymmetric_keys/x509_rsapss_params.asn1 | 19 +++++++
 include/linux/oid_registry.h                   |  2 +
 5 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 crypto/asymmetric_keys/x509_rsapss_params.asn1

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
index 4fefb21..8f16d4d 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -84,6 +84,11 @@ int software_key_determine_akcipher(const char *encoding,
 				     "pkcs1pad(%s,%s)",
 				     pkey->pkey_algo, hash_algo);
 		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
+	} else if (strcmp(encoding, "pss") == 0) {
+		n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+			     "psspad(%s)",
+			     pkey->pkey_algo);
+		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
 	}
 
 	if (strcmp(encoding, "raw") == 0 ||
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 6d00309..c2e5437 100644
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
@@ -265,6 +281,11 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
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
@@ -466,17 +487,59 @@ int x509_note_params(void *context, size_t hdrlen,
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
diff --git a/crypto/asymmetric_keys/x509_rsapss_params.asn1 b/crypto/asymmetric_keys/x509_rsapss_params.asn1
new file mode 100644
index 0000000..d49166e
--- /dev/null
+++ b/crypto/asymmetric_keys/x509_rsapss_params.asn1
@@ -0,0 +1,19 @@
+RSAPSS_Params ::= SEQUENCE {
+	hashAlgorithm		[0] HashAlgorithm OPTIONAL,
+	maskGenAlgorithm	[1] MaskGenAlgorithm OPTIONAL,
+	saltLen			[2] INTEGER OPTIONAL,
+	trailerField		[3] INTEGER OPTIONAL
+	}
+
+HashAlgorithm ::= SEQUENCE {
+	algorithm	OBJECT IDENTIFIER ({ x509_note_rsapss_hash })
+	}
+
+MaskGenAlgorithm ::= SEQUENCE {
+	algorithm	OBJECT IDENTIFIER,
+	hashAlgorithm	MgfHashAlgorithm
+	}
+
+MgfHashAlgorithm ::= SEQUENCE {
+	algorithm	OBJECT IDENTIFIER
+	}
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index cc64d94..f6eb783 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -34,6 +34,8 @@ enum OID {
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

