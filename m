Return-Path: <linux-integrity+bounces-2523-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF68CB153
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF3D1F22982
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4677144D24;
	Tue, 21 May 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHD06VLf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC6144D1F;
	Tue, 21 May 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305257; cv=none; b=nxcHOgjphhqXVxv6kBoZufMEEhjf/xg3DRjf6Lhj9iWhlJ7zSBgrA5krXSZK7oiEdxsFv1p01euxmF9k0fxM0qN2v2ntFiIBxF6OOOcEU5nOPLjPmnhwxgrThCU2ahKfveVbenk8JHnIFYbOxgh+0ITDUHW/rk52SB+RHmEp+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305257; c=relaxed/simple;
	bh=al+MASLwWaoNpdR9/hmIEfK/e8a1ZqWmBh4Y1jAD2MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTKMflI8oCl8rK5gURuniGOc1cKOlLhVVqSFPjjOQIdlWyZUUp2nSWAXObZxdim4WyKm9NGOi8v+uB6DzHLb99QwZUF4FRbwfvmF7fMmbtu02AAyDRav175vT1D6bCM0qRFXjHSCuDFDaAsyPo6EhuwVs47OTj4fO/MI5KBX48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHD06VLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE5C2BD11;
	Tue, 21 May 2024 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716305257;
	bh=al+MASLwWaoNpdR9/hmIEfK/e8a1ZqWmBh4Y1jAD2MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHD06VLfU59sGZxAi/9PhjgNbGrjNVdB662CndrrRdO7H8xLcZwpvwFhpf9IwHWvi
	 27IhPSmJ9mKyPo2ZRZQ4/u/wtR+jPY+M771eAhzZ+YSMpSb/XDVqOHJS8/UPgb9aQc
	 nFzUAFFuEvZXGS3tyJx6mF6/x9TBuWPby/NXeI1Lw5ti04AkptQlNdxhd5aGemxhUQ
	 ylbo1NWUm66g9rUj50OjbHtOn6k0c1WJ3osph9rjcrwR/gNtupSK5bfSdRAVkJm9AA
	 bVT5SjL5UHnh8Apn+g7T4uS6Afu4fbRGQ4RdHBGjF1N8HeYnevtB2yXY6o9TjBvXH2
	 adWdsDxupnISw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list),
	David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 5/5] keys: asymmetric: ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
Date: Tue, 21 May 2024 18:26:47 +0300
Message-ID: <20240521152659.26438-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521152659.26438-1-jarkko@kernel.org>
References: <20240521152659.26438-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Prestwood <prestwoj@gmail.com>

Based on earlier work by James Prestwood.

Add ASN.1 compatible asymmetric TPM2 RSA key subtype:

1. Signing and decryption (with the private key) is handled by
   TPM2_RSA_Decrypt.
2. Encryption (with the public key) is handled by the kernel RSA
   implementation.

Link: https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/
Signed-off-by: James Prestwood <prestwoj@gmail.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
* Drop the special case for null handle i.e. do not define policy.
* Remove empty line:
  https://lore.kernel.org/linux-integrity/SN7PR18MB531494159D3996799475209DE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com/
v2:
* Remove two spurios pr_info() messsages that I forgot to remove.
* Clean up padding functions and add additional checks for length
  also in tpm2_unpad_pcks1().
* Add the missing success check kzalloc() in tpm2_key_rsa_decrypt().
* Check that params->out_len for capacity before copying the result.
---
 crypto/asymmetric_keys/Kconfig        |  16 +
 crypto/asymmetric_keys/Makefile       |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c | 688 ++++++++++++++++++++++++++
 include/linux/tpm.h                   |   2 +
 4 files changed, 707 insertions(+)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index e1345b8f39f1..4d14bb0c346e 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -15,6 +15,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select MPILIB
 	select CRYPTO_HASH_INFO
 	select CRYPTO_AKCIPHER
+	select CRYPTO_RSA
 	select CRYPTO_SIG
 	select CRYPTO_HASH
 	help
