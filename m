Return-Path: <linux-integrity+bounces-2609-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 177038CE5AF
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468C6B208DE
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D3186263;
	Fri, 24 May 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="roBPqO6r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2A86640;
	Fri, 24 May 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555959; cv=none; b=Ryz9RRgnpLxp7dVaA4GQlIcqt65L9FPUIkWRlW5btcFMXdNgaABe1te02/5AnnT2YKkYucnKSqWEXE8sUyNe/D5g+9xzSX+Yj2UD2Wadj6VElh4QWXtvlzlXr5K9XIb2QlhmNqzNDyEDKEZkskhlCs5EimYiE4VjYYI0/npWPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555959; c=relaxed/simple;
	bh=9dFiZ+XSknK9pTiu6qLHoLR7mBuSpmYjeMB3X9Bn5N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EH2zO9WtCClHEplcsHdLpUmv7Bf8aPCXAd3TIZuIDOx5JAIqRP0JK8/nwPowVo8rbznJRniN217CAU55apsgOr/cYtsN/OD6nX4qK4Z7EuMxqCyrLPOQZSaGw22Lkkej8+zT6odyCcoN8JvyZsW8E/V8tTEyJ4R0QKokC6wLSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=roBPqO6r; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555956;
	bh=9dFiZ+XSknK9pTiu6qLHoLR7mBuSpmYjeMB3X9Bn5N8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=roBPqO6rhGL0xt6g1xQ56nQoE7CDfEc4GpavstzBu8VDF/0+/ogM5sBm/KL34rr0n
	 00LXdADKUPesGprmF70xsTNKE/6w+h/yBfZqIOcwyvv9DBf1FiSVMnRTh3nytk26Oz
	 pjO/paMenJ7ieokfmo55t1ttuDzi+yazd5RTK4nk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E051B1287771;
	Fri, 24 May 2024 09:05:56 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 81WnPpOPthrw; Fri, 24 May 2024 09:05:56 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 60B0D1280355;
	Fri, 24 May 2024 09:05:56 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org
Subject: [PATCH 3/6] KEYS: trusted: add PCR policy to TPM2 keys
Date: Fri, 24 May 2024 09:04:56 -0400
Message-Id: <20240524130459.21510-4-James.Bottomley@HansenPartnership.com>
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

This commit adds the ability to specify a PCR lock policy to TPM2
keys.  There is a complexity in that keys that contain both a password
(blobauth) and a PCR lock have to have two policy statements
(POLICY_PCR and POLICY_AUTHVALUE).  The way to construct a pcrinfo
statement for a key is simply to use the TPMS_PCR_SELECT structure to
specify the PCRs and follow this by a hash of all their values in
order of ascending PCR number.

To construct a policy around the value of the resettable PCR 16 using
the sha256 bank, first reset the pcr to zero giving a hash of all
zeros as:

66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925

Then the TPMS_PCR_SELECT value for sha256 bank PCR 16 is

000b03000001

So create a new 32 byte key with a policy locking the key to this
value of PCR 16 with a parent key of 81000001 would be:

keyctl add trusted kmk "new 32 keyhandle=0x81000001 pcrinfo=000b0300000166687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925" @u

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 .../security/keys/trusted-encrypted.rst       |  53 ++-
 include/keys/trusted-type.h                   |   5 +-
 include/linux/tpm.h                           |  16 +
 security/keys/trusted-keys/Kconfig            |   2 +
 security/keys/trusted-keys/Makefile           |   3 +
 security/keys/trusted-keys/tpm2-policy.c      | 325 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  53 +++
 security/keys/trusted-keys/tpm2key.asn1       |  13 +
 security/keys/trusted-keys/trusted_core.c     |   7 +-
 security/keys/trusted-keys/trusted_tpm2.c     | 147 +++++++-
 10 files changed, 606 insertions(+), 18 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index f4d7e162d5e4..c37c08956ec1 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -217,7 +217,10 @@ Usage::
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
@@ -343,6 +346,37 @@ Load a trusted key from the saved blob::
     f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409c22b
     e4a8aea2b607ec96931e6f4d4fe563ba
 
