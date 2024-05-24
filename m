Return-Path: <linux-integrity+bounces-2612-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C68CE5B8
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B85E1F21FE7
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFA86AC4;
	Fri, 24 May 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wks3LqLb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2586640;
	Fri, 24 May 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556017; cv=none; b=BqxJZ2A5rRACFB2BbE6sVQnUAoMZ07eVzjBhjNAWidWOW56+jsY9IRBFG62tyEviqlBG9PLMZf11IFmPfSMC8Xi4tDz2KApRta/699mI1xlHc69ck+dj9SZjvG12LvY6RBtfVeO9INq/84qDh9hEOV4PLvtCK0chuDF44jfQd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556017; c=relaxed/simple;
	bh=XvFXDbBsg0xnT5O9xyaNCyzYE7kQ/z3u8yxP4UjUM9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2KJwhQT7nmQuE9/pNJ5VuLFlWkKDxsUZ6pe7jdN00+O6lxtO5IItHZMVe7MowOhevXV9T2/7vAT2cdPuWGPzGo/L0S9VCylhp8tmQbMO1XvB54ybFANFbdDszBErlvjxgL1G32I7hJ6QhRxHOhcPJLxwUKWioLm6fJTDdl4glU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wks3LqLb; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716556014;
	bh=XvFXDbBsg0xnT5O9xyaNCyzYE7kQ/z3u8yxP4UjUM9Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=wks3LqLbplEN5Se9rAjHgd9CZeFCriSXG2SR3iV6aAe3r8NlZlZvm8Q8SMzfxpyi8
	 Wh2AXPHdOCZZHf1wCt+0jHkJjJSITRIbH0TiwqPjy1hAMmswLmmj6JpkDkaN0KJaYG
	 7RiSRD4dfmJIH1KUo9rcUIusOxL+GOl+M0pZp8io=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 99F0E1287771;
	Fri, 24 May 2024 09:06:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id aQ9nmV3C58WJ; Fri, 24 May 2024 09:06:54 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 12E631280355;
	Fri, 24 May 2024 09:06:54 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org
Subject: [PATCH 6/6] KEYS: trusted: add support for TPM keys with signed policy
Date: Fri, 24 May 2024 09:04:59 -0400
Message-Id: <20240524130459.21510-7-James.Bottomley@HansenPartnership.com>
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

Signed policy allows key policies to be modified after the TPM key is
created, provided the new policy is signed with a private key whose
public part is encoded into the initial policy.  How this works is
described in

https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html

Since this means that the key structure now contains public keys and
signatures, the maximum blob size has to be expanded simply to
accommodate a key with several policies.  The code assumes (as does
all other signed policy engines) that the first policy is the most
likely one to succeed, so it tries all the available signed policies
in first to last order and loads the key when one of them succeeds.

This code allows the kernel to process signed policy keys correctly,
it does not allow the kernel to create them.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-sessions.c          |   6 +
 include/keys/trusted-type.h               |   3 +-
 include/linux/tpm.h                       |   6 +
 security/keys/trusted-keys/tpm2-policy.c  | 473 ++++++++++++++++------
 security/keys/trusted-keys/tpm2-policy.h  |  19 +-
 security/keys/trusted-keys/tpm2key.asn1   |  12 +-
 security/keys/trusted-keys/trusted_tpm2.c |  63 +--
 7 files changed, 434 insertions(+), 148 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 63c175b2165c..c2b73283c46f 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1365,3 +1365,9 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
+
+struct crypto_shash *tpm2_get_policy_hash(struct tpm_chip *chip)
+{
+	return chip->auth->tfm;
+}
+EXPORT_SYMBOL(tpm2_get_policy_hash);
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 5d1d481a8a19..a6999800055e 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -19,11 +19,12 @@
 
 #define MIN_KEY_SIZE			32
 #define MAX_KEY_SIZE			128
-#define MAX_BLOB_SIZE			512
+#define MAX_BLOB_SIZE			4096
 #define MAX_PCRINFO_SIZE		128
 #define MAX_DIGEST_SIZE			64
 
 #define TPM2_MAX_POLICIES		16
+#define TPM2_MAX_AUTHS			8
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 894e51a7fe3a..09f14482675b 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -290,6 +290,8 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_LOAD_EXTERNAL		= 0x0167,
+	TPM2_CC_POLICY_AUTHORIZE	= 0x016A,
 	TPM2_CC_POLICY_AUTHVALUE	= 0x016B,
 	TPM2_CC_POLICY_COUNTER_TIMER	= 0x016D,
 	TPM2_CC_READ_PUBLIC		= 0x0173,
