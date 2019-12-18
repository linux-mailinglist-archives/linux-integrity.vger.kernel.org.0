Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1FC123FB2
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRGgz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 01:36:55 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42596 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfLRGgz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 01:36:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 61FCD8EE18E;
        Tue, 17 Dec 2019 22:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576651015;
        bh=kHgALg3dHZKld9Ss/YmiXtNNlBxNNKf9el3/b5FJPFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P78UF3BdpzkxcdfgcjmGDYL0q8lHh3eIpz8fYOAQ1QqUlcaT8H802AYkKsKcb4bgv
         JqWLEJpkm8fVinRMLlqYtqoZnxvF4j9o7d0j3t3wRuyGw3xZPrkoJOxXYJxftIHWYh
         iiI5k343uzo1NbqE5W42jPH6F+TuH9Z2lTNJ43YM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y4DUma1L4vTv; Tue, 17 Dec 2019 22:36:55 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 46E2D8EE0DF;
        Tue, 17 Dec 2019 22:36:54 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v3 3/9] security: keys: trusted: use ASN.1 tpm2 key format for the blobs
Date:   Wed, 18 Dec 2019 15:31:36 +0900
Message-Id: <20191218063142.23033-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
References: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Modify the tpm2 key format blob output to export and import in the
ASN.1 form for tpm2 sealed object keys.  For compatibility with prior
trusted keys, the importer will also accept two tpm2b quantities
representing the public and private parts of the key.  However, the
export via keyctl pipe will only output the ASN.1 format.

The benefit of the ASN.1 format is that it's a standard and thus the
exported key can be used by userspace tools.  The format includes
policy specifications, thus it gets us out of having to construct
policy handles in userspace and the format includes the parent meaning
you don't have to keep passing it in each time.

This patch only implements basic handling for the ASN.1 format, so
keys with passwords but no policy.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

v2: Updated encode API, added length checks
---
 security/keys/trusted-keys/Makefile       |   2 +-
 security/keys/trusted-keys/tpm2key.asn1   |  23 ++++
 security/keys/trusted-keys/trusted_tpm1.c |   2 +-
 security/keys/trusted-keys/trusted_tpm2.c | 189 +++++++++++++++++++++++++++++-
 4 files changed, 209 insertions(+), 7 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2key.asn1

diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
index 7b73cebbb378..e0198641eff2 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 trusted-y += trusted_tpm1.o
-trusted-y += trusted_tpm2.o
+trusted-y += trusted_tpm2.o tpm2key.asn1.o
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
new file mode 100644
index 000000000000..1851b7c80f08
--- /dev/null
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -0,0 +1,23 @@
+---
+--- Note: This isn't quite the definition in the standard
+---       However, the Linux asn.1 parser doesn't understand
+---       [2] EXPLICIT SEQUENCE OF OPTIONAL
+---       So there's an extra intermediate TPMPolicySequence
+---       definition to work around this
+
+TPMKey ::= SEQUENCE {
+	type		OBJECT IDENTIFIER ({tpmkey_type}),
+	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
+	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL,
+	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
+	parent		INTEGER ({tpmkey_parent}),
+	pubkey		OCTET STRING ({tpmkey_pub}),
+	privkey		OCTET STRING ({tpmkey_priv})
+	}
+
+TPMPolicySequence ::= SEQUENCE OF TPMPolicy
+
+TPMPolicy ::= SEQUENCE {
+	commandCode		[0] EXPLICIT INTEGER,
+	commandPolicy		[1] EXPLICIT OCTET STRING
+	}
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index d2c5ec1e040b..d744a0d1cb89 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -991,7 +991,7 @@ static int trusted_instantiate(struct key *key,
 		goto out;
 	}
 