+Create a trusted key on TPM 2.0 using an all zero value of PCR16 and
+using the NV storage root 81000001 as the parent::
+
+    $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 pcrinfo=000b0300000166687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925" @u
+
+Note the TPMS_PCR_SELECT value for sha256 bank PCR 16 is 000b03000001
+because all current TPMs have 24 PCRs, so the initial 000b says sha256
+bank (other possible banks are sha1=0004; sha384=000c; sha512=000d),
+03 says there are three following bytes of selection and then because
+the bytes are big endian, 16 is bit zero of byte 2. the hash is the
+sha256 sum of all zeros (the value of PCR 16)::
+
+    $ dd if=/dev/zero bs=1 count=32 2>/dev/null|sha256sum
+    66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925
+
+If you want to compute a current PCR hash value, simply take the
+hashes of multiple PCRs (in ascending order) and compute the sha256sum
+over the total:
+
+    $ { cat /sys/class/tpm/tpm0/pcr-sha256/7; cat /sys/class/tpm/tpm0/pcr-sha256/16; }|xxd -r -p|sha256sum
+
+Then use this value to append to a TPMS_PCR_SELECT (for 7 and 16 that
+would be 000b03800001) to the calculated hash as before.  Note also
+that the hash of the PCR registers has to use the name algorithm hash
+(the keyctl option hash=) not the bank algorithm hash.  So to select
+the sha1 pcr16 bank you'd say::
+
+    keyctl add trusted kmk "new 32 keyhandle=0x81000001 pcrinfo=000403000001de47c9b27eb8d300dbb5f2c353e632c393262cf06340c4fa7f1b40c4cbd36f90" @u
+
+because the trailing hash is the sha256sum of 20 zero bytes.
+
 Reseal (TPM specific) a trusted key under new PCR values::
 
     $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
