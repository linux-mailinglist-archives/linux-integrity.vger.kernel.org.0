Return-Path: <linux-integrity+bounces-9650-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z4sEL++JEmqW0gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9650-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:17:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09C5C16D2
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE431302F0DF
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 05:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3962E2D238F;
	Sun, 24 May 2026 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egjfQth6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7E2DE6FF;
	Sun, 24 May 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779599747; cv=none; b=bmf2eOfp0JnkhCytO84tZkmNAWdY73BcnFeXDg4mF289KQbQ85apbwlS3zsBcOEMTq6PL46BY9Z3TJwkqb3gADhFUp5t128oL2CsHDdJVwJ9N7MJ242r4wWJU97mIsSWwIOUnK/J67jrrQA1Kimy/fMIBEKJt7F5cyh9f8Dw9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779599747; c=relaxed/simple;
	bh=R1c57vlFHeOi/WKWb1B1eqZNdffnljRoiQiI1+U+QWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEzgygbi05+aexvWIDyEpzfV168uUzqiO6tmjVn55EyAs11kHtgpmryU8EWXMf9kBsAUPlOdwuJdICsQaksqtJZ64ec/VPCPhxJRDmDDS1iRHePMMpX4GRMqvTxZwX7yUy3TPwH79MButCSmnHfZdB+vufNVprLUYsiRxAbRF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egjfQth6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B1AC41F000E9;
	Sun, 24 May 2026 05:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779599744;
	bh=J/zLQARNj0oHRSp/EG/kgexamTHn/b9Eny6z5lqUYXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=egjfQth6kYquTaHRylcxgw3Upl1d0K1CDvi2hVq0a6l5jSYXxKvrtBhcCtcHwPhuQ
	 Z75nP4aSh6GhvxsDtbpHyAeT4H2xykPgy8O/KmHXasJDugMqAzH1xYpB5zhBWrPO0y
	 946MPp2A31gxtNPUf+PPHJYGFgbedQwjGi7YSoVI8QcNT+Vbwz6Jy0EZY+v3le30ES
	 aCfeI1e7W0boLM+9GoE/r1TsMhF7LhykNNLOmVBiiAQq2r7YpxgDmaQt4o3KUV32rh
	 objfz+GlPz9s01Z9U5jE0uzGejt70XIh76zjIXoDbSbXkeH9uBEMDqN9u6OdjcAmyA
	 SctaqBDF2MBng==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Prestwood <prestwoj@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v8 3/3] keys: asymmetric: tpm2_asymmetric
Date: Sun, 24 May 2026 08:15:14 +0300
Message-ID: <20260524051519.3708075-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524051519.3708075-1-jarkko@kernel.org>
References: <20260524051519.3708075-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,infradead.org,hansenpartnership.com,linux.ibm.com,gondor.apana.org.au,kernel.org,gmail.com,wunner.de,linux.win,davemloft.net,gmx.de,ziepe.ca,HansenPartnership.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9650-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F09C5C16D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tpm2_asymmetric is a key type for external keys generated outside the TPM
chip but later imported to the chip's key hierarchy as leaf keys.

The key type supports ECC-NIST-P256/384/521 and RSA keys and provides
signing and verification operations for each. In addition, for RSA
encryption and decryption operations are supported.

Co-developed-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/asymmetric_keys/Kconfig           |   17 +
 crypto/asymmetric_keys/Makefile          |    1 +
 crypto/asymmetric_keys/tpm2_asymmetric.c | 1096 ++++++++++++++++++++++
 include/linux/tpm.h                      |   10 +
 4 files changed, 1124 insertions(+)
 create mode 100644 crypto/asymmetric_keys/tpm2_asymmetric.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index e50bd9b3e27b..a93e13d5768f 100644
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
@@ -23,6 +24,22 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_TPM2_KEY_SUBTYPE
+	tristate "Asymmetric TPM2 crypto algorithm subtype"
+	depends on TCG_TPM
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
+	select CRYPTO_TPM2_KEY
+	select ASN1
+	select ASN1_ENCODER
+	help
+	  This option provides support for asymmetric TPM2 key type handling.
+	  Asymmetric operations such as sign and verify are delegated to the
+	  TPM, and bound to the kernel crypto subsystem. Both RSA and ECDSA
+	  keys are supported.
+
+	  ENOPKG will be reported if the requisite algorithm is unavailable.
+
 config X509_CERTIFICATE_PARSER
 	tristate "X.509 certificate parser"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98dcb..c83b40d021ac 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_SUBTYPE) += tpm2_asymmetric.o
 
 #
 # X.509 Certificate handling
