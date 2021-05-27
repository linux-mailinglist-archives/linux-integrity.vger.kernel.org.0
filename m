Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52506393039
	for <lists+linux-integrity@lfdr.de>; Thu, 27 May 2021 15:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhE0N4U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 May 2021 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbhE0N4N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 May 2021 09:56:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD7C061763;
        Thu, 27 May 2021 06:54:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso2450645pjb.0;
        Thu, 27 May 2021 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2T7+K8oGUO1T079bIkP0Tplou2479bflLyNKtimMMrA=;
        b=f2tKuN9iN7vY1nctTMdWbdYog8r6y2QuGDtmIgB8+0KOEvCTCybN6zHkHNUJkMO/h/
         S7DXSrBUGCPP9IvjFkja54THd473mX3Rpvs4QrrR2LugEhTsDHfdejwtaj0LmxIehjUM
         U4ceTebypn7ByLRgZ0vb5BeWTaHD/j1FFUXxitXJjZPhIgphGsAw5C31ZNR8hAV3Ii4d
         1H/dPbYG53/m6EnI1Dr4FQZx1oI/EDhulpUbcuvoSEFGvkz4HqbPZwCxeM6GPsYk/3/U
         89IINeMln6T6RpGcH0PbywegHL24thotqZoDx7vllLBGamhpLDPaqQ/xDkMXyVXLNw45
         5PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2T7+K8oGUO1T079bIkP0Tplou2479bflLyNKtimMMrA=;
        b=P4tE4ULw+EVu7+eZN7/VLCXZeUScaIVxydML1pebImWa3BJXBEYfQKoUu/DmLh+GO5
         8n/1w81aeTeI8nunIwYHBhXBEMx6uk7zlBRnDq1CwGo/xdz/tPo4ef1mElk9xJgvmiOv
         cgJS9H3IKg1w7eBXE5cE3qfooAuK+QTN/ggHT7hHiH5s60w6dfhwsZ0qga4XQB8c1uaa
         HrcuXc1ePWdne7qmQnYPPpBVLwZNlxohYMbojK0zTrt+2m11/TkzANa74F5J64KWzAXn
         3ykWflJE+3gAglSPOLjFxZv7Q+KCUREU3yvYqPazsUhuarNzX5NXidX2xTuYgGx2AfMg
         Epqw==
X-Gm-Message-State: AOAM5302ScChAnlY57U3kz4msNIWYz14RfiixOSGCLnPMIR33GmVvX43
        E4PYVSelwl0viN/WS9u9S1cY51P0PR8=
X-Google-Smtp-Source: ABdhPJzPI2YwmaBgn4CNijVJcLS8ptspZ4fF3jgQ3fEEAnRHRG5LF3JDnk1CKHCmRKCtqjBFr2Cjxg==
X-Received: by 2002:a17:902:d4c4:b029:f7:af18:2bd9 with SMTP id o4-20020a170902d4c4b02900f7af182bd9mr3337677plg.75.1622123678359;
        Thu, 27 May 2021 06:54:38 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 10sm2163387pgl.39.2021.05.27.06.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 06:54:38 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ebiggers@kernel.org,
        dhowells@redhat.com, jarkko@kernel.org,
        tianjia.zhang@linux.alibaba.com, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [PATCH v2 4/7] x509: add support for eddsa
Date:   Thu, 27 May 2021 21:53:32 +0800
Message-Id: <1622123615-15517-5-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Hongbo Li <herberthbli@tencent.com>

This patch make x509 support eddsa(currently ed25519). According to
RFC8032 section 5.1.7[1], the digest is not on the original message,
but on a special formated message string:
	SHA512(dom2(F, C) || R || A || PH(M))

[1]: https://tools.ietf.org/html/rfc8032#section-5.1.7

Signed-off-by: Hongbo Li <herberthbli@tencent.com>
---
 crypto/asymmetric_keys/public_key.c       | 73 ++++++++++++++++++++---
 crypto/asymmetric_keys/x509_cert_parser.c | 14 ++++-
 crypto/asymmetric_keys/x509_public_key.c  |  4 +-
 include/linux/oid_registry.h              |  1 +
 4 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 4fefb219bfdc..c1236a8fb38e 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -251,8 +251,8 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 }
 
 #if IS_REACHABLE(CONFIG_CRYPTO_SM2)
-static int cert_sig_digest_update(const struct public_key_signature *sig,
-				  struct crypto_akcipher *tfm_pkey)
+static int sm2_cert_sig_digest_update(const struct public_key_signature *sig,
+				      struct crypto_akcipher *tfm_pkey)
 {
 	struct crypto_shash *tfm;
 	struct shash_desc *desc;
@@ -297,7 +297,7 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
 	return ret;
 }
 #else
