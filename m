Return-Path: <linux-integrity+bounces-2422-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3CA8C6927
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EB9283D3A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88AE155743;
	Wed, 15 May 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QARLt8Y2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFA15572C;
	Wed, 15 May 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785340; cv=none; b=D/qcjpkq3B9A0czcUJF0UKUHxWTcdxbIqPhY7tj2TyBUyNPh5VbA7sfA7UG8jSzw0J6tZKYWR2VpRmWaDbG3QUF0QJz8/G1xeAlCLhda2xiR4JCU03OKJ+GoEKAOy40cTKXubCmrNX3h8uAsqAIq1TUOkSleG5upq0WTLhkqp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785340; c=relaxed/simple;
	bh=VzjvvZ9ObMsO/pd+PA+Q7TGExyfbBU28dZOOW6dqSSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcgunhe/h6GKjnepPDC358zmioye27T2Vs0d6Q0rquYLSG56H9UQM6uvmHCqVFURoPYBnMP454ijeykI7JB/khjgfnJsosC45jP9BAOLmmHuPBGOLn6W82sfmtEKrVuf+IUD06LpJeQZ+v6TXMCVrwY2+6xk05o8KCR/rPG6cMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QARLt8Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2206BC2BD11;
	Wed, 15 May 2024 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715785339;
	bh=VzjvvZ9ObMsO/pd+PA+Q7TGExyfbBU28dZOOW6dqSSs=;
	h=From:To:Cc:Subject:Date:From;
	b=QARLt8Y2f153giDpqZQk6fn55lras9Mm2rErqTSuhIv4gKtpeUFpUU9rAjyngtOnQ
	 FAQAnxCY2BHOjuumYOUjvWG26g9jWX0pGTLeAzQQDtcAE8bleWyKbPm5dK/GWmke/H
	 NeIhQJZ6v6ONBO+IoMpgSI9hrJN4hH64vxQhVV40esNZ0uYIwHT4WMhLZT8nRW9inq
	 hUCTHKQWhbqmK5Bs+jnRqQPEXOVedo7coUUa/2AJgiKwYBj06melEci0GczA89dIWB
	 i+iUZ/MoUx2T8rLe9netIh+00q1txLG028ED6dmH0FdWv70AoPOABtdtXTGvmmynuN
	 xMtma9kINzbmQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Prestwood <prestwoj@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
Date: Wed, 15 May 2024 18:02:10 +0300
Message-ID: <20240515150213.32491-1-jarkko@kernel.org>
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
v2:
- Fix typo in the kdoc.
- Export also the template struct.
---
 crypto/rsa-pkcs1pad.c         | 16 ++++++++++------
 include/crypto/rsa-pkcs1pad.h | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 include/crypto/rsa-pkcs1pad.h

diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index cd501195f34a..ea162ccf28ec 100644
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
+const struct rsa_asn1_template rsa_asn1_templates[] = {
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
2.45.0


