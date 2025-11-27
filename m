Return-Path: <linux-integrity+bounces-7711-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3382C90357
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBFE3A8D19
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 21:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD7320A01;
	Thu, 27 Nov 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5ihiDsV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6CA30AAB3;
	Thu, 27 Nov 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279725; cv=none; b=NWKucscHaem3uAKvUCvH1iFAtl1ki4L4MfwU5HehR7myNG1ehr451iQRY4mucQlYsKZb6WLj988WVDDhO2HJv6RFc6sTolhNvldHVPzQQqTn39re4PTdTK0dnCIm7rnuLJ8wJ1EbnQjnjMf62WrOy9nCm0IhjV8TlKan3LmPGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279725; c=relaxed/simple;
	bh=/gwjnabBAv2HMVTq2JSEzcn1XCy292GIKvUqSHr2PBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys9hTPPfx6hx4u2qbnRyILYMaW41fdwnOpVPPMWLaQi0aEjLmTdlrLFqwJUfmJTCvP5Z0fl9TxlDUamwzdaHZMRZFMYQmcLBCWSR4YbhVBo9OakC8fDwLExMP5PnRYM/loPQ+dfxBdBXim3ISe+r7h5OtwN1gsXPjvxX6RMlLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5ihiDsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30754C4CEF8;
	Thu, 27 Nov 2025 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279721;
	bh=/gwjnabBAv2HMVTq2JSEzcn1XCy292GIKvUqSHr2PBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5ihiDsVpP7XgvIwv7n8j4QyMhErFrqHII/+I/yB8ZeiOVMmM2fNDc93cEYooK1/m
	 H/3sXsy+wJzXNplsBhXIlSrxhp3FuLkcOGcs3QCfIbr31RwG6TPcnzW7lmWIjBn+0m
	 XGNkzHzITKOt1bUX6GgtrcFFjb1y2tUvXcLn6BQMKwYfT80nDQMsS8rzgF9yR0el8D
	 BBee33lcZe8EpEUPchnrWavYDuUh6Ff2+YLF/4hLN8JzHX2xN2MxWpUfqjcN27zXYP
	 olyxj8mMo2rsTVhNH2P1m+Y7JaqzDaeCAu/mEsLr9FVZS2mLXBd3II1tJSK5VrpeC5
	 OGMNFFPp6PJkg==
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
Subject: [PATCH v8 03/11] KEYS: trusted: remove redundant instance of tpm2_hash_map
Date: Thu, 27 Nov 2025 23:41:28 +0200
Message-ID: <20251127214138.3760029-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127214138.3760029-1-jarkko@kernel.org>
References: <20251127214138.3760029-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trusted keys duplicates tpm2_hash_map from TPM driver internals. Implement
and export `tpm2_find_hash_alg()` in order to address this glitch, and
replace redundant code block with a call this new function.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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
index 5b6ccf901623..dd502322f499 100644
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
index 0e9e043f728c..3d8f7d1ce2b8 100644
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
index 024be262702f..edd7b9d7e4dc 100644
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


