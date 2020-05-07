Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E5F1C9F0D
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 01:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEGXP7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 19:15:59 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33578 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgEGXP7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 19:15:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2D86A8EE268;
        Thu,  7 May 2020 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1588893359;
        bh=TDU7eTfjp0DDRiI0sTW3dbEZSvbFTmFXyvS978SjdJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ED6srHExD5/nRvSSgq6ka9zguHJjo4TDsRAmqVkIVJMvLMYEHfrNMHt9j8T4nRAtZ
         oqaGx1XprCEkQlRpjZrZT12VAcrU2T+83K4FQizgtBEcYBVHXHOIfgTnfmiUJiHjuW
         cBntPY/ssAIJUO+v56JGCKAeyyxQRATFjhpQyMW0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rcey7M2kkU2J; Thu,  7 May 2020 16:15:59 -0700 (PDT)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B36738EE181;
        Thu,  7 May 2020 16:15:58 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v9 7/8] security: keys: trusted: add ability to specify arbitrary policy
Date:   Thu,  7 May 2020 16:11:46 -0700
Message-Id: <20200507231147.27025-8-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds a policy= argument to key creation.  The policy is the
standard tss policymaker format and each separate policy line must
have a newline after it.

Thus to construct a policy requiring authorized value and pcr 16
locking using a sha256 hash, the policy (policy.txt) file would be two
lines:

0000017F00000001000B03000001303095B49BE85E381E5B20E557E46363EF55B0F43B132C2D8E3DE9AC436656F2
0000016b

This can be inserted into the key with

keyctl add trusted kmk "new 32 policy=`cat policy.txt` keyhandle=0x81000001 hash=sha256" @u

Note that although a few policies work like this, most require special
handling which must be added to the kernel policy construction
routine.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 .../security/keys/trusted-encrypted.rst       | 16 ++++++
 security/keys/trusted-keys/tpm2-policy.c      | 53 +++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  1 +
 security/keys/trusted-keys/trusted_tpm1.c     | 15 ++++++
 4 files changed, 85 insertions(+)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 053344c4df5b..b68d3eb73f00 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -76,6 +76,9 @@ Usage::
        policyhandle= handle to an authorization policy session that defines the
                      same policy and with the same hash algorithm as was used to
                      seal the key.
+       policy=       specify an arbitrary set of policies.  These must
+                     be in policymaker format with each separate
+                     policy line newline terminated.
 
 "keyctl print" returns an ascii hex copy of the sealed key, which is in standard
 TPM_STORED_DATA format.  The key length for new keys are always in bytes.
@@ -168,6 +171,19 @@ zeros (the value of PCR 16)::
     $ dd if=/dev/zero bs=1 count=20 2>/dev/null|sha1sum
     6768033e216468247bd031a0a2d9876d79818f8f
 
+You can also specify arbitrary policy in policymaker format, so a two
+value policy (the pcr example above and authvalue) would look like
+this in policymaker format::
+
+    0000017F000000010004030000016768033e216468247bd031a0a2d9876d79818f8f
+    0000016b
+
+This can be placed in a file (say policy.txt) and then added to the key as::
+
+    $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 policy=`cat policy.txt`" @u
+
+The newlines in the file policy.txt will be automatically processed.
+
 Reseal a trusted key under new pcr values::
 
     $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index 080a76e879fd..87a13e607eca 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -370,3 +370,56 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 
 	return 0;
 }
+
+int tpm2_parse_policies(struct tpm2_policies **ppols, char *str)
+{
+	struct tpm2_policies *pols;
+	char *p;
+	u8 *ptr;
+	int i = 0, left = PAGE_SIZE, res;
+
+	pols = kmalloc(left, GFP_KERNEL);
+	if (!pols)
+		return -ENOMEM;
+
+	ptr = (u8 *)(pols + 1);
+	left -= ptr - (u8 *)pols;
+
+	while ((p = strsep(&str, "\n"))) {
+		if (*p == '\0' || *p == '\n')
+			continue;
+
+		pols->len[i] = strlen(p)/2;
+		if (pols->len[i] > left) {
+			res = -E2BIG;
+			goto err;
+		}
+
+		res = hex2bin(ptr, p, pols->len[i]);
+		if (res)
+			goto err;
+
+		/* get command code and skip past */
+		pols->code[i] = get_unaligned_be32(ptr);
+		pols->policies[i] = ptr + 4;
+		ptr += pols->len[i];
+		left -= pols->len[i];
+		pols->len[i] -= 4;
+
+		/*
+		 * FIXME: this does leave the code embedded in dead
+		 * regions of the memory, but it's easier than
+		 * hexdumping to a temporary or copying over
+		 */
+		i++;
+	}
+
+	pols->count = i;
+	*ppols = pols;
+
+	return 0;
+
+ err:
+	kfree(pols);
+	return res;
+}
diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/trusted-keys/tpm2-policy.h
index 46bf1f0a9325..0da013116c1c 100644
--- a/security/keys/trusted-keys/tpm2-policy.h
+++ b/security/keys/trusted-keys/tpm2-policy.h
@@ -28,3 +28,4 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols, u32 hash,
 int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len);
 int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 			    u32 *handle);
+int tpm2_parse_policies(struct tpm2_policies **ppols, char *str);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 892b18275b0c..cd2a44fcef98 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -29,6 +29,8 @@
 
 #include <keys/trusted_tpm.h>
 
+#include "tpm2-policy.h"
+
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
 static struct tpm_chip *chip;
@@ -709,6 +711,7 @@ enum {
 	Opt_hash,
 	Opt_policydigest,
 	Opt_policyhandle,
+	Opt_policy,
 };
 
 static const match_table_t key_tokens = {
@@ -724,6 +727,7 @@ static const match_table_t key_tokens = {
 	{Opt_hash, "hash=%s"},
 	{Opt_policydigest, "policydigest=%s"},
 	{Opt_policyhandle, "policyhandle=%s"},
+	{Opt_policy, "policy=%s"},
 	{Opt_err, NULL}
 };
 
@@ -854,6 +858,17 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 				return -EINVAL;
 			opt->policyhandle = handle;
 			break;
+
+		case Opt_policy:
+			if (pay->policies)
+				return -EINVAL;
+			if (!tpm2)
+				return -EINVAL;
+			res = tpm2_parse_policies(&pay->policies, args[0].from);
+			if (res)
+				return res;
+			break;
+
 		default:
 			return -EINVAL;
 		}
-- 
2.26.1

