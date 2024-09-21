Return-Path: <linux-integrity+bounces-3647-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2C97DD0F
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 14:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E20D1C20985
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362191714A4;
	Sat, 21 Sep 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec4AbweI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B61547DA;
	Sat, 21 Sep 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726920502; cv=none; b=dHof5KqyVigwgU5DxRfC1SxrFC5PLEkEb5FaRs8ymjDSFhZM3sRNnjqKo7Q0Q7ymhiatw5USPtZ1RXavVFKl4YQzU7FG7mpkD8aYnh9SbqKqwzdfRMJsnkvbjvdZFvyxyN3kbQyYmGBzW0XVAebEunzYjMTih3Pq58iaioIQNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726920502; c=relaxed/simple;
	bh=emJg9Q6RhIzPfgJr3GQ05y7BJpoPEwXcyHUOVtxUKqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJXTv8OXasQGBUWqhQDkeP+cCLU+/nLzrPZWQ7bdRa5890XKOmWwDXddUNTWV17iuwvIlLCg0zgh8SuJkzbFoS41VFf+EOUi0jqKbKEBijO0GxR952mWpdZebaIlwlodn1ovFgTFllY8jxm532CjIp132FkftEDmtAkMQMGSzZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec4AbweI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223C1C4CEC2;
	Sat, 21 Sep 2024 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726920501;
	bh=emJg9Q6RhIzPfgJr3GQ05y7BJpoPEwXcyHUOVtxUKqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ec4AbweIc3du/s0Z3pJ4PVXePv2GIgtMlaCUxjk/briBHgOp7i/S1XveevQPUD8J0
	 Z9VWitPESuqMBLJJUFof7qUG8jMx58uKRwH3T/Cnz1khEDKR9JQ0y5JMPcZ1dYVvgK
	 3nDbBNbLPM2k+si/ZDgp1ZxpTBg3FmlkNJNcbhQ96P1QSt5LN8gYbV5jv9o5Ts0C2N
	 vuJciSripTYXE33yZQZSACGwXCl/aueqlymT1DLHYOdSOXXqyfTGY4dhi6H5yJgr1U
	 X3TSTFKvtPb6KUovsToV9/CV5lqdudXH8exXHZMpp5eEU/uFo4tm49BLB/Zwp7zwRx
	 HmX8Ah4bPxkvw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] tpm: Return on tpm2_create_null_primary() failure
Date: Sat, 21 Sep 2024 15:08:01 +0300
Message-ID: <20240921120811.1264985-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240921120811.1264985-1-jarkko@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_sessions_init() does not ignores the result of
tpm2_create_null_primary(). Address this by returning -ENODEV to the
caller.

Cc: stable@vger.kernel.org # v6.10+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5:
- Do not print klog messages on error, as tpm2_save_context() already
  takes care of this.
v4:
- Fixed up stable version.
v3:
- Handle TPM and POSIX error separately and return -ENODEV always back
  to the caller.
v2:
- Refined the commit message.
---
 drivers/char/tpm/tpm2-sessions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..0f09ac33ae99 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1338,7 +1338,8 @@ static int tpm2_create_null_primary(struct tpm_chip *chip)
 		tpm2_flush_context(chip, null_key);
 	}
 
-	return rc;
+	/* Map all errors to -ENODEV: */
+	return rc ? -ENODEV : rc;
 }
 
 /**
@@ -1354,7 +1355,7 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	rc = tpm2_create_null_primary(chip);
 	if (rc)
-		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+		return rc;
 
 	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
 	if (!chip->auth)
-- 
2.46.1