@@ -425,11 +459,17 @@ policy::
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
@@ -455,6 +495,17 @@ is false or not present, the key requires an explicit authorization
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
index 4eb64548a74f..5d1d481a8a19 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -20,9 +20,11 @@
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
@@ -31,6 +33,7 @@ struct trusted_key_payload {
 	unsigned char old_format;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
+	struct tpm2_policies *policies;
 };
 
 struct trusted_key_options {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index dc2dd98cf104..154efceec0a4 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -248,7 +248,9 @@ enum tpm2_return_codes {
 	TPM2_RC_SUCCESS		= 0x0000,
 	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
 	TPM2_RC_HANDLE		= 0x008B,
+	TPM2_RC_AUTH_FAIL	= 0x008E,
 	TPM2_RC_INTEGRITY	= 0x009F,
+	TPM2_RC_BAD_AUTH	= 0x00A2,
 	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
 	TPM2_RC_FAILURE		= 0x0101,
 	TPM2_RC_DISABLED	= 0x0120,
@@ -259,6 +261,18 @@ enum tpm2_return_codes {
 	TPM2_RC_RETRY		= 0x0922,
 };
 
+static inline int tpm2_error_code(u32 rc)
+{
+	if ((rc & 0x0180) == 0)
+		/* TPM 1.2 error */
+		return -1;
+	if ((rc & 0x0080) == 0)
+		/* Error or Warning */
+		return rc;
+	/* strip off encoded parameter, handle or session */
+	return rc & 0x00ff;
+}
+
 enum tpm2_command_codes {
 	TPM2_CC_FIRST		        = 0x011F,
 	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
@@ -276,12 +290,14 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
 	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
+	TPM2_CC_POLICY_AUTHVALUE	= 0x016B,
 	TPM2_CC_READ_PUBLIC		= 0x0173,
 	TPM2_CC_START_AUTH_SESS		= 0x0176,
 	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
 	TPM2_CC_GET_CAPABILITY	        = 0x017A,
 	TPM2_CC_GET_RANDOM	        = 0x017B,
 	TPM2_CC_PCR_READ	        = 0x017E,
+	TPM2_CC_POLICY_PCR		= 0x017F,
 	TPM2_CC_PCR_EXTEND	        = 0x0182,
 	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
 	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index 1fb8aa001995..da271679330b 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -8,6 +8,8 @@ config TRUSTED_KEYS_TPM
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 	select CRYPTO_HASH_INFO
 	select ASN1_ENCODER
 	select OID_REGISTRY
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index f0f3b27f688b..1d22d9821876 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -10,6 +10,9 @@ trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm1.o
 $(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
 trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
 trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
+ifeq ($(CONFIG_TCG_TPM2_HMAC),y)
+trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2-policy.o
+endif
 
 trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
 
diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
new file mode 100644
index 000000000000..8c3a09762c10
--- /dev/null
+++ b/security/keys/trusted-keys/tpm2-policy.c
@@ -0,0 +1,325 @@
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
+		case TPM2_CC_POLICY_PCR:
+		case TPM2_CC_POLICY_AUTHVALUE:
+			break;
+		default:
+			pr_info("tpm2 policy 0x%x is unsupported\n",
+				pols->code[i]);
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
+	u16 name_alg;
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
+	if (ret)
+		goto out;
+
+	/* capture the hash and size */
+
+	/* the hash is the second algorithm (the nameAlg) */
+	name_alg = get_unaligned_be16(&ctx->pub[4]);
+	pols->hash = tpm2_alg_to_crypto(name_alg);
+
+	if (pols->hash < 0)
+		ret = -EINVAL;
+
+	/* and the digest appears after the attributes */
+	pols->hash_size = get_unaligned_be16(&ctx->pub[10]);
+
+ out:
+	if (ret) {
+		kfree(pols);
+		payload->policies = NULL;
+	}
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
+		if (len)
+			crypto_shash_update(sdesc, policy, len);
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
+int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols)
+{
+	int i, rc;
+	u32 handle;
+	const char *failure;
+
+	rc = tpm2_start_policy_session(chip, &handle, pols->hash);
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
+		tpm_buf_append_u32(&buf, handle);
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
+
+		default:
+			failure = "unknown policy";
+			if (pols->len[i])
+				tpm_buf_append(&buf, pols->policies[i],
+					       pols->len[i]);
+
+			break;
+		}
+
+		rc = tpm_transmit_cmd(chip, &buf, 0, "updating policy");
+		tpm_buf_destroy(&buf);
+		if (rc) {
+			pr_notice("TPM policy %s failed, rc=%d\n",
+				  failure, rc);
+			tpm2_end_auth_session(chip);
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/trusted-keys/tpm2-policy.h
new file mode 100644
index 000000000000..b20e9c3e2f06
--- /dev/null
+++ b/security/keys/trusted-keys/tpm2-policy.h
@@ -0,0 +1,53 @@
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
+	int hash;		/* crypto not TPM hash algorithm */
+	u16 hash_size;
+};
+
+#ifdef CONFIG_TCG_TPM2_HMAC
+int tpm2_key_policy_process(struct tpm2_key_context *ctx,
+			    struct trusted_key_payload *payload);
+int tpm2_generate_policy_digest(struct tpm2_policies *pols, u32 hash,
+				u8 *policydigest, u32 *plen);
+int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len);
+int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols);
+#else
+static inline int tpm2_key_policy_process(struct tpm2_key_context *ctx,
+					  struct trusted_key_payload *payload)
+{
+	return 0;
+}
+static inline int tpm2_generate_policy_digest(struct tpm2_policies *pols,
+					      u32 hash,
+					      u8 *policydigest, u32 *plen)
+{
+	return -EINVAL;
+}
+static inline int tpm2_encode_policy(struct tpm2_policies *pols,
+				     u8 **data, u32 *len)
+{
+	return -EINVAL;
+}
+static inline int tpm2_get_policy_session(struct tpm_chip *chip,
+					  struct tpm2_policies *pols)
+{
+	return -EINVAL;
+}
+#endif
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
index f57f869ad600..1684bd8f725e 100644
--- a/security/keys/trusted-keys/tpm2key.asn1
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -1,11 +1,24 @@
 ---
 --- ASN.1 for TPM 2.0 keys
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
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 5113aeae5628..53f0f15b0f59 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -221,6 +221,7 @@ static void trusted_rcu_free(struct rcu_head *rcu)
 	struct trusted_key_payload *p;
 
 	p = container_of(rcu, struct trusted_key_payload, rcu);
+	kfree_sensitive(p->policies);
 	kfree_sensitive(p);
 }
 
