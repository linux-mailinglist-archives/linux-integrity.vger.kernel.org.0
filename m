Return-Path: <linux-integrity+bounces-2456-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BEE8C928B
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 23:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB73C1C20A27
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AEA6CDD5;
	Sat, 18 May 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM7bQN+7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518387173C;
	Sat, 18 May 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716068258; cv=none; b=G0PBCpsNtnxZQA9GOQYIjUjBAyhV1JGVpHBZ1xnE/lMjWBcwY5XLHlx2islVSWyNQ/5jzK2CGUITE52tw6JJd/9Ppdl0xbpipaNJXWPe9q2x9F7uiVf8GMp6WUoFOQzZLtBdAvCdOZDt1rec/pYTx4CFwR+XqGK39QrOttS6e/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716068258; c=relaxed/simple;
	bh=/DeeGeqKplWQhwy76qpyNbT8TjV3ONNLsN34x0zSwng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGMl/eyzJqifhzZM5bTbok6x8EMN9rvlx9zwFL1hpsvolXgZnzToBba2JtdY9awIW2BydRe0ZdlCY/G4NSeU4jtwPRUrsG/gJN1SCisRFr+FHg0atIJVmme7icioaYJji5sRRDeVhhxm/E+f5OUffZ7rjQIFZw9I+PSSGobFi9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM7bQN+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07C7C113CC;
	Sat, 18 May 2024 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716068258;
	bh=/DeeGeqKplWQhwy76qpyNbT8TjV3ONNLsN34x0zSwng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RM7bQN+78tMaMPKzx+VLfvv7mt22m3GRK89963TS1JXKifwjf2b1+wIk0bNo3bhNA
	 e5Eb+DsBMSOgSSjQggmPRXQ82VpgiqiRt71jTdbc52iFy2cUqRzic/3PlyqyipkpTI
	 EX8DEBglFUctV+PxmPtkpR9OGXU1DXokZzqJ09ssXcKjCIxWixasXjhQGCZDcG7TI4
	 Y4BbavE2kxZ0UdOfivb9Kj8nPBbT97aOeRX33M3W7opNU+Fj+0FKEL9wEpO2ctbWCe
	 1zfAi1MYMOBNi4NUk/Aqp1Az4fCeunrGffdLUxkd8grvLjyMPK3+TMMP9uXrGY13ya
	 4Y4Bit0tHLNFA==
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
	linux-kernel@vger.kernel.org (open list),
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH RFC 4/5] KEYS: trusted: Migrate tpm2_key_{encode,decode}() to TPM driver
Date: Sun, 19 May 2024 00:36:24 +0300
Message-ID: <20240518213700.5960-5-jarkko@kernel.org>
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

Migrate tpm2_key_{encode,decode}() to TPM driver and export the symbols
to make them callable from trusted keys.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/Kconfig                      |   5 +
 drivers/char/tpm/Makefile                     |   5 +
 drivers/char/tpm/tpm2_key.c                   | 181 +++++++++++++++++
 .../char/tpm}/tpm2key.asn1                    |   0
 include/crypto/tpm2_key.h                     |  33 ++++
 security/keys/trusted-keys/Makefile           |   2 -
 security/keys/trusted-keys/trusted_tpm2.c     | 187 ++----------------
 7 files changed, 242 insertions(+), 171 deletions(-)
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/tpm2_key.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index db41301e63f2..d5d06cc96932 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -3,10 +3,15 @@
 # TPM device configuration
 #
 
+config TCG_TPM2_KEY
+	bool
+
 menuconfig TCG_TPM
 	tristate "TPM Hardware Support"
 	depends on HAS_IOMEM
 	imply SECURITYFS
+	select ASN1
+	select ASN1_ENCODER
 	select CRYPTO
 	select CRYPTO_HASH_INFO
 	help
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 4c695b0388f3..071437058ef6 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -17,6 +17,11 @@ tpm-y += eventlog/tpm1.o
 tpm-y += eventlog/tpm2.o
 tpm-y += tpm-buf.o
 
