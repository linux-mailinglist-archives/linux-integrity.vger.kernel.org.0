Return-Path: <linux-integrity+bounces-2671-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFB98D1308
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 05:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962A1284571
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84866175AB;
	Tue, 28 May 2024 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMR4uXbx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7538DD4;
	Tue, 28 May 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868322; cv=none; b=J5YaxeMKl7kTIHTsy2P8y86NtcyMo6ituUweT8T6CXAHosh2ps7U1RnGmbTn2JrFI6gAfwVnivTmnjJ+5h6OrRec1UFuSUVD4MHRa0HnvPMr7jG9FwICg3o9KaKVkNnhVh6TxOZNQLpmaLdsMKu4UOHrHi1TCfGAsiJLjtA2AL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868322; c=relaxed/simple;
	bh=h8orBF4zzRfW1mNSKt+5IoMKfbFfiHan4PWjJTDQxIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu7IlmlXWVRv+pswWsSzGcTg9UQef/En/4OLQpyiTR9IKtLguaAXDJ4TNMTRBKa7YjjDvQDO2YsI6IrbSgx9iGJdfJuMvQp0JlNV6U1fw/6+cjHsniD60KDZib1mdZWHay6evkZR1ya+ZeDSUMoLMVIWsIwayBFRNZ2WPaXv4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMR4uXbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE52C3277B;
	Tue, 28 May 2024 03:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716868321;
	bh=h8orBF4zzRfW1mNSKt+5IoMKfbFfiHan4PWjJTDQxIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMR4uXbxPtMAAUSDyjM0JaGvYfg95UpO8ERhJg1kuQ1NZQlv5asuLufFPLmH8X1/i
	 JO1mODpqnsFGWlgfYu7IyKMRNDDqTowWakrJ2j7doKBVAYJgucOebgf7t4TDu1+gwo
	 ZrLeTqIFxuOLt+Xn6CAhe/g2CvM/5ohEIyeCYHioYRRSWEEQyAaU32MemP3t2nN6qe
	 mbAsY4Qf82aMGXMjGf/lAXSvKKNJTT9UHHEzigP5wzd2irOP9aJFXHVlNOfYqC7mt4
	 mwVU2SdFbSs4EUZwh5vox+vpasfqjVm6UGq3BKsm4si84c/QPk/zdE3evigcnw8TKc
	 K7zW1IEcnu2Nw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list),
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v6 3/6] KEYS: trusted: Change -EINVAL to -E2BIG
Date: Tue, 28 May 2024 06:51:18 +0300
Message-ID: <20240528035136.11464-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528035136.11464-1-jarkko@kernel.org>
References: <20240528035136.11464-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report -E2BIG instead of -EINVAL when too large size for the key blob is
requested.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 8b7dd73d94c1..06c8fa7b21ae 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -122,7 +122,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 		return ret;
 
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
-		return -EINVAL;
+		return -E2BIG;
 
 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
 	if (!blob)
-- 
2.45.1


