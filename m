Return-Path: <linux-integrity+bounces-2263-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C98B638C
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D031F22F63
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FC1422A6;
	Mon, 29 Apr 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="xZOLgkXw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88613AD2F;
	Mon, 29 Apr 2024 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422560; cv=none; b=f1aXZ8OkxBivJikpisc3AMCjMOV5w0d2GmpuvGxedCplD9DxYauje/XfBPAK3bCkNvvUavAWXXUuD7WNLwcoX3OwM3dviK2u3Fe+1dGvHsssyR1dQ1yr2TvtimXIwvtsUoNINl9HDVkpuH04VHJ8FG3J61Tm/+2KoXh+IDzQTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422560; c=relaxed/simple;
	bh=GhlA/Rq82/QUrouorinlF9Wm+3ULLc25ENkn8rx/tUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUIRyD4xwwy18gu/GCgtfX88TiLs60VKswWiSvRBbf9m5ZxOtxf/OWBxKlnqSvG52iz2ZoHSYVCkx535LR5AGqIXrw6XbCVnvMgFsEWUUCA8alCMM4P3fI6qnFauJ35+5jMN5QgeyClLbtz+q61xQky6gRsifci9wO3Je1Q+pEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=xZOLgkXw; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422558;
	bh=GhlA/Rq82/QUrouorinlF9Wm+3ULLc25ENkn8rx/tUg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=xZOLgkXwqhr4spcMDc5Tq1za5rFz1FV4fDdNYg+ijI7P9PtnlOgTjVvAuPJRq82mi
	 OhcrTIOk09+mJ9ocxX+jb8laKZhvbk4d7obuBZcL6JlushSgyy6rhTJhsn1pMffQo5
	 llrXrakebjA8rcf8IIKzRQTNvH4ZIgEYcFDFqhQo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8CB541281D87;
	Mon, 29 Apr 2024 16:29:18 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id SHoqPGxA2FRk; Mon, 29 Apr 2024 16:29:18 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F298D12819F3;
	Mon, 29 Apr 2024 16:29:17 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 06/22] tpm: TPM2B formatted buffers
Date: Mon, 29 Apr 2024 16:27:55 -0400
Message-Id: <20240429202811.13643-7-James.Bottomley@HansenPartnership.com>
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

Declare tpm_buf_init_sized() and tpm_buf_reset_sized() for creating TPM2B
formatted buffers. These buffers are also known as sized buffers in the
specifications and literature.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 38 +++++++++++++++++++++++++++++++++++---
 include/linux/tpm.h        |  4 ++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 3f39893f3bb1..099b4a56c5d5 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -47,6 +47,36 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
+/**
+ * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
+ * @buf:	A @tpm_buf
+ *
+ * Return: 0 or -ENOMEM
+ */
+int tpm_buf_init_sized(struct tpm_buf *buf)
+{
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
+		return -ENOMEM;
+
+	tpm_buf_reset_sized(buf);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
+
+/**
+ * tpm_buf_reset_sized() - Initialize a sized buffer
+ * @buf:	A &tpm_buf
+ */
+void tpm_buf_reset_sized(struct tpm_buf *buf)
+{
+	buf->flags = TPM_BUF_TPM2B;
+	buf->length = 2;
+	buf->data[0] = 0;
+	buf->data[1] = 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
+
 void tpm_buf_destroy(struct tpm_buf *buf)
 {
 	free_page((unsigned long)buf->data);
@@ -72,8 +102,6 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
 	/* Return silently if overflow has already happened. */
 	if (buf->flags & TPM_BUF_OVERFLOW)
 		return;
@@ -86,7 +114,11 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 
 	memcpy(&buf->data[buf->length], new_data, new_length);
 	buf->length += new_length;
-	head->length = cpu_to_be32(buf->length);
+
+	if (buf->flags & TPM_BUF_TPM2B)
+		((__be16 *)buf->data)[0] = cpu_to_be16(buf->length - 2);
+	else
+		((struct tpm_header *)buf->data)->length = cpu_to_be32(buf->length);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 1d7b39b5c383..715db4a91c1f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -300,6 +300,8 @@ struct tpm_header {
 enum tpm_buf_flags {
 	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
+	/* TPM2B format: */
+	TPM_BUF_TPM2B		= BIT(1),
 };
 
 /*
@@ -328,6 +330,8 @@ struct tpm2_hash {
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_sized(struct tpm_buf *buf);
+void tpm_buf_reset_sized(struct tpm_buf *buf);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
-- 
2.35.3


