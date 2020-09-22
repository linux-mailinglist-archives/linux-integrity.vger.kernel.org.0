Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E823627388B
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Sep 2020 04:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgIVCcu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Sep 2020 22:32:50 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36098 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729379AbgIVCct (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Sep 2020 22:32:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8C30C8EE194;
        Mon, 21 Sep 2020 19:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600741969;
        bh=PtZzYRhUjMbNeCJKYgcHudBuJ1U5bVl00VHl84I79yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKRK8Yqlm/JKp0qU3tYjhAFWScg6yLo27OnlQcKT9gOW72qOjoQhgIUJWpHyXprZn
         dykSxo/RX31/5x8tGryHsEDfv1BPEgT16vOPlB6dt3FwrClNzULe3qtcW2UHjaqV4/
         RVlXENw2ZhWEbFgFX8/r7cf3MhJApYGnGb2YkNPU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3moALqcLGBp1; Mon, 21 Sep 2020 19:32:49 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F369F8EE0CF;
        Mon, 21 Sep 2020 19:32:48 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v13 1/3] security: keys: trusted: add PCR policy to TPM2 keys
Date:   Mon, 21 Sep 2020 19:32:16 -0700
Message-Id: <20200922023218.7466-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922023218.7466-1-James.Bottomley@HansenPartnership.com>
References: <20200922023218.7466-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This commit adds the ability to specify a PCR lock policy to TPM2
keys.  There is a complexity in that the creator of the key must chose
either to use a PCR lock policy or to use authentication.  At the
current time they can't use both due to a complexity with the way
authentication works when policy registers are in use.  The way to
construct a pcrinfo statement for a key is simply to use the
TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
hash of all their values in order of ascending PCR number.

For simplicity, we require the hash of the PCRs to use the same hash
algorithm as the one passed in.  Thus to construct a policy around the
value of the resettable PCR 16 using the sha1 bank, first reset the
PCR to zero giving a hash of all zeros as:

6768033e216468247bd031a0a2d9876d79818f8f

Then the TPMS_PCR_SELECT value for PCR 16 is

03000001

So create a new 32 byte key with a policy policy locking the key to
this value of PCR 16 with a parent key of 81000001 would be:

keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo=030000016768033e216468247bd031a0a2d9876d79818f8f" @u

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: fix for new ASN.1 API eliminating hack in place and check lengths
v8: recover patch and fix offsets for hash and size
v9: fix cut and paste error in commit log
v10: update for kfree_sensitive()
v11: add policy to ASN.1 key format description
v12: tidy up commit message and document ASN.1 parser handlers
v13: add asn.1 dependency
---
 .../security/keys/trusted-encrypted.rst       |  36 +-
 include/keys/trusted-type.h                   |   5 +-
 include/linux/tpm.h                           |   5 +
 security/keys/Kconfig                         |   2 +
 security/keys/trusted-keys/Makefile           |   4 +-
 security/keys/trusted-keys/tpm2-policy.c      | 374 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  30 ++
 security/keys/trusted-keys/tpm2key.asn1       |  13 +
 security/keys/trusted-keys/trusted_tpm1.c     |   8 +-
 security/keys/trusted-keys/trusted_tpm2.c     |  86 +++-
 10 files changed, 548 insertions(+), 15 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index eb639bb24fcc..8b7853a277bc 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -60,7 +60,10 @@ Usage::
                      (40 ascii zeros)
        blobauth=     ascii hex auth for sealed data default 0x00...
                      (40 ascii zeros)
-       pcrinfo=	     ascii hex of PCR_INFO or PCR_INFO_LONG (no default)
+       pcrinfo=      ascii hex of PCR_INFO or PCR_INFO_LONG (no
+                     default) on TPM 1.2 and a TPMS_PCR_SELECTION
+                     coupled with a hash of all the selected PCRs on
+                     TPM 2.0 using the selected hash.
        pcrlock=	     pcr number to be extended to "lock" blob
        migratable=   0|1 indicating permission to reseal to new PCR values,
                      default 1 (resealing allowed)
@@ -151,6 +154,20 @@ Load a trusted key from the saved blob::
     f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409c22b
     e4a8aea2b607ec96931e6f4d4fe563ba
 
