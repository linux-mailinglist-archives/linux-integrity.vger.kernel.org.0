Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6CAD8EC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfIIMXt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:23:49 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48376 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfIIMXt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:23:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 639378EE180;
        Mon,  9 Sep 2019 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031829;
        bh=Dk4ieGLbX9ESMCTKII4nKlB99Z5WOmJxP3DjgubAZNs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=w87cyxxDKIehHXRfViMXd0RV8L1/e7xmUSGnoFMAgzacq1QQAS1UYhLZZv/Cal/t0
         WK/u+6zWaGjD6gbYB9a075ITHtA0Oms5e2QYFzPk0tdK0p3JVcAdD4hy2XmyVYfJid
         /nC6pwj/orE9w5EK5AqyTew4g/RVkbpCz6/AgVqs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XrUA0nDFRJki; Mon,  9 Sep 2019 05:23:49 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2868E8EE105;
        Mon,  9 Sep 2019 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031829;
        bh=Dk4ieGLbX9ESMCTKII4nKlB99Z5WOmJxP3DjgubAZNs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=w87cyxxDKIehHXRfViMXd0RV8L1/e7xmUSGnoFMAgzacq1QQAS1UYhLZZv/Cal/t0
         WK/u+6zWaGjD6gbYB9a075ITHtA0Oms5e2QYFzPk0tdK0p3JVcAdD4hy2XmyVYfJid
         /nC6pwj/orE9w5EK5AqyTew4g/RVkbpCz6/AgVqs=
Message-ID: <1568031826.6613.38.camel@HansenPartnership.com>
Subject: [PATCH v6 09/12] trusted keys: Add session encryption protection to
 the seal/unseal path
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:23:46 +0100
In-Reply-To: <1568031408.6613.29.camel@HansenPartnership.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If some entity is snooping the TPM bus, the can see the data going in
to be sealed and the data coming out as it is unsealed.  Add parameter
and response encryption to these cases to ensure that no secrets are
leaked even if the bus is snooped.