+# TPM2 Asymmetric Key
+$(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
+tpm-y += tpm2key.asn1.o
+tpm-y += tpm2_key.o
+
 tpm-$(CONFIG_TCG_TPM2_HMAC) += tpm2-sessions.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
 tpm-$(CONFIG_EFI) += eventlog/efi.o
diff --git a/drivers/char/tpm/tpm2_key.c b/drivers/char/tpm/tpm2_key.c
new file mode 100644
index 000000000000..e09441efb0f0
--- /dev/null
+++ b/drivers/char/tpm/tpm2_key.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "tpm2_key: "fmt
+
+#include <linux/asn1_encoder.h>
+#include <linux/asn1_decoder.h>
+#include <linux/oid_registry.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <crypto/tpm2_key.h>
+#include <asm/unaligned.h>
+#include <keys/trusted-type.h>
+#include "tpm2key.asn1.h"
+
+static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
+
+int tpm2_key_parent(void *context, size_t hdrlen,
+		    unsigned char tag,
+		    const void *value, size_t vlen)
+{
+	struct tpm2_key *ctx = context;
+	const u8 *v = value;
+	int i;
+
+	ctx->parent = 0;
+	for (i = 0; i < vlen; i++) {
+		ctx->parent <<= 8;
+		ctx->parent |= v[i];
+	}
+
+	return 0;
+}
+
+int tpm2_key_type(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	enum OID oid = look_up_OID(value, vlen);
+
+	if (oid != OID_TPMSealedData) {
+		char buffer[50];
+
+		sprint_oid(value, vlen, buffer, sizeof(buffer));
+		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
+			 buffer);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int tpm2_key_pub(void *context, size_t hdrlen,
+		 unsigned char tag,
+		 const void *value, size_t vlen)
+{
+	struct tpm2_key *ctx = context;
+
+	ctx->pub = value;
+	ctx->pub_len = vlen;
+
+	return 0;
+}
+
+int tpm2_key_priv(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	struct tpm2_key *ctx = context;
+
+	ctx->priv = value;
+	ctx->priv_len = vlen;
+
+	return 0;
+}
+
+/**
+ * tpm2_key_encode() - Encode TPM2 ASN.1 key.
+ * @blob:		Decoded blob.
+ * @blob_auth_len:	Authorization length.
+ * @key_handle:		TPM2 handle of the key.
+ * @src:		ASN.1 source.
+ *
+ * Encodes TPM2 ASN.1 key on success. Returns POSIX error code on failure.
+ */
+int tpm2_key_encode(u8 *blob, u32 blob_auth_len, u32 key_handle, u8 *src)
+{
+	const int SCRATCH_SIZE = PAGE_SIZE;
+	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	u8 *work = scratch, *work1;
+	u8 *end_work = scratch + SCRATCH_SIZE;
+	u8 *priv, *pub;
+	u16 priv_len, pub_len;
+	int ret;
+
+	priv_len = get_unaligned_be16(src) + 2;
+	priv = src;
+
+	src += priv_len;
+
+	pub_len = get_unaligned_be16(src) + 2;
+	pub = src;
+
+	if (!scratch)
+		return -ENOMEM;
+
+	work = asn1_encode_oid(work, end_work, tpm2key_oid,
+			       asn1_oid_len(tpm2key_oid));
+
+	if (blob_auth_len == 0) {
+		unsigned char bool[3], *w = bool;
+		/* tag 0 is emptyAuth */
+		w = asn1_encode_boolean(w, w + sizeof(bool), true);
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
+			return PTR_ERR(w);
+		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+	}
+
+	/*
+	 * Assume both octet strings will encode to a 2 byte definite length
+	 *
+	 * Note: For a well behaved TPM, this warning should never
+	 * trigger, so if it does there's something nefarious going on
+	 */
+	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
+		 "BUG: scratch buffer is too small"))
+		return -EINVAL;
+
+	work = asn1_encode_integer(work, end_work, key_handle);
+	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
+	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
+
+	work1 = blob;
+	work1 = asn1_encode_sequence(work1, work1 + MAX_BLOB_SIZE, scratch, work - scratch);
+	if (IS_ERR(work1)) {
+		ret = PTR_ERR(work1);
+		pr_err("ASN.1 encoder failed with %d\n", ret);
+		return ret;
+	}
+
+	return work1 - blob;
+}
+EXPORT_SYMBOL_GPL(tpm2_key_encode);
+
+/**
+ * tpm_key_decode() - Decode TPM2 ASN.1 key.
+ * @src:		ASN.1 source.
+ * @src_len:		ASN.1 source length.
+ * @key:		TPM2 asymmetric key.
+ * @max_key_len:	Maximum length of the TPM2 asymmetric key.
+ *
+ * Decodes TPM2 ASN.1 key on success. Returns POSIX error code on failure.
+ */
+int tpm2_key_decode(const u8 *src, u32 src_len, struct tpm2_key *key,
+		    u32 max_key_len)
+{
+	struct tpm2_key ctx;
+	int ret;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, src, src_len);
+	if (ret < 0)
+		return ret;
+
+	if (ctx.priv_len + ctx.pub_len > max_key_len)
+		return -EINVAL;
+
+	ctx.priv = kmemdup(ctx.priv, ctx.priv_len, GFP_KERNEL);
+	if (!ctx.priv)
+		return -ENOMEM;
+
+	ctx.pub = kmemdup(ctx.pub, ctx.pub_len, GFP_KERNEL);
+	if (!ctx.pub) {
+		kfree(ctx.priv);
+		return -ENOMEM;
+	}
+
+	memcpy(key, &ctx, sizeof(ctx));
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm2_key_decode);
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/drivers/char/tpm/tpm2key.asn1
similarity index 100%
rename from security/keys/trusted-keys/tpm2key.asn1
rename to drivers/char/tpm/tpm2key.asn1
diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
new file mode 100644
index 000000000000..e5d3330afef5
--- /dev/null
+++ b/include/crypto/tpm2_key.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_TPM2_KEY_H__
+#define __LINUX_TPM2_KEY_H__
+
+#include <linux/slab.h>
+
+/*
+ * TPM2 ASN.1 key
+ */
+struct tpm2_key {
+	u32 parent;
+	const u8 *pub;
+	u32 pub_len;
+	const u8 *priv;
+	u32 priv_len;
+};
+
+int tpm2_key_encode(u8 *blob, u32 blob_auth_len, u32 key_handle, u8 *src);
+int tpm2_key_decode(const u8 *src, u32 src_len, struct tpm2_key *key,
+		    u32 max_key_len);
+
+/**
+ * tpm2_key_free() - Release TPM2 asymmetric key resources and reset values
+ * @key:	TPM2 asymmetric key.
+ */
+static inline void tpm2_key_destroy(struct tpm2_key *key)
+{
+	kfree(key->priv);
+	kfree(key->pub);
+	memset(key, 0, sizeof(*key));
+}
+
+#endif /* __LINUX_TPM2_KEY_H__ */
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index f0f3b27f688b..2674d5c10fc9 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -7,9 +7,7 @@ obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_core.o
 trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm1.o
 
