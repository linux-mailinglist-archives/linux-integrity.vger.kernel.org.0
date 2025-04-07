Return-Path: <linux-integrity+bounces-5627-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64622A7D3FD
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 08:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992073AC418
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 06:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5CF224B0C;
	Mon,  7 Apr 2025 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLWzKvEs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9045224AFE;
	Mon,  7 Apr 2025 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007210; cv=none; b=NVqXHmFxXfzhwdYpmDh7sHIlA13FeUJ6QTUN94xCIf3d6HnPVgLumNQRW8tgqMy5ASpFmpt/PDK8JUmBGV+oWg/iGCSqUuWURIDGSckFI+xBWH0LXjNAyGxZpTXxsnoVsyirMvxGsr3g7W1AgQmVDNW1zpKV5l/h37MwjCYBssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007210; c=relaxed/simple;
	bh=JbtnUeBkY8lHjyDAeo00/LdvvPp6LVNtEhu2KGtCojc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgcQNmH6xdBI4onTu/zbh0F2HAtKVYu13+HkGI0t/RXN8pIxjvGh7yjKSVbIeoBkocKhDyA89jj8ySPrjEv0U0YFuMLK/xXbt8AHv6HT0GDWU6CbLqBgVvtCgx802D4fweM6YgOd0OW9RMrRIjKMkLs+1PzJW0Rot+gFP9wG4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLWzKvEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FF0C4CEDD;
	Mon,  7 Apr 2025 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744007209;
	bh=JbtnUeBkY8lHjyDAeo00/LdvvPp6LVNtEhu2KGtCojc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLWzKvEsvfO66KL3cyea5KENf77WOaDn5eHgyBuFY4k7eAcI4AMAlVS9Wf8RqC4+4
	 ATCAWk3MbMuqgfA3Cl08+QEj0FZigBrdmxBON5I9z65ykPs+QHoDf37nc7+Tto007B
	 jbNHrrQAzW4t8aoSbWM/pIS3IAw51b4KuVsy17IoCt12NuiMwY34arYOKoluaNe12l
	 mXe7OTxg5qtmG4PR93stlnaYK2ipwqkiXT+HoCrT/myYTqStaTIL8HTK3aEfZjQy4p
	 8+btH3ipSLOOw1DYrbfNBW4OO6biX1wug9VDgbNV6kJLc342RStY6zCnQT19cgIGV4
	 rOAKFDOAbhUKg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: Mask TPM RC in tpm2_start_auth_session()
Date: Mon,  7 Apr 2025 09:26:42 +0300
Message-Id: <20250407062642.72556-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <Z_NgdRHuTKP6JK--@gondor.apana.org.au>
References: <Z_NgdRHuTKP6JK--@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_start_auth_session() does not mask TPM RC correctly from the callers:

[   28.766528] tpm tpm0: A TPM error (2307) occurred start auth session

Process TPM RCs inside tpm2_start_auth_session(), and map them to POSIX
error codes.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
Closes: https://lore.kernel.org/linux-integrity/Z_NgdRHuTKP6JK--@gondor.apana.org.au/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 34 ++++++++++++++++----------------
 include/linux/tpm.h              |  1 +
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3f89635ba5e8..1ed23375e4cb 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -40,11 +40,6 @@
  *
  * These are the usage functions:
  *
- * tpm2_start_auth_session() which allocates the opaque auth structure
- *	and gets a session from the TPM.  This must be called before
- *	any of the following functions.  The session is protected by a
- *	session_key which is derived from a random salt value
- *	encrypted to the NULL seed.
  * tpm2_end_auth_session() kills the session and frees the resources.
  *	Under normal operation this function is done by
  *	tpm_buf_check_hmac_response(), so this is only to be used on
@@ -963,16 +958,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 }
 
 /**
- * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
- * @chip: the TPM chip structure to create the session with
+ * tpm2_start_auth_session() - Create an a HMAC authentication session
+ * @chip:	A TPM chip
  *
- * This function loads the NULL seed from its saved context and starts
- * an authentication session on the null seed, fills in the
- * @chip->auth structure to contain all the session details necessary
- * for performing the HMAC, encrypt and decrypt operations and
- * returns.  The NULL seed is flushed before this function returns.
+ * Loads the ephemeral key (null seed), and starts an HMAC authenticated
+ * session. The null seed is flushed before the return.
  *
- * Return: zero on success or actual error encountered.
+ * Returns zero on success, or a POSIX error code.
  */
 int tpm2_start_auth_session(struct tpm_chip *chip)
 {
@@ -1024,11 +1016,19 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	/* hash algorithm for session */
 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession");
 	tpm2_flush_context(chip, null_key);
-
-	if (rc == TPM2_RC_SUCCESS)
-		rc = tpm2_parse_start_auth_session(auth, &buf);
+	switch (rc) {
+	case TPM2_RC_SUCCESS:
+		break;
+	case TPM2_RC_SESSION_MEMORY:
+		rc = -ENOMEM;
+		goto out;
+	default:
+		rc = -EFAULT;
+		goto out;
+	}
+	rc = tpm2_parse_start_auth_session(auth, &buf);
 
 	tpm_buf_destroy(&buf);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6c3125300c00..c1d3d60b416f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -257,6 +257,7 @@ enum tpm2_return_codes {
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 	TPM2_RC_RETRY		= 0x0922,
+	TPM2_RC_SESSION_MEMORY	= 0x0903,
 };
 
 enum tpm2_command_codes {
-- 
2.39.5


