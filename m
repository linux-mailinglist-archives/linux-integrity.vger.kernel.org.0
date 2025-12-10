Return-Path: <linux-integrity+bounces-7893-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA8CB32F5
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 15:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54E9A30210F7
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70223EAA3;
	Wed, 10 Dec 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiw18lkT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994818787A;
	Wed, 10 Dec 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377623; cv=none; b=tG1IS+xzLlv1ez2osIyIOKfmjMY4GPraQo+JGAMXPmjNX1HBn0s0Gs5mEPpVxa/DXpXTarCFWU0KU1VVD2Q/xSNCHWog6C2Q2gh92f4jtXXKU46bVfvwOjOPTAotb8pRHuaJegZOP42YiUn8kNxN8SoRb14dVpK5eBrDwtNGMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377623; c=relaxed/simple;
	bh=FQ+qWhMfMoahdE00Fr6dXweIZfekA7MYZG6DDTqt6mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcBd2Mni/+M7BvCYUWsK8CUajrYVsCHQXzk/c3N7GdoOdMHBskwTzsEO3KAXYOPafCf1n3q6p1XLU7XvvfQZlPitKWu8xtvAhDE8C6xoEecocATDn7R5HcXqeBL98Ceud5QzCN1fivw9t7uhyPbOrIdyL62y+sy82+uMKYoqzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiw18lkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E14C4CEF1;
	Wed, 10 Dec 2025 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377623;
	bh=FQ+qWhMfMoahdE00Fr6dXweIZfekA7MYZG6DDTqt6mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiw18lkTlOjuolYETIXFi6zexb1ECE9BIigC8smYwx8B3W9hOx72zcnmkccjSc6Go
	 Q8DZpH1U+1WpjtWQoi47LU9oJ/uVCd2tk2cumaGCfxbvXAJ9jg1iDuXML1kvyfHs4Q
	 RhcKV37PUSSMJGuRcczno5aKtDYPcRjY/0kXccla86oXty49EPCl0Luk2QhzvRFUPA
	 jYr8rPobbNMBI5GmOYE9VH1widZq5/YELS6ZjXz7naO6JxnZPNbGEIJK2+2kTYeb5k
	 2aLyZOELt/UQwSkQ6do7NKM86E8m5UcyBKwQWKngWOE9MKVaDlxvXKu7NwYK7E4yk1
	 mLwRmwrN1VhYg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 7/7] tpm: Send only one TPM command per hwrng request
Date: Wed, 10 Dec 2025 16:39:39 +0200
Message-ID: <20251210143940.264191-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210143940.264191-1-jarkko@kernel.org>
References: <20251210143940.264191-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwrng framework does not have a enforce that all bytes requested need to be
read. By enforcing such a requirement internally, TPM driver can cause
unpredicatability in latency, as a single tpm_get_random() call can result
multiple TPM commands.

Especially, when TCG_TPM2_HMAC is enabled, roundtrips with the TPM should
be capped to exactly one.

Add a @wait parameter to enforce this behavior and set it to true at the
call sites TPM 1.2 keys. At the call sites of hwrng, set @wait to false.

Cc: David S. Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c               |  2 +-
 drivers/char/tpm/tpm-interface.c          | 11 +++++++++--
 include/linux/tpm.h                       |  2 +-
 security/keys/trusted-keys/trusted_tpm1.c |  8 ++++----
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 082b910ddf0d..8fca4373e2df 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -494,7 +494,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
 
-	return tpm_get_random(chip, data, max);
+	return tpm_get_random(chip, data, max, false);
 }
 
 static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index ab52a1cb0a78..5cc2bbabd57a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -604,9 +604,11 @@ static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
  * @chip:	A &tpm_chip instance. Whenset to %NULL, the default chip is used.
  * @out:	Destination buffer for the acquired random bytes.
  * @max:	The maximum number of bytes to write to @out.
+ * @wait:	Set to true when all of the @max bytes need to be acquired.
  *
  * Iterates pulling more bytes from TPM up until all of the @max bytes have been
- * received.
+ * received, when @wait it sets true. Otherwise, the queries for @max bytes from
+ * TPM exactly once, and returns the bytes that were received.
  *
  * Returns the number of random bytes read on success.
  * Returns -EINVAL when @out is NULL, or @max is not between zero and
@@ -614,7 +616,7 @@ static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
  * Returns tpm_transmit_cmd() error codes when the TPM command results an
  * error.
  */
-int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 {
 	u32 num_bytes = max;
 	u8 *out_ptr = out;
@@ -647,6 +649,11 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 		if (rc < 0)
 			goto err;
 
+		if (!wait) {
+			total = rc;
+			break;
+		}
+
 		out_ptr += rc;
 		total += rc;
 		num_bytes -= rc;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e68995df8796..177833d6b965 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -485,7 +485,7 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
-extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
+int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 int tpm2_find_hash_alg(unsigned int crypto_id);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 759c1ecb0435..f36f6a0b533f 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -361,7 +361,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 	unsigned char ononce[TPM_NONCE_SIZE];
 	int ret;
 
-	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
+	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE, true);
 	if (ret < 0)
 		return ret;
 
@@ -454,7 +454,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	memcpy(td->xorwork + SHA1_DIGEST_SIZE, sess.enonce, SHA1_DIGEST_SIZE);
 	sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
 
-	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
+	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE, true);
 	if (ret < 0)
 		goto out;
 
@@ -565,7 +565,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
-	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
+	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE, true);
 	if (ret < 0)
 		return ret;
 
@@ -938,7 +938,7 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 
 static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
 {
-	return tpm_get_random(chip, key, key_len);
+	return tpm_get_random(chip, key, key_len, true);
 }
 
 static int __init init_digests(void)
-- 
2.52.0


