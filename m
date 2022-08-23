Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4055459EF33
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 00:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiHWW0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiHWW0P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFB87685
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bf22so15262981pjb.4
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2ncyxa+e8puSkzyAo28dlynzalbwgiQJVy99ctIQYXQ=;
        b=Yafelakgwq5oLYYTlKWk4gtQoYKcyYn9otte8CgXghwEJlBijSWB4wKveUY3edwMIP
         Bjzf/CzbNPaR776m7/QUXarSah1IO5SxkIt5LbTPpceurSyoiEHAgxf5jaBm6R20S5Yo
         ZLpLG2SmcqRUQ1zz5x7rAqLOnJMbnFr2f9rYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2ncyxa+e8puSkzyAo28dlynzalbwgiQJVy99ctIQYXQ=;
        b=r6MwjOa04UXYJO/lmYINk40q2ozBi+Mxf5gy0ROE4RbsZvhAhmFH5051UqqPzZtS92
         82P0iO1WDIUBC8F3Wqw7hU9nLpcdxJjnpFqflcpSU99dprhuo7p81VeSVDmMsI4o/670
         gzfmIcllk+KBdeEncV7QvyEVtrx6gAVmd9ln+EjFYFgI9vSYuHrg7x2qStfFxy60+vm8
         cySbMX+E6FiXRXF9vFkYpoCGuRXSpMh1BEvFCNJmljH81r+EpkqldyfFifZ6pslnGZ8g
         8w2vB114apLvu5YW+06y1fJW3gmThsvClMqJavyFmowjKt+p08fKxestdjNmi5N2WZb2
         7MGQ==
X-Gm-Message-State: ACgBeo0FgtNSi2VvKhzrBZb4phdFypB2rSd4gSrDXG9ZpkYCH2nagqaO
        2TfkhGW+1JeJQSLEvXRXBGrFng==
X-Google-Smtp-Source: AA6agR4ueU8fQBN/JYWXCi3IJqLo6KhUgY4cT5WpRS70mkceXPZWF2eDQDlqQTsxIuB8GlyzGukQ0g==
X-Received: by 2002:a17:902:f550:b0:172:fe5d:aa0a with SMTP id h16-20020a170902f55000b00172fe5daa0amr5532628plf.170.1661293565132;
        Tue, 23 Aug 2022 15:26:05 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11256292pfa.150.2022.08.23.15.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:26:04 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Evan Green <evgreen@chromium.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 03/10] security: keys: trusted: Include TPM2 creation data
Date:   Tue, 23 Aug 2022 15:25:19 -0700
Message-Id: <20220823152108.v2.3.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220823222526.1524851-1-evgreen@chromium.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In addition to the private key and public key, the TPM2_Create
command may also return creation data, a creation hash, and a creation
ticket. These fields allow the TPM to attest to the contents of a
specified set of PCRs at the time the trusted key was created. Encrypted
hibernation will use this to ensure that PCRs settable only by the
kernel were set properly at the time of creation, indicating this is an
authentic hibernate key.

Encode these additional parameters into the ASN.1 created to represent
the key blob. The new fields are made optional so that they don't bloat
key blobs which don't need them, and to ensure interoperability with
old blobs.

---

(no changes since v1)

This is a replacement for Matthew's original patch here:
https://patchwork.kernel.org/patch/12096489/

That patch was written before the exported key format was switched to
ASN.1. This patch accomplishes the same thing (saving, loading, and
getting pointers to the creation data) while utilizing the new ASN.1
format.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
 include/keys/trusted-type.h               |   8 +
 security/keys/trusted-keys/tpm2key.asn1   |   5 +-
 security/keys/trusted-keys/trusted_tpm2.c | 202 +++++++++++++++++++---
 3 files changed, 190 insertions(+), 25 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 4eb64548a74f1a..209086fed240a5 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -22,15 +22,23 @@
 #define MAX_BLOB_SIZE			512
 #define MAX_PCRINFO_SIZE		64
 #define MAX_DIGEST_SIZE			64
