Return-Path: <linux-integrity+bounces-3816-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F799F85A
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 22:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DCB1F22B1C
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614191F9EAE;
	Tue, 15 Oct 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpSk/pWW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404C1F80DD;
	Tue, 15 Oct 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025934; cv=none; b=VCe1A3k2VX1y/5F7o0JQsRYvYQXBfsm0vKd//kijbo4JK/qkLexmawS3hlDnlRNHANECR8UJKTQYs6Oj/r748IYlYDSQIqQy9a1W32by/d/0DD2e7m55FiQnrVncdXCjjjWp0nvNznoIwkFbELMknUjb+5qECmt0XM5Zupuz8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025934; c=relaxed/simple;
	bh=OdfbPphNVRToS+4L7iWif22RAzWjckEAkN41WHeGg50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKd0c3k/AbpxwMXw9Gg6SDFDfFgX2c/jmrBDIlplu1MSZSa7wIX1FiwPzPEr9EBp58se3xRA7NiEz1V15X8WE4mdPsyRN9pfITxdOQ5Po3hN9xkJ8AYc0082X5GwvTcZxU5pCkffYSAuAKsmfCHDjJGcXIMN/YZc8OXp1/vZSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpSk/pWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F55C4CEC6;
	Tue, 15 Oct 2024 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729025933;
	bh=OdfbPphNVRToS+4L7iWif22RAzWjckEAkN41WHeGg50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpSk/pWW0GDNpTpxzpLph+2NXw9KHKsaY1unOGf+3SFCoq6Rw9rgx5etGj1h0uTy0
	 WT6jIOY5wwV0r+3J5hOa3DEVhvgYKT8IfmBIsKJwcmMDZYtjLt1c8Jef6lzrX0Glvl
	 vHrUlHvyv8R9kjvD0ZvueV8oa+MvmB8aYbf4zn1g5sdgL/D56ASk87LZ8ER+v6aXvF
	 dAXsMOpjEZYDvEDMm0Jyu3z4Ep7PialQRyNtbkdKRKVV54MBWFdnVjIbNByibA52f+
	 zfspTtTa5B+nNNw/BTcWKvb8ZS/t1hEpNHGslTgDVmHwCqqyDZbCMBCIHIVVwektxS
	 gX35w2B2jxpag==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	stable@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] tpm: Return on tpm2_create_null_primary() failure
Date: Tue, 15 Oct 2024 23:58:36 +0300
Message-ID: <20241015205842.117300-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015205842.117300-1-jarkko@kernel.org>
References: <20241015205842.117300-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_sessions_init() does not ignore the result of
tpm2_create_null_primary(). Address this by returning -ENODEV to the
caller. Given that upper layers cannot help healing the situation
further, deal with the TPM error here by

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v6:
- Address:
  https://lore.kernel.org/linux-integrity/69c893e7-6b87-4daa-80db-44d1120e80fe@linux.ibm.com/
  as TPM RC is taken care of at the call site. Add also the missing
  documentation for the return values.
v5:
- Do not print klog messages on error, as tpm2_save_context() already
  takes care of this.
v4:
- Fixed up stable version.
v3:
- Handle TPM and POSIX error separately and return -ENODEV always back
  to the caller.
v2:
- Refined the commit message.
---
 drivers/char/tpm/tpm2-sessions.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 511c67061728..253639767c1e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1347,6 +1347,11 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
  *
  * Derive and context save the null primary and allocate memory in the
  * struct tpm_chip for the authorizations.
+ *
+ * Return:
+ * * 0		- OK
+ * * -errno	- A system error
+ * * TPM_RC	- A TPM error
  */
 int tpm2_sessions_init(struct tpm_chip *chip)
 {
@@ -1354,7 +1359,7 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	rc = tpm2_create_null_primary(chip);
 	if (rc)
-		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+		return rc;
 
 	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
 	if (!chip->auth)
-- 
2.47.0


