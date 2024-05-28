Return-Path: <linux-integrity+bounces-2674-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03BE8D1317
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 05:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56128284719
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA97481DB;
	Tue, 28 May 2024 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB20Hgfq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140D481A3;
	Tue, 28 May 2024 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868344; cv=none; b=l59n6fYe8CzYmye3AavbTAiCe0Kzw8kohU/g1/SliTTSW1NHKc122PgfJtPHufsQJLZcSH1DBvzSYzpXN/Khn2wW/cg6QqNWQmPMkLdEX92fFWeeCFksGQSUzmdM4lNYu8o/ZDNYkPsqwBBIqfDWVFPv4cRiWRv9AoeK8+tT/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868344; c=relaxed/simple;
	bh=v9MeUiUS8Q/VuRxCC2YKx8zhemgKA48t6o1IF1bDbl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOSsW6s4t/p/i0JsRQKJrJAY5JIKOC7JtwsXPfUy4RtRxiEZfbtCbEopDEGUNdT3hI5HETXZArp8CmEaBQxfb9Kkdg/MFbZTUEk2LWHK/L+yJxttHFbU/H8w5pjld6Icrgaq529uQmnJiOyM+IarxYsCrRy/4rCkKN0ndWfOvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB20Hgfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42D4C3277B;
	Tue, 28 May 2024 03:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716868344;
	bh=v9MeUiUS8Q/VuRxCC2YKx8zhemgKA48t6o1IF1bDbl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kB20HgfqIdxr8FnPHpdOq7kp5ptxOQks+jQLKLVV4HQuLseViQGgK+5uI0XP2l1DC
	 uPkWS1AEzhNcQ6cCbeRMICjk1Jtxv6W5jhsoZSC9FZv2UILW0KscsyJ9avpVovWhJN
	 4Hiki8Qb8jyo8B+bY8FsdNfSKe3xMDejnpWyRhJ30wS4M49bpfTms5Kh3ZrvFT0iss
	 LQgMQZH9jxA255/p+svA8VxjMndHlk6Usf0r48dRJYkRFyuwoJf+6LvNjD9bYjNQ2w
	 pr4Arjdd4dz4roiVu+311c/eaogmfMkx+7h6o+N1N9tBr1IZDF1WCHPo7RCT553aF1
	 yxfyQ1pAhRljQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list),
	David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 6/6] keys: asymmetric: Add tpm2_key_ecdsa
Date: Tue, 28 May 2024 06:51:21 +0300
Message-ID: <20240528035136.11464-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528035136.11464-1-jarkko@kernel.org>
References: <20240528035136.11464-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Asymmetric TPM2 ECDSA key with signing and verification.
* Enabled with CONFIG_ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE.

Cc: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v6:
* Very first version.
* Stefan: any idea why the signature give -EKEYREJECTED?
---
 crypto/asymmetric_keys/Kconfig          |  15 +
 crypto/asymmetric_keys/Makefile         |   1 +
 crypto/asymmetric_keys/tpm2_key_ecdsa.c | 441 ++++++++++++++++++++++++
 crypto/ecdsa.c                          |   1 -
 include/linux/tpm.h                     |   6 +
 5 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_ecdsa.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 9d88c1190621..c97f11e0340c 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -24,6 +24,21 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE
+	tristate "Asymmetric TPM2 ECDSA crypto algorithm subtype"
+	depends on TCG_TPM
+	select CRYPTO_ECDSA
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
+	select CRYPTO_TPM2_KEY
+	select ASN1
+	select ASN1_ENCODER
+	help
+	  This option provides support for asymmetric TPM2 key type handling.
+	  If signature generation and/or verification are to be used,
+	  appropriate hash algorithms (such as SHA-256) must be available.
+	  ENOPKG will be reported if the requisite algorithm is unavailable.
+
 config ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
 	tristate "Asymmetric TPM2 RSA crypto algorithm subtype"
 	depends on TCG_TPM
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index c6da84607824..0843d2268a69 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE) += tpm2_key_ecdsa.o
 obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE) += tpm2_key_rsa.o
 
 #
