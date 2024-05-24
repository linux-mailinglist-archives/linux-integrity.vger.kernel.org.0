Return-Path: <linux-integrity+bounces-2611-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41678CE5B4
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70771C21950
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D986ACC;
	Fri, 24 May 2024 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XGwty+Mf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F9586AC8;
	Fri, 24 May 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555993; cv=none; b=K1SCeml1SSuS2ISxBexcqmk4uukVs4uvs0o/KjwnRVsd5/6nbPtTQlMVujAsRKfhimh2pCUn+LJnHBrNqFTN8MglN0FLfkyJPv8VyVQUqAayhAkdQyPZ7iMXK3Dh8EB4kOQs7yXXQ1jQ81rd48GiPaLeLGmyWh/MsP8aA9aWN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555993; c=relaxed/simple;
	bh=rvVTN0lncwH8pAWfVinaaR/CVl2XFX34rDyINBofXs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9SQHsg1NQw6uGFn3iEa3SNGRYDyosKK1VhvqKyEFBXqk5yVG+eTzZpdJJmEcGlD0vTYnIKBqCyPu/qI93nYKoY8Z6St4PoAoGNY3ihTfHyx9dcH/uryvfWWJMzcSRi+IFp+deWZsP353k6dEnxFCbH1dxAfw9TzHwJPdkwt7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=XGwty+Mf; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555991;
	bh=rvVTN0lncwH8pAWfVinaaR/CVl2XFX34rDyINBofXs0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=XGwty+MfRWkYkPp147wjocWiFuGkOc5VNDa2qky29mqkWVfEGgAtaBSyTN6Pw+Bhs
	 kODhxiCNhOej/YFjPogRRWSVvliIFmZE59IMIp3E3gKNzmTnAf+/7DFiTl09RMbijf
	 7Bk8ugXbkKDfJtuOy7Eh+QmeoDyhpL2kcX3kcprw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E25341287771;
	Fri, 24 May 2024 09:06:31 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Rjq7w-wIagWP; Fri, 24 May 2024 09:06:31 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 65F931280355;
	Fri, 24 May 2024 09:06:31 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org
Subject: [PATCH 5/6] KEYS: trusted: implement counter/timer policy
Date: Fri, 24 May 2024 09:04:58 -0400
Message-Id: <20240524130459.21510-6-James.Bottomley@HansenPartnership.com>
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

This is actually a generic policy allowing a range of comparisons
against any value set in the TPM Clock, which includes things like the
reset count, a monotonic millisecond count and the restart count.  The
most useful comparison is against the millisecond count for expiring
keys.  However, you have to remember that currently Linux doesn't try
to sync the epoch timer with the TPM, so the expiration is actually
measured in how long the TPM itself has been powered on ... the TPM
timer doesn't count while the system is powered down.  The millisecond
counter is a u64 quantity found at offset 8 in the timer structure,
and the <= comparision operand is 9, so a policy set to expire after the
TPM has been up for 100 seconds would look like

0000016d00000000000f424000080009

Where 0x16d is the counter timer policy code and 0xf4240 is 100 000 in
hex.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 .../security/keys/trusted-encrypted.rst       | 29 +++++++++++++++
 include/linux/tpm.h                           |  1 +
 security/keys/trusted-keys/tpm2-policy.c      | 37 +++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index fbb41cf16f30..7abda48089d8 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -545,3 +545,32 @@ DCP Blob Format
 
 .. kernel-doc:: security/keys/trusted-keys/trusted_dcp.c
    :identifiers: struct dcp_blob_fmt
+
+Appendix
+--------
+
+TPM 2.0 Policies
+----------------
+
+The current TPM supports PCR lock policies as documented above and
+CounterTimer policies which can be used to create expiring keys.  One
+caveat with expiring keys is that the TPM millisecond counter does not
+update while a system is powered off and Linux does not sync the TPM
+millisecond count with its internal clock, so the best you can expire
+in is in terms of how long any given TPM has been powered on.  (FIXME:
+Linux should simply update the millisecond clock to the current number
+of seconds past the epoch on boot).
+
+A CounterTimer policy is expressed in terms of length and offset
+against the TPM clock structure (TPMS_TIME_INFO), which looks like the
+packed structure::
+
+    struct tpms_time_info {
+	    u64 uptime;       /* time in ms since last start or reset */
+	    u64 clock;        /* cumulative uptime in ms */
+	    u32 resetcount;   /* number of times the TPM has been reset */
+	    u32 restartcount; /* number of times the TPM has been restarted */
+	    u8  safe          /* time was safely loaded from NVRam */
+    };
+
+The usual comparison for expiring keys is against clock, at offset 8.
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 154efceec0a4..894e51a7fe3a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -291,6 +291,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
 	TPM2_CC_POLICY_AUTHVALUE	= 0x016B,
+	TPM2_CC_POLICY_COUNTER_TIMER	= 0x016D,
 	TPM2_CC_READ_PUBLIC		= 0x0173,
 	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index a731c10d9bba..c0508cb95923 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -63,6 +63,7 @@ static int tpm2_validate_policy(struct tpm2_policies *pols)
 
 	for (i = 0; i < pols->count; i++) {
 		switch (pols->code[i]) {
+		case TPM2_CC_POLICY_COUNTER_TIMER:
 		case TPM2_CC_POLICY_PCR:
 		case TPM2_CC_POLICY_AUTHVALUE:
 			break;
@@ -177,6 +178,7 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 		u8 *policy = pols->policies[i];
 		int len = pols->len[i];
 		u32 cmd = pols->code[i];
+		u8 digest[MAX_DIGEST_SIZE];
 		u8 code[4];
 		SHASH_DESC_ON_STACK(sdesc, tfm);
 
@@ -192,6 +194,19 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 		put_unaligned_be32(cmd, code);
 		crypto_shash_update(sdesc, code, 4);
 
+		/* commands that need special handling */
+		if (cmd == TPM2_CC_POLICY_COUNTER_TIMER) {
+			SHASH_DESC_ON_STACK(sdesc1, tfm);
+
+			sdesc1->tfm = tfm;
+
+			/* counter timer policies are double hashed */
+			crypto_shash_digest(sdesc1, policy, len,
+					    digest);
+			policy = digest;
+			len = *plen;
+		}
+
 		if (len)
 			crypto_shash_update(sdesc, policy, len);
 
@@ -302,6 +317,28 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols)
 				       pols->len[i] - pols->hash_size);
 			break;
 
+		case TPM2_CC_POLICY_COUNTER_TIMER: {
+			/*
+			 * the format of this is the last two u16
+			 * quantities are the offset and operation
+			 * respectively.  The rest is operandB which
+			 * must be zero padded in a hash digest
+			 */
+			u16 opb_len = pols->len[i] - 4;
+
+			if (opb_len > pols->hash_size)
+				return -EINVAL;
+
+			tpm_buf_append_u16(&buf, opb_len);
+			tpm_buf_append(&buf, pols->policies[i], opb_len);
+
+			/* offset and operand*/
+			tpm_buf_append(&buf, pols->policies[i] + opb_len, 4);
+			failure = "Counter Timer";
+
+			break;
+		}
+
 		default:
 			failure = "unknown policy";
 			if (pols->len[i])
-- 
2.35.3


