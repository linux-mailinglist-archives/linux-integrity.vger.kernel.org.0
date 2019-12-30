Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F105912D2EE
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfL3RoL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 12:44:11 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39538 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbfL3RoK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 12:44:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 980508EE15F;
        Mon, 30 Dec 2019 09:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577727850;
        bh=caVNe0qmmW/yVqiTXrtklhxmMk2KQ4fhsW2nFHKjueg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgDKx6oQEynoaReOHEMZiXrK0Sv7YCaPj11lGFso5HzS1QQO9zOnrcBCshmdEuzDU
         R/VIgkkuWnM9EnXv5zlZx6usRFSCaYVT4DQ3f1woVs1dN8SDQThYmNphi9nAzYkGLJ
         mYP0qcwWBTFn6+4d5nA+0GVfrMxeLXu+AqZN+Trc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GEBIVRXBVmxr; Mon, 30 Dec 2019 09:44:10 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 33D258EE07B;
        Mon, 30 Dec 2019 09:44:10 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v4 9/9] security: keys: trusted: add password based authorizations to policy keys
Date:   Mon, 30 Dec 2019 09:38:02 -0800
Message-Id: <20191230173802.8731-10-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
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
 security/keys/trusted-keys/tpm2-policy.c  | 16 ++++++++++++++-
 security/keys/trusted-keys/trusted_tpm2.c | 34 ++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 2 deletions(-)

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
index 3c7a8e6c84c8..2c93197edf2b 100644
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
 
@@ -316,6 +317,16 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
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
@@ -357,6 +368,9 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
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
index 1f039b39aa7f..169846fde5f7 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -244,6 +244,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	u32 flags;
 	int i;
 	int rc;
+	static const int POLICY_SIZE = 2 * PAGE_SIZE;
 
 	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
 		if (options->hash == tpm2_hash_map[i].crypto_id) {
@@ -264,7 +265,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		/* 4 array len, 2 hash alg */
 		const int len = 4 + 2 + options->pcrinfo_len;
 
-		pols = kmalloc(sizeof(*pols) + len, GFP_KERNEL);
+		pols = kmalloc(POLICY_SIZE, GFP_KERNEL);
 		if (!pols)
 			return -ENOMEM;
 
@@ -285,6 +286,37 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
-- 
2.16.4

