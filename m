Return-Path: <linux-integrity+bounces-2988-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AA9926814
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 20:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F584B2413B
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C31891C6;
	Wed,  3 Jul 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ9JNtkw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6D1849EB;
	Wed,  3 Jul 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031107; cv=none; b=WkVPy9CYqa5HyDphp1N8lRgd4nP196a4CerBsyTQwqRWav0l1hc2Mt93Vt2PR5ecQmZUG+pJnsvnthSM0p5fQawEOuqrn3qZLmRL5+nRYVy2nprTbhT2FaFdpJ3TaewoG4eRG23WtSl9unE6z9rW7+jiZ+qyWkcmNu0WxK0crnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031107; c=relaxed/simple;
	bh=dabt/tzhuwy8245opiXUk9KD0F5uSrCDuSRV408xIe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQ7Gs/NSep1SUDzfrxKDsB87QSHZJ7hZUMM8VZOf341fza/W9hsrDVMgKBmeoa0wKaHvnLc6zs0x8RDlm5iNjyy7H6FWRyA2xUIbgtKVYpsM14KX9el6uMjMXZl8YPk3vKnpvldRlJ9E00h5d1WVD14fiR6DSCA0WcHlDCmhnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ9JNtkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79894C2BD10;
	Wed,  3 Jul 2024 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720031106;
	bh=dabt/tzhuwy8245opiXUk9KD0F5uSrCDuSRV408xIe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZ9JNtkw1SB3EzvrBGY8goTjBoUvdDrw8wgKwsXNoysGkMQaIqM/yVrVBWGJfWifa
	 5+2h4i+9VfsGlGdVRV6oAtTr0EvSAUVt4T5GNvzM+BORuEtK/wBFSW2XLdTiKvcl1m
	 eN0nBIZNRjfRg224l+0fq050FvnYhbPiOnEJbpw1EP96uC0CGY3t0J0ft4FATe2DjR
	 +pQQGdQF3VvnR2gZL1p3w1asxDAcm5syVB5kamD8IcWuXsoOBt8FEzOU4qKC1EvF7R
	 BrMW5CKLMXL+Ik6qwcqhisHbRIRibwoAIR0HOBTP0P7Czl07g/qiwDxL2u2AYOdtF8
	 4LXaaHwfrQhQA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/3] tpm: Address !chip->auth in tpm2_*_auth_session()
Date: Wed,  3 Jul 2024 21:24:48 +0300
Message-ID: <20240703182453.1580888-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703182453.1580888-1-jarkko@kernel.org>
References: <20240703182453.1580888-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unless tpm_chip_bootstrap() was called by the driver, !chip->auth can cause
a null derefence in tpm2_*_auth_session(). Thus, address !chip->auth in
tpm2_*_auth_session().

Cc: stable@vger.kernel.org # v6.9+
Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Closes: https://lore.kernel.org/linux-integrity/20240617193408.1234365-1-stefanb@linux.ibm.com/
Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Use dev_warn_once() instead of pr_warn_once().
---
 drivers/char/tpm/tpm2-sessions.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 907ac9956a78..2f1d96a5a5a7 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -824,8 +824,13 @@ EXPORT_SYMBOL(tpm_buf_check_hmac_response);
  */
 void tpm2_end_auth_session(struct tpm_chip *chip)
 {
-	tpm2_flush_context(chip, chip->auth->handle);
-	memzero_explicit(chip->auth, sizeof(*chip->auth));
+	struct tpm2_auth *auth = chip->auth;
+
+	if (!auth)
+		return;
+
+	tpm2_flush_context(chip, auth->handle);
+	memzero_explicit(auth, sizeof(*auth));
 }
 EXPORT_SYMBOL(tpm2_end_auth_session);
 
@@ -907,6 +912,11 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 	u32 null_key;
 
+	if (!auth) {
+		dev_warn_once(&chip->dev, "auth session is not active\n");
+		return 0;
+	}
+
 	rc = tpm2_load_null(chip, &null_key);
 	if (rc)
 		goto out;
-- 
2.45.2


