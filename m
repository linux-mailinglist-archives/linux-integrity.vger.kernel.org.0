Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16735618A
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbhDGC54 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 22:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbhDGC5z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 22:57:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33873C06174A;
        Tue,  6 Apr 2021 19:57:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p10so3471449pld.0;
        Tue, 06 Apr 2021 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IsqgkX1B/XHzgIm86KB9mtlu7RaetVYtDsCKlYOiOwU=;
        b=M1XoQiAYQn3GylX4fR4K53GnCU6CbK+H92USCQTSS5oWhrzgWXC9lDLCDc8GtL78ky
         QywVCCXeziuWOqsqRuC4G5QVa+DpFe/zcxk63kiGNdyi0MfU4H0YVV8YvW4tpkQlFffc
         pkbNmL3uVbEf6wMG7QiOnAdSxfkTdQepUy2ieAdNxwzb1nh1zDdQHUwrYnkrKeWDN33y
         MljQjs6D3esSRn4rHvaQ5jrLWu0wLf6VH7J9JGTXNj/Hfvzy8elPqBN8SqyNecGGYJNR
         C4OU6DLZKFcj6nc5AWIrZT0xG6YE8kQZR7EYBAAD42RPYdYxIlZr0CEwZ2309dJdo9Kd
         3k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IsqgkX1B/XHzgIm86KB9mtlu7RaetVYtDsCKlYOiOwU=;
        b=V80r2yMNdWdfg76FKwvEluNIbHnEK8ksI18DR4UnzhLLmzr/1TbUcgATPjWwd5nnKS
         pGoiYC4qoK0AXfnAC8LBxMVE7s4MIr6XFOJz0djvrI7TaXKDwgYwss+bQqsoy8YLsm9y
         nFewVWERKzc1O+U2Hwm34QF043kPVRVEHUSEVkPbwkzQ7qGdJMn86D0evBu/cT0zM12O
         dqXuqsiqJWqZzlgps1AnvnzvWPCswqSs0jEG1Kf29DJceyFMA4zcg/tednuQzeTOJkR/
         DfNj6OW5F9t+r0bFxMOZmiL769aOyjt2bY0NozV/y9P8vvgeFo1hkKQx3NdZYQY1coG/
         RyWQ==
X-Gm-Message-State: AOAM532XU9d0BcwbVvUMpE8OT+o1Gr69+2fRaksRjCp3nMeIg7lkv8da
        JDXustuHacV6ez0xL+dwno8M8SHGseMWrw==
X-Google-Smtp-Source: ABdhPJxhSQZxB/o/H9+9Cd4L8LTlwtAMF4A0pjsnQur4kKGodlYvOxNOFuJP9yVP2aYOS2Jkh1qW5A==
X-Received: by 2002:a17:90b:1114:: with SMTP id gi20mr1188537pjb.23.1617764265563;
        Tue, 06 Apr 2021 19:57:45 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s22sm3574981pjs.42.2021.04.06.19.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 19:57:45 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH v2 2/4] crypto: support rsa-pss encoding
Date:   Wed,  7 Apr 2021 10:57:01 +0800
Message-Id: <1617764223-14275-3-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617764223-14275-1-git-send-email-herbert.tencent@gmail.com>
References: <1617764223-14275-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch add the support of rsa-pss encoding which is described
rfc8017.
Similar to rsa-pkcs1, we create a pss template.

Signed-off-by: Hongbo Li <herbert.tencent@gmail.com>
---
 crypto/Makefile               |   7 ++-
 crypto/rsa.c                  |  14 ++---
 crypto/rsa_helper.c           | 127 ++++++++++++++++++++++++++++++++++++++++++
 crypto/rsapss_params.asn1     |  21 +++++++
 include/crypto/internal/rsa.h |  25 ++++++++-
 5 files changed, 185 insertions(+), 9 deletions(-)
 create mode 100644 crypto/rsapss_params.asn1

diff --git a/crypto/Makefile b/crypto/Makefile
index 10526d4..2c65744 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -33,13 +33,18 @@ obj-$(CONFIG_CRYPTO_DH) += dh_generic.o
 
 $(obj)/rsapubkey.asn1.o: $(obj)/rsapubkey.asn1.c $(obj)/rsapubkey.asn1.h
 $(obj)/rsaprivkey.asn1.o: $(obj)/rsaprivkey.asn1.c $(obj)/rsaprivkey.asn1.h
-$(obj)/rsa_helper.o: $(obj)/rsapubkey.asn1.h $(obj)/rsaprivkey.asn1.h
+$(obj)/rsapss_params.asn1.o: $(obj)/rsapss_params.asn1.c \
+			     $(obj)/rsapss_params.asn1.h
+$(obj)/rsa_helper.o: $(obj)/rsapubkey.asn1.h $(obj)/rsaprivkey.asn1.h \
+		     $(obj)/rsapss_params.asn1.h
 
 rsa_generic-y := rsapubkey.asn1.o
 rsa_generic-y += rsaprivkey.asn1.o
