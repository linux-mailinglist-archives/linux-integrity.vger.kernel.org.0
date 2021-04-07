Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0537A356D95
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbhDGNmk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347453AbhDGNmh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 09:42:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B57C061756;
        Wed,  7 Apr 2021 06:42:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a12so12936547pfc.7;
        Wed, 07 Apr 2021 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EsKCb+rhAYt6Up6vVPXMuPyNkrancdbPg36I5kk1aPQ=;
        b=FDgdXZYDIb3W0JEJSPZJOEw5Xo7PESKgUqpB8VJyScMlZceQfXFmiekWuJfyU/Kq0Q
         wXBTg7Z4D3qv+Ze0h5AFQ7Tc4P3/o/F2o96TBYxeSuGIJzXBXHGEsODezEOY4zgOOAPR
         B9XZsInziJpoGsUI5Fw3Rayf8Wl/ujfbO/MkDaZRAsXcxB0s57FG14x1vOViFkUPJvHA
         6VmaX/sUhM+y+k3SKi9yquGFcj2g9vJgqR4GMSAJkoxwn4AlN/vEZnIxgTBgC2ps+qrP
         OiJ1tawiXO/PYp+I3b2s+GXHh/gsgH81W6qi+iIDtv0s+w3idC3ybClik+5tQqacwHJr
         q1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EsKCb+rhAYt6Up6vVPXMuPyNkrancdbPg36I5kk1aPQ=;
        b=SYPDOGQzqME0VbNiMuvNPjtoMz/0u6v+mryUvIZXpx0UJRbr0FM7fGg7k0eOFcLBIG
         31LJ9MB0Rv9ixK2FaWXNF/5cdY6HtohGtk3Zy+DUF3IHlx7Vsd7Gdxe1kN+OHOoYaLUb
         dIS2pSqWUSx5HpVUg32JOrrhepFPIo6gukPjso4I51iO692BCLLcbl82YfVPLLBpWSbK
         7Nv8Pdz6frEJ798FzTLsns/KhyFI+IPAwo/MWZPOHHpYzrO5V8AIOk+52PidgK5Yydp3
         2ceZEWnUwAktuJj/dDSPxRfsClL+wNU/l/gCSp5do4qVv3AvsbfVww59wTUDGGH4VtkD
         hvow==
X-Gm-Message-State: AOAM532IKh3pUOCfAUHU5MdZ0Vlf0Y6igpqebwGFipxRI1/Cx8UrPvmL
        vQnXmh5AsBFbuHQQEXq+XlpSUdgHjFRJnQ==
X-Google-Smtp-Source: ABdhPJzYRO+HsX86nrSbaCStYrcjvGAyt88EkG7o1lMxY7SZNz8NXwZ2FowstBTXf+HkKdalOl9Ynw==
X-Received: by 2002:a63:f40b:: with SMTP id g11mr3489288pgi.133.1617802947467;
        Wed, 07 Apr 2021 06:42:27 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id t65sm1547350pfd.5.2021.04.07.06.42.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 06:42:27 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org, herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        herbert.tencent@gmail.com
Subject: [PATCH v4 2/4] crypto: support rsa-pss encoding
Date:   Wed,  7 Apr 2021 21:41:44 +0800
Message-Id: <1617802906-30513-3-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617802906-30513-1-git-send-email-herbert.tencent@gmail.com>
References: <1617802906-30513-1-git-send-email-herbert.tencent@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch add the support of rsa-pss encoding which is described in
RFC8017 section 8.1 and section 9.1.

Similar to rsa-pkcs1, we create a pss template. Parse pss related params
mgfhash and saltlen in set_pub_key.

Implement a mgf function according to RFC8017 section B.2.
Implement the verification according to RFC8017 section 8.1.2 and 9.1.2

