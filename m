Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988D3123FC6
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 07:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLRGko (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 01:40:44 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42842 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725810AbfLRGko (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 01:40:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AF27A8EE18E;
        Tue, 17 Dec 2019 22:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576651243;
        bh=ohxY8YLRxu1Tn8IBmrbxO4uzyOFwciDdtq97iGB0+UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9o7EPEdG840qiuG5MihIlWCejf6xOAmIYsudd0ngGXexzWr3XS/5kjkTX5sWIgyG
         NekB6cr9d5ZXs2NAkkGe2PVQ1OY202gsub7eRWEAbJMqN5pvYJvBJ4PAhykzBBT+WD
         Ax8W+MiJMRMlesrtfE4MToSHrAjtp+Gim+FKc4+Q=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id unBPwhQQPbC1; Tue, 17 Dec 2019 22:40:43 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A49218EE0DF;
        Tue, 17 Dec 2019 22:40:42 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v3 9/9] security: keys: trusted: add password based authorizations to policy keys
Date:   Wed, 18 Dec 2019 15:31:42 +0900
Message-Id: <20191218063142.23033-10-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
References: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM 2.0 has a trick where you can turn off the usual HMAC password
session requirement using TPM2_PolicyPassword, so everywhere we see a
TPM2_PolicyAuthValue (which does require HMAC password), we replace
with the TPM2_PolicyPassword command instead.  This allows us to use
passwords with TPM 2.0 trusted keys that also have a policy.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/tpm.h                       |  1 +
 security/keys/trusted-keys/tpm2-policy.c  | 16 ++++++++++++-
 security/keys/trusted-keys/trusted_tpm2.c | 38 ++++++++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 4 deletions(-)

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
index 5698475b30cb..56b99419ce90 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -193,7 +193,8 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols,
 			policy = digest;
 			len = *plen;
 		}
-		crypto_shash_update(sdesc, policy, len);
+		if (len)
+			crypto_shash_update(sdesc, policy, len);
 		/* now output the intermediate to the policydigest */
 		crypto_shash_final(sdesc, policydigest);
 
@@ -303,6 +304,16 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
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
@@ -344,6 +355,9 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 		}
 		default:
 			failure = "unknown policy";
+			if (pols->len[i])
+				tpm_buf_append(&buf, pols->policies[i],
+					       pols->len[i]);
 			break;
 		}
 		rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 82004273f8d4..085d09c4a4ed 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -53,7 +53,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 
 	asn1_encode_oid(&work, &work_len, tpm2key_oid,
 			asn1_oid_len(tpm2key_oid));
-	if (options->blobauth[0] == 0) {
+	if (options->blobauth_len == 0) {
 		unsigned char bool[3], *w = bool;
 		int bool_len = sizeof(bool);
 		/* tag 0 is emptyAuth */
@@ -247,6 +247,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	u32 flags;
 	int i;
 	int rc;
+	static const int POLICY_SIZE = 2 * PAGE_SIZE;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
 		if (options->hash == tpm2_hash_map[i].crypto_id) {
@@ -267,7 +268,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		/* 4 array len, 2 hash alg */
 		const int len = 4 + 2 + options->pcrinfo_len;
 
-		pols = kmalloc(sizeof(*pols) + len, GFP_KERNEL);
+		pols = kmalloc(POLICY_SIZE, GFP_KERNEL);
 		if (!pols)
 			return -ENOMEM;
 
@@ -288,6 +289,37 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
+				break;
+			}
+		}
+
+		if (!found) {
+			i = pols->count++;
+			scratch = pols->policies[i - 1] + pols->len[i - 1];
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
@@ -526,7 +558,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			     NULL /* nonce */, 0,
 			     TPM2_SA_CONTINUE_SESSION,
 			     options->blobauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+			     options->blobauth_len);
 
 	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
 	if (payload->policies)
-- 
2.16.4

