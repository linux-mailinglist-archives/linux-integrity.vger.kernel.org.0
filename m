Return-Path: <linux-integrity+bounces-7726-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B775C90AC3
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 03:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B89514E829C
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4D22BD033;
	Fri, 28 Nov 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrYAedE9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B225524C;
	Fri, 28 Nov 2025 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298472; cv=none; b=bi/spvuuiUA6fNs39um6yj2MULL+jGE7fYX3RFLY1Ri9LRZiKiih3P2rpn0i8AjXMYS7jnIrfwDWU8Lzlqp7KnJBE+SHGEeNlzQLhpDaQJgkwVEFdrP5BCBK+kprz4Wk428rfy10PuSqgannQJfW6/s/nbgobCAa2KfjOgoUQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298472; c=relaxed/simple;
	bh=2sk65LE1raMiUPZaVJ6CSZ+cwZCR1ikqTZm/0v9EiXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLQzl5o6TfrMowTiCjvN2kwKPOqacP/A6rZmXWlXxOpEvkmMYPCzlzRjAoOrEf9RQqn4EtH9RassKL3M5b+E+8yVvxyJ8Wvc3CYyBv+aGEmaghSGVIYtOu2sI1Widtsige/MWTRIIv5I+LwicAXu6tuqaNQoX31ngQABCdSBkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrYAedE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D34C4CEF8;
	Fri, 28 Nov 2025 02:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298472;
	bh=2sk65LE1raMiUPZaVJ6CSZ+cwZCR1ikqTZm/0v9EiXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hrYAedE9NT9rSV1WBFKNg/ibtYQcUfO3VKFTrV3inRxelrTAyeObKqYlhsnewo4+n
	 flwulsXy9Ds0ZjYE3w2GbepUeoZzMV/bFRW5cNC5B8pUEXfEPKrDL5g/OnxIdLjvUb
	 h3vHpxwlflB8oLB6u1UfCpWmM4CjAPfTpx2INIW5qRtTRWGMDbAJGM4Po/DKthUVE4
	 OxlEfboiAdYpgGSyqkYNE4QIriHvq2GrIxXSDFIvnD5pe0Br5SAuoqemwKvBqqhQXu
	 UXLUomCPbj2Rmp80m3nJMIAtR9Rfrx7vVai9gyOtzzOSXjtJH4PhLXRU1fbGDx36Ws
	 H/Qggo/cNklyg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 3/8] KEYS: trusted: Replace a redundant instance of tpm2_hash_map
Date: Fri, 28 Nov 2025 04:53:55 +0200
Message-ID: <20251128025402.4147024-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128025402.4147024-1-jarkko@kernel.org>
References: <20251128025402.4147024-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'trusted_tpm2' duplicates 'tpm2_hash_map' originally part of the TPN
driver, which is suboptimal.

Implement and export `tpm2_find_hash_alg()` in the driver, and substitute
the redundant code in 'trusted_tpm2' with a call to the new function.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v9:
- Improved the commit message a bit.
v8:
- Remove spurious tpm2_alg_to_crypto_id.
- Check return value of tpm2_find_hash_alg correctly in trusted_tpm2.c
  i.e, fail on "hash_alg < 0". Trusted keys were tested but I had my
  test harness misconfigured. I bisected the failure to this patch.
- The diff was not exactly minimal. Further optimize it.
v7:
- A new patch.
---
 drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++++-
 include/linux/tpm.h                       |  1 +
 security/keys/trusted-keys/trusted_tpm2.c | 23 ++++-------------------
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e298194883e8..a121c518ff6f 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -18,7 +18,7 @@ static bool disable_pcr_integrity;
 module_param(disable_pcr_integrity, bool, 0444);
 MODULE_PARM_DESC(disable_pcr_integrity, "Disable integrity protection of TPM2_PCR_Extend");
 
-static struct tpm2_hash tpm2_hash_map[] = {
+struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
@@ -26,6 +26,18 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
+int tpm2_find_hash_alg(unsigned int crypto_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++)
+		if (crypto_id == tpm2_hash_map[i].crypto_id)
+			return tpm2_hash_map[i].tpm_id;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(tpm2_find_hash_alg);
+
 int tpm2_get_timeouts(struct tpm_chip *chip)
 {
 	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 973458a38250..cbd3a70c0378 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -477,6 +477,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
+int tpm2_find_hash_alg(unsigned int crypto_id);
 
 static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 {
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c414a7006d78..4467e880ebd5 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -18,14 +18,6 @@
 
 #include "tpm2key.asn1.h"
 
-static struct tpm2_hash tpm2_hash_map[] = {
-	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
-	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
-	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
-	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
-};
-
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
 
 static int tpm2_key_encode(struct trusted_key_payload *payload,
@@ -244,20 +236,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	off_t offset = TPM_HEADER_SIZE;
 	struct tpm_buf buf, sized;
 	int blob_len = 0;
-	u32 hash;
+	int hash;
 	u32 flags;
-	int i;
 	int rc;
 
-	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
-		if (options->hash == tpm2_hash_map[i].crypto_id) {
-			hash = tpm2_hash_map[i].tpm_id;
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(tpm2_hash_map))
-		return -EINVAL;
+	hash = tpm2_find_hash_alg(options->hash);
+	if (hash < 0)
+		return hash;
 
 	if (!options->keyhandle)
 		return -EINVAL;
-- 
2.52.0