@@ -299,14 +301,17 @@ enum tpm2_command_codes {
 	TPM2_CC_GET_RANDOM	        = 0x017B,
 	TPM2_CC_PCR_READ	        = 0x017E,
 	TPM2_CC_POLICY_PCR		= 0x017F,
+	TPM2_CC_POLICY_RESTART		= 0x0180,
 	TPM2_CC_PCR_EXTEND	        = 0x0182,
 	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
 	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
+	TPM2_CC_POLICY_GET_DIGEST	= 0x0189,
 	TPM2_CC_CREATE_LOADED           = 0x0191,
 	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
 };
 
 enum tpm2_permanent_handles {
+	TPM2_RH_OWNER		= 0x40000001,
 	TPM2_RH_NULL		= 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
@@ -578,6 +583,7 @@ static inline void tpm_buf_append_empty_auth(struct tpm_buf *buf, u32 handle)
 
 int tpm2_start_auth_session(struct tpm_chip *chip);
 int tpm2_start_policy_session(struct tpm_chip *chip, u32 *handle, u8 hash);
+struct crypto_shash *tpm2_get_policy_hash(struct tpm_chip *chip);
 void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u32 handle, u8 *name);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index c0508cb95923..f9ee57fed8fe 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -28,13 +28,28 @@ int tpm2_key_code(void *context, size_t hdrlen,
 	u32 code = 0;
 	const u8 *v = value;
 	int i;
+	u8 a = ctx->auth_policies;
 
 	for (i = 0; i < vlen; i++) {
 		code <<= 8;
 		code |= v[i];
 	}
 
-	ctx->policy_code[ctx->policy_count] = code;
+	ctx->policy_code[a][ctx->policy_count[a]] = code;
+
+	return 0;
+}
+
+int tpm2_pol_seq(void *context, size_t hdrlen,
+		 unsigned char tag,
+		 const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->auth_policies++;
+
+	if (ctx->auth_policies > TPM2_MAX_AUTHS)
+		return -EINVAL;
 
 	return 0;
 }
@@ -44,9 +59,15 @@ int tpm2_key_policy(void *context, size_t hdrlen,
 		  const void *value, size_t vlen)
 {
 	struct tpm2_key_context *ctx = context;
+	u8 a = ctx->auth_policies;
+	u8 policy_count = ctx->policy_count[a]++;
+
+	if (policy_count >= TPM2_MAX_POLICIES)
+		return -EINVAL;
 
-	ctx->policies[ctx->policy_count] = value;
-	ctx->policy_len[ctx->policy_count++] = vlen;
+	ctx->policies[a][policy_count] = value;
+	ctx->policy_len[a][policy_count] = vlen;
+	ctx->policy_tot_len += vlen;
 
 	return 0;
 }
