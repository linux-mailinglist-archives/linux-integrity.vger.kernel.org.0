Return-Path: <linux-integrity+bounces-2607-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79F8CE5A8
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE47B206AE
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF8586263;
	Fri, 24 May 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Z1TljHxi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313085C79;
	Fri, 24 May 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555920; cv=none; b=QcT47xwkddUuT0HwwY4zsQK6JH0ecDrTdlKkCLqIfonAssIb/cJHNUKq7kbR6WPuZ/rJF45Sb44ZQxmyZj+VsrFN3w5Se5ilaE4z/mKH5kqBDqDgXPRC9oS4SXE/XCY+ZS5uDLjceFRSWEa9TQ7hg4ZzfLZqOxdRyiA3jCRFi3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555920; c=relaxed/simple;
	bh=aL373wwlgd4ZaiyoFZN7sYh6ocZgOj1739e3PLiyorw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COpz7t29Twp52EJpXn25y4GCbqPzYPRsTFo91pk+MakP7qO+YBFRTzJwmTQO9zHuZZiNNcRW7Ur1OTjiZNOAVDBYvPZQQJSpN5bLbNPu2uR728Dd4rZrn33RvDtCIdAMt8AOQh92+w6DojvGtYIPjlINSWb87SigdwJb0tjtmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Z1TljHxi; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555915;
	bh=aL373wwlgd4ZaiyoFZN7sYh6ocZgOj1739e3PLiyorw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=Z1TljHxiICmeehaY7QweCnLisvKXTrFBReaOCtReylzdiRyVAV0bIcEtwKpQI9sIB
	 0T0uHtCjlhgtv9lGVkIbfHR2NRW5gU3DW8p058lbQjzu185JZaa4ASl4Ais/fJq7yH
	 obQdPnyO797I7GPeQSo5wPvrV56TuGekLIvaSHE4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9705B1287771;
	Fri, 24 May 2024 09:05:15 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id SD03Vbfux8or; Fri, 24 May 2024 09:05:15 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2578E1280355;
	Fri, 24 May 2024 09:05:15 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org
Subject: [PATCH 1/6] tpm: consolidate TPM to crypto hash algorithm conversion
Date: Fri, 24 May 2024 09:04:54 -0400
Message-Id: <20240524130459.21510-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux crypto and the TPM use different numeric algorithm identifiers
for hash (and other) functions.  The conversion array for this already
exists in two separate places.  The new policy sessions code would
have to add a third copy, so instead of increasing the duplication,
move the definition to a single consolidated place in tpm.h so the
policy code can use it as is.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c               |  8 ----
 include/linux/tpm.h                       | 52 ++++++++++++++++++++++-
 security/keys/trusted-keys/trusted_tpm2.c | 20 +--------
 3 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 0cdf892ec2a7..f4428e715dd8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -14,14 +14,6 @@
 #include "tpm.h"
 #include <crypto/hash_info.h>
 
-static struct tpm2_hash tpm2_hash_map[] = {
-	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
-	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
-	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
-	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
-};
-
 int tpm2_get_timeouts(struct tpm_chip *chip)
 {
 	/* Fixed timeouts for TPM2 */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index c17e4efbb2e5..07f532456a0c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -418,11 +418,61 @@ enum tpm2_session_attributes {
 	TPM2_SA_AUDIT			= BIT(7),
 };
 
-struct tpm2_hash {
+static const struct {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
+} tpm2_hash_map[] = {
+	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
+	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
+	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
+	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
+	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
+/**
+ * tpm2_crypto_to_alg() - convert a crypto hash to a TPM alg id
+ *
+ * @hash: the crypto subsystem view of the hash
+ *
+ * Return: TPM algorithm id or -1 if no mapping was found.
+ */
+static inline int tpm2_crypto_to_alg(int hash)
+{
+	int i;
+	int tpm_alg = -1;
+
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
+		if (hash == tpm2_hash_map[i].crypto_id) {
+			tpm_alg = tpm2_hash_map[i].tpm_id;
+			break;
+		}
+	}
+
+	return tpm_alg;
+}
+
+/**
+ * tpm2_alg_to_crypto() - convert a TPM alg id to a crypto hash
+ *
+ * @hash: the TPM alg id view of the hash
+ *
+ * Return: TPM algorithm id or -1 if no mapping was found.
+ */
+static inline int tpm2_alg_to_crypto(int hash)
+{
+	int i;
+	int crypto_hash = -1;
+
+	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
+		if (hash == tpm2_hash_map[i].tpm_id) {
+			crypto_hash = tpm2_hash_map[i].crypto_id;
+			break;
+		}
+	}
+
+	return crypto_hash;
+}
+
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
 int tpm_buf_init_sized(struct tpm_buf *buf);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index dfeec06301ce..94ff9ccae66e 100644
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
@@ -231,19 +223,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	off_t offset = TPM_HEADER_SIZE;
 	struct tpm_buf buf, sized;
 	int blob_len = 0;
-	u32 hash;
+	int hash = tpm2_crypto_to_alg(options->hash);
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
+	if (hash < 0)
 		return -EINVAL;
 
 	if (!options->keyhandle)
-- 
2.35.3


