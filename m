Return-Path: <linux-integrity+bounces-7725-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D7C90AB4
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 03:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D53D3AC2AC
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 02:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB4298CC4;
	Fri, 28 Nov 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqpCycxF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D10281358;
	Fri, 28 Nov 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298467; cv=none; b=ZcEq24UOcFv6aKUiHG5A9wYxgaz0VONlcmX8a3Z0KHHXdUOIKADcVRCSOVDZiECum346feRGOJSoUB6HNi9XcsD3Jw0zcqW4Q/zhUcmrVSTpjLH86uLVeIwEKNdk9SCQ+hrOY4N3fYku3PQmaXUSCpAe67pnYZ8nBSnLiFXjED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298467; c=relaxed/simple;
	bh=HSPWIaou3sg13A4sP5sT/MOqlanDMIbkuMMW0glmtVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bd/Wg2sjJkN/9AcgmAqAqdOvOD+xSPnuk+LLFOKXDLljofETSbCwDyRb+INiF6NZhuPLZDNcOpWkm2MGkywVVrk3reNk0Uoyk4wbYo6oZQ1tYyDqI3eeDrqjcuYfM6fZH0uPSTWYMBRtyEOXPbMuFLWnbw1Y7pl14qFUITL7MrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqpCycxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A96C4CEF8;
	Fri, 28 Nov 2025 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764298467;
	bh=HSPWIaou3sg13A4sP5sT/MOqlanDMIbkuMMW0glmtVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqpCycxFf1S5h8JTVbEwVdrbvDElWyoSrSH50SL2uPis0P1js2VZUJYIsTf0TCxdK
	 KZx7OzhJij/MkqjWjUHjj114x9g/P8IsVO9b3VDV5tK6P0Vic9OmLPgp/Y0FtMI2Fn
	 6KqqW/oiZ9J7LzlWTtMIyTO/Q59YkQjUSIUx1MFxnt5UjzJR4rP1FoWiqSTLPPvRuJ
	 jn4AHw118Stjih0Ra32tABasGEwxazmE2k7nvYNl+HAGlI7guJhq8dPvaNYJg5KH08
	 TpIT3BJVboUEXoeiXLfeWwvgyCtMRZRoh5gYhZGG6r4vaM3ExyJyFeJEPbUFrr9X7G
	 4ns223Y7i7WIg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v9 2/8] tpm2-sessions: Open code tpm_buf_append_hmac_session()
Date: Fri, 28 Nov 2025 04:53:54 +0200
Message-ID: <20251128025402.4147024-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128025402.4147024-1-jarkko@kernel.org>
References: <20251128025402.4147024-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Open code 'tpm_buf_append_hmac_session_opt' to the call site, as it only
masks a call sequence and does otherwise nothing particularly useful.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
---
v8:
- Improvde the language a bit.
v7:
- No changes.
v6:
- No changes.
v5:
- No changes.
v4:
- Fixed typo in short summary.
v3:
- No changes.
v2:
- Uncorrupt the patch.
---
 drivers/char/tpm/tpm2-cmd.c               | 14 +++++++++++---
 include/linux/tpm.h                       | 23 -----------------------
 security/keys/trusted-keys/trusted_tpm2.c | 12 ++++++++++--
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e6cb4083c14e..e298194883e8 100644
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
index 004680757923..973458a38250 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -535,29 +535,6 @@ void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
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
2.52.0


