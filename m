Return-Path: <linux-integrity+bounces-3618-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE0297A003
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 13:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2736628330C
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670FB15748F;
	Mon, 16 Sep 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY0jUZP5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992714E2DA;
	Mon, 16 Sep 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484868; cv=none; b=hc2F81Pc0xW8UXNpyawjJzPxGC6b8fG4TatzCC8aF5/OT8WOCByOFcJSXemIvvhP6gZop3HDzp+lvdWYA+rLUh/x6LZHhrvMYB9Yi2INmK1udi63LAhqrg6ACMfB5TMqOWj2ycUxGRw5GtNicGkKnw65bt6prFeptEdDE8N5pZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484868; c=relaxed/simple;
	bh=xD2s5On1ZCWWzafhSszKhanrFM8TIDWSq6PdNHlzYy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nANs7SNLPQr/lvGKp2aRioyHycv1Qaw3ozC4Ycen5TpIBO7VPZVQ6gqJ8IlGzph+uKbjRyK3DJcTZaT9O0mlnJfTMqopEB47ZYPiCtFxjldh25ACiS6jtI1VpKxtxQm5LO8QCNa0DVK2wGNoH6esmjCYrwWZtfzX8avTC9OrCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY0jUZP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7251C4CEC4;
	Mon, 16 Sep 2024 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484868;
	bh=xD2s5On1ZCWWzafhSszKhanrFM8TIDWSq6PdNHlzYy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AY0jUZP5uKNbnY5Z8u9a6VGpH+29Fu+8WquuEtw3+rXhKUC7QWKx2b4USwVrhInDH
	 m/EbDH33kcy2drqRApYKAZTe7ccQGnXeWmMAsmYA2sMJ4D6o7Wtqb2/Tum+9+s58iF
	 fhixB1bh2UNfyZ4TaE0F4FJFDBVrWqBkssb0W9jyuMxAskhzveCqLsBT/+tW4qx11E
	 ZoU8MpjO0zqw7/66DE7H0fvQxemxbwsMzbjiYVXvx3OhMc4STH8fkZme24iBdzH7n1
	 gQRI4Co0YUDx9z26/Ny/DsuJ1RCDoKrcRQ6s5gQUw9667/G+r5r6YxFFR9zeXC6DfC
	 uLzUK1ql7nIlQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 6/6] tpm: flush the auth session only when /dev/tpm0 is open
Date: Mon, 16 Sep 2024 14:07:11 +0300
Message-ID: <20240916110714.1396407-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916110714.1396407-1-jarkko@kernel.org>
References: <20240916110714.1396407-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of flushing and reloading the auth session for every single
transaction, keep the session open unless /dev/tpm0 is open. In practice
this means applying TPM2_SA_CONTINUE_SESSION to the session attributes.
Flush the session always when /dev/tpm0 is written.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c       | 1 +
 drivers/char/tpm/tpm-dev-common.c | 1 +
 drivers/char/tpm/tpm-interface.c  | 1 +
 drivers/char/tpm/tpm2-sessions.c  | 4 ++++
 4 files changed, 7 insertions(+)

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
index f7746a165695..efe4b0017a83 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -268,6 +268,10 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 #ifdef CONFIG_TCG_TPM2_HMAC
+	/* The first write to /dev/tpm{rm0} will flush the session. */
+	if (!chip->is_open)
+		attributes |= TPM2_SA_CONTINUE_SESSION;
+
 	/*
 	 * The Architecture Guide requires us to strip trailing zeros
 	 * before computing the HMAC
-- 
2.46.0


