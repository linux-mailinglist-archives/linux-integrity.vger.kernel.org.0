Return-Path: <linux-integrity+bounces-7971-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C541DCBBCF9
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4CB3029C17
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B242D6612;
	Sun, 14 Dec 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsPx+75r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7A2D5935;
	Sun, 14 Dec 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726731; cv=none; b=R/vGP8k/57kVx+S9/O/aJw78KGYUUcUFTVbyN+NPJTKUHqqOfY4J/UVeJcCrV70zx5WNkc91+iteVZ/Xwv4uRCSfogqdWSJBNYsF1RJxj8KuvlURt3SY8BFrVYszZyadCruSDUqp8pernv8Am20Jw7pqyO3qhQDy/N6qAxa4h9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726731; c=relaxed/simple;
	bh=HdtC20rz6aIopnRHKq3aOZsSGC+Juz2ZtQLl3AqZv80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wk/cu7yVQ/3L6QWu8Vpqw5FSmOIr9/GKyYZe4kLKRrQaU1DgRb0rQ6L+kdZcEoCHrZQKrV3sghvPEUx5zJNc0oyl5SW+VF+eH9dhv0ScuWHoFp+F2+3QcUckxI0E6etDPG2/YUXedPLBxfFb4Rr2WFlcsmYeV3PhgtRuJKA7YWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsPx+75r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF50C4CEFB;
	Sun, 14 Dec 2025 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765726731;
	bh=HdtC20rz6aIopnRHKq3aOZsSGC+Juz2ZtQLl3AqZv80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tsPx+75rcjIiu3HaJ/hgnLUjwwPaj9WVdorf6cWowMFFd5oodP+zQWP0IG3hCbWew
	 BaFyLf3Sm/iL9IxWmXZCVNUhcNEgxsLmQ0FHSAhWXlBqU6JKIKmDoFzX1pO620Nhpa
	 lYufi2PKFbunPe9BFvgAA2mgbLT2f76QJ+xcARlwnbI4N2pnOyIr7bfANSMlmlIC+j
	 qlVttv4rvcXVknWBC/ibZLl183Vucru55rcGYnf05AaZmLpv0gE+lGj4I6CEMFhmO0
	 uPLr/2ZBuaiwzR6R9XuhC+85oxQkKzau4FR1Fu3PH6MeETh3G02dfmdNuKH1RtnD+H
	 18mbvDT9adNmQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
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
Subject: [PATCH v6 07/11] tpm: Send only one at most TPM2_GetRandom command
Date: Sun, 14 Dec 2025 17:38:04 +0200
Message-Id: <20251214153808.73831-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251214153808.73831-1-jarkko@kernel.org>
References: <20251214153808.73831-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwrng framework does not have a requirement that the all bytes requested
need to be provided. By enforcing such a requirement internally, TPM driver
can cause unpredictability in latency, as a single tpm_get_random() call
can result multiple TPM commands.

Especially, when TCG_TPM2_HMAC is enabled, extra roundtrips could have
significant effect to the system latency.

Add a wait-parameter to enforce the old behavior and set it to true only at
the call sites for TPM 1.2 keys. At the call sites of hwrng, set @wait to
false.

Cc: David S. Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
- Fixed grammar mistakes.
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
index d157be738612..0a79ed3696b7 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -614,9 +614,11 @@ static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
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
@@ -624,7 +626,7 @@ static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
  * Returns tpm_transmit_cmd() error codes when the TPM command results an
  * error.
  */
-int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
+int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait)
 {
 	u32 num_bytes = max;
 	u8 *out_ptr = out;
@@ -657,6 +659,11 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
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
index 72610f1aa402..d710a3aea2ff 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -487,7 +487,7 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
-extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
+int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max, bool wait);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
 int tpm2_find_hash_alg(unsigned int crypto_id);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 636acb66a4f6..5b5f7a029bc3 100644
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
2.39.5


