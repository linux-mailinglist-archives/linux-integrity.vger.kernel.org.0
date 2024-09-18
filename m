Return-Path: <linux-integrity+bounces-3637-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72397C0E2
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037BA1F2272D
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175D1CB32D;
	Wed, 18 Sep 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSunCmaX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45471CB32C;
	Wed, 18 Sep 2024 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691795; cv=none; b=Ze3UrMDRzG6GgtWRm63HeDU4XVGN2ZjU2w/0kOoFIu57f9if1QG2TprK0ovBFzTE8Ua44VEsVnvWw3LShW42IuSGPZjzJRD2CT0tzjD1b7a3eAB8uMNk4buH85ErCP3UBbeZjWUdQ3OpeZFhElFDWVdh45sFtWIC7Br/zZ0MAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691795; c=relaxed/simple;
	bh=a6hjHtAXEMh6b1R8nEW38A6SmJBF8Y73m7GYMb7SEdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRTjRxsXW8LBm40kGRzjxCb6wqNsQSzJ9ryek7u5M4fslZBZvosKfAZ/Mne4TjZlMEHaAPFjlaOnCLTPTTU0Stjxhv1oGlx4D5ac0jjoOZ8nrk9OIonBhy/vtCULEjkfVfUhkwugOQ4+HaHIe5++PLErhHcVHgC+swT/xtQkYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSunCmaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551BCC4CEC2;
	Wed, 18 Sep 2024 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726691794;
	bh=a6hjHtAXEMh6b1R8nEW38A6SmJBF8Y73m7GYMb7SEdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSunCmaXzik1WBkT7BnosXXdNSAG8dSg8J4fYJe/OPFdvCXWxbin/ZDf+jrmVed4u
	 KhEMVsVrGbGOMp81NLGk0jLKiny68b7GiUjjK44HSVvSnZf/fbG5Q/uJ9PJ1w0O8RG
	 z3vdhksIxLMNBzyKPqdGl9nR81EzlUDqRQW1Bgr9iVpzbwMe0fVeSeSFQU/3VyHGqf
	 zCFektkS76ZAnhVytu0kHX8DAa84IZDs2gko/ZXjqDXtpLrY3WZsqtvKR8KlvOG7OM
	 YW4buY5ncuMwhj0wfwGUboWr/NFIWJuJASDS86xl0BlNmTJLOSyueH9Y/HeET6sr18
	 Q1a2YvJ7KD8+g==
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
Subject: [PATCH v4 5/5] tpm: flush the auth session only when /dev/tpm0 is open
Date: Wed, 18 Sep 2024 23:35:49 +0300
Message-ID: <20240918203559.192605-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918203559.192605-1-jarkko@kernel.org>
References: <20240918203559.192605-1-jarkko@kernel.org>
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
index 6371e0ee88b0..e9d3a6a9d397 100644
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
2.46.0


