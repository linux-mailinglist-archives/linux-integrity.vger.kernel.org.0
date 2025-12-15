Return-Path: <linux-integrity+bounces-8037-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E6CC03B3
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 00:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D59530155F1
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2577433EB0C;
	Mon, 15 Dec 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crnh2DGm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEA146A66;
	Mon, 15 Dec 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842604; cv=none; b=ZCLYsr3NidTIqbo8AHkmpRNnUPN5D02yGbvjc1AjrD3r2ePBHAFCW7hC1VITFOYYFqpQrNO/MCJ85GiCGbiJUo93EZf1BbGVdjyxVmT8w8ogmxQkBd0A5kA1zEGNSjwlRZ7B8WTVjFy9fkcc7exEv1VJkSpFasvqCssMg33nYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842604; c=relaxed/simple;
	bh=5x88HEIkTgYf1xD7GovmrI5/UkL+Hu1QJ4lkwsKBz+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SdStvJ+EqYwhSMVjlH9ig+ayjKzibvbqTWjC8WqaPwCucWWBtANcG9UZn5NNVHbe7BMzir3zZW+Lehry8KpwnHrqBEa8DFAL5zLAQCFVuyUdwJXuEMC5SQpMXMCC+G/SKf6ui61b7ajRKJbO6GNF+JOXfoQqk0SupfAoU5Cm6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crnh2DGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E788CC4CEF5;
	Mon, 15 Dec 2025 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765842602;
	bh=5x88HEIkTgYf1xD7GovmrI5/UkL+Hu1QJ4lkwsKBz+I=;
	h=From:To:Cc:Subject:Date:From;
	b=Crnh2DGmFv5/LJoE3V1lqZ7itegKM1oPvG+UaRL9ZkZCGuHERR75/GzfotBNia8T0
	 DSU37glOuBAFTrNHnX3aspMh+s3ggVzHxNoULAskPOUo1R2QyJan0OIs5CVGW7MgQK
	 z3j6rOXXKOYyOUx6RUX30T0tnTRZogXNzwYTNOBjHfO8gI6UI2KT4mafpzS3I8EvVt
	 zz/c4q93B03Gf8a4CuvYxxhrsGsd58UG6BIZDtTbgna+7CnnE/z8teVFhlRVVwHpPn
	 S0jaeCZJmAlaMo9DsU8ewkM9LOGr0ItyXNIBER1TzXI431mU7s4YiXsBgkYgEAeN4e
	 xyF6OmQqH21UA==
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
Subject: [PATCH v3] KEYS: trusted: Use get_random-fallback for TPM
Date: Tue, 16 Dec 2025 01:49:54 +0200
Message-Id: <20251215234954.607848-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
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
v3:
- Fixed typos in the commit message.
- Moved the documentation comment to the correct location.
v2:
- Added Eric's reviewed-by tag.
- Addressed concerns from James by writing more details to the commit
  message and documenting random number generation to the source
  code.
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


