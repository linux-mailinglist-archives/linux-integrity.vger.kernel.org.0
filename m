Return-Path: <linux-integrity+bounces-7486-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D3BECE2C
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB119A7FAF
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878C2D5C6C;
	Sat, 18 Oct 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ57Uht6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855FCA6F;
	Sat, 18 Oct 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786268; cv=none; b=XPXoBaRciX+q6Q3Ed/50eIFT/758971zv7K2mZ6UVH/nkZQRqasjx2JotRSFY/qTLABdrE8zVrpmMcM00O+jqUV2j33vOFKZBiQI3KllltQ4jpVyYCPkCmggZmbIlktb58bRTZK+NBEJEOt5OOVQsQ9fk3wl9wJdFEh/bKQKwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786268; c=relaxed/simple;
	bh=js0KXq3wmOkXtodFn7nKEYviSdJ0OByjNFLTwYAoCJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tP2Q4wOnNi0VLj7lDvfJtsHvPduGFMynGRaSs/rxuP9kgnY/NJ2+ZaKp1qit5/R+m1fRG9hRYrGP3Jsf1RHfyfq3Plh67GyKAibR54758DK/c8phj2zf9eyNu6K7ZILQbqkKvlPeKLfOkJ6c98m2SL8AEquZZzq3IW0OJ6Rqk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ57Uht6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9515AC4CEFE;
	Sat, 18 Oct 2025 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786268;
	bh=js0KXq3wmOkXtodFn7nKEYviSdJ0OByjNFLTwYAoCJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQ57Uht6bogEEoe/qCSEsqsywZ9azESJB8F1+NT8SCNI8ebtRjZTMZdj0EKrzFWWr
	 oaZjVTL82QOU/RDdHzS0kYQIN0Xp1yTU3F5s25oyXsClvA8qqCKlZFfE8AfIPsWvRo
	 EY5BBhmDCepk27GVezPwLxOktVFmsXFOEAp5yEFZXgyn+nCD64ccIoz8Nx6U1lG7e/
	 uDOcpa1spU6BgpgL48K7MpU1jya6r75GiCQ0J08j39PjBbAcixuGg9YKpbJ14ON0zd
	 MdqRxynJdBUimijdam8q7yKV6ql5V51LO3YDK58Es5m508VT7bhI939uaCjf8xyNSb
	 Tm/99noIuVyHw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyring@vger.kernel.org,
	dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/10] KEYS: trusted: Fix memory leak in tpm2_load()
Date: Sat, 18 Oct 2025 14:17:18 +0300
Message-Id: <20251018111725.3116386-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018111725.3116386-1-jarkko@kernel.org>
References: <20251018111725.3116386-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_load() allocates a blob indirectly via tpm2_key_decode() but it is
not freed in all failure paths. Address this with a scope-based cleanup
helper __free(). For legacy blobs, the implicit de-allocation is gets
disable by no_free_ptr().

Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v6:
- A new patch in this version.
---
 security/keys/trusted-keys/trusted_tpm2.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 024be262702f..468a4a339541 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -106,9 +106,8 @@ struct tpm2_key_context {
 	u32 priv_len;
 };
 
-static int tpm2_key_decode(struct trusted_key_payload *payload,
-			   struct trusted_key_options *options,
-			   u8 **buf)
+static void *tpm2_key_decode(struct trusted_key_payload *payload,
+			     struct trusted_key_options *options)
 {
 	int ret;
 	struct tpm2_key_context ctx;
@@ -119,16 +118,15 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
 			       payload->blob_len);
 	if (ret < 0)
-		return ret;
+		return ERR_PTR(ret);
 
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
 	if (!blob)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	*buf = blob;
 	options->keyhandle = ctx.parent;
 
 	memcpy(blob, ctx.priv, ctx.priv_len);
@@ -136,7 +134,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 
 	memcpy(blob, ctx.pub, ctx.pub_len);
 
-	return 0;
+	return blob;
 }
 
 int tpm2_key_parent(void *context, size_t hdrlen,
@@ -391,13 +389,14 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
-	u8 *blob, *pub;
+	u8 *pub;
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
-	if (rc) {
+	u8 *blob __free(kfree) = tpm2_key_decode(payload, options);
+	if (IS_ERR(blob)) {
 		/* old form */
+		no_free_ptr(blob);
 		blob = payload->blob;
 		payload->old_format = 1;
 	}
@@ -464,8 +463,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
-	if (blob != payload->blob)
-		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
-- 
2.39.5


