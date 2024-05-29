Return-Path: <linux-integrity+bounces-2700-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5E68D3B20
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5A71F23F5B
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188A18131A;
	Wed, 29 May 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6NRrSxR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB153746E;
	Wed, 29 May 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997125; cv=none; b=iIVR79r0UK4fPK81y20WPo13izY7Zk6OKiuCYQNKMC41L+4xGCyhGQq8oVzgX7MxJGYmW4bMQbVon0C3JbfsqT7Rfo3as3aFbiJwX81CHsg3MOGq9Fcw5a6FoTKCOYIidIVXHOKeLWHOvjTQLF9oN6CQ+acYk88RleQEz5c2Rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997125; c=relaxed/simple;
	bh=95TvA9/h0nvrgtQHiKcs4/LTXnVVxXsNDauH0ofIR1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oi4DOlJwmq2C883QTN/KDwQ2rOBGg+Eh29jHg66aL299PzuQL1okcvwE9YQGOrO9mnFA3bCywKVCYdzF1Py9D6prxqcxl3I51RG+P6ePkUAwWC3gxTCgRY8X1SZCwXjMcC72gFUPETa0M+3v4RRLicRYbDh/Y4It2EVC30H7H8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6NRrSxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7923C113CC;
	Wed, 29 May 2024 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716997124;
	bh=95TvA9/h0nvrgtQHiKcs4/LTXnVVxXsNDauH0ofIR1c=;
	h=From:To:Cc:Subject:Date:From;
	b=f6NRrSxRkwEcniePe5IqWI+XjSKLpakhGIUebxS1vI3ZCzxw0EWmOsH5pxzs0X5QS
	 8CfnzAJuScqr+heWuEHBepANVqajFm9cmGkWf/4AV3295V0eZabJ/LbSHBZNOmUQaA
	 kAI5zcO1DV8f6X8rX8QpR6DkYC8cnkhEPIXAAXEMqjZez3icILEoR1bLgrUtKQS6gO
	 I4fgcUcM9AImA6vuynw8B5W+oKipY/qbOVkixC3TGRdnNBtn6ynmY+1ayl266I41rl
	 Uc+mQEhNH39e7UmWLkWK1vLixt8zHgwcckmcUG08chakyKLT5QkN2+oAJE+v09BgCx
	 2PlT5hWYSkWSg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] tpm: Remove illict WARN's from tpm2-sessions.c
Date: Wed, 29 May 2024 18:38:34 +0300
Message-ID: <20240529153835.14994-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sprinkling all over the place is just plain wrong so drop all of them
before the TPM bus encryption feature hits a release.

Link: https://lore.kernel.org/lkml/20240414170850.148122-1-elder@linaro.org/
Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
I have had to literally fight for so many other cosmetic things such as
https://lore.kernel.org/linux-integrity/20240528095438.1857-1-jarkko@kernel.org/T/#u
so that I must have missed this. 

If I contribute to any subsystem, I just plain do all that is asked,
no questions asked. Only reason I left a review unaddressed is when
I see some intersection with the architecture.

And lastly, not introducing new WARN's should be dead obvious, unless
per-WARN explicitly reasoned in the commit message near to the level
that it could be proven at court. Unless this care, I will simply not
review patch with something like this embedded.
---
 drivers/char/tpm/tpm2-sessions.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 907ac9956a78..371cf28a2b6a 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -394,7 +394,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 		/* we're not the first session */
 		len = get_unaligned_be32(&buf->data[auth->session]);
 		if (4 + len + auth->session != tpm_buf_length(buf)) {
-			WARN(1, "session length mismatch, cannot append");
+			pr_warn("tpm: session length mismatch, cannot append");
 			return;
 		}
 
@@ -644,8 +644,10 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 		dev_err(&chip->dev, "TPM: too many handles\n");
 		return;
 	}
-	WARN(auth->session != tpm_buf_length(buf),
-	     "name added in wrong place\n");
+	if (auth->session != tpm_buf_length(buf)) {
+		pr_warn("tpm: name added in wrong place\n");
+		return;
+	}
 	tpm_buf_append_u32(buf, handle);
 	auth->session += 4;
 
@@ -706,8 +708,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	int parm_len, len, i, handles;
 
 	if (auth->session >= TPM_HEADER_SIZE) {
-		WARN(1, "tpm session not filled correctly\n");
-		goto out;
+		pr_warn("tpm session not filled correctly\n");
+		return;
 	}
 
 	if (rc != 0)
-- 
2.45.1


