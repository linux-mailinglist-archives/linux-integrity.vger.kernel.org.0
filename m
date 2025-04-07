Return-Path: <linux-integrity+bounces-5628-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6DCA7D57F
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 09:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84DB188E0AB
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9C225784;
	Mon,  7 Apr 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INMZ82CW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971E176AA1;
	Mon,  7 Apr 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010258; cv=none; b=FuVaGH1PBnTgpWjGhnRqtz6Ew4F0GNYo/1oa7GvNoluIXFyEqpiKOnVzbrJ4lMCM8gI6CTnYOBKliYqaotUB//nzO85j4a5PPY/vBFP35CZ3fNhLufMh7fvzlYtVIw9qihE7P3+J4j4GvfQc+bxu1rg6V8bCZidFdyV6FOO997Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010258; c=relaxed/simple;
	bh=ZMpjbqNV5VmvNx/yWcRwPHpaDgDVafqCD1Ypnp/Awhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxjVAx1X9FIDRz2NZdYVi+gpjIpK2+ytrgmybAMaf/fakEY57Gi1iATacbqbE3jHZI0yLiMEJ8S6aojs5AO1f3VWQoL8Eu+RGDKJTr0DktZeXBys27L/3/f9b8ovGivzYpFgsQLE0pAsUQK/7T+Cx3p5nw/MQ6TCD8OlksVJLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INMZ82CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12981C4CEE8;
	Mon,  7 Apr 2025 07:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744010257;
	bh=ZMpjbqNV5VmvNx/yWcRwPHpaDgDVafqCD1Ypnp/Awhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INMZ82CWGDwx835l7YQF1L/d1lSwQBKmNVJMiEdhnwGTPIEvwEJIGLd7hxvJ9DFnb
	 nFshLFU8bbnHriaqJ3GBHX8DjYWADh9mRpLCMIpW8tyrAUVIH4IRRYdmZVDw6vIfmb
	 mpdi4x4KEKLhfmOuPBwkoeTSdP73g7PUH8JRewv+lX0XfpcbydJk2C4Ct5NldMAgVN
	 RqhkCO8cBt3qkL75WU5KpkesF4qqnvXnyriLhtdYCoD6qCM1KkwD3Rfdt6XHu3J/5q
	 /E81o25eRmwOFnvq6ZqZySXCmG2CvBk2E2NLvLZ4SaeBYS9EitOfrMkvyNOFdHCsKh
	 evd0G4BIVyqqA==
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
Subject: [PATCH v2] tpm: Mask TPM RC in tpm2_start_auth_session()
Date: Mon,  7 Apr 2025 10:17:31 +0300
Message-Id: <20250407071731.78915-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407062642.72556-1-jarkko@kernel.org>
References: <20250407062642.72556-1-jarkko@kernel.org>
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
v2:
- Investigate TPM rc only after destroying tpm_buf.
---
 drivers/char/tpm/tpm2-sessions.c | 29 +++++++++++++++--------------
 include/linux/tpm.h              |  1 +
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3f89635ba5e8..da382b86dc41 100644
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
@@ -1024,7 +1016,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	/* hash algorithm for session */
 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
+	rc = tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession");
 	tpm2_flush_context(chip, null_key);
 
 	if (rc == TPM2_RC_SUCCESS)
@@ -1032,6 +1024,15 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
 	tpm_buf_destroy(&buf);
 
+	switch (rc) {
+	case TPM2_RC_SESSION_MEMORY:
+		rc = -ENOMEM;
+		goto out;
+	default:
+		rc = -EFAULT;
+		goto out;
+	}
+
 	if (rc == TPM2_RC_SUCCESS) {
 		chip->auth = auth;
 		return 0;
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


