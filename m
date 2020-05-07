Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF21C9F10
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 01:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEGXQe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 19:16:34 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33604 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgEGXQe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 19:16:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0C6288EE268;
        Thu,  7 May 2020 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1588893394;
        bh=Vq4fJAR4c3n+7/s91qY+VIDyQxaRyUpDsyF2fK3Q/lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgFxpiZ42tJn3dM/OG+DSskaCH1Wmp/BjSemtmZ01mOuaIjzuMjaL2bNetQ24FD7x
         P0se1cELArLiFqCViCDkY9WTMYu87ohd9sUJvIC1xh5F39maGLTS6ghAdR3G7fcya6
         DGX4C1DsQlLsxxY3u6Rc+dHuPMGo6B4QBQ7jvbSk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id byLDFkJpnzbo; Thu,  7 May 2020 16:16:33 -0700 (PDT)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 88CA18EE181;
        Thu,  7 May 2020 16:16:33 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v9 8/8] security: keys: trusted: implement counter/timer policy
Date:   Thu,  7 May 2020 16:11:47 -0700
Message-Id: <20200507231147.27025-9-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
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
 .../security/keys/trusted-encrypted.rst       | 29 ++++++++++++++
 include/linux/tpm.h                           |  1 +
 security/keys/trusted-keys/tpm2-policy.c      | 40 ++++++++++++++++++-
 security/keys/trusted-keys/trusted_tpm2.c     | 36 ++++++++++++++++-
 4 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index b68d3eb73f00..53a6196c7df9 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -241,3 +241,32 @@ about the usage can be found in the file
 Another new format 'enc32' has been defined in order to support encrypted keys
 with payload size of 32 bytes. This will initially be used for nvdimm security
 but may expand to other usages that require 32 bytes payload.
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
index e32e9728adce..5026a06977e1 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -233,6 +233,7 @@ enum tpm2_command_codes {
 	TPM2_CC_PCR_EXTEND	        = 0x0182,
 	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
 	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
+	TPM2_CC_POLICY_PASSWORD		= 0x018c,
 	TPM2_CC_CREATE_LOADED           = 0x0191,
 	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
 };
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index 87a13e607eca..bd8eb02e1094 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -197,7 +197,8 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 			len = *plen;
 		}
 
-		crypto_shash_update(sdesc, policy, len);
+		if (len)
+			crypto_shash_update(sdesc, policy, len);
 
 		/* now output the intermediate to the policydigest */
 		crypto_shash_final(sdesc, policydigest);
@@ -332,6 +333,16 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 		u32 cmd = pols->code[i];
 		struct tpm_buf buf;
 
+		if (cmd == TPM2_CC_POLICY_AUTHVALUE)
+			/*
+			 * both PolicyAuthValue and PolicyPassword
+			 * hash to the same thing, but one triggers
+			 * HMAC authentication and the other simple
+			 * authentication.  Since we have no HMAC
+			 * code, we're choosing the simple
+			 */
+			cmd = TPM2_CC_POLICY_PASSWORD;
+
 		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, cmd);
 		if (rc)
 			return rc;
@@ -352,8 +363,35 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
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
index 98c65431ca75..3ec01ed874d9 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -248,6 +248,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	u32 flags;
 	int i;
 	int rc;
+	static const int POLICY_SIZE = 2 * PAGE_SIZE;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
 		if (options->hash == tpm2_hash_map[i].crypto_id) {
@@ -268,7 +269,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		/* 4 array len, 2 hash alg */
 		const int len = 4 + 2 + options->pcrinfo_len;
 
-		pols = kmalloc(sizeof(*pols) + len, GFP_KERNEL);
+		pols = kmalloc(POLICY_SIZE, GFP_KERNEL);
 		if (!pols)
 			return -ENOMEM;
 
@@ -289,6 +290,39 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		return -EINVAL;
 	}
 
+	/*
+	 * if we already have a policy, we have to add authorization
+	 * to it.  If we don't, we can simply follow the usual
+	 * non-policy route.
+	 */
+	if (options->blobauth_len != 0 && payload->policies) {
+		struct tpm2_policies *pols;
+		static u8 *scratch;
+		int i;
+		bool found = false;
+
+		pols = payload->policies;
+
+		/* make sure it's not already in policy */
+		for (i = 0; i < pols->count; i++) {
+			if (pols->code[i] == TPM2_CC_POLICY_AUTHVALUE) {
+				found = true;
+
+				break;
+			}
+		}
+
+		if (!found) {
+			i = pols->count++;
+			scratch = pols->policies[i - 1] + pols->len[i - 1];
+
+			/* the TPM2_PolicyPassword command has no payload */
+			pols->policies[i] = scratch;
+			pols->len[i] = 0;
+			pols->code[i] = TPM2_CC_POLICY_AUTHVALUE;
+		}
+	}
+
 	if (payload->policies) {
 		rc = tpm2_generate_policy_digest(payload->policies,
 						 options->hash,
-- 
2.26.1

