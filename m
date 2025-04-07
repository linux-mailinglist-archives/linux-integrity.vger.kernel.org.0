Return-Path: <linux-integrity+bounces-5629-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F2A7D5A9
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 09:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160317A4E22
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780222AE7B;
	Mon,  7 Apr 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCq1aAlo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7022A4F2;
	Mon,  7 Apr 2025 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010465; cv=none; b=UE2D7dQiVcxZ5cS0pUg8dTYt7uZDY/4NEU7B83u/NNNgn99P6+HKYhrXokH2OG54u869tZCU4i2176TafUJwFxtMduRv2Mo8wMi8VCKp5EaqjGGvzOcA5CH3rOMmOsTzOcTEg4aKSBGObK/ndLWVX61UbRavW4jSRxu8+nJiBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010465; c=relaxed/simple;
	bh=zTKxNvvZtoxntBZKdgelRQVrZfzC919L3UJ4SOuheOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRy3hfGN0SbgpIptvHhs+5pOlsZl4K2sU498as7UMp1qPonqUgjzGmVI5BAcD6pjetTjnhw18p2tVzZSA1lEfvdBw2tihhb7iVLCtNYemEeWQka1kWh4okKd6OW8rUe01WJVNYspAAm3X5JFPeiKZJEK5E92AcHRRkUPtLyfcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCq1aAlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62AEC4CEDD;
	Mon,  7 Apr 2025 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744010464;
	bh=zTKxNvvZtoxntBZKdgelRQVrZfzC919L3UJ4SOuheOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FCq1aAlo0vKB5iK30TDh0dwYwkTE9k6HIdVkmRBqOgSMPrrA0vD71QlInKossJaqm
	 JLpclX2Wi+vFme1QPFfH6776jm9285u2ye0CGmfmxCfjznnoDHyDTLu27pJXdE00wP
	 kvXIDuGpYun8/Rach9/O02hoGskjYIKB3e5Kg3ZpUf67Kxr3fRfK5g5beGpc7X2/0J
	 U6r4eMwLf+JBM3vPCIyzj8Zeyw3bePvZA6+bNR7mdpq438kX4Ebbd7mo8Ok6UlfefC
	 j6Tf0htUtJTOnMSjVxHRkLHfisJvAR4Anz9hrxNl/40y94/0q9x/7XaexjrLPNc0F/
	 AMWc4VCctJnkA==
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
Subject: [PATCH v3] tpm: Mask TPM RC in tpm2_start_auth_session()
Date: Mon,  7 Apr 2025 10:20:57 +0300
Message-Id: <20250407072057.81062-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407071731.78915-1-jarkko@kernel.org>
References: <20250407071731.78915-1-jarkko@kernel.org>
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
v3:
- rc > 0
v2:
- Investigate TPM rc only after destroying tpm_buf.
---
 drivers/char/tpm/tpm2-sessions.c | 31 +++++++++++++++++--------------
 include/linux/tpm.h              |  1 +
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3f89635ba5e8..abd54fb0a45a 100644
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
@@ -1032,6 +1024,17 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 
 	tpm_buf_destroy(&buf);
 
+	if (rc > 0) {
+		switch (rc) {
+		case TPM2_RC_SESSION_MEMORY:
+			rc = -ENOMEM;
+			goto out;
+		default:
+			rc = -EFAULT;
+			goto out;
+		}
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


