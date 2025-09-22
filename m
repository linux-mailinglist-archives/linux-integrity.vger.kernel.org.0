Return-Path: <linux-integrity+bounces-7226-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E4B9246B
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 18:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14ED87A8639
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E131283C;
	Mon, 22 Sep 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au+5IcJk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCB3126A0;
	Mon, 22 Sep 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559422; cv=none; b=M1GsAVBxYdlxxhvzZhsuIHPIh7ZxJlxCHpP30KgVsoeKbFtB0GfmCpcL5Lkhdo80359TqrIG7S27DbPwO8/RDXqU63UCtnigBuSlzs5VuCf+90J+dUbLI9FUHzy6krkjjFRv5IQQw76VOGOCxQCYOs3ktUDuOozfwARmJCyK4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559422; c=relaxed/simple;
	bh=RMx6siXIeqVXuN1p/iukcu2ZicONPOiKZaft77WYbOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rktMbSbPuPtrIPT/TuyBscCRIptkLG/auljdgeXOFjU9nmqOtekMnPhYUieePFuz2Qwc7aNNnQe0QU8b/KBJUDuLbtseppG8Hc92cO3SAypku0JJja8F0mOknygQAyRHB7Y8HP9T8R6bVk8r6NQhOlQM5uFI0tmL8Zas4B7vrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au+5IcJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59926C4CEF0;
	Mon, 22 Sep 2025 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559421;
	bh=RMx6siXIeqVXuN1p/iukcu2ZicONPOiKZaft77WYbOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Au+5IcJkOfY2W+7+X80vfpT/DsC8grrYXXPFrGinXajYvn2raiHV7sAI2PmeicNum
	 jkodul7tlqw9w5URp3a1CL0E0hcU29sssOje3rge8ULlu0+3PPjEwduYhSX6Ed66W/
	 zMbnO6YzMI68x34XosQ8QrWfKXE4EwSBdX1GmVro2YOq35tVhcwqr2fP1UyWdBL/sp
	 oWjNOLMGrSb9jl2ukKeoYoIyvDNM10CIVbnszvxlT+zNx7i/4OI5M+Q98e8Q7KmCEI
	 tFmO2ArGNPSv60tdUvmyqHpvtuUpgkl4Ia2uVWuJaTdHEAhmDXvqruMnCKdAl3uTnm
	 FSCA56p8TAWBQ==
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
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH 3/4] tpm2-sessions: Remove unnecessary wrapper
Date: Mon, 22 Sep 2025 19:43:16 +0300
Message-Id: <20250922164318.3540792-4-jarkko@kernel.org>
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

Open code tpm_buf_append_hmac_session_opt() because it adds unnecessary
disperancy to the call sites (and reduces the amount of code).

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
 security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 61a4daaef292..0a795adbdc11 100644
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


