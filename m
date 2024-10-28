Return-Path: <linux-integrity+bounces-3918-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB19B249E
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 06:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243CE1C210DF
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 05:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DE18CBFC;
	Mon, 28 Oct 2024 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClqiLAlM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FF18CBF9;
	Mon, 28 Oct 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094630; cv=none; b=prFOJtVvNe+Bns9D4Sd0+xxZ5Z47lcFIayzcAVw8L91r6yn24zhi6P3/rqyAlvGX3GR40+S+ITgZPy/v2fWJTP0R6nQ/nB2UXwfT7ziZxef71riLr7rWqGGKZYGWbdpM0mh9MIxcqamD7GRE4n1FPQyFGnB8lW/yX9VfOp2kWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094630; c=relaxed/simple;
	bh=XCl1yMmjSZe/N+58hVzZinUX+FhB2RuhENSeqHEfICA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru1oP15EwOtYBUPFYhYdUqmY7nyL94pXpefTu0Sk9UtZrztcP18VIxtAMfZM+BmrCSIrJ//aNSSxVbw/dyWmXAckCUjxaygmtSZfmbzfsxlUVyGHwYJtnalK+nKthpQo27no4aa1ABlLHb8SQATFq93opPvE1Plij2dbyZbcujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClqiLAlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35271C4CEC3;
	Mon, 28 Oct 2024 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730094630;
	bh=XCl1yMmjSZe/N+58hVzZinUX+FhB2RuhENSeqHEfICA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClqiLAlMkiN/DrZw9ugwPsZjE2a13LnBH68M15USUJdgIri7wqh6mvs/pgttHRWSi
	 fh6X75u8MZzEDqsgwQNfWGkXs9XSBIB9HGl6vtEP4jTgRoTSUSB9eR7fTlUSXyw9fx
	 a6JdOd9vNNUaYKnS/x1YWqoXmYpBnQebIuWPGivtyarv+vWoBczqRw0k+Dwt/mBKlD
	 99fhbfzxyz38qwsSEPftm6L/4vzKNxNLcaUR/zd1pELSVueMBlXiMpF61Xx+YYr/eI
	 IoGU2yk7t2EQhKjOhjVXRVqhMMYgFKtgvuVAyXXc7sU+Ge9573Xh1WlsI06YJv1upn
	 JQrbqkF5YGf7Q==
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
Subject: [PATCH v8 2/3] tpm: Rollback tpm2_load_null()
Date: Mon, 28 Oct 2024 07:50:00 +0200
Message-ID: <20241028055007.1708971-3-jarkko@kernel.org>
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

Do not continue on tpm2_create_primary() failure in tpm2_load_null().

Cc: stable@vger.kernel.org # v6.10+
Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v8:
- Fix stray character in a log message.
v7:
- No changes.
v6:
- Address Stefan's remark:
  https://lore.kernel.org/linux-integrity/def4ec2d-584b-405f-9d5e-99267013c3c0@linux.ibm.com/
v5:
- Fix the TPM error code leak from tpm2_load_context().
v4:
- No changes.
v3:
- Update log messages. Previously the log message incorrectly stated
  on load failure that integrity check had been failed, even tho the
  check is done *after* the load operation.
v2:
- Refined the commit message.
- Reverted tpm2_create_primary() changes. They are not required if
  tmp_null_key is used as the parameter.
---
 drivers/char/tpm/tpm2-sessions.c | 44 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index a0306126e86c..950a3e48293b 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -915,33 +915,37 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 
 static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 {
-	int rc;
 	unsigned int offset = 0; /* dummy offset for null seed context */
 	u8 name[SHA256_DIGEST_SIZE + 2];
+	u32 tmp_null_key;
+	int rc;
 
 	rc = tpm2_load_context(chip, chip->null_key_context, &offset,
-			       null_key);
-	if (rc != -EINVAL)
-		return rc;
+			       &tmp_null_key);
+	if (rc != -EINVAL) {
+		if (!rc)
+			*null_key = tmp_null_key;
+		goto err;
+	}
 
-	/* an integrity failure may mean the TPM has been reset */
-	dev_err(&chip->dev, "NULL key integrity failure!\n");
-	/* check the null name against what we know */
-	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
-	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
-		/* name unchanged, assume transient integrity failure */
-		return rc;
-	/*
-	 * Fatal TPM failure: the NULL seed has actually changed, so
-	 * the TPM must have been illegally reset.  All in-kernel TPM
-	 * operations will fail because the NULL primary can't be
-	 * loaded to salt the sessions, but disable the TPM anyway so
-	 * userspace programmes can't be compromised by it.
-	 */
-	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
+	/* Try to re-create null key, given the integrity failure: */
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
+	if (rc)
+		goto err;
+
+	/* Return null key if the name has not been changed: */
+	if (!memcmp(name, chip->null_key_name, sizeof(name))) {
+		*null_key = tmp_null_key;
+		return 0;
+	}
+
+	/* Deduce from the name change TPM interference: */
+	dev_err(&chip->dev, "null key integrity check failed\n");
+	tpm2_flush_context(chip, tmp_null_key);
 	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
-	return rc;
+err:
+	return rc ? -ENODEV : 0;
 }
 
 /**
-- 
2.47.0


