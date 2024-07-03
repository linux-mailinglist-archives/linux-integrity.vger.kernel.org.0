Return-Path: <linux-integrity+bounces-2982-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB839266C5
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 19:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365D2B22FD3
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE83185E62;
	Wed,  3 Jul 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFpRZ89b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AA170836;
	Wed,  3 Jul 2024 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026511; cv=none; b=Q7M3BHYRMpEYwmFiTDHK5f5nwyahadcCeHCTa8qXa2tUyq7HDvexnrhiIgCwrUOYmhsT5QyTclCmlPCmvJRyZMS+aEvhWBpJDA9azCx0OBhh9lcEJPXohM0k7fzTXGT4HBRWtSjxWOH7cA5afjdERHZd4y+8vgoSTc46ClM6Ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026511; c=relaxed/simple;
	bh=Bh1WZOoD8rKJfSE9pl8waPuK6bvUrIYjnIk14Lhl74Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJSe9NQ5iyvtgeEc83hzdmLLqsodeX5Ywv71umE8W7dd5E+GpCIUU21rCh26vxVj25kS+B+BzfhQZ1fBuzxQUQQddX5Gr5abkI4dcR90WLAkDtu4Nsb/e4MiT5Vfd5nNVqGDTxL5YaYHLj3xeTNN0wlcpZ1SrMQRXwGJw0+nyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFpRZ89b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685BFC2BD10;
	Wed,  3 Jul 2024 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026510;
	bh=Bh1WZOoD8rKJfSE9pl8waPuK6bvUrIYjnIk14Lhl74Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFpRZ89b0KtwSS9waMgMXui/2fnOZZ9z3NItxY0ddnZwXlmeMZgST1I9v3aVuofs0
	 xvazMkI6nYVX9UpTDlhJARenBQ2LA63SzrLu8q8cSOA7ttA1tuLq7YDjwn6j+yiLjV
	 TBxaLIKyTxqA4s2C9LCvrThwUwzHyFxoXEgysCz/gD8K7eaziOB+E8XsgIWWQol+lt
	 II9ity4St4acMIpr54/iVktEPX8xXmACfsjiuIz/iXNiNyjxo0cT8eL8J+0rqZMIQ7
	 ncp0DlIF0qQfxBPmMOt/8dz5rAImuq1IvvrcKfY01gpPGEEhS0JSqkSh+as9OWZm1o
	 qI/Dp2XzIJANQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: [PATCH 1/3] tpm: Address !chip->auth in tpm2_*_auth_session()
Date: Wed,  3 Jul 2024 20:08:11 +0300
Message-ID: <20240703170815.1494625-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703170815.1494625-1-jarkko@kernel.org>
References: <20240703170815.1494625-1-jarkko@kernel.org>
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
 drivers/char/tpm/tpm2-sessions.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 907ac9956a78..d94b14757452 100644
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
+		pr_warn_once("%s: encryption is not active\n", __func__);
+		return 0;
+	}
+
 	rc = tpm2_load_null(chip, &null_key);
 	if (rc)
 		goto out;
-- 
2.45.2


