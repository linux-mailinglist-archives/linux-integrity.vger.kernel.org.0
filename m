Return-Path: <linux-integrity+bounces-2957-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FDD91E636
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 19:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AE41F24314
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AAC16E860;
	Mon,  1 Jul 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGmal9au"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2816D31E;
	Mon,  1 Jul 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853667; cv=none; b=U4fpBX0yCCTX4wDTcYZYB76R+65vBl6DCuPQbF/unae5619lILcQEaMNd1DGkao6TJ1mtoew3cd2tBzhtNlgVaz5f4ZdvU5ubI/1ZbQqt7DVoLY2jUskx0hu3Pu1ygDd8rE9nvDwAk+AfA9Sz57WeDufMYjgOtZl2JxcA7jO/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853667; c=relaxed/simple;
	bh=n9Bt8sgeFilFYG9RUvitPHdBPbjhTJvSbKPS9z9tPgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zel9nwysVW/YH+VPJwNqpBkWJTdf0vqWEVCCXsStoD1WNQB9yuE8V+75pYMNgKUd9kwlujub10CdVxxI4TC4VsRYVIzMphrwCKBbYROAaZYEmJ5fKpUaYWaaNodd9mozV97xuht1o7R63Roxfpm6M+tFJ8ScW/4+fpEJ3tqWxgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGmal9au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7631FC32781;
	Mon,  1 Jul 2024 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719853666;
	bh=n9Bt8sgeFilFYG9RUvitPHdBPbjhTJvSbKPS9z9tPgY=;
	h=From:To:Cc:Subject:Date:From;
	b=BGmal9auIq47e0v8F4t46Yxb0nOXiVNDLeC0GOBfJ88rMiHZL2k/oCaVMHk4/DlxY
	 S8teHkxszwP8ycBPweWITsJENRhZHWPpdqK1aav9dHwbj591cJmMVF3xM7rE5vdRhB
	 g4vPZfK0daYKtIpYswNfmPjOAH8QxkvTnd7jhgkNeqkCX9bPgmguRfdhYJvltQBB2q
	 1Hbp10fkNegIpMOk92HY0cA1Vc0/8A9vL2OgDx4H8/hLXcOIvYFyEFwn24U5Te3UOt
	 xPDoGbn+2lZcOLF1XET1yDeGMjsuL10Y/a71pOmUCCnSSIzcYMkXQ3E7MhQh8y1sA7
	 1MEdovbjJ4VLQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] tpm: Check non-nullity of chip->auth
Date: Mon,  1 Jul 2024 17:07:34 +0000
Message-ID: <20240701170735.109583-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All exported functions lack the check for non-nullity of chip->auth. Add
the guard for each.

Link: https://lore.kernel.org/linux-integrity/9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org/
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 907ac9956a78..d833db20531a 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -377,6 +377,9 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 	u32 len;
 	struct tpm2_auth *auth = chip->auth;
 
+	if (!auth)
+		return;
+
 	/*
 	 * The Architecture Guide requires us to strip trailing zeros
 	 * before computing the HMAC
@@ -449,6 +452,9 @@ void tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	u8 cphash[SHA256_DIGEST_SIZE];
 	struct sha256_state sctx;
 
+	if (!auth)
+		return;
+
 	/* save the command code in BE format */
 	auth->ordinal = head->ordinal;
 
@@ -639,6 +645,9 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	struct tpm2_auth *auth = chip->auth;
 	int slot;
 
+	if (!auth)
+		return;
+
 	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
 	if (slot >= AUTH_MAX_NAMES) {
 		dev_err(&chip->dev, "TPM: too many handles\n");
@@ -705,6 +714,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	u32 cc = be32_to_cpu(auth->ordinal);
 	int parm_len, len, i, handles;
 
+	if (!auth)
+		return rc;
+
 	if (auth->session >= TPM_HEADER_SIZE) {
 		WARN(1, "tpm session not filled correctly\n");
 		goto out;
@@ -824,8 +836,13 @@ EXPORT_SYMBOL(tpm_buf_check_hmac_response);
  */
 void tpm2_end_auth_session(struct tpm_chip *chip)
 {
-	tpm2_flush_context(chip, chip->auth->handle);
-	memzero_explicit(chip->auth, sizeof(*chip->auth));
+	struct tpm2_auth *auth = chip->auth;
+
+	if (!auth)
+		return;
+
+	tpm2_flush_context(chip, auth->handle);
+	memzero_explicit(auth, sizeof(*auth));
 }
 EXPORT_SYMBOL(tpm2_end_auth_session);
 
@@ -907,6 +924,11 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 	u32 null_key;
 
+	if (!auth) {
+		pr_warn_once("%s: encryption is not active\n", __func__);
+		return 0;
+	}
+
 	rc = tpm2_load_null(chip, &null_key);
 	if (rc)
 		goto out;
-- 
2.45.2


