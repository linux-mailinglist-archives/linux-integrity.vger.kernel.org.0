Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC138BAF5
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 02:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhEUAqn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 20:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhEUAqm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 20:46:42 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B20C061574;
        Thu, 20 May 2021 17:45:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B8E6512806BA;
        Thu, 20 May 2021 17:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621557920;
        bh=g7Pav1Z/93yPRlFkuBLtk0OlOKI5UY3aQypTQCuxC38=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=AdrmgmaNz8AuCEWX4Exzeel0b7QUZF6coIoJ3sTPirtiHSVGx2WYCFZSIHVT+F54s
         qbUeoumWgxfgRu6A/xssRGSVWUF09TZO+HHomKW/5ro6cxmfTizRlX4lpQHgzwn6Qd
         tkuzXrukMCIO/IhZeFHzSFVK4r+S1a649hRQs2+g=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4OyU3DdHZOvE; Thu, 20 May 2021 17:45:20 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 22D7D12806B1;
        Thu, 20 May 2021 17:45:20 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 2/4] security: keys: trusted: add ability to specify arbitrary policy
Date:   Thu, 20 May 2021 17:43:59 -0700
Message-Id: <20210521004401.4167-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 security/keys/trusted-keys/trusted_tpm2.c     |  4 ++
 5 files changed, 89 insertions(+)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 5c66f29b7a1c..883844c95e91 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -172,6 +172,9 @@ Usage::
        policyhandle= handle to an authorization policy session that defines the
                      same policy and with the same hash algorithm as was used to
                      seal the key.
+       policy=       specify an arbitrary set of policies.  These must
+                     be in policymaker format with each separate
+                     policy line newline terminated.
 
 "keyctl print" returns an ascii hex copy of the sealed key, which is in standard
 TPM_STORED_DATA format.  The key length for new keys are always in bytes.
@@ -271,6 +274,19 @@ zeros (the value of PCR 16)::
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
 Reseal (TPM specific) a trusted key under new PCR values::
 
     $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
index b05b2953d5ea..bb28c864fa9b 100644
--- a/security/keys/trusted-keys/tpm2-policy.c
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -357,3 +357,56 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
 
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
index aa108bea6739..6ed7303e36b5 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -22,6 +22,8 @@
 
 #include <keys/trusted_tpm.h>
 
+#include "tpm2-policy.h"
+
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
 static struct tpm_chip *chip;
@@ -713,6 +715,7 @@ enum {
 	Opt_hash,
 	Opt_policydigest,
 	Opt_policyhandle,
+	Opt_policy,
 };
 
 static const match_table_t key_tokens = {
@@ -725,6 +728,7 @@ static const match_table_t key_tokens = {
 	{Opt_hash, "hash=%s"},
 	{Opt_policydigest, "policydigest=%s"},
 	{Opt_policyhandle, "policyhandle=%s"},
+	{Opt_policy, "policy=%s"},
 	{Opt_err, NULL}
 };
 
@@ -858,6 +862,17 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index a218f982fef5..afe9cc41885e 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -268,6 +268,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		/* 4 array len, 2 hash alg */
 		const int len = 4 + 2 + options->pcrinfo_len;
 
+		if (payload->policies)
+			/* can't specify pcr and general policy */
+			return -EINVAL;
+
 		pols = kmalloc(sizeof(*pols) + len, GFP_KERNEL);
 		if (!pols)
 			return -ENOMEM;
-- 
2.26.2

