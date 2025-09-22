Return-Path: <linux-integrity+bounces-7225-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC413B92456
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86674444E25
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 16:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE69312801;
	Mon, 22 Sep 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3yEKpeu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C53054E6;
	Mon, 22 Sep 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559418; cv=none; b=p/wEu5gKG4PFIYtmEjUZCntrDzkXGnkH6YzwCQ0I60A71zkKW47AwGuz7kPnySWsTHe0f8NCDn0eoHqOd3iGxUBW+xlAdN4pleC14m2iYitWqT3QnXYppJB1WBAI+WyZnTrIAsW4ZRbGW3BTV/PK6eS5k4SEkEJFDPkhEEqATt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559418; c=relaxed/simple;
	bh=Y+1c7b5mQ+4e2GWN5FoK5I9PttJtkmd4OsSaL/5zHpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCrfIBW0Cb4Q8V2DmwXbDGwI+C7ewTymcuOag/S6OLecltXY9TzBVqaU7hHQdTasDXIkW38J2gQKKVWSjOpZu1CVQOIc34iX/Mm1Z0vC6sHKoHgPu9I2aE5YoFYtxLM52qOX/XW2Rk3bFrNBa0B0o5FKDCNmrWcKXMaKWA3UHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3yEKpeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F245C4CEF0;
	Mon, 22 Sep 2025 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559417;
	bh=Y+1c7b5mQ+4e2GWN5FoK5I9PttJtkmd4OsSaL/5zHpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3yEKpeuycJuljiuOVrPSpMaxboE2k2Bx07dKuMffdp4nfJWxOA2rUJQ7wTAIcvpj
	 cva+rwnRJFIwyFeZAHRnf2ONvq68zOLlxRPKZOvXu04mekJNUg789FQxqK7SP0muoE
	 iNDwdPhXyNL2hOTmIAp2+Ft6ZXqq3VUjAoUuPMyR5Gsd4IDEPvmEZHMgcVk4yj4vi+
	 jBzjmCiYtWQC453fMzT7ERGQR64W0KU1/IK0raHgIA3orpaxQALlsizAH/QvgY/lmn
	 EoUe15Cb5HSpEDwpc+/ntLezbVet7A1jBfy/Kp5avZ3tTJurr6Hgo3IX7MLccKp9uj
	 rSIHrTrjwFjvQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH 2/4] tpm2-sessions: Remove unused parameter from tpm_buf_append_auth
Date: Mon, 22 Sep 2025 19:43:15 +0300
Message-Id: <20250922164318.3540792-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922164318.3540792-1-jarkko@kernel.org>
References: <20250922164318.3540792-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

In earlier bug fix, an extra parameter was by mistake to the function.

Fixes: 27184f8905ba ("tpm: Opt-in in disable PCR integrity protection")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm2-cmd.c      |  2 +-
 drivers/char/tpm/tpm2-sessions.c |  5 ++---
 include/linux/tpm.h              | 25 +------------------------
 3 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7d77f6fbc152..61a4daaef292 100644
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
index 667d290789ca..a8984d273c28 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -533,30 +533,7 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
-			 u8 attributes, u8 *passphrase, int passphraselen);
-static inline void tpm_buf_append_hmac_session_opt(struct tpm_chip *chip,
-						   struct tpm_buf *buf,
-						   u8 attributes,
-						   u8 *passphrase,
-						   int passphraselen)
-{
-	struct tpm_header *head;
-	int offset;
-
-	if (tpm2_chip_auth(chip)) {
-		tpm_buf_append_hmac_session(chip, buf, attributes, passphrase, passphraselen);
-	} else  {
-		offset = buf->handles * 4 + TPM_HEADER_SIZE;
-		head = (struct tpm_header *)buf->data;
-
-		/*
-		 * If the only sessions are optional, the command tag must change to
-		 * TPM2_ST_NO_SESSIONS.
-		 */
-		if (tpm_buf_length(buf) == offset)
-			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-	}
-}
+			 u8 *passphrase, int passphraselen);
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 
-- 
2.39.5


