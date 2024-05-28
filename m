Return-Path: <linux-integrity+bounces-2670-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DABF8D1303
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 05:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5611C21950
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 03:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8A282FA;
	Tue, 28 May 2024 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFJGocpV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB904241E7;
	Tue, 28 May 2024 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868317; cv=none; b=UpBGA6iST6LV9a7BARR/cc4JFJJDJ2BQHL8Oiu3iSjGfFdbhVO4YJzXL3xcZu5EsVIVkotx/MmaM1715lklAyJ0r8dt3Y4uQ6Wt7Z4VYK7xZpEtCtRmqZaPg3KsxM4HAf+E0/usEsgyre3PJMZG7GVTKkTofEdYUBWAlkbkZrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868317; c=relaxed/simple;
	bh=rQTPLrmfpCPpQ7Zz53PlLkcw1m7mUahOVVqZUGpxmKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXRcuhK4RkPvNrurY6LIWnuqENuAeRxK6PyNxC/m58bkJOOVeUK140igZWEeX9cYNDEayLtILFhl17LM6U5zGEYrWlxwEEMoh5FgoAZ0mnBJ+9FkW0Y/m7TjzaKh51gFNlK7aCNqrH04+9002XNFkHCsBr7QaJ0bWOJptA6TI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFJGocpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1A0C3277B;
	Tue, 28 May 2024 03:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716868317;
	bh=rQTPLrmfpCPpQ7Zz53PlLkcw1m7mUahOVVqZUGpxmKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mFJGocpV6xt6VzaDwEswX4GBU1Uo5NqO2zz6v9xQkJ0Hm+AGkuL/h65yRlRVkxQ5A
	 Ykzd7tkUMMlUbyIiyAgF+TuoctQpMaIW7+Q9fUOrB/1gWl5cWBPoXHe3S9i7RV6hPU
	 6oTNd3b7GkG5n1vwHLjZJvfnk6cImEd7uvuEnCTQcTCub/dfsxWkhDBNv5EprmoE6G
	 N9WP17eZoWZmlmBy4QecAjM2QK+VBEGVrAe1c/DV0t3JPGSEbwmSwIdAcZNgs6KAv8
	 hBv3SMTMzW6t1IDR42bR42If+YfLqCdcuSdlS4ljvWehBmYXNkOJridfL8YOmZZ2nF
	 p3oKyNm8QJpSQ==
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/6] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
Date: Tue, 28 May 2024 06:51:17 +0300
Message-ID: <20240528035136.11464-3-jarkko@kernel.org>
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

ASN.1 template is required for TPM2 asymmetric keys, as it needs to be
piggy-packed with the input data before applying TPM2_RSA_Decrypt. This
patch prepares crypto subsystem for the addition of those keys.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/rsa-pkcs1pad.c         | 16 ++++++++++------
 include/crypto/rsa-pkcs1pad.h | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 include/crypto/rsa-pkcs1pad.h

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index cd501195f34a..00b6c14f861c 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -7,6 +7,7 @@
 
 #include <crypto/algapi.h>
 #include <crypto/akcipher.h>
+#include <crypto/rsa-pkcs1pad.h>
 #include <crypto/internal/akcipher.h>
 #include <crypto/internal/rsa.h>
 #include <linux/err.h>
@@ -79,11 +80,7 @@ static const u8 rsa_digest_info_sha3_512[] = {
 	0x05, 0x00, 0x04, 0x40
 };
 
-static const struct rsa_asn1_template {
-	const char	*name;
-	const u8	*data;
-	size_t		size;
-} rsa_asn1_templates[] = {
+static const struct rsa_asn1_template rsa_asn1_templates[] = {
 #define _(X) { #X, rsa_digest_info_##X, sizeof(rsa_digest_info_##X) }
 	_(md5),
 	_(sha1),
@@ -101,7 +98,13 @@ static const struct rsa_asn1_template {
 	{ NULL }
 };
 
-static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
+/**
+ * rsa_lookup_asn1() - Lookup the ASN.1 digest info given the hash
+ * name:	hash algorithm name
+ *
+ * Returns the ASN.1 digest info on success, and NULL on failure.
+ */
+const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
 {
 	const struct rsa_asn1_template *p;
 
@@ -110,6 +113,7 @@ static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
 			return p;
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(rsa_lookup_asn1);
 
 struct pkcs1pad_ctx {
 	struct crypto_akcipher *child;
diff --git a/include/crypto/rsa-pkcs1pad.h b/include/crypto/rsa-pkcs1pad.h
new file mode 100644
index 000000000000..32c7453ff644
--- /dev/null
+++ b/include/crypto/rsa-pkcs1pad.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RSA padding templates.
+ */
+
+#ifndef _CRYPTO_RSA_PKCS1PAD_H
+#define _CRYPTO_RSA_PKCS1PAD_H
+
+/*
+ * Hash algorithm name to ASN.1 template mapping.
+ */
+struct rsa_asn1_template {
+	const char *name;
+	const u8 *data;
+	size_t size;
+};
+
+const struct rsa_asn1_template *rsa_lookup_asn1(const char *name);
+
+#endif /* _CRYPTO_RSA_PKCS1PAD_H */
-- 
2.45.1


