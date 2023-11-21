Return-Path: <linux-integrity+bounces-160-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328AC7F37F9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E030F282856
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5878B54667;
	Tue, 21 Nov 2023 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKkdUPzG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA154666
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 21:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC746C433C9;
	Tue, 21 Nov 2023 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700601466;
	bh=tjk9p4TlrYObLmQhm2Bz2gDnKhOQJKBounykc75pSc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKkdUPzGcA/FX4eFo4XJ2ND71Ux3fNopFK7OjOAiSVvDrNsMUkos0j/xde29hbHCw
	 aeixhlrdHLlXricAz/WxMJ2ZXG3cLapgCvKj1xsjb71H2Ix82m7Je3mJkA09rkn0VZ
	 BaFDcORFIm7Pd9UiNpwJX58/LRxuPh5+JTw7iZ3LJTGf5qmrecLYGbPceiMpMire9o
	 RBSnV4Gfkxq6ia/+S2Lw9I5ic0tUWv3okfozOgURGmQZR5LZqj5XLHfpK7biYXw+SH
	 EJhZ8MvtXnZ03tA2EiWU3sccvoVkp7OrMqzEolCXhNn9maRf4u07r9CV+85qk3excP
	 Q47c2aCVZ4g7Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	William Roberts <bill.c.roberts@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <jejb@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Julien Gomes <julien@arista.com>
Subject: [PATCH v4 7/8] tpm: Add tpm_buf_read_{u8,u16,u32}
Date: Tue, 21 Nov 2023 23:17:16 +0200
Message-ID: <20231121211717.31681-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121211717.31681-1-jarkko@kernel.org>
References: <20231121211717.31681-1-jarkko@kernel.org>
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
v3 [2023-11-21]: Add possibility to check for boundary error to the
as response to the feedback from Mario Limenciello:
https://lore.kernel.org/linux-integrity/3f9086f6-935f-48a7-889b-c71398422fa1@amd.com/
---
 drivers/char/tpm/tpm-buf.c | 76 +++++++++++++++++++++++++++++++++++++-
 include/linux/tpm.h        |  5 +++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 12bfade11372..f721e90757c4 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -108,7 +108,7 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
-		WARN(1, "tpm_buf: overflow\n");
+		WARN(1, "tpm_buf: write overflow\n");
 		buf->flags |= TPM_BUF_OVERFLOW;
 		return;
 	}
@@ -144,3 +144,77 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
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
+	/* Return silently if overflow has already happened. */
+	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+		return;
+
+	if (*(offset + count) >= buf->length) {
+		WARN(1, "tpm_buf: read out of boundary\n");
+		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		return;
+	}
+
+	memcpy(output, &buf->data[*offset], count);
+	*offset += count;
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


