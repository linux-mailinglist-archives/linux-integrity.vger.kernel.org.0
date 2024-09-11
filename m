Return-Path: <linux-integrity+bounces-3526-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5133B975256
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763F31C25E08
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017F192B96;
	Wed, 11 Sep 2024 12:30:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77A192B78;
	Wed, 11 Sep 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057824; cv=none; b=ep8qJV/sRsxVt1v/lf78LfebBRx+LSUjnJro1RZr0/WKx47sHF0wJr9KHwQ6MJqzPYRdF4issQGUiCWVgg2xJmVWagYvJCCD/XYhzzdM0LF05G128lZUMPTysVFcvatXsG9oc4+kCm3xYBO4z3oQN1iocJNvz6nPJvZXqVXGQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057824; c=relaxed/simple;
	bh=AngZno8N41cMJowi+55kUrIQRWN72YhfLpSY0OqrLWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqsiQuIbXbv/zZDhYFDb1gb/gr4Ilk272E3/2dvQ6juEA+aGDJzLhXHmZbO6CpTdvkNuzF+OaK9YWc3dTTvtnRhoBW+MNzf+2SErsyQUWumzl2DEoUH1Sm/yjSHzIhu4SrzJP2hlLIKg5u0MmpvBOFixrUF/Dbf8F1gSrwrZVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X3fQW1zymz9v7JM;
	Wed, 11 Sep 2024 20:05:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9F4EF1404A8;
	Wed, 11 Sep 2024 20:30:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscjjeFmDBG3AA--.60453S8;
	Wed, 11 Sep 2024 13:30:09 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 06/14] KEYS: PGP data parser
Date: Wed, 11 Sep 2024 14:29:03 +0200
Message-Id: <20240911122911.1381864-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3pscjjeFmDBG3AA--.60453S8
X-Coremail-Antispam: 1UD129KBjvJXoW3KrW7XryfCr47Zw4kJF1rtFb_yoWkKw1fpa
	1rWrWUtrW8GF1SkrWfAFWxKas0yry0yFWag3ySy3Way39Iqr10k34Ikr4UuF9rtF4kJrW3
	KFsYvFyjyr1DJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQHzQAGsE

From: David Howells <dhowells@redhat.com>

Implement a PGP data parser for the crypto key type to use when
instantiating a key.

This parser attempts to parse the instantiation data as a PGP packet
sequence (RFC 9580), v4 keys only, and if it parses okay attempts to
extract a public-key algorithm key or subkey from it.

If it finds such a key, it will set up a public_key subtype payload with
appropriate handler routines (RSA) and attach it to the key.

Thanks to Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> for pointing
out some errors.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig          |  10 +
 crypto/asymmetric_keys/Makefile         |   4 +
 crypto/asymmetric_keys/pgp_parser.h     |  18 ++
 crypto/asymmetric_keys/pgp_public_key.c | 356 ++++++++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp_parser.h
 create mode 100644 crypto/asymmetric_keys/pgp_public_key.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 8215e3fcd8db..c69bfdc022c0 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -109,4 +109,14 @@ config PGP_LIBRARY
 	  This option enables a library that provides a number of simple
 	  utility functions for parsing PGP (RFC 9580) packet-based messages.
 
+config PGP_KEY_PARSER
+	tristate "PGP key parser"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select PGP_LIBRARY
+	select SHA1 # V4 fingerprint generation
+	help
+	  This option provides support for parsing PGP (RFC 9880) format blobs
+	  for key data and provides the ability to instantiate a crypto key
+	  from a public key packet found inside the blob.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 055b28207111..d197e8b23b83 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -84,3 +84,7 @@ $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
 # PGP handling
 #
 obj-$(CONFIG_PGP_LIBRARY) += pgp_library.o
