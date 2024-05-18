Return-Path: <linux-integrity+bounces-2447-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813ED8C90A4
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 13:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E2A282D63
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E35B39FFD;
	Sat, 18 May 2024 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiDzSSuc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4D39FC1;
	Sat, 18 May 2024 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716032073; cv=none; b=fwbWQCth9qRRwkoGMdmyZ6WZOLddky4xOaJNljfaspTlGhAkNuANZgc4kZzPZ5kUigBOt49qcTkW6cMR5qhh0eR/kBB8uK5SRtBnoH0r6PBpYULFaNYO6NgN0iPA4LeZRHnkJJ3QaCYpv9tsnWgwRF2p5vEqg0UjaHcOcuZlx4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716032073; c=relaxed/simple;
	bh=lh54TV2ei8xvwUkn4mkrDUhs2EQCaYP+o8zISbosFVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNruluUG8h/Njfq9LvG35s3sAR13vAXbZQ6cgpIdP/ezTIVaDnd/4txwzNOloheFjhqvUFPiFSfO13hBAMTeuBAUXMZxqzjo2s+a9yjqBWRTcypcAKdrBjY3IHuwY5IUhq6W52JH0upQWbxGw+YLVb7TWodeXCMdYFkURMrhMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiDzSSuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BADC113CC;
	Sat, 18 May 2024 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716032072;
	bh=lh54TV2ei8xvwUkn4mkrDUhs2EQCaYP+o8zISbosFVo=;
	h=From:To:Cc:Subject:Date:From;
	b=OiDzSSucr/DxyvTLqvETRdx5EVpumXoBBJiMPCxfLsYaEKZgPCrWhQPjzo+8jgfhC
	 vC3Ql87au/4nFYBr3hiOtAvIAoE36UaLXvD9BVStKz+oD8W/GoelAnoYWm/Nagbp6q
	 7rh5LG71FshBVpSSKb6z8WwJSR8txuQQPArLvWea51iZOh2fvrYU8znCii+mAg6L4Y
	 W2hacrzNGKepwiiqZIqTfeirpwX/b5DJL9xJ2oKXQFThGACWMGzN4Bh+cnTKYLM9Z/
	 N/qSDoOLx4gMaL3aRAFH1gtnG2RaYVzGJQmCaCtJbnv3Nxtkhs2v9BwRJ/Jjya2DjW
	 bh2C6zZi+y0Jw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Vitor Soares <ivitro@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Date: Sat, 18 May 2024 14:34:24 +0300
Message-ID: <20240518113424.13486-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Causes performance drop in initialization so needs to be opt-in.
Distributors are capable of opt-in enabling this. Could be also handled by
kernel-command line in the future.

Reported-by: Vitor Soares <ivitro@gmail.com>
Closes: https://lore.kernel.org/linux-integrity/bf67346ef623ff3c452c4f968b7d900911e250c3.camel@gmail.com/#t
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index e63a6a17793c..db41301e63f2 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -29,7 +29,7 @@ if TCG_TPM
 
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
-	default y
+	default n
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
-- 
2.45.0