@@ -311,7 +312,11 @@ static long trusted_read(const struct key *key, char *buffer,
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
index 94ff9ccae66e..64c922bbc36c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -17,6 +17,7 @@
 #include <asm/unaligned.h>
 
 #include "tpm2key.asn1.h"
+#include "tpm2-policy.h"
 
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
 
@@ -54,6 +55,21 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
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
@@ -77,14 +93,6 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
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
@@ -107,6 +115,12 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
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
 
@@ -223,16 +237,85 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	off_t offset = TPM_HEADER_SIZE;
 	struct tpm_buf buf, sized;
 	int blob_len = 0;
-	int hash = tpm2_crypto_to_alg(options->hash);
+	int name_alg = tpm2_crypto_to_alg(options->hash);
 	u32 flags;
 	int rc;
+	static const int POLICY_SIZE = 2 * PAGE_SIZE;
+	u8 *scratch = NULL;
+	const bool generate_policy = options->pcrinfo_len;
 
-	if (hash < 0)
+	if (name_alg < 0)
 		return -EINVAL;
 
 	if (!options->keyhandle)
 		return -EINVAL;
 
+
+	if (generate_policy && payload->policies)
+		/*
+		 * can't specify both policy construction options
+		 * and passed in policy set
+		 */
+		return -EINVAL;
+
+	if (generate_policy) {
+		struct tpm2_policies *pols;
+
+		pols = kmalloc(POLICY_SIZE, GFP_KERNEL);
+		if (!pols)
+			return -ENOMEM;
+		pols->count = 0;
+		payload->policies = pols;
+		scratch = (u8 *)(pols + 1);
+	}
+
+	if (options->pcrinfo_len) {
+		struct tpm2_policies *pols = payload->policies;
+		int i;
+		/* 4 array len */
+		const int len = 4 + options->pcrinfo_len;
+
+		i = pols->count++;
+		pols->len[i] = len;
+		pols->policies[i] = scratch;
+		pols->code[i] = TPM2_CC_POLICY_PCR;
+
+		/* only a single TPMS_PCR_SELECTION */
+		put_unaligned_be32(1, &scratch[0]);
+		memcpy(&scratch[4], options->pcrinfo, options->pcrinfo_len);
+		scratch += len;
+	}
+
+	if (options->policydigest_len != 0 && payload->policies)
+		/* can't specify both a digest and a policy */
+		return -EINVAL;
+
+	/*
+	 * if we already have a policy, we have to add authorization
+	 * to it.  If we don't, we can simply follow the usual
+	 * non-policy route.
+	 */
+	if (generate_policy && options->blobauth_len) {
+		struct tpm2_policies *pols;
+		int i;
+
+		pols = payload->policies;
+		i = pols->count++;
+
+		/* the TPM2_PolicyPassword command has no payload */
+		pols->len[i] = 0;
+		pols->code[i] = TPM2_CC_POLICY_AUTHVALUE;
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
 	rc = tpm_try_get_ops(chip);
 	if (rc)
 		return rc;
@@ -271,7 +354,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* public */
 	tpm_buf_reset_sized(&sized);
 	tpm_buf_append_u16(&sized, TPM_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&sized, hash);
+	tpm_buf_append_u16(&sized, name_alg);
 
 	/* key properties */
 	flags = 0;
@@ -467,9 +550,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	u8 *data;
 	int rc;
 
-	rc = tpm2_start_auth_session(chip);
-	if (rc)
-		return rc;
+	if (payload->policies && options->policyhandle)
+		/* can't have both a passed in policy and a key resident one */
+		return -EINVAL;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
 	if (rc) {
@@ -477,6 +560,13 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
+	if (payload->policies)
+		rc = tpm2_get_policy_session(chip, payload->policies);
+	else
+		rc = tpm2_start_auth_session(chip);
+	if (rc)
+		goto out;
+
 	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
 
 	if (!options->policyhandle) {
@@ -505,8 +595,14 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
-	if (rc > 0)
+	if (rc > 0) {
+		rc = tpm2_error_code(rc);
+		if (rc == TPM2_RC_BAD_AUTH)
+			pr_info("Bad blobauth\n");
+		else if (rc == TPM2_RC_AUTH_FAIL)
+			pr_info("Bad blobauth (DA Counter incremented)\n");
 		rc = -EPERM;
+	}
 
 	if (!rc) {
 		data_len = be16_to_cpup(
@@ -574,3 +670,24 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 
 	return rc;
 }
+
+/*
+ * weak symbols for policy statements in tpm2key.asn1 in case
+ * tpm2-policy.c can't be built
+ */
+
+int __weak tpm2_key_code(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	pr_err("TPM key policy is unsupported without CONFIG_TCG_TPM2_HMAC=Y\n");
+
+	return -EINVAL;
+}
+
+int __weak tpm2_key_policy(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	return -EINVAL;
+}
-- 
2.35.3


