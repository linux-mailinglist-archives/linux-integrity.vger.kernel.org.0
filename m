Return-Path: <linux-integrity+bounces-7693-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C552C8EA19
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 14:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C054E3527F8
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A753328E1;
	Thu, 27 Nov 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZQxChmo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745E32E74B;
	Thu, 27 Nov 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251713; cv=none; b=AvfU3s8AON7fjDKvtZGZdAtFtymm4Sra4QAtBe0xC7/3gFxvppaCjbYozQLnuFQTmL98t7QGML5M9X4+oE7qhaBizPXHeD85iKccPxTH3KuBWH0vWakMOHh/xHVJZAIBOxGvCSzejeDqC1+TeKgvHtQSSxGdQbIBubU+IFBTQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251713; c=relaxed/simple;
	bh=eA0cfKfU41iaZNTEtKcAhl4jAiD+DBmTitPZhDCP/Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGOPVIDscyzw896ZPNiuw/h9HVYVP8L5IKne6guiilNQJIg/NkvZ685S03o6eoXIWrRq6St4a0Frq8XndyfQrT7oUP9bUZXIcR36bK+IXAxmscnJqNGX7C3+rPwATUjqT79ZNaVL1dHzAg3iXUQVu+RLAtuCe85g1ICtmJs0jIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZQxChmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9991C116C6;
	Thu, 27 Nov 2025 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251713;
	bh=eA0cfKfU41iaZNTEtKcAhl4jAiD+DBmTitPZhDCP/Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZQxChmoLmeBM5Kj77kceX0TlaPIakJY2Llxix3vDNrhqIk6PtvgkVxsUN4IEQpY5
	 8yJIbuBA+1accaX4VEEui4frFGZMoVLQN6RTIWrx4w12PIfhQOYyVwWuX0cGJx5rMC
	 KP3fUgIpI31PPX+DRD5WTy1306as4byhXPs2iTDlOVYpJAAFvCs6uETYtvz5j/UCQD
	 iVGVPiQHBSzR5v5IbSpkZlTsYWQD8ieR4tPIKjtzaC0SBeHrBKrjzuf93+/sjAzP5c
	 hPxs9RPHyVq0gKcU89S+1wOLtF3y11bWnus5rQQcDShNiY62HbeA81MBAHh1gS/6D2
	 8cCZQZG+IV5hQ==
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
Subject: [PATCH v7 04/11] KEYS: trusted: Fix memory leak in tpm2_load()
Date: Thu, 27 Nov 2025 15:54:36 +0200
Message-ID: <20251127135445.2141241-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127135445.2141241-1-jarkko@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
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
index 3205732fb4b7..00bc1afb32c8 100644
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


