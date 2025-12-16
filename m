Return-Path: <linux-integrity+bounces-8054-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD1DCC1612
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 08:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943BD305DCC8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8773451D7;
	Tue, 16 Dec 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuqKpd3m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C43451D1;
	Tue, 16 Dec 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871141; cv=none; b=ADxdphTUl8LIFOOskri2cH3N7rvy252P2D5lovSO8e8dcZc5/DaK/YJY2aVrD5gDQVJz0hAU7o+uRMwTi+LbWB2yg0ImHgZCDxHV7npySBvm3+jSh5aKFRJK2GJbQPk1CxceCBzXxkRe3PI+MEZmdUuocf3KWmTIJIueBk3Z7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871141; c=relaxed/simple;
	bh=0i3zA22k2tG1Va0CvL4JeyMUaJv8xOEqU4aBTN2XJI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApPPHxYzB7PZeDSnnjd4/g23jv1uyZ7JY8Es9RKZaraT7TK0mNiPIAb5e0MnqMkamMtFq+dan0PB3fadFVq5ml/2epGZ5sPkoJ7oZG3NABwTy1spqmWzlZE8B8QcEHQtpGeUeotD3qqC9MQ1kGYUpR2IPYZtlUmHTE/muOJDc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuqKpd3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2993FC16AAE;
	Tue, 16 Dec 2025 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871141;
	bh=0i3zA22k2tG1Va0CvL4JeyMUaJv8xOEqU4aBTN2XJI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuqKpd3mB5mQ1zBY8bIwUOpI2XvNo6Llxdpn8YlmscUiwqRfbdjfpraiu6114/255
	 XvKCfzjjPEVi2nfyRDB6ETmQBGye4s1OownUP//68HzkC8/hoCX31tkbQONuBFhvzF
	 fHRgm1iyGhKjFwJbhSn0bCg36q71wMnHtbS3wx/kgKixKr25c2vAHi7P3J8dAdsRre
	 h1szOwf8v7ngPt6uRzCTYncIC+5X8ZXn6gPsQ6WXa/kXysM+f8ClT1RtPX5SLoVnH4
	 p+U56RN0+pdf+B9HCky95jert4jw559VTD4l836w4Zs5Bk5CARtxK9cW6B2L/x+Gwd
	 aMnhX7+y0QtWQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v7 09/12] tpm: Change tpm_get_random() opportunistic
Date: Tue, 16 Dec 2025 09:44:50 +0200
Message-Id: <20251216074454.2192499-10-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251216074454.2192499-1-jarkko@kernel.org>
References: <20251216074454.2192499-1-jarkko@kernel.org>
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


