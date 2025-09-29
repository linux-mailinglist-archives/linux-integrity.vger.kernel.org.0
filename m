Return-Path: <linux-integrity+bounces-7287-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28445BA7E8A
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 06:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99F57AEB2F
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Sep 2025 03:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6705214A97;
	Mon, 29 Sep 2025 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLD+MAlb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1914A91;
	Mon, 29 Sep 2025 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118416; cv=none; b=GRIeb5z77nmiwHzQstoK7fnRAQjIgV2tFoLZZs5RDpGQtxa4Uh+t8hFhxh4oKm8TJd0W6rXXzVoBffITH13HlGi80OMOADt0HalClHW5M9JBsNeaawlXZe6QlOwWNcCP1Sa+qMOSbKxAETLdTwA4ra2EpgTSaCalS3Bdqp/aOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118416; c=relaxed/simple;
	bh=vp/EXe41X8sVnTgTmzJQ7JxUyo9s8SkCvGwzwhH8u3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcGNWMMDHsaSKAYeiwyLOh8+YB8TZfZm6ux02JPAEdN4mOJusu5fnv196kWvZrzyiz6i/1qMzc610mgb5X/VGDPhqyZFYdc1rA9UyHntHHJENwqMnWoPJqOzUPN6YSWHwtoZqSNum0Qf/MMmD5icWLKKAcHVzzgBD+kCJDCpb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLD+MAlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C67FC113D0;
	Mon, 29 Sep 2025 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759118415;
	bh=vp/EXe41X8sVnTgTmzJQ7JxUyo9s8SkCvGwzwhH8u3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLD+MAlbYU9Fbu09zkbFlJZe7F4J5o7E8o3Re+gPohGB2S2MLOJD0M1JgvAj53qE6
	 1rrqUxJqtKbzVeH7Zy/7biVcqzYlC+1uGBkjGqLLtikD21NWgndSvrQAucHGYIDWue
	 H1xUNv5mp+QAyXZqJoN7dALJloIAn1rDq3fQFYv7Mvm2gpEj+Z7MN9CCxGShWf5VhW
	 ry88xz7mAy7hn5jlYGC9GVfW3EJPGqfJPZCMjd54rXpeBLoG1KFLdwVROfC9P+XsA7
	 8AJo8Aj5gE+1HBgBP8js9O5uxZoWypK4LACYHGAuXjsMrj65JUiOkvuESqtcNAFrjs
	 b7/W6xVEBLmLg==
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
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 5/9] tpm2-sessions: Umask tpm_buf_append_hmac_session()
Date: Mon, 29 Sep 2025 06:59:34 +0300
Message-Id: <20250929035938.1773341-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929035938.1773341-1-jarkko@kernel.org>
References: <20250929035938.1773341-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Open code tpm_buf_append_hmac_session_opt() in order to unmask the code
paths in the call sites of tpm_buf_append_hmac_session().

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
v2:
- Uncorrupt the patch.
---
 drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
 include/linux/tpm.h                       | 23 -----------------------
 security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c182a07b70de..eef324e61308 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -257,9 +257,17 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
 	do {
 		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
-						| TPM2_SA_CONTINUE_SESSION,
-						NULL, 0);
+		if (tpm2_chip_auth(chip)) {
+			tpm_buf_append_hmac_session(chip, &buf,
+						    TPM2_SA_ENCRYPT |
+						    TPM2_SA_CONTINUE_SESSION,
+						    NULL, 0);
+		} else  {
+			offset = buf.handles * 4 + TPM_HEADER_SIZE;
+			head = (struct tpm_header *)buf.data;
+			if (tpm_buf_length(&buf) == offset)
+				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		}
 		tpm_buf_append_u16(&buf, num_bytes);
 		tpm_buf_fill_hmac_session(chip, &buf);
 		err = tpm_transmit_cmd(chip, &buf,
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1fa02e18e688..e72e7657faa2 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -532,29 +532,6 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 int passphraselen);
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u8 *passphrase, int passphraselen);
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
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index e165b117bbca..c414a7006d78 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -482,8 +482,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
+	struct tpm_header *head;
 	struct tpm_buf buf;
 	u16 data_len;
+	int offset;
 	u8 *data;
 	int rc;
 
@@ -518,8 +520,14 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		tpm2_buf_append_auth(&buf, options->policyhandle,
 				     NULL /* nonce */, 0, 0,
 				     options->blobauth, options->blobauth_len);
-		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT,
-						NULL, 0);
+		if (tpm2_chip_auth(chip)) {
+			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
+		} else  {
+			offset = buf.handles * 4 + TPM_HEADER_SIZE;
+			head = (struct tpm_header *)buf.data;
+			if (tpm_buf_length(&buf) == offset)
+				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+		}
 	}
 
 	tpm_buf_fill_hmac_session(chip, &buf);
-- 
2.39.5