diff --git a/crypto/asymmetric_keys/tpm2_asymmetric.c b/crypto/asymmetric_keys/tpm2_asymmetric.c
new file mode 100644
index 000000000000..f6598e6fd283
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm2_asymmetric.c
@@ -0,0 +1,1096 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * An asymmetric TPM2 key subtype.
+ */
+
+#include <crypto/hash_info.h>
+#include <crypto/internal/ecc.h>
+#include <crypto/public_key.h>
+#include <crypto/tpm2_key.h>
+#include <keys/asymmetric-parser.h>
+#include <keys/asymmetric-subtype.h>
+#include <linux/asn1_encoder.h>
+#include <linux/keyctl.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tpm.h>
+#include <linux/unaligned.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "tpm2_asymmetric: "fmt
+
+/* TPM2 Structures 12.2.3.5: TPMS_RSA_PARMS */
+struct tpm2_asymmetric_rsa_parms {
+	__be16 symmetric;
+	__be16 scheme;
+	__be16 key_bits;
+	__be32 exponent;
+	__be16 modulus_size;
+} __packed;
+
+/* TPM2 Structures 12.2.3.6: TPMS_ECC_PARMS */
+struct tpm2_asymmetric_ecc_parms {
+	__be16 symmetric;
+	__be16 scheme;
+	__be16 ecc;
+	__be16 kdf;
+};
+
+static const void *tpm2_asymmetric_parms(const struct tpm2_key *key)
+{
+	return &key->data[key->priv_len + 2 + sizeof(*key->desc)];
+}
+
+static u16 tpm2_asymmetric_rsa_mod_size(const struct tpm2_key *key)
+{
+	const struct tpm2_asymmetric_rsa_parms *p = tpm2_asymmetric_parms(key);
+
+	return be16_to_cpu(p->modulus_size);
+}
+
+static const u8 *tpm2_asymmetric_ecc_x(const struct tpm2_key *key)
+{
+	return tpm2_asymmetric_parms(key) + sizeof(struct tpm2_asymmetric_ecc_parms);
+}
+
+static const u8 *tpm2_asymmetric_ecc_y(const struct tpm2_key *key)
+{
+	const u8 *x = tpm2_asymmetric_ecc_x(key);
+	u16 x_size = get_unaligned_be16(&x[0]);
+
+	return &x[2 + x_size];
+}
+
+static unsigned int tpm2_asymmetric_ecc_key_bits(u16 ecc)
+{
+	switch (ecc) {
+	case TPM2_ECC_NIST_P256:
+		return 256;
+	case TPM2_ECC_NIST_P384:
+		return 384;
+	case TPM2_ECC_NIST_P521:
+		return 521;
+	default:
+		return 0;
+	}
+}
+
+static int tpm2_asymmetric_hash_lookup(const char *hash_algo,
+				       int *hash_id, int *tpm_hash)
+{
+	int id, alg;
+
+	if (!hash_algo)
+		return -EINVAL;
+
+	id = match_string(hash_algo_name, HASH_ALGO__LAST, hash_algo);
+	if (id < 0)
+		return -ENOPKG;
+
+	alg = tpm2_find_hash_alg(id);
+	if (alg < 0)
+		return -ENOPKG;
+
+	if (hash_id)
+		*hash_id = id;
+
+	if (tpm_hash)
+		*tpm_hash = alg;
+
+	return 0;
+}
+
+static int tpm2_asymmetric_signature_scheme(const struct tpm2_key *key,
+					    const char *encoding,
+					    const char *hash_algo,
+					    u16 *scheme,
+					    int *tpm_hash)
+{
+	if (!encoding)
+		return -ENOPKG;
+
+	switch (tpm2_key_type(key)) {
+	case TPM_ALG_RSA:
+		if (strcmp(encoding, "pkcs1") != 0)
+			return -ENOPKG;
+		*scheme = TPM_ALG_RSASSA;
+		break;
+	case TPM_ALG_ECC:
+		if (strcmp(encoding, "x962") != 0)
+			return -ENOPKG;
+		*scheme = TPM_ALG_ECDSA;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return tpm2_asymmetric_hash_lookup(hash_algo, NULL, tpm_hash);
+}
+
+/*
+ * Load a TPM2 key blob into the TPM.
+ *
+ * On success, @buf is initialized and the authorization session is kept open.
+ * On failure, @buf is destroyed and the authorization session is closed.
+ */
+static int tpm2_asymmetric_load(struct tpm_chip *chip, struct tpm2_key *key,
+				struct tpm_buf *buf, u32 *handle_out)
+{
+	int ret;
+
+	ret = tpm2_start_auth_session(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm_buf_init(buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (ret < 0)
+		goto err_auth;
+
+	ret = tpm_buf_append_name(chip, buf, key->parent, NULL);
+	if (ret)
+		goto err_buf;
+	tpm_buf_append_hmac_session(chip, buf, TPM2_SA_CONTINUE_SESSION |
+				    TPM2_SA_ENCRYPT, NULL, 0);
+	tpm_buf_append(buf, &key->data[0], key->priv_len + key->pub_len);
+	if (buf->flags & TPM_BUF_OVERFLOW) {
+		ret = -E2BIG;
+		goto err_buf;
+	}
+	ret = tpm_buf_fill_hmac_session(chip, buf);
+	if (ret)
+		goto err_buf;
+	ret = tpm_transmit_cmd(chip, buf, 4, "TPM2_CC_LOAD");
+	ret = tpm_buf_check_hmac_response(chip, buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_buf;
+	}
+
+	*handle_out = be32_to_cpup((__be32 *)&buf->data[TPM_HEADER_SIZE]);
+	return 0;
+
+err_buf:
+	tpm_buf_destroy(buf);
+
+err_auth:
+	tpm2_end_auth_session(chip);
+	return ret;
+}
+
+static void tpm2_asymmetric_key_destroy(void *payload0, void *payload3)
+{
+	kfree(payload0);
+}
+
+/*
+ * Encrypt using TPM2_RSA_Encrypt with RSAES (PKCS#1 v1.5) scheme.
+ */
+static int tpm2_asymmetric_rsa_encrypt(struct tpm_chip *chip,
+				       struct tpm2_key *key,
+				       struct kernel_pkey_params *params,
+				       const void *in, void *out)
+{
+	u32 key_handle = 0;
+	struct tpm_buf buf;
+	u16 ciphertext_len;
+	u16 scheme;
+	u8 *pos;
+	int ret;
+
+	if (!params->encoding)
+		return -EINVAL;
+
+	if (strcmp(params->encoding, "pkcs1") == 0)
+		scheme = TPM_ALG_RSAES;
+	else if (strcmp(params->encoding, "raw") == 0)
+		scheme = TPM_ALG_NULL;
+	else
+		return -ENOPKG;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm2_asymmetric_load(chip, key, &buf, &key_handle);
+	if (ret)
+		goto err_ops;
+
+	tpm2_end_auth_session(chip);
+	tpm_buf_destroy(&buf);
+
+	ret = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_RSA_ENCRYPT);
+	if (ret)
+		goto err_key;
+
+	tpm_buf_append_u32(&buf, key_handle);
+
+	tpm_buf_append_u16(&buf, params->in_len);
+	tpm_buf_append(&buf, in, params->in_len);
+
+	tpm_buf_append_u16(&buf, scheme);
+
+	tpm_buf_append_u16(&buf, 0);
+
+	ret = tpm_transmit_cmd(chip, &buf, 4, "TPM2_RSA_Encrypt");
+	if (ret) {
+		ret = -EIO;
+		goto err_buf;
+	}
+
+	pos = buf.data + TPM_HEADER_SIZE;
+	ciphertext_len = be16_to_cpup((__be16 *)pos);
+	pos += 2;
+	if (pos + ciphertext_len > buf.data + buf.length) {
+		ret = -EIO;
+		goto err_buf;
+	}
+
+	if (params->out_len < ciphertext_len) {
+		ret = -EMSGSIZE;
+		goto err_buf;
+	}
+
+	memcpy(out, pos, ciphertext_len);
+	ret = ciphertext_len;
+
+err_buf:
+	tpm_buf_destroy(&buf);
+
+err_key:
+	tpm2_flush_context(chip, key_handle);
+
+err_ops:
+	tpm_put_ops(chip);
+	return ret;
+}
+
+/*
+ * Convert a TPM2B_PUBLIC_KEY_RSA response into a raw RSA signature.
+ */
+static int tpm2_asymmetric_rsa_parse_signature(struct tpm_buf *buf,
+					       off_t *offset,
+					       struct kernel_pkey_params *params,
+					       void *out)
+{
+	u16 sig_len;
+
+	sig_len = tpm_buf_read_u16(buf, offset);
+	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+		return -EIO;
+	if (*offset + sig_len > buf->length)
+		return -EIO;
+	if (sig_len > params->out_len)
+		return -EMSGSIZE;
+
+	memcpy(out, &buf->data[*offset], sig_len);
+	return sig_len;
+}
+
+/*
+ * Convert a TPMT_SIGNATURE ECDSA R/S response into DER SEQUENCE form.
+ */
+static int tpm2_asymmetric_ecc_parse_signature(struct tpm_buf *buf, off_t *offset,
+					       struct kernel_pkey_params *params,
+					       void *out)
+{
+	u8 der[2 * (2 + ECC_MAX_BYTES + 1)];
+	u8 *encoded, *ptr;
+	const u8 *s;
+	u16 r_size;
+	u16 s_size;
+
+	r_size = tpm_buf_read_u16(buf, offset);
+	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+		return -EIO;
+	if (r_size == 0 || r_size > ECC_MAX_BYTES ||
+	    *offset + r_size + 2 > buf->length)
+		return -EIO;
+
+	s_size = get_unaligned_be16(&buf->data[*offset + r_size]);
+	s = &buf->data[*offset + r_size + 2];
+	if (s_size == 0 || s_size > ECC_MAX_BYTES ||
+	    *offset + r_size + 2 + s_size > buf->length)
+		return -EIO;
+
+	ptr = der;
+	ptr = asn1_encode_integer_bytes(ptr, der + sizeof(der),
+					&buf->data[*offset], r_size);
+	ptr = asn1_encode_integer_bytes(ptr, der + sizeof(der), s, s_size);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+
+	encoded = asn1_encode_sequence(out, (u8 *)out + params->out_len,
+				       der, ptr - der);
+	if (IS_ERR(encoded))
+		return PTR_ERR(encoded) == -EINVAL ? -EMSGSIZE : PTR_ERR(encoded);
+
+	return encoded - (u8 *)out;
+}
+
+static int tpm2_asymmetric_parse_signature(struct tpm_buf *buf,
+					   u16 scheme, int tpm_hash,
+					   struct kernel_pkey_params *params,
+					   void *out)
+{
+	off_t offset = TPM_HEADER_SIZE + 4;
+	u16 hash_alg;
+	u16 sig_alg;
+
+	sig_alg = tpm_buf_read_u16(buf, &offset);
+	hash_alg = tpm_buf_read_u16(buf, &offset);
+	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+		return -EIO;
+	if (sig_alg != scheme || hash_alg != tpm_hash)
+		return -EIO;
+
+	switch (scheme) {
+	case TPM_ALG_RSASSA:
+		return tpm2_asymmetric_rsa_parse_signature(buf, &offset, params, out);
+	case TPM_ALG_ECDSA:
+		return tpm2_asymmetric_ecc_parse_signature(buf, &offset, params, out);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/*
+ * Sign a digest using TPM2_Sign.
+ */
+static int tpm2_asymmetric_sign(struct tpm_chip *chip, struct tpm2_key *key,
+				struct kernel_pkey_params *params,
+				const void *in, void *out)
+{
+	struct tpm_buf buf;
+	u32 key_handle = 0;
+	int tpm_hash;
+	u16 scheme;
+	int ret;
+
+	ret = tpm2_asymmetric_signature_scheme(key, params->encoding,
+					       params->hash_algo, &scheme,
+					       &tpm_hash);
+	if (ret)
+		return ret;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm2_asymmetric_load(chip, key, &buf, &key_handle);
+	if (ret)
+		goto err_ops;
+
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_SIGN);
+	ret = tpm_buf_append_name(chip, &buf, key_handle, NULL);
+	if (ret)
+		goto err_key;
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT, NULL, 0);
+
+	/* digest (TPM2B_DIGEST) */
+	tpm_buf_append_u16(&buf, params->in_len);
+	tpm_buf_append(&buf, in, params->in_len);
+
+	/* inScheme (TPMT_SIG_SCHEME) */
+	tpm_buf_append_u16(&buf, scheme);
+	tpm_buf_append_u16(&buf, tpm_hash);
+
+	/* validation (TPMT_TK_HASHCHECK): NULL ticket */
+	tpm_buf_append_u16(&buf, TPM2_ST_HASHCHECK);
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	tpm_buf_append_u16(&buf, 0);
+
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		tpm2_end_auth_session(chip);
+		ret = -E2BIG;
+		goto err_key;
+	}
+	ret = tpm_buf_fill_hmac_session(chip, &buf);
+	if (ret)
+		goto err_key;
+	ret = tpm_transmit_cmd(chip, &buf, 4, "TPM2_Sign");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_key;
+	}
+
+	ret = tpm2_asymmetric_parse_signature(&buf, scheme, tpm_hash, params, out);
+
+err_key:
+	tpm2_flush_context(chip, key_handle);
+	tpm_buf_destroy(&buf);
+
+err_ops:
+	tpm_put_ops(chip);
+	return ret;
+}
+
+/*
+ * Decrypt using TPM2_RSA_Decrypt with RSAES-PKCS1-v1_5 scheme.
+ */
+static int tpm2_asymmetric_rsa_decrypt(struct tpm_chip *chip,
+				       struct tpm2_key *key,
+				       struct kernel_pkey_params *params,
+				       const void *in, void *out)
+{
+	u32 key_handle = 0;
+	struct tpm_buf buf;
+	u16 decrypted_len;
+	off_t offset;
+	int ret;
+
+	if (!params->encoding || strcmp(params->encoding, "pkcs1") != 0)
+		return -ENOPKG;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	ret = tpm2_asymmetric_load(chip, key, &buf, &key_handle);
+	if (ret)
+		goto err_ops;
+
+	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_RSA_DECRYPT);
+	ret = tpm_buf_append_name(chip, &buf, key_handle, NULL);
+	if (ret)
+		goto err_key;
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT, NULL, 0);
+	tpm_buf_append_u16(&buf, params->in_len);
+	tpm_buf_append(&buf, in, params->in_len);
+	tpm_buf_append_u16(&buf, TPM_ALG_RSAES);
+	tpm_buf_append_u16(&buf, 0);
+	if (buf.flags & TPM_BUF_OVERFLOW) {
+		tpm2_end_auth_session(chip);
+		ret = -E2BIG;
+		goto err_key;
+	}
+	ret = tpm_buf_fill_hmac_session(chip, &buf);
+	if (ret)
+		goto err_key;
+	ret = tpm_transmit_cmd(chip, &buf, 4, "TPM2_RSA_DECRYPT");
+	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
+	if (ret) {
+		ret = -EIO;
+		goto err_key;
+	}
+
+	offset = TPM_HEADER_SIZE + 4;
+	decrypted_len = tpm_buf_read_u16(&buf, &offset);
+	if (buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+		ret = -EIO;
+		goto err_key;
+	}
+	if (offset + decrypted_len > buf.length) {
+		ret = -EIO;
+		goto err_key;
+	}
+
+	if (params->out_len < decrypted_len) {
+		ret = -EMSGSIZE;
+		goto err_key;
+	}
+
+	memcpy(out, &buf.data[offset], decrypted_len);
+	ret = decrypted_len;
+
+err_key:
+	tpm2_flush_context(chip, key_handle);
+	tpm_buf_destroy(&buf);
+
+err_ops:
+	tpm_put_ops(chip);
+	return ret;
+}
+
+/*
+ * Verify an RSA signature using TPM2_VerifySignature with RSASSA scheme.
+ */
+static int tpm2_asymmetric_rsa_verify(const struct key *key,
+				      const struct public_key_signature *sig)
+{
+	struct tpm2_key *tpm2_key = key->payload.data[asym_crypto];
+	struct tpm_chip *chip;
+	struct tpm_buf buf;
+	u32 key_handle = 0;
+	int tpm_hash;
+	int ret;
+
+	if (!sig->m)
+		return -ENOPKG;
+
+	if (!sig->encoding || strcmp(sig->encoding, "pkcs1") != 0)
+		return -ENOPKG;
+
+	if (!sig->hash_algo)
+		return -EINVAL;
+
+	chip = tpm_default_chip();
+
+	if (!chip)
+		return -ENODEV;
+
+	ret = tpm2_asymmetric_hash_lookup(sig->hash_algo, NULL, &tpm_hash);
+	if (ret)
+		goto err_chip;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		goto err_chip;
+
+	ret = tpm2_asymmetric_load(chip, tpm2_key, &buf, &key_handle);
+	if (ret)
+		goto err_ops;
+
+	tpm2_end_auth_session(chip);
+	tpm_buf_destroy(&buf);
+
+	ret = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS,
+			   TPM2_CC_VERIFY_SIGNATURE);
+	if (ret)
+		goto err_key;
+
+	tpm_buf_append_u32(&buf, key_handle);
+
+	tpm_buf_append_u16(&buf, sig->m_size);
+	tpm_buf_append(&buf, sig->m, sig->m_size);
+
+	tpm_buf_append_u16(&buf, TPM_ALG_RSASSA);
+	tpm_buf_append_u16(&buf, tpm_hash);
+	tpm_buf_append_u16(&buf, sig->s_size);
+	tpm_buf_append(&buf, sig->s, sig->s_size);
+
+	ret = tpm_transmit_cmd(chip, &buf, 0, "TPM2_VerifySignature");
+	if (ret)
+		ret = -EKEYREJECTED;
+
+	tpm_buf_destroy(&buf);
+
+err_key:
+	tpm2_flush_context(chip, key_handle);
+
+err_ops:
+	tpm_put_ops(chip);
+
+err_chip:
+	put_device(&chip->dev);
+	return ret;
+}
+
+static int tpm2_asymmetric_rsa_query(const struct kernel_pkey_params *params,
+				     struct kernel_pkey_query *info)
+{
+	const struct tpm2_key *key = params->key->payload.data[asym_crypto];
+	u16 max_data_size = TPM2_MAX_DIGEST_SIZE;
+	const u16 mod_size = tpm2_asymmetric_rsa_mod_size(key);
+	int hash_id, ret;
+
+	if (!params->encoding)
+		return -EINVAL;
+
+	memset(info, 0, sizeof(*info));
+	info->key_size = mod_size * 8;
+
+	if (strcmp(params->encoding, "pkcs1") == 0) {
+		if (params->hash_algo) {
+			ret = tpm2_asymmetric_hash_lookup(params->hash_algo, &hash_id, NULL);
+			if (ret)
+				return ret;
+			max_data_size = hash_digest_size[hash_id];
+		}
+
+		info->max_data_size = max_data_size;
+		info->max_sig_size = mod_size;
+		info->max_enc_size = mod_size;
+		info->max_dec_size = mod_size;
+		info->supported_ops = KEYCTL_SUPPORTS_SIGN |
+				      KEYCTL_SUPPORTS_VERIFY |
+				      KEYCTL_SUPPORTS_ENCRYPT |
+				      KEYCTL_SUPPORTS_DECRYPT;
+		return 0;
+	}
+
+	if (strcmp(params->encoding, "raw") == 0) {
+		info->max_data_size = mod_size;
+		info->max_enc_size = mod_size;
+		info->max_dec_size = mod_size;
+		info->supported_ops = KEYCTL_SUPPORTS_ENCRYPT;
+		return 0;
+	}
+
+	return -ENOPKG;
+}
+
+static int tpm2_asymmetric_rsa_validate(const struct tpm2_key *key)
+{
+	const struct tpm2_asymmetric_rsa_parms *p = tpm2_asymmetric_parms(key);
+	u16 key_bits;
+	u16 mod_size;
+
+	if (tpm2_key_policy_size(key) != 0)
+		return -EBADMSG;
+
+	if (key->pub_len < 2 + sizeof(*key->desc) + sizeof(*p))
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->symmetric) != TPM_ALG_NULL)
+		return -EBADMSG;
+
+	if (be16_to_cpu(p->scheme) != TPM_ALG_NULL)
+		return -EBADMSG;
+
+	key_bits = be16_to_cpu(p->key_bits);
+	if (key_bits != 2048 && key_bits != 3072 && key_bits != 4096)
+		return -EBADMSG;
+
+	if (be32_to_cpu(p->exponent) != 0x00000000 &&
+	    be32_to_cpu(p->exponent) != 0x00010001)
+		return -EBADMSG;
+
+	mod_size = tpm2_asymmetric_rsa_mod_size(key);
+	if (mod_size != key_bits / 8)
+		return -EBADMSG;
+
+	if (key->pub_len < 2 + sizeof(*key->desc) + sizeof(*p) + mod_size)
+		return -EBADMSG;
+
+	return 0;
+}
+
+static unsigned int tpm2_asymmetric_der_len_size(unsigned int len)
+{
+	if (len < 128)
+		return 1;
+	if (len <= 255)
+		return 2;
+	return 3;
+}
+
+/*
+ * Parse a DER-encoded ECDSA signature: SEQUENCE { INTEGER r, INTEGER s }.
+ *
+ * On success, @r/@r_len and @s/@s_len point into @der with leading zero
+ * pads stripped.
+ */
+static int tpm2_asymmetric_ecc_parse_der_signature(const u8 *der, u32 der_len,
+						   const u8 **r, u16 *r_len,
+						   const u8 **s, u16 *s_len)
+{
+	const u8 *end = der + der_len;
+	u32 seq_len, int_len;
+	const u8 *p = der;
+
+	if (p >= end || *p++ != 0x30)
+		return -EBADMSG;
+
+	if (p >= end)
+		return -EBADMSG;
+	if (*p < 0x80) {
+		seq_len = *p++;
+	} else if (*p == 0x81) {
+		if (++p >= end)
+			return -EBADMSG;
+		seq_len = *p++;
+	} else {
+		return -EBADMSG;
+	}
+
+	if (p + seq_len > end)
+		return -EBADMSG;
+	end = p + seq_len;
+
+	/* INTEGER r */
+	if (p >= end || *p++ != 0x02)
+		return -EBADMSG;
+	if (p >= end)
+		return -EBADMSG;
+	int_len = *p++;
+	if (int_len == 0 || int_len >= 0x80 || p + int_len > end)
+		return -EBADMSG;
+	while (int_len > 1 && *p == 0x00) {
+		p++;
+		int_len--;
+	}
+	*r = p;
+	*r_len = int_len;
+	p += int_len;
+
+	/* INTEGER s */
+	if (p >= end || *p++ != 0x02)
+		return -EBADMSG;
+	if (p >= end)
+		return -EBADMSG;
+	int_len = *p++;
+	if (int_len == 0 || int_len >= 0x80 || p + int_len > end)
+		return -EBADMSG;
+	while (int_len > 1 && *p == 0x00) {
+		p++;
+		int_len--;
+	}
+	*s = p;
+	*s_len = int_len;
+	p += int_len;
+
+	if (p != end)
+		return -EBADMSG;
+
+	return 0;
+}
+
+/*
+ * Verify an ECDSA signature using TPM2_VerifySignature.
+ *
+ * A DER-encoded signature is parsed into (r, s) components for the TPM command.
+ */
+static int tpm2_asymmetric_ecc_verify(const struct key *key,
+				      const struct public_key_signature *sig)
+{
+	struct tpm2_key *tpm2_key = key->payload.data[asym_crypto];
+	struct tpm_chip *chip;
+	const u8 *r, *s_data;
+	struct tpm_buf buf;
+	u32 key_handle = 0;
+	u16 r_len, s_len;
+	int tpm_hash;
+	int ret;
+
+	if (!sig->m)
+		return -ENOPKG;
+
+	if (!sig->encoding || strcmp(sig->encoding, "x962") != 0)
+		return -ENOPKG;
+
+	if (!sig->hash_algo)
+		return -EINVAL;
+
+	chip = tpm_default_chip();
+
+	if (!chip)
+		return -ENODEV;
+
+	ret = tpm2_asymmetric_hash_lookup(sig->hash_algo, NULL, &tpm_hash);
+	if (ret)
+		goto err_chip;
+
+	ret = tpm2_asymmetric_ecc_parse_der_signature(sig->s, sig->s_size,
+						      &r, &r_len, &s_data,
+						      &s_len);
+	if (ret)
+		goto err_chip;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		goto err_chip;
+
+	ret = tpm2_asymmetric_load(chip, tpm2_key, &buf, &key_handle);
+	if (ret)
+		goto err_ops;
+
+	tpm2_end_auth_session(chip);
+	tpm_buf_destroy(&buf);
+
+	ret = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS,
+			   TPM2_CC_VERIFY_SIGNATURE);
+	if (ret)
+		goto err_key;
+
+	tpm_buf_append_u32(&buf, key_handle);
+
+	/* digest (TPM2B_DIGEST) */
+	tpm_buf_append_u16(&buf, sig->m_size);
+	tpm_buf_append(&buf, sig->m, sig->m_size);
+
+	/* signature (TPMT_SIGNATURE): ECDSA with the given hash */
+	tpm_buf_append_u16(&buf, TPM_ALG_ECDSA);
+	tpm_buf_append_u16(&buf, tpm_hash);
+
+	/* signatureR (TPM2B_ECC_PARAMETER) */
+	tpm_buf_append_u16(&buf, r_len);
+	tpm_buf_append(&buf, r, r_len);
+
+	/* signatureS (TPM2B_ECC_PARAMETER) */
+	tpm_buf_append_u16(&buf, s_len);
+	tpm_buf_append(&buf, s_data, s_len);
+
+	ret = tpm_transmit_cmd(chip, &buf, 0, "TPM2_VerifySignature");
+	if (ret)
+		ret = -EKEYREJECTED;
+
+	tpm_buf_destroy(&buf);
+
+err_key:
+	tpm2_flush_context(chip, key_handle);
+
+err_ops:
+	tpm_put_ops(chip);
+
+err_chip:
+	put_device(&chip->dev);
+	return ret;
+}
+
+static int tpm2_asymmetric_ecc_query(const struct kernel_pkey_params *params,
+				     struct kernel_pkey_query *info)
+{
+	const struct tpm2_key *key = params->key->payload.data[asym_crypto];
+	const struct tpm2_asymmetric_ecc_parms *p = tpm2_asymmetric_parms(key);
+	unsigned int int_len, seq_payload;
+	const u8 *x;
+	u16 ecc, n;
+	int ret;
+
+	ecc = be16_to_cpu(p->ecc);
+	x = tpm2_asymmetric_ecc_x(key);
+	n = get_unaligned_be16(&x[0]);
+	int_len = n + 1;
+
+	if (!params->encoding || strcmp(params->encoding, "x962") != 0)
+		return -ENOPKG;
+
+	ret = tpm2_asymmetric_hash_lookup(params->hash_algo, NULL, NULL);
+	if (ret)
+		return ret;
+
+	/*
+	 * SEQUENCE { INTEGER (<=n+1 bytes), INTEGER (<=n+1 bytes) }
+	 */
+	seq_payload = 2 * (1 + tpm2_asymmetric_der_len_size(int_len) + int_len);
+
+	memset(info, 0, sizeof(*info));
+	info->key_size = tpm2_asymmetric_ecc_key_bits(ecc);
+	info->max_sig_size = 1 + tpm2_asymmetric_der_len_size(seq_payload) + seq_payload;
+	info->max_data_size = TPM2_MAX_DIGEST_SIZE;
+	info->supported_ops = KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS_VERIFY;
+
+	return 0;
+}
+
+static int tpm2_asymmetric_ecc_validate(const struct tpm2_key *key)
+{
+	const struct tpm2_asymmetric_ecc_parms *p = tpm2_asymmetric_parms(key);
+	size_t min_len = 2 + sizeof(*key->desc) + sizeof(*p);
+	u16 x_size, y_size;
+	const u8 *x, *y;
+
+	if (tpm2_key_policy_size(key) != 0)
+		return -EBADMSG;
+
+	if (key->pub_len < min_len + 2)
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
+	x = tpm2_asymmetric_ecc_x(key);
+	x_size = get_unaligned_be16(&x[0]);
+	if (x_size > ECC_MAX_BYTES)
+		return -EBADMSG;
+
+	if (key->pub_len < min_len + 2 + x_size + 2)
+		return -EBADMSG;
+
+	y = tpm2_asymmetric_ecc_y(key);
+	y_size = get_unaligned_be16(&y[0]);
+	if (y_size > ECC_MAX_BYTES)
+		return -EBADMSG;
+
+	if (key->pub_len < min_len + 2 + x_size + 2 + y_size)
+		return -EBADMSG;
+
+	if (x_size != y_size)
+		return -EBADMSG;
+
+	return 0;
+}
+
+static const char *tpm2_asymmetric_ecc_name(const struct tpm2_key *key)
+{
+	const struct tpm2_asymmetric_ecc_parms *p;
+
+	p = tpm2_asymmetric_parms(key);
+
+	switch (be16_to_cpu(p->ecc)) {
+	case TPM2_ECC_NIST_P256:
+		return "ecdsa-nist-p256";
+	case TPM2_ECC_NIST_P384:
+		return "ecdsa-nist-p384";
+	case TPM2_ECC_NIST_P521:
+		return "ecdsa-nist-p521";
+	default:
+		return "ecdsa";
+	}
+}
+
+static void tpm2_asymmetric_describe(const struct key *asymmetric_key,
+				     struct seq_file *m)
+{
+	const struct tpm2_key *key;
+
+	key = asymmetric_key->payload.data[asym_crypto];
+	if (!key)
+		return;
+
+	switch (tpm2_key_type(key)) {
+	case TPM_ALG_RSA:
+		seq_puts(m, "tpm2.rsa");
+		break;
+	case TPM_ALG_ECC:
+		seq_printf(m, "tpm2.%s", tpm2_asymmetric_ecc_name(key));
+		break;
+	default:
+		seq_puts(m, "tpm2.unknown");
+		break;
+	}
+}
+
+static int tpm2_asymmetric_query(const struct kernel_pkey_params *params,
+				 struct kernel_pkey_query *info)
+{
+	struct tpm2_key *key = params->key->payload.data[asym_crypto];
+
+	switch (tpm2_key_type(key)) {
+	case TPM_ALG_RSA:
+		return tpm2_asymmetric_rsa_query(params, info);
+	case TPM_ALG_ECC:
+		return tpm2_asymmetric_ecc_query(params, info);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tpm2_asymmetric_eds_op(struct kernel_pkey_params *params,
+				  const void *in, void *out)
+{
+	struct tpm2_key *key = params->key->payload.data[asym_crypto];
+	struct tpm_chip *chip;
+	int ret;
+
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENODEV;
+
+	switch (params->op) {
+	case kernel_pkey_encrypt:
+		if (tpm2_key_type(key) != TPM_ALG_RSA) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+		ret = tpm2_asymmetric_rsa_encrypt(chip, key, params, in, out);
+		break;
+	case kernel_pkey_decrypt:
+		if (tpm2_key_type(key) != TPM_ALG_RSA) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+		ret = tpm2_asymmetric_rsa_decrypt(chip, key, params, in, out);
+		break;
+	case kernel_pkey_sign:
+		ret = tpm2_asymmetric_sign(chip, key, params, in, out);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	put_device(&chip->dev);
+	return ret;
+}
+
+static int tpm2_asymmetric_verify_signature(const struct key *asymmetric_key,
+					    const struct public_key_signature *sig)
+{
+	struct tpm2_key *key = asymmetric_key->payload.data[asym_crypto];
+
+	switch (tpm2_key_type(key)) {
+	case TPM_ALG_RSA:
+		return tpm2_asymmetric_rsa_verify(asymmetric_key, sig);
+	case TPM_ALG_ECC:
+		return tpm2_asymmetric_ecc_verify(asymmetric_key, sig);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static struct asymmetric_key_subtype tpm2_asymmetric_subtype = {
+	.owner			= THIS_MODULE,
+	.name			= "tpm2_asymmetric_key",
+	.name_len		= sizeof("tpm2_asymmetric_key") - 1,
+	.describe		= tpm2_asymmetric_describe,
+	.destroy		= tpm2_asymmetric_key_destroy,
+	.query			= tpm2_asymmetric_query,
+	.eds_op			= tpm2_asymmetric_eds_op,
+	.verify_signature	= tpm2_asymmetric_verify_signature,
+};
+
+static int tpm2_asymmetric_preparse(struct key_preparsed_payload *prep)
+{
+	struct tpm2_key *key __free(kfree) = NULL;
+	int ret;
+
+	key = tpm2_key_decode(prep->data, prep->datalen);
+	if (IS_ERR(key)) {
+		ret = PTR_ERR(key);
+		key = NULL;
+		return ret;
+	}
+
+	if (key->oid != OID_TPMLoadableKey)
+		return -EBADMSG;
+
+	switch (tpm2_key_type(key)) {
+	case TPM_ALG_RSA:
+		ret = tpm2_asymmetric_rsa_validate(key);
+		break;
+	case TPM_ALG_ECC:
+		ret = tpm2_asymmetric_ecc_validate(key);
+		break;
+	default:
+		ret = -EBADMSG;
+		break;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	__module_get(tpm2_asymmetric_subtype.owner);
+
+	prep->payload.data[asym_subtype] = &tpm2_asymmetric_subtype;
+	prep->payload.data[asym_key_ids] = NULL;
+	prep->payload.data[asym_crypto] = no_free_ptr(key);
+	prep->payload.data[asym_auth] = NULL;
+	prep->quotalen = 100;
+
+	return 0;
+}
+
+static struct asymmetric_key_parser tpm2_asymmetric_parser = {
+	.owner	= THIS_MODULE,
+	.name	= "tpm2_asymmetric_parser",
+	.parse	= tpm2_asymmetric_preparse,
+};
+
+static int __init tpm2_asymmetric_init(void)
+{
+	return register_asymmetric_key_parser(&tpm2_asymmetric_parser);
+}
+
+static void __exit tpm2_asymmetric_exit(void)
+{
+	unregister_asymmetric_key_parser(&tpm2_asymmetric_parser);
+}
+
+module_init(tpm2_asymmetric_init);
+module_exit(tpm2_asymmetric_exit);
+
+MODULE_DESCRIPTION("Asymmetric TPM2 key");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 202da079d500..d4d5ddc0173a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -45,6 +45,7 @@ enum tpm2_session_types {
 /* if you add a new hash to this, increment TPM_MAX_HASHES below */
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_RSA		= 0x0001,
 	TPM_ALG_SHA1		= 0x0004,
 	TPM_ALG_AES		= 0x0006,
 	TPM_ALG_KEYEDHASH	= 0x0008,
@@ -53,6 +54,9 @@ enum tpm_algorithms {
 	TPM_ALG_SHA512		= 0x000D,
 	TPM_ALG_NULL		= 0x0010,
 	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_RSASSA		= 0x0014,
+	TPM_ALG_RSAES		= 0x0015,
+	TPM_ALG_ECDSA		= 0x0018,
 	TPM_ALG_ECC		= 0x0023,
 	TPM_ALG_CFB		= 0x0043,
 };
@@ -66,6 +70,8 @@ enum tpm_algorithms {
 enum tpm2_curves {
 	TPM2_ECC_NONE		= 0x0000,
 	TPM2_ECC_NIST_P256	= 0x0003,
+	TPM2_ECC_NIST_P384	= 0x0004,
+	TPM2_ECC_NIST_P521	= 0x0005,
 };
 
 struct tpm_digest {
@@ -242,6 +248,7 @@ enum tpm2_structures {
 	TPM2_ST_NO_SESSIONS	= 0x8001,
 	TPM2_ST_SESSIONS	= 0x8002,
 	TPM2_ST_CREATION	= 0x8021,
+	TPM2_ST_HASHCHECK	= 0x8024,
 };
 
 /* Indicates from what layer of the software stack the error comes from */
@@ -276,12 +283,15 @@ enum tpm2_command_codes {
 	TPM2_CC_NV_READ                 = 0x014E,
 	TPM2_CC_CREATE		        = 0x0153,
 	TPM2_CC_LOAD		        = 0x0157,
+	TPM2_CC_RSA_DECRYPT	        = 0x0159,
 	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
+	TPM2_CC_SIGN		        = 0x015D,
 	TPM2_CC_UNSEAL		        = 0x015E,
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
 	TPM2_CC_READ_PUBLIC		= 0x0173,
+	TPM2_CC_RSA_ENCRYPT	        = 0x0174,
 	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
-- 
2.47.3


