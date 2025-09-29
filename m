Return-Path: <linux-integrity+bounces-7296-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C1BAA82A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 21:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649571655DE
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC37925179A;
	Mon, 29 Sep 2025 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl5rKIsz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DA250BEC;
	Mon, 29 Sep 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175343; cv=none; b=mIxXA6utqMzibypu3eAcXj2IfvIC4gPxTf5m4qRewGuVlC4dPWDyTVs8ogGf6Q4xvMuAQ4J/enH7OoaQ40dtEKqCKEPQ/bvaTEJZhWiirvY9IAkVzT3fS4Fw60nWqSF0hDchgjH4h1Paxa/YkFjXkYPzPS+HAFc/4qtF1hhJO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175343; c=relaxed/simple;
	bh=P3WwEfvDElda2d/q7fTHO0OWGD5NIM0FLhsDiJMfHQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDLtMBpOSR/C/QdVQN+rMebOdmyWsS+/bspm/Zs88dDctepKTPpxGPsrNYr8lls7nrtMqM6h28XZZpnVkESUkzcNauD20upvXcdpTnM8Q7E/0dgNClsOPrimAFwDeV5eCEiZo+eSPPsZqRmJYXlI8db7YUSD0T92bT94sHaAMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl5rKIsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3517C4CEF4;
	Mon, 29 Sep 2025 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759175342;
	bh=P3WwEfvDElda2d/q7fTHO0OWGD5NIM0FLhsDiJMfHQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tl5rKIszVa755G1dsWI+/Cdod11nug5jeUG84wIwOCnFMirSs+maUObt6F3OYN7Hz
	 /BEknPz4uGIGVctwADFjTWPTYI7Vci+n35I77vHYTzUlhd8FGqyEgvfvvienO7irTf
	 gaL2gBHZTf9VeNElKzTrKaxIQo8QPMwLMjfYL2t4k8mwf40Zge/bi0rm25N2QC0EZ5
	 u41PSG2E/STPzvZqN7taM8yTsrgx6C9Tyi3NLqjTON6lDUWjwDDz2wk8f3sKkYj+Hq
	 PCk24CClPiGQ9H22U3iDohSgUKcyelEcu32fRlHd6EXi+xFzXXBhlxJcRZDtU+6JKU
	 DbNcEVD2hRvFQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 04/10] tpm2-sessions: Remove 'attributes' from tpm_buf_append_auth
Date: Mon, 29 Sep 2025 22:48:26 +0300
Message-Id: <20250929194832.2913286-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929194832.2913286-1-jarkko@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

In a previous bug fix, 'attributes' was added by mistake to
tpm_buf_append_auth(). Remove the parameter.

Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v3:
- No changes
v2:
- Uncorrupt the patch.
---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 5 ++---
 include/linux/tpm.h              | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index a7cddd4b5626..86b1a4d859b9 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -191,7 +191,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(chip, &buf, pcr_idx);
-		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
+		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
 	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 6d03c224e6b2..13f019d1312a 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -266,7 +266,7 @@ void tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphrase_len)
+			 u8 *passphrase, int passphrase_len)
 {
 	/* offset tells us where the sessions area begins */
 	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
@@ -327,8 +327,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_auth(chip, buf, attributes, passphrase,
-				    passphrase_len);
+		tpm_buf_append_auth(chip, buf, passphrase, passphrase_len);
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 51846317d662..1fa02e18e688 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -531,7 +531,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphraselen);
+			 u8 *passphrase, int passphraselen);
 static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
 						   struct tpm_buf *buf,
 						   u8 attributes,
-- 
2.39.5