-static inline int cert_sig_digest_update(
+static inline int sm2_cert_sig_digest_update(
 	const struct public_key_signature *sig,
 	struct crypto_akcipher *tfm_pkey)
 {
@@ -305,6 +305,58 @@ static inline int cert_sig_digest_update(
 }
 #endif /* ! IS_REACHABLE(CONFIG_CRYPTO_SM2) */
 
+static int eddsa_cert_sig_digest_update(const struct public_key *pub,
+					const struct public_key_signature *sig)
+{
+	struct crypto_shash *tfm = NULL;
+	struct shash_desc *desc = NULL;
+	int key_size, ret = 0;
+
+	if (strcmp(pub->pkey_algo, "eddsa-25519"))
+		return -ENOPKG;
+
+	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	desc->tfm = tfm;
+
+	/* RFC8032 section 5.1.7
+	 * step 2. SHA512(dom2(F, C) || R || A || PH(M))
+	 */
+	key_size = 32;
+	if (sig->s_size != key_size * 2 ||
+	    pub->keylen != key_size) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto free;
+
+	ret = crypto_shash_update(desc, sig->s, key_size);
+	if (ret < 0)
+		goto free;
+
+	ret = crypto_shash_update(desc, pub->key, key_size);
+	if (ret < 0)
+		goto free;
+
+	ret = crypto_shash_finup(desc, sig->data, sig->data_size, sig->digest);
+
+free:
+	kfree(desc);
+	crypto_free_shash(tfm);
+	return ret;
+}
+
 /*
  * Verify a signature using a public key.
  */
@@ -358,11 +410,16 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (ret)
 		goto error_free_key;
 
-	if (sig->pkey_algo && strcmp(sig->pkey_algo, "sm2") == 0 &&
-	    sig->data_size) {
-		ret = cert_sig_digest_update(sig, tfm);
-		if (ret)
-			goto error_free_key;
+	if (sig->pkey_algo && sig->data_size) {
+		if (strcmp(sig->pkey_algo, "sm2") == 0) {
+			ret = sm2_cert_sig_digest_update(sig, tfm);
+			if (ret)
+				goto error_free_key;
+		} else if (strcmp(sig->pkey_algo, "eddsa") == 0) {
+			ret = eddsa_cert_sig_digest_update(pkey, sig);
+			if (ret)
+				goto error_free_key;
+		}
 	}
 
 	sg_init_table(src_sg, 2);
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 6d003096b5bc..3f60c57d8d76 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -258,6 +258,9 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 	case OID_SM2_with_SM3:
 		ctx->cert->sig->hash_algo = "sm3";
 		goto sm2;
+	case OID_ed25519:
+		ctx->cert->sig->hash_algo = "sha512";
+		goto eddsa;
 	}
 
 rsa_pkcs1:
@@ -280,6 +283,11 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 	ctx->cert->sig->encoding = "x962";
 	ctx->algo_oid = ctx->last_oid;
 	return 0;
+eddsa:
+	ctx->cert->sig->pkey_algo = "eddsa";
+	ctx->cert->sig->encoding = "raw";
+	ctx->algo_oid = ctx->last_oid;
+	return 0;
 }
 
 /*
@@ -302,7 +310,8 @@ int x509_note_signature(void *context, size_t hdrlen,
 	if (strcmp(ctx->cert->sig->pkey_algo, "rsa") == 0 ||
 	    strcmp(ctx->cert->sig->pkey_algo, "ecrdsa") == 0 ||
 	    strcmp(ctx->cert->sig->pkey_algo, "sm2") == 0 ||
-	    strcmp(ctx->cert->sig->pkey_algo, "ecdsa") == 0) {
+	    strcmp(ctx->cert->sig->pkey_algo, "ecdsa") == 0 ||
+	    strcmp(ctx->cert->sig->pkey_algo, "eddsa") == 0) {
 		/* Discard the BIT STRING metadata */
 		if (vlen < 1 || *(const u8 *)value != 0)
 			return -EBADMSG;
@@ -517,6 +526,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 			return -ENOPKG;
 		}
 		break;
+	case OID_ed25519:
+		ctx->cert->pub->pkey_algo = "eddsa-25519";
+		break;
 	default:
 		return -ENOPKG;
 	}
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 3d45161b271a..a8fd3682695f 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -131,7 +131,9 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 	ret = -EKEYREJECTED;
 	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0 &&
 	    (strncmp(cert->pub->pkey_algo, "ecdsa-", 6) != 0 ||
-	     strcmp(cert->sig->pkey_algo, "ecdsa") != 0))
+	     strcmp(cert->sig->pkey_algo, "ecdsa") != 0) &&
+	    (strncmp(cert->pub->pkey_algo, "eddsa-", 6) != 0 ||
+	     strcmp(cert->sig->pkey_algo, "eddsa") != 0))
 		goto out;
 
 	ret = public_key_verify_signature(cert->pub, cert->sig);
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index cc64d9419746..d84bb867a1f9 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -64,6 +64,7 @@ enum OID {
 
 	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
 	OID_sha1,			/* 1.3.14.3.2.26 */
+	OID_ed25519,			/* 1.3.101.112 */
 	OID_id_ansip384r1,		/* 1.3.132.0.34 */
 	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
 	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
-- 
2.27.0

