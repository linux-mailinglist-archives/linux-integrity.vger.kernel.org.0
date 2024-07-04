Return-Path: <linux-integrity+bounces-2997-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDE927251
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E11B229F1
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4058172784;
	Thu,  4 Jul 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaGrUAJe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6D17084A;
	Thu,  4 Jul 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083449; cv=none; b=VWhtbjiquRAf6jsNYLlegBB+aBk1U2uDUgw1JjN0UuhNddv6JDBhLSYY+mb8bh57fmDZQ2v/vv9oZEtKUTn3YRWrndyBTzQjvl07UgbB+JD2cMKS2LwnxM/kH/zy3BDg5pg+XSdEKX0B02hd2q5K5qf2yrO+zTEw6dw2O14IXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083449; c=relaxed/simple;
	bh=urQk/W7QgAkmeUdca4VhY2EisitaIXwv21mu/blon6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twntbI8ZQvO345OPHY14zwEdd+6Vn+8/OcHd2g8SgajVTNYaQwz6izdqPdl8El/wF1jjiF+a/fcFHAE/ce4dGR5B0/ENYgM2fH6OkME61qmmq9MQMGlj6IuA2L0hYxWm9pIboXNjVCNfK2lizESEaMtsex1jLJ5QszoqEf79Pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaGrUAJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD5BC3277B;
	Thu,  4 Jul 2024 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083449;
	bh=urQk/W7QgAkmeUdca4VhY2EisitaIXwv21mu/blon6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaGrUAJeFZW6Pjxa2pWT6qViw8ngk7vdm11z4lV3A3edk5pYhABC1Yp5FAHieIWjp
	 5cpFfMzVvLhN9/oPKlAXjCkEA3k1H6Rp6LczpINw3J9c2Yi3UKE9W7lzwFwIJxneOB
	 Det7u3bKk7Lr3jpQclllLzzoEhEPZLYrG8iaLBZAufUXvSTG9SVm8FhMY2trVPjBLO
	 flLoDTw+B4QJbLp5Mi/tX6DM/9pxHFFbUzqPzBt0EWNto3M79FD7gYn/iLcJV8iTYK
	 y0xrDjYd0g/3hkd2SuEeseh2iTlZDNcg4dFwtUZSKxugMYfXTd6DsFFYu9EI1XWT8h
	 jDrM5mNsHBqpQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [PATCH v3 1/3] tpm: Address !chip->auth in tpm2_*_auth_session()
Date: Thu,  4 Jul 2024 11:57:02 +0300
Message-ID: <20240704085708.661142-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704085708.661142-1-jarkko@kernel.org>
References: <20240704085708.661142-1-jarkko@kernel.org>
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


