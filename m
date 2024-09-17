Return-Path: <linux-integrity+bounces-3627-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDCA97B25F
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64839286BB2
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CFF197A8E;
	Tue, 17 Sep 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAE0QSA5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516217BEC3;
	Tue, 17 Sep 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587924; cv=none; b=qrVJoerGuHccKNYL7RWX8wXyyCzsokRwScxYkLV7ZCCK8SuNntuIr6BpNsYG4BgjeteyqOqbUwJdMUzAzzQIv74DkD0JNQK2DkGQVs48/2h0l5ZK+S4zsP23+h3GPvq2pLpeXiyZ2yoQ8ZXWfzIoKphBZFuCyELmg1s95JERd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587924; c=relaxed/simple;
	bh=cogOvavHdY+bOLWky6a19ab7QS0R/kyUy+elvwMD+8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAzFliSBlsPFC0B880QJovT18JsLoA7ZKrGrspSiIiuGt8AZR+auMnOWOPyew9RB+2fOM5cdirnIRFxResH4tUWHoBzxvgXTwidR3JqFs42nVALCimhQ/EAPasSm1zLYYqJbHHhKoVcrET/vEdBkezPU2gojdfQqXxc6dyPOW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAE0QSA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AECC4CEC5;
	Tue, 17 Sep 2024 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587924;
	bh=cogOvavHdY+bOLWky6a19ab7QS0R/kyUy+elvwMD+8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAE0QSA5Q47KqSDJ8Urj7f8ny0MWEE0E9/KopCBWe2vv2QFiu9HoZEb84kgXSrcxr
	 XH0Ifng2shmQwEI+UCariZONqHLEb+r3iJNJXqgx9imPz0OigdJ2GytObiNl4uxsaf
	 NoUsI/F+dYXPXGxHy42BWUQqZ5QaD1LpA9okGUEKpfXSi8IBGiXz20zC01i5+I23uM
	 rcgPV4ncPHqHjBfIR76Oow3lA7W39VATlgpCUb+Iddt1UV/kJnmVydS0/tgddq5o47
	 DIdXPm3G76l53S4ldCfRGFLXC1qFg44A1PO0SEQSBaEJs1VNc+7647VAPh54bCos73
	 oiIxOUkEEs/Qw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] tpm: open code tpm2_create_null_primary()
Date: Tue, 17 Sep 2024 18:44:36 +0300
Message-ID: <20240917154444.702370-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917154444.702370-1-jarkko@kernel.org>
References: <20240917154444.702370-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As tpm2_sessions_init() has been shrunk only as a single and only call
site for tpm2_create_null_primary(), open code it to the call site.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- A new patch.
---
 drivers/char/tpm/tpm2-sessions.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d240039d0849..72c83eb3f665 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1281,7 +1281,13 @@ static int tpm2_create_primary(struct tpm_chip *chip, u32 hierarchy,
 	return rc;
 }
 
-static int tpm2_create_null_primary(struct tpm_chip *chip)
+/**
+ * tpm2_sessions_init() - Initialize the null keypair for authenticated sessions
+ * @chip: a &tpm_chip instance
+ *
+ * Return: 0 on success and -ENODEV on failure.
+ */
+int tpm2_sessions_init(struct tpm_chip *chip)
 {
 	u32 null_key;
 	int rc;
@@ -1308,23 +1314,5 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
 	/* Map all errors to -ENODEV: */
 	return rc ? -ENODEV : rc;
 }
-
-/**
- * tpm2_sessions_init() - start of day initialization for the sessions code
- * @chip: TPM chip
- *
- * Derive and context save the null primary and allocate memory in the
- * struct tpm_chip for the authorizations.
- */
-int tpm2_sessions_init(struct tpm_chip *chip)
-{
-	int rc;
-
-	rc = tpm2_create_null_primary(chip);
-	if (rc)
-		return rc;
-
-	return rc;
-}
 EXPORT_SYMBOL(tpm2_sessions_init);
 #endif /* CONFIG_TCG_TPM2_HMAC */
-- 
2.46.0


