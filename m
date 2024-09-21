Return-Path: <linux-integrity+bounces-3648-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3268197DD15
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 14:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6335C1C20DC4
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993816F271;
	Sat, 21 Sep 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fobVuybM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29E16F0CF;
	Sat, 21 Sep 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726920507; cv=none; b=fwYvdz2cIbHzuaeaFiL4KMeM3qrER5M6aVQX11b12XKN6cbgJc7hdD+4EDHSlxjDasQNfhUgBrrTdZ3jntJY9+ZN1u4auyO1I5IPBfvd/f1rwAwwPFITuJNDb6CNd00cm+h+kcgvnRdrmylRvq8aoAfnKEIvtx8KZiI5C9b4HV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726920507; c=relaxed/simple;
	bh=P2zhXgB97Gxeg1yK0YAqaMJDy5+vnJ15TAuh79GHT0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwlKo9E+orS5XjofNSOJAruJs9WY3iQFeNjwfSQL4s0pJy3/jI2JRm0dNGGFrocwNJiA6eVDgtMmOgBxL3H5h/HkwiZNUmwFbEt4x+7yLbfLwfL5N9+HSpbb/F9jIUSIlCncIX7AB+KUxOTFk7w/Sxn5KA7v2xsoIEV5KSBThmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fobVuybM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247BFC4CEC2;
	Sat, 21 Sep 2024 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726920506;
	bh=P2zhXgB97Gxeg1yK0YAqaMJDy5+vnJ15TAuh79GHT0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fobVuybM1pslwg1Oap86V0LW1hIOdpy0cEPAOWTu84qTD3izKV8tYechEYI6Y/Etp
	 N1bdIFcR6dS3J67VAGeZSVmra21+Jd3Juhc35Rv/uvVW4kIchWRsHjYRbfmZnVBNBx
	 pjrE7F0jy++BEsDoaiaDxwk1XsGeUwx/MeYJlkraFc00DvDKW27R972lYcUo64AzJQ
	 vM5Qxxk7Tmw+WN9PyVplpW/acQQ/gcjk/tJqftA1Ija5AQKW2iWkGw8vSihCnkSZTj
	 /QtpeU2D72LZg1U9xrkTYAyEPjiXzSAKmSeGjv39j5zd+/7tmFgVUAniOuDERml5yz
	 Qcgmx/akzHy3A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] tpm: Implement tpm2_load_null() rollback
Date: Sat, 21 Sep 2024 15:08:02 +0300
Message-ID: <20240921120811.1264985-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240921120811.1264985-1-jarkko@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
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
index 0f09ac33ae99..a856adef18d3 100644
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
+	return rc ? -ENODEV : rc;
 }
 
 /**
-- 
2.46.1


