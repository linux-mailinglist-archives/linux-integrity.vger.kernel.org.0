Return-Path: <linux-integrity+bounces-3817-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E699F85D
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 22:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C23284AD2
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6738C1F9EAE;
	Tue, 15 Oct 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN3RLaGF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BA1F80DD;
	Tue, 15 Oct 2024 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025939; cv=none; b=L5N0iW0waY+LR3rlpdN5QfxOpxNq+RGyffdOhXJp1G3CwLrRh/ms62yIxnDodr84OPSp30I7hZruUsIpjmDCM1E0ApNQFcSDDAy8GdQQ5Wthn/4obKg3r7bvc0s9nWUthV07xX1dZV7/zZRyLcd4eZG3kGYDtReEc5/xl7ag3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025939; c=relaxed/simple;
	bh=eldE9A77XPppw7dIFi4hvn84XWAs9Hpi5aCEiES7OhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEMMhqAqEht+guIKAnhpdnNqkHIxVq/Uq32EHDLV17msL8UZ3CD3hVmmtg4T8gTkhkOuSwH+BpZeZiLf3uQTMS9qtO29CTDNunR6zFwX7r7f7iZPxEEUhxLy8dVMdHsv2t8o8Z/qUd8ao/rQ/RIcH0CrG40U6zRBoFdJ5TF3bBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN3RLaGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556D6C4CEC7;
	Tue, 15 Oct 2024 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729025938;
	bh=eldE9A77XPppw7dIFi4hvn84XWAs9Hpi5aCEiES7OhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EN3RLaGFxAnYU1k4ESJFMyO2pvuRBGG4Qr0VJafZRQJKS8ueEvBfjwFPv4C8KR3M5
	 JQzI3JrfsMNKXCoAtujbpKHp25HQaNV+zHzuhd0Bnf+Ofq5E+lv/4owPC1EtDwVU7l
	 W8sEiB9pt/HCXPNMDqK14mx0iRVHkYW4hoixBFUHePH0fHzmfzy+9eyNLJFBwmIeV9
	 2QYHC7zrLWKaqKAgW3iuXbvkfHEoAXtX1r+QEjhyF4remjPrcbJN03wEQrM2SzWxde
	 chW1sguAH9eqcxaoniqcnBnFVUK4goFTfYH32IIf7D+siKpVjmlDVXAHoMyfch/dmD
	 1gf5F7ksU/Q/Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	stable@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] tpm: Implement tpm2_load_null() rollback
Date: Tue, 15 Oct 2024 23:58:37 +0300
Message-ID: <20241015205842.117300-3-jarkko@kernel.org>
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

tpm2_load_null() has weak and broken error handling:

- The return value of tpm2_create_primary() is ignored.
- Leaks TPM return codes from tpm2_load_context() to the caller.
- If the key name comparison succeeds returns previous error
  instead of zero to the caller.

Implement a proper error rollback.

Cc: stable@vger.kernel.org # v6.10+
Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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
 drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 253639767c1e..1215c53f0ae7 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -915,33 +915,36 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 
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
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
+	if (rc)
+		goto err;
+
+	/* Return the null key if the name has not been changed: */
+	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0) {
+		*null_key = tmp_null_key;
+		return 0;
+	}
+
+	/* Deduce from the name change TPM interference: */
+	dev_err(&chip->dev, "the null key integrity check failedh\n");
+	tpm2_flush_context(chip, tmp_null_key);
 	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
-	return rc;
+err:
+	return rc ? -ENODEV : 0;
 }
 
 /**
-- 
2.47.0


