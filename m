Return-Path: <linux-integrity+bounces-2539-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE1A8CB6DC
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 02:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A981C22EBA
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 00:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2696139;
	Wed, 22 May 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjjT/6ah"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017E568A;
	Wed, 22 May 2024 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339187; cv=none; b=D0RrOt+ad8jDWKu1nomeeJ0tT7MxF9VgTKofykjcTBByGeGbM+OJ1ilOYC9QYJYnje2uLi/hod9tJkb4mGIu8+txwD2vB2besIFtJTM4ixHIA1u0V2qzPP0lWmQM/GDrs8eYE03uACnxbcvlXV1vAhbGKPhe0vPsNna5MHSJ7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339187; c=relaxed/simple;
	bh=rQTPLrmfpCPpQ7Zz53PlLkcw1m7mUahOVVqZUGpxmKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9zpbc95CuyEHQBqH1lXOHciTfbzZnDusRI+mY6QXCh8imw3IFf/itzRvFvb3s/dDoW+EWFuqWCA+hvqpvDDseHqToR6tiOquBhBdsTBtQMFEeI/iYbyU6wVvczYBfshJN82zGuNj7FH9ghDytlJD7iQtfyVC4CxnUQBpPr5A8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjjT/6ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8E0C32786;
	Wed, 22 May 2024 00:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716339186;
	bh=rQTPLrmfpCPpQ7Zz53PlLkcw1m7mUahOVVqZUGpxmKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjjT/6ahpTP6a+Bs8wKUPMZRh4rOFZoK7T2tHX/Rfe16aMb7kTHzRg4fSW7u1RX8t
	 AjLeDgLuB8djDKF0i4zTtoSsbQdiz/NbsZlVU+kbdSZdJBJXCsNljVg/VVQgtmePaO
	 H6yuAWrKQmvbjj3BVx3YQH+sdXydeiA9wpxV5de8cwwBmVATsnoiBcneVd7gNrGNaQ
	 CmZp8pKGk1AQSZ8a0Z65eQSzL7AT3+xyIgf2g8t/vlY0ZzYW8likNa0Tp/DF0Zg8Kr
	 /5MjXvuVIeWUBsUTKMp3GoBeVVx9R4wrbyIoJLd2NP7Ew0amfDCJYs/ypuiVrMQQRF
	 yCh1AySogOxOQ==
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/5] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
Date: Wed, 22 May 2024 03:52:39 +0300
Message-ID: <20240522005252.17841-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522005252.17841-1-jarkko@kernel.org>
References: <20240522005252.17841-1-jarkko@kernel.org>
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


