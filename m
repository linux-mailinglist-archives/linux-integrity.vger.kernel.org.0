Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580FE31FF14
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSS65 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 13:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSS64 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 13:58:56 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB306C061756;
        Fri, 19 Feb 2021 10:58:15 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id z190so6524142qka.9;
        Fri, 19 Feb 2021 10:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KrQXwiQOrYdmdBeohS17LUCH0SNmxvLabDc2BiEUeQw=;
        b=K9O6Q01/YkrYTXjpSjGE0WZR9RMEVZpyrV/z4mB0O8d90xUbkpZ2UrQog4aL3V6Vr7
         JhGyOunVkvfoe5LuNDPKC/q9pubvqYJQg3MUaLB5/Jb3be984isodU0cg7G348QXwImE
         Aq0uzJJg5k2PYVXkpYI6LpOcZVT/0xSmdZa5FZtcGiN6LYx5y9bbcVINtkrLaaiaYAyu
         bYTa02aP3rQbOPk7W0noxBEdPEZpXvNQIM3FsyiDzhkt/crvgyv/kfMpO+ZnFDTDIo36
         AMC29X7uxSMUb1XfaGLQcghw62bL3T/Hwd+8eQ4AEe80eJb5BLviQWF1ywnnD3eS21wV
         5ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KrQXwiQOrYdmdBeohS17LUCH0SNmxvLabDc2BiEUeQw=;
        b=ZDmZEN63WXwIPXeCXFFmpupbrsvc3bIlM0GlHrjXER5KibRljgbDm8YhjGWhNZ8Bo3
         FayPiYgcLLTr3/Ouk13ohIaxUKDgiPd538VckUu7UwIBKSRBFzcfvVtmDCGgxDe46nid
         vJ/q93Ypo+bU+6JRkaE3yIzQqTHbjJSY9FCK5JFe+4kzLlQ7XffhsHH5lg92Kfen3PaD
         iavs8psFiYteyvIE86zpUXKqmxb+/mKmoyIHBNfA7EQwZZREOQJJRmOhtkbt9/so02mq
         2kmbPtYph/0WunbFVXKl0u3SnHG8xb9e9rZMb3FySc+fH1S25TkqL56VcN3YG4L55aQn
         rWeQ==
X-Gm-Message-State: AOAM532L81azXc8Mjo1GXx6aRfK8PparH6D23KLaCFvFYw30NmkNcMAM
        gWiNH8jQH7vhbGasrpZjMzsN3/zzX1tO4Lpy
X-Google-Smtp-Source: ABdhPJzUQKajXSakO+XOjONnWcHAb9jFXnLa9wh9fCuCQuxvuPyavCeG5TXEdh+ap4LgR0QUCuCWkA==
X-Received: by 2002:a37:7f03:: with SMTP id a3mr10785166qkd.16.1613761095092;
        Fri, 19 Feb 2021 10:58:15 -0800 (PST)
Received: from localhost.localdomain ([189.61.66.20])
        by smtp.gmail.com with ESMTPSA id t54sm6109523qte.8.2021.02.19.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:58:14 -0800 (PST)
From:   Saulo Alessandre <saulo.alessandre@gmail.com>
To:     stefanb@linux.ibm.com
Cc:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        zohar@linux.ibm.com, Saulo Alessandre <saulo.alessandre@tse.jus.br>
Subject: [PATCH 1/3] add params and ids to support nist_p384
Date:   Fri, 19 Feb 2021 15:57:57 -0300
Message-Id: <20210219185759.1033764-1-saulo.alessandre@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215162532.1077098-1-stefanb@linux.ibm.com>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Saulo Alessandre <saulo.alessandre@tse.jus.br>

* crypto/asymmetric_keys/x509_cert_parser.c
  - prepare x509 parser to load nist_secpp384r1

* crypto/ecc_curve_defs.h
  - add nist_p384 params

* include/crypto/ecdh.h
  - add ECC_CURVE_NIST_P384

* include/linux/oid_registry.h
  - reorder OID_id_ecdsa_with_sha1
  - add OID_id_secp384r1