-	if (!options->keyhandle) {
+	if (!options->keyhandle && !tpm2) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 08ec7f48f01d..cf10fea5410a 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2014 Intel Corporation
  */
 
+#include <linux/asn1_encoder.h>
+#include <linux/oid_registry.h>
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/tpm.h>
@@ -12,6 +14,10 @@
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
 
+#include <asm/unaligned.h>
+
+#include "tpm2key.asn1.h"
+
 static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
@@ -20,6 +26,160 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
+static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
+
+static int tpm2_key_encode(struct trusted_key_payload *payload,
+			   struct trusted_key_options *options,
+			   u8 *src, u32 len)
+{
+	const int SCRATCH_SIZE = PAGE_SIZE;
+	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	u8 *work = scratch, *work1;
+	int work_len = SCRATCH_SIZE, work1_len;
+	u8 *priv, *pub;
+	u16 priv_len, pub_len;
+
+	priv_len = get_unaligned_be16(src);
+	src += 2;
+	priv = src;
+	src += priv_len;
+	pub_len = get_unaligned_be16(src);
+	src += 2;
+	pub = src;
+
+	if (!scratch)
+		return -ENOMEM;
+
+	asn1_encode_oid(&work, &work_len, tpm2key_oid,
+			asn1_oid_len(tpm2key_oid));
+	if (options->blobauth[0] == 0) {
+		unsigned char bool[3], *w = bool;
+		int bool_len = sizeof(bool);
+		/* tag 0 is emptyAuth */
+		if (WARN(asn1_encode_boolean(&w, &bool_len, true) < 0,
+			 "BUG: Boolean failed to encode"))
+			return 0;
+		asn1_encode_tag(&work, &work_len, 0, bool, w - bool);
+	}
+	asn1_encode_integer(&work, &work_len, options->keyhandle);
+	/*
+	 * Assume both octet strings will encode to a 2 byte definite length
+	 *
+	 * Note: For a well behaved TPM, this warning should never
+	 * trigger, so if it does there's something nefarious going on
+	 */
+	if (WARN(work - scratch + pub_len + priv_len + 8 > SCRATCH_SIZE,
+		 "BUG: scratch buffer is too small"))
+		return 0;
+	asn1_encode_octet_string(&work, &work_len, pub, pub_len);
+	asn1_encode_octet_string(&work, &work_len, priv, priv_len);
+
+	work1 = payload->blob;
+	work1_len = MAX_BLOB_SIZE;
+	if (WARN(asn1_encode_sequence(&work1, &work1_len, scratch,
+				      work - scratch) < 0,
+		 "BUG: ASN.1 encoder failed"))
+		return 0;
+
+	return work1 - payload->blob;
+}
+
+struct tpm2key_context {
+	u32 parent;
+	const u8 *pub;
+	u32 pub_len;
+	const u8 *priv;
+	u32 priv_len;
+};
+
+static int tpm2_key_decode(struct trusted_key_payload *payload,
+			   struct trusted_key_options *options,
+			   u8 **buf)
+{
+	int ret;
+	struct tpm2key_context ctx;
+	u8 *blob;
+
+	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
+			       payload->blob_len);
+	if (ret < 0)
+		return ret;
+
+	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
+		return -EINVAL;
+
+	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	if (!blob)
+		return -ENOMEM;
+
+	*buf = blob;
+	options->keyhandle = ctx.parent;
+	put_unaligned_be16(ctx.priv_len, blob);
+	blob += 2;
+	memcpy(blob, ctx.priv, ctx.priv_len);
+	blob += ctx.priv_len;
+	put_unaligned_be16(ctx.pub_len, blob);
+	blob += 2;
+	memcpy(blob, ctx.pub, ctx.pub_len);
+
+	return 0;
+}
+
+int tpmkey_parent(void *context, size_t hdrlen,
+		  unsigned char tag,
+		  const void *value, size_t vlen)
+{
+	struct tpm2key_context *ctx = context;
+	const u8 *v = value;
+	int i;
+
+	ctx->parent = 0;
+	for (i = 0; i < vlen; i++) {
+		ctx->parent <<= 8;
+		ctx->parent |= v[i];
+	}
+	return 0;
+}
+
+int tpmkey_type(void *context, size_t hdrlen,
+		unsigned char tag,
+		const void *value, size_t vlen)
+{
+	enum OID oid = look_up_OID(value, vlen);
+
+	if (oid != OID_TPMSealedData) {
+		char buffer[50];
+
+		sprint_oid(value, vlen, buffer, sizeof(buffer));
+		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
+			 buffer);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int tpmkey_pub(void *context, size_t hdrlen,
+	       unsigned char tag,
+	       const void *value, size_t vlen)
+{
+	struct tpm2key_context *ctx = context;
+
+	ctx->pub = value;
+	ctx->pub_len = vlen;
+	return 0;
+}
+
+int tpmkey_priv(void *context, size_t hdrlen,
+		unsigned char tag,
+		const void *value, size_t vlen)
+{
+	struct tpm2key_context *ctx = context;
+
+	ctx->priv = value;
+	ctx->priv_len = vlen;
+	return 0;
+}
+
 /**
  * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
@@ -79,6 +239,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (i == ARRAY_SIZE(tpm2_hash_map))
 		return -EINVAL;
 
+	if (!options->keyhandle)
+		return -EINVAL;
+
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	if (rc)
 		return rc;
@@ -144,8 +307,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
-	payload->blob_len = blob_len;
+	payload->blob_len =
+		tpm2_key_encode(payload, options,
+				&buf.data[TPM_HEADER_SIZE + 4],
+				blob_len);
 
 out:
 	tpm_buf_destroy(&buf);
@@ -156,6 +321,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		else
 			rc = -EPERM;
 	}
+	if (payload->blob_len < 0)
+		return payload->blob_len;
 
 	return rc;
 }
@@ -182,13 +349,23 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
+	u8 *blob;
 	int rc;
 
-	private_len = be16_to_cpup((__be16 *) &payload->blob[0]);
+	rc = tpm2_key_decode(payload, options, &blob);
+	if (rc)
+		/* old form */
+		blob = payload->blob;
+
+	/* new format carries keyhandle but old format doesn't */
+	if (!options->keyhandle)
+		return -EINVAL;
+
+	private_len = be16_to_cpup((__be16 *) &blob[0]);
 	if (private_len > (payload->blob_len - 2))
 		return -E2BIG;
 
-	public_len = be16_to_cpup((__be16 *) &payload->blob[2 + private_len]);
+	public_len = be16_to_cpup((__be16 *) &blob[2 + private_len]);
 	blob_len = private_len + public_len + 4;
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
@@ -204,7 +381,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			     options->keyauth /* hmac */,
 			     TPM_DIGEST_SIZE);
 
-	tpm_buf_append(&buf, payload->blob, blob_len);
+	tpm_buf_append(&buf, blob, blob_len);
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
@@ -217,6 +394,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
+	if (blob != payload->blob)
+		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
-- 
2.16.4

