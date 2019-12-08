Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA2116078
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Dec 2019 06:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbfLHFNW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Dec 2019 00:13:22 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58100 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfLHFNV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Dec 2019 00:13:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 984C48EE111;
        Sat,  7 Dec 2019 21:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575782001;
        bh=9bVoBmJ6mY3uKdITKe8NDCfHjhounPrY1rA6LnkCDj0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B8gVmQlv1vL+1K/VyUUBJBH4RmE4CUEYfnYdjU03dwV5iGpz9oXkPW0CBDezgFYLL
         T7kK+/tEZPWClK1eS/Zdr8HrEIqbg1KW96hNctqagAYciZuCaOyYSLpoE1aeUJBZpV
         bNpMLmSqKlzTACtUj7BwUP4Nuamtlpn9Ol1kKV1s=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5LC46jPbcZvk; Sat,  7 Dec 2019 21:13:21 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 35AA08EE109;
        Sat,  7 Dec 2019 21:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575782001;
        bh=9bVoBmJ6mY3uKdITKe8NDCfHjhounPrY1rA6LnkCDj0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B8gVmQlv1vL+1K/VyUUBJBH4RmE4CUEYfnYdjU03dwV5iGpz9oXkPW0CBDezgFYLL
         T7kK+/tEZPWClK1eS/Zdr8HrEIqbg1KW96hNctqagAYciZuCaOyYSLpoE1aeUJBZpV
         bNpMLmSqKlzTACtUj7BwUP4Nuamtlpn9Ol1kKV1s=
Message-ID: <1575782000.14069.17.camel@HansenPartnership.com>
Subject: [PATCH 7/8] security: keys: trusted: add ability to specify
 arbitrary policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 07 Dec 2019 21:13:20 -0800
In-Reply-To: <1575781600.14069.8.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
 Documentation/security/keys/trusted-encrypted.rst | 16 ++++++++
 security/keys/trusted-keys/tpm2-policy.c          | 46 +++++++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h          |  1 +
 security/keys/trusted-keys/trusted_tpm1.c         | 14 ++++++-
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 1a3ca84ad3cd..ade1a9dc8367 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -70,6 +70,9 @@ Usage::
        hash=         hash algorithm name as a string. For TPM 1.x the only
                      allowed value is sha1. For TPM 2.x the allowed values
                      are sha1, sha256, sha384, sha512 and sm3-256.
+       policy=       specify an arbitrary set of policies.  These must
+                     be in policymaker format with each separate
+                     policy line newline terminated.
 
 "keyctl print" returns an ascii hex copy of the sealed key, which is in standard
 TPM_STORED_DATA format.  The key length for new keys are always in bytes.
@@ -162,6 +165,19 @@ zeros (the value of PCR 16)::
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
index ae83636ece37..4f8549219055 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -342,3 +342,49 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 	}
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
+		pols->len[i] = strlen(p)/2;
+		if (pols->len[i] > left) {
+			res = -E2BIG;
+			goto err;
+		}
+		res = hex2bin(ptr, p, pols->len[i]);
+		if (res)
+			goto err;
+		/* get command code and skip past */
+		pols->code[i] = get_unaligned_be32(ptr);
+		pols->policies[i] = ptr + 4;
+		ptr += pols->len[i];
+		left -= pols->len[i];
+		pols->len[i] -= 4;
+		/*
+		 * FIXME: this does leave the code embedded in dead
+		 * regions of the memory, but it's easier than
+		 * hexdumping to a temporary or copying over
+		 */
+		i++;
+	}
+	pols->count = i;
+	*ppols = pols;
+	return 0;
+ err:
+	kfree(pols);
+	return res;
+}
diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/trusted-keys/tpm2-policy.h
index 152c948743f3..cb804a544ced 100644
--- a/security/keys/trusted-keys/tpm2-policy.h
+++ b/security/keys/trusted-keys/tpm2-policy.h
@@ -28,3 +28,4 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols, u32 hash,
 int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len);
 int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 			    u32 *handle);
+int tpm2_parse_policies(struct tpm2_policies **ppols, char *str);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 6290e611b632..ba05c75c3170 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -29,6 +29,8 @@
 
 #include <keys/trusted_tpm.h>
 
+#include "tpm2-policy.h"
+
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
 static struct tpm_chip *chip;
@@ -706,7 +708,7 @@ enum {
 	Opt_new, Opt_load, Opt_update,
 	Opt_keyhandle, Opt_keyauth, Opt_blobauth,
 	Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
-	Opt_hash,
+	Opt_hash, Opt_policy,
 };
 
 static const match_table_t key_tokens = {
@@ -720,6 +722,7 @@ static const match_table_t key_tokens = {
 	{Opt_pcrlock, "pcrlock=%s"},
 	{Opt_migratable, "migratable=%s"},
 	{Opt_hash, "hash=%s"},
+	{Opt_policy, "policy=%s"},
 	{Opt_err, NULL}
 };
 
@@ -809,6 +812,15 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 				return -EINVAL;
 			}
 			break;
+		case Opt_policy:
+			if (pay->policies)
+				return -EINVAL;
+			if (!tpm2)
+				return -EINVAL;
+			res = tpm2_parse_policies(&pay->policies, args[0].from);
+			if (res)
+				return res;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.16.4

