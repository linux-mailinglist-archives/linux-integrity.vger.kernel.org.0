Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375067A0B3
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 18:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjAXR6z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 12:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjAXR6y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 12:58:54 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEA46159;
        Tue, 24 Jan 2023 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674583133;
        bh=j8s3MAH4gAww4EanJpJX1q31VFGAa766SNAMcsGTBKk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=SUoMQSJPV0CbKHWPDxpT1+9g6XWnLFSyoHKHhva1BsdtNVa9/2kGbqImovIjzn6wZ
         NcSK3IzF/z3pIsy9B9YKXTjx3Nj4VgSQfFP3F6kzZK3od49fVAYb+hp1KF27xNAkQn
         78Ubg8buZ7afg+6tgOB9x/zcvUR8SVd8LCiLTlmk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4975F12861A7;
        Tue, 24 Jan 2023 12:58:53 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NcWP-ot2jBsG; Tue, 24 Jan 2023 12:58:53 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AECC712818AC;
        Tue, 24 Jan 2023 12:58:52 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 09/11] KEYS: trusted: Add session encryption protection to the seal/unseal path
Date:   Tue, 24 Jan 2023 12:55:14 -0500
Message-Id: <20230124175516.5984-10-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124175516.5984-1-James.Bottomley@HansenPartnership.com>
References: <20230124175516.5984-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v2: fix unseal with policy and password
---
 security/keys/trusted-keys/trusted_tpm2.c | 85 ++++++++++++++++-------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 2b2c8eb258d5..0ed308d400da 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -230,6 +230,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 {
 	int blob_len = 0;
 	struct tpm_buf buf;
+	struct tpm2_auth *auth;
 	u32 hash;
 	u32 flags;
 	int i;
@@ -252,18 +253,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
+	rc = tpm2_start_auth_session(chip, &auth);
+	if (rc)
+		goto out_put;
+
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	if (rc) {
-		tpm_put_ops(chip);
-		return rc;
+		tpm2_end_auth_session(auth);
+		goto out_put;
 	}
 
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+	tpm_buf_append_name(&buf, auth, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, TPM2_SA_DECRYPT,
+				    options->keyauth, TPM_DIGEST_SIZE);
 
 	/* sensitive */
 	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len);
@@ -308,7 +310,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 	}
 
+	tpm_buf_fill_hmac_session(&buf, auth);
 	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
+	if (rc)
+		goto out;
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (rc)
 		goto out;
 
@@ -340,6 +346,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	else
 		payload->blob_len = blob_len;
 
+out_put:
 	tpm_put_ops(chip);
 	return rc;
 }
@@ -363,6 +370,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 u32 *blob_handle)
 {
 	struct tpm_buf buf;
+	struct tpm2_auth *auth;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
@@ -409,16 +417,19 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
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
+
+	tpm_buf_append_name(&buf, auth, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(&buf, auth, 0, options->keyauth,
+				    TPM_DIGEST_SIZE);
 
 	tpm_buf_append(&buf, blob, blob_len);
 
@@ -427,7 +438,9 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		goto out;
 	}
 
+	tpm_buf_fill_hmac_session(&buf, auth);
 	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
@@ -461,24 +474,48 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
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
-			     options->blobauth_len);
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
+		 * FIXME: The policy session was generated outside the
+		 * kernel so we don't known the nonce and thus can't
+		 * calculate a HMAC on it.  Therefore, the user can
+		 * only really use TPM2_PolicyPassword and we must
+		 * send down the plain text password, which could be
+		 * intercepted.  We can still encrypt the returned
+		 * key, but that's small comfort since the interposer
+		 * could repeat our actions with the exfiltrated
+		 * password.
+		 */
+		tpm2_buf_append_auth(&buf, options->policyhandle,
+				     NULL /* nonce */, 0, 0,
+				     options->blobauth, options->blobauth_len);
+		tpm_buf_append_hmac_session_opt(&buf, auth, TPM2_SA_ENCRYPT,
+						NULL, 0);
+	}
 
+	tpm_buf_fill_hmac_session(&buf, auth);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
+	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
 	if (rc > 0)
 		rc = -EPERM;
 
-- 
2.35.3