+#define MAX_CREATION_DATA		412
+#define MAX_TK				76
 
 struct trusted_key_payload {
 	struct rcu_head rcu;
 	unsigned int key_len;
 	unsigned int blob_len;
+	unsigned int creation_len;
+	unsigned int creation_hash_len;
+	unsigned int tk_len;
 	unsigned char migratable;
 	unsigned char old_format;
 	unsigned char key[MAX_KEY_SIZE + 1];
 	unsigned char blob[MAX_BLOB_SIZE];
+	unsigned char *creation;
+	unsigned char *creation_hash;
+	unsigned char *tk;
 };
 
 struct trusted_key_options {
diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
index f57f869ad60068..1bfbf290e523a3 100644
--- a/security/keys/trusted-keys/tpm2key.asn1
+++ b/security/keys/trusted-keys/tpm2key.asn1
@@ -7,5 +7,8 @@ TPMKey ::= SEQUENCE {
 	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
 	parent		INTEGER ({tpm2_key_parent}),
 	pubkey		OCTET STRING ({tpm2_key_pub}),
-	privkey		OCTET STRING ({tpm2_key_priv})
+	privkey		OCTET STRING ({tpm2_key_priv}),
+	creationData	[1] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_data}),
+	creationHash	[2] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_hash}),
+	creationTk	[3] EXPLICIT OCTET STRING OPTIONAL ({tpm2_key_creation_tk})
 	}
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 2b2c8eb258d5bd..1f166d4fa307a9 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -37,7 +37,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	u8 *work = scratch, *work1;
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
+	u8 *creation_data = NULL, *creation_hash = NULL, *creation_tk = NULL;
+	u16 creation_data_len, creation_hash_len = 0, creation_tk_len = 0;
 	u16 priv_len, pub_len;
+	int rc;
 
 	priv_len = get_unaligned_be16(src) + 2;
 	priv = src;
@@ -46,6 +49,26 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 
 	pub_len = get_unaligned_be16(src) + 2;
 	pub = src;
+	src += pub_len;
+
+	creation_data_len = get_unaligned_be16(src);
+	if (creation_data_len) {
+		creation_data_len += 2;
+		creation_data = src;
+		src += creation_data_len;
+
+		creation_hash_len = get_unaligned_be16(src) + 2;
+		creation_hash = src;
+		src += creation_hash_len;
+
+		/*
+		 * The creation ticket (TPMT_TK_CREATION) consists of a 2 byte
+		 * tag, 4 byte handle, and then a TPM2B_DIGEST, which is a 2
+		 * byte length followed by data.
+		 */
+		creation_tk_len = get_unaligned_be16(src + 6) + 8;
+		creation_tk = src;
+	}
 
 	if (!scratch)
 		return -ENOMEM;
@@ -63,26 +86,81 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	}
 
 	/*
-	 * Assume both octet strings will encode to a 2 byte definite length
+	 * Assume each octet string will encode to a 2 byte definite length.
+	 * Each optional octet string consumes one extra byte.
 	 *
-	 * Note: For a well behaved TPM, this warning should never
-	 * trigger, so if it does there's something nefarious going on
+	 * Note: For a well behaved TPM, this warning should never trigger, so
+	 * if it does there's something nefarious going on
 	 */
-	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
-		 "BUG: scratch buffer is too small"))
-		return -EINVAL;
+	if (WARN(work - scratch + pub_len + priv_len + creation_data_len +
+		 creation_hash_len + creation_tk_len + (7 * 5) + 3 >
+		 SCRATCH_SIZE,
+		 "BUG: scratch buffer is too small")) {
+		rc = -EINVAL;
+		goto err;
+	}
 
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
 	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
+	if (creation_data_len) {
+		u8 *scratch2 = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+		u8 *work2;
+		u8 *end_work2 = scratch2 + SCRATCH_SIZE;
+
+		if (!scratch2) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		work2 = asn1_encode_octet_string(scratch2,
+						 end_work2,
+						 creation_data,
+						 creation_data_len);
+
+		work = asn1_encode_tag(work,
+				       end_work,
+				       1,
+				       scratch2,
+				       work2 - scratch2);
+
+		work2 = asn1_encode_octet_string(scratch2,
+						 end_work2,
+						 creation_hash,
+						 creation_hash_len);
+
+		work = asn1_encode_tag(work,
+				       end_work,
+				       2,
+				       scratch2,
+				       work2 - scratch2);
+
+		work2 = asn1_encode_octet_string(scratch2,
+						 end_work2,
+						 creation_tk,
+						 creation_tk_len);
+
+		work = asn1_encode_tag(work,
+				       end_work,
+				       3,
+				       scratch2,
+				       work2 - scratch2);
+
+		kfree(scratch2);
+	}
 
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
-		return PTR_ERR(work1);
+	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
+		rc = PTR_ERR(work1);
+		goto err;
+	}
 
 	return work1 - payload->blob;
