Return-Path: <linux-integrity+bounces-2421-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B548C678B
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 15:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EB3281B1C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108912A16E;
	Wed, 15 May 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki78AE9X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD912A15B;
	Wed, 15 May 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780381; cv=none; b=HzreStY+F8yJpmmSThKQMES/oEJmjPxxwPrKR879Tql8LMThE/uIeKD6HmmEvhsjfdGDQsjT8W6SKm3yCJHDiXw0pXG5ErcslFVXtgLqdZrkHhoXDHUAvRI6RZ89d9StP0ufCWjDQODii8JYfjk/6cTk6DVrenZHrlKva2TFygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780381; c=relaxed/simple;
	bh=17blqijHRfRC3vxH1neCWLqBA7J+OA+Hm9veCyE5STQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsCU/DAAx4Yh8UbR3sIcosENXNHNuPDmQhlvT2i5GTmSQH2TCGsLBJpIIuqUmxHJDf4rg5b0aPDXozPugSrH3o6ugNv9mbNWYnmZVEAeQ1ATJ8y/jJV+Kcn+DpsRMzNxBqEqm3EmQRqPOTmFwhGwvgHGb17HebNiOtqCEt5Yr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki78AE9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE25C4AF0B;
	Wed, 15 May 2024 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715780380;
	bh=17blqijHRfRC3vxH1neCWLqBA7J+OA+Hm9veCyE5STQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ki78AE9XAAMtOh9Nkf1Pp5y5zmVJeprzd3VNs1f6hSE/n8u4cB+4gEoR7PE1nl2AM
	 9onlpQqFBmKAriQRHBmlWjeJdKqyf0goRUzjVYlKzWLOvLO0J8+FGv9i6tvBVo0zv0
	 1DhUWs2DEzmg5tCHHaWIW+p6ZsPvUaJg/5u+W91I713iJC6xpae+fefdGlUQsWsDAi
	 4MOctzzNTiL3jEOU8z/QwRntx2rxh4LD2ARV6ZtPWsTXASoQeGD6uRoG2APerAybsk
	 QBt3JgO9t458/FbhgNXMG0Z56pwzb1UUzBdE/3CdBbuebhVJ30L5HSbFjIXmLJ/wBF
	 tQp4tQF2U/tCw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Prestwood <prestwoj@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
Date: Wed, 15 May 2024 16:39:30 +0300
Message-ID: <20240515133933.8515-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.0
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

Later rsa_lookup_asn1() can be enabled in crypto/asymmetric_keys/Kconfig
by:

	depends on CRYPTO_RSA >= <TPM2 asymmetric keys>

Cc: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/rsa-pkcs1pad.c         | 10 +++++++++-
 include/crypto/rsa-pkcs1pad.h | 11 +++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 include/crypto/rsa-pkcs1pad.h

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index cd501195f34a..a07ccf179f56 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -7,6 +7,7 @@
 
 #include <crypto/algapi.h>
 #include <crypto/akcipher.h>
+#include <crypto/rsa-pkcs1pad.h>
 #include <crypto/internal/akcipher.h>
 #include <crypto/internal/rsa.h>
 #include <linux/err.h>
@@ -101,7 +102,13 @@ static const struct rsa_asn1_template {
 	{ NULL }
 };
 
-static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
+/**
+ * rsa_lookup_asn1() - Lookup the ASN.1 digest info given the hash
+ * name:	hash algorithm name
+ *
+ * Returns theu ASN.1 digest info on success, and NULL on failure.
+ */
+const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
 {
 	const struct rsa_asn1_template *p;
 
@@ -110,6 +117,7 @@ static const struct rsa_asn1_template *rsa_lookup_asn1(const char *name)
 			return p;
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(rsa_lookup_asn1);
 
 struct pkcs1pad_ctx {
 	struct crypto_akcipher *child;
diff --git a/include/crypto/rsa-pkcs1pad.h b/include/crypto/rsa-pkcs1pad.h
new file mode 100644
index 000000000000..9881fa23d0dd
--- /dev/null
+++ b/include/crypto/rsa-pkcs1pad.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RSA padding templates.
+ */
+
+#ifndef _CRYPTO_RSA_PKCS1PAD_H
+#define _CRYPTO_RSA_PKCS1PAD_H
+
+const struct rsa_asn1_template *rsa_lookup_asn1(const char *name);
+
+#endif /* _CRYPTO_RSA_PKCS1PAD_H */
-- 
2.45.0


