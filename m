Return-Path: <linux-integrity+bounces-8057-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1099FCC16CC
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 09:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 401D4304EFF9
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC035346790;
	Tue, 16 Dec 2025 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6nT74dY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D2346786;
	Tue, 16 Dec 2025 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871157; cv=none; b=WQ1HAoHzIrZLubXaI9HVbiIDKsj+bHrYwOl08vzKE08PGXN2QFHDwC1ih7h9hgU3B/l48my2y5tW3XLME6zuBGpRHqP7KdUD3BlGssCITNij77l7fbTcS+zNrQzBbmrSGJ4RYvXtRSso9DmiAeE/ig1wCDKSynRv5Pwe/XQwHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871157; c=relaxed/simple;
	bh=Nx8IZ6HOdd2PDgKswr3Bbt9/pdQRxq0yplhMYnphfMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dlIOSYzyDBXVTYeII+69Y2xyd32a7FQcRS7+kHSqGmW+nJfGm8huk9K4r2NrlWqJ7tovi1gkaucfSvgm0R2obUOHrwoGQbJMQ2jXfSe53TRozd90IhKF3YdJS0t/3CtLycqzD/KT/eoRQgKi9gjJJPCs2NXSWkgR0E7Pvc37ooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6nT74dY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF65FC4CEF1;
	Tue, 16 Dec 2025 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765871156;
	bh=Nx8IZ6HOdd2PDgKswr3Bbt9/pdQRxq0yplhMYnphfMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6nT74dYs6Mrv8obLTCMqDrn1H2iL4ZSRoKYf/tKe+WKUoZiC6iAsAzJJYvxfIavu
	 o1XelufoAWUz+OqHSxEkq9ym6AWxcxLvAo5Aw1Drkgx+yr9hgHGyqyWtfeCJOkC2V3
	 EzQpVi0z+hMz1HxO+l1E3f7l038qGfA74bS5hmbjQU7leYdtLW4UwOWR5EgmWw2K1b
	 bWh76ovQoPb4IYvvs53hIcld/aNz9K8pMDFzZ3rVoNbZAi7IawYPXkKRoi4pcOvRhX
	 f9Wek8Zo6lRV4EHU1EQZkdZw4fPeum8Pz8l2XWcMWHBbLaCjMpX38/23jse0tRWA65
	 tINVk7rtBkbMg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v7 12/12] tpm-buf: Remove tpm_buf_append_handle
Date: Tue, 16 Dec 2025 09:44:53 +0200
Message-Id: <20251216074454.2192499-13-jarkko@kernel.org>
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

Since the number of handles is fixed to a single handle, eliminate all uses
of buf->handles and deduce values during compile-time.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Streamline the code change and remove dead code.
---
 drivers/char/tpm/tpm-buf.c       | 26 --------------------------
 drivers/char/tpm/tpm2-cmd.c      |  2 +-
 drivers/char/tpm/tpm2-sessions.c | 14 ++------------
 include/linux/tpm.h              |  2 --
 4 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 6134eabe6961..752c69b8a4f5 100644
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
@@ -177,30 +175,6 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
-/**
- * tpm_buf_append_handle() - Add a handle
- * @chip:	&tpm_chip instance
- * @buf:	&tpm_buf instance
- * @handle:	a TPM object handle
- *
- * Add a handle to the buffer, and increase the count tracking the number of
- * handles in the command buffer. Works only for command buffers.
- */
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
-{
-	if (buf->flags & TPM_BUF_INVALID)
-		return;
-
-	if (buf->flags & TPM_BUF_TPM2B) {
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
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
index 335ea3d600c7..f066efb54a2c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -205,7 +205,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			return rc;
 		tpm_buf_append_hmac_session(chip, buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, buf, pcr_idx);
+		tpm_buf_append_u32(buf, pcr_idx);
 		tpm_buf_append_auth(chip, buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 8c9a7e7c82d5..f2b8ca893e15 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -261,7 +261,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_u32(buf, handle);
 		return 0;
 	}
 
@@ -288,17 +288,7 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_name);
 void tpm_buf_append_auth(struct tpm_chip *chip, struct tpm_buf *buf,
 			 u8 *passphrase, int passphrase_len)
 {
-	/* offset tells us where the sessions area begins */
-	int offset = buf->handles * 4 + TPM_HEADER_SIZE;
-	u32 len = 9 + passphrase_len;
-
-	if (tpm_buf_length(buf) != offset) {
-		/* not the first session so update the existing length */
-		len += get_unaligned_be32(&buf->data[offset]);
-		put_unaligned_be32(len, &buf->data[offset]);
-	} else {
-		tpm_buf_append_u32(buf, len);
-	}
+	tpm_buf_append_u32(buf, 9 + passphrase_len);
 	/* auth handle */
 	tpm_buf_append_u32(buf, TPM2_RS_PW);
 	/* nonce */
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4bbe0fcd1657..e68995df8796 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -395,7 +395,6 @@ enum tpm_buf_flags {
  */
 struct tpm_buf {
 	u8 flags;
-	u8 handles;
 	u16 length;
 	u16 capacity;
 	u8 data[];
@@ -441,7 +440,6 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.39.5


