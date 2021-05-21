Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB7738BAFD
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 02:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhEUArp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 20:47:45 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:47062 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235348AbhEUAro (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 20:47:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9BF7E12806C8;
        Thu, 20 May 2021 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621557982;
        bh=nSMAvFQ2qf9u9Cj4tHSExvhtmIcTBRz0nwDD/jHDViE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=At7D9XLAKMgLsUo3Y5WU/PXR0kQEUjlyJEMRuFQyc07gwDFuO/+YJbo1Evrek0jpQ
         HSjQIj9iFEcmyTV9uWqb0jJ7/Z2VNRTiUPZec9/pV7STMBvDUKrD5mFWOGkRSM2nXA
         Lx1r6NBnBa3jLqlrAS+1DS5Qy5KTV4nU6P8lqEiM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id biPT8wdljmij; Thu, 20 May 2021 17:46:22 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2203412806B1;
        Thu, 20 May 2021 17:46:22 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4/4] security: keys: trusted: implement authorization policy
Date:   Thu, 20 May 2021 17:44:01 -0700
Message-Id: <20210521004401.4167-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When using authorizations (passwords) with a policy, the trigger for
the authorizations must be present in the policy statements that are
required to build to the policy hash.  Add this required policy statement
if blobauth is present.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/tpm.h                       |  2 ++
 security/keys/trusted-keys/tpm2-policy.c  | 14 +++++++++-
 security/keys/trusted-keys/trusted_tpm2.c | 33 +++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 85e167ae2c65..081ed7d6d4ac 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -230,6 +230,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_POLICY_AUTHVALUE	= 0x016B,
 	TPM2_CC_POLICY_COUNTER_TIMER	= 0x016D,
 	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
@@ -240,6 +241,7 @@ enum tpm2_command_codes {
 	TPM2_CC_PCR_EXTEND	        = 0x0182,
 	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
 	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
+	TPM2_CC_POLICY_PASSWORD		= 0x018c,
 	TPM2_CC_CREATE_LOADED           = 0x0191,
 	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
 };
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index 21bfeb686287..0f5daa5653bf 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -67,6 +67,7 @@ static int tpm2_validate_policy(struct tpm2_policies *pols)
 		switch (pols->code[i]) {
 		case TPM2_CC_POLICY_COUNTER_TIMER:
 		case TPM2_CC_POLICY_PCR:
+		case TPM2_CC_POLICY_AUTHVALUE:
 			break;
 		default:
 			pr_warn("tpm2 policy 0x%x is unsupported",
@@ -198,7 +199,8 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 			len = *plen;
 		}
 
-		crypto_shash_update(sdesc, policy, len);
+		if (len)
+			crypto_shash_update(sdesc, policy, len);
 
 		/* now output the intermediate to the policydigest */
 		crypto_shash_final(sdesc, policydigest);
@@ -334,6 +336,16 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
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
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index b7eb919de8ef..282c633bd2ec 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -294,6 +294,39 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
2.26.2

