Return-Path: <linux-integrity+bounces-3886-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F24709A59C5
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 07:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C6B23501
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076031CF5F6;
	Mon, 21 Oct 2024 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOy04R3F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567E1D0B9C;
	Mon, 21 Oct 2024 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489190; cv=none; b=erw2apU8YDlFbVbud3alKOkleU6uoA6NF1CDGsN/74dR4L4eOSyjiow/3zscrngcKQFqrepEmzzY+xtKoNVi5r9KdFrRBlx6vPWSw6TjWQmc504IPdY0n7cKOiF3eSucScD4gnOKqLLEUXP4LurAhCbe6vh+AsVTdi3qVeCoVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489190; c=relaxed/simple;
	bh=zVwJDklgIRkad8lPk/v3KTWUu6spY32sDV7tSQf3Ico=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZXCu803Z+tmc1z4hzYkubWMDjGayO5u6qvq/kbo95V7ObFYQNLFe9C5SKSocSquo9Cw0JOe88z1xk723J4EnE0NoQtIVbI+VGPyiPptk2Vxs3bAsb2D0b1ESn8dReH9gOTFJibmiYUGMv4zHLMuiINLZKFOu7BaBHe2A5lC8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOy04R3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A767FC4CEC3;
	Mon, 21 Oct 2024 05:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729489190;
	bh=zVwJDklgIRkad8lPk/v3KTWUu6spY32sDV7tSQf3Ico=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOy04R3FlDlMdpsVknAi10CZtsPDha+rXagHZ5QT96NSjfSzCyZmBbfp46FM92H0o
	 JEIFNYsirVP51YGm1hwAQFFqCBf0YSnx4rYQZ/LJNpmBOaRVEffZ4sivB7H4oAC5jl
	 U8jB2av5ENXCfYhh4VCW7/1CdvSMqY6K+EDA26atflD1TiJbYa8lsOnWMMS5d3dKiF
	 8PrVT6cI4r9/MLvytPAIpf7hQS6pvmsrKAkSAIRxI1CESPflsBCTorm1xVcStl63Ok
	 6QD0kIbtCmWM0TBMk5XP7I0LL+2WBYaRIcK+H0HZvGeoMp7N9skjRS7Jo2+GiAFNbu
	 ovrSbubpiStPQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 4/5] tpm: Allocate chip->auth in tpm2_start_auth_session()
Date: Mon, 21 Oct 2024 08:39:18 +0300
Message-ID: <20241021053921.33274-5-jarkko@kernel.org>
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

Move allocation of chip->auth to tpm2_start_auth_session() so that the
field can be used as flag to tell whether auth session is active or not.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5:
- No changes.
v4:
- Change to bug.
v3:
- No changes.
v2:
- A new patch.
---
 drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 78c650ce4c9f..6e52785de9fd 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -484,7 +484,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
 	sha256_final(&sctx, out);
 }
 
-static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
+static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+				struct tpm2_auth *auth)
 {
 	struct crypto_kpp *kpp;
 	struct kpp_request *req;
@@ -543,7 +544,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
 	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
 	kpp_request_set_input(req, s, EC_PT_SZ*2);
-	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
+	sg_init_one(d, auth->salt, EC_PT_SZ);
 	kpp_request_set_output(req, d, EC_PT_SZ);
 	crypto_kpp_compute_shared_secret(req);
 	kpp_request_free(req);
@@ -554,8 +555,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	 * This works because KDFe fully consumes the secret before it
 	 * writes the salt
 	 */
-	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
-		  chip->auth->salt);
+	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
 
  out:
 	crypto_free_kpp(kpp);
@@ -854,6 +854,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 			/* manually close the session if it wasn't consumed */
 			tpm2_flush_context(chip, auth->handle);
 		memzero_explicit(auth, sizeof(*auth));
+		kfree(auth);
+		chip->auth = NULL;
 	} else {
 		/* reset for next use  */
 		auth->session = TPM_HEADER_SIZE;
@@ -882,6 +884,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
 
 	tpm2_flush_context(chip, auth->handle);
 	memzero_explicit(auth, sizeof(*auth));
+	kfree(auth);
+	chip->auth = NULL;
 }
 EXPORT_SYMBOL(tpm2_end_auth_session);
 
@@ -970,25 +974,29 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
  */
 int tpm2_start_auth_session(struct tpm_chip *chip)
 {
+	struct tpm2_auth *auth;
 	struct tpm_buf buf;
-	struct tpm2_auth *auth = chip->auth;
-	int rc;
 	u32 null_key;
+	int rc;
 
-	if (!auth) {
-		dev_warn_once(&chip->dev, "auth session is not active\n");
+	if (chip->auth) {
+		dev_warn_once(&chip->dev, "auth session is active\n");
 		return 0;
 	}
 
+	auth = kzalloc(sizeof(*auth), GFP_KERNEL);
+	if (!auth)
+		return -ENOMEM;
+
 	rc = tpm2_load_null(chip, &null_key);
 	if (rc)
-		goto out;
+		goto err;
 
 	auth->session = TPM_HEADER_SIZE;
 
 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
 	if (rc)
-		goto out;
+		goto err;
 
 	/* salt key handle */
 	tpm_buf_append_u32(&buf, null_key);
@@ -1000,7 +1008,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
 
 	/* append encrypted salt and squirrel away unencrypted in auth */
-	tpm_buf_append_salt(&buf, chip);
+	tpm_buf_append_salt(&buf, chip, auth);
 	/* session type (HMAC, audit or policy) */
 	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
 
@@ -1021,10 +1029,13 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
 	tpm_buf_destroy(&buf);
 
-	if (rc)
-		goto out;
+	if (rc == TPM2_RC_SUCCESS) {
+		chip->auth = auth;
+		return 0;
+	}
 
- out:
+err:
+	kfree(auth);
 	return rc;
 }
 EXPORT_SYMBOL(tpm2_start_auth_session);
@@ -1377,10 +1388,6 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 		return rc;
 	}
 
-	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
-	if (!chip->auth)
-		return -ENOMEM;
-
 	return rc;
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */
-- 
2.47.0