---
 crypto/asymmetric_keys/x509_cert_parser.c |  3 +++
 crypto/ecc_curve_defs.h                   | 32 +++++++++++++++++++++++
 include/crypto/ecdh.h                     |  1 +
 include/linux/oid_registry.h              |  3 ++-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index d6d72420307c..03535bd8b8ef 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -512,6 +512,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 		case OID_id_prime256v1:
 			ctx->cert->pub->pkey_algo = "ecdsa-nist-p256";
 			break;
+		case OID_id_secp384r1:
+			ctx->cert->pub->pkey_algo = "ecdsa-nist-p384";
+			break;
 		default:
 			return -ENOPKG;
 		}
diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
index 69be6c7d228f..b327732f6ef5 100644
--- a/crypto/ecc_curve_defs.h
+++ b/crypto/ecc_curve_defs.h
@@ -54,4 +54,36 @@ static struct ecc_curve nist_p256 = {
 	.b = nist_p256_b
 };
 
+/* NIST P-384 */
+static u64 nist_p384_g_x[] = { 0x3A545E3872760AB7ull, 0x5502F25DBF55296Cull,
+				0x59F741E082542A38ull, 0x6E1D3B628BA79B98ull,
+				0x8Eb1C71EF320AD74ull, 0xAA87CA22BE8B0537ull };
+static u64 nist_p384_g_y[] = { 0x7A431D7C90EA0E5Full, 0x0A60B1CE1D7E819Dull,
+				0xE9DA3113B5F0B8C0ull, 0xF8F41DBD289A147Cull,
+				0x5D9E98BF9292DC29ull, 0x3617DE4A96262C6Full };
+static u64 nist_p384_p[] = { 0x00000000FFFFFFFFull, 0xFFFFFFFF00000000ull,
+				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
+static u64 nist_p384_n[] = { 0xECEC196ACCC52973ull, 0x581A0DB248B0A77Aull,
+				0xC7634D81F4372DDFull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
+static u64 nist_p384_a[] = { 0x00000000FFFFFFFCull, 0xFFFFFFFF00000000ull,
+				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
+				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
+static u64 nist_p384_b[] = { 0x2a85c8edd3ec2aefull, 0xc656398d8a2ed19dull,
+				0x0314088f5013875aull, 0x181d9c6efe814112ull,
+				0x988e056be3f82d19ull, 0xb3312fa7e23ee7e4ull };
+static struct ecc_curve nist_p384 = {
+	.name = "nist_384",
+	.g = {
+		.x = nist_p384_g_x,
+		.y = nist_p384_g_y,
+		.ndigits = 6,
+	},
+	.p = nist_p384_p,
+	.n = nist_p384_n,
+	.a = nist_p384_a,
+	.b = nist_p384_b
+};
+
 #endif
diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
index a5b805b5526d..e4ba1de961e4 100644
--- a/include/crypto/ecdh.h
+++ b/include/crypto/ecdh.h
@@ -25,6 +25,7 @@
 /* Curves IDs */
 #define ECC_CURVE_NIST_P192	0x0001
 #define ECC_CURVE_NIST_P256	0x0002
+#define ECC_CURVE_NIST_P384	0x0003
 
 /**
  * struct ecdh - define an ECDH private key
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index ff3cad9f8c1f..d656450dfc66 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -19,10 +19,10 @@
 enum OID {
 	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
 	OID_id_dsa,			/* 1.2.840.10040.4.1 */
-	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
 	OID_id_prime192v1,		/* 1.2.840.10045.3.1.1 */
 	OID_id_prime256v1,		/* 1.2.840.10045.3.1.7 */
+	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
 	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
 	OID_id_ecdsa_with_sha384,	/* 1.2.840.10045.4.3.3 */
@@ -64,6 +64,7 @@ enum OID {
 
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
 	OID_sha1,			/* 1.3.14.3.2.26 */
+	OID_id_secp384r1,		/* 1.3.132.0.34 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
 	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */
-- 
2.25.1