+Create a trusted key on TPM 2.0 using an all zero value of PCR16 and
+using the NV storage root 81000001 as the parent::
+
+    $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo=030000016768033e216468247bd031a0a2d9876d79818f8f" @u
+
+Note the TPMS_PCR_SELECT value for PCR 16 is 03000001 because all
+current TPMs have 24 PCRs, so the initial 03 says there are three
+following bytes of selection and then because the bytes are big
+endian, 16 is bit zero of byte 2. the hash is the sha1 sum of all
+zeros (the value of PCR 16)::
+
+    $ dd if=/dev/zero bs=1 count=20 2>/dev/null|sha1sum
+    6768033e216468247bd031a0a2d9876d79818f8f
+
 Reseal a trusted key under new pcr values::
 
     $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
@@ -221,11 +238,17 @@ policy::
     TPMKey ::= SEQUENCE {
         type		OBJECT IDENTIFIER
         emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL
+        policy		[1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL
         parent		INTEGER
         pubkey		OCTET STRING
         privkey		OCTET STRING
     }
 
+    TPMPolicy ::= SEQUENCE {
+	CommandCode		[0] EXPLICIT INTEGER
+	CommandPolicy		[1] EXPLICIT OCTET STRING
+    }
+
 type is what distinguishes the key even in binary form since the OID
 is provided by the TCG to be unique and thus forms a recognizable
 binary pattern at offset 3 in the key.  The OIDs currently made
@@ -251,6 +274,17 @@ is false or not present, the key requires an explicit authorization
 phrase.  This is used by most user space consumers to decide whether
 to prompt for a password.
 
+policy represents a sequence of one or more policy statements that
+must be executed successfully into a session policy register.  If
+policy isn't present then no policy is required to unlock the key, but
+if it is, commandCode is the TPM 2.0 command code of the policy
+instruction that must be executed and CommandPolicy represents the
+binary parameter area of the policy command.
+
+Note that the current sequential execution requirement means that only
+AND based policy can be constructed at the moment, so TPM2_PolicyOR is
+not currently supported.
+
 parent represents the parent key handle, either in the 0x81 MSO space,
 like 0x81000001 for the RSA primary storage key.  Userspace programmes
 also support specifying the primary handle in the 0x40 MSO space.  If
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index b2d87ad21714..c117bf598230 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -14,9 +14,11 @@
 #define MIN_KEY_SIZE			32
 #define MAX_KEY_SIZE			128
 #define MAX_BLOB_SIZE			512
-#define MAX_PCRINFO_SIZE		64
+#define MAX_PCRINFO_SIZE		128
 #define MAX_DIGEST_SIZE			64
 
+#define TPM2_MAX_POLICIES		16
+
 struct trusted_key_payload {
 	struct rcu_head rcu;
 	unsigned int key_len;
@@ -25,6 +27,7 @@ struct trusted_key_payload {
 	unsigned char old_format;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
+	struct tpm2_policies *policies;
 };
 
 struct trusted_key_options {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 35224860fd0c..254c33086288 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -230,10 +230,14 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_POLICY_AUTHVALUE	= 0x016B,
+	TPM2_CC_POLICY_COUNTER_TIMER	= 0x016D,
+	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
 	TPM2_CC_GET_RANDOM	        = 0x017B,
 	TPM2_CC_PCR_READ	        = 0x017E,
+	TPM2_CC_POLICY_PCR		= 0x017F,
 	TPM2_CC_PCR_EXTEND	        = 0x0182,
 	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
 	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
@@ -242,6 +246,7 @@ enum tpm2_command_codes {
 };
 
 enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
 
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 3b75ee102c58..d5c23c2309b3 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -74,6 +74,8 @@ config TRUSTED_KEYS
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 	select CRYPTO_HASH_INFO
 	select ASN1_ENCODER
 	select ASN1
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index f87c43f306d5..aa2dc827e6f2 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -6,5 +6,5 @@
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_tpm1.o
 
-$(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
-trusted-y += trusted_tpm2.o tpm2key.asn1.o
+$(obj)/trusted_tpm2.o $(obj)/tpm2-policy.o: $(obj)/tpm2key.asn1.h
+trusted-y += trusted_tpm2.o tpm2key.asn1.o tpm2-policy.o
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
new file mode 100644
index 000000000000..011f42e574db
--- /dev/null
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
+ */
+
+#include <linux/asn1_encoder.h>
+#include <linux/err.h>
+#include <linux/types.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+#include <linux/tpm.h>
+
+#include <asm/unaligned.h>
+
+#include <crypto/hash.h>
+
+#include <keys/trusted-type.h>
+#include <keys/trusted_tpm.h>
+
+#include "tpm2key.asn1.h"
+#include "tpm2-policy.h"
+
+/* used by ASN.1 parser only to extract policy code */
+int tpm2_key_code(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+	u32 code = 0;
+	const u8 *v = value;
+	int i;
+
+	for (i = 0; i < vlen; i++) {
+		code <<= 8;
+		code |= v[i];
+	}
+
+	ctx->policy_code[ctx->policy_count] = code;
+
+	return 0;
+}
+
+/* used by ASN.1 parser only to extract policy sequence */
+int tpm2_key_policy(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->policies[ctx->policy_count] = value;
+	ctx->policy_len[ctx->policy_count++] = vlen;
+
+	return 0;
+}
+
+/* we only support a limited number of policy statement so
+ * make sure we don't have anything we can't support
+ */
+static int tpm2_validate_policy(struct tpm2_policies *pols)
+{
+	int i;
+
+	if (pols->count == 0)
+		return 0;
+
+	for (i = 0; i < pols->count; i++) {
+		switch (pols->code[i]) {
+		case TPM2_CC_POLICY_COUNTER_TIMER:
+		case TPM2_CC_POLICY_PCR:
+		case TPM2_CC_POLICY_AUTHVALUE:
+			break;
+		default:
+			printk(KERN_INFO "tpm2 policy 0x%x is unsupported",
+			       pols->code[i]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * tpm2_key_process_policy - collect the policty from the context
+ * @ctx: the context to collect from
+ * @payload: the payload structure to place it in
+ *
+ * THis function sizes the policy statements and allocates space
+ * within the payload to receive them before copying them over.  It
+ * should be used after the ber decoder has completed successfully
+ */
+int tpm2_key_policy_process(struct tpm2_key_context *ctx,
+			    struct trusted_key_payload *payload)
+{
+	int tot_len = 0;
+	u8 *buf;
+	int i, ret, len = 0;
+	struct tpm2_policies *pols;
+
+	if (ctx->policy_count == 0)
+		return 0;
+
+	for (i = 0; i < ctx->policy_count; i++)
+		tot_len += ctx->policy_len[i];
+	tot_len += sizeof(*pols);
+
+	pols = kmalloc(tot_len, GFP_KERNEL);
+	if (!pols)
+		return -ENOMEM;
+
+	payload->policies = pols;
+	buf = (u8 *)(pols + 1);
+
+	for (i = 0; i < ctx->policy_count; i++) {
+		pols->policies[i] = &buf[len];
+		pols->len[i] = ctx->policy_len[i];
+		pols->code[i] = ctx->policy_code[i];
+		if (pols->len[i])
+			memcpy(pols->policies[i], ctx->policies[i],
+			       ctx->policy_len[i]);
+		len += ctx->policy_len[i];
+	}
+	pols->count = ctx->policy_count;
+
+	ret = tpm2_validate_policy(pols);
+	if (ret) {
+		kfree(pols);
+		payload->policies = NULL;
+	}
+
+	/* capture the hash and size */
+
+	/* the hash is the second algorithm */
+	pols->hash = get_unaligned_be16(&ctx->pub[4]);
+	/* and the digest appears after the attributes */
+	pols->hash_size = get_unaligned_be16(&ctx->pub[10]);
+
+	return ret;
+}
+
+int tpm2_generate_policy_digest(struct tpm2_policies *pols,
+				u32 hash, u8 *policydigest, u32 *plen)
+{
+	int i;
+	struct crypto_shash *tfm;
+	int rc;
+
+	if (pols->count == 0)
+		return 0;
+
+	tfm = crypto_alloc_shash(hash_algo_name[hash], 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = crypto_shash_digestsize(tfm);
+	if (WARN(rc > MAX_DIGEST_SIZE,
+		 "BUG: trusted key code has alg %s with digest too large (%d)",
+		 hash_algo_name[hash], rc)) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	pols->hash = hash;
+	pols->hash_size = rc;
+	*plen = rc;
+
+	/* policy digests always start out all zeros */
+	memset(policydigest, 0, rc);
+
+	for (i = 0; i < pols->count; i++) {
+		u8 *policy = pols->policies[i];
+		int len = pols->len[i];
+		u32 cmd = pols->code[i];
+		u8 digest[MAX_DIGEST_SIZE];
+		u8 code[4];
+		SHASH_DESC_ON_STACK(sdesc, tfm);
+
+		sdesc->tfm = tfm;
+		rc = crypto_shash_init(sdesc);
+		if (rc)
+			goto err;
+
+		/* first hash the previous digest */
+		crypto_shash_update(sdesc, policydigest, *plen);
+
+		/* then hash the command code */
+		put_unaligned_be32(cmd, code);
+		crypto_shash_update(sdesc, code, 4);
+
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
+		crypto_shash_update(sdesc, policy, len);
+
+		/* now output the intermediate to the policydigest */
+		crypto_shash_final(sdesc, policydigest);
+
+	}
+	rc = 0;
+
+ err:
+	crypto_free_shash(tfm);
+	return rc;
+}
+
+int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len)
+{
+	const int SCRATCH_SIZE = PAGE_SIZE;
+	u8 *buf = kmalloc(2 * SCRATCH_SIZE, GFP_KERNEL);
+	u8 *work = buf + SCRATCH_SIZE;
+	u8 *ptr;
+	u8 *end_work = work + SCRATCH_SIZE;
+	int i, ret;
+
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < pols->count; i++) {
+		u8 *seq, *tag;
+		u32 cmd = pols->code[i];
+
+		if (WARN(work - buf + 14 + pols->len[i] > 2 * SCRATCH_SIZE,
+			 "BUG: scratch buffer is too small"))
+			return -EINVAL;
+
+		work = asn1_encode_sequence(work, end_work, NULL, -1);
+		seq = work;
+
+		work = asn1_encode_tag(work, end_work, 0, NULL, -1);
+		tag = work;
+
+		work = asn1_encode_integer(work, end_work, cmd);
+		asn1_encode_tag(tag, end_work, 0, NULL, work - tag);
+
+		work = asn1_encode_tag(work, end_work, 1, NULL, -1);
+		tag = work;
+
+		work = asn1_encode_octet_string(work, end_work,
+						pols->policies[i],
+						pols->len[i]);
+
+		asn1_encode_tag(tag, end_work, 1, NULL, work - tag);
+
+		seq = asn1_encode_sequence(seq, end_work, NULL, work - seq);
+		if (IS_ERR(seq)) {
+			ret = PTR_ERR(seq);
+			goto err;
+		}
+	}
+	ptr = asn1_encode_sequence(buf, buf + SCRATCH_SIZE, buf + PAGE_SIZE,
+				   work - buf - PAGE_SIZE);
+	if (IS_ERR(ptr)) {
+		ret = PTR_ERR(ptr);
+		goto err;
+	}
+
+	*data = buf;
+	*len = ptr - buf;
+
+	return 0;
+
+ err:
+	kfree(buf);
+	return ret;
+}
+
+int tpm2_start_policy_session(struct tpm_chip *chip, u16 hash, u32 *handle)
+{
+	struct tpm_buf buf;
+	int rc;
+	int i;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
+	if (rc)
+		return rc;
+
+	/* NULL salt key handle */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+
+	/* NULL bind key handle */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+
+	/* empty nonce caller */
+	tpm_buf_append_u16(&buf, 20);
+	for (i = 0; i < 20; i++)
+		tpm_buf_append_u8(&buf, 0);
+
+	/* empty auth */
+	tpm_buf_append_u16(&buf, 0);
+
+	/* session type policy */
+	tpm_buf_append_u8(&buf, 0x01);
+
+	/* symmetric encryption parameters */
+
+	/* symmetric algorithm  */
+	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
+
+	/* hash algorithm for session */
+	tpm_buf_append_u16(&buf, hash);
+
+	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (rc)
+		goto out;
+
+	*handle = get_unaligned_be32(buf.data + TPM_HEADER_SIZE);
+
+ out:
+	tpm_buf_destroy(&buf);
+
+	return rc <= 0 ? rc : -EPERM;
+}
+
+int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
+			    u32 *handle)
+{
+	int i, rc;
+	const char *failure;
+
+	rc = tpm2_start_policy_session(chip, pols->hash, handle);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < pols->count; i++) {
+		u32 cmd = pols->code[i];
+		struct tpm_buf buf;
+
+		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, cmd);
+		if (rc)
+			return rc;
+
+		tpm_buf_append_u32(&buf, *handle);
+
+		switch (cmd) {
+		case TPM2_CC_POLICY_PCR:
+			failure = "PCR";
+			/*
+			 * for reasons best known to the TCG we have
+			 * to reverse the two arguments to send to the
+			 * policy command
+			 */
+			tpm_buf_append_u16(&buf, pols->hash_size);
+			tpm_buf_append(&buf, pols->policies[i] + pols->len[i] -
+				       pols->hash_size, pols->hash_size);
+			tpm_buf_append(&buf, pols->policies[i],
+				       pols->len[i] - pols->hash_size);
+			break;
+		default:
+			failure = "unknown policy";
+			break;
+		}
+
+		rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+		tpm_buf_destroy(&buf);
+		if (rc) {
+			printk(KERN_NOTICE "TPM policy %s failed, rc=%d\n",
+			       failure, rc);
+			tpm2_flush_context(chip, *handle);
+			*handle = 0;
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/trusted-keys/tpm2-policy.h
new file mode 100644
index 000000000000..46bf1f0a9325
--- /dev/null
+++ b/security/keys/trusted-keys/tpm2-policy.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct tpm2_key_context {
+	u32 parent;
+	const u8 *pub;
+	u32 pub_len;
+	const u8 *priv;
+	u32 priv_len;
+	const u8 *policies[TPM2_MAX_POLICIES];
+	u32 policy_code[TPM2_MAX_POLICIES];
+	u16 policy_len[TPM2_MAX_POLICIES];
+	u8 policy_count;
+};
+
+struct tpm2_policies {
+	u32 code[TPM2_MAX_POLICIES];
+	u8 *policies[TPM2_MAX_POLICIES];
+	u16 len[TPM2_MAX_POLICIES];
+	u8 count;
+	u16 hash;
+	u16 hash_size;
+};
+
+int tpm2_key_policy_process(struct tpm2_key_context *ctx,
+			    struct trusted_key_payload *payload);
+int tpm2_generate_policy_digest(struct tpm2_policies *pols, u32 hash,
+				u8 *policydigest, u32 *plen);
+int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len);
+int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
+			    u32 *handle);
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
index 3f6a9d01d1e5..0c241d000120 100644
--- a/security/keys/trusted-keys/tpm2key.asn1
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -1,11 +1,24 @@
 ---
 --- ASN.1 for for TPM 2.0 keys
 ---
+--- Note: This isn't quite the definition in the standard
+---       However, the Linux asn.1 parser doesn't understand
+---       [2] EXPLICIT SEQUENCE OF OPTIONAL
+---       So there's an extra intermediate TPMPolicySequence
+---       definition to work around this
 
 TPMKey ::= SEQUENCE {
 	type		OBJECT IDENTIFIER ({tpm2_key_type}),
 	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
+	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL,
 	parent		INTEGER ({tpm2_key_parent}),
 	pubkey		OCTET STRING ({tpm2_key_pub}),
 	privkey		OCTET STRING ({tpm2_key_priv})
 	}
+
+TPMPolicySequence ::= SEQUENCE OF TPMPolicy
+
+TPMPolicy ::= SEQUENCE {
+	commandCode		[0] EXPLICIT INTEGER ({tpm2_key_code}),
+	commandPolicy		[1] EXPLICIT OCTET STRING ({tpm2_key_policy})
+	}
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index f235637865b9..2130a27fcbff 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1065,6 +1065,8 @@ static void trusted_rcu_free(struct rcu_head *rcu)
 	struct trusted_key_payload *p;
 
 	p = container_of(rcu, struct trusted_key_payload, rcu);
+
+	kfree_sensitive(p->policies);
 	kfree_sensitive(p);
 }
 
@@ -1174,7 +1176,11 @@ static long trusted_read(const struct key *key, char *buffer,
  */
 static void trusted_destroy(struct key *key)
 {
-	kfree_sensitive(key->payload.data[0]);
+	struct trusted_key_payload *p;
+
+	p = key->payload.data[0];
+	kfree_sensitive(p->policies);
+	kfree_sensitive(p);
 }
 
 struct key_type key_type_trusted = {
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 905c5ca4d51c..98c65431ca75 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -17,6 +17,7 @@
 #include <asm/unaligned.h>
 
 #include "tpm2key.asn1.h"
+#include "tpm2-policy.h"
 
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
@@ -62,6 +63,21 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
 	}
 
+	if (payload->policies) {
+		u8 *encoded_pols;
+		u32 encoded_pol_len;
+		int ret;
+
+		ret = tpm2_encode_policy(payload->policies, &encoded_pols,
+					 &encoded_pol_len);
+		if (ret)
+			return ret;
+
+		work = asn1_encode_tag(work, end_work, 1, encoded_pols,
+				       encoded_pol_len);
+		kfree(encoded_pols);
+	}
+
 	/*
 	 * Assume both octet strings will encode to a 2 byte definite length
 	 *
@@ -85,14 +101,6 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	return work1 - payload->blob;
 }
 
-struct tpm2_key_context {
-	u32 parent;
-	const u8 *pub;
-	u32 pub_len;
-	const u8 *priv;
-	u32 priv_len;
-};
-
 static int tpm2_key_decode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 **buf)
@@ -115,6 +123,12 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (!blob)
 		return -ENOMEM;
 
+	ret = tpm2_key_policy_process(&ctx, payload);
+	if (ret) {
+		kfree(blob);
+		return ret;
+	}
+
 	*buf = blob;
 	options->keyhandle = ctx.parent;
 
@@ -248,6 +262,42 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (!options->keyhandle)
 		return -EINVAL;
 
+	if (options->pcrinfo_len != 0) {
+		struct tpm2_policies *pols;
+		static u8 *scratch;
+		/* 4 array len, 2 hash alg */
+		const int len = 4 + 2 + options->pcrinfo_len;
+
+		pols = kmalloc(sizeof(*pols) + len, GFP_KERNEL);
+		if (!pols)
+			return -ENOMEM;
+
+		pols->count = 1;
+		pols->len[0] = len;
+		scratch = (u8 *)(pols + 1);
+		pols->policies[0] = scratch;
+		pols->code[0] = TPM2_CC_POLICY_PCR;
+
+		put_unaligned_be32(1, &scratch[0]);
+		put_unaligned_be16(hash, &scratch[4]);
+		memcpy(&scratch[6], options->pcrinfo, options->pcrinfo_len);
+		payload->policies = pols;
+	}
+
+	if (options->policydigest_len != 0 && payload->policies) {
+		/* can't specify both a digest and a policy */
+		return -EINVAL;
+	}
+
+	if (payload->policies) {
+		rc = tpm2_generate_policy_digest(payload->policies,
+						 options->hash,
+						 options->policydigest,
+						 &options->policydigest_len);
+		if (rc)
+			return rc;
+	}
+
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	if (rc)
 		return rc;
@@ -456,21 +506,37 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	u16 data_len;
 	u8 *data;
 	int rc;
+	u32 policyhandle;
+
+	if (payload->policies && options->policyhandle)
+		/* can't have both a passed in policy and a key resident one */
+		return -EINVAL;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
 	if (rc)
 		return rc;
 
+	if (payload->policies) {
+		rc = tpm2_get_policy_session(chip, payload->policies,
+					     &policyhandle);
+		if (rc)
+			return rc;
+	} else {
+		policyhandle = options->policyhandle;
+	}
+
 	tpm_buf_append_u32(&buf, blob_handle);
 	tpm2_buf_append_auth(&buf,
-			     options->policyhandle ?
-			     options->policyhandle : TPM2_RS_PW,
+			     policyhandle ?
+			     policyhandle : TPM2_RS_PW,
 			     NULL /* nonce */, 0,
 			     TPM2_SA_CONTINUE_SESSION,
 			     options->blobauth /* hmac */,
 			     options->blobauth_len);
 
 	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
+	if (payload->policies)
+		tpm2_flush_context(chip, policyhandle);
 	if (rc > 0)
 		rc = -EPERM;
 
-- 
2.26.2

