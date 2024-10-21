Return-Path: <linux-integrity+bounces-3887-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF19A59C8
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 07:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966BF1F22003
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 05:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9DF1CF7B7;
	Mon, 21 Oct 2024 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV++9lG2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE741CF7B1;
	Mon, 21 Oct 2024 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489195; cv=none; b=jQPjkfdjb+SkXkNWgFuQYWzZl+6r32bIUuz6UoDPgw3p6RPYHDC0OEGUtHp/xvk4sSCriUtKxKdi0A24zb2JxV3Uh1g2YckwPcXEUBrNhWk0OTUNVzJCZkploPyXdOTJ00xb8Kv57svjhjPbLDwoDpo8iQU+6XqZcTN4YfTncBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489195; c=relaxed/simple;
	bh=EKbaumhrez1Xq9qGRGrCO5GSCxZW2UvHqIoq1v904RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ0gb/OZi0AJfn05t8rM7ZrMqyzdhvsLNWKHhjyXE0Joc1nolsGHwhIoZRv+LHr+zbcAK+V6kGjmWec4MjO/BJgojHODz1OSIGqseFrd2l2afz8PLbZy7/lEp2fsNq2AnWwKHd4nfml20/HoAl9bIbR+FTMFvNRp7bhQyEnrqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV++9lG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3470CC4CEC3;
	Mon, 21 Oct 2024 05:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729489195;
	bh=EKbaumhrez1Xq9qGRGrCO5GSCxZW2UvHqIoq1v904RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MV++9lG2tpZXVhTx+hx83+MRldld4SqTTvJ480HZ+28/awqvvh3LIV7oEA7i2DeiY
	 g6b0ynx2otMSxNuzNvSLcqSU6ZtRit1kZM3QOcJFEASOdsZFj1N5T8qENfJu6Lc7Al
	 TLMNDrhQFJKJZowpSXLxQAOYai2ulpzh0D16ZcT7CQQq5mQbqDcxIprBVuraznXO0n
	 q7rdJh+9Wv2b+QAbOyGlSTuk9NTEWNRgk1JSzTer831U/b/8FiL+ftumHd3MXZ13d4
	 h/EX091bYWGqJJt0YR5c/nmCVOpza0tcDjexGPS9JbUTpHLqSGNSSydgDK0ZjfTNiG
	 9E3EfrXP58a1w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Pengyu Ma <mapengyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 5/5] tpm: flush the auth session only when /dev/tpm0 is open
Date: Mon, 21 Oct 2024 08:39:19 +0300
Message-ID: <20241021053921.33274-6-jarkko@kernel.org>
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

Instead of flushing and reloading the auth session for every single
transaction, keep the session open unless /dev/tpm0 is used. In practice
this means applying TPM2_SA_CONTINUE_SESSION to the session attributes.
Flush the session always when /dev/tpm0 is written.

Reported-by: Pengyu Ma <mapengyu@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219229
Cc: stable@vger.kernel.org # v6.10+
Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_session*()")
Tested-by: Pengyu Ma <mapengyu@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5:
- No changes.
v4:
- Changed as bug.
v3:
- Refined the commit message.
- Removed the conditional for applying TPM2_SA_CONTINUE_SESSION only when
  /dev/tpm0 is open. It is not required as the auth session is flushed,
  not saved.
v2:
- A new patch.
---
 drivers/char/tpm/tpm-chip.c       | 1 +
 drivers/char/tpm/tpm-dev-common.c | 1 +
 drivers/char/tpm/tpm-interface.c  | 1 +
 drivers/char/tpm/tpm2-sessions.c  | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0ea00e32f575..7a6bb30d1f32 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -680,6 +680,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 	rc = tpm_try_get_ops(chip);
 	if (!rc) {
 		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+			tpm2_end_auth_session(chip);
 			tpm2_flush_context(chip, chip->null_key);
 			chip->null_key = 0;
 		}
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 4eaa8e05c291..a3ed7a99a394 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -29,6 +29,7 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		tpm2_end_auth_session(chip);
 		tpm2_flush_context(chip, chip->null_key);
 		chip->null_key = 0;
 	}
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index bfa47d48b0f2..2363018fa8fb 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -381,6 +381,7 @@ int tpm_pm_suspend(struct device *dev)
 	if (!rc) {
 		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 #ifdef CONFIG_TCG_TPM2_HMAC
+			tpm2_end_auth_session(chip);
 			tpm2_flush_context(chip, chip->null_key);
 			chip->null_key = 0;
 #endif
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 6e52785de9fd..a7079c7ec6d1 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -333,6 +333,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 #ifdef CONFIG_TCG_TPM2_HMAC
+	/* The first write to /dev/tpm{rm0} will flush the session. */
+	attributes |= TPM2_SA_CONTINUE_SESSION;
+
 	/*
 	 * The Architecture Guide requires us to strip trailing zeros
 	 * before computing the HMAC
-- 
2.47.0


