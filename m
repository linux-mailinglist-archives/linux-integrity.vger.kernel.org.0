Return-Path: <linux-integrity+bounces-2520-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD88CB145
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9FFB22D25
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945A4F8A1;
	Tue, 21 May 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnogqpTF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128B1465AF;
	Tue, 21 May 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305238; cv=none; b=YLHob7x7wRIWT1TS21So3JUeZrDFBLt7f5E6gB5hBmKrMM1MciHTnJA3IBJqhZrfkqXudI+Q81hobpB9i/1ObtsCv+6J4U9OGJhkLZJo4PkMeqkSg7MFLLpUHbnSkJlTBKKB4fturUz5YHhGmsiValvmmWeGybvf3urYGzlK6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305238; c=relaxed/simple;
	bh=nn0VoJiLw3x3CMW67NfJ4kQdCy1dkZ6pA6m6663My+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSToZu1T64gBcX+kl5Orn52fPDrc8FslcAxpUjI4XT/3+vH40POFr4PiNYiIZO2j+3B7cDjNtGYE1AJpMsEev6iHqf2DnClFKP+FGVeZFtF595AaekqjtueXcTyls5XALH5up9wS6gs9bwwaMJmT7B2+Dsxml6k25iuejpBA/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnogqpTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF83C2BD11;
	Tue, 21 May 2024 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716305238;
	bh=nn0VoJiLw3x3CMW67NfJ4kQdCy1dkZ6pA6m6663My+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnogqpTFfB9ZxCiSnSB6DdFvqePmEIyAFNhb8JvYd21FgidSFxpWlaoLcvGtdUBbh
	 WRpdaljYb6d2aMLmRygSxnS79cF+gQ5po2cTrwzw3P/XW+XkwumAjfSaxHC4QrMoq4
	 o4g4XFqiPQnmCfjfZpcVvs7WZ/SG7GCBH+U4sQ6fdpb2y1OAMY7vPYMVS7sxjHzm/M
	 xquiukV7VQtDvJBqVWn8LfGTEbCx2JOfkBl85zlY6jElUCI2glvfPjAYob9Z5Zjl1o
	 D7sTgSVLIL2RHBT6+0LA9RopL5BI2K9yayuI81nzzVpNDnBIPg3pLt771U+xsNvfYF
	 7kmXOi/iDbXww==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 2/5] lib: Expand asn1_encode_integer() to variable size integers
Date: Tue, 21 May 2024 18:26:44 +0300
Message-ID: <20240521152659.26438-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240521152659.26438-1-jarkko@kernel.org>
References: <20240521152659.26438-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand asn1_encode_integer() to variable size integers, meaning that it
will get a blob in big-endian format as integer and length of the blob as
parameters. This is required in order to encode RSA public key modulus.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
* Fix off-by-one in indices when returning zero:
  https://lore.kernel.org/linux-integrity/SN7PR18MB5314CFBD18B011F292809EBFE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com/
---
 include/linux/asn1_encoder.h              |   3 +-
 lib/asn1_encoder.c                        | 185 ++++++++++++----------
 security/keys/trusted-keys/trusted_tpm2.c |   4 +-
 3 files changed, 103 insertions(+), 89 deletions(-)

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
index 08cd0c2ad34f..ad5fb18db9e2 100644
--- a/include/linux/asn1_encoder.h
+++ b/include/linux/asn1_encoder.h
@@ -9,9 +9,10 @@
 #include <linux/bug.h>
 
 #define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
+
 unsigned char *
 asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
-		    s64 integer);
+		    const u8 *integer, int integer_len);
 unsigned char *
 asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
 		u32 oid[], int oid_len);
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 0fd3c454a468..266e8042742e 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -9,12 +9,78 @@
 #include <linux/bug.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+
+/**
+ * asn1_encode_length() - encode a length to follow an ASN.1 tag
+ * @data: pointer to encode at
+ * @data_len: pointer to remaining length (adjusted by routine)
+ * @len: length to encode
+ *
+ * This routine can encode lengths up to 65535 using the ASN.1 rules.
+ * It will accept a negative length and place a zero length tag
+ * instead (to keep the ASN.1 valid).  This convention allows other
+ * encoder primitives to accept negative lengths as singalling the
+ * sequence will be re-encoded when the length is known.
+ */
+static int asn1_encode_length(unsigned char **data, int *data_len, int len)
+{
+	if (*data_len < 1)
+		return -EINVAL;
+
+	if (len < 0) {
+		*((*data)++) = 0;
+		(*data_len)--;
+		return 0;
+	}
+
+	if (len <= 0x7f) {
+		*((*data)++) = len;
+		(*data_len)--;
+		return 0;
+	}
+
+	if (*data_len < 2)
+		return -EINVAL;
+
+	if (len <= 0xff) {
+		*((*data)++) = 0x81;
+		*((*data)++) = len & 0xff;
+		*data_len -= 2;
+		return 0;
+	}
+
+	if (*data_len < 3)
+		return -EINVAL;
+
+	if (len <= 0xffff) {
+		*((*data)++) = 0x82;
+		*((*data)++) = (len >> 8) & 0xff;
+		*((*data)++) = len & 0xff;
+		*data_len -= 3;
+		return 0;
+	}
+
+	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
+		return -EINVAL;
+
+	if (*data_len < 4)
+		return -EINVAL;
+	*((*data)++) = 0x83;
+	*((*data)++) = (len >> 16) & 0xff;
+	*((*data)++) = (len >> 8) & 0xff;
+	*((*data)++) = len & 0xff;
+	*data_len -= 4;
+
+	return 0;
+}
 
 /**
  * asn1_encode_integer() - encode positive integer to ASN.1
- * @data:	pointer to the pointer to the data
- * @end_data:	end of data pointer, points one beyond last usable byte in @data
- * @integer:	integer to be encoded
+ * @data:		pointer to the pointer to the data
+ * @end_data:		end of data pointer, points one beyond last usable byte in @data
+ * @integer:		integer to be encoded
+ * @integer_len:	length in bytes of the integer blob
  *
  * This is a simplified encoder: it only currently does
  * positive integers, but it should be simple enough to add the
@@ -22,15 +88,17 @@
  */
 unsigned char *
 asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