+rsa_generic-y += rsapss_params.asn1.o
 rsa_generic-y += rsa.o
 rsa_generic-y += rsa_helper.o
 rsa_generic-y += rsa-pkcs1pad.o
+rsa_generic-y += rsa-psspad.o
 obj-$(CONFIG_CRYPTO_RSA) += rsa_generic.o
 
 $(obj)/sm2signature.asn1.o: $(obj)/sm2signature.asn1.c $(obj)/sm2signature.asn1.h
diff --git a/crypto/rsa.c b/crypto/rsa.c
index 4cdbec9..adc9b2d2 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -6,18 +6,11 @@
  */
 
 #include <linux/module.h>
-#include <linux/mpi.h>
 #include <crypto/internal/rsa.h>
 #include <crypto/internal/akcipher.h>
 #include <crypto/akcipher.h>
 #include <crypto/algapi.h>
 
-struct rsa_mpi_key {
-	MPI n;
-	MPI e;
-	MPI d;
-};
-
 /*
  * RSAEP function [RFC3447 sec 5.1.1]
  * c = m^e mod n;
@@ -269,12 +262,19 @@ static int rsa_init(void)
 		return err;
 	}
 
+	err = crypto_register_template(&rsa_psspad_tmpl);
+	if (err) {
+		crypto_unregister_akcipher(&rsa);
+		return err;
+	}
+
 	return 0;
 }
 
 static void rsa_exit(void)
 {
 	crypto_unregister_template(&rsa_pkcs1pad_tmpl);
+	crypto_unregister_template(&rsa_psspad_tmpl);
 	crypto_unregister_akcipher(&rsa);
 }
 
diff --git a/crypto/rsa_helper.c b/crypto/rsa_helper.c
index 94266f2..912d975 100644
--- a/crypto/rsa_helper.c
+++ b/crypto/rsa_helper.c
@@ -12,6 +12,7 @@
 #include <crypto/internal/rsa.h>
 #include "rsapubkey.asn1.h"
 #include "rsaprivkey.asn1.h"
+#include "rsapss_params.asn1.h"
 
 int rsa_get_n(void *context, size_t hdrlen, unsigned char tag,
 	      const void *value, size_t vlen)
@@ -148,6 +149,115 @@ int rsa_get_qinv(void *context, size_t hdrlen, unsigned char tag,
 	return 0;
 }
 
+int rsa_get_pss_hash(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct rsa_pss_ctx *ctx = context;
+	enum OID oid;
+
+	if (!value || !vlen)
+		return -EINVAL;
+
+	oid = look_up_OID(value, vlen);
+	switch (oid) {
+	case OID_sha1:
+		ctx->hash_algo = "sha1";
+		break;
+	case OID_sha224:
+		ctx->hash_algo = "sha224";
+		break;
+	case OID_sha256:
+		ctx->hash_algo = "sha256";
+		break;
+	case OID_sha384:
+		ctx->hash_algo = "sha384";
+		break;
+	case OID_sha512:
+		ctx->hash_algo = "sha512";
+		break;
+	default:
+		return -ENOPKG;
+
+	}
+
+	return 0;
+}
+
+int rsa_get_pss_mgf(void *context, size_t hdrlen, unsigned char tag,
+		    const void *value, size_t vlen)
+{
+	struct rsa_pss_ctx *ctx = context;
+	enum OID oid;
+
+	if (!value || !vlen)
+		return -EINVAL;
+
+	oid = look_up_OID(value, vlen);
+	if (oid != OID_rsa_mgf1)
+		return -ENOPKG;
+	ctx->mgf_algo = "mgf1";
+
+	return 0;
+}
+
+int rsa_get_pss_mgf_hash(void *context, size_t hdrlen, unsigned char tag,
+			 const void *value, size_t vlen)
+{
+	struct rsa_pss_ctx *ctx = context;
+	enum OID oid;
+
+	if (!value || !vlen)
+		return -EINVAL;
+	/* todo, merge with get_pss_hash */
+	oid = look_up_OID(value, vlen);
+	switch (oid) {
+	case OID_sha1:
+		ctx->mgf_hash_algo = "sha1";
+		break;
+	case OID_sha224:
+		ctx->mgf_hash_algo = "sha224";
+		break;
+	case OID_sha256:
+		ctx->mgf_hash_algo = "sha256";
+		break;
+	case OID_sha384:
+		ctx->mgf_hash_algo = "sha384";
+		break;
+	case OID_sha512:
+		ctx->mgf_hash_algo = "sha512";
+		break;
+	default:
+		return -ENOPKG;
+	}
+
+	return 0;
+}
+
+int rsa_get_pss_saltlen(void *context, size_t hdrlen, unsigned char tag,
+			const void *value, size_t vlen)
+{
+	struct rsa_pss_ctx *ctx = context;
+
+	if (!value || vlen < 1 || vlen > 2)
+		return -EINVAL;
+
+	if (vlen == 1)
+		ctx->salt_len = *(u8 *)value;
+	else if (vlen == 2)
+		ctx->salt_len = ntohs(*(u16 *)value);
+
+	return 0;
+}
+
+int rsa_get_pss_trailerfield(void *context, size_t hdrlen, unsigned char tag,
+			     const void *value, size_t vlen)
+{
+	if (!value || !vlen || *(u8 *)value != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * rsa_parse_pub_key() - decodes the BER encoded buffer and stores in the
  *                       provided struct rsa_key, pointers to the raw key as is,
@@ -184,3 +294,20 @@ int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
 	return asn1_ber_decoder(&rsaprivkey_decoder, rsa_key, key, key_len);
 }
 EXPORT_SYMBOL_GPL(rsa_parse_priv_key);
+
+/**
+ * rsa_parse_pss_params() - decodes the BER encoded pss padding params
+ *
+ * @ctx:	struct rsa_pss_ctx, pss padding context
+ * @params:	params in BER format
+ * @params_len:	length of params
+ *
+ * Return:	0 on success or error code in case of error
+ */
+int rsa_parse_pss_params(struct rsa_pss_ctx *ctx, const void *params,
+			 unsigned int params_len)
+{
+	return asn1_ber_decoder(&rsapss_params_decoder, ctx, params,
+				params_len);
+}
+EXPORT_SYMBOL_GPL(rsa_parse_pss_params);
diff --git a/crypto/rsapss_params.asn1 b/crypto/rsapss_params.asn1
new file mode 100644
index 0000000..4d6b0ba
--- /dev/null
+++ b/crypto/rsapss_params.asn1
@@ -0,0 +1,21 @@
+-- rfc4055 section 3.1.
+
+RSAPSS_Params ::= SEQUENCE {
+	hashAlgorithm		[0] HashAlgorithm OPTIONAL,
+	maskGenAlgorithm	[1] MaskGenAlgorithm OPTIONAL,
+	saltLen			[2] INTEGER OPTIONAL ({ rsa_get_pss_saltlen }),
+	trailerField		[3] INTEGER OPTIONAL ({ rsa_get_pss_trailerfield })
+	}
+
+HashAlgorithm ::= SEQUENCE {
+	algorithm		OBJECT IDENTIFIER ({ rsa_get_pss_hash })
+	}
+
+MaskGenAlgorithm ::= SEQUENCE {
+	algorithm	OBJECT IDENTIFIER  ({ rsa_get_pss_mgf }),
+	hashAlgorithm	MgfHashAlgorithm
+	}
+
+MgfHashAlgorithm ::= SEQUENCE {
+	algorithm	OBJECT IDENTIFIER ({ rsa_get_pss_mgf_hash })
+	}
diff --git a/include/crypto/internal/rsa.h b/include/crypto/internal/rsa.h
index e870133..cfb0801 100644
--- a/include/crypto/internal/rsa.h
+++ b/include/crypto/internal/rsa.h
@@ -8,6 +8,12 @@
 #ifndef _RSA_HELPER_
 #define _RSA_HELPER_
 #include <linux/types.h>
+#include <linux/mpi.h>
+#include <linux/oid_registry.h>
+#include <crypto/sha2.h>
+
+#define RSA_MAX_DIGEST_SIZE		SHA512_DIGEST_SIZE
+#define RSA_PSS_DEFAULT_SALT_LEN	20
 
 /**
  * rsa_key - RSA key structure
@@ -47,11 +53,28 @@ struct rsa_key {
 	size_t qinv_sz;
 };
 
+struct rsa_mpi_key {
+	MPI n;
+	MPI e;
+	MPI d;
+};
+
+struct rsa_pss_ctx {
+	struct crypto_akcipher *child;
+	unsigned int key_size;
+	const char *hash_algo;
+	const char *mgf_algo;
+	const char *mgf_hash_algo;
+	u32 salt_len;
+};
+
 int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
 		      unsigned int key_len);
 
 int rsa_parse_priv_key(struct rsa_key *rsa_key, const void *key,
 		       unsigned int key_len);
-
+int rsa_parse_pss_params(struct rsa_pss_ctx *ctx, const void *params,
+			 unsigned int params_len);
 extern struct crypto_template rsa_pkcs1pad_tmpl;
+extern struct crypto_template rsa_psspad_tmpl;
 #endif
-- 
1.8.3.1

