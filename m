Return-Path: <linux-integrity+bounces-3623-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5381297B24F
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 17:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B22A1F274C4
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E95194A76;
	Tue, 17 Sep 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwNoTDzB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AC194138;
	Tue, 17 Sep 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587904; cv=none; b=UuxFrK3UyNYxNj7i7IsF9kPggK4flZoXegG405H0YhYmYwoUagmrgBVKO9mX+ePhGT60bUzyaFSt52HLr02RB7jtYJvpY9pJWlLFAxnDUaE8bmAToYJq/IKWM8p14nAr6SBMTy2Vku9XIqW/1p4DJ0QZCJaHhDlIYxjmXhX6Pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587904; c=relaxed/simple;
	bh=BMyYGqGEO26GNPeQnIBlL1dX/WGOQKX5Yh6/QOkpGHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDOXHZTpaXrzAZLezK7Va8M4dSJxWqeyWsxf9TLqi92QLAZsBY8jscExuLXL8N73wW1fTLFKnUxRS34A3o35EJ04NbBhegYTj84OlmuDvVgfLyFRm5iiC20gsOX7ZKZxh1Nng1ZMU59PO8MtBLmo28ehaTgpE7Y4qZyxoVGtIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwNoTDzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A03C4CEC5;
	Tue, 17 Sep 2024 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587903;
	bh=BMyYGqGEO26GNPeQnIBlL1dX/WGOQKX5Yh6/QOkpGHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwNoTDzBM4Lm2wuAGIqEZkyE7plkegd9QQBCKk46t+lvsAvsfyY3sK20RAeJplI6j
	 /if9C1sw2hiXQ+hYMi6R1Lg35AIc8f89kkfgl4pYksTxu1HQdPiajpvKEkidPj6ypn
	 56me0Zu7hICMSInfC2O9R/GUqy06yFj161DqgXjRzz/SQqBrVYJ52iqAZxKai/FONe
	 BjHOConj+CCP+wi7Z5obWVeJ/TXbVK6dyOjlJjSfs2IpvzlM8UnT8CQgtmw3x85ztX
	 lMTcIXHZ7XyLUC+Q0PnFKV/k7ucK99Z7V7UmIR9iG0JuA7gLb2M9d0J55qDpFyGpMr
	 jFlP712AzvqLA==
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
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] tpm: Return on tpm2_create_primary() failure in tpm2_load_null()
Date: Tue, 17 Sep 2024 18:44:32 +0300
Message-ID: <20240917154444.702370-4-jarkko@kernel.org>
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

tpm2_load_null() ignores the return value of tpm2_create_primary().
Further, it does not heal from the situation when memcmp() returns zero.

Address this by returning on failure and saving the null key if there
was no detected interference in the bus.

Cc: stable@vger.kernel.org # v6.11+
Fixes: eb24c9788cd9 ("tpm: disable the TPM if NULL name changes")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Update log messages. Previously the log message incorrectly stated
  on load failure that integrity check had been failed, even tho the
  check is done *after* the load operation.
v2:
- Refined the commit message.
- Reverted tpm2_create_primary() changes. They are not required if
  tmp_null_key is used as the parameter.
---
 drivers/char/tpm/tpm2-sessions.c | 38 +++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 0993d18ee886..03c56f0eda49 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -850,32 +850,34 @@ static int tpm2_parse_start_auth_session(struct tpm2_auth *auth,
 
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
+			       &tmp_null_key);
+	if (rc != -EINVAL) {
+		if (!rc)
+			*null_key = tmp_null_key;
 		return rc;
+	}
+	dev_info(&chip->dev, "the null key has been reset\n");
 
-	/* an integrity failure may mean the TPM has been reset */
-	dev_err(&chip->dev, "NULL key integrity failure!\n");
-	/* check the null name against what we know */
-	tpm2_create_primary(chip, TPM2_RH_NULL, NULL, name);
-	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0)
-		/* name unchanged, assume transient integrity failure */
+	rc = tpm2_create_primary(chip, TPM2_RH_NULL, &tmp_null_key, name);
+	if (rc)
 		return rc;
-	/*
-	 * Fatal TPM failure: the NULL seed has actually changed, so
-	 * the TPM must have been illegally reset.  All in-kernel TPM
-	 * operations will fail because the NULL primary can't be
-	 * loaded to salt the sessions, but disable the TPM anyway so
-	 * userspace programmes can't be compromised by it.
-	 */
-	dev_err(&chip->dev, "NULL name has changed, disabling TPM due to interference\n");
-	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
+	/* Return the null key if the name has not been changed: */
+	if (memcmp(name, chip->null_key_name, sizeof(name)) == 0) {
+		*null_key = tmp_null_key;
+		return 0;
+	}
+
+	/* Deduce from the name change TPM interference: */
+	dev_err(&chip->dev, "the null key integrity check failedh\n");
+	tpm2_flush_context(chip, tmp_null_key);
+	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 	return rc;
 }
 
-- 
2.46.0


