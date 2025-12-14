Return-Path: <linux-integrity+bounces-7976-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B0CBC060
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 22:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FD1E300B82F
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 21:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739A28727F;
	Sun, 14 Dec 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnD3XFEB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057732772D;
	Sun, 14 Dec 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765747963; cv=none; b=kuIJpXmyaMTgmUdtGofx9D5x2tpmkowsVJEQYWWVswoVQkMoUUEQI54pwXd/5WpkAArtCgsQJujmCSJ0sr8QwnLbUTQA+DmEg3OYOrT1+kbjFnZ7IAllpzcgwgtTanEwNDJ/EoeIIiORlAel59e4fEVDg0aZPKs6PKq9AAZBqfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765747963; c=relaxed/simple;
	bh=OPfV9+beCTEYX6TFJLkhS1HZUvA+/J8PLcpBI9k3iIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HoiYW/NI5elnMYufCLnUp+Guu7E82+xwH+QZh7tFJY1u5PEs0oFX/rkmYpcd8YXhY+1x1hKkhfcCm9thFA5V7vnI0kbl1DGnNRCdQksZBJSSMIJMtHwzbMxWmSAI4YGnZ2aVmPMm3lUyWKoFU+V79e0D5d5Tin8p+XVUQ9LEGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnD3XFEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D17C4CEF1;
	Sun, 14 Dec 2025 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765747962;
	bh=OPfV9+beCTEYX6TFJLkhS1HZUvA+/J8PLcpBI9k3iIY=;
	h=From:To:Cc:Subject:Date:From;
	b=LnD3XFEB2YKkr9mncyxI2tTFCVv/lU6TxvxY6UM97TXzCBCNJMak3ooBP28ArI+Jj
	 BgrmcCVO8UEa0S3kn4UoXhzfL9ino1SpRx16L3VNQ9xgxpEKTfeppNS0rO7f5Kw0zW
	 gLlZtVSsW/xtb/lM0+nzPDB9KOiwUlaWI4f3XJmxV6S6zUOF52lmFBieawrv4wgxLg
	 BJjtsuFLR+GjaMyTpkEwWbxFw4r6lYXjg7+KM8WW2NNdoTus4eRxIzW70jHxXpwdq6
	 N70Akt8EoFofCuOvSC50mEDYHq10mS4IiUX5SJiwgCZAgBFk/dxcsc7D0OVXXIAB28
	 DbbOBU6/MGFCw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: trusted: Use get_random-fallback for TPM
Date: Sun, 14 Dec 2025 23:32:36 +0200
Message-Id: <20251214213236.339586-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
   use should be pooled rather than directly used. This both reduces
   latency and improves its predictability.

2. Linux is better off overall if every subsystem uses the same source for
   the random bistream as the de-facto choice, unless *force majeure*
   reasons point to some other direction.

In the case, of TPM there is no reason for trusted keys to invoke TPM
directly.

Thus, unset '.get_random', which causes fallback to kernel_get_random().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm1.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 636acb66a4f6..33b7739741c3 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -936,11 +936,6 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 	return ret;
 }
 
-static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
-{
-	return tpm_get_random(chip, key, key_len);
-}
-
 static int __init init_digests(void)
 {
 	int i;
@@ -992,6 +987,5 @@ struct trusted_key_ops trusted_key_tpm_ops = {
 	.init = trusted_tpm_init,
 	.seal = trusted_tpm_seal,
 	.unseal = trusted_tpm_unseal,
-	.get_random = trusted_tpm_get_random,
 	.exit = trusted_tpm_exit,
 };
-- 
2.39.5