-$(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
 trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
-trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
 
 trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index dbdd6a318b8b..3e1140914ca4 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -13,11 +13,10 @@
 
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
+#include <crypto/tpm2_key.h>
 
 #include <asm/unaligned.h>
 
-#include "tpm2key.asn1.h"
-
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
@@ -26,169 +25,6 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
-static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
-
-static int tpm2_key_encode(struct trusted_key_payload *payload,
-			   struct trusted_key_options *options,
-			   u8 *src, u32 len)
-{
-	const int SCRATCH_SIZE = PAGE_SIZE;
-	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
-	u8 *work = scratch, *work1;
-	u8 *end_work = scratch + SCRATCH_SIZE;
-	u8 *priv, *pub;
-	u16 priv_len, pub_len;
-	int ret;
-
-	priv_len = get_unaligned_be16(src) + 2;
-	priv = src;
-
-	src += priv_len;
-
-	pub_len = get_unaligned_be16(src) + 2;
-	pub = src;
-
-	if (!scratch)
-		return -ENOMEM;
-
-	work = asn1_encode_oid(work, end_work, tpm2key_oid,
-			       asn1_oid_len(tpm2key_oid));
-
-	if (options->blobauth_len == 0) {
-		unsigned char bool[3], *w = bool;
-		/* tag 0 is emptyAuth */
-		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
-			return PTR_ERR(w);
-		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
-	}
-
-	/*
-	 * Assume both octet strings will encode to a 2 byte definite length
-	 *
-	 * Note: For a well behaved TPM, this warning should never
-	 * trigger, so if it does there's something nefarious going on
-	 */
-	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
-		 "BUG: scratch buffer is too small"))
-		return -EINVAL;
-
-	work = asn1_encode_integer(work, end_work, options->keyhandle);
-	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
-	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
-
-	work1 = payload->blob;
-	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
-				     scratch, work - scratch);
-	if (IS_ERR(work1)) {
-		ret = PTR_ERR(work1);
-		pr_err("ASN.1 encode error %d\n", ret);
-		return ret;
-	}
-
-	return work1 - payload->blob;
-}
-
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
-
 /**
  * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
@@ -338,7 +174,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
+	blob_len = tpm2_key_encode(payload->blob, options->blobauth_len,
+				   options->keyhandle, &buf.data[offset]);
 
 out:
 	tpm_buf_destroy(&sized);
@@ -378,20 +215,32 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
-	struct tpm_buf buf;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
+	struct tpm2_key key;
+	struct tpm_buf buf;
 	u8 *blob, *pub;
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
+	rc = tpm2_key_decode(payload->blob, payload->blob_len, &key,
+			     MAX_BLOB_SIZE);
 	if (rc) {
-		/* old form */
+		/* legacy format: */
 		blob = payload->blob;
 		payload->old_format = 1;
+	} else {
+		blob = kmalloc(key.priv_len + key.pub_len + 4, GFP_KERNEL);
+		if (blob) {
+			options->keyhandle = key.parent;
+			memcpy(blob, key.priv, key.priv_len);
+			memcpy(&blob[key.priv_len], key.pub, key.pub_len);
+		}
 	}
+	tpm2_key_destroy(&key);
+	if (!blob)
+		return -ENOMEM;
 
 	/* new format carries keyhandle but old format doesn't */
 	if (!options->keyhandle)
-- 
2.45.1


