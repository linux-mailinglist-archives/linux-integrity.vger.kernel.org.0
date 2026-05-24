Return-Path: <linux-integrity+bounces-9649-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCPhIsiJEmqC0gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9649-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:16:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53105C16BB
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 07:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D393027B7E
	for <lists+linux-integrity@lfdr.de>; Sun, 24 May 2026 05:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F02DE6FF;
	Sun, 24 May 2026 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlA92mMZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F32D131D;
	Sun, 24 May 2026 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779599740; cv=none; b=CDvtgvuyN24aOZ3cMo/2AkYonRdbGa3eXr8P6iJDNbTlbyPeUQU0vHu4zbijinad7VNP2O4McNCQnhxIiWX9yMW2y73EutoppfttNZowph7D/q11i5lSudrFyQmPh88/p4IKRBP2DiG64Oob4Jbw4uhnhjOP5QXj3hIFMG/bRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779599740; c=relaxed/simple;
	bh=cprsDt8mvzg757EI5xzIDAuBPDpx1DPfjmZvAVre8lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W37cwp0tai6z/erj8hLLYZkJzsmRXRj8pQ8MSslNtr/CQ6kq0D0VYu/5VY6S9UI3i3QK9ZMR0zTYGiE8XQmP5YJiqKri/qVq9ylN/iazLbTSPx5hOCaQciIAvB5c6/Q1HebiO25IJR4C2XDtKOgGaU/FbiVSwQ/OK6mYQoBtXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlA92mMZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1C0451F000E9;
	Sun, 24 May 2026 05:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779599738;
	bh=+ccOfGvZi4CTqd2/wXh9RtmD03GS9gPLCDKhk3bgDU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YlA92mMZGiraG5aTIckIHnMXvPnPSYBANAUKo1spDqdlVINXb+5I3iNIJUlnQiLnr
	 qQu1k6k9GmkvKR93JPiCXgx0W+oPYxNyqq7Xv2lwPPArb4zME7b9F18vz3J+U5w/Dn
	 XCsn+RfQTHOsy6JTV0d7wKEpNeCSjpXuHMbDGgYHZRKEDtcXv6wUFnAo6SGdiLiKQ4
	 I8Y6HBj8yCfhofw2GKlQzCU2jLQSq3K4AuWaPlg1g2wUOi1Llr64jpdXgDhnVvM57X
	 mcYTBKjRekhBYUNlBqb7kqkSKTQY3VaOCN9/n3zqm4qdN+25ePh9YUUl9KYkAVqr7V
	 IcSFnEtYUNESA==
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
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v8 2/3] crypto: Migrate TPMKey ASN.1 objects from trusted-keys
Date: Sun, 24 May 2026 08:15:13 +0300
Message-ID: <20260524051519.3708075-3-jarkko@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9649-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E53105C16BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Migrate the TPMKey ASN.1 code from trusted-keys to the crypto subsystem,
and put the code behind CRYPTO_TPM2_KEY Kconfig flag.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/Kconfig                            |   7 +
 crypto/Makefile                           |   6 +
 crypto/tpm2_key.asn1                      |  11 ++
 crypto/tpm2_key.c                         | 150 ++++++++++++++++++++++
 include/crypto/tpm2_key.h                 |  46 +++++++
 security/keys/trusted-keys/Kconfig        |   2 +-
 security/keys/trusted-keys/Makefile       |   2 -
 security/keys/trusted-keys/tpm2key.asn1   |  11 --
 security/keys/trusted-keys/trusted_tpm2.c | 119 ++---------------
 9 files changed, 232 insertions(+), 122 deletions(-)
 create mode 100644 crypto/tpm2_key.asn1
 create mode 100644 crypto/tpm2_key.c
 create mode 100644 include/crypto/tpm2_key.h
 delete mode 100644 security/keys/trusted-keys/tpm2key.asn1

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 103d1f58cb7c..5476d80372a1 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -3,6 +3,13 @@
 # Generic algorithms support
 #
 
+config CRYPTO_TPM2_KEY
+	bool
+	depends on CRYPTO
+	select ASN1
+	select OID_REGISTRY
+	default n
+
 #
 # async_tx api: hardware offloaded memory transfer/transform support
 #
