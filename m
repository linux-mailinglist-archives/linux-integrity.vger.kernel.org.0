Return-Path: <linux-integrity+bounces-2481-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5B18CA245
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 20:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD4EB21C84
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD51384BE;
	Mon, 20 May 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTFHShHl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD16139CEF;
	Mon, 20 May 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230882; cv=none; b=S5TrOlV01WcCuFJLe00TCfqFI2rrVm2oxDRXeBvnBNaMxEWJANDCefiKLa25T5KBjYtiPRfUaqMZap6S5DGw89R6FJva4sCcfyF/Nvwlf2VoIF5vXUCk8J7Z98Kt9QL+8GPTvLM289V9H/EXz80tXAkpyLCib9kb1w5i2xZzS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230882; c=relaxed/simple;
	bh=gNU6Lgy9J7HTeRp31thBNRIyKze5WZQpaPwf2uA260I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc9vrifcImafJ3LJzDrGnv+fpTO7XNZgo5+i4ex9T/13xeGZwHGU6/BPT3eRxl3ovVG9d92cMJH+w7TP69yXDhHTqCBo5Bl95duBHPt6pw1WOULx6VHKdrF28rbqTgYVjspeil+B6SIKZ6nHZ0RptIJ2IEBWKdxMQylLdmqUekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTFHShHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE7BC4AF07;
	Mon, 20 May 2024 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716230882;
	bh=gNU6Lgy9J7HTeRp31thBNRIyKze5WZQpaPwf2uA260I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTFHShHluBudnfubBQ0rhx3PRp1gCsbdi7w59c9ckvX3s8NB5ebJxnRjak+xakXxF
	 BGzdoiBJNn2Ncjq6yJe8JjKLavicOqANOC2MSX9sMHhKmoDXqpr8x2r2GWWTlIMpGz
	 iVG14+61JtBjdp2Sorl3idfgcZFlvz0yM2F3kqMDSJ+Ffhfe0flqTTgc8D37cqk1Z1
	 5G6roOBmHAaxLXUq5d1IBfk2I97l6T1US1JC0FHVRLwIhhmwQ6Jkvw8NEol4jaYVXX
	 8DJSjSBMKkg+aIChmrqWzeu3bS7JLvRLH0GYHi/9fTjyubsLslhGHQTMtG2f92z0Q0
	 Uk2eQbUZ0S+nw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
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
Subject: [PATCH 5/6] tpm: tpm2_key: Extend parser to TPM_LoadableKey
Date: Mon, 20 May 2024 21:47:12 +0300
Message-ID: <20240520184727.22038-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520184727.22038-1-jarkko@kernel.org>
References: <20240520184727.22038-1-jarkko@kernel.org>
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
 security/keys/trusted-keys/trusted_tpm2.c |  5 +++++
 3 files changed, 18 insertions(+), 3 deletions(-)

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
index 49ee2a57797a..842a8e2701e4 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -304,6 +304,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		blob = payload->blob;
 		payload->old_format = 1;
 	} else {
+		if (key.oid != OID_TPMSealedData) {
+			tpm2_key_destroy(&key);
+			return -EINVAL;
+		}
+
 		blob = kmalloc(key.priv_len + key.pub_len + 4, GFP_KERNEL);
 		if (blob) {
 			options->keyhandle = key.parent;
-- 
2.45.1


