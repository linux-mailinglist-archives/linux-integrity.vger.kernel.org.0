Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A03B219B3C
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgGIIkd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 04:40:33 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56875 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbgGIIka (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 04:40:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0U2BnTA6_1594284019;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U2BnTA6_1594284019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Jul 2020 16:40:20 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, vt@altlinux.org, gilad@benyossef.com,
        pvanleeuwen@rambus.com, zhang.jia@linux.alibaba.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH v5 4/8] crypto: sm2 - introduce OSCCA SM2 asymmetric cipher algorithm
Date:   Thu,  9 Jul 2020 16:40:11 +0800
Message-Id: <20200709084015.21886-5-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
References: <20200709084015.21886-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This new module implement the SM2 public key algorithm. It was
published by State Encryption Management Bureau, China.
List of specifications for SM2 elliptic curve public key cryptography:

* GM/T 0003.1-2012
* GM/T 0003.2-2012
* GM/T 0003.3-2012
* GM/T 0003.4-2012
* GM/T 0003.5-2012

IETF: https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
oscca: http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
scctc: http://www.gmbz.org.cn/main/bzlb.html

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/Kconfig           |  17 ++
 crypto/Makefile          |   8 +
 crypto/sm2.c             | 473 +++++++++++++++++++++++++++++++++++++++
 crypto/sm2signature.asn1 |   4 +
 include/crypto/sm2.h     |  25 +++
 5 files changed, 527 insertions(+)
 create mode 100644 crypto/sm2.c
 create mode 100644 crypto/sm2signature.asn1
 create mode 100644 include/crypto/sm2.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 091c0a0bbf26..de330d658758 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -260,6 +260,23 @@ config CRYPTO_ECRDSA
 	  standard algorithms (called GOST algorithms). Only signature verification
 	  is implemented.
 
+config CRYPTO_SM2
+	tristate "SM2 algorithm"
+	select CRYPTO_SM3
+	select CRYPTO_AKCIPHER
+	select CRYPTO_MANAGER
+	select MPILIB
+	select ASN1
+	help
+	  Generic implementation of the SM2 public key algorithm. It was
+	  published by State Encryption Management Bureau, China.
+	  as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012.
+
+	  References:
+	  https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
+	  http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
+	  http://www.gmbz.org.cn/main/bzlb.html
+
 config CRYPTO_CURVE25519
 	tristate "Curve25519 algorithm"
 	select CRYPTO_KPP
diff --git a/crypto/Makefile b/crypto/Makefile
index 4ca12b6044f7..b279483fba50 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -42,6 +42,14 @@ rsa_generic-y += rsa_helper.o
 rsa_generic-y += rsa-pkcs1pad.o
 obj-$(CONFIG_CRYPTO_RSA) += rsa_generic.o
 
+$(obj)/sm2signature.asn1.o: $(obj)/sm2signature.asn1.c $(obj)/sm2signature.asn1.h
+$(obj)/sm2.o: $(obj)/sm2signature.asn1.h
+
+sm2_generic-y += sm2signature.asn1.o
+sm2_generic-y += sm2.o
+
+obj-$(CONFIG_CRYPTO_SM2) += sm2_generic.o
+
 crypto_acompress-y := acompress.o
 crypto_acompress-y += scompress.o
 obj-$(CONFIG_CRYPTO_ACOMP2) += crypto_acompress.o