diff --git a/crypto/Makefile b/crypto/Makefile
index 162242593c7c..e232f9b9bee6 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -206,3 +206,9 @@ obj-$(CONFIG_CRYPTO_KDF800108_CTR) += kdf_sp800108.o
 obj-$(CONFIG_CRYPTO_DF80090A) += df_sp80090a.o
 
 obj-$(CONFIG_CRYPTO_KRB5) += krb5/
+
+ifdef CONFIG_CRYPTO_TPM2_KEY
+$(obj)/tpm2_key.asn1.o: $(obj)/tpm2_key.asn1.h $(obj)/tpm2_key.asn1.c
+$(obj)/tpm2_key.o: $(obj)/tpm2_key.asn1.h
+obj-y += tpm2_key.o tpm2_key.asn1.o
+endif
diff --git a/crypto/tpm2_key.asn1 b/crypto/tpm2_key.asn1
new file mode 100644
index 000000000000..553bf996af59
--- /dev/null
+++ b/crypto/tpm2_key.asn1
@@ -0,0 +1,11 @@
+---
+--- ASN.1 for TPM 2.0 keys
+---
+
+TPMKey ::= SEQUENCE {
+	type		OBJECT IDENTIFIER ({tpm2_key_get_type}),
+	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL ({tpm2_key_get_empty_auth}),
+	parent		INTEGER ({tpm2_key_get_parent}),
+	pubkey		OCTET STRING ({tpm2_get_public}),
+	privkey		OCTET STRING ({tpm2_get_private})
+	}
diff --git a/crypto/tpm2_key.c b/crypto/tpm2_key.c
new file mode 100644
index 000000000000..5704ccdb7c0d
--- /dev/null
+++ b/crypto/tpm2_key.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <crypto/tpm2_key.h>
+#include <linux/oid_registry.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include "tpm2_key.asn1.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "tpm2_key: "fmt
+
+struct tpm2_key_decoder_context {
+	u32 parent;
+	const u8 *pub;
+	u32 pub_len;
+	const u8 *priv;
+	u32 priv_len;
+	enum OID oid;
+	bool empty_auth;
+};
+
+int tpm2_key_get_parent(void *context, size_t hdrlen,
+			unsigned char tag,
+			const void *value, size_t vlen)
+{
+	struct tpm2_key_decoder_context *decoder = context;
+	const u8 *v = value;
+	int i;
+
+	decoder->parent = 0;
+	for (i = 0; i < vlen; i++) {
+		decoder->parent <<= 8;
+		decoder->parent |= v[i];
+	}
+
+	return 0;
+}
+
+int tpm2_key_get_type(void *context, size_t hdrlen,
+		      unsigned char tag,
+		      const void *value, size_t vlen)
+{
+	struct tpm2_key_decoder_context *decoder = context;
+
+	decoder->oid = look_up_OID(value, vlen);
+	return 0;
+}
+
+int tpm2_key_get_empty_auth(void *context, size_t hdrlen,
+			    unsigned char tag,
+			    const void *value, size_t vlen)
+{
+	struct tpm2_key_decoder_context *decoder = context;
+	const u8 *bool_value = value;
+
+	if (!value || vlen != 1)
+		return -EBADMSG;
+
+	decoder->empty_auth = bool_value[0] != 0;
+	return 0;
+}
+
+static inline bool tpm2_key_is_valid(const void *value, size_t vlen)
+{
+	if (vlen < 2 || vlen > TPM2_KEY_BYTES_MAX)
+		return false;
+
+	if (get_unaligned_be16(value) != vlen - 2)
+		return false;
+
+	return true;
+}
+
+int tpm2_get_public(void *context, size_t hdrlen, unsigned char tag,
+		    const void *value, size_t vlen)
+{
+	struct tpm2_key_decoder_context *decoder = context;
+
+	if (!tpm2_key_is_valid(value, vlen))
+		return -EBADMSG;
+
+	if (sizeof(struct tpm2_key_desc) > vlen - 2)
+		return -EBADMSG;
+
+	decoder->pub = value;
+	decoder->pub_len = vlen;
+	return 0;
+}
+
+int tpm2_get_private(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct tpm2_key_decoder_context *decoder = context;
+
+	if (!tpm2_key_is_valid(value, vlen))
+		return -EBADMSG;
+
+	decoder->priv = value;
+	decoder->priv_len = vlen;
+	return 0;
+}
+
+/**
+ * tpm2_key_decode() - Decode TPM2 ASN.1 key
+ * @src:	ASN.1 source.
+ * @src_len:	ASN.1 source length.
+ *
+ * Decodes the TPM2 ASN.1 key and validates that the public key data has all
+ * the shared fields of TPMT_PUBLIC. This is full coverage of the memory that
+ * can be validated before doing any key type specific validation.
+ *
+ * Return:
+ * - TPM2 ASN.1 key on success.
+ * - -EBADMSG when decoding fails.
+ * - -ENOMEM when OOM while allocating struct tpm2_key.
+ */
+struct tpm2_key *tpm2_key_decode(const u8 *src, u32 src_len)
+{
+	struct tpm2_key_decoder_context decoder;
+	struct tpm2_key *key;
+	u8 *data;
+	int ret;
+
+	memset(&decoder, 0, sizeof(decoder));
+	ret = asn1_ber_decoder(&tpm2_key_decoder, &decoder, src, src_len);
+	if (ret < 0) {
+		if (ret != -EBADMSG)
+			pr_info("Decoder error %d\n", ret);
+
+		return ERR_PTR(-EBADMSG);
+	}
+
+	key = kzalloc(sizeof(*key), GFP_KERNEL);
+	if (!key)
+		return ERR_PTR(-ENOMEM);
+
+	data = &key->data[0];
+	memcpy(&data[0], decoder.priv, decoder.priv_len);
+	memcpy(&data[decoder.priv_len], decoder.pub, decoder.pub_len);
+
+	key->oid = decoder.oid;
+	key->priv_len = decoder.priv_len;
+	key->pub_len = decoder.pub_len;
+	key->parent = decoder.parent;
+	key->desc = (struct tpm2_key_desc *)&data[decoder.priv_len + 2];
+	key->empty_auth = decoder.empty_auth;
+	return key;
+}
+EXPORT_SYMBOL_GPL(tpm2_key_decode);
diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
new file mode 100644
index 000000000000..883afaa596e5
--- /dev/null
+++ b/include/crypto/tpm2_key.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_TPM2_KEY_H__
+#define __LINUX_TPM2_KEY_H__
+
+#include <linux/oid_registry.h>
+#include <linux/slab.h>
+
+#define TPM2_KEY_BYTES_MAX 1024
+
+/*  TPM2 Structures 12.2.4: TPMT_PUBLIC */
+struct tpm2_key_desc {
+	__be16 type;
+	__be16 name_alg;
+	__be32 object_attributes;
+	__be16 policy_size;
+} __packed;
+
+/* Decoded TPM2 ASN.1 key. */
+struct tpm2_key {
+	u8 data[2 * TPM2_KEY_BYTES_MAX];
+	struct tpm2_key_desc *desc;
+	u16 priv_len;
+	u16 pub_len;
+	u32 parent;
+	enum OID oid;
+	bool empty_auth;
+};
+
+struct tpm2_key *tpm2_key_decode(const u8 *src, u32 src_len);
+
+static inline const void *tpm2_key_data(const struct tpm2_key *key)
+{
+	return &key->data[0];
+}
+
+static inline u16 tpm2_key_type(const struct tpm2_key *key)
+{
+	return be16_to_cpu(key->desc->type);
+}
+
+static inline int tpm2_key_policy_size(const struct tpm2_key *key)
+{
+	return be16_to_cpu(key->desc->policy_size);
+}
+
+#endif /* __LINUX_TPM2_KEY_H__ */
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index e5a4a53aeab2..09b1ec1d5bc2 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -27,9 +27,9 @@ config TRUSTED_KEYS_TPM
 	select CRYPTO_HASH_INFO
 	select CRYPTO_LIB_SHA1
 	select CRYPTO_LIB_UTILS
