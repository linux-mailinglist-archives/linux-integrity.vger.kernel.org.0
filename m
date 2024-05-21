Return-Path: <linux-integrity+bounces-2495-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E18CA6CF
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 05:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412DE1F20CEA
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E320323;
	Tue, 21 May 2024 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE+6tN+m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09093BB32;
	Tue, 21 May 2024 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261439; cv=none; b=lyDGkfJpJJmHeLiVzYurx4DTT5kOx9Xc5zji2NVUh0rvG3Kaa33EO6rP1SvYIcQTksFv0s81hTLNkkeSTG+TpvwPTv5hXnzmWfcRKmwv+CkO/3c1Js6pXB9ZAMn8AnReGZWXNGmLZkwNApan6FvFxW3c6Tyamjg0eaE63eGOd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261439; c=relaxed/simple;
	bh=UAboRLGS7mPC957H6sOCjxTXDHuNsnoUR6E4ZLlnQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSaxncjtJ8W9xFc8MYYnP3hix6ngPqVENTuc4FHdalqXqXzdU93vvz25ZS3NxyPK3BRRv5RCs9HxQ0UEtIyzvZYFjyuIjaLz7viY5gEqod5iUVw5eUMOXNq0jRpbiUL2lJh8PtjWEYJYRwCOuNrMb2n216FJK/eIskG5APaGspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE+6tN+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D663EC2BD10;
	Tue, 21 May 2024 03:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716261439;
	bh=UAboRLGS7mPC957H6sOCjxTXDHuNsnoUR6E4ZLlnQfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BE+6tN+m6fx9OgZToaDacpbDWg+pJj59hvxFVCDQEd+zb5xAE344zx6ST7EMNHWsB
	 so/X2hKPVn3FuA0kkSjC0jZjpND0sNc6ne2LAtIOgkAKzfycTyiLSmglDudknOizHY
	 If14J9oWy00jpVeGnKzaOAqQFyn1yHlueM0RwJJSsCTyKys0ZbunfqptVIMvdTnoY3
	 Kgv16jgwi/KoB1jlWHOuIsUKU9ugR4YeH8b7+VCWOFQczT3oQDDf817ATCeSu68Rfc
	 /7hQqB9zS9bT8SMWo1Jv2jjVc/sCPGkvZjFXaOsJoE+esLGSQAJgxzZepkX8QqMpUs
	 uPSu9a0mFz5jQ==
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
Subject: [PATCH v2 5/6] tpm: tpm2_key: Extend parser to TPM_LoadableKey
Date: Tue, 21 May 2024 06:16:30 +0300
Message-ID: <20240521031645.17008-6-jarkko@kernel.org>
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

Extend parser to TPM_LoadableKey. Add field for oid to struct tpm2_key
so that callers can differentiate different key types.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2_key.c               | 14 +++++++++++---
 include/crypto/tpm2_key.h                 |  2 ++
 security/keys/trusted-keys/trusted_tpm2.c |  4 ++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm2_key.c b/drivers/char/tpm/tpm2_key.c
index 0112362e432e..59797dc232f1 100644
--- a/drivers/char/tpm/tpm2_key.c
+++ b/drivers/char/tpm/tpm2_key.c
@@ -32,16 +32,24 @@ int tpm2_key_type(void *context, size_t hdrlen,
 		  const void *value, size_t vlen)
 {
 	enum OID oid = look_up_OID(value, vlen);
-
-	if (oid != OID_TPMSealedData) {
+	struct tpm2_key *key = context;
+
+	switch (oid) {
+	case OID_TPMSealedData:
+		pr_info("TPMSealedData\n");
+		break;
+	case OID_TPMLoadableKey:
+		pr_info("TPMLodableKey\n");
+		break;
+	default:
 		char buffer[50];
-
 		sprint_oid(value, vlen, buffer, sizeof(buffer));
 		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
 			 buffer);
 		return -EINVAL;
 	}
 
+	key->oid = oid;
 	return 0;
 }
 
diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
index acf41b2e0c92..2d2434233000 100644
--- a/include/crypto/tpm2_key.h
+++ b/include/crypto/tpm2_key.h
@@ -2,12 +2,14 @@
 #ifndef __LINUX_TPM2_KEY_H__
 #define __LINUX_TPM2_KEY_H__
 
+#include <linux/oid_registry.h>
 #include <linux/slab.h>
 
 /*
  * TPM2 ASN.1 key
  */
 struct tpm2_key {
+	enum OID oid;
 	u32 parent;
 	const u8 *blob;
 	u32 blob_len;
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index f255388d32b8..ce4c667c3ee3 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -305,6 +305,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		payload->old_format = 1;
 	} else {
 		blob = key.blob;
+		if (key.oid != OID_TPMSealedData) {
+			tpm2_key_destroy(&key);
+			return -EINVAL;
+		}
 	}
 
 	if (!blob)
-- 
2.45.1


