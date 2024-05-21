Return-Path: <linux-integrity+bounces-2507-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808088CAF10
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F539B22886
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570FF770F1;
	Tue, 21 May 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH5xBKK+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428E757F7;
	Tue, 21 May 2024 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296974; cv=none; b=DXBBopf29htgHSq4cgU0kUD1mlhBSBt8qKJrgwiIzuIKEO+ZofHJn6dMdaOVY1RaVO6aHZoeVy2kfGhn5hxFCGdelm7RdWk0tnHewR0YZ7yLjPftnIe4YFOg5K/sTkbO4ThiwUmfX+Twzdl0zwY1cWnBqvOUWAa/fOYN0gqWZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296974; c=relaxed/simple;
	bh=pX4lnz4Ho0YAIupiqTKt1T4eoxbg1bfM27YVtkVjMfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbWmV400W2na8sg9MzNvMLE2RL8DCb3h8LlnukyTmoDCuGRIu9X6TyzYxu99/9OzUVsP821kdQyx06+pSF3AZ2RjKMF+NOYUdMqquI8uaIFCGkc1q5qjm3zqaPqiMXZNrvob7RkAGA1Z3qF/qCRIQBcYY9LNGHDRea1gG9E8aC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH5xBKK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D545C2BD11;
	Tue, 21 May 2024 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296973;
	bh=pX4lnz4Ho0YAIupiqTKt1T4eoxbg1bfM27YVtkVjMfk=;
	h=From:To:Cc:Subject:Date:From;
	b=bH5xBKK+bAt0U0/m36L2l1OKfYOn/f5e5wTrhnBON8A4mJwpfMWh9Vf08p//Yd0Ib
	 Y1o/1+6u5Xif1+KmFK0QWaw/M3yW9aGUa/syO5FaqUfVSgRotQdmVkTtOFFrqLgJ0F
	 1XR6CdfAnT7cMXJ0vVsa1/6rUogZFh8DBsIhytDplCrAGT5mAHZcr9B/wu5DVzm3o1
	 6oekdRx4087LJXVl8xSZ6pb/0+j2zKWL6/C4GNmgex0bzl6oXrzlbxtiX29lWiPLT1
	 KeDA2AOSWloFqgZauV10MDp3qiBl4E+bf3W6DUDYJNwr3BLXu6w468IA12gc55D1CG
	 k4xtRvi058r9w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
Date: Tue, 21 May 2024 16:09:20 +0300
Message-ID: <20240521130921.15028-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's be more conservative and enable HMAC by default only for the
platforms where it immediately makes sense, i.e. x86-64 and aarch64.
This can be relaxed later on, and obviously the kconfig option can be
set even if not default on a particular arch.

Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Closes: https://lore.kernel.org/linux-integrity/D1FCAPJSYLTS.R9VC1CXDCIHH@kernel.org/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index e63a6a17793c..19e61dcfcbbe 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -29,7 +29,7 @@ if TCG_TPM
 
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
-	default y
+	default X86_64 || ARM64
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
-- 
2.45.1


