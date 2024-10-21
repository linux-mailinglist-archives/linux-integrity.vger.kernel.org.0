Return-Path: <linux-integrity+bounces-3884-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB49A59BF
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 07:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715441C211A7
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 05:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ADF1CF7C3;
	Mon, 21 Oct 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plF3Rzne"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD8194AF3;
	Mon, 21 Oct 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489180; cv=none; b=OmkR7Lug7eBX0r4T663QeLfR6ODDpRvQ8Kp4rtKly2RwOjUDuT87Fy/ITZ2re3Zc7q7NN9pBZ51D0ogZSf2bdx2Zob2x6aOXN41ULWYywNDvX1SwtgYp3ZNbPrC1B2vYE0r51oUCFCJcjP9fEH6Vorb8La/mUnHxVtLYs+qBd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489180; c=relaxed/simple;
	bh=D0m4paxP6P0gzIZy7P2Jr7htyTZRIO+jDExebpPsZQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI2XRKmuIZ9uQDS5DnNY+jdwcmqTTK7lcPxpCtC3Uc4ftM3vZZs9/8/VMo2NzBXisYwXbIKF1CZouZuXp5C+mAonFqQaiJS7NyXLXYgrMCw5vqZnF4aXRbBAD0TVQtrD7LDRhRICR1DmB6CinuN10Iv2XW63zGPtmeUqZQgKRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plF3Rzne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB4DC4CEC3;
	Mon, 21 Oct 2024 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729489179;
	bh=D0m4paxP6P0gzIZy7P2Jr7htyTZRIO+jDExebpPsZQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plF3RznebuLsmKn3P4aGm240QSdRrTVuIS0UgAMa/HJoG1/bdnZKuhXyXTR7kAAv2
	 FXMoworq4UGjARs+SBbjUSuhjqYM/DEYRtY6wfBDNV5jiKkqLL4GA753+VMBUwnjR3
	 Qu36XzfR1terhsaMf6ntNwMbYrrTQc9OTunYFFpb/nojFKbLJCbmYj7dfEt1rPsou1
	 53BGOeF8qDCqk9nudBwP2FNMBHPXp8nglYlTUDJnAcDPPj9x4Q/n+AO79K+V/bYqlC
	 OL6YL9Bi3pSFTSgNkqySulTBZQlXL5YhpNsbCpdKIiAltNuIAJ3jdE5rmjhKK+B9OV
	 2U+r9yhmZJTHA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 2/5] tpm: Implement tpm2_load_null() rollback
Date: Mon, 21 Oct 2024 08:39:16 +0300
Message-ID: <20241021053921.33274-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021053921.33274-1-jarkko@kernel.org>
References: <20241021053921.33274-1-jarkko@kernel.org>
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
--
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
index 1e12e0b2492e..bdac11964b55 100644
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


