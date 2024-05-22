Return-Path: <linux-integrity+bounces-2542-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F08CB6E9
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 02:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2388E1F27C94
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 00:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5E5672;
	Wed, 22 May 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIeRUCp5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D519470;
	Wed, 22 May 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339201; cv=none; b=RJHjqb9e26lvx49/Japi5t3x2mh1xtSLnrA6WYXswizFJfTehgqL7PjS68LkBlPSMz917M9///ClR+NcnfhLnoTQ41nUkIMqGfNVlCVOmXqpL0+fQwJqzPQmTpN97GCTSN6Gy6oO+VguuNso4hxe2nhA9/nkTJJ3UnP2s0Igsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339201; c=relaxed/simple;
	bh=1rnyBWgefbdvaOcJNmGJS6J3mOl1VZITDy0E+9wgNW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1QcHSb3NadV4up1w1pSKMZQEE630Y+ztqdmXLC0O+LKfK6paKS6sGzDi9gQeIgNF2V+G/B8rh33mJEpbmNWKrio0W4sljhlo4sGpTJIoXPTGleXk1r5ClhOewuBJf7w34PpcA+egP3ENz9MpQ12wQmYrKHsBHJeztIWd3zQ8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIeRUCp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BE3C32789;
	Wed, 22 May 2024 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716339201;
	bh=1rnyBWgefbdvaOcJNmGJS6J3mOl1VZITDy0E+9wgNW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIeRUCp5hQu2g+vF/EHPTOeBUZ0OXk2yi0Mi4LiZnmC0wVp16jIJWdu/Fz5LqeS5L
	 B9xgVHIVJDVnYkxUKZyUuVGkwSvbGap7GKRhdDGVlaHHYQw8PyCVrb3Ve8jxx5tdSV
	 rmCumNvfYiziZaIHNSSwfsOqXJ1w8R+AIKqiLW0Qnb5vpMCOi1qK9Xc07RSupCQN7l
	 7FJmsObUMFcyV4hJdEcL1svdDnlbKCX+8Wgz8ZNhAgMjHWeSQ3P1p12fgy3Po5/7gj
	 CjMzCiwZToQV5CVSuU1bxoU0iErAqcz2HkuNRaFH+9dg4Z0naWeUeLGmE5zZOPXgKu
	 wrUTJ8g01eB6Q==
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
Subject: [PATCH v4 4/5] tpm: tpm2_key: Extend parser to TPM_LoadableKey
Date: Wed, 22 May 2024 03:52:42 +0300
Message-ID: <20240522005252.17841-5-jarkko@kernel.org>
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
index 7662b2cb85bf..b5c07288eff5 100644
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
index 7e6eaec8b0bc..06a09c399334 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -303,6 +303,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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