diff --git a/crypto/asymmetric_keys/tpm2_key_ecdsa.c b/crypto/asymmetric_keys/tpm2_key_ecdsa.c
new file mode 100644
index 000000000000..ad99984440fd
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm2_key_ecdsa.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Asymmetric TPM2 ECDSA key subtype.
+ *
+ * See Documentation/crypto/asymmetric-keys.rst
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/internal/ecc.h>
+#include <crypto/akcipher.h>
+#include <crypto/sha2.h>
+#include <crypto/public_key.h>
+#include <crypto/tpm2_key.h>
+#include <keys/asymmetric-parser.h>
+#include <keys/asymmetric-subtype.h>
+#include <linux/asn1_encoder.h>
+#include <linux/keyctl.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/tpm.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "tpm2_key_ecdsa: "fmt
+
+struct tpm2_ecc_parms {
+	__be16 symmetric;
+	__be16 scheme;
+	__be16 ecc;
+	__be16 kdf;
+};
+
+static const u8 *tpm2_key_ecdsa_ecc_x(const struct tpm2_key *key)
+{
+	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
+
+	return &key->data[o + sizeof(struct tpm2_ecc_parms)];
+}
+
+static const u8 *tpm2_key_ecdsa_ecc_y(const struct tpm2_key *key)
+{
+	const u8 *x = tpm2_key_ecdsa_ecc_x(key);
+	u16 x_size = get_unaligned_be16(&x[0]);
+
+	/* +2 from the size field: */
+	return &x[2 + x_size];
+}
+
+static void tpm2_key_ecdsa_describe(const struct key *asymmetric_key,
+				    struct seq_file *m)
+{
+	struct tpm2_key *key = asymmetric_key->payload.data[asym_crypto];
+
+	if (!key) {
+		pr_err("key missing");
+		return;
+	}
+
+	seq_puts(m, "TPM2/ECDSA");
+}
+
+static void tpm2_key_ecdsa_destroy(void *payload0, void *payload3)
+{
+	struct tpm2_key *key = payload0;
+
+	if (!key)
+		return;
+
+	kfree(key);
+}
+
+static const char *tpm2_ecc_name(u16 ecc)
+{
+	const char *name;
+
+	switch (ecc) {
+	case TPM2_ECC_NIST_P521:
+		name = "ecdsa-nist-p521";
+		break;
+	case TPM2_ECC_NIST_P384:
+		name = "ecdsa-nist-p384";
+		break;
+	default:
+		name = "ecdsa-nist-p256";
+		break;
+	}
+
+	return name;
+}
+
+static int tpm2_key_ecdsa_query(const struct kernel_pkey_params *params,
+				struct kernel_pkey_query *info)
+{
+	const struct tpm2_key *key = params->key->payload.data[asym_crypto];
+	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
+	const struct tpm2_ecc_parms *p =
+		(const struct tpm2_ecc_parms *)&key->data[o];
+	u16 ecc = be16_to_cpu(p->ecc);
+	const char *ecc_name = tpm2_ecc_name(ecc);
+	const u8 *x = tpm2_key_ecdsa_ecc_x(key);
+	u16 x_size = get_unaligned_be16(&x[0]);
+	struct crypto_akcipher *tfm;
+	char data[256];
+	u8 *ptr;
+	int ret;
+
+	memset(data, 0, sizeof(data));
+
+	tfm = crypto_alloc_akcipher(ecc_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	/* Probe for ecdsa_set_pub_key(): */
+	ptr = &data[0];
+	*ptr++ = 0x04; /* uncompressed */
+	memcpy(&ptr[0], &x[2], x_size);
+	memcpy(&ptr[x_size], &x[2 + x_size + 2], x_size);
+	ret = crypto_akcipher_set_pub_key(tfm, data, 2 * x_size + 1);
+	crypto_free_akcipher(tfm);
+	if (ret < 0)
+		return ret;
+
+	info->max_sig_size = 256;
+	info->key_size = 256;
+	info->max_data_size = 256;
+	info->supported_ops = KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS_VERIFY;
+	return ret;
+}
+
+static int tpm2_key_ecdsa_sign(struct tpm_chip *chip, struct tpm2_key *key,
+			       struct kernel_pkey_params *params,
+			       const void *in, void *out)
+{
+	off_t offset = sizeof(struct tpm_header) + 4;
+	u16 hash_algo = TPM_ALG_SHA256;
+	u8 digest[SHA256_DIGEST_SIZE];
+	u32 in_len = params->in_len;
+	struct tpm_buf buf;
+	u16 digest_size;
+	u32 key_handle;
+	u8 *ptr = out;
+	u16 sig_algo;
+	int ret;
+
+	/* Require explicit hash algorithm: */
+	if (!params->hash_algo)
+		return -EINVAL;
+
+	/* Currently only support SHA256: */
+	if (!!strcmp(params->hash_algo, "sha256"))
+		return -EINVAL;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm2_start_auth_session(chip);
+	if (ret)
+		goto err_ops;
+
+	ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (ret < 0) {
+		tpm2_end_auth_session(chip);
+		goto err_ops;
+	}
+
+	tpm_buf_append_name(chip, &buf, key->parent, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_CONTINUE_SESSION |
+				    TPM2_SA_ENCRYPT, NULL, 0);
+	tpm_buf_append(&buf, &key->data[0], key->priv_len + key->pub_len);
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		tpm2_end_auth_session(chip);
+		ret = -E2BIG;
+		goto err_buf;
+	}
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "ECDSA loading");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		tpm2_end_auth_session(chip);
+		ret = -EIO;
+		goto err_buf;
+	}
+
+	key_handle = be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE]);
+
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_SIGN);
+	tpm_buf_append_name(chip, &buf, key_handle, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT, NULL, 0);
+
+	sha256(in, in_len, digest);
+	tpm_buf_append_u16(&buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(&buf, digest, SHA256_DIGEST_SIZE);
+	tpm_buf_append_u16(&buf, TPM_ALG_ECDSA);
+	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
+
+	/* 10.7.2 A NULL Ticket */
+	tpm_buf_append_u16(&buf, TPM2_ST_HASHCHECK);
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	tpm_buf_append_u16(&buf, 0);
+
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "ECDSA signing");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		tpm2_end_auth_session(chip);
+		ret = -EIO;
+		goto err_blob;
+	}
+
+	ret = -EIO;
+	sig_algo = tpm_buf_read_u16(&buf, &offset);
+	if (sig_algo != TPM_ALG_ECDSA)
+		goto err_blob;
+
+	hash_algo = tpm_buf_read_u16(&buf, &offset);
+	if (hash_algo != TPM_ALG_SHA256)
+		goto err_blob;
+
+	digest_size = tpm_buf_read_u16(&buf, &offset);
+	if (digest_size != SHA256_DIGEST_SIZE)
+		goto err_blob;
+
+	/* SEQUENCE */
+	*ptr++ = 0x30;
+	*ptr++ = 2 * (2 + SHA256_DIGEST_SIZE);
+	/* INTEGER */
+	*ptr++ = 0x02;
+	*ptr++ = SHA256_DIGEST_SIZE;
+	memcpy(ptr, &buf.data[offset], SHA256_DIGEST_SIZE);
+	offset += SHA256_DIGEST_SIZE;
+	ptr += SHA256_DIGEST_SIZE;
+
+	digest_size = tpm_buf_read_u16(&buf, &offset);
+	if (digest_size != SHA256_DIGEST_SIZE)
+		goto err_blob;
+
+	/* INTEGER */
+	*ptr++ = 0x02;
+	*ptr++ = SHA256_DIGEST_SIZE;
+	memcpy(ptr, &buf.data[offset], SHA256_DIGEST_SIZE);
+	offset += SHA256_DIGEST_SIZE;
+	ptr += SHA256_DIGEST_SIZE;
+
+	ret = (void *)ptr - out;
+	pr_info("ret=%d\n", ret);
+
+err_blob:
+	tpm2_flush_context(chip, key_handle);
+
+err_buf:
+	tpm_buf_destroy(&buf);
+
+err_ops:
+	tpm_put_ops(chip);
+	return ret;
+}
+
+static int tpm2_key_ecdsa_eds_op(struct kernel_pkey_params *params,
+				 const void *in, void *out)
+{
+	struct tpm2_key *key = params->key->payload.data[asym_crypto];
+	struct tpm_chip *chip = tpm_default_chip();
+
+	if (!chip)
+		return -ENODEV;
+
+	switch (params->op) {
+	case kernel_pkey_sign:
+		return tpm2_key_ecdsa_sign(chip, key, params, in, out);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tpm2_key_ecdsa_verify_signature(const struct key *key,
+					   const struct public_key_signature *sig)
+{
+	const struct tpm2_key *tpm2_key = key->payload.data[asym_crypto];
+	const off_t o = tpm2_key->priv_len + 2 + sizeof(*tpm2_key->desc);
+	const struct tpm2_ecc_parms *p =
+		(const struct tpm2_ecc_parms *)&tpm2_key->data[o];
+	u16 ecc = be16_to_cpu(p->ecc);
+	const char *ecc_name = tpm2_ecc_name(ecc);
+	const u8 *x = tpm2_key_ecdsa_ecc_x(tpm2_key);
+	u16 x_size = get_unaligned_be16(&x[0]);
+	struct akcipher_request *req;
+	struct scatterlist src_sg[2];
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	char data[256];
+	u8 *ptr;
+	int ret;
+
+	memset(data, 0, sizeof(data));
+
+	tfm = crypto_alloc_akcipher(ecc_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	/* Probe for ecdsa_set_pub_key(): */
+	ptr = &data[0];
+	*ptr++ = 0x04; /* uncompressed */
+	memcpy(&ptr[0], &x[2], x_size);
+	memcpy(&ptr[x_size], &x[2 + x_size + 2], x_size);
+	ret = crypto_akcipher_set_pub_key(tfm, data, 2 * x_size + 1);
+	if (ret)
+		goto err_tfm;
+
+	ret = -ENOMEM;
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto err_tfm;
+
+	sg_init_table(src_sg, 2);
+	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
+	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
+	akcipher_request_set_crypt(req, src_sg, NULL, sig->s_size,
+				   sig->digest_size);
+	crypto_init_wait(&cwait);
+	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
+	akcipher_request_free(req);
+
+err_tfm:
+	crypto_free_akcipher(tfm);
+	return ret;
+}
+
+/*
+ * Asymmetric TPM2 ECDSA key. Signs and decrypts with TPM.
+ */
+struct asymmetric_key_subtype tpm2_key_ecdsa_subtype = {
+	.owner			= THIS_MODULE,
+	.name			= "tpm2_key_ecdsa",
+	.name_len		= sizeof("tpm2_key_ecdsa") - 1,
+	.describe		= tpm2_key_ecdsa_describe,
+	.destroy		= tpm2_key_ecdsa_destroy,
+	.query			= tpm2_key_ecdsa_query,
+	.eds_op			= tpm2_key_ecdsa_eds_op,
+	.verify_signature	= tpm2_key_ecdsa_verify_signature,
+};
+EXPORT_SYMBOL_GPL(tpm2_key_ecdsa_subtype);
+
+static int __tpm2_key_ecdsa_preparse(struct tpm2_key *key)
+{
+	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
+	const struct tpm2_ecc_parms *p =
+		(const struct tpm2_ecc_parms *)&key->data[o];
+	u16 x_size, y_size;
+	const u8 *x, *y;
+
+	if (tpm2_key_type(key) != TPM_ALG_ECC)
+		return -EBADMSG;
+
+	if (tpm2_key_policy_size(key) != 0)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->symmetric) != TPM_ALG_NULL)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->scheme) != TPM_ALG_NULL)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->ecc) != TPM2_ECC_NIST_P256 &&
+	    be16_to_cpu(p->ecc) != TPM2_ECC_NIST_P384 &&
+	    be16_to_cpu(p->ecc) != TPM2_ECC_NIST_P521)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->kdf) != TPM_ALG_NULL)
+		return -EBADMSG;
+
+	x = tpm2_key_ecdsa_ecc_x(key);
+	x_size = get_unaligned_be16(&x[0]);
+	if (x_size > ECC_MAX_BYTES)
+		return -EBADMSG;
+
+	y = tpm2_key_ecdsa_ecc_y(key);
+	y_size = get_unaligned_be16(&y[0]);
+	if (y_size > ECC_MAX_BYTES)
+		return -EBADMSG;
+
+	if (x_size != y_size)
+		return -EBADMSG;
+
+	return 0;
+}
+
+/*
+ * Attempt to parse a data blob for a key as a TPM private key blob.
+ */
+static int tpm2_key_ecdsa_preparse(struct key_preparsed_payload *prep)
+{
+	struct tpm2_key *key;
+	int ret;
+
+	key = tpm2_key_decode(prep->data, prep->datalen);
+	if (IS_ERR(key))
+		return ret;
+
+	if (key->oid != OID_TPMLoadableKey) {
+		kfree(key);
+		return -EBADMSG;
+	}
+
+	ret = __tpm2_key_ecdsa_preparse(key);
+	if (ret < 0) {
+		kfree(key);
+		return ret;
+	}
+
+	prep->payload.data[asym_subtype] = &tpm2_key_ecdsa_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = key;
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+	return 0;
+}
+
+static struct asymmetric_key_parser tpm2_key_ecdsa_parser = {
+	.owner	= THIS_MODULE,
+	.name	= "tpm2_key_ecdsa_parser",
+	.parse	= tpm2_key_ecdsa_preparse,
+};
+
+static int __init tpm2_key_ecdsa_init(void)
+{
+	return register_asymmetric_key_parser(&tpm2_key_ecdsa_parser);
+}
+
+static void __exit tpm2_key_ecdsa_exit(void)
+{
+	unregister_asymmetric_key_parser(&tpm2_key_ecdsa_parser);
+}
+
+module_init(tpm2_key_ecdsa_init);
+module_exit(tpm2_key_ecdsa_exit);
+
+MODULE_DESCRIPTION("Asymmetric TPM2 ECDSA key");
+MODULE_LICENSE("GPL");
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 258fffbf623d..cf7d630c6593 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -236,7 +236,6 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	if (d[0] != 4)
 		return -EINVAL;
 
