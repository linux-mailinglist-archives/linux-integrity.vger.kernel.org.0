Return-Path: <linux-integrity+bounces-2753-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E358D5F80
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256781F2465E
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EC1514F8;
	Fri, 31 May 2024 10:20:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EC1514CE;
	Fri, 31 May 2024 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150821; cv=none; b=kc7N6gzPebqZt7xMDTqOWrR+RMAaSZRdQFDD8EizDeTE9nj9xRpEQfmWceqg+8qSLMDBNqEM2i8WxA+apS+LeyX1ramOVuVUYBECY8RnixxjZZAouw6uZdBLtPRIwLi6te30uqkWtfskuMxbk811NNk4pkg1SsfXVC4rQsVooJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150821; c=relaxed/simple;
	bh=1eJi1WQWqfYZwZAKCTyRZGB2/dWJ67hjqSbjuS1o9v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQQsxFK/dV1+sIXZkzbPkhzU9JeLmdK+4FCRjNa1XtEys4hvbLg1d9VxqfliZy01n+Y6As3ixAcAI8+zcUgKeXGObhdR0RKjKNMoeNoeS3X9uQfBWJyovemFHyoEIy2M+rOwB9klxVOCuHxpL37xRg+3q+Ocsf/DKaVLRnGrgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sCzMf-004Agn-0E;
	Fri, 31 May 2024 18:20:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 May 2024 18:20:03 +0800
Date: Fri, 31 May 2024 18:20:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Huaxin Lu <luhuaxin1@huawei.com>
Cc: David Howells <dhowells@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, xiujianfeng@huawei.com,
	wangweiyang2@huawei.com, yiyang13@huawei.com,
	zhujianwei7@huawei.com, shenyining@huawei.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] crypto: sm2 - Remove sm2 algorithm
Message-ID: <ZlmkU7h3O2pS-vvw@gondor.apana.org.au>
References: <20240513230718.447895-1-luhuaxin1@huawei.com>
 <Zkc1nsG9H1ajhCl_@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkc1nsG9H1ajhCl_@gondor.apana.org.au>

The SM2 algorithm has a single user in the kernel.  However, it's
never been integrated properly with that user: asymmetric_keys.

The crux of the issue is that the way it computes its digest with
sm3 does not fit into the architecture of asymmetric_keys.  As no
solution has been proposed, remove this algorithm.

It can be resubmitted when it is integrated properly into the
asymmetric_keys subsystem.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/Kconfig                            |  18 -
 crypto/Makefile                           |   8 -
 crypto/asymmetric_keys/pkcs7_parser.c     |   4 -
 crypto/asymmetric_keys/public_key.c       |   7 -
 crypto/asymmetric_keys/x509_cert_parser.c |  16 -
 crypto/asymmetric_keys/x509_public_key.c  |  17 +-
 crypto/sm2.c                              | 498 ----------------------
 crypto/sm2signature.asn1                  |   4 -
 crypto/testmgr.c                          |   6 -
 crypto/testmgr.h                          |  59 ---
 include/crypto/sm2.h                      |  28 --
 security/integrity/digsig_asymmetric.c    |   3 +-
 12 files changed, 3 insertions(+), 665 deletions(-)
 delete mode 100644 crypto/sm2.c
 delete mode 100644 crypto/sm2signature.asn1
 delete mode 100644 include/crypto/sm2.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5688d42a59c2..72e2decb8c6a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -313,24 +313,6 @@ config CRYPTO_ECRDSA
 	  One of the Russian cryptographic standard algorithms (called GOST
 	  algorithms). Only signature verification is implemented.
 
-config CRYPTO_SM2
-	tristate "SM2 (ShangMi 2)"
-	select CRYPTO_SM3
-	select CRYPTO_AKCIPHER
-	select CRYPTO_MANAGER
-	select MPILIB
-	select ASN1
-	help
-	  SM2 (ShangMi 2) public key algorithm
-
-	  Published by State Encryption Management Bureau, China,
-	  as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012.
-
-	  References:
-	  https://datatracker.ietf.org/doc/draft-shen-sm2-ecdsa/
-	  http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
-	  http://www.gmbz.org.cn/main/bzlb.html
-
 config CRYPTO_CURVE25519
 	tristate "Curve25519"
 	select CRYPTO_KPP