@@ -56,21 +77,24 @@ int tpm2_key_policy(void *context, size_t hdrlen,
  */
 static int tpm2_validate_policy(struct tpm2_policies *pols)
 {
-	int i;
+	int i, j;
 
-	if (pols->count == 0)
+	if (pols->auths == 0)
 		return 0;
 
-	for (i = 0; i < pols->count; i++) {
-		switch (pols->code[i]) {
-		case TPM2_CC_POLICY_COUNTER_TIMER:
-		case TPM2_CC_POLICY_PCR:
-		case TPM2_CC_POLICY_AUTHVALUE:
-			break;
-		default:
-			pr_info("tpm2 policy 0x%x is unsupported\n",
-				pols->code[i]);
+	for (i = 0; i < pols->auths; i++) {
+		for (j = 0; j < pols->count[i]; j++) {
+			switch (pols->code[i][j]) {
+			case TPM2_CC_POLICY_COUNTER_TIMER:
+			case TPM2_CC_POLICY_PCR:
+			case TPM2_CC_POLICY_AUTHVALUE:
+			case TPM2_CC_POLICY_AUTHORIZE:
+				break;
+			default:
+				pr_info("tpm2 policy 0x%x is unsupported\n",
+					pols->code[i][j]);
 			return -EINVAL;
+			}
 		}
 	}
 
@@ -89,36 +113,35 @@ static int tpm2_validate_policy(struct tpm2_policies *pols)
 int tpm2_key_policy_process(struct tpm2_key_context *ctx,
 			    struct trusted_key_payload *payload)
 {
-	int tot_len = 0;
 	u8 *buf;
-	int i, ret, len = 0;
+	int i, j, ret, len = 0;
 	struct tpm2_policies *pols;
 	u16 name_alg;
 
-	if (ctx->policy_count == 0)
+	if (ctx->policy_tot_len == 0)
 		return 0;
 
-	for (i = 0; i < ctx->policy_count; i++)
-		tot_len += ctx->policy_len[i];
-	tot_len += sizeof(*pols);
-
-	pols = kmalloc(tot_len, GFP_KERNEL);
+	pols = kmalloc(ctx->policy_tot_len + sizeof(*pols), GFP_KERNEL);
 	if (!pols)
 		return -ENOMEM;
 
 	payload->policies = pols;
 	buf = (u8 *)(pols + 1);
 
-	for (i = 0; i < ctx->policy_count; i++) {
-		pols->policies[i] = &buf[len];
-		pols->len[i] = ctx->policy_len[i];
-		pols->code[i] = ctx->policy_code[i];
-		if (pols->len[i])
-			memcpy(pols->policies[i], ctx->policies[i],
-			       ctx->policy_len[i]);
-		len += ctx->policy_len[i];
+	for (i = 0; i < ctx->auth_policies; i++) {
+		for (j = 0; j < ctx->policy_count[i]; j++) {
+			pols->policies[i][j] = &buf[len];
+			pols->len[i][j] = ctx->policy_len[i][j];
+			pols->code[i][j] = ctx->policy_code[i][j];
+			if (pols->len[i][j])
+				memcpy(pols->policies[i][j],
+				       ctx->policies[i][j],
+				       ctx->policy_len[i][j]);
+			len += ctx->policy_len[i][j];
+		}
+		pols->count[i] = ctx->policy_count[i];
 	}
-	pols->count = ctx->policy_count;
+	pols->auths = ctx->auth_policies;
 
 	ret = tpm2_validate_policy(pols);
 	if (ret)
@@ -148,7 +171,7 @@ int tpm2_key_policy_process(struct tpm2_key_context *ctx,
 int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 				u32 hash, u8 *policydigest, u32 *plen)
 {
-	int i;
+	int i, j;
 	struct crypto_shash *tfm;
 	int rc;
 
@@ -174,45 +197,47 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 	/* policy digests always start out all zeros */
 	memset(policydigest, 0, rc);
 
-	for (i = 0; i < pols->count; i++) {
-		u8 *policy = pols->policies[i];
-		int len = pols->len[i];
-		u32 cmd = pols->code[i];
-		u8 digest[MAX_DIGEST_SIZE];
-		u8 code[4];
-		SHASH_DESC_ON_STACK(sdesc, tfm);
+	for (i = 0; i < pols->auths; i++) {
+		for (j = 0; j < pols->count[i]; j++) {
+			u8 *policy = pols->policies[i][j];
+			int len = pols->len[i][j];
+			u32 cmd = pols->code[i][j];
+			u8 digest[MAX_DIGEST_SIZE];
+			u8 code[4];
+			SHASH_DESC_ON_STACK(sdesc, tfm);
 
-		sdesc->tfm = tfm;
-		rc = crypto_shash_init(sdesc);
-		if (rc)
-			goto err;
+			sdesc->tfm = tfm;
+			rc = crypto_shash_init(sdesc);
+			if (rc)
+				goto err;
 
-		/* first hash the previous digest */
-		crypto_shash_update(sdesc, policydigest, *plen);
+			/* first hash the previous digest */
+			crypto_shash_update(sdesc, policydigest, *plen);
 
-		/* then hash the command code */
-		put_unaligned_be32(cmd, code);
-		crypto_shash_update(sdesc, code, 4);
+			/* then hash the command code */
+			put_unaligned_be32(cmd, code);
+			crypto_shash_update(sdesc, code, 4);
 
-		/* commands that need special handling */
-		if (cmd == TPM2_CC_POLICY_COUNTER_TIMER) {
-			SHASH_DESC_ON_STACK(sdesc1, tfm);
+			/* commands that need special handling */
+			if (cmd == TPM2_CC_POLICY_COUNTER_TIMER) {
+				SHASH_DESC_ON_STACK(sdesc1, tfm);
 
-			sdesc1->tfm = tfm;
+				sdesc1->tfm = tfm;
 
-			/* counter timer policies are double hashed */
-			crypto_shash_digest(sdesc1, policy, len,
-					    digest);
-			policy = digest;
-			len = *plen;
-		}
+				/* counter timer policies are double hashed */
+				crypto_shash_digest(sdesc1, policy, len,
+						    digest);
+				policy = digest;
+				len = *plen;
+			}
 
-		if (len)
-			crypto_shash_update(sdesc, policy, len);
+			if (len)
+				crypto_shash_update(sdesc, policy, len);
 
-		/* now output the intermediate to the policydigest */
-		crypto_shash_final(sdesc, policydigest);
+			/* now output the intermediate to the policydigest */
+			crypto_shash_final(sdesc, policydigest);
 
+		}
 	}
 	rc = 0;
 
@@ -228,41 +253,45 @@ int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len)
 	u8 *work = buf + SCRATCH_SIZE;
 	u8 *ptr;
 	u8 *end_work = work + SCRATCH_SIZE;
-	int i, ret;
+	int i, j, ret;
 
 	if (!buf)
 		return -ENOMEM;
 
-	for (i = 0; i < pols->count; i++) {
-		u8 *seq, *tag;
-		u32 cmd = pols->code[i];
+	for (i = 0; i < pols->auths; i++) {
+		for (j = 0; j < pols->count[i]; j++) {
+			u8 *seq, *tag;
+			u32 cmd = pols->code[i][j];
 
-		if (WARN(work - buf + 14 + pols->len[i] > 2 * SCRATCH_SIZE,
-			 "BUG: scratch buffer is too small"))
-			return -EINVAL;
+			if (WARN(work - buf + 14 + pols->len[i][j] >
+				 2 * SCRATCH_SIZE,
+				 "BUG: scratch buffer is too small"))
+				return -EINVAL;
 
-		work = asn1_encode_sequence(work, end_work, NULL, -1);
-		seq = work;
+			work = asn1_encode_sequence(work, end_work, NULL, -1);
+			seq = work;
 
-		work = asn1_encode_tag(work, end_work, 0, NULL, -1);
-		tag = work;
+			work = asn1_encode_tag(work, end_work, 0, NULL, -1);
+			tag = work;
 
-		work = asn1_encode_integer(work, end_work, cmd);
-		asn1_encode_tag(tag, end_work, 0, NULL, work - tag);
+			work = asn1_encode_integer(work, end_work, cmd);
+			asn1_encode_tag(tag, end_work, 0, NULL, work - tag);
 
-		work = asn1_encode_tag(work, end_work, 1, NULL, -1);
-		tag = work;
+			work = asn1_encode_tag(work, end_work, 1, NULL, -1);
+			tag = work;
 
-		work = asn1_encode_octet_string(work, end_work,
-						pols->policies[i],
-						pols->len[i]);
+			work = asn1_encode_octet_string(work, end_work,
+							pols->policies[i][j],
+							pols->len[i][j]);
 
-		asn1_encode_tag(tag, end_work, 1, NULL, work - tag);
+			asn1_encode_tag(tag, end_work, 1, NULL, work - tag);
 
-		seq = asn1_encode_sequence(seq, end_work, NULL, work - seq);
-		if (IS_ERR(seq)) {
-			ret = PTR_ERR(seq);
-			goto err;
+			seq = asn1_encode_sequence(seq, end_work, NULL,
+						   work - seq);
+			if (IS_ERR(seq)) {
+				ret = PTR_ERR(seq);
+				goto err;
+			}
 		}
 	}
 	ptr = asn1_encode_sequence(buf, buf + SCRATCH_SIZE, buf + PAGE_SIZE,
@@ -282,18 +311,131 @@ int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len)
 	return ret;
 }
 
-int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols)
+static int tpm2_policy_restart(struct tpm_chip *chip, u32 handle)
 {
-	int i, rc;
-	u32 handle;
-	const char *failure;
+	struct tpm_buf buf;
+	int rc;
 
-	rc = tpm2_start_policy_session(chip, &handle, pols->hash);
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_POLICY_RESTART);
+	if (rc)
+		return rc;
+
+	tpm_buf_append_u32(&buf, handle);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "restarting policy");
+	tpm_buf_destroy(&buf);
+	if (rc) {
+		pr_notice("TPM policy restart failed, rc=%d\n", rc);
+		return -EPERM;
+	}
+	return 0;
+}
+
+static int tpm2_policy_gettkhash(struct tpm_chip *chip, u8 *pubkey, u8 *nonce,
+				 u8 *signature, int siglen,
+				 u32 handle, u8 **hash, u8 **name,
+				 u8 **ticket)
+{
+	struct tpm_buf buf;
+	int rc;
+	int len;
+	u32 sigkey;
+	off_t offset;
+	SHASH_DESC_ON_STACK(sdesc, tpm2_get_policy_hash(chip));
+
+	sdesc->tfm = tpm2_get_policy_hash(chip);
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_POLICY_GET_DIGEST);
 	if (rc)
 		return rc;
 
-	for (i = 0; i < pols->count; i++) {
-		u32 cmd = pols->code[i];
+	tpm_buf_append_u32(&buf, handle);
+
+	rc = tpm_transmit_cmd(chip, &buf, 0, "getting policy hash");
+	if (rc)
+		goto out;
+	len = get_unaligned_be16(&buf.data[TPM_HEADER_SIZE]) + 2;
+	rc = -ENOMEM;
+	*hash = kmalloc(len, GFP_KERNEL);
+	if (!*hash)
+		goto out;
+	memcpy(*hash, &buf.data[TPM_HEADER_SIZE], len);
+
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_LOAD_EXTERNAL);
+
+	/* empty sensitive */
+	tpm_buf_append_u16(&buf, 0);
+	/* TPM2B_PUBLIC */
+	len = get_unaligned_be16(pubkey) + 2;
+	tpm_buf_append(&buf, pubkey, len);
+	/* hierarchy (use null because never a password) */
+	tpm_buf_append_u32(&buf, TPM2_RH_OWNER);
+
+	rc = tpm_transmit_cmd(chip, &buf, 4, "loading external key");
+	if (rc)
+		goto out;
+
+	offset = TPM_HEADER_SIZE;
+	sigkey = tpm_buf_read_u32(&buf, &offset);
+	len = get_unaligned_be16(&buf.data[offset]) + 2;
+	*name = kmalloc(len, GFP_KERNEL);
+	if (!*name) {
+		tpm2_flush_context(chip, sigkey);
+		rc = -ENOMEM;
+		goto out;
+	}
+	memcpy(*name, &buf.data[offset], len);
+
+	tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_VERIFY_SIGNATURE);
+	/* handle of public key to verify with */
+	tpm_buf_append_u32(&buf, sigkey);
+	/* digest hash(policy||nonce) */
+	len = get_unaligned_be16(*hash);
+	tpm_buf_append_u16(&buf, len);
+	/* now compute the signed data which is hash(policy||nonce) */
+	crypto_shash_init(sdesc);
+	len = get_unaligned_be16(*hash); /* better be the tfm hash size */
+	crypto_shash_update(sdesc, *hash + 2, len);
+	len = get_unaligned_be16(nonce);
+	crypto_shash_update(sdesc, nonce + 2, len);
+	crypto_shash_final(sdesc, &buf.data[buf.length]);
+	buf.length += len;
+	/* signature */
+	tpm_buf_append(&buf, signature, siglen);
+
+	rc = tpm_transmit_cmd(chip, &buf, 4, "verifying signature");
+	tpm2_flush_context(chip, sigkey);
+	if (rc)
+		goto out;
+
+	len = tpm_buf_length(&buf) - TPM_HEADER_SIZE;
+	*ticket = kmalloc(len, GFP_KERNEL);
+	if (!*ticket) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	memcpy(*ticket, &buf.data[TPM_HEADER_SIZE], len);
+
+ out:
+	if (rc) {
+		kfree(*hash);
+		*hash = NULL;
+		kfree(*name);
+		*name = NULL;
+	}
+	tpm_buf_destroy(&buf);
+	return rc;
+}
+
+
+static int tpm2_try_policy(struct tpm_chip *chip, struct tpm2_policies *pols,
+			   u32 handle, int p)
+{
+	int i, rc;
+	const char *failure;
+
+	for (i = 0; i < pols->count[p]; i++) {
+		u32 cmd = pols->code[p][i];
 		struct tpm_buf buf;
 
 		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, cmd);
@@ -311,10 +453,11 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols)
 			 * policy command
 			 */
 			tpm_buf_append_u16(&buf, pols->hash_size);
-			tpm_buf_append(&buf, pols->policies[i] + pols->len[i] -
+			tpm_buf_append(&buf, pols->policies[p][i]
+				       + pols->len[p][i] -
 				       pols->hash_size, pols->hash_size);
-			tpm_buf_append(&buf, pols->policies[i],
-				       pols->len[i] - pols->hash_size);
+			tpm_buf_append(&buf, pols->policies[p][i],
+				       pols->len[p][i] - pols->hash_size);
 			break;
 
 		case TPM2_CC_POLICY_COUNTER_TIMER: {
@@ -324,26 +467,82 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols)
 			 * respectively.  The rest is operandB which
 			 * must be zero padded in a hash digest
 			 */
-			u16 opb_len = pols->len[i] - 4;
+			u16 opb_len = pols->len[p][i] - 4;
 
 			if (opb_len > pols->hash_size)
 				return -EINVAL;
 
 			tpm_buf_append_u16(&buf, opb_len);
-			tpm_buf_append(&buf, pols->policies[i], opb_len);
+			tpm_buf_append(&buf, pols->policies[p][i], opb_len);
 
 			/* offset and operand*/
-			tpm_buf_append(&buf, pols->policies[i] + opb_len, 4);
+			tpm_buf_append(&buf, pols->policies[p][i] + opb_len, 4);
 			failure = "Counter Timer";
 
 			break;
 		}
+		case TPM2_CC_POLICY_AUTHORIZE: {
+			u8 *pubkey = pols->policies[p][i];
+			u8 *nonce;
+			u8 *signature;
+			u8 *ticket = NULL;
+			u8 *hash = NULL;
+			u8 *name = NULL;
+			int len, siglen;
+			const int maxlen = pols->len[p][i];
+
+			if (i == 0)
+				/*
+				 * If this is the first policy then skip
+				 * because we should already have executed
+				 * a successful PolicyAuthorize before getting
+				 * here
+				 */
+				continue;
+
+			len = get_unaligned_be16(pubkey);
+			if (len + 2 > maxlen) {
+				failure = "malformed policy";
+				break;
+			}
+			nonce = pubkey + len + 2;
+			len = get_unaligned_be16(nonce);
+			if (len + 2 > maxlen) {
+				failure = "malformed policy";
+				break;
+			}
+			signature = nonce + len + 2;
+			siglen = pubkey + maxlen - signature;
+			failure = "policy authorize";
+			rc = tpm2_policy_gettkhash(chip, pubkey, nonce,
+						   signature, siglen,
+						   handle, &hash,
+						   &name, &ticket);
+			if (rc)
+				break;
+			len = get_unaligned_be16(hash);
+			tpm_buf_append(&buf, hash, len + 2);
+			kfree(hash);
+
+			len = get_unaligned_be16(nonce);
+			tpm_buf_append(&buf, nonce, len + 2);
+
+			len = get_unaligned_be16(name);
+			tpm_buf_append(&buf, name, len + 2);
+			kfree(name);
+
+			len = get_unaligned_be16(ticket + 6) + 8;
+			tpm_buf_append(&buf, ticket, len);
+			kfree(ticket);
+
+			break;
+		}
 
 		default:
 			failure = "unknown policy";
-			if (pols->len[i])
-				tpm_buf_append(&buf, pols->policies[i],
-					       pols->len[i]);
+			if (pols->len[p][i])
+				tpm_buf_append(&buf, pols->policies[p][i],
+					       pols->len[p][i]);
 
 			break;
 		}
@@ -353,14 +552,62 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols)
 		if (rc) {
 			pr_notice("TPM policy %s failed, rc=%d\n",
 				  failure, rc);
-			tpm2_end_auth_session(chip);
-			return -EPERM;
+			return rc;
 		}
 	}
