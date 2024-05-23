Return-Path: <linux-integrity+bounces-2596-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638838CDC0D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06789B22EA8
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA4129E9C;
	Thu, 23 May 2024 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqz8ifPL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9437129E8F;
	Thu, 23 May 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499542; cv=none; b=mYkQv2H1A9k7xyaPYWkwlLl9H1wLXQzpVI78Wx0rnUXBP0FHwfZxcgva7zXmQbbP8eyw/vfAiFBKRIxvdrxODvLcS3vVQwzOkJeKC2tC36sJYOAjGxOGGa3VIGhqImXgo217yMahiFL3WSSe5OiZRT1pu5J4M/T/SWFTiZsfDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499542; c=relaxed/simple;
	bh=bwx46fyxi21f4lcvrvEJTqeSya2jS+B+m4IM+zxLp1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+aY1VY6MywZ3NbYMzoTMHc45LpiwTXBKtZJU5ItEhl4s5GHEsSYNfGfeHnbcvSobsf5mSowdrkCPAFrGa/meAYwmRo9rJ0EYVQiFmOVOkSab6PhNsbi3e0hjfCCo/lJeuOdz4ZE6pDW0X+sCyANX4aIVLpArIQPQtHDo2gHJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqz8ifPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DF3C2BD10;
	Thu, 23 May 2024 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716499542;
	bh=bwx46fyxi21f4lcvrvEJTqeSya2jS+B+m4IM+zxLp1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dqz8ifPLdAC3GfGmk+iFUDIJYQqDFZKz/rHwVow7krDMeCSi92Z3jvuJnR5ceYxj1
	 DHv9R1+hOfYxsGuV2ZrmOaE5rD+6NiD8KJS9yfkSS3sJJ+vILaZbFZgDwlUHjdIxu0
	 vDvImru48Z+xuT0jf2SFL5Ykhy4ujTInzztBw6VIVopGF53MjuECGB4hFB1tqmco+y
	 oMr9tmZO7Bp55qDHTzprKeGKMCCC/vXLP1eym3eRqKoMJmEXhfbrLK1srcUCASIKdk
	 oUulJ0Ow1p2ZXao4JBOuFtARibYlFAOJEZp542NuhQ7lWf8G1ouQHviuYtQVUos4gv
	 Ry3+u3YepTBvg==
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
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH v5 4/5] tpm: tpm2_key: Extend parser to TPM_LoadableKey
Date: Fri, 24 May 2024 00:25:05 +0300
Message-ID: <20240523212515.4875-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523212515.4875-1-jarkko@kernel.org>
References: <20240523212515.4875-1-jarkko@kernel.org>
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
index e0bd1a2fc2ca..5b4555dd13e5 100644
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


