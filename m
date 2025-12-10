Return-Path: <linux-integrity+bounces-7901-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE328CB39C1
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 18:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C978319CE11
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A4327201;
	Wed, 10 Dec 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Nc66g3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2B3271F4;
	Wed, 10 Dec 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765387274; cv=none; b=HGwOcz0/vL9zviUGw3huH39tm6X2m8ftzVpHvXtAOp6V5fsaic7KX4wxP1YwrZlZzmVsrQzntqKhUrs5MJvud4lmcI6k3AsPnzQzMjad6xZj8000JFXCPYiNjTXWQNvMFiJHddS0B43yhwyjv6zmS4Gv8pfJHzIsrh0iETjZcPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765387274; c=relaxed/simple;
	bh=kqsz75FRwe7BwNAXl/0a3oLZCU/8TrrYjPcsTX5SiOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZasiVQuuqh5d39y+H0gE0YiX+v5ADXc2wOsXjjcK2x2T5fTjFKpqyAW1T1xQTlz38XiJlxtUX3UQq2IvkZhzuBWO8kuZUtLtBi+W/+kUXsuv/2l3EGrQ+4uXZeZOuR5cFTrzl43kC8N1H2SXDlzs2BJckHRMjnS2bj3hs8inlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Nc66g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7421C4CEF1;
	Wed, 10 Dec 2025 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765387274;
	bh=kqsz75FRwe7BwNAXl/0a3oLZCU/8TrrYjPcsTX5SiOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4Nc66g394+zyWrBiPZ+M2804j0FS4MWmmHbb9ZBaGM+IYEnKNIv+5qR21dESz+KB
	 mXxBdimNvLcC9J+z2+019kP+mL2+8EkTo7y6nl1ZmC+vubJS9W01jVUZiOItFGbXmn
	 UDdUwEN28SNUdZfinZmgDdfWweqOVydxLedfzM1mhdqnfZIGy/MpAqg6PGO3JW+ADh
	 1P3/CTTy7lQ8iCoXTaxBq/IfZt6E+I4bUv4Da7z/20tCYgRQ4ZssN9i+oXpg82DhA/
	 +KSGXiRru/AOw7cF/jWI2obBeOwp+INbAw3g8qB5751CTPR+YFpbZSD3fW/CWBUG0/
	 +RG2U8GTygksw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: [PATCH v4 7/8] tpm: Send only one at most TPM2_GetRandom command
Date: Wed, 10 Dec 2025 19:20:25 +0200
Message-Id: <20251210172027.109938-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251210172027.109938-1-jarkko@kernel.org>
References: <20251210172027.109938-1-jarkko@kernel.org>
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
2.39.5


