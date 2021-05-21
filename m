Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30E638BAF7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 02:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhEUArB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 20:47:01 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:46950 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234062AbhEUArA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 20:47:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 865A712806BA;
        Thu, 20 May 2021 17:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621557938;
        bh=VvyxQjcDUACEkbKQIFQodsbnA7yfgHSn4PF/wgzsl7M=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=wXMUYvSi6LBvnR5iDghG4Dq5/XpougAmTajfW5xSxiGqgHTPlOj2ICECrp9g9oEJW
         qUrB9SH1tUWiKkvRGWaWFfJym2VFo1ho05gmw67S2l8kx7LFCJX7VNIQ14n+bZVAAZ
         6Ckn3ZKrH/Q6uG8Zw/DKuWYmE8xiFt5O8AyOCxAQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9fE2aTIOZXT1; Thu, 20 May 2021 17:45:38 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1000212806B1;
        Thu, 20 May 2021 17:45:38 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 3/4] security: keys: trusted: implement counter/timer policy
Date:   Thu, 20 May 2021 17:44:00 -0700
Message-Id: <20210521004401.4167-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
 .../security/keys/trusted-encrypted.rst       | 31 +++++++++++++-
 include/linux/tpm.h                           |  1 +
 security/keys/trusted-keys/tpm2-policy.c      | 42 +++++++++++++++++++
 security/keys/trusted-keys/trusted_tpm2.c     |  3 +-
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 883844c95e91..c40e38200c1e 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -346,7 +346,6 @@ Another new format 'enc32' has been defined in order to support encrypted keys
 with payload size of 32 bytes. This will initially be used for nvdimm security
 but may expand to other usages that require 32 bytes payload.
 
-
 TPM 2.0 ASN.1 Key Format
 ------------------------
 
@@ -420,3 +419,33 @@ string length.
 privkey is the binary representation of TPM2B_PUBLIC excluding the
 initial TPM2B header which can be reconstructed from the ASN.1 octed
 string length.
+
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
+            u64 uptime;       /* time in ms since last start or reset */
+	    u64 clock;        /* cumulative uptime in ms */
+	    u32 resetcount;   /* numer of times the TPM has been reset */
+	    u32 restartcount; /* number of times the TPM has been restarted */
+	    u8  safe          /* time was safely loaded from NVRam */
+    };
+
+The usual comparison for expiring keys is against clock, at offset 8.
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 298321fe07ee..85e167ae2c65 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -230,6 +230,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_POLICY_COUNTER_TIMER	= 0x016D,
 	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index bb28c864fa9b..21bfeb686287 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -65,6 +65,7 @@ static int tpm2_validate_policy(struct tpm2_policies *pols)
 
 	for (i = 0; i < pols->count; i++) {
 		switch (pols->code[i]) {
+		case TPM2_CC_POLICY_COUNTER_TIMER:
 		case TPM2_CC_POLICY_PCR:
 			break;
 		default:
@@ -168,6 +169,7 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 		u8 *policy = pols->policies[i];
 		int len = pols->len[i];
 		u32 cmd = pols->code[i];
+		u8 digest[MAX_DIGEST_SIZE];
 		u8 code[4];
 		SHASH_DESC_ON_STACK(sdesc, tfm);
 
@@ -183,6 +185,19 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
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
 		crypto_shash_update(sdesc, policy, len);
 
 		/* now output the intermediate to the policydigest */
@@ -339,8 +354,35 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 			tpm_buf_append(&buf, pols->policies[i],
 				       pols->len[i] - pols->hash_size);
 			break;
+
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
+			if (pols->len[i])
+				tpm_buf_append(&buf, pols->policies[i],
+					       pols->len[i]);
+
 			break;
 		}
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index afe9cc41885e..b7eb919de8ef 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -248,6 +248,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	u32 flags;
 	int i;
 	int rc;
+	static const int POLICY_SIZE = 2 * PAGE_SIZE;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
 		if (options->hash == tpm2_hash_map[i].crypto_id) {
@@ -272,7 +273,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			/* can't specify pcr and general policy */
 			return -EINVAL;
 
-		pols = kmalloc(sizeof(*pols) + len, GFP_KERNEL);
+		pols = kmalloc(POLICY_SIZE, GFP_KERNEL);
 		if (!pols)
 			return -ENOMEM;
 
-- 
2.26.2

