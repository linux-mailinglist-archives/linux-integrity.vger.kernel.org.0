Return-Path: <linux-integrity+bounces-7808-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BECA5C26
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 01:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C68430D3F94
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586D17A2E8;
	Fri,  5 Dec 2025 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o52Qj5gY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015A748F;
	Fri,  5 Dec 2025 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764895769; cv=none; b=P9I5lxQKVAVcL6gCzMSTG0Tt82/Ipfqu63jgwacPN+8afRCTjUMR5Zg4Lf+CjR2V6ZFw9jB8AedVf6VQ5YQf8/Q2Ws0d2h6rXFxYi79OAUr+wtMd+fJ8VELCTDT9w8VUfiY6LAwnoNy8eMYrbu0uXtlHz4raRzq9Y55vsSc6CFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764895769; c=relaxed/simple;
	bh=hI8D1jmAdG9YoomhQsUNUMoGuS9zzlnfvniKoIdw2rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUYpj8c/frae8Fkrry/XKwE41tGbLyBDQiO0WSZUefWeFRqWJfZOrQ7ber8FKl6EtpQY8qLwtMgnEfB3ObNy1LJOtc6uPUSig/dsqoTtPZMmYreIkd9Jowv0NZR+KBPGiXaIRtKRCa4kgcYECX7iSlqJk9pBWprEIKV5gb+EDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o52Qj5gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EE8C4CEFB;
	Fri,  5 Dec 2025 00:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764895768;
	bh=hI8D1jmAdG9YoomhQsUNUMoGuS9zzlnfvniKoIdw2rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o52Qj5gY8bdLxCVcxXrIMzHEnJ1UcY1p4psSHluHeJU2fxm4TQ6h/yZiyEaL5uf8n
	 SkGkM8C/SGqhbOV/EAkWv41kFFcHolq0o/zyimpVazCNGlZQR3WOIhLRJ0LIhyNNC+
	 GxHwX0BzglZW4dCb/45TcDDDMJQzccxwaxW2WF2Z7JaDbt4yA2dzGHzsbzjVCZvtEa
	 GXSyqWUYjLSNl3EBkW0fi7qfhk3axtwm4FkobfgvoALzvfBKc1t8YEzmdabfDd6YSa
	 G8ZhMDId80AoSs1DcNRHGmMaGrOTTPD6u0G3oEpAC1E0AnECQPYf3gFvgVt8vrDEXD
	 eWHzPzNpZrd5w==
Date: Fri, 5 Dec 2025 02:49:24 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Re-orchestrate tpm2_read_public() calls
Message-ID: <aTIsFJobEyISTO_y@kernel.org>
References: <20251204223128.435109-1-jarkko@kernel.org>
 <aTIXOr3rpI9xufTl@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v1r8RKK0+KkMB8FT"
Content-Disposition: inline
In-Reply-To: <aTIXOr3rpI9xufTl@kernel.org>


--v1r8RKK0+KkMB8FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 05, 2025 at 01:20:30AM +0200, Jarkko Sakkinen wrote:
> On Fri, Dec 05, 2025 at 12:31:27AM +0200, Jarkko Sakkinen wrote:
> > tpm2_load_cmd() and tpm2_unseal_cmd() use the same parent, and calls to
> > tpm_buf_append_name() cause the exact same TPM2_ReadPublic command to be
> > sent to the chip, causing unnecessary traffic.
> > 
> > 1. Export tpm2_read_public in order to make it callable from 'trusted_tpm2'.
> > 2. Re-orchestrate tpm2_seal_trusted() and tpm2_unseal_trusted() in order to
> >    halve the name resolutions required:
> > 2a. Move tpm2_read_public() calls into trusted_tpm2.
> > 2b. Pass TPM name to tpm_buf_append_name().
> > 2c. Rework tpm_buf_append_name() to use the pre-resolved name.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> If ASN.1 blob would contain also name of the parent then zero
> tpm2_read_public() calls would be required i.e., the main bottleneck
> here inherits from the limitations of the file format itself.

Along the lines of attached patch.

BR, Jarkko

--v1r8RKK0+KkMB8FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-KEYS-trusted-Extend-TPMKey-ASN.1-definition-with-par.patch

From c5fc7e38aae838dd1190b33545a8b1a1696e9ce8 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Fri, 5 Dec 2025 01:53:33 +0200
Subject: [PATCH] KEYS: trusted: Extend TPMKey ASN.1 definition with
 'parentName'

Extend TPMKey ASN.1 definition [1] with an optional 'parentName' attribute
containing TPMT_HA blob for the parent. Encode this attribute for the
generated TPM keys, which allows skipping TPM2_ReadPublic when unsealing
the key.

[1] https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.txt

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/tpm2key.asn1   | 17 ++++-
 security/keys/trusted-keys/trusted_tpm2.c | 80 +++++++++++++++--------
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
index f57f869ad600..080f0e399982 100644
--- a/security/keys/trusted-keys/tpm2key.asn1
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -1,11 +1,26 @@
 ---
 --- ASN.1 for TPM 2.0 keys
 ---