As part of doing this conversion it was discovered that policy
sessions can't work with HMAC protected authority because of missing
pieces (the tpm Nonce).  I've added code to work the same way as
before, which will result in potential authority exposure (while still
adding security for the command and the returned blob), and a fixme to
redo the API to get rid of this security hole.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 124 ++++++++++++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 572d05966b77..2c798f18282f 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -422,7 +422,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 {
 	unsigned int blob_len;
 	struct tpm_buf buf;
+	struct tpm_buf t2b;
 	u32 hash;
+	struct tpm2_auth *auth;
 	int i;
 	int rc;
 
@@ -436,45 +438,56 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (i == ARRAY_SIZE(tpm2_hash_map))
 		return -EINVAL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	if (rc) {
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
+
+	rc = tpm_buf_init_2b(&t2b);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
 
+	tpm_buf_append_name(&buf, auth, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_DECRYPT,
+				    options->keyauth, TPM_DIGEST_SIZE);
 	/* sensitive */
-	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
+	tpm_buf_append_u16(&t2b, TPM_DIGEST_SIZE);
+	tpm_buf_append(&t2b, options->blobauth, TPM_DIGEST_SIZE);
+	tpm_buf_append_u16(&t2b, payload->key_len + 1);
+	tpm_buf_append(&t2b, payload->key, payload->key_len);
+	tpm_buf_append_u8(&t2b, payload->migratable);
 
-	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
-	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
-	tpm_buf_append_u16(&buf, payload->key_len + 1);
-	tpm_buf_append(&buf, payload->key, payload->key_len);
-	tpm_buf_append_u8(&buf, payload->migratable);
+	tpm_buf_append_2b(&buf, &t2b);
 
 	/* public */
-	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
-	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
-	tpm_buf_append_u16(&buf, hash);
+	tpm_buf_append_u16(&t2b, TPM_ALG_KEYEDHASH);
+	tpm_buf_append_u16(&t2b, hash);
 
 	/* policy */
 	if (options->policydigest_len) {
-		tpm_buf_append_u32(&buf, 0);
-		tpm_buf_append_u16(&buf, options->policydigest_len);
-		tpm_buf_append(&buf, options->policydigest,
+		tpm_buf_append_u32(&t2b, 0);
+		tpm_buf_append_u16(&t2b, options->policydigest_len);
+		tpm_buf_append(&t2b, options->policydigest,
 			       options->policydigest_len);
 	} else {
-		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
-		tpm_buf_append_u16(&buf, 0);
+		tpm_buf_append_u32(&t2b, TPM2_OA_USER_WITH_AUTH);
+		tpm_buf_append_u16(&t2b, 0);
 	}
 
 	/* public parameters */
-	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
-	tpm_buf_append_u16(&buf, 0);
+	tpm_buf_append_u16(&t2b, TPM_ALG_NULL);
+	/* unique (zero) */
+	tpm_buf_append_u16(&t2b, 0);
+
+	tpm_buf_append_2b(&buf, &t2b);
 
 	/* outside info */
 	tpm_buf_append_u16(&buf, 0);
@@ -487,7 +500,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
+	tpm_buf_fill_hmac_session(&buf, auth);
 	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (rc)
 		goto out;
 
@@ -505,6 +520,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	payload->blob_len = blob_len;
 
 out:
+	tpm_buf_destroy(&t2b);
 	tpm_buf_destroy(&buf);
 
 	if (rc > 0) {
@@ -536,6 +552,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 u32 *blob_handle)
 {
 	struct tpm_buf buf;
+	struct tpm2_auth *auth;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
@@ -550,17 +567,18 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	if (rc) {
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
 
+	tpm_buf_append_name(&buf, auth, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, 0, options->keyauth, TPM_DIGEST_SIZE);
 	tpm_buf_append(&buf, payload->blob, blob_len);
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
@@ -568,7 +586,9 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		goto out;
 	}
 
+	tpm_buf_fill_hmac_session(&buf, auth);
 	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
@@ -600,24 +620,50 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   u32 blob_handle)
 {
 	struct tpm_buf buf;
+	struct tpm2_auth *auth;
 	u16 data_len;
 	u8 *data;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	rc = tpm2_start_auth_session(chip, &auth);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_u32(&buf, blob_handle);
-	tpm2_buf_append_auth(&buf,
-			     options->policyhandle ?
-			     options->policyhandle : TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     TPM2_SA_CONTINUE_SESSION,
-			     options->blobauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	if (rc) {
+		tpm2_end_auth_session(auth);
+		return rc;
+	}
+
+	tpm_buf_append_name(&buf, auth, blob_handle, NULL);
+
+	if (!options->policyhandle) {
+		tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_ENCRYPT,
+					    options->blobauth, TPM_DIGEST_SIZE);
+	} else {
+		/*
+		 * FIXME: the policy can't be used for HMAC protection
+		 * of the authorization because it must be generated
+		 * with the initial nonces which isn't passed in, so
+		 * append a second encryption session to at least HMAC
+		 * protect the command and encrypt the sealed blob on
+		 * return.
+		 *
+		 * Note: this also means the caller either has to use
+		 * an empty password or compute the password HMAC
+		 * based on the policy nonces and place it in blobauth
+		 */
+		tpm2_buf_append_auth(&buf, options->policyhandle,
+				     NULL /* nonce */, 0, 0,
+				     options->blobauth /* hmac */,
+				     TPM_DIGEST_SIZE);
+		tpm_buf_append_hmac_session_opt(&buf, auth, TPM2_SA_ENCRYPT,
+						NULL, 0);
+	}
 
+	tpm_buf_fill_hmac_session(&buf, auth);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (rc > 0)
 		rc = -EPERM;
 
-- 
2.16.4

