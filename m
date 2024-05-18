Return-Path: <linux-integrity+bounces-2457-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB878C9292
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 23:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CDEB2102C
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D26EB5C;
	Sat, 18 May 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtIFinNO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19606CDA3;
	Sat, 18 May 2024 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716068266; cv=none; b=LwJCdOlNDWAljq8X8txpcKouK7DPOFsZyzEvTniotGxm4S/hFeh3DOm10nBrMYf9WrnQoYRvMUjpROkTTg9Yy2UgHf7KUKX/OpX/b/aQOdfbcyOqpGe4awZV19I+HeWoldgf/Ufs6y/jg2vJPP9kYoGiXweAxRxUxlDzPkI0eFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716068266; c=relaxed/simple;
	bh=R2SZeE+P5GdD5yWwmn4/xrJZ3ND6iUZHLjBTx0bcb6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZycYMy3OsVwy1BNXoh6i3BPu+pmOjWho1eS+3MDZp/6sDL9m0kiXkxciehZ8OupSmHiXXKWfsN5aoAsysewiVnwtO3jCuDaIEafwKzL9BSBXGS5tyqs86ZBn3Xe5/YMndmMCjfbBGRtWi2kSYw1UuBaHMCXaquIiCsD9ghl5hHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtIFinNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D42AC113CC;
	Sat, 18 May 2024 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716068266;
	bh=R2SZeE+P5GdD5yWwmn4/xrJZ3ND6iUZHLjBTx0bcb6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtIFinNOX0kCH+VULG9GRBPKgigsAsbX8OhqUdD6kFj+HtAxWi7c1Fg43+LpZuY7h
	 BZJNyzgUweifFVBmXtcUsRPUfSFix7dDa5EkmIJ0/jD4+44m8PAwkYc66HYK1Laecr
	 2r52U2OEFnmwJapxTqUVVj5Im6gFOqGXaLg0BQc+EOinOUIspQHgz2Ff22dx+7vFNu
	 StsmUIlj2ksuR+FY3csvZtD9abCQV1YB/BJvtBrhh2OaAg5OJkLq0p+emwgiZ5GW5W
	 jHbfIftJEh/Xk1WpWxpoUJijMMXroj/JkCNrRgkZ++WpXvgnCCsFV2TZB+m2R2yrAB
	 WKuTnpIkmLokA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 5/5] keys: asymmetric: ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
Date: Sun, 19 May 2024 00:36:25 +0300
Message-ID: <20240518213700.5960-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240518213700.5960-1-jarkko@kernel.org>
References: <20240518213700.5960-1-jarkko@kernel.org>
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

1. Signing and decryption (with the private key) is handled by TPM2_RSA_Decrypt.
2. Encryption (with the public key) is handled by the kernel RSA
   implementation.

Link: https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/
Signed-off-by: James Prestwood <prestwoj@gmail.com>
Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/asymmetric_keys/Kconfig        |  12 +
 crypto/asymmetric_keys/Makefile       |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c | 648 ++++++++++++++++++++++++++
 drivers/char/tpm/tpm2_key.c           |  11 +
 include/crypto/tpm2_key.h             |   3 +
 include/linux/tpm.h                   |   1 +
 6 files changed, 676 insertions(+)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index e1345b8f39f1..0ccbc0e80aa2 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -23,6 +23,18 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
+	tristate "Asymmetric TPM2 RSA crypto algorithm subtype"
+	depends on TCG_TPM && TCG_TPM2_HAMC
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
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
index bc65d3b98dcb..f9730b39f008 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_SUBTYPE) += tpm2_key_rsa.o
 
 #
 # X.509 Certificate handling
