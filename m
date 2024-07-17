Return-Path: <linux-integrity+bounces-3161-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86C933C49
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33171F237CD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135017FAA6;
	Wed, 17 Jul 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Zt8Ckj4K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0517F4EC
	for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215771; cv=none; b=js3kg1HSCnxYeLV5J+bH9Qth6+tsXsBMkaKr1UDcbLuJ4sTGdk5n+5BVKpgdgecxIN6HUwQphC2Zh3GMpQG8EKD3f6NsRRh67s5LrkjLPQBfm5xXDwFDX8NsvHlK8e8wbXvh7TXVuta/9Xdle9CKSRMx9AjdeYz5+tP1zRUQitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215771; c=relaxed/simple;
	bh=mlueMApefrBx3oCbCetbJgT4sruWDXzUi6v+8CnwLuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaZvjq7tf4MZbcDHuCtFXXy9EwrAlwmOIT88XjNyXTHB4biH8KCz9s60XbjT3uPy1veqKdp5fd87ItjZdL26lfYUppSk/MytmuYZQ73e81mXkp9sMOxgNUizrikqbttVtvZyKmTbw9xE1VuyZ3w1gW2pGMTw18mN2c55x30L7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Zt8Ckj4K; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so2257986f8f.3
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2024 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1721215767; x=1721820567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juT3uodcmwnlXPVSCunbVs4x8IyH/tPtIrSj5xeHKyQ=;
        b=Zt8Ckj4Kc6ZIBApxp846A8PfVpIH3JXYgwzLXfvCxVHhd5WJtQPm2HQsV09bEK/ynv
         WByzUZ0UvAsb0NJ5ibmNJfZ3r9MyBgyMTPKL6LZpPSWohz0FG9eYtDSLJf+F7UfVCBFt
         DLNR0CpDj4J+LNv/cGDILPezDwRSviyo1iTMselmwscW03A0bU7Swk95v5Z0/yWgNrDI
         mRMznVeswuZRgWrbWu2c5NZFCS3TvWk7CbucqN6DSVEEn3+ecp5O7WVc52rglZecA+bN
         B9ghVMS3ddmYQQHl7bQLrJdKOMmkQ7vaUnWcdJPlBhmZZ1MP02yvupN3dV7DSCT594i4
         Ga+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721215767; x=1721820567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juT3uodcmwnlXPVSCunbVs4x8IyH/tPtIrSj5xeHKyQ=;
        b=tGEBtVrLJI/zWFFzkXk5/bM1e9e85/Hy0teMtqR9/PFkIbAq3kZhiymbgwUFlphTRa
         zvIok3SdPVXpu5eDwENyXNpvMUf7oIGqC2+Xzbu4rWdfnJnSDsCEaNK8VO0mruOpHibm
         ik/dmO63h6CbuGsueh2UD6IPe9rmcz9A3l4vH0xDNIeAxc6zL2v2NzD1Fmpheu4YZ80e
         bTyNzqlCJic53vACbcDeUsH3uVGlKnCKo4VsaeFRKo6fvP1xZTEGLUWGbjrToQLz3H7U
         VeHsMyHrwznFfG5ZypWyNWGxCA8/LdBO7Fhym9hmCr3SmELekUD9iI3RQxTXB+9s1gS3
         EbDQ==
X-Gm-Message-State: AOJu0Yw+cb/FT9QYJaDGH3fc/++JusR67zQKzzpD2SzKNclopgf/amoJ
	Wnss6poNoyNgHJlGG2mo34SAkbuPwtaXgT60SAHRLLnl/r7aVge1Y8aiM9qLP8s=
X-Google-Smtp-Source: AGHT+IGYE7f7sIy7b+/v6HZr1Z65eDUdS6PMQc5R2C0QdpR/FSBhFb+VKCZNHWlw7oT3n32HFT6z9Q==
X-Received: by 2002:adf:e508:0:b0:366:f041:935d with SMTP id ffacd0b85a97d-3683179ebc7mr829016f8f.60.1721215767047;
        Wed, 17 Jul 2024 04:29:27 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-368119970e7sm10640354f8f.21.2024.07.17.04.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:29:26 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] KEYS: trusted: dcp: fix leak of blob encryption key