+
+obj-$(CONFIG_PGP_KEY_PARSER) += pgp_key_parser.o
+pgp_key_parser-y := \
+	pgp_public_key.o
diff --git a/crypto/asymmetric_keys/pgp_parser.h b/crypto/asymmetric_keys/pgp_parser.h
new file mode 100644
index 000000000000..900f81f5ee14
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_parser.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP crypto data parser internal definitions
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include "pgplib.h"
+
+#define kenter(FMT, ...) \
+	pr_devel("==> %s(" FMT ")\n", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) \
+	pr_devel("<== %s()" FMT "\n", __func__, ##__VA_ARGS__)
+
+/*
+ * pgp_public_key.c
+ */
+extern const char *pgp_to_public_key_algo[PGP_PUBKEY__LAST];
diff --git a/crypto/asymmetric_keys/pgp_public_key.c b/crypto/asymmetric_keys/pgp_public_key.c
new file mode 100644
index 000000000000..94284a78bf9b
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_public_key.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Instantiate a public key crypto key from PGP format data [RFC 9580]
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) "PGP: "fmt
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mpi.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/asymmetric-parser.h>
+#include <crypto/hash.h>
+#include <crypto/public_key.h>
+
+#include "pgp_parser.h"
+
+#define MAX_MPI 5
+#define KEYCTL_SUPPORTS_ENCDEC \
+	(KEYCTL_SUPPORTS_ENCRYPT | KEYCTL_SUPPORTS_DECRYPT)
+#define KEYCTL_SUPPORTS_SIGVER (KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS_VERIFY)
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PGP key parser");
+
+const char *pgp_to_public_key_algo[PGP_PUBKEY__LAST] = {
+	[PGP_PUBKEY_RSA_ENC_OR_SIG]	= "rsa",
+	[PGP_PUBKEY_RSA_ENC_ONLY]	= "rsa",
+	[PGP_PUBKEY_RSA_SIG_ONLY]	= "rsa",
+};
+
+static const int pgp_key_algo_p_num_mpi[PGP_PUBKEY__LAST] = {
+	[PGP_PUBKEY_RSA_ENC_OR_SIG]	= 2,
+	[PGP_PUBKEY_RSA_ENC_ONLY]	= 2,
+	[PGP_PUBKEY_RSA_SIG_ONLY]	= 2,
+};
+
+static const u8 pgp_public_key_capabilities[PGP_PUBKEY__LAST] = {
+	[PGP_PUBKEY_RSA_ENC_OR_SIG]	= KEYCTL_SUPPORTS_ENCDEC |
+					  KEYCTL_SUPPORTS_SIGVER,
+	[PGP_PUBKEY_RSA_ENC_ONLY]	= KEYCTL_SUPPORTS_ENCDEC,
+	[PGP_PUBKEY_RSA_SIG_ONLY]	= KEYCTL_SUPPORTS_SIGVER,
+};
+
+static inline void digest_putc(struct shash_desc *digest, uint8_t ch)
+{
+	crypto_shash_update(digest, &ch, 1);
+}
+
+struct pgp_key_data_parse_context {
+	struct pgp_parse_context pgp;
+	struct public_key *pub;
+	u8 raw_fingerprint[HASH_MAX_DIGESTSIZE];
+	size_t raw_fingerprint_len;
+};
+
+/*
+ * Calculate the public key ID (RFC 9580 5.5.4)
+ */
+static int pgp_calc_pkey_keyid(struct shash_desc *digest,
+			       struct pgp_parse_pubkey *pgp,
+			       struct public_key *pub)
+{
+	unsigned int nb[MAX_MPI];
+	unsigned int nn[MAX_MPI];
+	unsigned int n;
+	size_t keylen = pub->keylen;
+	u8 *key_ptr = pub->key;
+	u8 *pp[MAX_MPI];
+	u32 a32;
+	int npkey = pgp_key_algo_p_num_mpi[pgp->pubkey_algo];
+	int i, ret;
+
+	kenter("");
+
+	n = 6;
+	for (i = 0; i < npkey; i++) {
+		if (keylen < 2)
+			break;
+
+		ret = mpi_key_length(key_ptr, keylen, nb + i, nn + i);
+		if (ret < 0)
+			return ret;
+
+		key_ptr += 2;
+		keylen -= 2;
+		n += 2;
+
+		if (keylen < nn[i])
+			break;
+
+		pp[i] = key_ptr;
+		key_ptr += nn[i];
+		keylen -= nn[i];
+		n += nn[i];
+	}
+
+	if (keylen != 0) {
+		pr_debug("excess %zu\n", keylen);
+		return -EBADMSG;
+	}
+
+	digest_putc(digest, 0x99);     /* ctb */
+	digest_putc(digest, n >> 8);   /* 16-bit header length */
+	digest_putc(digest, n);
+	digest_putc(digest, pgp->version);
+
+	a32 = pgp->creation_time;
+	digest_putc(digest, a32 >> 24);
+	digest_putc(digest, a32 >> 16);
+	digest_putc(digest, a32 >>  8);
+	digest_putc(digest, a32 >>  0);
+
+	digest_putc(digest, pgp->pubkey_algo);
+
+	for (i = 0; i < npkey; i++) {
+		digest_putc(digest, nb[i] >> 8);
+		digest_putc(digest, nb[i]);
+		crypto_shash_update(digest, pp[i], nn[i]);
+	}
+	ret = 0;
+
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Calculate the public key ID fingerprint
+ */
+static int pgp_generate_fingerprint(struct pgp_key_data_parse_context *ctx,
+				    struct pgp_parse_pubkey *pgp,
+				    struct public_key *pub)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *digest;
+	char fingerprint[HASH_MAX_DIGESTSIZE * 2 + 1] = { 0 };
+	size_t offset;
+	int ret;
+
+	ret = -ENOMEM;
+	tfm = crypto_alloc_shash("sha1", 0, 0);
+	if (IS_ERR(tfm))
+		goto cleanup;
+
+	digest = kmalloc(sizeof(*digest) + crypto_shash_descsize(tfm),
+			 GFP_KERNEL);
+	if (!digest)
+		goto cleanup_tfm;
+
+	digest->tfm = tfm;
+	crypto_shash_set_flags(digest->tfm, CRYPTO_TFM_REQ_MAY_SLEEP);
+	ret = crypto_shash_init(digest);
+	if (ret < 0)
+		goto cleanup_hash;
+
+	ret = pgp_calc_pkey_keyid(digest, pgp, pub);
+	if (ret < 0)
+		goto cleanup_hash;
+
+	ctx->raw_fingerprint_len = crypto_shash_digestsize(tfm);
+
+	ret = crypto_shash_final(digest, ctx->raw_fingerprint);
+	if (ret < 0)
+		goto cleanup_hash;
+
+	offset = ctx->raw_fingerprint_len - 8;
+	pr_debug("offset %zu/%zu\n", offset, ctx->raw_fingerprint_len);
+
+	bin2hex(fingerprint, ctx->raw_fingerprint, ctx->raw_fingerprint_len);
+	pr_debug("fingerprint %s\n", fingerprint);
+
+	ret = 0;
+cleanup_hash:
+	kfree(digest);
+cleanup_tfm:
+	crypto_free_shash(tfm);
+cleanup:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Extract a public key or public subkey from the PGP stream.
+ */
+static int pgp_process_public_key(struct pgp_parse_context *context,
+				  enum pgp_packet_tag type,
+				  u8 headerlen,
+				  const u8 *data,
+				  size_t datalen)
+{
+	const char *algo;
+	struct pgp_key_data_parse_context *ctx =
+		container_of(context, struct pgp_key_data_parse_context, pgp);
+	struct pgp_parse_pubkey pgp;
+	struct public_key *pub;
+	u8 capabilities;
+	int ret;
+
+	kenter(",%u,%u,,%zu", type, headerlen, datalen);
+
+	if (ctx->raw_fingerprint_len) {
+		kleave(" = -ENOKEY [already]");
+		return -EBADMSG;
+	}
+
+	pub = kzalloc(sizeof(*pub), GFP_KERNEL);
+	if (!pub)
+		return -ENOMEM;
+	pub->id_type = "PGP";
+
+	ret = pgp_parse_public_key(&data, &datalen, &pgp);
+	if (ret < 0)
+		goto cleanup;
+
+	if (pgp.pubkey_algo >= PGP_PUBKEY__LAST)
+		goto cleanup_unsupported_pkey_algo;
+	algo = pgp_to_public_key_algo[pgp.pubkey_algo];
+	if (!algo)
+		goto cleanup_unsupported_pkey_algo;
+
+	pub->pkey_algo = algo;
+
+	/*
+	 * It's the public half of a key, so that only gives us encrypt and
+	 * verify capabilities.
+	 */
+	capabilities = pgp_public_key_capabilities[pgp.pubkey_algo] &
+		       (KEYCTL_SUPPORTS_ENCRYPT | KEYCTL_SUPPORTS_VERIFY);
+	/*
+	 * Capabilities are not stored anymore in the public key, consider
+	 * only keys that allow signature verification.
+	 */
+	if (!(capabilities & KEYCTL_SUPPORTS_VERIFY))
+		goto cleanup_unsupported_pkey_algo;
+
+	pub->key_eflags |= 1 << KEY_EFLAG_DIGITALSIG;
+
+	pub->key = kmemdup(data, datalen, GFP_KERNEL);
+	if (!pub->key)
+		goto cleanup_nomem;
+
+	pub->keylen = datalen;
+
+	ret = pgp_generate_fingerprint(ctx, &pgp, pub);
+	if (ret < 0)
+		goto cleanup;
+
+	ctx->pub = pub;
+	kleave(" = 0 [use]");
+	return 0;
+
+cleanup_unsupported_pkey_algo:
+	pr_debug("Unsupported public key algorithm %u\n",
+		 pgp.pubkey_algo);
+	ret = -ENOPKG;
+	goto cleanup;
+cleanup_nomem:
+	ret = -ENOMEM;
+	goto cleanup;
+cleanup:
+	pr_devel("cleanup");
+	public_key_free(pub);
+	kleave(" = %d", ret);
+	return ret;
+}
+
+static struct asymmetric_key_ids *
+pgp_key_generate_id(struct pgp_key_data_parse_context *ctx)
+{
+	struct asymmetric_key_ids *kids;
+	struct asymmetric_key_id *kid;
+
+	kids = kzalloc(sizeof(*kids), GFP_KERNEL);
+	if (!kids)
+		return kids;
+
+	kid = asymmetric_key_generate_id(ctx->raw_fingerprint,
+					 ctx->raw_fingerprint_len, NULL, 0);
+	if (IS_ERR(kid))
+		goto error;
+
+	kids->id[0] = kid;
+	kids->id[1] = kmemdup(kid, sizeof(*kid) + ctx->raw_fingerprint_len,
+			      GFP_KERNEL);
+	if (!kids->id[1])
+		goto error;
+
+	return kids;
+error:
+	kfree(kids->id[0]);
+	kfree(kids);
+
+	return NULL;
+}
+
+/*
+ * Attempt to parse the instantiation data blob for a key as a PGP packet
+ * message holding a key.
+ */
+static int pgp_key_parse(struct key_preparsed_payload *prep)
+{
+	struct pgp_key_data_parse_context ctx;
+	int ret;
+
+	kenter("");
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.pgp.types_of_interest = (1 << PGP_PKT_PUBLIC_KEY);
+	ctx.pgp.process_packet = pgp_process_public_key;
+
+	ret = pgp_parse_packets(prep->data, prep->datalen, &ctx.pgp);
+	if (ret < 0)
+		goto error;
+
+	/* Key packet not found. */
+	if (!ctx.raw_fingerprint_len) {
+		ret = -ENOENT;
+		goto error;
+	}
+
+	/* We're pinning the module by being linked against it */
+	__module_get(public_key_subtype.owner);
+	prep->payload.data[asym_subtype] = &public_key_subtype;
+	prep->payload.data[asym_key_ids] = pgp_key_generate_id(&ctx);
+	prep->payload.data[asym_crypto] = ctx.pub;
+	prep->quotalen = 100;
+	return 0;
+
+error:
+	public_key_free(ctx.pub);
+	return ret;
+}
+
+static struct asymmetric_key_parser pgp_key_parser = {
+	.owner		= THIS_MODULE,
+	.name		= "pgp",
+	.parse		= pgp_key_parse,
+};
+
+/*
+ * Module stuff
+ */
+static int __init pgp_key_init(void)
+{
+	return register_asymmetric_key_parser(&pgp_key_parser);
+}
+
+static void __exit pgp_key_exit(void)
+{
+	unregister_asymmetric_key_parser(&pgp_key_parser);
+}
+
+module_init(pgp_key_init);
+module_exit(pgp_key_exit);
-- 
2.34.1


