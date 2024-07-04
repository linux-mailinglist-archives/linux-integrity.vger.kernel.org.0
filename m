Return-Path: <linux-integrity+bounces-3006-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FDF927D50
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC071F24736
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCFF13A260;
	Thu,  4 Jul 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxpYjMPL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0A54660;
	Thu,  4 Jul 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119206; cv=none; b=YvbBP9Lx6WY4nCAsc2uicg3Delux3unpsPCGTYJXK8LWKNx3axWa+3Mr9Dk+lT8oIq9DEzEmkOY/bhlDQ484O5b55jI9Pce2fDm5UUzehajLhrxBKAWAgjvtbqbmA/L4LQC0tq2uwbpUDhLtzZUbS8KlBBo+nafvLwabPHjaQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119206; c=relaxed/simple;
	bh=ozB6sXxoZjPGE+obe6yHmAPktZE1u9uWHV2bB0LM1Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJW7GZTjgLJePAdynKASZGYpgCheBrcH2mWQAcMFFx9JCv1rXTQY7dx6aGXss4pxZ69WgqGbRyPV/+QPnrqQZwF8xCrmnLWKeXArzHUuc/fKfaVblp2acPHi4LHj4QRf9/6n7Jphu2CzVvKy5MjibgTtompO2nWRiGwqlhf6RN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxpYjMPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D968C3277B;
	Thu,  4 Jul 2024 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720119205;
	bh=ozB6sXxoZjPGE+obe6yHmAPktZE1u9uWHV2bB0LM1Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxpYjMPL90kk5BfTb8v/F776y8N3oYo133wDOgEGHMsg7oVJ1r9rkbeGMyQgrNg0N
	 rkwMKKqiCIIdvo5EvTtdlxg87Q1zFuPlF279GkMnfawAo5bW2iZv4jBEsboUz2EnPU
	 nBg1yPFyMhRqYxS4CdHUtUlAssKrOKHWWNJHMac4fm/gP7N5zOGEm0tV3fRwPntVVs
	 /G/UEqIeoMUytJPw08YhXA/tmBpeCJgU50k5vTe22n+QR/x3ee2/fd+7mQJooBOdh2
	 UzLs7sisM6s/l7lcLoJgYSifWL8x1B/eEeHh61YuHEWZn/9QjpUYUHnboYFctz4ldH
	 2yX1q3tK5GecQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] tpm: Address !chip->auth in tpm2_*_auth_session()
Date: Thu,  4 Jul 2024 21:53:06 +0300
Message-ID: <20240704185313.224318-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704185313.224318-1-jarkko@kernel.org>
References: <20240704185313.224318-1-jarkko@kernel.org>
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
Tested-by: Michael Ellerman <mpe@ellerman.id.au> # ppc
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
* Added tested-by from Michael Ellerman.
v3:
* No changes.
v2:
* Use dev_warn_once() instead of pr_warn_once().
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


