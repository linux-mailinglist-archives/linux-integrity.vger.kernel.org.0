Return-Path: <linux-integrity+bounces-8061-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C2CC1C77
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B9D3053B21
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84DE33A713;
	Tue, 16 Dec 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXYnmeRv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821433ADA0;
	Tue, 16 Dec 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876923; cv=none; b=K6PA+Qm4pelg0obgk8Vw7TsfEgvT2nE9N4kydUAO4bhqSO4Y++tWSH5curXisodO67ZoYxwPsQDRIGhzVX/7XUFF6OvjiURiOdDOTZmJ1ZFj9D45oVqb3HdUWzIGZIvMId2B3bqFC5jSsa49Q2Zj9/UeFJFEt1bhSIc9oA6Tgmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876923; c=relaxed/simple;
	bh=9ueixsz8Nykx2JcyoqfkvTUfikUcc0s3hNapCYqs10g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BARmRw/+lYZ/0T4zgeWQxs6edNsG78hfipEobs8uHqq9nRbX+pn/jhx7AAlJHKJPiS32emQjSnF1q/FU2nQxvFlPEwrmGQGWoFsNIxjg2TB2Z1IceqfB0OQCR9GVHMB1KGtQeTwYIlRre0mIRSYTbIe1uX9OVWQcJAr2/pxbj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXYnmeRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB857C113D0;
	Tue, 16 Dec 2025 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876923;
	bh=9ueixsz8Nykx2JcyoqfkvTUfikUcc0s3hNapCYqs10g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fXYnmeRv9XurxRQIAp+tspvJRHUxG2mojbqVibzZjUM0RMkSGBw60eUHGPuCXIyd9
	 +jfwBNqQ1zcAhTGL1+KEWHoZs13D7Iqr/UCO01DunTJ8fJdpZGzEtJRR9kEoL8tLmc
	 gVc1SVoL8G7XF/tnyXz6aqTOfyVJliUG+uGjjH4XT4he2WHM5H8xweDT1523Embfx/
	 96MMOWRsXb6SqzWVjNB86dvf6n+GaXTM4IM5vO/kQPYn+NSDcwf/K+5wodEQZ7d/Gi
	 u8eg5KqH3NDO3gCSIWPxL80Mvo7oyW+r2mnv2AhN1KTrucgcikJ8cqUzjQjFtPC1SU
	 YKg7JZGrfHa3Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 02/12] KEYS: trusted: Use get_random_bytes_wait() instead of tpm_get_random()
Date: Tue, 16 Dec 2025 11:21:36 +0200
Message-Id: <20251216092147.2326606-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216092147.2326606-1-jarkko@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute remaining tpm_get_random() calls in trusted_tpm1.c with
get_random_bytes_wait() thus aligning random number generation for TPM 1.2
with the removal of '.get_random' callback.

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm1.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 7ce7e31bcdfb..3d75bb6f9689 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -371,13 +371,10 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 	unsigned char ononce[TPM_NONCE_SIZE];
 	int ret;
 
-	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
+	ret = get_random_bytes_wait(ononce, TPM_NONCE_SIZE);
 	if (ret < 0)
 		return ret;
 
-	if (ret != TPM_NONCE_SIZE)
-		return -EIO;
-
 	tpm_buf_reset(tb, TPM_TAG_RQU_COMMAND, TPM_ORD_OSAP);
 	tpm_buf_append_u16(tb, type);
 	tpm_buf_append_u32(tb, handle);
@@ -464,15 +461,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	memcpy(td->xorwork + SHA1_DIGEST_SIZE, sess.enonce, SHA1_DIGEST_SIZE);
 	sha1(td->xorwork, SHA1_DIGEST_SIZE * 2, td->xorhash);
 
-	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
+	ret = get_random_bytes_wait(td->nonceodd, TPM_NONCE_SIZE);
 	if (ret < 0)
 		goto out;
 
-	if (ret != TPM_NONCE_SIZE) {
-		ret = -EIO;
-		goto out;
-	}
-
 	ordinal = htonl(TPM_ORD_SEAL);
 	datsize = htonl(datalen);
 	pcrsize = htonl(pcrinfosize);
@@ -575,14 +567,10 @@ static int tpm_unseal(struct tpm_buf *tb,
 	}
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
-	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
+	ret = get_random_bytes_wait(nonceodd, TPM_NONCE_SIZE);
 	if (ret < 0)
 		return ret;
 
-	if (ret != TPM_NONCE_SIZE) {
-		pr_info("tpm_get_random failed (%d)\n", ret);
-		return -EIO;
-	}
 	ret = TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
 			   enonce1, nonceodd, cont, sizeof(uint32_t),
 			   &ordinal, bloblen, blob, 0, 0);
-- 
2.39.5


