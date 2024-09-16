Return-Path: <linux-integrity+bounces-3617-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BBD97A000
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 13:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255DF1C20ADA
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29D6156F21;
	Mon, 16 Sep 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Xn5R34"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3A13B79F;
	Mon, 16 Sep 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484864; cv=none; b=G7aTHTkj+H14/XD1l1TrASXFmT5FFMf69PIhqt/KZ0IgHpDRzMpvf+018oZ3shbqhBJFMAdvWjYPRVtC+KR9nI1jf6ijzgHieR9ErLhQXOP4cS0EkangAOXQIXxYH44ACud4KrhGmJ066DF+NMyUULBUb5GaQ9rETqNb/trdT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484864; c=relaxed/simple;
	bh=PS65qO6IIeNlJU7mQBF4NPFIdNyDq11GyCkWvQYX8Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUNCZEBT/7HnJ3Fs4cTpP/lIrz2ma6qenlDLoQLgz2gd+UOqOC8pJkxpKf3jtBvKJaV9TeG57FseFhjWd1X9Hy59nnVkIXrYZO7FpyWTqjWjpXe6JGPtQDEvDDYzQDZkiwmS1KBKbihZsbkIHn7qKJUJ5avz9VLdGvYELJQLzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Xn5R34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0048C4CECC;
	Mon, 16 Sep 2024 11:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484864;
	bh=PS65qO6IIeNlJU7mQBF4NPFIdNyDq11GyCkWvQYX8Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2Xn5R34+/fSY7hPX/Yd4b/psu925W1xkbyj9GDkCn8iseTqDaU9J3Zv3Ku5yZVFZ
	 A7G850zhSWLzxGyswJxlW9qNMTGsSe+Pl0jTTdww21Mu2zuiNbAzn0bdyb+rjFb/j9
	 1bJ4mDjM4ar4MPYfarWY4IkA+4uzBcAUc4CfUJpso1CPwEskWRTCgXtKmvkMYVnadW
	 K+JaJQUDMjEIFlvoJ7rmkrkXEeiz4wlBjNuX3IjHRoz9gmVBNyLdv1fBHiIUmnFCwN
	 9ygNhkxQ2JpD3j9YeIJCU1sBTMvkgeB73Mifl6Ga9Pcby/dCLXPDHJzhHvBfLs5jva
	 DA5bkndbfb0Ww==
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
Subject: [PATCH v2 5/6] tpm: Allocate chip->auth in tpm2_start_auth_session()
Date: Mon, 16 Sep 2024 14:07:10 +0300
Message-ID: <20240916110714.1396407-6-jarkko@kernel.org>
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

Move allocation of chip->auth to tpm2_start_auth_session() so that the
field can be used as flag to tell whether auth session is active or not.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index fc1f3502e6ee..f7746a165695 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -419,7 +419,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
 	sha256_final(&sctx, out);
 }
 
-static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
+static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+				struct tpm2_auth *auth)
 {
 	struct crypto_kpp *kpp;
 	struct kpp_request *req;
@@ -478,7 +479,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	sg_set_buf(&s[0], chip->null_ec_key_x, EC_PT_SZ);
 	sg_set_buf(&s[1], chip->null_ec_key_y, EC_PT_SZ);
 	kpp_request_set_input(req, s, EC_PT_SZ*2);
-	sg_init_one(d, chip->auth->salt, EC_PT_SZ);
+	sg_init_one(d, auth->salt, EC_PT_SZ);
 	kpp_request_set_output(req, d, EC_PT_SZ);
 	crypto_kpp_compute_shared_secret(req);
 	kpp_request_free(req);
@@ -489,8 +490,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip)
 	 * This works because KDFe fully consumes the secret before it
 	 * writes the salt
 	 */
-	tpm2_KDFe(chip->auth->salt, "SECRET", x, chip->null_ec_key_x,
-		  chip->auth->salt);
+	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
 
  out:
 	crypto_free_kpp(kpp);
@@ -789,6 +789,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 			/* manually close the session if it wasn't consumed */
 			tpm2_flush_context(chip, auth->handle);
 		memzero_explicit(auth, sizeof(*auth));
+		kfree(auth);
+		chip->auth = NULL;
 	} else {
 		/* reset for next use  */
 		auth->session = TPM_HEADER_SIZE;
@@ -817,6 +819,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
 
 	tpm2_flush_context(chip, auth->handle);
 	memzero_explicit(auth, sizeof(*auth));
+	kfree(auth);
+	chip->auth = NULL;
 }
 EXPORT_SYMBOL(tpm2_end_auth_session);
 
@@ -913,25 +917,29 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
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
@@ -943,7 +951,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
 
 	/* append encrypted salt and squirrel away unencrypted in auth */
-	tpm_buf_append_salt(&buf, chip);
+	tpm_buf_append_salt(&buf, chip, auth);
 	/* session type (HMAC, audit or policy) */
 	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
 
@@ -964,10 +972,13 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
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
@@ -1315,10 +1326,6 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 		return rc;
 	}
 
-	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
-	if (!chip->auth)
-		return -ENOMEM;
-
 	return rc;
 }
 EXPORT_SYMBOL(tpm2_sessions_init);
-- 
2.46.0


