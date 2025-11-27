Return-Path: <linux-integrity+bounces-7712-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D9C9034B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B9BC35151F
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3FA322A3E;
	Thu, 27 Nov 2025 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf8PzsY6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0E30AAB3;
	Thu, 27 Nov 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279729; cv=none; b=HBw1LyrQSex2EATZYuy9jBSclLnq4pguzwkiswdzHhNS8FVQRoAbAzSl5AeVHpo0FABB9jQs2uiWcEWAU3z3Ho7u2gh/ettrjml0vDtP7ISAsNgZJmSoL7aURvjEu0PYmffKZRwWooXfZnUGzXY1AYn+hnUm8xzRbZlOYyuIzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279729; c=relaxed/simple;
	bh=3UUWKYLzGAg4A1KC8AbrL28qz9d8TSVwH0sjaBLkc8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRu9ll8lwkS/fxPwp+cNxGlQuYo9+Oy9a+417Te55Nh+IXMkLO4GxT140txxilhOaIBqeT5z7lFgytkKOaaWJQPRBQ84sPrYwTxQ1EJ/t18NpyCLae3R0aufQVxAbuS/dDaOz/nhE2XNN3aKjygvSzqahLfEOwaXjwJ4C9fooGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf8PzsY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB65C4CEF8;
	Thu, 27 Nov 2025 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279726;
	bh=3UUWKYLzGAg4A1KC8AbrL28qz9d8TSVwH0sjaBLkc8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pf8PzsY6Uv6BnSy5+8GeGXPXjhD5Ui0JWYigF6jYiFrQTVVKG/bWus4FfiWGbVMUM
	 GteNdncOzYh4EOlN1Vlq4jGN8KxvpHsHsZxV9NSVhbkm4rxcpVCvKoHE5b31Kj6kBb
	 sLpwXDLUlEWEa00dgbjPMoCHAOz+6EZAbdHvlCGn8v5lLQmVKnHGlEaVAcsWcaMdEi
	 myvh+kIl+2OWgAbt2UDnxwPafslwM63ZSJZRrESsN5zyyfgq2dWIGxpNyysDApS3GM
	 2oPhrUIGpXb+dYg7D4tpO3GazGD7y/pE06r5Fc0cmHETiMbIUJETRcDA8wQAvu+V/5
	 DlywMDfD6qXMQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
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
Subject: [PATCH v8 04/11] KEYS: trusted: Fix memory leak in tpm2_load()
Date: Thu, 27 Nov 2025 23:41:29 +0200
Message-ID: <20251127214138.3760029-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127214138.3760029-1-jarkko@kernel.org>
References: <20251127214138.3760029-1-jarkko@kernel.org>
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
v7:
- Fix compiler warning.
v6:
- A new patch in this version.
---
 security/keys/trusted-keys/trusted_tpm2.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index edd7b9d7e4dc..36e20a9a94b4 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -98,9 +98,8 @@ struct tpm2_key_context {
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
@@ -111,16 +110,15 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
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
@@ -128,7 +126,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 
 	memcpy(blob, ctx.pub, ctx.pub_len);
 
-	return 0;
+	return blob;
 }
 
 int tpm2_key_parent(void *context, size_t hdrlen,
@@ -372,6 +370,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 struct trusted_key_options *options,
 			 u32 *blob_handle)
 {
+	u8 *blob_ref __free(kfree) = NULL;
 	struct tpm_buf buf;
 	unsigned int private_len;
 	unsigned int public_len;
@@ -380,11 +379,14 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
-	if (rc) {
+	blob = tpm2_key_decode(payload, options);
+	if (IS_ERR(blob)) {
 		/* old form */
 		blob = payload->blob;
 		payload->old_format = 1;
+	} else {
+		/* Bind to cleanup: */
+		blob_ref = blob;
 	}
 
 	/* new format carries keyhandle but old format doesn't */
@@ -449,8 +451,6 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
 
 out:
-	if (blob != payload->blob)
-		kfree(blob);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0)
-- 
2.52.0


