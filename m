Return-Path: <linux-integrity+bounces-172-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636497F3935
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950CD1C20E69
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0A5B217;
	Tue, 21 Nov 2023 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPa6/htb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B35B20A
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 22:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E93FC433C7;
	Tue, 21 Nov 2023 22:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605928;
	bh=7Pxyt/ojqGnO8r8ulwYL+5aIat96EW0XQ6GmCI/E80I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPa6/htb4/rLBsJ6Rp45h/Hbaup9UGgWxCyHmai5sAi2SbxnYPNVo+oZ2pO1MfHeI
	 N87V278AiSMf4ULfCirRV0e5uuPzLLcUTkW/umfUlweQolYUsHccsNLSP8gHtnUv+u
	 rpqhHxrb/idIUJbKv76O0PpkEitZaTOFeix9X7b5M7ZzVhcq5hXxrahLiM1/4Dsuyc
	 bIx0v0sJzgdn5rhrsxp68ICAhwThP3HYb6or4QHcrpze6UU2HqaLdfHShMB55AwPaN
	 oA9mt2b5qYQcX8GRvgU5OHD2gxgiujHvlEk0xX5LhOGZZp78QzO8daLRulOz6Wn824
	 FnDqO6cDIvOpA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Julien Gomes <julien@arista.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 7/8] tpm: Add tpm_buf_read_{u8,u16,u32}
Date: Wed, 22 Nov 2023 00:31:19 +0200
Message-ID: <20231121223130.30824-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121223130.30824-1-jarkko@kernel.org>
References: <20231121223130.30824-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare reader functions for the instances of struct tpm_buf. If the read
goes out of boundary, TPM_BUF_BOUNDARY_ERROR is set, and subsequent read
will do nothing.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4 [2023-11-21]: Address James Bottomley's feedback for v2 of this
patch, i.e. offset pointer was not correctly dereferenced.
v3 [2023-11-21]: Add possibility to check for boundary error to the
as response to the feedback from Mario Limenciello:
https://lore.kernel.org/linux-integrity/3f9086f6-935f-48a7-889b-c71398422fa1@amd.com/
---
 drivers/char/tpm/tpm-buf.c | 79 +++++++++++++++++++++++++++++++++++++-
 include/linux/tpm.h        |  5 +++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 099b4a56c5d5..f0b122a1c2d9 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -107,7 +107,7 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
-		WARN(1, "tpm_buf: overflow\n");
+		WARN(1, "tpm_buf: write overflow\n");
 		buf->flags |= TPM_BUF_OVERFLOW;
 		return;
 	}
@@ -143,3 +143,80 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 	tpm_buf_append(buf, (u8 *)&value2, 4);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
+
+/**
+ * tpm_buf_read() - Read from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ * @count:	the number of bytes to read
+ * @output:	the output buffer
+ */
+static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void *output)
+{
+	off_t next_offset;
+
+	/* Return silently if overflow has already happened. */
+	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+		return;
+
+	next_offset = *offset + count;
+	if (next_offset >= buf->length) {
+		WARN(1, "tpm_buf: read out of boundary\n");
+		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		return;
+	}
+
+	memcpy(output, &buf->data[*offset], count);
+	*offset = next_offset;
+}
+
+/**
+ * tpm_buf_read_u8() - Read 8-bit word from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ *
+ * Return: next 8-bit word
+ */
+u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
+{
+	u8 value;
+
+	tpm_buf_read(buf, offset, sizeof(value), &value);
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
+
+/**
+ * tpm_buf_read_u16() - Read 16-bit word from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ *
+ * Return: next 16-bit word
+ */
+u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
+{
+	u16 value;
+
+	tpm_buf_read(buf, offset, sizeof(value), &value);
+
+	return be16_to_cpu(value);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
+
+/**
+ * tpm_buf_read_u32() - Read 32-bit word from a TPM buffer
+ * @buf:	&tpm_buf instance
+ * @offset:	offset within the buffer
+ *
+ * Return: next 32-bit word
+ */
+u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
+{
+	u32 value;
+
+	tpm_buf_read(buf, offset, sizeof(value), &value);
+
+	return be32_to_cpu(value);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 715db4a91c1f..e8172f81c562 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -302,6 +302,8 @@ enum tpm_buf_flags {
 	TPM_BUF_OVERFLOW	= BIT(0),
 	/* TPM2B format: */
 	TPM_BUF_TPM2B		= BIT(1),
+	/* read out of boundary: */
+	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
 };
 
 /*
@@ -338,6 +340,9 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
+u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
+u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.42.1


