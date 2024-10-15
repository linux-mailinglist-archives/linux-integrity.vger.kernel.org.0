Return-Path: <linux-integrity+bounces-3820-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABFD99F86D
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D7A1F21369
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2024 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B21FBF4D;
	Tue, 15 Oct 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXRVOvr0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569B1FBF49;
	Tue, 15 Oct 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729025954; cv=none; b=VDQF1ZlT1hHLCSNJu8Q58O1iB5bV4AOen1n96cgUo98OgNMn54XE0jODUejzw7OOg0A84bhmBUijtJj620ecrtX0vNfk8+YKDDKYKuXnSUCToTvh2ds/x+8unpVAIwdpSIdfgkLNdsDb4J6/dNN7AM49O0WJdNF5k6HA7FMUtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729025954; c=relaxed/simple;
	bh=Uhi67Z9bObKORkUfO8nLiAvjlzLJE8SomXQr8tKtJRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSDc27wjM473uaQRW5RfHXygen2xWselwe9AYtU+Nr3GyNNy6aioQVTMZTvsVf6fD8prObBx2kgx5F6uz3qjc1689dPRVeX20P2Q/jHMND59yw6MRaA1vF9AYlVclx/HKnHYSo7Wv41Ba6as8+U1u8cuvhE3V8qLze3GZyIGSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXRVOvr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7777EC4CEC6;
	Tue, 15 Oct 2024 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729025954;
	bh=Uhi67Z9bObKORkUfO8nLiAvjlzLJE8SomXQr8tKtJRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXRVOvr0cKMen2bJMSl87/dTaexDOxxYhbZxY/RTVGin9JJOyCXg46Y5A0GbmkXWH
	 TiyS5QOql0DNOLYHC8AMG+XTg64+TxJRYBRX7jyW7dajXB8X9s48+/iR5vadkBtmTE
	 RBtp0vvW8or6WAkvHyeSlAv4JsOH0Tb8xHxgW8j15mrEdrf4EW7qmflj83oVI1DvYD
	 ALRWcDb2iw5XEfeN5KJ/eCkqn0/pXZkiU2Vl7WIgLv/XEKChTkr3oRhxDbVFEJXICu
	 QYuG/oP9I0L6Eq06MCy63Ug/Wv0PniG6ALwy+1xK/Dwm/ChM8ScCPryaIjZohX1inS
	 /lsRe5zwTtMTw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Stefan Berger <stefanb@linux.ibm.com>,
	Pengyu Ma <mapengyu@gmail.com>,
	stable@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/5] tpm: flush the auth session only when /dev/tpm0 is open
Date: Tue, 15 Oct 2024 23:58:40 +0300
Message-ID: <20241015205842.117300-6-jarkko@kernel.org>
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
index 78d344607b53..844cfc338f33 100644
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


