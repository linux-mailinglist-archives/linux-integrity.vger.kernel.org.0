Return-Path: <linux-integrity+bounces-7864-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1369ECAF2EF
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 08:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E425030CCDD8
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 07:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61927BF93;
	Tue,  9 Dec 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a97k0cxe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF8256C70;
	Tue,  9 Dec 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265971; cv=none; b=u6QGLNSj9LHttRsPoAiIvrIVuRxkd95tlG3R3p8yir3W1pnaTF3C8UJZPepLaBaRy5wiR/XR6fzOhlp8QCxxOJvNAF5Kq/o7o2j0WxNC/HO+xmVRtdoITtXXpjfgxJKP4GLEg4vEv1HYTbkKL4PIuwNwSz85HSIiE92mI0zJiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265971; c=relaxed/simple;
	bh=dFuocr7ISngAObHRPsUc07GBxdyZmEy3cK629rJgpCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAVAg7q9/23kJaCH1ARl4DfyG55eEuM/FKMG61zz/zNS5/1xF2e+1y/psS2sKWfRbR/em28k6iSkSJBCaW2BR2DAxCyZ20qVGwVhvuWx3DbIlbacLtP0bib4swwuhG1xVrnPSmF/N+7/sxtckcZ8hRT3XO3U8x5wd3SIANUADaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a97k0cxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BF9C19421;
	Tue,  9 Dec 2025 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265971;
	bh=dFuocr7ISngAObHRPsUc07GBxdyZmEy3cK629rJgpCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a97k0cxeOlp3QLeokdm1qdmL3BEw6DEu1oHtefSYfol+yiER6GBbb/oAkz15D5mxL
	 pM+DPO+uv/0gYGEzYr3lCIDCgXOcTTatUe7hcDh/S1T7gJqjdD/tPdo+W7v2zgysbF
	 TsCtYA4wSrh1s9Cs30o3WVjLEe5VwKWx7UIEebs5X6SegSVm9e9fC4h0YOC1CBXyjY
	 XHQNWCqH3lPJ2FvOFp+IZ9PY3wyKvuv+0EvlmP0QPJwPifPrAup8Ubnd6y3yic4Iev
	 K//YfV87BIsY54xXoNmCgFCLka5sP6noi0vFshESK2oqRYO85Yo5BW/iKzlYYz4TII
	 w1RlgHCfFjtSA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH 4/4] tpm-buf: Remove tpm_buf_append_handle
Date: Tue,  9 Dec 2025 09:39:02 +0200
Message-ID: <20251209073903.767518-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209073903.767518-1-jarkko@kernel.org>
References: <20251209073903.767518-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the number of handles is fixed to a single handle, eliminate all uses
of buf->handles and deduce values during compile-time.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-buf.c                | 25 -----------------------
 drivers/char/tpm/tpm2-cmd.c               |  4 ++--
 drivers/char/tpm/tpm2-sessions.c          |  4 ++--
 include/linux/tpm.h                       |  1 -
 security/keys/trusted-keys/trusted_tpm2.c |  2 +-
 5 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 73be8a87b472..752c69b8a4f5 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -40,7 +40,6 @@ static void __tpm_buf_reset(struct tpm_buf *buf, u16 buf_size, u16 tag, u32 ordi
 	buf->flags = 0;
 	buf->length = sizeof(*head);
 	buf->capacity = buf_size - sizeof(*buf);
-	buf->handles = 0;
 	head->tag = cpu_to_be16(tag);
 	head->length = cpu_to_be32(sizeof(*head));
 	head->ordinal = cpu_to_be32(ordinal);
@@ -56,7 +55,6 @@ static void __tpm_buf_reset_sized(struct tpm_buf *buf, u16 buf_size)
 	buf->flags = TPM_BUF_TPM2B;
 	buf->length = 2;
 	buf->capacity = buf_size - sizeof(*buf);
-	buf->handles = 0;
 	buf->data[0] = 0;
 	buf->data[1] = 0;
 }
@@ -177,29 +175,6 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
-/**
- * tpm_buf_append_handle() - Add a handle
- * @buf:	&tpm_buf instance
- * @handle:	a TPM object handle
- *
- * Add a handle to the buffer, and increase the count tracking the number of
- * handles in the command buffer. Works only for command buffers.
- */
-void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
-{
-	if (buf->flags & TPM_BUF_INVALID)
-		return;
-
-	if (buf->flags & TPM_BUF_TPM2B) {
-		WARN(1, "tpm-buf: invalid type: TPM2B\n");
-		buf->flags |= TPM_BUF_INVALID;
-		return;
-	}
-
-	tpm_buf_append_u32(buf, handle);
-	buf->handles++;
-}
-
 /**
  * tpm_buf_read() - Read from a TPM buffer
  * @buf:	&tpm_buf instance
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 5b04e74b6377..d14e249831c7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -205,7 +205,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			return rc;
 		tpm_buf_append_hmac_session(chip, buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(buf, pcr_idx);
+		tpm_buf_append_u32(buf, pcr_idx);
 		tpm_buf_append_auth(chip, buf, NULL, 0);
 	}
 
@@ -281,7 +281,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 						    TPM2_SA_CONTINUE_SESSION,
 						    NULL, 0);
 		} else  {
-			offset = buf->handles * 4 + TPM_HEADER_SIZE;
+			offset = TPM_HEADER_SIZE + sizeof(u32);
 			head = (struct tpm_header *)buf->data;
 			if (tpm_buf_length(buf) == offset)
 				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 62a200ae72d7..dfd1abe673bc 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -261,7 +261,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(buf, handle);
+		tpm_buf_append_u32(buf, handle);
 		return 0;
 	}
 
@@ -289,7 +289,7 @@ void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u8 *passphrase, int passphrase_len)
 {
 	/* offset tells us where the sessions area begins */
-	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
+	int offset = TPM_HEADER_SIZE + sizeof(u32);
 	u32 len = 9 + passphrase_len;
 
 	if (tpm_buf_length(buf) != offset) {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index db716841973f..e20647cc0a0f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -437,7 +437,6 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 7756aa839d81..0a07a18da2ed 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -495,7 +495,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		if (tpm2_chip_auth(chip)) {
 			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT, NULL, 0);
 		} else  {
-			offset = buf->handles * 4 + TPM_HEADER_SIZE;
+			offset = TPM_HEADER_SIZE + sizeof(u32);
 			head = (struct tpm_header *)buf->data;
 			if (tpm_buf_length(buf) == offset)
 				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-- 
2.52.0


