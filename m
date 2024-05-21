Return-Path: <linux-integrity+bounces-2522-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B9F8CB14E
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF1283411
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1261474A4;
	Tue, 21 May 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvatreaw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D7146D77;
	Tue, 21 May 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305249; cv=none; b=Sm5+MZU+rZdjfBVLua8Hflg/mUJUnwHF8DQrHYU6gz01QHBq08IZGQ1/xFpUbFUZkTbRJYUttGgqa6QV+cOG0CIWIYunttLeM38qquSN3YtEVcpOw6lsuOjdireZugF/54xmxWIjF8ZEVWICWlcIkCY9fusbEymO+jEgerqFUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305249; c=relaxed/simple;
	bh=zi66issw9MiUi8Zz5qR+3SdBH1g6liWWaQWZQngxkW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSnBVl1sVHg6w/rJHpkkYZRZtPZpvKNAGz8rvlQu/jE1MGyfVbtNy8ixhhffznqmsP+28sUrw7fKvhaqzKAClW+NBUcwcVDvGuVd2cbUUxcn4wcdL3YCSRCIN9c5/FXDm1Vt9rUQEMtsp5d1uSMlFmnTtnlMHzKTgHns3nqVr3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvatreaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D73C2BD11;
	Tue, 21 May 2024 15:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716305249;
	bh=zi66issw9MiUi8Zz5qR+3SdBH1g6liWWaQWZQngxkW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvatreawEq355t8Gw/Bq8zGwK0yyo+Qa7G7CsSNi9NDKp9fuv2UAPAM0px69HdEMY
	 hGJkHOD4g2Xc60Q94jEDzaYykpHbH/F8pGTQnu1mzEST67YM5423/lVkGC4vbZPO8b
	 lmgVD0Rqd+JD4v0VsnRPlWTu55CAfIZwZwET8tdt3SESlxkUKiH64GR6xMXhZ09HJi
	 YszETIgyp75Z3JVZxD4INNKfgvRMKKH7wmvqsQK/35Vu8KAp8rDUppbtnzKiLIKoMj
	 VzcX7BUHDZHYyUwi0wE1b8Jfte7iRuWbDCJClju6CAegZ7A/dg6DJk7N/wJxaQAfiA
	 8VkdDABmPGHUg==
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
Subject: [PATCH v3 4/5] tpm: tpm2_key: Extend parser to TPM_LoadableKey
Date: Tue, 21 May 2024 18:26:46 +0300
Message-ID: <20240521152659.26438-5-jarkko@kernel.org>
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

Extend parser to TPM_LoadableKey. Add field for oid to struct tpm2_key
so that callers can differentiate different key types.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
* Fixup klog messages:
  https://lore.kernel.org/linux-integrity/SN7PR18MB53140F4341BC441C1C11586EE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com/
---
 drivers/char/tpm/tpm2_key.c               | 17 ++++++++++++-----
 include/crypto/tpm2_key.h                 |  2 ++
 security/keys/trusted-keys/trusted_tpm2.c |  4 ++++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2_key.c b/drivers/char/tpm/tpm2_key.c
index 0112362e432e..06be1cc0156b 100644
--- a/drivers/char/tpm/tpm2_key.c
+++ b/drivers/char/tpm/tpm2_key.c
@@ -32,16 +32,23 @@ int tpm2_key_type(void *context, size_t hdrlen,
 		  const void *value, size_t vlen)
 {
 	enum OID oid = look_up_OID(value, vlen);
-
-	if (oid != OID_TPMSealedData) {
+	struct tpm2_key *key = context;
+
+	switch (oid) {
+	case OID_TPMSealedData:
+		pr_debug("TPMSealedData\n");
+		break;
+	case OID_TPMLoadableKey:
+		pr_debug("TPMLodableKey\n");
+		break;
+	default:
 		char buffer[50];
-
 		sprint_oid(value, vlen, buffer, sizeof(buffer));
-		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
-			 buffer);
+		pr_debug("Unknown OID \"%s\"\n", buffer);
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


