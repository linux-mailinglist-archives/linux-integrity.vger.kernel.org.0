Return-Path: <linux-integrity+bounces-3917-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8239B249A
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 06:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827371F213D9
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 05:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055D18DF87;
	Mon, 28 Oct 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTtuA7QU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9018DF7B;
	Mon, 28 Oct 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094625; cv=none; b=krz1O0ZCjvwE/YxAcF0wWCkpi6HbdU3YH2lnVQe4XuMQ7mq6hQag1eZEEUGhrhUypLDBMKOGVOkJmTCMOk3ZdxYlAH/O4QWTdMr6XVqyB8Fntm7ISyZYwenTNfxCLYRRK5EFR16yqRuNGoI7Yha/TzHQ9SRw1cITtqw9g6wZyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094625; c=relaxed/simple;
	bh=cphvGT84GpWQdpKAIyfVpKkY71YTs0aVCk6EV1mh/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GadcqZI0wR0HKqxO6SJXFvg/GSSfsQUpmXyKnKW/9mL4SiNANUIYT2aUey3VeftxEyzQ4ARIntfzZfjaH/2YvJ5TMhMI/V+lAABzhFVF6aRHO3K+tCoVCWAM4Tem+SAyMXgRfGRXTY7dG7437LdhN3ELV3lY4vdODS0pLIUtPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTtuA7QU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAA0C4CEC3;
	Mon, 28 Oct 2024 05:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730094625;
	bh=cphvGT84GpWQdpKAIyfVpKkY71YTs0aVCk6EV1mh/Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTtuA7QUYZswPSu3j8yKgx7hvjTM4TiKnXDnkS5abTEXhfg6EmiRiLMwTGk77o8Qr
	 P3fq7fyGoo75+YX8A/HAys7Zsu/LQKImvwgUgvZBIdJXmAFwIczBCWovDIQ0qXHmTT
	 1nR7dEVXUDNXx0BEsN9G0nqJxMbrrMjrJCiIn//BQ9schZbzYf7s3Ixky829+nv+hY
	 fwpXJ7RK8VLdGcN3+Fe1GYzS1kZpCtagRd8dZstgefSFNYCciyvYX2i3MF5aSEZfdU
	 ELC/kXjPDS/e35O0vPJgOwcr2tbu3NrUbCxDMHUTe3+EZwqH4puT0TgCyfldTcfeHf
	 e0Z6djDubZKOQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	stable@vger.kernel.org
Subject: [PATCH v8 1/3] tpm: Return tpm2_sessions_init() when null key creation fails
Date: Mon, 28 Oct 2024 07:49:59 +0200
Message-ID: <20241028055007.1708971-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028055007.1708971-1-jarkko@kernel.org>
References: <20241028055007.1708971-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not continue tpm2_sessions_init() further if the null key pair creation
fails.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v8:
- Refine commit message.
v7:
- Add the error message back but fix it up a bit:
  1. Remove 'TPM:' given dev_err().
  2. s/NULL/null/ as this has nothing to do with the macro in libc.
  3. Fix the reasoning: null key creation failed
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
 drivers/char/tpm/tpm2-sessions.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..a0306126e86c 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1347,14 +1347,21 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
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
 	int rc;
 
 	rc = tpm2_create_null_primary(chip);
-	if (rc)
-		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+	if (rc) {
+		dev_err(&chip->dev, "null key creation failed with %d\n", rc);
+		return rc;
+	}
 
 	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
 	if (!chip->auth)
-- 
2.47.0