diff --git a/crypto/Makefile b/crypto/Makefile
index edbbaa3ffef5..4c99e5d376f6 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -50,14 +50,6 @@ rsa_generic-y += rsa_helper.o
 rsa_generic-y += rsa-pkcs1pad.o
 obj-$(CONFIG_CRYPTO_RSA) += rsa_generic.o
 
-$(obj)/sm2signature.asn1.o: $(obj)/sm2signature.asn1.c $(obj)/sm2signature.asn1.h
-$(obj)/sm2.o: $(obj)/sm2signature.asn1.h
-
-sm2_generic-y += sm2signature.asn1.o
-sm2_generic-y += sm2.o
-
-obj-$(CONFIG_CRYPTO_SM2) += sm2_generic.o
-
 $(obj)/ecdsasignature.asn1.o: $(obj)/ecdsasignature.asn1.c $(obj)/ecdsasignature.asn1.h
 $(obj)/ecdsa.o: $(obj)/ecdsasignature.asn1.h
 ecdsa_generic-y += ecdsa.o
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 231ad7b3789d..423d13c47545 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -292,10 +292,6 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
 		ctx->sinfo->sig->pkey_algo = "ecdsa";
 		ctx->sinfo->sig->encoding = "x962";
 		break;
-	case OID_SM2_with_SM3:
-		ctx->sinfo->sig->pkey_algo = "sm2";
-		ctx->sinfo->sig->encoding = "raw";
-		break;
 	case OID_gost2012PKey256:
 	case OID_gost2012PKey512:
 		ctx->sinfo->sig->pkey_algo = "ecrdsa";
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 3474fb34ded9..422940a6706a 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -124,13 +124,6 @@ software_key_determine_akcipher(const struct public_key *pkey,
 		    strcmp(hash_algo, "sha3-384") != 0 &&
 		    strcmp(hash_algo, "sha3-512") != 0)
 			return -EINVAL;
-	} else if (strcmp(pkey->pkey_algo, "sm2") == 0) {
-		if (strcmp(encoding, "raw") != 0)
-			return -EINVAL;
-		if (!hash_algo)
-			return -EINVAL;
-		if (strcmp(hash_algo, "sm3") != 0)
-			return -EINVAL;
 	} else if (strcmp(pkey->pkey_algo, "ecrdsa") == 0) {
 		if (strcmp(encoding, "raw") != 0)
 			return -EINVAL;
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 25cc4273472f..ee2fdab42334 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -257,10 +257,6 @@ int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
 	case OID_gost2012Signature512:
 		ctx->cert->sig->hash_algo = "streebog512";
 		goto ecrdsa;
-
-	case OID_SM2_with_SM3:
-		ctx->cert->sig->hash_algo = "sm3";
-		goto sm2;
 	}
 
 rsa_pkcs1:
@@ -273,11 +269,6 @@ int x509_note_sig_algo(void *context, size_t hdrlen, unsigned char tag,
 	ctx->cert->sig->encoding = "raw";
 	ctx->sig_algo = ctx->last_oid;
 	return 0;
-sm2:
-	ctx->cert->sig->pkey_algo = "sm2";
-	ctx->cert->sig->encoding = "raw";
-	ctx->sig_algo = ctx->last_oid;
-	return 0;
 ecdsa:
 	ctx->cert->sig->pkey_algo = "ecdsa";
 	ctx->cert->sig->encoding = "x962";
@@ -309,7 +300,6 @@ int x509_note_signature(void *context, size_t hdrlen,
 
 	if (strcmp(ctx->cert->sig->pkey_algo, "rsa") == 0 ||
 	    strcmp(ctx->cert->sig->pkey_algo, "ecrdsa") == 0 ||
-	    strcmp(ctx->cert->sig->pkey_algo, "sm2") == 0 ||
 	    strcmp(ctx->cert->sig->pkey_algo, "ecdsa") == 0) {
 		/* Discard the BIT STRING metadata */
 		if (vlen < 1 || *(const u8 *)value != 0)
@@ -514,17 +504,11 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 	case OID_gost2012PKey512:
 		ctx->cert->pub->pkey_algo = "ecrdsa";
 		break;
-	case OID_sm2:
-		ctx->cert->pub->pkey_algo = "sm2";
-		break;
 	case OID_id_ecPublicKey:
 		if (parse_OID(ctx->params, ctx->params_size, &oid) != 0)
 			return -EBADMSG;
 
 		switch (oid) {
-		case OID_sm2:
-			ctx->cert->pub->pkey_algo = "sm2";
-			break;
 		case OID_id_prime192v1:
 			ctx->cert->pub->pkey_algo = "ecdsa-nist-p192";
 			break;
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 00ac7159fba2..8409d7d36cb4 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -7,7 +7,6 @@
 
 #define pr_fmt(fmt) "X.509: "fmt
 #include <crypto/hash.h>
-#include <crypto/sm2.h>
 #include <keys/asymmetric-parser.h>
 #include <keys/asymmetric-subtype.h>
 #include <keys/system_keyring.h>
@@ -64,20 +63,8 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	desc->tfm = tfm;
 
-	if (strcmp(cert->pub->pkey_algo, "sm2") == 0) {
-		ret = strcmp(sig->hash_algo, "sm3") != 0 ? -EINVAL :
-		      crypto_shash_init(desc) ?:
-		      sm2_compute_z_digest(desc, cert->pub->key,
-					   cert->pub->keylen, sig->digest) ?:
-		      crypto_shash_init(desc) ?:
-		      crypto_shash_update(desc, sig->digest,
-					  sig->digest_size) ?:
-		      crypto_shash_finup(desc, cert->tbs, cert->tbs_size,
-					 sig->digest);
-	} else {
-		ret = crypto_shash_digest(desc, cert->tbs, cert->tbs_size,
-					  sig->digest);
-	}
+	ret = crypto_shash_digest(desc, cert->tbs, cert->tbs_size,
+				  sig->digest);
 
 	if (ret < 0)
 		goto error_2;
diff --git a/crypto/sm2.c b/crypto/sm2.c
deleted file mode 100644
index 5ab120d74c59..000000000000
--- a/crypto/sm2.c
+++ /dev/null
@@ -1,498 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * SM2 asymmetric public-key algorithm
- * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
- * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
- *
- * Copyright (c) 2020, Alibaba Group.
- * Authors: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
- */
-
-#include <linux/module.h>
-#include <linux/mpi.h>
-#include <crypto/internal/akcipher.h>
-#include <crypto/akcipher.h>
-#include <crypto/hash.h>
-#include <crypto/rng.h>
-#include <crypto/sm2.h>
-#include "sm2signature.asn1.h"
-
-/* The default user id as specified in GM/T 0009-2012 */
-#define SM2_DEFAULT_USERID "1234567812345678"
-#define SM2_DEFAULT_USERID_LEN 16
-
-#define MPI_NBYTES(m)   ((mpi_get_nbits(m) + 7) / 8)
-
-struct ecc_domain_parms {
-	const char *desc;           /* Description of the curve.  */
-	unsigned int nbits;         /* Number of bits.  */
-	unsigned int fips:1; /* True if this is a FIPS140-2 approved curve */
-
-	/* The model describing this curve.  This is mainly used to select
-	 * the group equation.
-	 */
-	enum gcry_mpi_ec_models model;
-
-	/* The actual ECC dialect used.  This is used for curve specific
-	 * optimizations and to select encodings etc.
-	 */
-	enum ecc_dialects dialect;
-
-	const char *p;              /* The prime defining the field.  */
-	const char *a, *b;          /* The coefficients.  For Twisted Edwards
-				     * Curves b is used for d.  For Montgomery
-				     * Curves (a,b) has ((A-2)/4,B^-1).
-				     */
-	const char *n;              /* The order of the base point.  */
-	const char *g_x, *g_y;      /* Base point.  */
-	unsigned int h;             /* Cofactor.  */
-};
-
-static const struct ecc_domain_parms sm2_ecp = {
-	.desc = "sm2p256v1",
-	.nbits = 256,
-	.fips = 0,
-	.model = MPI_EC_WEIERSTRASS,
-	.dialect = ECC_DIALECT_STANDARD,
-	.p   = "0xfffffffeffffffffffffffffffffffffffffffff00000000ffffffffffffffff",
-	.a   = "0xfffffffeffffffffffffffffffffffffffffffff00000000fffffffffffffffc",
-	.b   = "0x28e9fa9e9d9f5e344d5a9e4bcf6509a7f39789f515ab8f92ddbcbd414d940e93",
-	.n   = "0xfffffffeffffffffffffffffffffffff7203df6b21c6052b53bbf40939d54123",
-	.g_x = "0x32c4ae2c1f1981195f9904466a39c9948fe30bbff2660be1715a4589334c74c7",
-	.g_y = "0xbc3736a2f4f6779c59bdcee36b692153d0a9877cc62a474002df32e52139f0a0",
-	.h = 1
-};
-
-static int __sm2_set_pub_key(struct mpi_ec_ctx *ec,
-			     const void *key, unsigned int keylen);
-
-static int sm2_ec_ctx_init(struct mpi_ec_ctx *ec)
-{
-	const struct ecc_domain_parms *ecp = &sm2_ecp;
-	MPI p, a, b;
-	MPI x, y;
-	int rc = -EINVAL;
-
-	p = mpi_scanval(ecp->p);
-	a = mpi_scanval(ecp->a);
-	b = mpi_scanval(ecp->b);
-	if (!p || !a || !b)
-		goto free_p;
-
-	x = mpi_scanval(ecp->g_x);
-	y = mpi_scanval(ecp->g_y);
-	if (!x || !y)
-		goto free;
-
-	rc = -ENOMEM;
-
-	ec->Q = mpi_point_new(0);
-	if (!ec->Q)
-		goto free;
-
-	/* mpi_ec_setup_elliptic_curve */
-	ec->G = mpi_point_new(0);
-	if (!ec->G) {
-		mpi_point_release(ec->Q);
-		goto free;
-	}
-
-	mpi_set(ec->G->x, x);
-	mpi_set(ec->G->y, y);
-	mpi_set_ui(ec->G->z, 1);
-
-	rc = -EINVAL;
-	ec->n = mpi_scanval(ecp->n);
-	if (!ec->n) {
-		mpi_point_release(ec->Q);
-		mpi_point_release(ec->G);
-		goto free;
-	}
-
-	ec->h = ecp->h;
-	ec->name = ecp->desc;
-	mpi_ec_init(ec, ecp->model, ecp->dialect, 0, p, a, b);
-
-	rc = 0;
-
-free:
-	mpi_free(x);
-	mpi_free(y);
-free_p:
-	mpi_free(p);
-	mpi_free(a);
-	mpi_free(b);
-
-	return rc;
-}
-
-static void sm2_ec_ctx_deinit(struct mpi_ec_ctx *ec)
-{
-	mpi_ec_deinit(ec);
-
-	memset(ec, 0, sizeof(*ec));
-}
-
-/* RESULT must have been initialized and is set on success to the
- * point given by VALUE.
- */
-static int sm2_ecc_os2ec(MPI_POINT result, MPI value)
-{
-	int rc;
-	size_t n;
-	unsigned char *buf;
-	MPI x, y;
-
-	n = MPI_NBYTES(value);
-	buf = kmalloc(n, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	rc = mpi_print(GCRYMPI_FMT_USG, buf, n, &n, value);
-	if (rc)
-		goto err_freebuf;
-
-	rc = -EINVAL;
-	if (n < 1 || ((n - 1) % 2))
-		goto err_freebuf;
-	/* No support for point compression */
-	if (*buf != 0x4)
-		goto err_freebuf;
-
-	rc = -ENOMEM;
-	n = (n - 1) / 2;
-	x = mpi_read_raw_data(buf + 1, n);
-	if (!x)
-		goto err_freebuf;
-	y = mpi_read_raw_data(buf + 1 + n, n);
-	if (!y)
-		goto err_freex;
-
-	mpi_normalize(x);
-	mpi_normalize(y);
-	mpi_set(result->x, x);
-	mpi_set(result->y, y);
-	mpi_set_ui(result->z, 1);
-
-	rc = 0;
-
-	mpi_free(y);
-err_freex:
-	mpi_free(x);
-err_freebuf:
-	kfree(buf);
-	return rc;
-}
-
-struct sm2_signature_ctx {
-	MPI sig_r;
-	MPI sig_s;
-};
-
-int sm2_get_signature_r(void *context, size_t hdrlen, unsigned char tag,
-				const void *value, size_t vlen)
-{
-	struct sm2_signature_ctx *sig = context;
-
-	if (!value || !vlen)
-		return -EINVAL;
-
-	sig->sig_r = mpi_read_raw_data(value, vlen);
-	if (!sig->sig_r)
-		return -ENOMEM;
-
-	return 0;
-}
-
-int sm2_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
-				const void *value, size_t vlen)
-{
-	struct sm2_signature_ctx *sig = context;
-
-	if (!value || !vlen)
-		return -EINVAL;
-
-	sig->sig_s = mpi_read_raw_data(value, vlen);
-	if (!sig->sig_s)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int sm2_z_digest_update(struct shash_desc *desc,
-			       MPI m, unsigned int pbytes)
-{
-	static const unsigned char zero[32];
-	unsigned char *in;
-	unsigned int inlen;
-	int err;
-
-	in = mpi_get_buffer(m, &inlen, NULL);
-	if (!in)
-		return -EINVAL;
-
-	if (inlen < pbytes) {
-		/* padding with zero */
-		err = crypto_shash_update(desc, zero, pbytes - inlen) ?:
-		      crypto_shash_update(desc, in, inlen);
-	} else if (inlen > pbytes) {
-		/* skip the starting zero */
-		err = crypto_shash_update(desc, in + inlen - pbytes, pbytes);
-	} else {
-		err = crypto_shash_update(desc, in, inlen);
-	}
-
-	kfree(in);
-	return err;
-}
-
-static int sm2_z_digest_update_point(struct shash_desc *desc,
-				     MPI_POINT point, struct mpi_ec_ctx *ec,
-				     unsigned int pbytes)
-{
-	MPI x, y;
-	int ret = -EINVAL;
-
-	x = mpi_new(0);
-	y = mpi_new(0);
-
-	ret = mpi_ec_get_affine(x, y, point, ec) ? -EINVAL :
-	      sm2_z_digest_update(desc, x, pbytes) ?:
-	      sm2_z_digest_update(desc, y, pbytes);
-
-	mpi_free(x);
-	mpi_free(y);
-	return ret;
-}
-
-int sm2_compute_z_digest(struct shash_desc *desc,
-			 const void *key, unsigned int keylen, void *dgst)
-{
-	struct mpi_ec_ctx *ec;
-	unsigned int bits_len;
-	unsigned int pbytes;
-	u8 entl[2];
-	int err;
-
-	ec = kmalloc(sizeof(*ec), GFP_KERNEL);
-	if (!ec)
-		return -ENOMEM;
-
-	err = sm2_ec_ctx_init(ec);
-	if (err)
-		goto out_free_ec;
-
-	err = __sm2_set_pub_key(ec, key, keylen);
-	if (err)
-		goto out_deinit_ec;
-
-	bits_len = SM2_DEFAULT_USERID_LEN * 8;
-	entl[0] = bits_len >> 8;
-	entl[1] = bits_len & 0xff;
-
-	pbytes = MPI_NBYTES(ec->p);
-
-	/* ZA = H256(ENTLA | IDA | a | b | xG | yG | xA | yA) */
-	err = crypto_shash_init(desc);
-	if (err)
-		goto out_deinit_ec;
-
-	err = crypto_shash_update(desc, entl, 2);
-	if (err)
-		goto out_deinit_ec;
-
-	err = crypto_shash_update(desc, SM2_DEFAULT_USERID,
-				  SM2_DEFAULT_USERID_LEN);
-	if (err)
-		goto out_deinit_ec;
-
-	err = sm2_z_digest_update(desc, ec->a, pbytes) ?:
-	      sm2_z_digest_update(desc, ec->b, pbytes) ?:
-	      sm2_z_digest_update_point(desc, ec->G, ec, pbytes) ?:
-	      sm2_z_digest_update_point(desc, ec->Q, ec, pbytes);
-	if (err)
-		goto out_deinit_ec;
-
-	err = crypto_shash_final(desc, dgst);
-
-out_deinit_ec:
-	sm2_ec_ctx_deinit(ec);
-out_free_ec:
-	kfree(ec);
-	return err;
-}
-EXPORT_SYMBOL_GPL(sm2_compute_z_digest);
-
-static int _sm2_verify(struct mpi_ec_ctx *ec, MPI hash, MPI sig_r, MPI sig_s)
-{
-	int rc = -EINVAL;
-	struct gcry_mpi_point sG, tP;
-	MPI t = NULL;
-	MPI x1 = NULL, y1 = NULL;
-
-	mpi_point_init(&sG);
-	mpi_point_init(&tP);
-	x1 = mpi_new(0);
-	y1 = mpi_new(0);
-	t = mpi_new(0);
-
-	/* r, s in [1, n-1] */
-	if (mpi_cmp_ui(sig_r, 1) < 0 || mpi_cmp(sig_r, ec->n) > 0 ||
-		mpi_cmp_ui(sig_s, 1) < 0 || mpi_cmp(sig_s, ec->n) > 0) {
-		goto leave;
-	}
-
-	/* t = (r + s) % n, t == 0 */
-	mpi_addm(t, sig_r, sig_s, ec->n);
-	if (mpi_cmp_ui(t, 0) == 0)
-		goto leave;
-
-	/* sG + tP = (x1, y1) */
-	rc = -EBADMSG;
-	mpi_ec_mul_point(&sG, sig_s, ec->G, ec);
-	mpi_ec_mul_point(&tP, t, ec->Q, ec);
-	mpi_ec_add_points(&sG, &sG, &tP, ec);
-	if (mpi_ec_get_affine(x1, y1, &sG, ec))
-		goto leave;
-
-	/* R = (e + x1) % n */
-	mpi_addm(t, hash, x1, ec->n);
-
-	/* check R == r */
-	rc = -EKEYREJECTED;
-	if (mpi_cmp(t, sig_r))
-		goto leave;
-
-	rc = 0;
-
-leave:
-	mpi_point_free_parts(&sG);
-	mpi_point_free_parts(&tP);
-	mpi_free(x1);
-	mpi_free(y1);
-	mpi_free(t);
-
-	return rc;
-}
-
-static int sm2_verify(struct akcipher_request *req)
-{
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
-	unsigned char *buffer;
-	struct sm2_signature_ctx sig;
-	MPI hash;
-	int ret;
-
-	if (unlikely(!ec->Q))
-		return -EINVAL;
-
-	buffer = kmalloc(req->src_len + req->dst_len, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	sg_pcopy_to_buffer(req->src,
-		sg_nents_for_len(req->src, req->src_len + req->dst_len),
-		buffer, req->src_len + req->dst_len, 0);
-
-	sig.sig_r = NULL;
-	sig.sig_s = NULL;
-	ret = asn1_ber_decoder(&sm2signature_decoder, &sig,
-				buffer, req->src_len);
-	if (ret)
-		goto error;
-
-	ret = -ENOMEM;
-	hash = mpi_read_raw_data(buffer + req->src_len, req->dst_len);
-	if (!hash)
-		goto error;
-
-	ret = _sm2_verify(ec, hash, sig.sig_r, sig.sig_s);
-
-	mpi_free(hash);
-error:
-	mpi_free(sig.sig_r);
-	mpi_free(sig.sig_s);
-	kfree(buffer);
-	return ret;
-}
-
-static int sm2_set_pub_key(struct crypto_akcipher *tfm,
-			const void *key, unsigned int keylen)
-{
-	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
-
-	return __sm2_set_pub_key(ec, key, keylen);
-
-}
-
-static int __sm2_set_pub_key(struct mpi_ec_ctx *ec,
-			     const void *key, unsigned int keylen)
-{
-	MPI a;
-	int rc;
-
-	/* include the uncompressed flag '0x04' */
-	a = mpi_read_raw_data(key, keylen);
-	if (!a)
-		return -ENOMEM;
-
-	mpi_normalize(a);
-	rc = sm2_ecc_os2ec(ec->Q, a);
-	mpi_free(a);
-
-	return rc;
-}
-
-static unsigned int sm2_max_size(struct crypto_akcipher *tfm)
-{
-	/* Unlimited max size */
-	return PAGE_SIZE;
-}
-
-static int sm2_init_tfm(struct crypto_akcipher *tfm)
-{
-	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
-
-	return sm2_ec_ctx_init(ec);
-}
-
-static void sm2_exit_tfm(struct crypto_akcipher *tfm)
-{
-	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
-
-	sm2_ec_ctx_deinit(ec);
-}
-
-static struct akcipher_alg sm2 = {
-	.verify = sm2_verify,
-	.set_pub_key = sm2_set_pub_key,
-	.max_size = sm2_max_size,
-	.init = sm2_init_tfm,
-	.exit = sm2_exit_tfm,
-	.base = {
-		.cra_name = "sm2",
-		.cra_driver_name = "sm2-generic",
-		.cra_priority = 100,
-		.cra_module = THIS_MODULE,
-		.cra_ctxsize = sizeof(struct mpi_ec_ctx),
-	},
-};
-
-static int __init sm2_init(void)
-{
-	return crypto_register_akcipher(&sm2);
-}
-
-static void __exit sm2_exit(void)
-{
-	crypto_unregister_akcipher(&sm2);
-}
-
-subsys_initcall(sm2_init);
-module_exit(sm2_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
-MODULE_DESCRIPTION("SM2 generic algorithm");
-MODULE_ALIAS_CRYPTO("sm2-generic");
diff --git a/crypto/sm2signature.asn1 b/crypto/sm2signature.asn1
deleted file mode 100644
index ab8c0b754d21..000000000000
--- a/crypto/sm2signature.asn1
+++ /dev/null
@@ -1,4 +0,0 @@
-Sm2Signature ::= SEQUENCE {
-	sig_r	INTEGER ({ sm2_get_signature_r }),
-	sig_s	INTEGER ({ sm2_get_signature_s })
-}
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 00f5a6cf341a..f71bdba5597f 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5589,12 +5589,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(sha512_tv_template)
 		}
-	}, {
-		.alg = "sm2",
-		.test = alg_test_akcipher,
-		.suite = {
-			.akcipher = __VECS(sm2_tv_template)
-		}
 	}, {
 		.alg = "sm3",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 5350cfd9d325..9b38501a17b2 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -5774,65 +5774,6 @@ static const struct hash_testvec hmac_streebog512_tv_template[] = {
 	},
 };
 
-/*
- * SM2 test vectors.
- */
-static const struct akcipher_testvec sm2_tv_template[] = {
-	{ /* Generated from openssl */
-	.key =
-	"\x04"
-	"\x8e\xa0\x33\x69\x91\x7e\x3d\xec\xad\x8e\xf0\x45\x5e\x13\x3e\x68"
-	"\x5b\x8c\xab\x5c\xc6\xc8\x50\xdf\x91\x00\xe0\x24\x73\x4d\x31\xf2"
-	"\x2e\xc0\xd5\x6b\xee\xda\x98\x93\xec\xd8\x36\xaa\xb9\xcf\x63\x82"
-	"\xef\xa7\x1a\x03\xed\x16\xba\x74\xb8\x8b\xf9\xe5\x70\x39\xa4\x70",
-	.key_len = 65,
-	.param_len = 0,
-	.c =
-	"\x30\x45"
-	"\x02\x20"
-	"\x70\xab\xb6\x7d\xd6\x54\x80\x64\x42\x7e\x2d\x05\x08\x36\xc9\x96"
-	"\x25\xc2\xbb\xff\x08\xe5\x43\x15\x5e\xf3\x06\xd9\x2b\x2f\x0a\x9f"
-	"\x02\x21"
-	"\x00"
-	"\xbf\x21\x5f\x7e\x5d\x3f\x1a\x4d\x8f\x84\xc2\xe9\xa6\x4c\xa4\x18"
-	"\xb2\xb8\x46\xf4\x32\x96\xfa\x57\xc6\x29\xd4\x89\xae\xcc\xda\xdb",
-	.c_size = 71,
-	.algo = OID_SM2_with_SM3,
-	.m =
-	"\x47\xa7\xbf\xd3\xda\xc4\x79\xee\xda\x8b\x4f\xe8\x40\x94\xd4\x32"
-	"\x8f\xf1\xcd\x68\x4d\xbd\x9b\x1d\xe0\xd8\x9a\x5d\xad\x85\x47\x5c",
-	.m_size = 32,
-	.public_key_vec = true,
-	.siggen_sigver_test = true,
-	},
-	{ /* From libgcrypt */
-	.key =
-	"\x04"
-	"\x87\x59\x38\x9a\x34\xaa\xad\x07\xec\xf4\xe0\xc8\xc2\x65\x0a\x44"
-	"\x59\xc8\xd9\x26\xee\x23\x78\x32\x4e\x02\x61\xc5\x25\x38\xcb\x47"
-	"\x75\x28\x10\x6b\x1e\x0b\x7c\x8d\xd5\xff\x29\xa9\xc8\x6a\x89\x06"
-	"\x56\x56\xeb\x33\x15\x4b\xc0\x55\x60\x91\xef\x8a\xc9\xd1\x7d\x78",
-	.key_len = 65,
-	.param_len = 0,
-	.c =
-	"\x30\x44"
-	"\x02\x20"
-	"\xd9\xec\xef\xe8\x5f\xee\x3c\x59\x57\x8e\x5b\xab\xb3\x02\xe1\x42"
-	"\x4b\x67\x2c\x0b\x26\xb6\x51\x2c\x3e\xfc\xc6\x49\xec\xfe\x89\xe5"
-	"\x02\x20"
-	"\x43\x45\xd0\xa5\xff\xe5\x13\x27\x26\xd0\xec\x37\xad\x24\x1e\x9a"
-	"\x71\x9a\xa4\x89\xb0\x7e\x0f\xc4\xbb\x2d\x50\xd0\xe5\x7f\x7a\x68",
-	.c_size = 70,
-	.algo = OID_SM2_with_SM3,
-	.m =
-	"\x11\x22\x33\x44\x55\x66\x77\x88\x99\xaa\xbb\xcc\xdd\xee\xff\x00"
-	"\x12\x34\x56\x78\x9a\xbc\xde\xf0\x12\x34\x56\x78\x9a\xbc\xde\xf0",
-	.m_size = 32,
-	.public_key_vec = true,
-	.siggen_sigver_test = true,
-	},
-};
-
 /* Example vectors below taken from
  * http://www.oscca.gov.cn/UpFile/20101222141857786.pdf
  *
diff --git a/include/crypto/sm2.h b/include/crypto/sm2.h
deleted file mode 100644
index 04a92c1013c8..000000000000
--- a/include/crypto/sm2.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * sm2.h - SM2 asymmetric public-key algorithm
- * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
- * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
- *
- * Copyright (c) 2020, Alibaba Group.
- * Written by Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
- */
-
-#ifndef _CRYPTO_SM2_H
-#define _CRYPTO_SM2_H
-
-struct shash_desc;
-
-#if IS_REACHABLE(CONFIG_CRYPTO_SM2)
-int sm2_compute_z_digest(struct shash_desc *desc,
-			 const void *key, unsigned int keylen, void *dgst);
-#else
-static inline int sm2_compute_z_digest(struct shash_desc *desc,
-				       const void *key, unsigned int keylen,
-				       void *dgst)
-{
-	return -ENOTSUPP;
-}
-#endif
-
-#endif /* _CRYPTO_SM2_H */
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index de603cf42ac7..457c0a396caf 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -114,8 +114,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	} else if (!strncmp(pk->pkey_algo, "ecdsa-", 6)) {
 		/* edcsa-nist-p192 etc. */
 		pks.encoding = "x962";
-	} else if (!strcmp(pk->pkey_algo, "ecrdsa") ||
-		   !strcmp(pk->pkey_algo, "sm2")) {
+	} else if (!strcmp(pk->pkey_algo, "ecrdsa")) {
 		pks.encoding = "raw";
 	} else {
 		ret = -ENOPKG;
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

