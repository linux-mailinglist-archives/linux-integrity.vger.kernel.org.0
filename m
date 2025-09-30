Return-Path: <linux-integrity+bounces-7344-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82DBAEC04
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 01:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A851C7A6C79
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518C2D3218;
	Tue, 30 Sep 2025 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr+hFFLl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260401A2C0B;
	Tue, 30 Sep 2025 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274419; cv=none; b=O3sJJC/q/jOB/Fwsn60F6CHWhk56BD/Xw6fR39I6+XyPSSbUcTpCnNY9qfZxSok2W5cUWgH2wZ+n8pAGcdxKinoh6l6+uyCUfUCzMSWVhoR88w2U+wiUNBZGSOlURVGfTF80ZIHV+ijTuSeO3w0LMjoaTtJ0uFgM24Dh1x8kAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274419; c=relaxed/simple;
	bh=J7dYilX7+fwruSZCr5jW3fpm0gVg9dKX3I7gHKTRx3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfZxLvEFT63JswLOOzR2LCQNOcPImGIpzBtpSwf9YOM89U9wsa9ayu0WaY743VwKNRZiH4PRKfX/k/zh8EhFTM2GgjIby+8lZwwn2gwLp+sMeeYN2mHgY/hcDfGNE5tLwvybFtC0gu594gXkVvIz51wSw4UNtOXJIVBwkyCjj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr+hFFLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB4C113CF;
	Tue, 30 Sep 2025 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759274418;
	bh=J7dYilX7+fwruSZCr5jW3fpm0gVg9dKX3I7gHKTRx3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cr+hFFLlLjYxcU+gALEz2z9ALdqoKi0S1V4ZnmWLTV/VdFj0eikSACQLsmarOSx0E
	 yOXyr8tAcqQ62c/+rNaRbq7YZePManb4nz3ppmSoYp/9ZuajbvKmk+rHXo74XioFIc
	 7108i0qZnE2bkvNZ6ZI0vxLdzcw/P7Rn6NzWIW9S4vBBgwbQ3137pqMgx/ebbylXI8
	 HJUsxGLOMGhcTl1r0ttFPUsrRjrRQHBbE3+Gad5Zn+6ikNfN+j5uPNLOkG62fYnpgO
	 rr0T+r1YGSNYsaCkyOBkhrLTYBxD2dOGSqXg1d7aXRPSWnv2FG3loAuAUZLyK0xBiM
	 Hr073UO6jqd+w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/9] KEYS: trusted: Use tpm_ret_to_err() in trusted_tpm2
Date: Wed,  1 Oct 2025 02:19:52 +0300
Message-Id: <20250930231958.1437783-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930231958.1437783-1-jarkko@kernel.org>
References: <20250930231958.1437783-1-jarkko@kernel.org>
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
index 024be262702f..e165b117bbca 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -348,25 +348,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
@@ -468,10 +462,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		kfree(blob);
 	tpm_buf_destroy(&buf);
 
-	if (rc > 0)
-		rc = -EPERM;
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -534,8 +525,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_fill_hmac_session(chip, &buf);
 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
-	if (rc > 0)
-		rc = -EPERM;
 
 	if (!rc) {
 		data_len = be16_to_cpup(
@@ -568,7 +557,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 
 out:
 	tpm_buf_destroy(&buf);
-	return rc;
+	return tpm_ret_to_err(rc);
 }
 
 /**
@@ -600,6 +589,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 
 out:
 	tpm_put_ops(chip);
-
-	return rc;
+	return tpm_ret_to_err(rc);
 }
-- 
2.39.5


