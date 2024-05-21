Return-Path: <linux-integrity+bounces-2494-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAFD8CA6CB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 05:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414771C20BC3
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C11CD29;
	Tue, 21 May 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwIIXzE1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3D2556E;
	Tue, 21 May 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261435; cv=none; b=DNylbWQGKZ39S6F8P53TM9lLwUkUFfHLWAKGjaJox+77xDElfjmTYaCQCIPHgPwpAItOuPtTK7k99qlD4elui8cLtXRG8nCagCqFaZv5ewtQzlWLDUiuQBRArVF09OEVeYNBsgilpkRaKib48sQ+ced1TSliQUW2+pAOT1ZPD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261435; c=relaxed/simple;
	bh=n3cIMYf7xZGCzgAkDDAlFx85xEycCwosKadBNAn25Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upIG38E15cNJsKqcXF41qu/Ikb+2iz6yQQvt6zIxXQkvQSdxxHoT2f02h/vCbg4FKfdWk540c+NwSeKhBwvtvUXJoPn4YdMa8yE08RDv26EF67b74mvgIfkieGLgNhHCHWIm/9rnAKHLznBqj4szjokvoyhl8GNSyDEMWhjfjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwIIXzE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E77C2BD10;
	Tue, 21 May 2024 03:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716261435;
	bh=n3cIMYf7xZGCzgAkDDAlFx85xEycCwosKadBNAn25Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwIIXzE1xw5aYEGI78qrhpjosf1rBczq8Z/7pUaMROmisAKG9/MJj421TtlZ5Bn/P
	 zfxKyz7zZZNsl8zn9gOkPxbD06DDf03tCGO+BY+CkkZdIaOzXvzFhD61cJ2iKjtpuW
	 yVubyvSOFRwgkFz9VkOFkzKY751RblgTQBrmf8m6W9AGFl32fDL7Ql64T/fG0u/ZwW
	 YCrHrU7Vgy2NkhOLOzBcqKrMVklc6J4p9jbWcaOWp0JEhKfMOi4/e8yJHQR4/qUXym
	 VrsQdAHkgONXPc+Ad6eSdDr7dE+iAhgvjwfsPhAfKDKw1dEKTZsnF4hxDpNOqiE9oy
	 e/Ho10PyQdazw==
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
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 4/6] KEYS: trusted: Move tpm2_key_decode() to the TPM driver
Date: Tue, 21 May 2024 06:16:29 +0300
Message-ID: <20240521031645.17008-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521031645.17008-1-jarkko@kernel.org>
References: <20240521031645.17008-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move tpm2_key_decode() to the TPM driver and export the symbols to make
them callable from trusted keys. It can re-used for asymmetric keys.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
Do not allocate blob twice. Use the one inside struct tpm2_key.
---
 drivers/char/tpm/Kconfig                      |   1 +
 drivers/char/tpm/Makefile                     |   5 +
 drivers/char/tpm/tpm2_key.c                   | 111 +++++++++++++++
 .../char/tpm}/tpm2key.asn1                    |   0
 include/crypto/tpm2_key.h                     |  33 +++++
 security/keys/trusted-keys/Makefile           |   2 -
 security/keys/trusted-keys/trusted_tpm2.c     | 127 +++---------------
 7 files changed, 167 insertions(+), 112 deletions(-)
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/tpm2_key.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index e63a6a17793c..de2f4093c939 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -7,6 +7,7 @@ menuconfig TCG_TPM
 	tristate "TPM Hardware Support"
 	depends on HAS_IOMEM
 	imply SECURITYFS
+	select ASN1
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
index 000000000000..0112362e432e
--- /dev/null
+++ b/drivers/char/tpm/tpm2_key.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/oid_registry.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <crypto/tpm2_key.h>
+#include <asm/unaligned.h>
+#include "tpm2key.asn1.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "tpm2_key: "fmt
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
+	u32 blob_len;
+	int ret;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, src, src_len);
+	if (ret < 0)
+		return ret;
+
+	blob_len = ctx.priv_len + ctx.pub_len;
+	if (blob_len > max_key_len)
+		return -E2BIG;
+
+	ctx.blob_len = blob_len;
+	ctx.blob = kmalloc(blob_len, GFP_KERNEL);
+	if (!ctx.blob)
+		return -ENOMEM;
+
+	memcpy((void *)ctx.blob, ctx.priv, ctx.priv_len);
+	memcpy((void *)ctx.blob + ctx.priv_len, ctx.pub, ctx.pub_len);
+	ctx.priv = ctx.blob;
+	ctx.pub = ctx.blob + ctx.priv_len;
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
index 000000000000..acf41b2e0c92
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
+	const u8 *blob;
+	u32 blob_len;
+	const u8 *pub;
+	u32 pub_len;
+	const u8 *priv;
+	u32 priv_len;
+};
+
+int tpm2_key_decode(const u8 *src, u32 src_len, struct tpm2_key *key,
+		    u32 max_key_len);
+
+/**
+ * tpm2_key_free() - Release TPM2 asymmetric key resources and reset values
+ * @key:	TPM2 asymmetric key.
+ */
+static inline void tpm2_key_destroy(struct tpm2_key *key)
+{
+	kfree(key->blob);
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
index ec59f9389a2d..f255388d32b8 100644
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
@@ -28,9 +27,9 @@ static struct tpm2_hash tpm2_hash_map[] = {
 
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
 
-static int tpm2_key_encode(struct trusted_key_payload *payload,
-			   struct trusted_key_options *options,
-			   u8 *src, u32 len)
+static int tpm2_trusted_key_encode(struct trusted_key_payload *payload,
+				   struct trusted_key_options *options,
+				   u8 *src, u32 len)
 {
 	const int SCRATCH_SIZE = PAGE_SIZE;
 	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
@@ -100,106 +99,6 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
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
-
 /**
  * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
@@ -349,7 +248,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
+	blob_len = tpm2_trusted_key_encode(payload, options, &buf.data[offset],
+					   blob_len);
 
 out:
 	tpm_buf_destroy(&sized);
@@ -389,21 +289,27 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
-	struct tpm_buf buf;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
-	u8 *blob, *pub;
+	struct tpm2_key key;
+	struct tpm_buf buf;
+	const u8 *blob, *pub;
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
+	rc = tpm2_key_decode(payload->blob, payload->blob_len, &key, PAGE_SIZE);
 	if (rc) {
 		/* old form */
 		blob = payload->blob;
 		payload->old_format = 1;
+	} else {
+		blob = key.blob;
 	}
 
+	if (!blob)
+		return -ENOMEM;
+
 	/* new format carries keyhandle but old format doesn't */
 	if (!options->keyhandle)
 		return -EINVAL;
@@ -467,7 +373,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 out:
 	if (blob != payload->blob)
-		kfree(blob);
+		tpm2_key_destroy(&key);
+
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
-- 
2.45.1