+err:
+	kfree(scratch);
+	return rc;
 }
 
 struct tpm2_key_context {
@@ -91,15 +169,21 @@ struct tpm2_key_context {
 	u32 pub_len;
 	const u8 *priv;
 	u32 priv_len;
+	const u8 *creation_data;
+	u32 creation_data_len;
+	const u8 *creation_hash;
+	u32 creation_hash_len;
+	const u8 *creation_tk;
+	u32 creation_tk_len;
 };
 
 static int tpm2_key_decode(struct trusted_key_payload *payload,
-			   struct trusted_key_options *options,
-			   u8 **buf)
+			   struct trusted_key_options *options)
 {
+	u64 data_len;
 	int ret;
 	struct tpm2_key_context ctx;
-	u8 *blob;
+	u8 *blob, *buf;
 
 	memset(&ctx, 0, sizeof(ctx));
 
@@ -108,21 +192,57 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (ret < 0)
 		return ret;
 
-	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
+	data_len = ctx.priv_len + ctx.pub_len + ctx.creation_data_len +
+		   ctx.creation_hash_len + ctx.creation_tk_len;
+
+	if (data_len > MAX_BLOB_SIZE)
 		return -EINVAL;
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
-	if (!blob)
+	buf = kmalloc(data_len + 4, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	*buf = blob;
+	blob = buf;
 	options->keyhandle = ctx.parent;
 
 	memcpy(blob, ctx.priv, ctx.priv_len);
 	blob += ctx.priv_len;
 
 	memcpy(blob, ctx.pub, ctx.pub_len);
+	blob += ctx.pub_len;
+	if (ctx.creation_data_len) {
+		memcpy(blob, ctx.creation_data, ctx.creation_data_len);
+		blob += ctx.creation_data_len;
+	}
+
+	if (ctx.creation_hash_len) {
+		memcpy(blob, ctx.creation_hash, ctx.creation_hash_len);
+		blob += ctx.creation_hash_len;
+	}
 
+	if (ctx.creation_tk_len) {
+		memcpy(blob, ctx.creation_tk, ctx.creation_tk_len);
+		blob += ctx.creation_tk_len;
+	}
+
+	/*
+	 * Copy the buffer back into the payload blob since the creation
+	 * info will be used after loading.
+	 */
+	payload->blob_len = blob - buf;
+	memcpy(payload->blob, buf, payload->blob_len);
+	if (ctx.creation_data_len) {
+		payload->creation = payload->blob + ctx.priv_len + ctx.pub_len;
+		payload->creation_len = ctx.creation_data_len;
+		payload->creation_hash = payload->creation + ctx.creation_data_len;
+		payload->creation_hash_len = ctx.creation_hash_len;
+		payload->tk = payload->creation_hash +
+			      payload->creation_hash_len;
+
+		payload->tk_len = ctx.creation_tk_len;
+	}
+
+	kfree(buf);
 	return 0;
 }
 
@@ -185,6 +305,42 @@ int tpm2_key_priv(void *context, size_t hdrlen,
 	return 0;
 }
 
+int tpm2_key_creation_data(void *context, size_t hdrlen,
+			   unsigned char tag,
+			   const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->creation_data = value;
+	ctx->creation_data_len = vlen;
+
+	return 0;
+}
+
+int tpm2_key_creation_hash(void *context, size_t hdrlen,
+			   unsigned char tag,
+			   const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->creation_hash = value;
+	ctx->creation_hash_len = vlen;
+
+	return 0;
+}
+
+int tpm2_key_creation_tk(void *context, size_t hdrlen,
+			 unsigned char tag,
+			 const void *value, size_t vlen)
+{
+	struct tpm2_key_context *ctx = context;
+
+	ctx->creation_tk = value;
+	ctx->creation_tk_len = vlen;
+
+	return 0;
+}
+
 /**
  * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
@@ -229,6 +385,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_options *options)
 {
 	int blob_len = 0;
+	unsigned int offset;
 	struct tpm_buf buf;
 	u32 hash;
 	u32 flags;
@@ -317,13 +474,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		rc = -E2BIG;
 		goto out;
 	}
-	if (tpm_buf_length(&buf) < TPM_HEADER_SIZE + 4 + blob_len) {
+	offset = TPM_HEADER_SIZE + 4;
+	if (tpm_buf_length(&buf) < offset + blob_len) {
 		rc = -EFAULT;
 		goto out;
 	}
 
 	blob_len = tpm2_key_encode(payload, options,
-				   &buf.data[TPM_HEADER_SIZE + 4],
+				   &buf.data[offset],
 				   blob_len);
 
 out:
@@ -370,13 +528,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
-	if (rc) {
-		/* old form */
-		blob = payload->blob;
+	rc = tpm2_key_decode(payload, options);
+	if (rc)
 		payload->old_format = 1;
-	}
 
+	blob = payload->blob;
 	/* new format carries keyhandle but old format doesn't */
 	if (!options->keyhandle)
 		return -EINVAL;
@@ -433,8 +589,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
-	if (blob != payload->blob)
-		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
-- 
2.31.0