diff --git a/crypto/asymmetric_keys/tpm2_key_rsa.c b/crypto/asymmetric_keys/tpm2_key_rsa.c
new file mode 100644
index 000000000000..8f245dd1b8b0
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm2_key_rsa.c
@@ -0,0 +1,648 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* TPM2 asymmetric public-key crypto subtype
+ *
+ * See Documentation/crypto/asymmetric-keys.rst
+ *
+ * Copyright (c) 2020 Intel Corporation
+ */
+
+#define pr_fmt(fmt) "tpm2_key: "fmt
+
+#include <asm/unaligned.h>
+#include <crypto/akcipher.h>
+#include <crypto/public_key.h>
+#include <crypto/rsa-pkcs1pad.h>
+#include <crypto/tpm2_key.h>
+#include <keys/asymmetric-subtype.h>
+#include <linux/keyctl.h>
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/tpm.h>
+
+/* Room to fit two u32 zeros for algo id and parameters length. */
+#define SETKEY_PARAMS_SIZE (sizeof(u32) * 2)
+
+/*
+ * Maximum buffer size for the BER/DER encoded public key.  The public key
+ * is of the form SEQUENCE { INTEGER n, INTEGER e } where n is a maximum 2048
+ * bit key and e is usually 65537
+ * The encoding overhead is:
+ * - max 4 bytes for SEQUENCE
+ *   - max 4 bytes for INTEGER n type/length
+ *     - 257 bytes of n
+ *   - max 2 bytes for INTEGER e type/length
+ *     - 3 bytes of e
+ * - 4+4 of zeros for set_pub_key parameters (SETKEY_PARAMS_SIZE)
+ */
+#define PUB_KEY_BUF_SIZE (4 + 4 + 257 + 2 + 3 + SETKEY_PARAMS_SIZE)
+
+static int tpm2_rsa_decrypt(struct tpm_chip *chip, u32 parent,
+			    const unsigned char *keyblob, size_t bloblen,
+			    const void *data, size_t len, void *out)
+{
+	unsigned int private_len;
+	unsigned int public_len;
+	unsigned int parsed_len;
+	unsigned int offset = 0;
+	u32 blob_handle = 0;
+	u32 key_handle = 0;
+	struct tpm_buf buf;
+	u16 decrypted_len;
+	u8 *pos;
+	int ret;
+
+	private_len = be16_to_cpup((__be16 *)&keyblob[0]);
+	if (private_len > (bloblen - 2))
+		return -EINVAL;
+
+	public_len = be16_to_cpup((__be16 *)&keyblob[2 + private_len]);
+	parsed_len = private_len + public_len + 4;
+	if (parsed_len > bloblen)
+		return -EINVAL;
+
+	chip = tpm_find_get_ops(chip);
+	if (!chip)
+		return -ENODEV;
+
+	ret = tpm2_start_auth_session(chip);
+	if (ret)
+		goto err_ops;
+
+	if (parent == TPM2_RH_NULL) {
+		ret = tpm2_load_context(chip, chip->null_key_context, &offset,
+					&key_handle);
+		if (ret) {
+			ret = -EIO;
+			goto err_auth;
+		}
+	} else {
+		key_handle = parent;
+	}
+
+	ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (ret < 0)
+		goto err_key;
+
+	tpm_buf_append_name(chip, &buf, key_handle, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_CONTINUE_SESSION |
+				    TPM2_SA_ENCRYPT, NULL, 0);
+	tpm_buf_append(&buf, keyblob, bloblen);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		ret = -E2BIG;
+		goto err_buf;
+	}
+
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_buf;
+	}
+
+	blob_handle = be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE]);
+
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_RSA_DECRYPT);
+
+	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT, NULL, 0);
+
+	tpm_buf_append_u16(&buf, len);
+	tpm_buf_append(&buf, data, len);
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+	tpm_buf_append_u16(&buf, 0);
+
+	tpm_buf_fill_hmac_session(chip, &buf);
+	ret = tpm_transmit_cmd(chip, &buf, 4, "decrypting RSA");
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
+	memcpy(out, pos, decrypted_len);
+	ret = decrypted_len;
+
+err_blob:
+	tpm2_flush_context(chip, blob_handle);
+
+err_buf:
+	tpm_buf_destroy(&buf);
+
+err_key:
+	tpm2_flush_context(chip, key_handle);
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
+/*
+ * PKCS1 padding (type 1)
+ */
+static int __maybe_unused tpm2_pad_pkcs1(const u8 *m, unsigned int mlen,
+					 u8 *em, unsigned int em_len)
+{
+	unsigned int ps_len = em_len - mlen - 3;
+
+	if (mlen > em_len - 11)
+		return -EBADMSG;
+
+	em[0] = 0;
+	em[1] = 1;
+
+	memset(em + 2, 0xff, ps_len);
+
+	em[2 + ps_len] = 0;
+	memcpy(em + 2 + ps_len + 1, m, mlen);
+
+	return 0;
+}
+
+/*
+ * RFC 3447 - Section 7.2.2
+ */
+static const u8 *tpm2_unpad_pkcs1(const u8 *data, unsigned int len,
+				  unsigned int *out_len)
+{
+	unsigned int i;
+
+	/*
+	 * Size of input data should be checked against public key size by
+	 * caller.
+	 */
+	if (data[0] != 0 || data[1] != 2)
+		return NULL;
+
+	i = 2;
+
+	while (data[i] != 0 && i < len)
+		i++;
+
+	if (i == len)
+		return NULL;
+
+	*out_len = len - i - 1;
+
+	return data + i + 1;
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
+			strscpy(cipher, "pkcs1pad(rsa)");
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
+		strscpy(cipher, "rsa");
+		return 0;
+	}
+
+	return -ENOPKG;
+}
+
+static inline u8 *tpm2_key_append_tag(u8 *buf, u8 tag, u32 len)
+{
+	*buf++ = tag;
+
+	if (len <= 127) {
+		buf[0] = len;
+		return buf + 1;
+	}
+
+	if (len <= 255) {
+		buf[0] = 0x81;
+		buf[1] = len;
+		return buf + 2;
+	}
+
+	buf[0] = 0x82;
+	put_unaligned_be16(len, buf + 1);
+	return buf + 3;
+}
+
+static inline u32 tpm2_key_definite_length(u32 len)
+{
+	if (len <= 127)
+		return 1;
+	if (len <= 255)
+		return 2;
+	return 3;
+}
+
+static u32 tpm2_key_to_der(const void *pub_key, u32 len, u8 *buf)
+{
+	u8 *cur = buf;
+	u32 n_len = tpm2_key_definite_length(len) + 1 + len + 1;
+	u32 e_len = tpm2_key_definite_length(3) + 1 + 3;
+	u8 e[3] = { 0x01, 0x00, 0x01 };
+
+	/* SEQUENCE */
+	cur = tpm2_key_append_tag(cur, 0x30, n_len + e_len);
+	/* INTEGER n */
+	cur = tpm2_key_append_tag(cur, 0x02, len + 1);
+	cur[0] = 0x00;
+	memcpy(cur + 1, pub_key, len);
+	cur += len + 1;
+	cur = tpm2_key_append_tag(cur, 0x02, sizeof(e));
+	memcpy(cur, e, sizeof(e));
+	cur += sizeof(e);
+	/* Zero parameters to satisfy set_pub_key ABI. */
+	memset(cur, 0, SETKEY_PARAMS_SIZE);
+
+	return cur - buf;
+}
+
+/*
+ * Encryption operation is performed with the public key.  Hence it is done
+ * in software
+ */
+static int tpm2_key_rsa_encrypt(struct tpm2_key *key,
+				struct kernel_pkey_params *params,
+				const void *in, void *out)
+{
+	char cipher[CRYPTO_MAX_ALG_NAME];
+	struct scatterlist in_sg, out_sg;
+	u8 der_pub_key[PUB_KEY_BUF_SIZE];
+	struct akcipher_request *req;
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	u32 der_pub_key_len;
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
+	der_pub_key_len = tpm2_key_to_der(key->pub, key->pub_len, der_pub_key);
+
+	rc = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
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
+
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
+/*
+ * Decryption operation is performed with the private key in the TPM.
+ */
+static int tpm2_key_rsa_decrypt(struct tpm_chip *chip, struct tpm2_key *key,
+				size_t in_len, const void *in, void *out)
+{
+	unsigned int unpadded_len;
+	const u8 *unpadded;
+	u8 *decrypted;
+	int rc;
+
+	decrypted = kmalloc(key->pub_len, GFP_KERNEL);
+
+	rc = tpm2_rsa_decrypt(chip, key->parent, key->blob, key->blob_len, in,
+			      in_len, decrypted);
+	if (rc < 0)
+		return rc;
+
+	unpadded = tpm2_unpad_pkcs1(decrypted, rc, &unpadded_len);
+	if (!unpadded)
+		return -EINVAL;
+
+	memcpy(out, unpadded, unpadded_len);
+	return unpadded_len;
+}
+
+/*
+ * Sign operation is an encryption using the TPM's private key. With RSA the
+ * only difference between encryption and decryption is where the padding goes.
+ * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed to do
+ * encryption.
+ */
+static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key *key,
+			     struct kernel_pkey_params *params,
+			     const void *in, void *out)
+{
+	const struct rsa_asn1_template *asn1;
+	u32 in_len = params->in_len;
+	void *asn1_wrapped = NULL;
+	u8 *padded;
+	int rc;
+
+	if (strcmp(params->encoding, "pkcs1")) {
+		rc = -ENOPKG;
+		goto done;
+	}
+
+	if (params->hash_algo) {
+		asn1 = rsa_lookup_asn1(params->hash_algo);
+		if (!asn1) {
+			rc = -ENOPKG;
+			goto done;
+		}
+
+		/* Request enough space for the ASN.1 template + input hash */
+		asn1_wrapped = kzalloc(in_len + asn1->size, GFP_KERNEL);
+		if (!asn1_wrapped) {
+			rc = -ENOMEM;
+			goto done;
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
+	/*
+	 * Using the TPM's decrypt call to sign (aka encrypt). This
+	 * requires pre-padding the data with PKCS1.
+	 */
+	padded = kmalloc(key->pub_len, GFP_KERNEL);
+	tpm2_pad_pkcs1(in, in_len, padded, key->pub_len);
+
+	rc = tpm2_rsa_decrypt(chip, key->parent, key->blob, key->blob_len,
+			      padded, key->pub_len, out);
+
+	kfree(padded);
+done:
+	kfree(asn1_wrapped);
+	return rc;
+}
+
+static void tpm2_key_rsa_describe(const struct key *asymmetric_key,
+				  struct seq_file *m)
+{
+	struct tpm2_key *key = asymmetric_key->payload.data[asym_crypto];
+
+	if (!key) {
+		pr_err("key is empty");
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
+}
+
+static int tpm2_key_rsa_eds_op(struct kernel_pkey_params *params,
+			       const void *in, void *out)
+{
+	struct tpm2_key *tk = params->key->payload.data[asym_crypto];
+	struct tpm_chip *chip = tpm_default_chip();
+	int rc = -EOPNOTSUPP;
+
+	if (!chip)
+		return -ENODEV;
+
+	switch (params->op) {
+	case kernel_pkey_encrypt:
+		rc = tpm2_key_encrypt(tk, params, in, out);
+		break;
+	case kernel_pkey_decrypt:
+		rc = tpm2_key_decrypt(tk, chip, params, in, out);
+		break;
+	case kernel_pkey_sign:
+		rc = tpm2_key_sign(tk, chip, params, in, out);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
+static int tpm2_key_rsa_verify(const struct key *key,
+			       const struct public_key_signature *sig)
+{
+	const struct tpm2_key *tk = key->payload.data[asym_crypto];
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	u8 der_pub_key[PUB_KEY_BUF_SIZE];
+	struct akcipher_request *req;
+	struct scatterlist src_sg[2];
+	struct crypto_akcipher *tfm;
+	struct crypto_wait cwait;
+	u32 der_pub_key_len;
+	int rc;
+
+	if (WARN_ON(!tk || !sig || !sig->s))
+		return -EINVAL;
+
+	if (!sig->digest)
+		return -ENOPKG;
+
+	rc = determine_akcipher(sig->encoding, sig->hash_algo, alg_name);
+	if (rc < 0)
+		return rc;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	der_pub_key_len = derive_pub_key(tk->pub, tk->pub_len,
+					 der_pub_key);
+
+	rc = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
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
+err_tfm:
+	crypto_free_akcipher(tfm);
+	pr_devel("<=%s() = %d\n", __func__, rc);
+	if (WARN_ON_ONCE(rc > 0))
+		rc = -EINVAL;
+	return rc;
+}
+
+static int tpm2_key_query(const struct kernel_pkey_params *params,
+			  struct kernel_pkey_query *info)
+{
+	struct tpm2_key *tk = params->key->payload.data[asym_crypto];
+	char alg_name[CRYPTO_MAX_ALG_NAME];
+	u8 der_pub_key[PUB_KEY_BUF_SIZE];
+	struct crypto_akcipher *tfm;
+	u32 der_pub_key_len = 0;
+	unsigned int len;
+	int ret;
+
+	ret = determine_akcipher(params->encoding, params->hash_algo, alg_name);
+	if (ret < 0)
+		return ret;
+
+	tfm = crypto_alloc_akcipher(alg_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	der_pub_key_len = derive_pub_key(tk->pub, tk->pub_len,
+					 der_pub_key);
+
+	ret = crypto_akcipher_set_pub_key(tfm, der_pub_key, der_pub_key_len);
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
+	struct tpm2_key key;
+	int ret;
+
+	memset(&key, 0, sizeof(key));
+
+	/*
+	 * TPM 2.0 RSA keys are recommended to be 2048 bits long. Assume the
+	 * blob is no more than 4x that.
+	 */
+	if (prep->datalen > 256 * 4)
+		return -EMSGSIZE;
+
+	ret = tpm2_key_decode(prep->data, prep->data_len, &key, MAX_BLOB_SIZE);
+	if (ret)
+		return ret;
+
+	prep->payload.data[asym_subtype] = &tpm2_key_rsa_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = tk;
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+
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
+	return register_asymmetric_key_parser(&tpm2_key_parser);
+}
+
+static void __exit tpm2_key_rsa_exit(void)
+{
+	unregister_asymmetric_key_parser(&tpm2_key_parser);
+}
+
+module_init(tpm2_key_rsa_init);
+module_exit(tpm2_key_rsa_exit);
+
+MODULE_DESCRIPTION("Asymmetric TPM2 RSA key");
+MODULE_LICENSE("GPL");
diff --git a/drivers/char/tpm/tpm2_key.c b/drivers/char/tpm/tpm2_key.c
index e09441efb0f0..0d125b53de0e 100644
--- a/drivers/char/tpm/tpm2_key.c
+++ b/drivers/char/tpm/tpm2_key.c
@@ -175,6 +175,17 @@ int tpm2_key_decode(const u8 *src, u32 src_len, struct tpm2_key *key,
 		return -ENOMEM;
 	}
 
+	ctx.blob_len = ctx.priv_len + ctx.pub_len;
+	ctx.blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
+	if (!ctx.blob) {
+		kfree(ctx.pub);
+		kfree(ctx.priv);
+		return -ENOMEM;
+	}
+
+	memcpy((void *)ctx.blob, ctx.priv, ctx.priv_len);
+	memcpy((void *)ctx.blob + ctx.priv_len, ctx.pub, ctx.pub_len);
+
 	memcpy(key, &ctx, sizeof(ctx));
 	return 0;
 }
diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
index e5d3330afef5..7b5c5ec6bed5 100644
--- a/include/crypto/tpm2_key.h
+++ b/include/crypto/tpm2_key.h
@@ -13,6 +13,8 @@ struct tpm2_key {
 	u32 pub_len;
 	const u8 *priv;
 	u32 priv_len;
+	const u8 *blob;
+	u32 blob_len;
 };
 
 int tpm2_key_encode(u8 *blob, u32 blob_auth_len, u32 key_handle, u8 *src);
@@ -27,6 +29,7 @@ static inline void tpm2_key_destroy(struct tpm2_key *key)
 {
 	kfree(key->priv);
 	kfree(key->pub);
+	kfree(key->blob);
 	memset(key, 0, sizeof(*key));
 }
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 2f25ca07127b..238814ee5c6f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -271,6 +271,7 @@ enum tpm2_command_codes {
 	TPM2_CC_NV_READ                 = 0x014E,
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
+	TPM2_CC_RSA_DECRYPT	        = 0x0159,
 	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
 	TPM2_CC_UNSEAL		        = 0x015E,
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
-- 
2.45.1