Date: Wed, 17 Jul 2024 13:28:45 +0200
Message-ID: <20240717112845.92088-2-david@sigma-star.at>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717112845.92088-1-david@sigma-star.at>
References: <20240717112845.92088-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trusted keys unseal the key blob on load, but keep the sealed payload in
the blob field so that every subsequent read (export) will simply
convert this field to hex and send it to userspace.

With DCP-based trusted keys, we decrypt the blob encryption key (BEK)
in the Kernel due hardware limitations and then decrypt the blob payload.
BEK decryption is done in-place which means that the trusted key blob
field is modified and it consequently holds the BEK in plain text.
Every subsequent read of that key thus send the plain text BEK instead
of the encrypted BEK to userspace.

This issue only occurs when importing a trusted DCP-based key and
then exporting it again. This should rarely happen as the common use cases
are to either create a new trusted key and export it, or import a key
blob and then just use it without exporting it again.

Fix this by performing BEK decryption and encryption in a dedicated
buffer. Further always wipe the plain text BEK buffer to prevent leaking
the key via uninitialized memory.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
Signed-off-by: David Gstir <david@sigma-star.at>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_dcp.c | 33 +++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index b0947f072a98..4edc5bbbcda3 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -186,20 +186,21 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	return ret;
 }
 
-static int decrypt_blob_key(u8 *key)
+static int decrypt_blob_key(u8 *encrypted_key, u8 *plain_key)
 {
-	return do_dcp_crypto(key, key, false);
+	return do_dcp_crypto(encrypted_key, plain_key, false);
 }
 
-static int encrypt_blob_key(u8 *key)
+static int encrypt_blob_key(u8 *plain_key, u8 *encrypted_key)
 {
-	return do_dcp_crypto(key, key, true);
+	return do_dcp_crypto(plain_key, encrypted_key, true);
 }
 
 static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
+	u8 plain_blob_key[AES_KEYSIZE_128];
 
 	blen = calc_blob_len(p->key_len);
 	if (blen > MAX_BLOB_SIZE)
@@ -207,30 +208,36 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 
 	b->fmt_version = DCP_BLOB_VERSION;
 	get_random_bytes(b->nonce, AES_KEYSIZE_128);
-	get_random_bytes(b->blob_key, AES_KEYSIZE_128);
+	get_random_bytes(plain_blob_key, AES_KEYSIZE_128);
 
-	ret = do_aead_crypto(p->key, b->payload, p->key_len, b->blob_key,
+	ret = do_aead_crypto(p->key, b->payload, p->key_len, plain_blob_key,
 			     b->nonce, true);
 	if (ret) {
 		pr_err("Unable to encrypt blob payload: %i\n", ret);
-		return ret;
+		goto out;
 	}
 
-	ret = encrypt_blob_key(b->blob_key);
+	ret = encrypt_blob_key(plain_blob_key, b->blob_key);
 	if (ret) {
 		pr_err("Unable to encrypt blob key: %i\n", ret);
-		return ret;
+		goto out;
 	}
 
 	put_unaligned_le32(p->key_len, &b->payload_len);
 	p->blob_len = blen;
-	return 0;
+	ret = 0;
+
+out:
+	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+
+	return ret;
 }
 
 static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
+	u8 plain_blob_key[AES_KEYSIZE_128];
 
 	if (b->fmt_version != DCP_BLOB_VERSION) {
 		pr_err("DCP blob has bad version: %i, expected %i\n",
@@ -248,14 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	}
 
-	ret = decrypt_blob_key(b->blob_key);
+	ret = decrypt_blob_key(b->blob_key, plain_blob_key);
 	if (ret) {
 		pr_err("Unable to decrypt blob key: %i\n", ret);
 		goto out;
 	}
 
 	ret = do_aead_crypto(b->payload, p->key, p->key_len + DCP_BLOB_AUTHLEN,
-			     b->blob_key, b->nonce, false);
+			     plain_blob_key, b->nonce, false);
 	if (ret) {
 		pr_err("Unwrap of DCP payload failed: %i\n", ret);
 		goto out;
@@ -263,6 +270,8 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 
 	ret = 0;
 out:
+	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+
 	return ret;
 }
 
-- 
2.35.3