-
 	return 0;
 }
 
+int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols)
+{
+	int rc;
+	u32 handle;
+
+	if (pols->code[0][0] == TPM2_CC_POLICY_AUTHORIZE &&
+	    pols->auths == 1) {
+		pr_notice("TPM Key requires signed policies but has none\n");
+		return -EINVAL;
+	}
+
+	rc = tpm2_start_policy_session(chip, &handle, pols->hash);
+	if (rc)
+		return rc;
+
+	if (pols->code[0][0] == TPM2_CC_POLICY_AUTHORIZE) {
+		int p;
+
+		for (p = 1; p < pols->auths; p++) {
+			if (p != 1) {
+				/* restart policy if looping */
+				rc = tpm2_policy_restart(chip, handle);
+				if (rc)
+					goto out;
+			}
+
+			rc = tpm2_try_policy(chip, pols, handle, p);
+			if (rc) {
+				pr_notice("TPM signed policy %d failed\n", p);
+			} else {
+				pr_notice("TPM signed policy %d succeeded\n",
+					  p);
+				break;
+			}
+		}
+		if (rc)
+			/* no signed policies succeeded */
+			goto out;
+	}
+
+	rc = tpm2_try_policy(chip, pols, handle, 0);
+ out:
+	if (rc) {
+		rc = -EPERM;
+		tpm2_end_auth_session(chip);
+	}
+
+	return rc;
+}
+
 int tpm2_parse_policies(struct tpm2_policies **ppols, char *str)
 {
 	struct tpm2_policies *pols;
@@ -379,22 +626,22 @@ int tpm2_parse_policies(struct tpm2_policies **ppols, char *str)
 		if (*p == '\0' || *p == '\n')
 			continue;
 
-		pols->len[i] = strlen(p)/2;
-		if (pols->len[i] > left) {
+		pols->len[0][i] = strlen(p)/2;
+		if (pols->len[0][i] > left) {
 			res = -E2BIG;
 			goto err;
 		}
 
-		res = hex2bin(ptr, p, pols->len[i]);
+		res = hex2bin(ptr, p, pols->len[0][i]);
 		if (res)
 			goto err;
 
 		/* get command code and skip past */
-		pols->code[i] = get_unaligned_be32(ptr);
-		pols->policies[i] = ptr + 4;
-		ptr += pols->len[i];
-		left -= pols->len[i];
-		pols->len[i] -= 4;
+		pols->code[0][i] = get_unaligned_be32(ptr);
+		pols->policies[0][i] = ptr + 4;
+		ptr += pols->len[0][i];
+		left -= pols->len[0][i];
+		pols->len[0][i] -= 4;
 
 		/*
 		 * FIXME: this does leave the code embedded in dead
@@ -404,7 +651,7 @@ int tpm2_parse_policies(struct tpm2_policies **ppols, char *str)
 		i++;
 	}
 
-	pols->count = i;
+	pols->count[0] = i;
 	*ppols = pols;
 
 	return 0;
diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/trusted-keys/tpm2-policy.h
index 8ddf235b3fec..da0ab99078b8 100644
--- a/security/keys/trusted-keys/tpm2-policy.h
+++ b/security/keys/trusted-keys/tpm2-policy.h
@@ -6,17 +6,20 @@ struct tpm2_key_context {
 	u32 pub_len;
 	const u8 *priv;
 	u32 priv_len;
-	const u8 *policies[TPM2_MAX_POLICIES];
-	u32 policy_code[TPM2_MAX_POLICIES];
-	u16 policy_len[TPM2_MAX_POLICIES];
-	u8 policy_count;
+	const u8 *policies[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
+	u32 policy_code[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
+	u16 policy_len[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
+	u8 policy_count[TPM2_MAX_AUTHS];
+	u8 auth_policies;
+	int policy_tot_len;
 };
 
 struct tpm2_policies {
-	u32 code[TPM2_MAX_POLICIES];
-	u8 *policies[TPM2_MAX_POLICIES];
-	u16 len[TPM2_MAX_POLICIES];
-	u8 count;
+	u32 code[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
+	u8 *policies[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
+	u16 len[TPM2_MAX_AUTHS][TPM2_MAX_POLICIES];
+	u8 count[TPM2_MAX_AUTHS];
+	u8 auths;
 	int hash;		/* crypto not TPM hash algorithm */
 	u16 hash_size;
 };
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
index 1684bd8f725e..c5a68b3e354f 100644
--- a/security/keys/trusted-keys/tpm2key.asn1
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -5,12 +5,13 @@
 ---       However, the Linux asn.1 parser doesn't understand
 ---       [2] EXPLICIT SEQUENCE OF OPTIONAL
 ---       So there's an extra intermediate TPMPolicySequence
----       definition to work around this
+---       and TPMAuthPolicySequence definitions to work around this
 
 TPMKey ::= SEQUENCE {
 	type		OBJECT IDENTIFIER ({tpm2_key_type}),
 	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
-	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL,
+	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL ({tpm2_pol_seq}),
+	authPolicy	[3] EXPLICIT TPMAuthPolicySequence OPTIONAL,
 	parent		INTEGER ({tpm2_key_parent}),
 	pubkey		OCTET STRING ({tpm2_key_pub}),
 	privkey		OCTET STRING ({tpm2_key_priv})
@@ -22,3 +23,10 @@ TPMPolicy ::= SEQUENCE {
 	commandCode		[0] EXPLICIT INTEGER ({tpm2_key_code}),
 	commandPolicy		[1] EXPLICIT OCTET STRING ({tpm2_key_policy})
 	}
+
+TPMAuthPolicySequence ::= SEQUENCE OF TPMAuthPolicy ({tpm2_pol_seq})
+
+TPMAuthPolicy ::= SEQUENCE {
+	name		[0] EXPLICIT UTF8String OPTIONAL,
+	policy		[1] EXPLICIT TPMPolicySequence
+	}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 64c922bbc36c..e2d937e44274 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -98,38 +98,45 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 			   u8 **buf)
 {
 	int ret;
-	struct tpm2_key_context ctx;
+	struct tpm2_key_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	u8 *blob;
 
-	memset(&ctx, 0, sizeof(ctx));
+	if (!ctx)
+		return -ENOMEM;
 
-	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
+	ret = asn1_ber_decoder(&tpm2key_decoder, ctx, payload->blob,
 			       payload->blob_len);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
-		return -EINVAL;
+	if (ctx->priv_len + ctx->pub_len > MAX_BLOB_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
-	if (!blob)
-		return -ENOMEM;
+	blob = kmalloc(ctx->priv_len + ctx->pub_len + 4, GFP_KERNEL);
+	if (!blob) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	ret = tpm2_key_policy_process(&ctx, payload);
+	ret = tpm2_key_policy_process(ctx, payload);
 	if (ret) {
 		kfree(blob);
-		return ret;
+		goto out;
 	}
 
 	*buf = blob;
-	options->keyhandle = ctx.parent;
+	options->keyhandle = ctx->parent;
 
-	memcpy(blob, ctx.priv, ctx.priv_len);
-	blob += ctx.priv_len;
+	memcpy(blob, ctx->priv, ctx->priv_len);
+	blob += ctx->priv_len;
 
-	memcpy(blob, ctx.pub, ctx.pub_len);
+	memcpy(blob, ctx->pub, ctx->pub_len);
 
-	return 0;
+ out:
+	kfree(ctx);
+	return ret;
 }
 
 int tpm2_key_parent(void *context, size_t hdrlen,
@@ -264,7 +271,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		pols = kmalloc(POLICY_SIZE, GFP_KERNEL);
 		if (!pols)
 			return -ENOMEM;
-		pols->count = 0;
+		pols->count[0] = 0;
+		pols->auths = 1;
 		payload->policies = pols;
 		scratch = (u8 *)(pols + 1);
 	}
@@ -275,10 +283,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		/* 4 array len */
 		const int len = 4 + options->pcrinfo_len;
 
-		i = pols->count++;
-		pols->len[i] = len;
-		pols->policies[i] = scratch;
-		pols->code[i] = TPM2_CC_POLICY_PCR;
+		i = pols->count[0]++;
+		pols->len[0][i] = len;
+		pols->policies[0][i] = scratch;
+		pols->code[0][i] = TPM2_CC_POLICY_PCR;
 
 		/* only a single TPMS_PCR_SELECTION */
 		put_unaligned_be32(1, &scratch[0]);
@@ -300,11 +308,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		int i;
 
 		pols = payload->policies;
-		i = pols->count++;
+		i = pols->count[0]++;
 
 		/* the TPM2_PolicyPassword command has no payload */
-		pols->len[i] = 0;
-		pols->code[i] = TPM2_CC_POLICY_AUTHVALUE;
+		pols->len[0][i] = 0;
+		pols->code[0][i] = TPM2_CC_POLICY_AUTHVALUE;
 	}
 
 	if (payload->policies) {
@@ -685,6 +693,13 @@ int __weak tpm2_key_code(void *context, size_t hdrlen,
 	return -EINVAL;
 }
 
+int __weak tpm2_pol_seq(void *context, size_t hdrlen,
+			unsigned char tag,
+			const void *value, size_t vlen)
+{
+	return -EINVAL;
+}
+
 int __weak tpm2_key_policy(void *context, size_t hdrlen,
 		  unsigned char tag,
 		  const void *value, size_t vlen)
-- 
2.35.3


