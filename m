Return-Path: <linux-integrity+bounces-2699-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F58D3A3A
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD24E1F229B6
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9D16EBF0;
	Wed, 29 May 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQxmWSDf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4FD15B11A;
	Wed, 29 May 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994983; cv=none; b=Ct5kmO1lZVWAZXN7Dt0XbK8iM2yjyq77w6Co8v9NwJTyTkbZsskMbYKr9TFX+oKFxe8kcwc2F8j3pEdCGhzPtXoOF45VyZlqZNbN+OPoqLXi2g4YTS40wmoz+0o9gR8hS3bHu/xJXiizLHwM9uLAOsXqG09Vf14JoUGXnumwW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994983; c=relaxed/simple;
	bh=GgJTrTZisEXG4OMYBlgiTpElAAP3aUEM38oKEk6OIgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZzujF+3EvowF1bhfxdp/zv9r3F+2HP68bf5RGBtApS6bly+o3K8jbGWLTqdu3jagPVoPAyf4um8sR90menBSERcGNnQs2bKjH6mgTqX8QZADezu4Ym2W5nHuoeq/HBGfY8msJjm8knqwNPa3WqBUt3/k8yUJ2w881wv1j5ICuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQxmWSDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC26FC113CC;
	Wed, 29 May 2024 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716994982;
	bh=GgJTrTZisEXG4OMYBlgiTpElAAP3aUEM38oKEk6OIgE=;
	h=From:To:Cc:Subject:Date:From;
	b=nQxmWSDfytkUQyRo+wZ9v6jYtaba9+r14sI5ypj2JwXsNfW6U7pSkaB1Gyw9BtUUt
	 /qcY1pCFtUCL3AcCibBndTdfDP9o6i3s+vIwCGvUmD1vhPfC0fqMBHD/eOrnP3HfsH
	 z742rZlRQ5oUdXUEuKW3XnS1az68qUetk+AXhIJtx9MmmdarIqP68pzlyBSKPPpAVr
	 ltci8DAuAaMrGWOMfGjGT4O37ofsFkaZIpEh7TmBZzkXLOkMKHvZi70D8xNRz+r40H
	 6/bW4vOei5CUKMgmwTKoZ98Nl+YatiMAje3h53SU8Tli7g47n2LpxvZCjaMfO16+sl
	 PtmwX6tzPHzbw==
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
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: trusted: Change -EINVAL to -E2BIG
Date: Wed, 29 May 2024 18:02:53 +0300
Message-ID: <20240529150253.27630-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report -E2BIG instead of -EINVAL when too large size for the key blob is
requested. By filtering these errors from other invalid data, this will
help distinguish the overflows.

Link: https://lore.kernel.org/keyrings/D1M4GRF0RL2W.3QHTBXZWNW9RW@kernel.org/
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
I don't think this is a fix and neither needs to be backported but makes
sense for upcoming versions. Sending as a separate patch from the TPM2
asymmetric keys series.
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


