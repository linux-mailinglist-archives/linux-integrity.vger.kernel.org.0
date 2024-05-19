Return-Path: <linux-integrity+bounces-2467-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD3C8C9771
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 01:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6AB1C2090E
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 23:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFFB74404;
	Sun, 19 May 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBTyPX8Q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F9FC01;
	Sun, 19 May 2024 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716162692; cv=none; b=qNMFrA9a+5fjdDROYzHdsCS17diPluFP1WAeSyrqFH9PMYrij1JSgir+N0Z/YoJL+hgfKYM2+KroyuDtr2GqX7VZ1bcb28Tbif3Xl/tSPh0r5t4sw/jZtsY/8dEPWb0JBz/koeSWHH8In5e50xvJiACn+Bvge2uv/9IKfFhcN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716162692; c=relaxed/simple;
	bh=0a/VB7iwxfJ/j0uJ9oRqOBqUkIqRfPU0lYVZ0FT1bQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOYOD1SlTsiitAYGlq+z5VRNbpg3ZoY0bWMCVFrdVuxS5J9kRgYAhjdryUHmW3siDvANHEBqSwmdyjdHUnI69/OjJWQMnlMagyDQeyBTG03rpJ6+xhzexiyMlafaZ2aMQgSuJjN/OIWWAcllRYlme7CbhSs9B9VdTGHwGsLlRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBTyPX8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8750DC32786;
	Sun, 19 May 2024 23:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716162692;
	bh=0a/VB7iwxfJ/j0uJ9oRqOBqUkIqRfPU0lYVZ0FT1bQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBTyPX8QDYW67IOTT36BBtjpZeM0IrtGh7dSJEdLU1y5nJ8v8UdMN/y5Kxt+LDi8X
	 Ql+iBG8xHy5ohPAGL3q+ohl8puthjrgpcuS71IRmMW/JnGZYiOlfL7rbTgfYdzNxAs
	 lHR9XqMvtl3YaiwMOoadYr1OaJ3rbRl30RY2YXkI9sNyETHAC+u/whffVT9xSsqC7f
	 wDNbqQNrDQ5C54blSzdrwCDI7NqLgc9HdKe+zq4jVZa2C09CkmMRFCGHdlHVH4LYrE
	 I1FIZseAJozmfH1KvfkMaoMmOOsLeoOxP3mOBhkmqujTM7Ic6hqb4DTKB5bo9KpHKL
	 SmIDOGLPmNH4A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	James.Bottomley@HansenPartnership.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Vitor Soares <ivitro@gmail.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
Date: Mon, 20 May 2024 02:51:19 +0300
Message-ID: <20240519235122.3380-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240519235122.3380-1-jarkko@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
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
2.45.1


