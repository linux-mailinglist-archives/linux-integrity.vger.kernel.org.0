Return-Path: <linux-integrity+bounces-2582-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B08CD58D
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 16:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719B2281C6C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A2C14A62B;
	Thu, 23 May 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc+SwPD5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D21DFF0;
	Thu, 23 May 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474070; cv=none; b=WR2eECiu+Nk24SIHg3Gk+n4/AoWORPDO0McT/DC1ba7XEFu5fWY8BgMM/YpnMuMqboR0KaPjomB7mraxia2nZDFMU92I0fKZL2Pj6wtnFhsCDhNWh5YAlEw4AHrD4FvIvdyjTVvLFSu+MB7tx84db8HWrasxsGXmW5Jm1n6WeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474070; c=relaxed/simple;
	bh=K4MHc5ac+AueouJANI/JDlffZUtTY1ZdCbXd6vnH3QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2KczB/01K4q0rXrjb47Mi3p9De6ISb2dR6MAsi7IqrgtKI1g+J6YLwUdKC5BoUzNun1obHDdytxe9cNBdZg++/qTQhZ6KbOa/fkZn++UjzNjq0PdXfasKlukpO6Fl7klyP9bN6u5kU23Pa0ltsLrRdtJihttI5XIUySDboaL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc+SwPD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF6CC2BD10;
	Thu, 23 May 2024 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716474070;
	bh=K4MHc5ac+AueouJANI/JDlffZUtTY1ZdCbXd6vnH3QI=;
	h=From:To:Cc:Subject:Date:From;
	b=pc+SwPD5z/73NTPSeONSYH+sRdkLKAMHpcpxHA4+sYR29Gdhijh7bBUO6/09aGwct
	 4/U/pik1i8zPvV2Ab2B+o8xFUzn2NmhKgxq6SNTEXuSQuE2t5Rm1RqmoqPchvlZhzn
	 KXLJLpsaIC+VbPF7i/IK4Z6l6s/wbWKsL0z6+/1mQaYbEQYyAR4qBoGNcaWYbuSyI0
	 BGomRyqAbljP4DTzlHyvNE33a2XHtfEYbmAJAI+/Zmdh53g1HHMDMGQ+BQeX4LsBL4
	 xFTz2xZbhGxjvoxFhdqQTU5igzSa23sAZFAXZymzAFjBzjdWy0EScqvhLO7B9YSVYh
	 vAbNgSQ68VKAA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ben Boeckel <me@benboeckel.net>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3] KEYS: trusted: Use ASN.1 encoded OID
Date: Thu, 23 May 2024 17:20:52 +0300
Message-ID: <20240523142056.17159-1-jarkko@kernel.org>
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

Replace it with an encoded u8-array, which has the same number of
elements:

	67 81 05 0A 01 05

Include OBJECT IDENTIFIER (0x06) tag and length as the prologue so that
the OID can be simply copied to the blob leading to:

	06 06 67 81 05 0A 01 05

Since this in stationary place in the buffer it is guaranteed to always
fit and not further checks are required.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
* Addressed Ben's suggestions:
  https://lore.kernel.org/linux-integrity/Zk9Hb-whVYvJrfLY@farprobe/
* Added David's R-b, as the only change in code was to add const
  to the declaration.
v2:
* Not my day I guess. This one has print_hex_dump() taken away.
  Apologies for spamming. The patch is however tested properly
  with run-tests.sh in https://gitlab.com/jarkkojs/linux-tpmdd-test.
---
 include/linux/asn1_encoder.h              |  4 -
 lib/asn1_encoder.c                        | 91 -----------------------
 security/keys/trusted-keys/trusted_tpm2.c |  6 +-
 3 files changed, 3 insertions(+), 98 deletions(-)

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
index 8b7dd73d94c1..d478096cb5c1 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -26,7 +26,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
 };
 
-static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
+static const u8 OID_TPMSealedData_ASN1[] = {0x06, 0x06, 0x67, 0x81, 0x05, 0x0a, 0x01, 0x05};
 
 static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
@@ -51,8 +51,8 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	if (!scratch)
 		return -ENOMEM;
 
-	work = asn1_encode_oid(work, end_work, tpm2key_oid,
-			       asn1_oid_len(tpm2key_oid));
+	work = memcpy(work, OID_TPMSealedData_ASN1, sizeof(OID_TPMSealedData_ASN1));
+	work += sizeof(OID_TPMSealedData_ASN1);
 
 	if (options->blobauth_len == 0) {
 		unsigned char bool[3], *w = bool;
-- 
2.45.1


