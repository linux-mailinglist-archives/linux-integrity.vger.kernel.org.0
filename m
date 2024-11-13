Return-Path: <linux-integrity+bounces-4112-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A19C7DA7
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 22:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FB283B25
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F591DEFC7;
	Wed, 13 Nov 2024 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="gwdBbD+g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD7EAD0
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533299; cv=none; b=cuWuY9F4f3g4K5OPKEQ2NRk0wXzkupsikbxR55wnOnAmmV5luiK6zfOudY5xKJLPEmeVBlWlrR9657bWH9QqHjJIQLrXM4uonF7bzWS92K3JqCplDbvKoHkKfFtgNifrW6XVEteEP+771ZxaD4Duu0ov+7w0eL5RUWzFemYYFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533299; c=relaxed/simple;
	bh=rKhHAG+LvAXKqEHhSlBUI3rw27sV72XPt1hCRbQISuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvaqZko9Z4YfUX2i/WSWVaSQ8aRtM5d76nlJ6x3IcsB3Spa3rlPMMSgTsEweh9GWgmsM2REYzUIx1ZGUbULW0mxkMJ0fChDEfVvh6k7T+gipsuOL3D6T9S2B7xz0q7mZqqFREvqLAgL5A99OrBAd6c57ORGdF4J9XXESDaS3s70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=gwdBbD+g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso61911605e9.3
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 13:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1731533294; x=1732138094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ6xAbIC8Al8OcOI95+3pwvP6j9wIJ23QXfOfXWSupE=;
        b=gwdBbD+gMOJlgKY4stYurbeaVqgSW9rmuoGPSWiXjDn3oz/rIOpGtrACiY82gWXTjo
         Pd/YotrMvXQx2xueYlulDGe6v/00u8vffQJj4xvSw0/JlMXxRcg2dngCdpiaQWeNNyuJ
         G3m0hP2HDFZpL0IL4JG+ypHPODSEofGffv4MejhEjGnOcLhH/bbmn8kRbbdSb7QsGIDb
         ksj/TwDceE7hjKTwxi1XMXMfEpdpyuDsHVbDoOcY6ZmKNVxZlXiDEQ6gtpNQdtODhhio
         HunON0sXyr1mIioyT489OrmOjIgiLWL/fnsPaZuDeIxRqpQT0+N/mD0Wqu+oxASUUjz5
         znCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731533294; x=1732138094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ6xAbIC8Al8OcOI95+3pwvP6j9wIJ23QXfOfXWSupE=;
        b=RHut1CgdG63Yk4ApfuLpzNVo9pnQlslayytkLxzbfSkud3v0JFsnXIpywtrIVcPwOb
         GgGfvr6vG0p33nJSP1updmi2sWEG/fvqNJXF8YAAtwCdueHsv2fMAt3vV/qk1Re4r18o
         tTtR7yCEs3Qwc4coSIoojAShNopREfo/cpE4dbZkgR7C4bcIsZoFTwTYSGCMESt1cWPv
         +zE/aFY59YVXK3Gx66lJHD/yElVK0ZPNgdw1swdhtEGAqHcSagZqRXjie3eorrf9KrFH
         ffBkJ2GQTone+bBsD9jnlDQ0BYEE/FuJcu/b5J8RRs8HPM4Lc6WXRQaGTPFR6w3GAtx/
         InFA==
X-Gm-Message-State: AOJu0YyJa1G+m4oNnyad9thludhHXI/eL0U8ObnsZhOcBx5zZ5DVsO7L
	fJTLVEMm+7feQdqJ5JTcn8lzRm8QXNuOQxXUOKPsMfrHTigVSx6htlHHcaB6lMk=
X-Google-Smtp-Source: AGHT+IEG3+0loCICljuOQmwpXB+TVjExLPGwnEULJ4Fhnr8A6GRVCEaGZc+hzlpvGDhdAwfNGhjx+w==
X-Received: by 2002:a05:600c:b95:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-432d4ad3329mr37270825e9.26.1731533294505;
        Wed, 13 Nov 2024 13:28:14 -0800 (PST)
Received: from localhost (17-14-180.cgnat.fonira.net. [185.17.14.180])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-432da265c45sm229285e9.11.2024.11.13.13.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 13:28:14 -0800 (PST)
From: David Gstir <david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=y
Date: Wed, 13 Nov 2024 22:27:54 +0100
Message-ID: <20241113212754.12758-1-david@sigma-star.at>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With vmalloc stack addresses enabled (CONFIG_VMAP_STACK=y) DCP trusted
keys can crash during en- and decryption of the blob encryption key via
the DCP crypto driver. This is caused by improperly using sg_init_one()
with vmalloc'd stack buffers (plain_key_blob).

Fix this by always using kmalloc() for buffers we give to the DCP crypto
driver.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key")
Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/trusted_dcp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index e908c53a803c..7b6eb655df0c 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -201,12 +201,16 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
-	u8 plain_blob_key[AES_KEYSIZE_128];
+	u8 *plain_blob_key;
 
 	blen = calc_blob_len(p->key_len);
 	if (blen > MAX_BLOB_SIZE)
 		return -E2BIG;
 
+	plain_blob_key = kmalloc(AES_KEYSIZE_128, GFP_KERNEL);
+	if (!plain_blob_key)
+		return -ENOMEM;
+
 	b->fmt_version = DCP_BLOB_VERSION;
 	get_random_bytes(b->nonce, AES_KEYSIZE_128);
 	get_random_bytes(plain_blob_key, AES_KEYSIZE_128);
@@ -229,7 +233,8 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 	ret = 0;
 
 out:
-	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+	memzero_explicit(plain_blob_key, AES_KEYSIZE_128);
+	kfree(plain_blob_key);
 
 	return ret;
 }
@@ -238,7 +243,7 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
 	int blen, ret;
-	u8 plain_blob_key[AES_KEYSIZE_128];
+	u8 *plain_blob_key = NULL;
 
 	if (b->fmt_version != DCP_BLOB_VERSION) {
 		pr_err("DCP blob has bad version: %i, expected %i\n",
@@ -256,6 +261,12 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	}
 
+	plain_blob_key = kmalloc(AES_KEYSIZE_128, GFP_KERNEL);
+	if (!plain_blob_key) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = decrypt_blob_key(b->blob_key, plain_blob_key);
 	if (ret) {
 		pr_err("Unable to decrypt blob key: %i\n", ret);
@@ -271,7 +282,10 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 
 	ret = 0;
 out:
-	memzero_explicit(plain_blob_key, sizeof(plain_blob_key));
+	if (plain_blob_key) {
+		memzero_explicit(plain_blob_key, AES_KEYSIZE_128);
+		kfree(plain_blob_key);
+	}
 
 	return ret;
 }
-- 
2.47.0


