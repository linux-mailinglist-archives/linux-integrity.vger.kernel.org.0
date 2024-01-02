Return-Path: <linux-integrity+bounces-606-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968F822045
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 18:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F751C2266C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58DE1549F;
	Tue,  2 Jan 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cQrdOwxz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292F15491;
	Tue,  2 Jan 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704215769;
	bh=IXTaYPhs+Z47ZssITLiRDv+1XDVv5UgqtsfBBLD02kI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=cQrdOwxzULmhwGE59v8s103OrFtgumr0KGZzAzrtou5aBAmFnVmw/pZpUPKqqs58F
	 R8f+XuXgMglkYG1lsdBwZQesIzXQ+jyNLjd4p21cumSMvij8LUL0a5DbmB9Up7+Dbj
	 3wyY51H+y5og8RnY3QIZIO62CHHet5V42ZAQwewI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6103C12868A4;
	Tue,  2 Jan 2024 12:16:09 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 3m-peuLcmc5V; Tue,  2 Jan 2024 12:16:09 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 873171286695;
	Tue,  2 Jan 2024 12:16:08 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v6 18/20] KEYS: trusted: Add session encryption protection to the seal/unseal path
Date: Tue,  2 Jan 2024 12:04:06 -0500
Message-Id: <20240102170408.21969-19-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v3: fix session memory leak
---
 security/keys/trusted-keys/trusted_tpm2.c | 88 ++++++++++++++++-------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 97b1dfca2dba..dfeec06301ce 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -253,26 +253,26 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
+	rc = tpm2_start_auth_session(chip);
+	if (rc)
+		goto out_put;
+
 	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
 	if (rc) {
-		tpm_put_ops(chip);
-		return rc;
+		tpm2_end_auth_session(chip);
+		goto out_put;
 	}
 
 	rc = tpm_buf_init_sized(&sized);
 	if (rc) {
 		tpm_buf_destroy(&buf);
-		tpm_put_ops(chip);
-		return rc;
+		tpm2_end_auth_session(chip);
+		goto out_put;
 	}
 
-	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
-	tpm_buf_append_u32(&buf, options->keyhandle);
-	tpm2_buf_append_auth(&buf, TPM2_RS_PW,
-			     NULL /* nonce */, 0,
-			     0 /* session_attributes */,
-			     options->keyauth /* hmac */,
-			     TPM_DIGEST_SIZE);
+	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
+				    options->keyauth, TPM_DIGEST_SIZE);
 
 	/* sensitive */
 	tpm_buf_append_u16(&sized, options->blobauth_len);
@@ -314,10 +314,13 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
+		tpm2_end_auth_session(chip);
 		goto out;
 	}
 
+	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 4, "sealing data");
+	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 	if (rc)
 		goto out;
 
@@ -348,6 +351,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	else
 		payload->blob_len = blob_len;
 
+out_put:
 	tpm_put_ops(chip);
 	return rc;
 }
@@ -417,25 +421,31 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
+	rc = tpm2_start_auth_session(chip);
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
+		tpm2_end_auth_session(chip);
+		return rc;
+	}
+
+	tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
+				    TPM_DIGEST_SIZE);
 
 	tpm_buf_append(&buf, blob, blob_len);
 
 	if (buf.flags & TPM_BUF_OVERFLOW) {
 		rc = -E2BIG;
+		tpm2_end_auth_session(chip);
 		goto out;
 	}
 
+	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 4, "loading blob");
+	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 	if (!rc)
 		*blob_handle = be32_to_cpup(
 			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
@@ -473,20 +483,44 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	u8 *data;
 	int rc;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
+	rc = tpm2_start_auth_session(chip);
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
+		tpm2_end_auth_session(chip);
+		return rc;
+	}
+
+	tpm_buf_append_name(chip, &buf, blob_handle, NULL);
+
+	if (!options->policyhandle) {
+		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
+					    options->blobauth,
+					    options->blobauth_len);
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
+		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
+						NULL, 0);
+	}
 
+	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
+	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
 	if (rc > 0)
 		rc = -EPERM;
 
-- 
2.35.3


