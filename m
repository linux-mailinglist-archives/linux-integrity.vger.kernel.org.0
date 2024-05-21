Return-Path: <linux-integrity+bounces-2519-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837758CB13F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52C71C217A0
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F189144D0F;
	Tue, 21 May 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0aW5lxK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC004F8A1;
	Tue, 21 May 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305232; cv=none; b=A0XILQkzMwxMjC0DseeukolUaXkN5i9bBDUQYiHHmGTkdk4jGNv7duKTDFtgg5SnEjltvs3pOlggu3BPU0UXIQ6fH6BwWeqMWScuYS7rOmTqZCe4tQsrpWT1G8r0r7N101i2klbTaPu14SNywSodMVIWhQpDHl5wQ+BtO6w8Pfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305232; c=relaxed/simple;
	bh=rQTPLrmfpCPpQ7Zz53PlLkcw1m7mUahOVVqZUGpxmKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YirZfLwHW+shonYWwD5VXabcjWFVAwPZgwkXOboIQIshyve14xtcpaZUd+vGYCa9zdQUKUSsJaH/EZM3LQNdL3IfUyPoXPG7OPmRnxr+/nUI1XKxEgX9vOmvJ0320tOWKlbg2xzxsAjHDa7aef6AOUZoWfpeM68Hd8P4c+2W0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0aW5lxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DF7C2BD11;
	Tue, 21 May 2024 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716305232;
	bh=rQTPLrmfpCPpQ7Zz53PlLkcw1m7mUahOVVqZUGpxmKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0aW5lxK71K/avqKveHh96xCcyi64NF+GqNps93jaKKqDlcmWf5vzEgG6Pd/ZZZpH
	 o3gPZoJE+85VKB5cZMlBQEEWUhslIBrHSuiFow44LjXCVQUxLFbDtD0MjelTWGuYpU
	 H4+uB05FByyk216R8SWvB/J/rJ248vGBwuHCTq6fdllnU4YKgtnZlG08mj2C3ClPWN
	 pC6idlRzzlzzNixsPIl/7iA/1CKUDmEixA15LSXfhIWqUx2dKsapsjdAyziiitipjI
	 cBw9sdRHXX8bOaP4l5wlXwpS7o3b9wiBdqJJyEPkYsLkPni65DDvfK3fotYqGO4kFL
	 gsC/780Ad6AVg==
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
Subject: [PATCH v3 1/5] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
Date: Tue, 21 May 2024 18:26:43 +0300
Message-ID: <20240521152659.26438-2-jarkko@kernel.org>
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


