Return-Path: <linux-integrity+bounces-3626-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE3697B25B
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C193287AC1
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Sep 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6E1946C7;
	Tue, 17 Sep 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrJh4aC1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B4188A37;
	Tue, 17 Sep 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587919; cv=none; b=P0cdgy9nd3U4unjln69ubJKj8yBlchNs5rV2an7z3DjpFKWCqiFu62LFwDTzmmvCDHPYcKb1f9/4PA6P4R5deozYIwcXtsU5ZI0txT29J2+a0wgcF/NPg8spUS5kBcKectzriVUbpjJMJ1hGNJcks+fOHPZ2dVP7XXJhyww/MWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587919; c=relaxed/simple;
	bh=ierCK7VWxvo8wK6md4TR1uHJ+m5L2VbdufMWxne1uCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGtrpvzGG2sOzQxOOZNS0/yzm/BpaoN1uUG7QNTA3QCUos+8R9zBvAa3kBE7nwtnvOQMjhQiuiixTKHZxuI7Uke7f0b46TFJSltcrZxjOTL7BwS1lrvNkuH+rpNHI6SXBlE5PLVCVrc196kbPyHPPDq/f3+yj5gtRU3Dcmf5OCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrJh4aC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80299C4CEC5;
	Tue, 17 Sep 2024 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726587919;
	bh=ierCK7VWxvo8wK6md4TR1uHJ+m5L2VbdufMWxne1uCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrJh4aC16spska4hn1hVdh+hmAbymnIz/1CZozeUYlaPJhL2+N+MrD4vTVvHMLtXh
	 uYjE4X2rMq1stohIGUCCxOr0LzKNKaBcxBNil/cocBKfZIqt3wPhUn30/GC60cXC0L
	 0LiZg2KMWtsNrxYp3LbI36F+Z4DYXz89V53ioc+P3xm+/+busembyoWql9rIKz66fa
	 09CKz24YCPivPJ8iLTLnaCxgvXzGRJMdxSd7X39FiYLBt303Jem+aI2/YuLbKcoUld
	 35QX4/k2A5OK2zXCrxALvYa6oHkaXAdYvK1Gh6RGsW9vtgCWsYyw0viU18u3YzDtcm
	 GqcNQWwcOzWAw==
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
Subject: [PATCH v3 6/7] tpm: flush the auth session only when /dev/tpm0 is open
Date: Tue, 17 Sep 2024 18:44:35 +0300
Message-ID: <20240917154444.702370-7-jarkko@kernel.org>
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

Instead of flushing and reloading the auth session for every single
transaction, keep the session open unless /dev/tpm0 is used. In practice
this means applying TPM2_SA_CONTINUE_SESSION to the session attributes.
Flush the session always when /dev/tpm0 is written.

This reduces the number of TPM2_ContextLoad and TPM2_FlushContext
commands

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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
index 4bc07963e260..c6fdeb4feaef 100644
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
index 43b8e3576232..d240039d0849 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -268,6 +268,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
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


