Return-Path: <linux-integrity+bounces-3919-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5A9B24A3
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 06:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E245B1F2161D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 05:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9618D649;
	Mon, 28 Oct 2024 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoPDTCaA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260E18D643;
	Mon, 28 Oct 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094637; cv=none; b=ETo5za/exDLRg2RPNYIDZsJf/DDNxHfWpAEDJvK97kZ0Q+aaUqJu5hqAcRQ7I5Je1mK1m6yWwmqnI9s/THCEtrFIkffQZsI2fVpPakSnyICFQwDaZJWNLnlrM8/M4Etml21A4jgRRslwH+mqEF6xi+vNJnZcFsaNSsmuMGXM6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094637; c=relaxed/simple;
	bh=fRewTVB7pv+APGXOeNKhX+6/qgzbhVlGGPP5SuLFXA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeyIigRkMj9vrHt9PPAppHqQz3tnGrl+qRO1KUD6Wt1+zKmW++yFJrXtA96Y4fgseCW91x9J2Yi/xmwFogu0CV0TsmlWCrGb1WIHe8gnoepqCjB2DMBbLUT1VfE3TZT8Eei1fC+ccPIfaQZjRRma2kRBliYE5IRkyqeMHGwLvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoPDTCaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26600C4CEC3;
	Mon, 28 Oct 2024 05:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730094636;
	bh=fRewTVB7pv+APGXOeNKhX+6/qgzbhVlGGPP5SuLFXA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UoPDTCaAapuARW1mojaR4w0c7iAnZj+/m7Dnjw60oVkv1tZXbgT99P1MJk3XJlf+j
	 g9X9W63F6xpkfgKVphutzepxQZMCApZjTicWPCZvz6SsAbQQGyJZCceMwgA5ZI7+8k
	 g8n+u54x+lL5K0/WkCdNcXs1fl5A38Mzqe6gXuMkSjBTcDIRNe6FLgry/7l1Yh2xEG
	 jo1F6n/Es31hyyEKPWn1QMU9FHICtmSg+QT+rmNAEkZjHFXR2xzmQGWZJpyto+hIoI
	 9Cs4CgnxleRdPO9935qNNKMiBM8Td+qAYlmGLGwWfdsO+z+pfM5Ipwx5s0Dth56r8m
	 swtPv1v4Iyrsg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	Pengyu Ma <mapengyu@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 3/3] tpm: Lazily flush the auth session
Date: Mon, 28 Oct 2024 07:50:01 +0200
Message-ID: <20241028055007.1708971-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028055007.1708971-1-jarkko@kernel.org>
References: <20241028055007.1708971-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the allocation of chip->auth to tpm2_start_auth_session() so that this
field can be used as flag to tell whether auth session is active or not.

Instead of flushing and reloading the auth session for every transaction
separately, keep the session open unless /dev/tpm0 is used.

Reported-by: Pengyu Ma <mapengyu@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219229
Cc: stable@vger.kernel.org # v6.10+
Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_session*()")
Tested-by: Pengyu Ma <mapengyu@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v8:
- Since auth session and null key are flushed at a same time, only
  either needs to be checked. Addresses and a remark from James
  Bottomley few revisions ago.
- kfree_sensitive()
- Effectively squash top three patches given the simplifications.
v7:
- No changes.
v6:
- No changes.
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
 drivers/char/tpm/tpm-chip.c       | 10 +++++++
 drivers/char/tpm/tpm-dev-common.c |  3 +++
 drivers/char/tpm/tpm-interface.c  |  6 +++--
 drivers/char/tpm/tpm2-sessions.c  | 45 ++++++++++++++++++-------------
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 854546000c92..1ff99a7091bb 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -674,6 +674,16 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
  */
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
+#ifdef CONFIG_TCG_TPM2_HMAC
+	int rc;
+
+	rc = tpm_try_get_ops(chip);
+	if (!rc) {
+		tpm2_end_auth_session(chip);
+		tpm_put_ops(chip);
+	}
+#endif
+
 	tpm_del_legacy_sysfs(chip);
 	if (tpm_is_hwrng_enabled(chip))
 		hwrng_unregister(&chip->hwrng);
diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 30b4c288c1bb..c7a88fa7b0fc 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -27,6 +27,9 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	struct tpm_header *header = (void *)buf;
 	ssize_t ret, len;
 
+	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		tpm2_end_auth_session(chip);
+
 	ret = tpm2_prepare_space(chip, space, buf, bufsiz);
 	/* If the command is not implemented by the TPM, synthesize a
 	 * response with a TPM2_RC_COMMAND_CODE return for user-space.
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 5da134f12c9a..8134f002b121 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -379,10 +379,12 @@ int tpm_pm_suspend(struct device *dev)
 
 	rc = tpm_try_get_ops(chip);
 	if (!rc) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
+		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+			tpm2_end_auth_session(chip);
 			tpm2_shutdown(chip, TPM2_SU_STATE);
-		else
+		} else {
 			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+		}
 
 		tpm_put_ops(chip);
 	}
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 950a3e48293b..03145a465b5d 100644
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
@@ -484,7 +487,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
 	sha256_final(&sctx, out);
 }
 
-static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
+static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+				struct tpm2_auth *auth)
 {
 	struct crypto_kpp *kpp;
 	struct kpp_request *req;
@@ -543,7 +547,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
 	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
 	kpp_request_set_input(req, s, EC_PT_SZ*2);
-	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
+	sg_init_one(d, auth->salt, EC_PT_SZ);
 	kpp_request_set_output(req, d, EC_PT_SZ);
 	crypto_kpp_compute_shared_secret(req);
 	kpp_request_free(req);
@@ -554,8 +558,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	 * This works because KDFe fully consumes the secret before it
 	 * writes the salt
 	 */
-	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
-		  chip->auth->salt);
+	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
 
  out:
 	crypto_free_kpp(kpp);
@@ -853,7 +856,9 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 		if (rc)
 			/* manually close the session if it wasn't consumed */
 			tpm2_flush_context(chip, auth->handle);
-		memzero_explicit(auth, sizeof(*auth));
+
+		kfree_sensitive(auth);
+		chip->auth = NULL;
 	} else {
 		/* reset for next use  */
 		auth->session = TPM_HEADER_SIZE;
@@ -881,7 +886,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
 		return;
 
 	tpm2_flush_context(chip, auth->handle);
-	memzero_explicit(auth, sizeof(*auth));
+	kfree_sensitive(auth);
+	chip->auth = NULL;
 }
 EXPORT_SYMBOL(tpm2_end_auth_session);
 
@@ -962,16 +968,20 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
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
 		goto out;
@@ -992,7 +1002,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
 
 	/* append encrypted salt and squirrel away unencrypted in auth */
-	tpm_buf_append_salt(&buf, chip);
+	tpm_buf_append_salt(&buf, chip, auth);
 	/* session type (HMAC, audit or policy) */
 	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
 
@@ -1014,10 +1024,13 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
 	tpm_buf_destroy(&buf);
 
-	if (rc)
-		goto out;
+	if (rc == TPM2_RC_SUCCESS) {
+		chip->auth = auth;
+		return 0;
+	}
 
- out:
+out:
+	kfree_sensitive(auth);
 	return rc;
 }
 EXPORT_SYMBOL(tpm2_start_auth_session);
@@ -1367,10 +1380,6 @@ int tpm2_sessions_init(struct tpm_chip *chip)
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