Signed-off-by: Hongbo Li <herbert.tencent@gmail.com>
---
 crypto/Makefile               |   7 +-
 crypto/rsa-psspad.c           | 398 ++++++++++++++++++++++++++++++++++++++++++
 crypto/rsa.c                  |  14 +-
 crypto/rsa_helper.c           | 127 ++++++++++++++
 crypto/rsapss_params.asn1     |  21 +++
 include/crypto/internal/rsa.h |  25 ++-
 6 files changed, 583 insertions(+), 9 deletions(-)
 create mode 100644 crypto/rsa-psspad.c
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
diff --git a/crypto/rsa-psspad.c b/crypto/rsa-psspad.c
new file mode 100644
index 0000000..342c4cc
--- /dev/null
+++ b/crypto/rsa-psspad.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RSA PSS padding templates.
+ *
+ * Copyright (c) 2021 Hongbo Li <herberthbli@tencent.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <crypto/hash.h>
+#include <crypto/internal/rsa.h>
+#include <crypto/internal/akcipher.h>
+
+struct psspad_inst_ctx {
+	struct crypto_akcipher_spawn spawn;
+};
+
+struct psspad_request {
+	struct scatterlist out_sg[1];
+	uint8_t *out_buf;
+	struct akcipher_request child_req;
+};
+
+static const u8 *psspad_unpack(void *dst, const void *src, size_t sz)
+{
+	memcpy(dst, src, sz);
+	return src + sz;
+}
+
+static int psspad_set_pub_key(struct crypto_akcipher *tfm, const void *key,
+			      unsigned int keylen)
+{
+	struct rsa_pss_ctx *ctx = akcipher_tfm_ctx(tfm);
+	const u8 *ptr;
+	u32 algo, paramlen;
+	int err;
+
+	ctx->key_size = 0;
+
+	err = crypto_akcipher_set_pub_key(ctx->child, key, keylen);
+	if (err)
+		return err;
+
+	/* Find out new modulus size from rsa implementation */
+	err = crypto_akcipher_maxsize(ctx->child);
+	if (err > PAGE_SIZE)
+		return -EOPNOTSUPP;
+
+	ctx->key_size = err;
+
+	ptr = key + keylen;
+	ptr = psspad_unpack(&algo, ptr, sizeof(algo));
+	ptr = psspad_unpack(&paramlen, ptr, sizeof(paramlen));
+	err = rsa_parse_pss_params(ctx, ptr, paramlen);
+	if (err < 0)
+		return err;
+
+	if (!ctx->hash_algo)
+		ctx->hash_algo = "sha1";
+	if (!ctx->mgf_algo)
+		ctx->mgf_algo = "mgf1";
+	if (!ctx->mgf_hash_algo)
+		ctx->mgf_hash_algo = "sha1";
+	if (!ctx->salt_len)
+		ctx->salt_len = RSA_PSS_DEFAULT_SALT_LEN;
+
+	return 0;
+}
+
+static int psspad_mgf1(const char *hash_algo, u8 *seed, u32 seed_len, u8 *mask,
+		       u32 masklen)
+{
+	struct crypto_shash *tfm = NULL;
+	u32 hlen, cnt, tlen;
+	u8 c[4], digest[RSA_MAX_DIGEST_SIZE], buf[RSA_MAX_DIGEST_SIZE + 4];
+	int i, err = 0;
+	SHASH_DESC_ON_STACK(desc, tfm);
+
+	tfm = crypto_alloc_shash(hash_algo, 0, 0);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		return err;
+	}
+	desc->tfm = tfm;
+	hlen = crypto_shash_digestsize(tfm);
+	cnt = DIV_ROUND_UP(masklen, hlen);
+	tlen = 0;
+	for (i = 0; i < cnt; i++) {
+		/* C = I2OSP (counter, 4) */
+		c[0] = (i >> 24) & 0xff;
+		c[1] = (i >> 16) & 0xff;
+		c[2] = (i >> 8) & 0xff;
+		c[3] = i & 0xff;
+
+		memcpy(buf, seed, seed_len);
+		memcpy(buf + seed_len, c, 4);
+		err = crypto_shash_digest(desc, buf,
+					  seed_len + 4, digest);
+		if (err < 0)
+			goto free;
+
+		/* T = T || Hash(mgfSeed || C) */
+		tlen = i * hlen;
+		if (i == cnt - 1)
+			memcpy(mask + tlen, digest, masklen - tlen);
+		else
+			memcpy(mask + tlen, digest, hlen);
+	}
+free:
+	crypto_free_shash(tfm);
+	return err;
+}
+
+/* EMSA-PSS-VERIFY (M, EM, emBits) */
+static int psspad_verify_complete(struct akcipher_request *req, int err)
+{
+	struct crypto_akcipher *ak_tfm = crypto_akcipher_reqtfm(req);
+	struct rsa_pss_ctx *ctx = akcipher_tfm_ctx(ak_tfm);
+	struct psspad_request *req_ctx = akcipher_request_ctx(req);
+	struct crypto_akcipher *rsa_tfm;
+	struct rsa_mpi_key *mpi_key;
+	struct crypto_shash *tfm = NULL;
+	u32 i, hlen, slen, modbits, embits, emlen, masklen, buflen;
+	u8 *em, *h, *maskeddb, *dbmask, *db, *salt;
+	u8 mhash[RSA_MAX_DIGEST_SIZE], digest[RSA_MAX_DIGEST_SIZE];
+	u8 *buf = NULL;
+	SHASH_DESC_ON_STACK(desc, tfm);
+
+	if (err)
+		goto free;
+
+	tfm = crypto_alloc_shash(ctx->hash_algo, 0, 0);
+	if (IS_ERR(tfm)) {
+		err = PTR_ERR(tfm);
+		tfm = NULL;
+		goto free;
+	}
+	desc->tfm = tfm;
+	hlen = crypto_shash_digestsize(tfm);
+
+	/* mhash */
+	sg_pcopy_to_buffer(req->src,
+			   sg_nents_for_len(req->src,
+					    req->src_len + req->dst_len),
+			   mhash, hlen, req->src_len);
+
+	err = -EINVAL;
+
+	/* section 8.1.2. emLen = \ceil ((modBits - 1)/8) */
+	rsa_tfm = crypto_akcipher_reqtfm(&req_ctx->child_req);
+	mpi_key = akcipher_tfm_ctx(rsa_tfm);
+	modbits = mpi_get_nbits(mpi_key->n);
+	embits = modbits - 1;
+	emlen = DIV_ROUND_UP(embits, 8);
+
+	/* 3. If emLen < hLen + sLen + 2, output "inconsistent" and stop. */
+	slen = ctx->salt_len;
+	if (emlen < hlen + slen + 2)
+		goto free;
+
+	/* 4. If the rightmost octet of EM does not have hexadecimal value
+	 * 0xbc, output "inconsistent" and stop.
+	 */
+	em = req_ctx->out_buf;
+	if (em[emlen - 1] != 0xbc)
+		goto free;
+
+
+	/* 5. Let maskedDB be the leftmost emLen - hLen - 1 octets of EM,
+	 * and let H be the next hLen octets.
+	 */
+	maskeddb = em;
+	masklen = emlen - hlen - 1;
+	h = em + masklen;
+
+	/* 6. If the leftmost 8emLen - emBits bits of the leftmost octet in
+	 * maskedDB are not all equal to zero, output "inconsistent" and
+	 * stop.
+	 */
+	if (maskeddb[0] & ~(0xff >> (8 * emlen - embits)))
+		goto free;
+
+	/* 7. Let dbMask = MGF(H, emLen - hLen - 1). */
+	buflen = max_t(u32, masklen, 8 + hlen + slen);
+	buf = kmalloc(buflen, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto free;
+	}
+	dbmask = buf;
+	err = psspad_mgf1(ctx->mgf_hash_algo, h, hlen, dbmask, masklen);
+	if (err)
+		goto free;
+
+	/* 8. Let DB = maskedDB \xor dbMask. */
+	db = maskeddb;
+	for (i = 0; i < masklen; i++)
+		db[i] = maskeddb[i] ^ dbmask[i];
+
+	/* 9. Set the leftmost 8emLen - emBits bits of the leftmost octet
+	 * in DB to zero.
+	 */
+	db[0] &= 0xff >> (8 * emlen - embits);
+
+	/* 10. If the emLen - hLen - sLen - 2 leftmost octets of DB are not
+	 * zero or if the octet at position emLen - hLen - sLen - 1 (the
+	 * leftmost position is "position 1") does not have hexadecimal
+	 * value 0x01, output "inconsistent" and stop.
+	 */
+	for (i = 0; i < emlen - hlen - slen - 2; i++) {
+		if (db[i]) {
+			err = -EINVAL;
+			goto free;
+		}
+	}
+	if (db[i] != 1)
+		goto free;
+
+	/* 11. Let salt be the last sLen octets of DB. */
+	salt = db + masklen - slen;
+
+	/* 12. M' = (0x)00 00 00 00 00 00 00 00 || mHash || salt ; */
+	memset(buf, 0, 8);
+	memcpy(buf + 8, mhash, hlen);
+	memcpy(buf + 8 + hlen, salt, slen);
+
+	/* 13. Let H' = Hash(M'), an octet string of length hLen. */
+	err = crypto_shash_digest(desc, buf, 8 + hlen + slen, digest);
+	if (err < 0)
+		goto free;
+
+	/* 14. If H = H', output "consistent". Otherwise, output
+	 * "inconsistent".
+	 */
+	if (memcmp(h, digest, hlen))
+		err = -EKEYREJECTED;
+
+free:
+	if (tfm)
+		crypto_free_shash(tfm);
+	kfree_sensitive(req_ctx->out_buf);
+	kfree(buf);
+	return err;
+}
+
+static void psspad_verify_complete_cb(
+	struct crypto_async_request *child_async_req, int err)
+{
+	struct akcipher_request *req = child_async_req->data;
+	struct crypto_async_request async_req;
+
+	if (err == -EINPROGRESS)
+		return;
+
+	async_req.data = req->base.data;
+	async_req.tfm = crypto_akcipher_tfm(crypto_akcipher_reqtfm(req));
+	async_req.flags = child_async_req->flags;
+	req->base.complete(&async_req, psspad_verify_complete(req, err));
+}
+
+static int psspad_verify(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct rsa_pss_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct psspad_request *req_ctx = akcipher_request_ctx(req);
+	int err;
+
+	if (WARN_ON(req->dst) ||
+	    WARN_ON(!req->dst_len) ||
+	    !ctx->key_size || req->src_len < ctx->key_size)
+		return -EINVAL;
+
+	req_ctx->out_buf = kmalloc(ctx->key_size + req->dst_len, GFP_KERNEL);
+	if (!req_ctx->out_buf)
+		return -ENOMEM;
+
+	sg_init_table(req_ctx->out_sg, 1);
+	sg_set_buf(req_ctx->out_sg, req_ctx->out_buf, ctx->key_size);
+
+	akcipher_request_set_tfm(&req_ctx->child_req, ctx->child);
+	akcipher_request_set_callback(&req_ctx->child_req, req->base.flags,
+				      psspad_verify_complete_cb, req);
+
+	/* Reuse input buffer, output to a new buffer */
+	akcipher_request_set_crypt(&req_ctx->child_req, req->src,
+				   req_ctx->out_sg, req->src_len,
+				   ctx->key_size);
+
+	err = crypto_akcipher_encrypt(&req_ctx->child_req);
+	if (err != -EINPROGRESS && err != -EBUSY)
+		return psspad_verify_complete(req, err);
+
+	return err;
+}
+
+static unsigned int psspad_get_max_size(struct crypto_akcipher *tfm)
+{
+	struct rsa_pss_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return ctx->key_size;
+}
+
+static int psspad_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct akcipher_instance *inst = akcipher_alg_instance(tfm);
+	struct psspad_inst_ctx *ictx = akcipher_instance_ctx(inst);
+	struct rsa_pss_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct crypto_akcipher *child_tfm;
+
+	child_tfm = crypto_spawn_akcipher(&ictx->spawn);
+	if (IS_ERR(child_tfm))
+		return PTR_ERR(child_tfm);
+
+	ctx->child = child_tfm;
+	return 0;
+}
+
+static void psspad_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct rsa_pss_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	crypto_free_akcipher(ctx->child);
+}
+
+static void psspad_free(struct akcipher_instance *inst)
+{
+	struct psspad_inst_ctx *ctx = akcipher_instance_ctx(inst);
+	struct crypto_akcipher_spawn *spawn = &ctx->spawn;
+
+	crypto_drop_akcipher(spawn);
+	kfree(inst);
+}
+
+static int psspad_create(struct crypto_template *tmpl, struct rtattr **tb)
+{
+	u32 mask;
+	struct akcipher_instance *inst;
+	struct psspad_inst_ctx *ctx;
+	struct akcipher_alg *rsa_alg;
+	int err;
+
+	err = crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_AKCIPHER, &mask);
+	if (err)
+		return err;
+
+	inst = kzalloc(sizeof(*inst) + sizeof(*ctx), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	ctx = akcipher_instance_ctx(inst);
+
+	err = crypto_grab_akcipher(&ctx->spawn, akcipher_crypto_instance(inst),
+				   crypto_attr_alg_name(tb[1]), 0, mask);
+	if (err)
+		goto err_free_inst;
+
+	rsa_alg = crypto_spawn_akcipher_alg(&ctx->spawn);
+
+	err = -ENAMETOOLONG;
+	if (snprintf(inst->alg.base.cra_name,
+		     CRYPTO_MAX_ALG_NAME, "psspad(%s)",
+		     rsa_alg->base.cra_name) >= CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
+
+	if (snprintf(inst->alg.base.cra_driver_name,
+		     CRYPTO_MAX_ALG_NAME, "psspad(%s)",
+		     rsa_alg->base.cra_driver_name) >=
+	    CRYPTO_MAX_ALG_NAME)
+		goto err_free_inst;
+
+	inst->alg.base.cra_priority = rsa_alg->base.cra_priority;
+	inst->alg.base.cra_ctxsize = sizeof(struct rsa_pss_ctx);
+
+	inst->alg.init = psspad_init_tfm;
+	inst->alg.exit = psspad_exit_tfm;
+	inst->alg.verify = psspad_verify;
+	inst->alg.set_pub_key = psspad_set_pub_key;
+	inst->alg.max_size = psspad_get_max_size;
+	inst->alg.reqsize = sizeof(struct psspad_request) + rsa_alg->reqsize;
+
+	inst->free = psspad_free;
+
+	err = akcipher_register_instance(tmpl, inst);
+	if (err) {
+err_free_inst:
+		psspad_free(inst);
+	}
+	return err;
+}
+
+struct crypto_template rsa_psspad_tmpl = {
+	.name = "psspad",
+	.create = psspad_create,
+	.module = THIS_MODULE,
+};
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