-		    s64 integer)
+		    const u8 *integer, int integer_len)
 {
 	int data_len = end_data - data;
-	unsigned char *d = &data[2];
 	bool found = false;
+	unsigned char *d;
+	int encoded_len;
+	u8 *encoded;
+	int ret;
 	int i;
 
-	if (WARN(integer < 0,
-		 "BUG: integer encode only supports positive integers"))
+	if (WARN(!integer, "BUG: integer is null"))
 		return ERR_PTR(-EINVAL);
 
 	if (IS_ERR(data))
@@ -40,17 +108,22 @@ asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 	if (data_len < 3)
 		return ERR_PTR(-EINVAL);
 
-	/* remaining length where at d (the start of the integer encoding) */
-	data_len -= 2;
+	(*data++) = _tag(UNIV, PRIM, INT);
+	data_len--;
 
-	data[0] = _tag(UNIV, PRIM, INT);
-	if (integer == 0) {
-		*d++ = 0;
-		goto out;
+	if (!memchr_inv(integer, 0, integer_len)) {
+		data[0] = 1;
+		data[1] = 0;
+		return &data[2];
 	}
 
-	for (i = sizeof(integer); i > 0 ; i--) {
-		int byte = integer >> (8 * (i - 1));
+	encoded = kzalloc(integer_len, GFP_KERNEL);
+	if (!encoded)
+		return ERR_PTR(-ENOMEM);
+	d = encoded;
+
+	for (i = 0; i < integer_len; i++) {
+		int byte = integer[i];
 
 		if (!found && byte == 0)
 			continue;
@@ -67,21 +140,23 @@ asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 			 * have len >= 1
 			 */
 			*d++ = 0;
-			data_len--;
 		}
 
 		found = true;
-		if (data_len == 0)
-			return ERR_PTR(-EINVAL);
-
 		*d++ = byte;
-		data_len--;
 	}
 
- out:
-	data[1] = d - data - 2;
+	encoded_len = d - encoded;
 
-	return d;
+	ret = asn1_encode_length(&data, &data_len, encoded_len);
+	if (ret)  {
+		kfree(encoded);
+		return ERR_PTR(ret);
+	}
+
+	memcpy(data, encoded, encoded_len);
+	kfree(encoded);
+	return data + encoded_len;
 }
 EXPORT_SYMBOL_GPL(asn1_encode_integer);
 
@@ -176,70 +251,6 @@ asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
 }
 EXPORT_SYMBOL_GPL(asn1_encode_oid);
 
-/**
- * asn1_encode_length() - encode a length to follow an ASN.1 tag
- * @data: pointer to encode at
- * @data_len: pointer to remaining length (adjusted by routine)
- * @len: length to encode
- *
- * This routine can encode lengths up to 65535 using the ASN.1 rules.
- * It will accept a negative length and place a zero length tag
- * instead (to keep the ASN.1 valid).  This convention allows other
- * encoder primitives to accept negative lengths as singalling the
- * sequence will be re-encoded when the length is known.
- */
-static int asn1_encode_length(unsigned char **data, int *data_len, int len)
-{
-	if (*data_len < 1)
-		return -EINVAL;
-
-	if (len < 0) {
-		*((*data)++) = 0;
-		(*data_len)--;
-		return 0;
-	}
-
-	if (len <= 0x7f) {
-		*((*data)++) = len;
-		(*data_len)--;
-		return 0;
-	}
-
-	if (*data_len < 2)
-		return -EINVAL;
-
-	if (len <= 0xff) {
-		*((*data)++) = 0x81;
-		*((*data)++) = len & 0xff;
-		*data_len -= 2;
-		return 0;
-	}
-
-	if (*data_len < 3)
-		return -EINVAL;
-
-	if (len <= 0xffff) {
-		*((*data)++) = 0x82;
-		*((*data)++) = (len >> 8) & 0xff;
-		*((*data)++) = len & 0xff;
-		*data_len -= 3;
-		return 0;
-	}
-
-	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
-		return -EINVAL;
-
-	if (*data_len < 4)
-		return -EINVAL;
-	*((*data)++) = 0x83;
-	*((*data)++) = (len >> 16) & 0xff;
-	*((*data)++) = (len >> 8) & 0xff;
-	*((*data)++) = len & 0xff;
-	*data_len -= 4;
-
-	return 0;
-}
-
 /**
  * asn1_encode_tag() - add a tag for optional or explicit value
  * @data:	pointer to place tag at
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 8b7dd73d94c1..ec59f9389a2d 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -38,6 +38,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
 	u16 priv_len, pub_len;
+	u32 key_handle;
 	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
@@ -77,7 +78,8 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		goto err;
 	}
 
-	work = asn1_encode_integer(work, end_work, options->keyhandle);
+	key_handle = cpu_to_be32(options->keyhandle);
+	work = asn1_encode_integer(work, end_work, (u8 *)&key_handle, 4);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
 	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
 
-- 
2.45.1


