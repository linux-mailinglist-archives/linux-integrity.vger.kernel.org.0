Return-Path: <linux-integrity+bounces-2264-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6F8B638E
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F632840BE
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804BC1419B4;
	Mon, 29 Apr 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="uC8bZVLv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121513AD2F;
	Mon, 29 Apr 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422568; cv=none; b=F8NuLyJKUvQz979sFAFl0hqeyeSJz6AtFq8Y5jS/rOw7JXHEsN2OTBVzuJcWszIPJdAqojSOvSQNOMQDVfcuZ8oV/CF0u4kdRlMcDR2yM2CsBfALbYcj7Wyv7p0fQGNBT9esOBqsKHiSJcQKXyrVUEYdYWbCp2POtKm2Y5UHjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422568; c=relaxed/simple;
	bh=B5x/0D2Tjpcday6Z/hf7mIF1khP/vscYwie2pM+QlM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INdTCsDGqJJZlCuIKEd3GFngDqNJvLBw3/ozYkGDFv6NktJxLVJ6waCyp8mYggV/uBG1QqrF3TzbogElGp1KSUKGDwFM0MzMzzEcbC9zKZyvvkQQw7C4DCJibLlZr2y0t42Gx7xcs62hIPUbLtyOP3axSTc9dBK2gzwVbf3t4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=uC8bZVLv; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422566;
	bh=B5x/0D2Tjpcday6Z/hf7mIF1khP/vscYwie2pM+QlM8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=uC8bZVLvP8CNiSUaAJgXVXozQ6mqpSL/0kToU8p5l4TH6W1Hy0U+NC1W6wr4BwtAq
	 ZpGREatIFg9BeIAwaLqP7EzsqcptfVn+N4VbEdNlRjPI7TJVGjImO/wB2kJ3bxkfTJ
	 vKzxhIIF2uftbdgaqLgAvkSDTM3YfXpBJfqydbs4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 896951281ED0;
	Mon, 29 Apr 2024 16:29:26 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id f9b2yf6ydlhb; Mon, 29 Apr 2024 16:29:26 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D11391281D87;
	Mon, 29 Apr 2024 16:29:25 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 07/22] tpm: Add tpm_buf_read_{u8,u16,u32}
Date: Mon, 29 Apr 2024 16:27:56 -0400
Message-Id: <20240429202811.13643-8-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

Declare reader functions for the instances of struct tpm_buf. If the read
goes out of boundary, TPM_BUF_BOUNDARY_ERROR is set, and subsequent read
will do nothing.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 79 +++++++++++++++++++++++++++++++++++++-
 include/linux/tpm.h        |  5 +++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 099b4a56c5d5..32619e9ab4fa 100644
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
+	if (next_offset > buf->length) {
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
2.35.3


