Return-Path: <linux-integrity+bounces-8047-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0774CC168B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 08:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2609C30B861F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B71340DA3;
	Tue, 16 Dec 2025 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpyiXQfq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF833FE30;
	Tue, 16 Dec 2025 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871112; cv=none; b=VcdL2vx5PPVk/cjnVOxr8uuQHRcvpmYV+o8iq2ygFyA5QuVEcMJcllwOXrXr+S7uvsAl0yQQ5eKdd2OfJNLYN5jaiEjhMJcByKInYrtybhIQjQyheBmctYzvtZAd7qGzpy+UqJVswsJAunczlgepoETEStBOuyHEyTq4KUuNbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871112; c=relaxed/simple;
	bh=9ueixsz8Nykx2JcyoqfkvTUfikUcc0s3hNapCYqs10g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uu63HSlSuGMlBAH+CdcK//w5hGPO7+usiDol23azgPKmyN9gEehRsmgtRCP/ylB7OBLHZDrbuq+27uHBTe8UiFrF9DemX9S50/RbILIzzxUkUR/ppxdVEevpCvA9DXHdDHnSwoA1aGsLh+/Tg1LNhumYsEvkkrUzUbLG1I5At+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpyiXQfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13384C4CEF1;
	Tue, 16 Dec 2025 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871111;
	bh=9ueixsz8Nykx2JcyoqfkvTUfikUcc0s3hNapCYqs10g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpyiXQfqEPtz3dDIAPcFLckWir7u6MyzGbAjTv/YMfQy0GNqyazB1QzblUbNwpNNQ
	 ylSDlH+S0xbRQ0CozUr2heJUREeNEZjnVcdpjeZIkwaYuKlCQfETtx9ONqDEKhTSAu
	 HNcUtmYxLdizLKk6C85dWl74OZfRjiv6QS3A06Adz3qvKPqmptQRnFfAw81+1i7glY
	 2BL5njSWrJEj+1E0McLxQSrqHOfXQDPVNAgb2ZW9yh0Z8UZZ3iyUYTwRM9c5XPdzhl
	 7LKchJn7BqgAnQU2FchBY53ZAegCRuyCcxsF0UTZ9cwXsfQ4urdxAClk7LD1RVRqoi
	 9lbqV3AL9gfOw==
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
Subject: [PATCH v7 02/12] KEYS: trusted: Use get_random_bytes_wait() instead of tpm_get_random()
Date: Tue, 16 Dec 2025 09:44:43 +0200
Message-Id: <20251216074454.2192499-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216074454.2192499-1-jarkko@kernel.org>
References: <20251216074454.2192499-1-jarkko@kernel.org>
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


