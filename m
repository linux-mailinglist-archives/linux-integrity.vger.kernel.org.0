Return-Path: <linux-integrity+bounces-8309-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HlFG1hudmneQgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8309-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:26:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1978215A
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1032C30056D2
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF6F2F3612;
	Sun, 25 Jan 2026 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg7bB5mR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8E2F0C78;
	Sun, 25 Jan 2026 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369144; cv=none; b=Dwxr6nA0F2JDy20fMq6++P0FK+fKNwcLjsXQqbof9g+Po/jMSVEy7aBy4iDGogD3gALbeagaSUT6lghFGd1kbwGnVJ6awW/6Ta2qKE+xP8NLwUK9AuwtMvRk5ddp+36nPsO8D1YIhSvfFkeAZS+s8ls9YP+atq1q1sEiq6b/Cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369144; c=relaxed/simple;
	bh=PN1ONpQnK+SF5l97FwDLlbrYt2AY83T4hiKTu6AGHLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIWEwxOiEcc2tS7XNgwQBG97xdIM6wNjbo4lEbPoDRgrEV1zOtrkD5FQoNHnq9bt4at53F2CBPbumJeUD3qSEo7RrLvJO/j/2b1Aahu1skLroykgRmN0MPQeYIaurDLMTfLkbRuaddG4J8Du5yaIvZGEfE8FM6EiMUNt4Kwhdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg7bB5mR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A5CC4CEF1;
	Sun, 25 Jan 2026 19:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369143;
	bh=PN1ONpQnK+SF5l97FwDLlbrYt2AY83T4hiKTu6AGHLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dg7bB5mRCyWuA0nJNvLZFcsoA1GcvefGR04wiNY+U91Cr+gxGguOWpuXfXktMlMWG
	 yPbZ2LqtDpjMm0h4Tr2RXsrqt28C3Uttpf61T2NpYmeGp6d8W4dN2pit1VXw0nI2EY
	 h6PdPuIxPjTvvqfpoP2bd6mP0Rhmw0L49nCFqrI82vqpYo5oA//j0x3eGgjZkHiC8X
	 rYToaLHpDMJW2ammMluxlfqgWrWzbBswVCe6rJJ8kAhM6ve64iCA1FNqSfXc8d0Uz3
	 xMGnkd9LJ2NwOkB/FfCrpFiuAhWajG1yFWhnHzthHo6Sp3Bj6j9eSlIK2xLSBJC0Uu
	 a7h7GGT6MvsJg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
Date: Sun, 25 Jan 2026 21:25:11 +0200
Message-ID: <20260125192526.782202-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125192526.782202-1-jarkko@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8309-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD1978215A
X-Rspamd-Action: no action

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
2.52.0


