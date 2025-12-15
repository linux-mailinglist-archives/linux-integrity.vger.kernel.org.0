Return-Path: <linux-integrity+bounces-8005-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4FDCC0296
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 00:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5D93018D75
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E655F32939A;
	Mon, 15 Dec 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOn+Dr4P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3959328244;
	Mon, 15 Dec 2025 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765840490; cv=none; b=ekUGkFCpwvRbeda0gCr3Kmmbp9Wo1+AZ1AT2Z4YUP7O9g1Td8AOCyRtFbIYzqNTOuGJhyGIAOaRPK4ahIz37SUbbpar26pSNpMZtrzdosOSDN7/KCK+1YkM7vH6yejMrsh7CD4kwrG6xSu3GfXRqMGD1m29FpMPF+QuX9wzNS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765840490; c=relaxed/simple;
	bh=NGAR1aUtk+RPWjoJ/iLtnB5aelDIPnRmXuvE5A8Ntsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mhuqK9D2hu+ULX4LVIbKiwDyHeuEoI3aWqsRggsPSzo9QQGAQq+7RhMW3l0sJTRfSj4DHGEb8M+5XPJ939Qiqd5JtIw+m7HXF4vMUocFYY894TPE+eF2sQwyimRAX/JSHiCKN9qQJ1eLohkeiPqiDvQNTDWrpM+15d+KNEcihGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOn+Dr4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73C5C4CEF5;
	Mon, 15 Dec 2025 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765840490;
	bh=NGAR1aUtk+RPWjoJ/iLtnB5aelDIPnRmXuvE5A8Ntsc=;
	h=From:To:Cc:Subject:Date:From;
	b=qOn+Dr4PfqGd99biALYKPsk9nRb/aFJyyNGKfpn934TTj6AO7FLbSGcbIBntZC4dq
	 cNc+35/7KkAf0qV5l3lYUCMHiTc+8GgjVNjc7+zHXTfvSR/IE+2wZoIm68MaulU+XQ
	 UkzIEDQLrDprcSOKgH7tf7+S7oWuWFthe9lpWcR5oGV6NRVP2aeEhPSUpFUFw36xOg
	 EwK+eO+BBnvcDuJEqJ9H0E99vq9YDDsrGqWUMN0t8LRLOvZQrNp0xpoHN9boPuJ/qs
	 oOSv6FWy5Gw35O7IAwjVX4VkQebrNKhdTi2YuNQ2Z8Pgp9yW9siZLv2Cz1/w6FkxXK
	 DNyvx7pOYpDiA==
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
Subject: [PATCH v2] KEYS: trusted: Use get_random-fallback for TPM
Date: Tue, 16 Dec 2025 01:14:38 +0200
Message-Id: <20251215231438.565522-1-jarkko@kernel.org>
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

One might argue that TPM RNG should be used so that generated trusted keys
have the matching entropy with the TPM internally generated objects.

This argument does some weight into it but as far cryptography goes, FIPS
certification sets the exact bar, not which exact FIPS certified RNG will
be used. Thus, the rational choice is obviously to pick the lowest latency
path.

Finally, there also some actual defence in depth benefits on using kernel
RNG. E.g., it helps to mitigate TPM firmware bugs concerning RNG
implementation, which do happen in the wild occasionally.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Added Eric's reviewed-by tag.
- Addressed concerns from James by writing more details to the commit
  message and documenting random number generation to the source
  code.
---
 security/keys/trusted-keys/trusted_tpm1.c | 6 ------
 security/keys/trusted-keys/trusted_tpm2.c | 9 +++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 636acb66a4f6..33b7739741c3 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -936,11 +936,6 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
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
@@ -992,6 +987,5 @@ struct trusted_key_ops trusted_key_tpm_ops = {
 	.init = trusted_tpm_init,
 	.seal = trusted_tpm_seal,
 	.unseal = trusted_tpm_unseal,
-	.get_random = trusted_tpm_get_random,
 	.exit = trusted_tpm_exit,
 };
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index a7ea4a1c3bed..d16be47f1305 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -2,6 +2,15 @@
 /*
  * Copyright (C) 2004 IBM Corporation
  * Copyright (C) 2014 Intel Corporation
+
+/**
+ * DOC: Random Number Generation
+ *
+ * tpm_get_random() was previously used here as the RNG in order to have equal
+ * entropy with the objects fully inside the TPM. However, as far as goes,
+ * kernel RNG is equally fine, as long as long as it is FIPS certified. Also,
+ * using kernel RNG has the benefit of mitigating bugs in the TPM firmware
+ * associated with the RNG.
  */
 
 #include <linux/asn1_encoder.h>
-- 
2.39.5