@@ -23,6 +24,21 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
+	tristate "Asymmetric TPM2 RSA crypto algorithm subtype"
+	depends on TCG_TPM
+	select TCG_TPM2_HMAC
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
+	select ASN1
+	select ASN1_ENCODER
+	help
+	  This option provides support for asymmetric TPM2 key type handling.
+	  If signature generation and/or verification are to be used,
+	  appropriate hash algorithms (such as SHA-256) must be available.
+	  ENOPKG will be reported if the requisite algorithm is unavailable.
+
 config X509_CERTIFICATE_PARSER
 	tristate "X.509 certificate parser"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98dcb..c6da84607824 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE) += tpm2_key_rsa.o
 
 #
 # X.509 Certificate handling
diff --git a/crypto/asymmetric_keys/tpm2_key_rsa.c b/crypto/asymmetric_keys/tpm2_key_rsa.c
new file mode 100644
index 000000000000..ecdfa169f406
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm2_key_rsa.c
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* TPM2 asymmetric public-key crypto subtype
+ *
+ * See Documentation/crypto/asymmetric-keys.rst
+ *
+ * Copyright (c) 2020 Intel Corporation
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/akcipher.h>
+#include <crypto/public_key.h>
+#include <crypto/rsa-pkcs1pad.h>
+#include <crypto/tpm2_key.h>
+#include <keys/asymmetric-parser.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/trusted-type.h>
+#include <linux/asn1_encoder.h>
+#include <linux/keyctl.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/tpm.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "tpm2_key_rsa: "fmt
+
+#define PUB_KEY_BUF_SIZE 512
+
+struct tpm2_key_rsa {
+	struct tpm2_key key;
+	const u8 *pub;
+	int pub_len;
+};
+
+static const int PKCS1_PAD_MIN_SIZE = 11;
+
+/*
+ * Fill the data with PKCS#1 v1.5 padding.
+ */
+static int tpm2_pad_pkcs1(const u8 *in, int in_len, u8 *out, int out_len)
+{
+	unsigned int prefix_len = out_len - in_len - 3;
+
+	if (in_len > out_len - PKCS1_PAD_MIN_SIZE)
+		return -EBADMSG;
+
+	/* prefix */
+	out[0] = 0;
+	out[1] = 1;
+	memset(&out[2], 0xff, prefix_len);
+	out[2 + prefix_len] = 0;
+	/* payload */
+	memcpy(&out[2 + prefix_len + 1], in, in_len);
+
+	return 0;
+}
+
+/*
+ * RFC 3447 - Section 7.2.2
+ * Size of the input data should be checked against public key size by
+ * the caller.
+ */
+static const u8 *tpm2_unpad_pkcs1(const u8 *in, int in_len, int *out_len)
+{
+	int i;
+
+	if (in[0] != 0 || in[1] != 2)
+		return NULL;
+
+	i = 2;
+	while (in[i] != 0 && i < in_len)
+		i++;
+
+	if (i == in_len || i < (PKCS1_PAD_MIN_SIZE - 1))
+		return NULL;
+
+	*out_len = in_len - i - 1;
+	return in + i + 1;
+}
+
+/*
+ * Outputs the cipher algorithm name on success, and retuns -ENOPKG
+ * on failure.
+ */
+static int tpm2_key_get_akcipher(const char *encoding, const char *hash_algo,
+				 char *cipher)
+{
+	ssize_t ret;
+
+	if (strcmp(encoding, "pkcs1") == 0) {
+		if (!hash_algo) {
+			strcpy(cipher, "pkcs1pad(rsa)");
+			return 0;
+		}
+
+		ret = snprintf(cipher, CRYPTO_MAX_ALG_NAME,
+			       "pkcs1pad(rsa,%s)",
+			       hash_algo);
+		if (ret >= CRYPTO_MAX_ALG_NAME)
+			return -ENOPKG;
+
+		return 0;
+	}
+
+	if (strcmp(encoding, "raw") == 0) {
+		strcpy(cipher, "rsa");
+		return 0;
+	}
+
+	return -ENOPKG;
+}
+
+static int tpm2_key_rsa_extract_pub(struct tpm2_key_rsa *key_rsa)
+{
+	struct tpm2_key *key = &key_rsa->key;
+	struct tpm_buf buf;
+	off_t offset = 2;
+	u16 policy_len;
+	u32 attr;
+	u16 bits;
+	u16 type;
+	u16 len;
+	u16 alg;
+	u32 exp;
+
+	buf.flags = TPM_BUF_TPM2B;
+	buf.length = key->pub_len;
+	buf.data = (void *)key->pub;
+
+	if (get_unaligned_be16(key->pub) != buf.length - 2)
+		return -EINVAL;
+
+	type = tpm_buf_read_u16(&buf, &offset);
+	pr_debug("pub type: 0x%04x\n", type);
+	if (type != TPM_ALG_RSA)
+		return -EINVAL;
+
+	alg = tpm_buf_read_u16(&buf, &offset);
+	pr_debug("pub name alg: 0x%04x\n", alg);
+	attr = tpm_buf_read_u32(&buf, &offset);
+	pr_debug("pub attributes: 0x%08x\n", attr);
+	policy_len = tpm_buf_read_u16(&buf, &offset);
+	pr_debug("pub policy length: %u bytes\n", policy_len);
+	offset += policy_len;
+
+	alg = tpm_buf_read_u16(&buf, &offset);
+	pr_debug("pub symmetric: 0x%04x\n", alg);
+	if (alg != TPM_ALG_NULL)
+		return -EINVAL;
+
+	alg = tpm_buf_read_u16(&buf, &offset);
+	pr_debug("pub symmetric scheme: 0x%04x\n", alg);
+	if (alg != TPM_ALG_NULL)
+		return -EINVAL;
+
+	bits = tpm_buf_read_u16(&buf, &offset);
+	pr_debug("pub bits: %u\n", bits);
+
+	exp = tpm_buf_read_u32(&buf, &offset);
+	pr_debug("pub exponent: 0x%08x\n", exp);
+	if (exp != 0x00000000 && exp !=  0x00010001)
+		return -EINVAL;
+
+	len = tpm_buf_read_u16(&buf, &offset);
+	pr_debug("pub modulus: %u bytes\n", len);
+	key_rsa->pub = key->pub + offset;
+	key_rsa->pub_len = len;
+
+	return buf.flags & TPM_BUF_BOUNDARY_ERROR ? -EIO : 0;
+}
+
+static int tpm2_key_rsa_encode(const struct tpm2_key_rsa *key, u8 *buf)
+{
+	const int SCRATCH_SIZE = PAGE_SIZE;
+	const u8 exp[3] = {1, 0, 1};
+	u8 *scratch, *work, *work1, *end_work;
+	int pub_len = key->pub_len;
+	const u8 *pub = key->pub;
+	int ret;
+
+	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	if (!scratch)
+		return -ENOMEM;
+
+	work = scratch;
+	end_work = &scratch[SCRATCH_SIZE];
+
+	work = asn1_encode_integer(work, end_work, pub, pub_len);
+	if (IS_ERR(work)) {
+		ret = PTR_ERR(work);
+		goto err;
+	}
+
+	work = asn1_encode_integer(work, end_work, exp, 3);
+	if (IS_ERR(work)) {
+		ret = PTR_ERR(work);
+		goto err;
+	}
+
+	work1 = buf;
+	work1 = asn1_encode_sequence(work1, &work1[PUB_KEY_BUF_SIZE],
+				     scratch, work - scratch);
+	if (IS_ERR(work1)) {
+		ret = PTR_ERR(work1);
+		goto err;
+	}
+
+	memset(work1, 0, 8);
+
+	kfree(scratch);
+	return work1 - buf;
+
+err:
+	kfree(scratch);
+	return ret;
+}
+
+/*
+ * Encryption operation is performed with the public key.  Hence it is done
+ * in software
+ */
+static int tpm2_key_rsa_encrypt(struct tpm2_key_rsa *key,
+				struct kernel_pkey_params *params,
+				const void *in, void *out)
+{
+	char cipher[CRYPTO_MAX_ALG_NAME];
+	struct scatterlist in_sg, out_sg;
+	u8 enc_pub_key[PUB_KEY_BUF_SIZE];
+	struct akcipher_request *req;
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	int rc;
+
+	rc = tpm2_key_get_akcipher(params->encoding, params->hash_algo, cipher);
+	if (rc < 0)
+		return rc;
+
+	tfm = crypto_alloc_akcipher(cipher, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = tpm2_key_rsa_encode(key, enc_pub_key);
+	if (rc < 0)
+		goto err_tfm;
+
+	rc = crypto_akcipher_set_pub_key(tfm, enc_pub_key, rc);
+	if (rc < 0)
+		goto err_tfm;
+
+	req = akcipher_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		rc = -ENOMEM;
+		goto err_tfm;
+	}
+
+	sg_init_one(&in_sg, in, params->in_len);
+	sg_init_one(&out_sg, out, params->out_len);
+	akcipher_request_set_crypt(req, &in_sg, &out_sg, params->in_len,
+				   params->out_len);
+
+	crypto_init_wait(&cwait);
+	akcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &cwait);
+
+	rc = crypto_akcipher_encrypt(req);
+	rc = crypto_wait_req(rc, &cwait);
+	if (!rc)
+		rc = req->dst_len;
+
+	akcipher_request_free(req);
+
+err_tfm:
+	crypto_free_akcipher(tfm);
+
+	return rc;
+}
+
+static int __tpm2_key_rsa_decrypt(struct tpm_chip *chip,
+				  struct tpm2_key_rsa *key,
+				  struct kernel_pkey_params *params,
+				  const void *in, int in_len, void *out)
+{
+	unsigned int offset = 0;
+	u32 key_handle = 0;
+	struct tpm_buf buf;
+	u16 decrypted_len;
+	u32 parent;
+	u8 *pos;
+	int ret;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm2_start_auth_session(chip);
+	if (ret)
+		goto err_ops;
+
+	parent = key->key.parent;
+
+	ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (ret < 0)
+		goto err_parent;
+
+	tpm_buf_append_name(chip, &buf, parent, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_CONTINUE_SESSION |
+				    TPM2_SA_ENCRYPT, NULL, 0);
+	tpm_buf_append(&buf, key->key.blob, key->key.blob_len);
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		ret = -E2BIG;
+		goto err_buf;
+	}
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "RSA key loading");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_buf;
+	}
+	key_handle = be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE]);
+
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_RSA_DECRYPT);
+	tpm_buf_append_name(chip, &buf, key_handle, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT, NULL, 0);
+	tpm_buf_append_u16(&buf, in_len);
+	tpm_buf_append(&buf, in, in_len);
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "RSA key decrypting");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_blob;
+	}
+
+	pos = buf.data + TPM_HEADER_SIZE + 4;
+	decrypted_len = be16_to_cpup((__be16 *)pos);
+	pos += 2;
+
+	if (params->out_len < decrypted_len) {
+		ret = -EMSGSIZE;
+		goto err_blob;
+	}
+
+	memcpy(out, pos, decrypted_len);
+	ret = decrypted_len;
+
+err_blob:
+	tpm2_flush_context(chip, key_handle);
+
+err_buf:
+	tpm_buf_destroy(&buf);
+
+err_parent:
+	if (key->key.parent == TPM2_RH_NULL)
+		tpm2_flush_context(chip, parent);
+
+err_auth:
+	if (ret < 0)
+		tpm2_end_auth_session(chip);
+
+err_ops:
+	tpm_put_ops(chip);
+	return ret;
+}
+
+static int tpm2_key_rsa_decrypt(struct tpm_chip *chip, struct tpm2_key_rsa *key,
+				struct kernel_pkey_params *params,
+				const void *in, void *out)
+{
+	const u8 *ptr;
+	int out_len;
+	u8 *work;
+	int ret;
+
+	work = kzalloc(params->out_len, GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	ret = __tpm2_key_rsa_decrypt(chip, key, params, in, params->in_len,
+				     work);
+	if (ret < 0)
+		goto err;
+
+	ptr = tpm2_unpad_pkcs1(work, ret, &out_len);
+	if (!ptr) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (out_len > params->out_len) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	memcpy(out, ptr, out_len);
+	kfree(work);
+	return out_len;
+
+err:
+	kfree(work);
+	return ret;
+}
+
+/*
+ * Sign operation is an encryption using the TPM's private key. With RSA the
+ * only difference between encryption and decryption is where the padding goes.
+ * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed to do
+ * encryption.
+ */
+static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key_rsa *key,
+			     struct kernel_pkey_params *params,
+			     const void *in, void *out)
+{
+	const struct rsa_asn1_template *asn1;
+	u32 in_len = params->in_len;
+	void *asn1_wrapped = NULL;
+	int pub_len = key->pub_len;
+	u8 *padded;
+	int ret;
+
+	if (strcmp(params->encoding, "pkcs1") != 0) {
+		ret = -ENOPKG;
+		goto err;
+	}
+
+	if (params->hash_algo) {
+		asn1 = rsa_lookup_asn1(params->hash_algo);
+		if (!asn1) {
+			ret = -ENOPKG;
+			goto err;
+		}
+
+		/* Request enough space for the ASN.1 template + input hash */
+		asn1_wrapped = kzalloc(in_len + asn1->size, GFP_KERNEL);
+		if (!asn1_wrapped) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		/* Copy ASN.1 template, then the input */
+		memcpy(asn1_wrapped, asn1->data, asn1->size);
+		memcpy(asn1_wrapped + asn1->size, in, in_len);
+
+		in = asn1_wrapped;
+		in_len += asn1->size;
+	}
+
+	/* with padding: */
+	padded = kmalloc(pub_len, GFP_KERNEL);
+	tpm2_pad_pkcs1(in, in_len, padded, pub_len);
+	ret = __tpm2_key_rsa_decrypt(chip, key, params, padded, pub_len, out);
+	kfree(padded);
+
+err:
+	kfree(asn1_wrapped);
+	return ret;
+}
+
+static void tpm2_key_rsa_describe(const struct key *asymmetric_key,
+				  struct seq_file *m)
+{
+	struct tpm2_key_rsa *key = asymmetric_key->payload.data[asym_crypto];
+
+	if (!key) {
+		pr_err("key blob missing");
+		return;
+	}
+
+	seq_puts(m, "TPM2/RSA");
+}
+
+static void tpm2_key_rsa_destroy(void *payload0, void *payload3)
+{
+	struct tpm2_key *key = payload0;
+
+	if (!key)
+		return;
+
+	tpm2_key_destroy(key);
+	kfree(key);
+}
+
+static int tpm2_key_rsa_eds_op(struct kernel_pkey_params *params,
+			       const void *in, void *out)
+{
+	struct tpm2_key_rsa *key = params->key->payload.data[asym_crypto];
+	struct tpm_chip *chip = tpm_default_chip();
+
+	if (!chip)
+		return -ENODEV;
+
+	switch (params->op) {
+	case kernel_pkey_encrypt:
+		return tpm2_key_rsa_encrypt(key, params, in, out);
+	case kernel_pkey_decrypt:
+		return tpm2_key_rsa_decrypt(chip, key, params, in, out);
+	case kernel_pkey_sign:
+		return tpm2_key_rsa_sign(chip, key, params, in, out);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tpm2_key_rsa_verify(const struct key *key,
+			       const struct public_key_signature *sig)
+{
+	const struct tpm2_key_rsa *tpm2_key = key->payload.data[asym_crypto];
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	u8 enc_pub_key[PUB_KEY_BUF_SIZE];
+	struct akcipher_request *req;
+	struct scatterlist src_sg[2];
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	int rc;
+
+	if (!sig->digest)
+		return -ENOPKG;
+
+	rc = tpm2_key_get_akcipher(sig->encoding, sig->hash_algo, alg_name);
+	if (rc < 0)
+		return rc;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = tpm2_key_rsa_encode(tpm2_key, enc_pub_key);
+	if (rc < 0)
+		goto err_tfm;
+
+	rc = crypto_akcipher_set_pub_key(tfm, enc_pub_key, rc);
+	if (rc < 0)
+		goto err_tfm;
+
+	rc = -ENOMEM;
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
+	rc = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
+
+	akcipher_request_free(req);
+
+err_tfm:
+	crypto_free_akcipher(tfm);
+	return rc;
+}
+
+static int tpm2_key_rsa_query(const struct kernel_pkey_params *params,
+			      struct kernel_pkey_query *info)
+{
+	struct tpm2_key_rsa *tk = params->key->payload.data[asym_crypto];
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	u8 enc_pub_key[PUB_KEY_BUF_SIZE];
+	struct crypto_akcipher *tfm;
+	unsigned int len;
+	int ret;
+
+	ret = tpm2_key_get_akcipher(params->encoding, params->hash_algo, alg_name);
+	if (ret < 0)
+		return ret;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ret = tpm2_key_rsa_encode(tk, enc_pub_key);
+	if (ret < 0)
+		goto err_tfm;
+
+	ret = crypto_akcipher_set_pub_key(tfm, enc_pub_key, ret);
+	if (ret < 0)
+		goto err_tfm;
+
+	len = crypto_akcipher_maxsize(tfm);
+
+	info->key_size = tk->pub_len * 8;
+	info->max_data_size = tk->pub_len;
+	info->max_sig_size = len;
+	info->max_enc_size = len;
+	info->max_dec_size = tk->pub_len;
+
+	info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT |
+			      KEYCTL_SUPPORTS_DECRYPT |
+			      KEYCTL_SUPPORTS_VERIFY |
+			      KEYCTL_SUPPORTS_SIGN;
+
+err_tfm:
+	crypto_free_akcipher(tfm);
+	return ret;
+}
+
+/*
+ * Asymmetric TPM2 RSA key. Signs and decrypts with TPM.
+ */
+struct asymmetric_key_subtype tpm2_key_rsa_subtype = {
+	.owner			= THIS_MODULE,
+	.name			= "tpm2_key_rsa",
+	.name_len		= sizeof("tpm2_key_rsa") - 1,
+	.describe		= tpm2_key_rsa_describe,
+	.destroy		= tpm2_key_rsa_destroy,
+	.query			= tpm2_key_rsa_query,
+	.eds_op			= tpm2_key_rsa_eds_op,
+	.verify_signature	= tpm2_key_rsa_verify,
+};
+EXPORT_SYMBOL_GPL(tpm2_key_rsa_subtype);
+
+/*
+ * Attempt to parse a data blob for a key as a TPM private key blob.
+ */
+static int tpm2_key_preparse(struct key_preparsed_payload *prep)
+{
+	struct tpm2_key_rsa *key;
+	int ret;
+
+	key = kzalloc(sizeof(*key), GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	/*
+	 * TPM 2.0 RSA keys are recommended to be 2048 bits long. Assume the
+	 * blob is no more than 4x that.
+	 */
+	if (prep->datalen > 256 * 4) {
+		kfree(key);
+		return -EMSGSIZE;
+	}
+
+	ret = tpm2_key_decode(prep->data, prep->datalen, &key->key, PAGE_SIZE);
+	if (ret) {
+		kfree(key);
+		return ret;
+	}
+
+	if (key->key.oid != OID_TPMLoadableKey) {
+		tpm2_key_destroy(&key->key);
+		kfree(key);
+		return -EINVAL;
+	}
+
+	ret = tpm2_key_rsa_extract_pub(key);
+	if (ret < 0) {
+		tpm2_key_destroy(&key->key);
+		kfree(key);
+		return ret;
+	}
+
+	prep->payload.data[asym_subtype] = &tpm2_key_rsa_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = key;
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+	return 0;
+}
+
+static struct asymmetric_key_parser tpm2_key_rsa_parser = {
+	.owner	= THIS_MODULE,
+	.name	= "tpm2_key_rsa_parser",
+	.parse	= tpm2_key_preparse,
+};
+
+static int __init tpm2_key_rsa_init(void)
+{
+	return register_asymmetric_key_parser(&tpm2_key_rsa_parser);
+}
+
+static void __exit tpm2_key_rsa_exit(void)
+{
+	unregister_asymmetric_key_parser(&tpm2_key_rsa_parser);
+}
+
+module_init(tpm2_key_rsa_init);
+module_exit(tpm2_key_rsa_exit);
+
+MODULE_DESCRIPTION("Asymmetric TPM2 RSA key");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index c17e4efbb2e5..040be2c75868 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -43,6 +43,7 @@ enum tpm2_session_types {
 /* if you add a new hash to this, increment TPM_MAX_HASHES below */
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_RSA		= 0x0001,
 	TPM_ALG_SHA1		= 0x0004,
 	TPM_ALG_AES		= 0x0006,
 	TPM_ALG_KEYEDHASH	= 0x0008,
@@ -271,6 +272,7 @@ enum tpm2_command_codes {
 	TPM2_CC_NV_READ                 = 0x014E,
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
+	TPM2_CC_RSA_DECRYPT	        = 0x0159,
 	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
 	TPM2_CC_UNSEAL		        = 0x015E,
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
-- 
2.45.1


