Return-Path: <linux-integrity+bounces-8046-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453EFCC1621
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 08:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E71ED3063860
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42EE33C19B;
	Tue, 16 Dec 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgmlxhO6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400233C18E;
	Tue, 16 Dec 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871107; cv=none; b=pXwtdZbWtrisNnV2RFuvvCCWFdiOLgMivYXjKJBylK/XKTygiKI2b7SJvSGDdedjU6DJ7FxTYhLpnd863QBcie/8HuU2kTvty572ECokc3IdxveQQWmmFMsppuXqZdmlnv0GF5jaJEfsb7rnVfmiltzJq/jnMBtiVlj8Z7PXRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871107; c=relaxed/simple;
	bh=dOlZHbDKn4Rp8hb3QcyxziTii8177lSWZt3UBbY/UHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgO190QyqSyALQCutbbbv/fSXwRw4cET44unbFIGkbRS7pBrn/PKwSL0CHYq2NlMSiwfxIHfpJSRotbyxd8hSEj9BrEMWTnTAmsgnvYqpDlSNCzK8wMRGlc+54iIUmv1dK/xT42bdBvl3SmYH+w6YnwH49Ywu5kLVF8lACCj6Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgmlxhO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D17C4CEF1;
	Tue, 16 Dec 2025 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871107;
	bh=dOlZHbDKn4Rp8hb3QcyxziTii8177lSWZt3UBbY/UHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgmlxhO68iqDXQyAXcWKf1xp1nrb+wrn02IEJgXl96GjSvtloqfGuMRzW353nSIvw
	 aGcRIIhjsGXPVk8Gj9sz1HUoMcKp/wxLkntoOEY4+5QM6GCUFlM1zgwxvliHatAD2s
	 2u8fUFtbJdhND6dIyfqJl+GN2dSYFMu7YzxjIuJvLenXi8Wk+KzWvLERqkSnGpDzpb
	 AnIxtfBj4AkCXnaIdAcbD00oRI/6sUk4BIGoJoodT2IGuAKHHB8DP7egkasdfFAzQc
	 A+UJQc1OqrZdmVod6ldg8TIfso/bv1gcM3TZew6ApgXQ9Cpk00g6tRs1RFKmGdVpXG
	 1xsaKOkbak+Ng==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 01/12] KEYS: trusted: Use get_random-fallback for TPM
Date: Tue, 16 Dec 2025 09:44:42 +0200
Message-Id: <20251216074454.2192499-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216074454.2192499-1-jarkko@kernel.org>
References: <20251216074454.2192499-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
   use should be pooled rather than directly used. This both reduces
   latency and improves its predictability.

2. Linux is better off overall if every subsystem uses the same source for
   generating the random numbers required.

Thus, unset '.get_random', which causes fallback to kernel_get_random().

One might argue that TPM RNG should be used for the generated trusted keys,
so that they have matching entropy with the TPM internally generated
objects.

This argument does have some weight into it but as far cryptography goes,
FIPS certification sets the exact bar, not which exact FIPS certified RNG
will be used. Thus, the rational choice is obviously to pick the lowest
latency path, which is kernel RNG.

Finally, there is an actual defence in depth benefit when using kernel RNG
as it helps to mitigate TPM firmware bugs concerning RNG implementation,
given the obfuscation by the other entropy sources.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v7:
- A new patch. Simplifies follow up patches.
---
 security/keys/trusted-keys/trusted_tpm1.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 636acb66a4f6..7ce7e31bcdfb 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -6,6 +6,16 @@
  * See Documentation/security/keys/trusted-encrypted.rst
  */
 
+/**
+ * DOC: Random Number Generation
+ *
+ * tpm_get_random() was previously used here as the RNG in order to have equal
+ * entropy with the objects fully inside the TPM. However, as far as goes,
+ * kernel RNG is equally fine, as long as long as it is FIPS certified. Also,
+ * using kernel RNG has the benefit of mitigating bugs in the TPM firmware
+ * associated with the RNG.
+ */
+
 #include <crypto/hash_info.h>
 #include <crypto/sha1.h>
 #include <crypto/utils.h>
@@ -936,11 +946,6 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 	return ret;
 }
 
-static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
-{
-	return tpm_get_random(chip, key, key_len);
-}
-
 static int __init init_digests(void)
 {
 	int i;
@@ -992,6 +997,5 @@ struct trusted_key_ops trusted_key_tpm_ops = {
 	.init = trusted_tpm_init,
 	.seal = trusted_tpm_seal,
 	.unseal = trusted_tpm_unseal,
-	.get_random = trusted_tpm_get_random,
 	.exit = trusted_tpm_exit,
 };
-- 
2.39.5