+TPMPolicy ::= SEQUENCE {
+	commandCode	[0] EXPLICIT INTEGER,
+	commandPolicy	[1] EXPLICIT OCTET STRING
+}
+
+TPMAuthPolicy ::= SEQUENCE {
+	name		[0] EXPLICIT UTF8String OPTIONAL,
+	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy
+}
 
 TPMKey ::= SEQUENCE {
 	type		OBJECT IDENTIFIER ({tpm2_key_type}),
 	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
+	policy		[1] EXPLICIT SEQUENCE OF TPMPolicy OPTIONAL,
+	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
+	authPolicy	[3] EXPLICIT SEQUENCE OF TPMAuthPolicy OPTIONAL,
+	description	[4] EXPLICIT UTF8String OPTIONAL,
+	rsaParent	[5] EXPLICIT BOOLEAN OPTIONAL,
+	parentName	[6] EXPLICIT OCTET STRING ({tpm2_key_parent_name}),
 	parent		INTEGER ({tpm2_key_parent}),
 	pubkey		OCTET STRING ({tpm2_key_pub}),
 	privkey		OCTET STRING ({tpm2_key_priv})
-	}
+}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 88bafbcc011a..85fd34457431 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -20,16 +20,26 @@
 
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
 
+enum tpm_key_tag {
+	TPM_KEY_TAG_EMPTY_AUTH	= 0,
+	TPM_KEY_TAG_POLICY	= 1,
+	TPM_KEY_TAG_SECRET	= 2,
+	TPM_KEY_TAG_AUTH_POLICY	= 3,
+	TPM_KEY_TAG_DESCRIPTION = 4,
+	TPM_KEY_TAG_RSA_PARENT	= 5,
+	TPM_KEY_TAG_PARENT_NAME	= 6,
+};
+
 static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
-			   u8 *src, u32 len)
+			   u8 *src, u32 len, u8 *parent_name,
+			   u16 parent_name_size)
 {
 	const int SCRATCH_SIZE = PAGE_SIZE;
-	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
-	u8 *work = scratch, *work1;
-	u8 *end_work = scratch + SCRATCH_SIZE;
-	u8 *priv, *pub;
+	u8 *end_work, *end_name;
 	u16 priv_len, pub_len;
+	u8 *work, *work1;
+	u8 *priv, *pub;
 	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
@@ -40,9 +50,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	pub_len = get_unaligned_be16(src) + 2;
 	pub = src;
 
+	u8 *scratch __free(kfree) = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
 	if (!scratch)
 		return -ENOMEM;
 
+	work = scratch;
+	end_work = scratch + SCRATCH_SIZE;
+
 	work = asn1_encode_oid(work, end_work, tpm2key_oid,
 			       asn1_oid_len(tpm2key_oid));
 
@@ -50,13 +64,22 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
-			ret = PTR_ERR(w);
-			goto err;
-		}
-		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
+			return PTR_ERR(w);
+		work = asn1_encode_tag(work, end_work, TPM_KEY_TAG_EMPTY_AUTH,
+				       bool, w - bool);
 	}
 
+	u8 *name_encoded __free(kfree) = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	if (!name_encoded)
+		return -ENOMEM;
+
+	end_name = asn1_encode_octet_string(name_encoded,
+					    name_encoded + SCRATCH_SIZE,
+					    parent_name, parent_name_size);
+	work = asn1_encode_tag(work, end_work, TPM_KEY_TAG_PARENT_NAME,
+			       name_encoded, end_name - name_encoded);
+
 	/*
 	 * Assume both octet strings will encode to a 2 byte definite length
 	 *
@@ -65,8 +88,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
 		 "BUG: scratch buffer is too small")) {
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
@@ -79,15 +101,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	if (IS_ERR(work1)) {
 		ret = PTR_ERR(work1);
 		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	kfree(scratch);
 	return work1 - payload->blob;
-
-err:
-	kfree(scratch);
-	return ret;
 }
 
 struct tpm2_key_context {
@@ -96,11 +113,13 @@ struct tpm2_key_context {
 	u32 pub_len;
 	const u8 *priv;
 	u32 priv_len;
+	const u8 *name;
+	u32 name_len;
 };
 
 static int tpm2_key_decode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
-			   u8 **buf)
+			   u8 **buf, u8 *parent_name, u16 *parent_name_size)
 {
 	int ret;
 	struct tpm2_key_context ctx;
@@ -127,6 +146,8 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	blob += ctx.priv_len;
 
 	memcpy(blob, ctx.pub, ctx.pub_len);
+	memcpy(parent_name, ctx.name, ctx.name_len);
+	*parent_name_size = ctx.name_len;
 
 	return 0;
 }
@@ -190,6 +211,16 @@ int tpm2_key_priv(void *context, size_t hdrlen,
 	return 0;
 }
 
+int tpm2_key_parent_name(void *context, size_t hdrlen, unsigned char tag,
+			 const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->name = value;
+	ctx->name_len = vlen;
+
+	return 0;
+}
 /**
  * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
@@ -347,7 +378,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
-	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
+	blob_len = tpm2_key_encode(payload, options, &buf.data[offset],
+				   blob_len, parent_name, parent_name_size);
 	if (blob_len < 0)
 		rc = blob_len;
 
@@ -602,7 +634,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	 * Try to decode the provided blob as an ASN.1 blob. Assume that the
 	 * blob is in the legacy format if decoding does not end successfully.
 	 */
-	rc = tpm2_key_decode(payload, options, &blob);
+	rc = tpm2_key_decode(payload, options, &blob, &parent_name[0], &parent_name_size);
 	if (rc) {
 		blob = payload->blob;
 		payload->old_format = 1;
@@ -617,12 +649,6 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
-	rc = tpm2_read_public(chip, options->keyhandle, parent_name);
-	if (rc < 0)
-		goto out;
-
-	parent_name_size = rc;
-
 	rc = tpm2_load_cmd(chip, payload, options, parent_name,
 			   parent_name_size, blob, &blob_handle);
 	if (rc)
-- 
2.39.5


--v1r8RKK0+KkMB8FT--

