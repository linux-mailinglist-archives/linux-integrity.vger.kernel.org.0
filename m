Return-Path: <linux-integrity+bounces-8063-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC033CC1C23
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 10:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D163830312CA
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181DF33C1A8;
	Tue, 16 Dec 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u88APjTR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138433C1A1;
	Tue, 16 Dec 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876933; cv=none; b=iprc+SXG5T0c68cVPKm8TTvXppdfHv5sS1B8E/4l7hNl85uxDskLN9n6owOnjKUDiGsUCvs7PfkNhTdZgizvsN7CbNHQ5YZO1HsjmocYOgwsoTFfAYRXhBOwLv1j50XKET7gHRdygORHyvTB6gu4MzAF9m2GGXmP+Jbbxkcs9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876933; c=relaxed/simple;
	bh=FHUyR88PQ2QJFep1CUd0xN5Zr+H39ie66m0Kuwx0VCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LmFJSF3vrniM8Pdb3T5G1/urw8snkyOF6hOFbyXsvBSJYiKZmZx18FEWh7YrQgNQAQ96MJMuhAAVgaDlxtNpBO4EheNZpeRlsXbXUfRBBunTDu/Hue4RP9vUCGZuJJog4E3xQl7ZzatBzS41ZpEuCmEy3xk0JZ1NtKMzGTPfJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u88APjTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C4BC4CEF1;
	Tue, 16 Dec 2025 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876932;
	bh=FHUyR88PQ2QJFep1CUd0xN5Zr+H39ie66m0Kuwx0VCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u88APjTRLiOjlR9AVMsn/SoJWZm3LHwvvrJbahlZqmLvmQQIAsRbatXXRszjc4xOf
	 5AFeqMcLeVwkf3TickJX7rcxLwn9DHR00RFQWEVzmeiSP8y7a1YFDnOniEwYQlABRY
	 91eeIEsSi57pmiTbap6n1kw/LcitGDe4muXRbhTk7VvMHUyeBztcxc/HHgmFV0asGG
	 VwgGLPqOttRLX9iQG0f3Y4hLcYjePToQRhjj9BH65WU+QOtISMyS8y8lE3WsDXRI0W
	 wMpx9p5kcxskqBpClkRtYVD8zffgtd+JB9heko7z02pfLZl7bbbPf8lFzGgLuHbAdt
	 tWeokSWsKphEA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v8 04/12] tpm: Change tpm_get_random() opportunistic
Date: Tue, 16 Dec 2025 11:21:38 +0200
Message-Id: <20251216092147.2326606-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216092147.2326606-1-jarkko@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hwrng framework does not have a requirement that the all bytes requested
need to be provided. By enforcing such a requirement internally, TPM driver
can cause unpredictability in latency, as a single tpm_get_random() call
can result multiple TPM commands.

Especially, when TCG_TPM2_HMAC is enabled, extra roundtrips could have
significant effect to the system latency.

Thus, send TPM command only once and return bytes received instead of
committing to the number of requested bytes.

Cc: David S. Miller <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v7:
- Given that hwrng is now only caller for tpm_get_random(), remove the
  wait parameter.
v4:
- Fixed grammar mistakes.
---
 drivers/char/tpm/tpm-interface.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index d157be738612..677dcef05dfb 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -626,10 +626,6 @@ static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
-	u32 num_bytes = max;
-	u8 *out_ptr = out;
-	int retries = 5;
-	int total = 0;
 	int rc;
 
 	if (!out || !max || max > TPM_MAX_RNG_DATA)
@@ -646,28 +642,14 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 		rc = tpm2_start_auth_session(chip);
 		if (rc)
 			return rc;
-	}
-
-	do {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
-			rc = tpm2_get_random(chip, out_ptr, num_bytes);
-		else
-			rc = tpm1_get_random(chip, out_ptr, num_bytes);
-
-		if (rc < 0)
-			goto err;
-
-		out_ptr += rc;
-		total += rc;
-		num_bytes -= rc;
-	} while (retries-- && total < max);
 
-	tpm_put_ops(chip);
-	return total ? total : -EIO;
+		rc = tpm2_get_random(chip, out, max);
+	} else {
+		rc = tpm1_get_random(chip, out, max);
+	}
 
-err:
 	tpm_put_ops(chip);
-	return rc;
+	return rc != 0 ? rc : -EIO;
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
 
-- 
2.39.5