-	keylen--;
 	digitlen = keylen >> 1;
 
 	ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index a4be7a852bde..b70ba5962102 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -45,6 +45,7 @@ enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
 	TPM_ALG_RSA		= 0x0001,
 	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_HMAC		= 0x0004,
 	TPM_ALG_AES		= 0x0006,
 	TPM_ALG_KEYEDHASH	= 0x0008,
 	TPM_ALG_SHA256		= 0x000B,
@@ -52,6 +53,7 @@ enum tpm_algorithms {
 	TPM_ALG_SHA512		= 0x000D,
 	TPM_ALG_NULL		= 0x0010,
 	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_ECDSA		= 0x0018,
 	TPM_ALG_ECC		= 0x0023,
 	TPM_ALG_CFB		= 0x0043,
 };
@@ -65,6 +67,8 @@ enum tpm_algorithms {
 enum tpm2_curves {
 	TPM2_ECC_NONE		= 0x0000,
 	TPM2_ECC_NIST_P256	= 0x0003,
+	TPM2_ECC_NIST_P384	= 0x0004,
+	TPM2_ECC_NIST_P521	= 0x0005,
 };
 
 struct tpm_digest {
@@ -239,6 +243,7 @@ enum tpm2_structures {
 	TPM2_ST_NO_SESSIONS	= 0x8001,
 	TPM2_ST_SESSIONS	= 0x8002,
 	TPM2_ST_CREATION	= 0x8021,
+	TPM2_ST_HASHCHECK	= 0x8024,
 };
 
 /* Indicates from what layer of the software stack the error comes from */
@@ -274,6 +279,7 @@ enum tpm2_command_codes {
 	TPM2_CC_LOAD		        = 0x0157,
 	TPM2_CC_RSA_DECRYPT	        = 0x0159,
 	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
+	TPM2_CC_SIGN			= 0x015D,
 	TPM2_CC_UNSEAL		        = 0x015E,
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
-- 
2.45.1


