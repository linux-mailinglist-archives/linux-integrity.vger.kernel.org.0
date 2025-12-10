Return-Path: <linux-integrity+bounces-7891-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F5CB32D4
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8F0730267E8
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B263A233D9C;
	Wed, 10 Dec 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5yAk6Bt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3621FBEB0;
	Wed, 10 Dec 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377613; cv=none; b=Qw4qGqrhpVTvgG3Drbd0rEwvBCw8n9r9tE7BJmd/S7ETX1ofwm+XmGkyhdV89+Zf1c4UmftKKJ6l8le9OfKQUFzW8J1AUgWRIaF6fU9XsI7tkps0wnJYBkdsF5uBvXYO/HYzjSLNuIfKjfaBI2pI+gk/2nH8YxqjatkI6ILHs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377613; c=relaxed/simple;
	bh=FfDJCUK7lfUWywCaOcs8zoO2Q0y5xtmdcrVfwNUryIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgfGSDa82v3DR+ggMnERlb1Pb4JC5bwOPxuwkt8zFCwB201b54yK4VFi0P2k7tyKqBLTvi9MuSKo8IPfHHwM9XsXhfV1fo3qUyXAxGg7CIZTSsXhqDfIF39rlyvN8vn1xfYFSYLgO9IILkXeufQOLcJVaIMEcVZoZdiAlTsVFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5yAk6Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECF4C4CEF1;
	Wed, 10 Dec 2025 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377613;
	bh=FfDJCUK7lfUWywCaOcs8zoO2Q0y5xtmdcrVfwNUryIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5yAk6BtGPVocue9n93+9wR/UcAg7j7yS43G6xnbHgoQuv2/On3JlCHlMcd8ixgmQ
	 8O0IyrZzx0fn1fEemfakEiqef4/mI5cwpIZBbbC/GsFyZ1FFPEcAfKfKWMIWbhzjHP
	 6v4weyhDYm049TIs4N+/8Mnu7FXKIbpX9VSUq1yE89RfkCSBrOL2qjVk+iVuhlfwIX
	 EkBsQ57JjdPD5a/zVHCJ0fHnZxW2pkkHCS8sA+dXSsfVhOrR3ZqqlQo6z1VPEn76Xv
	 VAklQETt9O5eoaX7YxZWpb3ZJF5NpOFCyDzd++xCm3VjcKnt7b9kGs6/w9jsdWias/
	 /8WQO3Jyu+z5A==
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
Subject: [PATCH v3 5/7] tpm-buf: Remove tpm_buf_append_handle
Date: Wed, 10 Dec 2025 16:39:37 +0200
Message-ID: <20251210143940.264191-6-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210143940.264191-1-jarkko@kernel.org>
References: <20251210143940.264191-1-jarkko@kernel.org>
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
 drivers/char/tpm/tpm-buf.c       | 25 -------------------------
 drivers/char/tpm/tpm2-cmd.c      |  6 ++----
 drivers/char/tpm/tpm2-sessions.c | 14 ++------------
 include/linux/tpm.h              |  2 --
 4 files changed, 4 insertions(+), 43 deletions(-)

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
index 436ee82620e4..bc50d6b734cf 100644
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
 
@@ -281,10 +281,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 						    TPM2_SA_CONTINUE_SESSION,
 						    NULL, 0);
 		} else  {
-			offset = buf->handles * 4 + TPM_HEADER_SIZE;
 			head = (struct tpm_header *)buf->data;
-			if (tpm_buf_length(buf) == offset)
-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
+			head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
 		}
 		tpm_buf_append_u16(buf, num_bytes);
 		err = tpm_buf_fill_hmac_session(chip, buf);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 62a200ae72d7..f2b8ca893e15 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -261,7 +261,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(buf, handle);
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
index 9f684fc7ae04..e68995df8796 100644
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
-void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.52.0


