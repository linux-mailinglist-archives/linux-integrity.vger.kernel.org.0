Return-Path: <linux-integrity+bounces-7713-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F479C90378
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 22:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFF63A8DC3
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A59325717;
	Thu, 27 Nov 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDA18vcS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC640325709;
	Thu, 27 Nov 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279732; cv=none; b=VdSxJNKhJklw49ICHhxF5KTcFFJJ0zl/T8TQMHaVJd7PZtR2mYhSCsTHAw6LTbDAydPZndAZqGSPIK0hpaC8iqXa4nwZ+xmoFH0GZNl1+rzyzGPMYT4JBglRaRhJBIm1njaFR4UIDvS2RfqBYKLhE4i63lBAXuwHFU7+vjDipkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279732; c=relaxed/simple;
	bh=nRCr2evzd6yP3J3Prn3I8dRfy4vG8D1jwPFXwFhpvEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAQPsOueOQJfmH59G+VVRXOyVnSd85Z+cMhuoGvaYfdsfqtdTW8Vkiymh5HMcUtZtvCMlX0rCK5rBfp117LgEKtOA0qj/Rxwb0SvvXLgIR5PraMzHIInMIurDZ2JD+uD/+GGdgI9OXdTs0MpeUrKVeBV+8RDzNA/1XlLyoox3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDA18vcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521C0C4CEF8;
	Thu, 27 Nov 2025 21:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764279731;
	bh=nRCr2evzd6yP3J3Prn3I8dRfy4vG8D1jwPFXwFhpvEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDA18vcSOzh1E2y8zFlyBJHiT22BT+22Rqybtg5auXSc3K0Unj/dd2gmi41U0C/F0
	 GAVxXr88txMJ7m0AfwT1Ini7TV8XU/NGhwVCv80DUWdj1Ao2ZeUysJswI2AySnVZZ5
	 sqSpcbO19l/dBdxfBeWiEVu1jOluCuT3O9zA8wZkALDNxMGGc8PHvdvTl/IC27nwpA
	 rS8PG0y4Zd6AiwQOy+FQ2Zd1Y4kynfvU53AMD3rRGfoE9+ZXKnfeUf0aNc3defJoqJ
	 rE66se5oFGNW4Y21GuFB27ZbG0a/tMBGltFkVuRn4iCs7cqy8vVP6ORxx8Pzcs3hrD
	 gKPiFaDBqOX3g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/11] KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
Date: Thu, 27 Nov 2025 23:41:30 +0200
Message-ID: <20251127214138.3760029-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127214138.3760029-1-jarkko@kernel.org>
References: <20251127214138.3760029-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Use tpm_ret_to_err() to transmute TPM return codes in trusted_tpm2.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
v6:
- No changes.
v5:
- No changes.
v4:
- No changes.
v3:
- No changes.
v2:
- New patch split out from the fix.
---
 security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 36e20a9a94b4..42ae6990a6ed 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -331,25 +331,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	}
 
 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
+	if (blob_len < 0)
+		rc = blob_len;
 
 out:
 	tpm_buf_destroy(&sized);
 	tpm_buf_destroy(&buf);
 
-	if (rc > 0) {
-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
-			rc = -EINVAL;
-		else
-			rc = -EPERM;
-	}
-	if (blob_len < 0)
-		rc = blob_len;
-	else
+	if (!rc)
 		payload->blob_len = blob_len;
 
 out_put:
 	tpm_put_ops(chip);
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -453,10 +447,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 out:
 	tpm_buf_destroy(&buf);
 
-	if (rc > 0)
-		rc = -EPERM;
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -519,8 +510,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
-	if (rc > 0)
-		rc = -EPERM;
 
 	if (!rc) {
 		data_len = be16_to_cpup(
@@ -553,7 +542,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 
 out:
 	tpm_buf_destroy(&buf);
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -585,6 +574,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 
 out:
 	tpm_put_ops(chip);
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
-- 
2.52.0


