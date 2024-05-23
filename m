Return-Path: <linux-integrity+bounces-2570-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8828CD33A
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 15:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF891C2176B
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78213BAE3;
	Thu, 23 May 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obwQ+HW3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360D13B7BC;
	Thu, 23 May 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469730; cv=none; b=E8QLTW9oeSPa7m9dDi7gW2sjWYC6pkrnsq4zpBz4p6EgAihK34yaIUhQ8SkzUir3T1tosb922gWoyU0IDWSzLeSAb9PjzZ28PFjzGj72aDfLE86kaukkSxxfSFDhnb81z3OQHYY7sYnyXfNUGAG3T4WvjY12EwaNPxcXdLtSz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469730; c=relaxed/simple;
	bh=5x2a4GM3brTtaycRNakzuLxHq3n5FCWmESOoxOPKfDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFxiQmoYRWCSgxc2jL/++tI6NIkK5UsD/BqmAj1ZxPMF+E7N1wDbEH7mQPTY+cvW2TizTAY9Dyjjkbk3DAudx2v0l4Q3fkYtx2Z3/tzrJqa8y9B0woRMXo2tYDYO1vy3QVksGELjUpeP7bE32OaBmZf8j/uvCZ+u5D3Zz2NkgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obwQ+HW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56226C2BD10;
	Thu, 23 May 2024 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716469729;
	bh=5x2a4GM3brTtaycRNakzuLxHq3n5FCWmESOoxOPKfDg=;
	h=From:To:Cc:Subject:Date:From;
	b=obwQ+HW3dkBtcZ2A7SnkC9L0Csk8Z3mlB8nmpNniwjdIiufbdTCQo56oh4HCPaWqg
	 gEmXAmN1/XFKQamXKamiG0EiecKHbxM74ffFuv1M1CFqqQ5d270zshNA9U6d9JvHEr
	 xMLoKSllvP4XLwdLtjxmE6QqRB/Zhj3TV5R64qVgqmfnJ7zMWuMfcnsxBlK+PjB0eN
	 K6QKqzPMv3XUgWJtJYzHQsQqc7AE2cu9x8lbgMxBfJVks5GfhOu9pD6CSLWJnAxLTW
	 enWO6FfGpHLuFMcAtS9ukesEZZl2OPpxXVNFGMHFWMkiJgihPF5C46koke1xoUSkmt
	 SQuShp1g9Zd5w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] KEYS: trusted: Use ASN.1 encoded OID
Date: Thu, 23 May 2024 16:08:35 +0300
Message-ID: <20240523130839.31265-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason to encode OID_TPMSealedData at run-time, as it never
changes.

Replace it with the encoded version, which has exactly the same size:

	67 81 05 0A 01 05

Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so that
the OID can be simply copied to the blob.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/asn1_encoder.h              |  4 -
 lib/asn1_encoder.c                        | 91 -----------------------
 security/keys/trusted-keys/trusted_tpm2.c | 10 ++-
 3 files changed, 7 insertions(+), 98 deletions(-)

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
index 08cd0c2ad34f..afeefdfe2525 100644
--- a/include/linux/asn1_encoder.h
+++ b/include/linux/asn1_encoder.h
@@ -8,14 +8,10 @@
 #include <linux/asn1_ber_bytecode.h>
 #include <linux/bug.h>
 
-#define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
 unsigned char *
 asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 		    s64 integer);
 unsigned char *
-asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
-		u32 oid[], int oid_len);
-unsigned char *
 asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
 		u32 tag, const unsigned char *string, int len);
 unsigned char *
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 0fd3c454a468..c0db3cbebe89 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -85,97 +85,6 @@ asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 }
 EXPORT_SYMBOL_GPL(asn1_encode_integer);
 
-/* calculate the base 128 digit values setting the top bit of the first octet */
-static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
-{
-	unsigned char *data = *_data;
-	int start = 7 + 7 + 7 + 7;
-	int ret = 0;
-
-	if (*data_len < 1)
-		return -EINVAL;
-
-	/* quick case */
-	if (oid == 0) {
-		*data++ = 0x80;
-		(*data_len)--;
-		goto out;
-	}
-
-	while (oid >> start == 0)
-		start -= 7;
-
-	while (start > 0 && *data_len > 0) {
-		u8 byte;
-
-		byte = oid >> start;
-		oid = oid - (byte << start);
-		start -= 7;
-		byte |= 0x80;
-		*data++ = byte;
-		(*data_len)--;
-	}
-
-	if (*data_len > 0) {
-		*data++ = oid;
-		(*data_len)--;
-	} else {
-		ret = -EINVAL;
-	}
-
- out:
-	*_data = data;
-	return ret;
-}
-
-/**
- * asn1_encode_oid() - encode an oid to ASN.1
- * @data:	position to begin encoding at
- * @end_data:	end of data pointer, points one beyond last usable byte in @data
- * @oid:	array of oids
- * @oid_len:	length of oid array
- *
- * this encodes an OID up to ASN.1 when presented as an array of OID values
- */
-unsigned char *
-asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
-		u32 oid[], int oid_len)
-{
-	int data_len = end_data - data;
-	unsigned char *d = data + 2;
-	int i, ret;
-
-	if (WARN(oid_len < 2, "OID must have at least two elements"))
-		return ERR_PTR(-EINVAL);
-
-	if (WARN(oid_len > 32, "OID is too large"))
-		return ERR_PTR(-EINVAL);
-
-	if (IS_ERR(data))
-		return data;
-
-
-	/* need at least 3 bytes for tag, length and OID encoding */
-	if (data_len < 3)
-		return ERR_PTR(-EINVAL);
-
-	data[0] = _tag(UNIV, PRIM, OID);
-	*d++ = oid[0] * 40 + oid[1];
-
-	data_len -= 3;
-
-	for (i = 2; i < oid_len; i++) {
-		ret = asn1_encode_oid_digit(&d, &data_len, oid[i]);
-		if (ret < 0)
-			return ERR_PTR(ret);
-	}
-
-	data[1] = d - data - 2;
-
-	return d;
-}
-EXPORT_SYMBOL_GPL(asn1_encode_oid);
-
 /**
  * asn1_encode_length() - encode a length to follow an ASN.1 tag
  * @data: pointer to encode at
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 8b7dd73d94c1..dadeed35627c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -26,7 +26,8 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
-static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
+/* Encoded OID_TPMSealedData. */
+static u8 OID_TPMSealedData_ASN1[] = {0x06, 0x06, 0x67, 0x81, 0x05, 0x0a, 0x01 0x05};
 
 static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
@@ -51,8 +52,8 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	if (!scratch)
 		return -ENOMEM;
 
-	work = asn1_encode_oid(work, end_work, tpm2key_oid,
-			       asn1_oid_len(tpm2key_oid));
+	work = memcpy(work, OID_TPMSealedData_ASN1, sizeof(OID_TPMSealedData_ASN1));
+	work += OID_TPMSealedData_ASN1;
 
 	if (options->blobauth_len == 0) {
 		unsigned char bool[3], *w = bool;
@@ -90,6 +91,9 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		goto err;
 	}
 
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
+		       payload->blob, work1 - payload->blob, 0);
+
 	kfree(scratch);
 	return work1 - payload->blob;
 
-- 
2.45.1