diff --git a/crypto/sm2.c b/crypto/sm2.c
new file mode 100644
index 000000000000..86da175bcda6
--- /dev/null
+++ b/crypto/sm2.c
@@ -0,0 +1,473 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM2 asymmetric public-key algorithm
+ * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
+ * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
+ *
+ * Copyright (c) 2020, Alibaba Group.
+ * Authors: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mpi.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/akcipher.h>
+#include <crypto/hash.h>
+#include <crypto/sm3_base.h>
+#include <crypto/rng.h>
+#include <crypto/sm2.h>
+#include "sm2signature.asn1.h"
+
+#define MPI_NBYTES(m)   ((mpi_get_nbits(m) + 7) / 8)
+
+struct ecc_domain_parms {
+	const char *desc;           /* Description of the curve.  */
+	unsigned int nbits;         /* Number of bits.  */
+	unsigned int fips:1; /* True if this is a FIPS140-2 approved curve */
+
+	/* The model describing this curve.  This is mainly used to select
+	 * the group equation.
+	 */
+	enum gcry_mpi_ec_models model;
+
+	/* The actual ECC dialect used.  This is used for curve specific
+	 * optimizations and to select encodings etc.
+	 */
+	enum ecc_dialects dialect;
+
+	const char *p;              /* The prime defining the field.  */
+	const char *a, *b;          /* The coefficients.  For Twisted Edwards
+				     * Curves b is used for d.  For Montgomery
+				     * Curves (a,b) has ((A-2)/4,B^-1).
+				     */
+	const char *n;              /* The order of the base point.  */
+	const char *g_x, *g_y;      /* Base point.  */
+	unsigned int h;             /* Cofactor.  */
+};
+
+static const struct ecc_domain_parms sm2_ecp = {
+	.desc = "sm2p256v1",
+	.nbits = 256,
+	.fips = 0,
+	.model = MPI_EC_WEIERSTRASS,
+	.dialect = ECC_DIALECT_STANDARD,
+	.p   = "0xfffffffeffffffffffffffffffffffffffffffff00000000ffffffffffffffff",
+	.a   = "0xfffffffeffffffffffffffffffffffffffffffff00000000fffffffffffffffc",
+	.b   = "0x28e9fa9e9d9f5e344d5a9e4bcf6509a7f39789f515ab8f92ddbcbd414d940e93",
+	.n   = "0xfffffffeffffffffffffffffffffffff7203df6b21c6052b53bbf40939d54123",
+	.g_x = "0x32c4ae2c1f1981195f9904466a39c9948fe30bbff2660be1715a4589334c74c7",
+	.g_y = "0xbc3736a2f4f6779c59bdcee36b692153d0a9877cc62a474002df32e52139f0a0",
+	.h = 1
+};
+
+static int sm2_ec_ctx_init(struct mpi_ec_ctx *ec)
+{
+	const struct ecc_domain_parms *ecp = &sm2_ecp;
+	MPI p, a, b;
+	MPI x, y;
+	int rc = -EINVAL;
+
+	p = mpi_scanval(ecp->p);
+	a = mpi_scanval(ecp->a);
+	b = mpi_scanval(ecp->b);
+	if (!p || !a || !b)
+		goto free_p;
+
+	x = mpi_scanval(ecp->g_x);
+	y = mpi_scanval(ecp->g_y);
+	if (!x || !y)
+		goto free;
+
+	/* mpi_ec_setup_elliptic_curve */
+	ec->G = mpi_point_new(0);
+	if (!ec->G)
+		goto free;
+
+	mpi_set(ec->G->x, x);
+	mpi_set(ec->G->y, y);
+	mpi_set_ui(ec->G->z, 1);
+
+	ec->n = mpi_scanval(ecp->n);
+	if (!ec->n) {
+		mpi_point_release(ec->G);
+		goto free;
+	}
+
+	ec->h = ecp->h;
+	ec->name = ecp->desc;
+	mpi_ec_init(ec, ecp->model, ecp->dialect, 0, p, a, b);
+
+	rc = 0;
+
+free:
+	mpi_free(x);
+	mpi_free(y);
+free_p:
+	mpi_free(p);
+	mpi_free(a);
+	mpi_free(b);
+
+	return rc;
+}
+
+static void sm2_ec_ctx_deinit(struct mpi_ec_ctx *ec)
+{
+	mpi_free(ec->n);
+	mpi_point_release(ec->G);
+
+	mpi_ec_deinit(ec);
+
+	memset(ec, 0, sizeof(*ec));
+}
+
+static int sm2_ec_ctx_reset(struct mpi_ec_ctx *ec)
+{
+	sm2_ec_ctx_deinit(ec);
+	return sm2_ec_ctx_init(ec);
+}
+
+/* RESULT must have been initialized and is set on success to the
+ * point given by VALUE.
+ */
+static int sm2_ecc_os2ec(MPI_POINT result, MPI value)
+{
+	int rc;
+	size_t n;
+	const unsigned char *buf;
+	unsigned char *buf_memory;
+	MPI x, y;
+
+	n = (mpi_get_nbits(value)+7)/8;
+	buf_memory = kmalloc(n, GFP_KERNEL);
+	rc = mpi_print(GCRYMPI_FMT_USG, buf_memory, n, &n, value);
+	if (rc) {
+		kfree(buf_memory);
+		return rc;
+	}
+	buf = buf_memory;
+
+	if (n < 1) {
+		kfree(buf_memory);
+		return -EINVAL;
+	}
+	if (*buf != 4) {
+		kfree(buf_memory);
+		return -EINVAL; /* No support for point compression.  */
+	}
+	if (((n-1)%2)) {
+		kfree(buf_memory);
+		return -EINVAL;
+	}
+	n = (n-1)/2;
+	x = mpi_read_raw_data(buf + 1, n);
+	if (!x) {
+		kfree(buf_memory);
+		return -ENOMEM;
+	}
+	y = mpi_read_raw_data(buf + 1 + n, n);
+	kfree(buf_memory);
+	if (!y) {
+		mpi_free(x);
+		return -ENOMEM;
+	}
+
+	mpi_normalize(x);
+	mpi_normalize(y);
+
+	mpi_set(result->x, x);
+	mpi_set(result->y, y);
+	mpi_set_ui(result->z, 1);
+
+	mpi_free(x);
+	mpi_free(y);
+
+	return 0;
+}
+
+struct sm2_signature_ctx {
+	MPI sig_r;
+	MPI sig_s;
+};
+
+int sm2_get_signature_r(void *context, size_t hdrlen, unsigned char tag,
+				const void *value, size_t vlen)
+{
+	struct sm2_signature_ctx *sig = context;
+
+	if (!value || !vlen)
+		return -EINVAL;
+
+	sig->sig_r = mpi_read_raw_data(value, vlen);
+	if (!sig->sig_r)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int sm2_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
+				const void *value, size_t vlen)
+{
+	struct sm2_signature_ctx *sig = context;
+
+	if (!value || !vlen)
+		return -EINVAL;
+
+	sig->sig_s = mpi_read_raw_data(value, vlen);
+	if (!sig->sig_s)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int sm2_z_digest_update(struct shash_desc *desc,
+			MPI m, unsigned int pbytes)
+{
+	static const unsigned char zero[32];
+	unsigned char *in;
+	unsigned int inlen;
+
+	in = mpi_get_buffer(m, &inlen, NULL);
+	if (!in)
+		return -EINVAL;
+
+	if (inlen < pbytes) {
+		/* padding with zero */
+		crypto_sm3_update(desc, zero, pbytes - inlen);
+		crypto_sm3_update(desc, in, inlen);
+	} else if (inlen > pbytes) {
+		/* skip the starting zero */
+		crypto_sm3_update(desc, in + inlen - pbytes, pbytes);
+	} else {
+		crypto_sm3_update(desc, in, inlen);
+	}
+
+	kfree(in);
+	return 0;
+}
+
+static int sm2_z_digest_update_point(struct shash_desc *desc,
+			MPI_POINT point, struct mpi_ec_ctx *ec, unsigned int pbytes)
+{
+	MPI x, y;
+	int ret = -EINVAL;
+
+	x = mpi_new(0);
+	y = mpi_new(0);
+
+	if (!mpi_ec_get_affine(x, y, point, ec) &&
+		!sm2_z_digest_update(desc, x, pbytes) &&
+		!sm2_z_digest_update(desc, y, pbytes))
+		ret = 0;
+
+	mpi_free(x);
+	mpi_free(y);
+	return ret;
+}
+
+int sm2_compute_z_digest(struct crypto_akcipher *tfm,
+			const unsigned char *id, size_t id_len,
+			unsigned char dgst[SM3_DIGEST_SIZE])
+{
+	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
+	uint16_t bits_len;
+	unsigned char entl[2];
+	SHASH_DESC_ON_STACK(desc, NULL);
+	unsigned int pbytes;
+
+	if (id_len > (USHRT_MAX / 8) || !ec->Q)
+		return -EINVAL;
+
+	bits_len = (uint16_t)(id_len * 8);
+	entl[0] = bits_len >> 8;
+	entl[1] = bits_len & 0xff;
+
+	pbytes = MPI_NBYTES(ec->p);
+
+	/* ZA = H256(ENTLA | IDA | a | b | xG | yG | xA | yA) */
+	sm3_base_init(desc);
+	crypto_sm3_update(desc, entl, 2);
+	crypto_sm3_update(desc, id, id_len);
+
+	if (sm2_z_digest_update(desc, ec->a, pbytes) ||
+		sm2_z_digest_update(desc, ec->b, pbytes) ||
+		sm2_z_digest_update_point(desc, ec->G, ec, pbytes) ||
+		sm2_z_digest_update_point(desc, ec->Q, ec, pbytes))
+		return -EINVAL;
+
+	crypto_sm3_finup(desc, NULL, 0, dgst);
+	return 0;
+}
+EXPORT_SYMBOL(sm2_compute_z_digest);
+
+static int _sm2_verify(struct mpi_ec_ctx *ec, MPI hash, MPI sig_r, MPI sig_s)
+{
+	int rc = -EINVAL;
+	struct gcry_mpi_point sG, tP;
+	MPI t = NULL;
+	MPI x1 = NULL, y1 = NULL;
+
+	mpi_point_init(&sG);
+	mpi_point_init(&tP);
+	x1 = mpi_new(0);
+	y1 = mpi_new(0);
+	t = mpi_new(0);
+
+	/* r, s in [1, n-1] */
+	if (mpi_cmp_ui(sig_r, 1) < 0 || mpi_cmp(sig_r, ec->n) > 0 ||
+		mpi_cmp_ui(sig_s, 1) < 0 || mpi_cmp(sig_s, ec->n) > 0) {
+		goto leave;
+	}
+
+	/* t = (r + s) % n, t == 0 */
+	mpi_addm(t, sig_r, sig_s, ec->n);
+	if (mpi_cmp_ui(t, 0) == 0)
+		goto leave;
+
+	/* sG + tP = (x1, y1) */
+	rc = -EBADMSG;
+	mpi_ec_mul_point(&sG, sig_s, ec->G, ec);
+	mpi_ec_mul_point(&tP, t, ec->Q, ec);
+	mpi_ec_add_points(&sG, &sG, &tP, ec);
+	if (mpi_ec_get_affine(x1, y1, &sG, ec))
+		goto leave;
+
+	/* R = (e + x1) % n */
+	mpi_addm(t, hash, x1, ec->n);
+
+	/* check R == r */
+	rc = -EKEYREJECTED;
+	if (mpi_cmp(t, sig_r))
+		goto leave;
+
+	rc = 0;
+
+leave:
+	mpi_point_free_parts(&sG);
+	mpi_point_free_parts(&tP);
+	mpi_free(x1);
+	mpi_free(y1);
+	mpi_free(t);
+
+	return rc;
+}
+
+static int sm2_verify(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
+	unsigned char *buffer;
+	struct sm2_signature_ctx sig;
+	MPI hash;
+	int ret;
+
+	if (unlikely(!ec->Q))
+		return -EINVAL;
+
+	buffer = kmalloc(req->src_len + req->dst_len, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	sg_pcopy_to_buffer(req->src,
+			sg_nents_for_len(req->src, req->src_len + req->dst_len),
+			buffer, req->src_len + req->dst_len, 0);
+
+	sig.sig_r = NULL;
+	sig.sig_s = NULL;
+	ret = asn1_ber_decoder(&sm2signature_decoder, &sig, buffer, req->src_len);
+	if (ret)
+		goto error;
+
+	ret = -ENOMEM;
+	hash = mpi_read_raw_data(buffer + req->src_len, req->dst_len);
+	if (!hash)
+		goto error;
+
+	ret = _sm2_verify(ec, hash, sig.sig_r, sig.sig_s);
+
+	mpi_free(hash);
+error:
+	mpi_free(sig.sig_r);
+	mpi_free(sig.sig_s);
+	kfree(buffer);
+	return ret;
+}
+
+static int sm2_set_pub_key(struct crypto_akcipher *tfm, const void *key,
+						unsigned int keylen)
+{
+	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
+	MPI a;
+	int rc;
+
+	rc = sm2_ec_ctx_reset(ec);
+	if (rc)
+		return rc;
+
+	ec->Q = mpi_point_new(0);
+	if (!ec->Q)
+		return -ENOMEM;
+
+	/* include the uncompressed flag '0x04' */
+	rc = -ENOMEM;
+	a = mpi_read_raw_data(key, keylen);
+	if (!a)
+		goto error;
+
+	mpi_normalize(a);
+	rc = sm2_ecc_os2ec(ec->Q, a);
+	mpi_free(a);
+	if (rc)
+		goto error;
+
+	return 0;
+
+error:
+	mpi_point_release(ec->Q);
+	ec->Q = NULL;
+	return rc;
+}
+
+static unsigned int sm2_max_size(struct crypto_akcipher *tfm)
+{
+	/* Unlimited max size */
+	return PAGE_SIZE;
+}
+
+static void sm2_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
+
+	mpi_ec_deinit(ec);
+}
+
+static struct akcipher_alg sm2 = {
+	.verify = sm2_verify,
+	.set_pub_key = sm2_set_pub_key,
+	.max_size = sm2_max_size,
+	.exit = sm2_exit_tfm,
+	.base = {
+		.cra_name = "sm2",
+		.cra_driver_name = "sm2-generic",
+		.cra_priority = 100,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct mpi_ec_ctx),
+	},
+};
+
+static int sm2_init(void)
+{
+	return crypto_register_akcipher(&sm2);
+}
+
+static void sm2_exit(void)
+{
+	crypto_unregister_akcipher(&sm2);
+}
+
+subsys_initcall(sm2_init);
+module_exit(sm2_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
+MODULE_DESCRIPTION("SM2 generic algorithm");
+MODULE_ALIAS_CRYPTO("sm2-generic");
diff --git a/crypto/sm2signature.asn1 b/crypto/sm2signature.asn1
new file mode 100644
index 000000000000..ab8c0b754d21
--- /dev/null
+++ b/crypto/sm2signature.asn1
@@ -0,0 +1,4 @@
+Sm2Signature ::= SEQUENCE {
+	sig_r	INTEGER ({ sm2_get_signature_r }),
+	sig_s	INTEGER ({ sm2_get_signature_s })
+}
diff --git a/include/crypto/sm2.h b/include/crypto/sm2.h
new file mode 100644
index 000000000000..af452556dcd4
--- /dev/null
+++ b/include/crypto/sm2.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * sm2.h - SM2 asymmetric public-key algorithm
+ * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
+ * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
+ *
+ * Copyright (c) 2020, Alibaba Group.
+ * Written by Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#ifndef _CRYPTO_SM2_H
+#define _CRYPTO_SM2_H
+
+#include <crypto/sm3.h>
+#include <crypto/akcipher.h>
+
+/* The default user id as specified in GM/T 0009-2012 */
+#define SM2_DEFAULT_USERID "1234567812345678"
+#define SM2_DEFAULT_USERID_LEN 16
+
+extern int sm2_compute_z_digest(struct crypto_akcipher *tfm,
+			const unsigned char *id, size_t id_len,
+			unsigned char dgst[SM3_DIGEST_SIZE]);
+
+#endif /* _CRYPTO_SM2_H */
-- 
2.17.1