+	select CRYPTO_TPM2_KEY
 	select ASN1_ENCODER
 	select OID_REGISTRY
-	select ASN1
 	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Platform Module (TPM) as trusted key
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 5fc053a21dad..ac09d2d90051 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -7,9 +7,7 @@ obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_core.o
 trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm1.o
 
-$(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
 trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
-trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
 
 trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
 
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
deleted file mode 100644
index f57f869ad600..000000000000
--- a/security/keys/trusted-keys/tpm2key.asn1
+++ /dev/null
@@ -1,11 +0,0 @@
----
---- ASN.1 for TPM 2.0 keys
----
-
-TPMKey ::= SEQUENCE {
-	type		OBJECT IDENTIFIER ({tpm2_key_type}),
-	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
-	parent		INTEGER ({tpm2_key_parent}),
-	pubkey		OCTET STRING ({tpm2_key_pub}),
-	privkey		OCTET STRING ({tpm2_key_priv})
-	}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6340823f8b53..5b079fe476d1 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -13,11 +13,10 @@
 
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
+#include <crypto/tpm2_key.h>
 
 #include <linux/unaligned.h>
 
-#include "tpm2key.asn1.h"
-
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
 
 static int tpm2_key_encode(struct trusted_key_payload *payload,
@@ -90,105 +89,6 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	return ret;
 }
 
-struct tpm2_key_context {
-	u32 parent;
-	const u8 *pub;
-	u32 pub_len;
-	const u8 *priv;
-	u32 priv_len;
-};
-
-static int tpm2_key_decode(struct trusted_key_payload *payload,
-			   struct trusted_key_options *options,
-			   u8 **buf)
-{
-	int ret;
-	struct tpm2_key_context ctx;
-	u8 *blob;
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
-			       payload->blob_len);
-	if (ret < 0)
-		return ret;
-
-	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
-		return -EINVAL;
-
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
-	if (!blob)
-		return -ENOMEM;
-
-	*buf = blob;
-	options->keyhandle = ctx.parent;
-
-	memcpy(blob, ctx.priv, ctx.priv_len);
-	blob += ctx.priv_len;
-
-	memcpy(blob, ctx.pub, ctx.pub_len);
-
-	return 0;
-}
-
-int tpm2_key_parent(void *context, size_t hdrlen,
-		  unsigned char tag,
-		  const void *value, size_t vlen)
-{
-	struct tpm2_key_context *ctx = context;
-	const u8 *v = value;
-	int i;
-
-	ctx->parent = 0;
-	for (i = 0; i < vlen; i++) {
-		ctx->parent <<= 8;
-		ctx->parent |= v[i];
-	}
-
-	return 0;
-}
-
-int tpm2_key_type(void *context, size_t hdrlen,
-		unsigned char tag,
-		const void *value, size_t vlen)
-{
-	enum OID oid = look_up_OID(value, vlen);
-
-	if (oid != OID_TPMSealedData) {
-		char buffer[50];
-
-		sprint_oid(value, vlen, buffer, sizeof(buffer));
-		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
-			 buffer);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-int tpm2_key_pub(void *context, size_t hdrlen,
-	       unsigned char tag,
-	       const void *value, size_t vlen)
-{
-	struct tpm2_key_context *ctx = context;
-
-	ctx->pub = value;
-	ctx->pub_len = vlen;
-
-	return 0;
-}
-
-int tpm2_key_priv(void *context, size_t hdrlen,
-		unsigned char tag,
-		const void *value, size_t vlen)
-{
-	struct tpm2_key_context *ctx = context;
-
-	ctx->priv = value;
-	ctx->priv_len = vlen;
-
-	return 0;
-}
 
 /**
  * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
@@ -372,23 +272,26 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
-	u8 *blob_ref __free(kfree) = NULL;
+	struct tpm2_key *key __free(kfree) = NULL;
 	struct tpm_buf buf;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
-	u8 *blob, *pub;
+	const u8 *blob, *pub;
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
-	if (rc) {
+	key = tpm2_key_decode(payload->blob, payload->blob_len);
+	if (IS_ERR(key))
+		key = NULL;
+
+	if (key && key->oid == OID_TPMSealedData) {
+		options->keyhandle = key->parent;
+		blob = tpm2_key_data(key);
+	} else {
 		/* old form */
 		blob = payload->blob;
 		payload->old_format = 1;
-	} else {
-		/* Bind for cleanup: */
-		blob_ref = blob;
 	}
 
 	/* new format carries keyhandle but old format doesn't */
-- 
2.47.3


