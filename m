Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95928117C1E
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 01:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLJAHd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 19:07:33 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37986 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfLJAHd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 19:07:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 07BCB8EE112;
        Mon,  9 Dec 2019 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575936453;
        bh=GgfynOpRQRXogDBFZ1EQxy/Ngs4HkeChvwp8iw6AHNw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VJB3V7dRGzRF+GDdXuwm3MtGrEWIQRlvPj+3qowANSRGX6elWcZ8SZG/smXBsGD8w
         cH9jo6hbySIa1LYEPd+1S1zKUKV1+7vyEuvs/O9IeuIFBhaHLV1B3fb3ZLEYymvufk
         md8fH0T9iB25eB4bn67/fut7pWUbV+6RPst5tD2Q=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wjpsM6kmcqGc; Mon,  9 Dec 2019 16:07:32 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8DA878EE0FC;
        Mon,  9 Dec 2019 16:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575936452;
        bh=GgfynOpRQRXogDBFZ1EQxy/Ngs4HkeChvwp8iw6AHNw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TjTP/l21zNR0TEtq6cllbqWKSvCtXlcFpukZDIBpxQpi8BbFLndjAMH2OYv0tg1Q4
         VX+X57/UfgFVL7Aok2xN9Y+sCc9PLUox+Un2YGw9AjRFa8BM1LQUMbEMoIc5YclEDc
         GJTk/h/V3NotlAmVOu0coHLbcVSBLJ4cZK9T+0cQ=
Message-ID: <1575936451.31378.54.camel@HansenPartnership.com>
Subject: [PATCH v2 4/8] security: keys: trusted: use ASN.1 tpm2 key format
 for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 09 Dec 2019 16:07:31 -0800
In-Reply-To: <1575936272.31378.50.camel@HansenPartnership.com>
References: <1575936272.31378.50.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
 security/keys/trusted-keys/trusted_tpm2.c | 181 +++++++++++++++++++++++++++++-
 4 files changed, 201 insertions(+), 7 deletions(-)
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
index 08ec7f48f01d..6ae3197f767f 100644
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
@@ -20,6 +26,152 @@ static struct tpm2_hash tpm2_hash_map[] = {
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
+	asn1_encode_oid(&work, tpm2key_oid, asn1_oid_len(tpm2key_oid));
+	if (options->blobauth[0] == 0) {
+		unsigned char bool[3], *w = bool;
+		/* tag 0 is emptyAuth */
+		asn1_encode_boolean(&w, true);
+		asn1_encode_tag(&work, 0, bool, w - bool);
+	}
+	asn1_encode_integer(&work, options->keyhandle,
+			    work - scratch + SCRATCH_SIZE);
+	/*
+	 * Assume both ovtet strings will encode to a 2 byte definite length
+	 *
+	 * Note: For a well behaved TPM, this warning should never
+	 * trigger, so if it does there's something nefarious going on
+	 */
+	if (WARN(work - scratch + pub_len + priv_len + 8 > SCRATCH_SIZE,
+		 "BUG: scratch buffer is too small"))
+		return -EINVAL;
+	asn1_encode_octet_string(&work, pub, pub_len);
+	asn1_encode_octet_string(&work, priv, priv_len);
+
+	work1 = payload->blob;
+	asn1_encode_sequence(&work1, scratch, work - scratch);
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
@@ -79,6 +231,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (i == ARRAY_SIZE(tpm2_hash_map))
 		return -EINVAL;
 
+	if (!options->keyhandle)
+		return -EINVAL;
+
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	if (rc)
 		return rc;
@@ -144,8 +299,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -156,6 +313,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		else
 			rc = -EPERM;
 	}
+	if (payload->blob_len < 0)
+		return payload->blob_len;
 
 	return rc;
 }
@@ -182,13 +341,23 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
@@ -204,7 +373,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			     options->keyauth /* hmac */,
 			     TPM_DIGEST_SIZE);
 
-	tpm_buf_append(&buf, payload->blob, blob_len);
+	tpm_buf_append(&buf, blob, blob_len);
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
@@ -217,6 +386,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
+	if (blob != payload->blob)
+		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
-- 
2.16.4

