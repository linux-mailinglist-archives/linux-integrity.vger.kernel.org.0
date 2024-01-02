Return-Path: <linux-integrity+bounces-591-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020F821FEB
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 18:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A20B222E6
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E04E15488;
	Tue,  2 Jan 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PA5Eh2y/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25D15480;
	Tue,  2 Jan 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704215161;
	bh=4DImhrudZ9znlmNF6meZrbdL9Csk0OqVMWjaSO93PrE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=PA5Eh2y/r0BGYo+52YCfr7/x8liXCK02GOk6WEy2pFlkqhHSKgID34kBCkGzRsWAW
	 Gx8vHDcmixDex/TUoGq5ztvF7QDRJ4OwB5h9MSWSP+wNrAubRy3actYFjzGc8m5NHc
	 eVy+racJyERQa3ZgKAAEPV0nojDmqtXbCyYnf+hw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1452A128680E;
	Tue,  2 Jan 2024 12:06:01 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id d7Cpc7Ez7wD5; Tue,  2 Jan 2024 12:06:01 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6FDC512809EB;
	Tue,  2 Jan 2024 12:06:00 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v6 03/20] tpm: Move buffer handling from static inlines to real functions
Date: Tue,  2 Jan 2024 12:03:51 -0500
Message-Id: <20240102170408.21969-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

separate out the tpm_buf_... handling functions from static inlines in
tpm.h and move them to their own tpm-buf.c file.  This is a precursor
to adding new functions for other TPM type handling because the amount
of code will grow from the current 70 lines in tpm.h to about 200
lines when the additions are done.  200 lines of inline functions is a
bit too much to keep in a header file.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/Makefile  |  1 +
 drivers/char/tpm/tpm-buf.c | 87 ++++++++++++++++++++++++++++++++++++++
 include/linux/tpm.h        | 80 ++++-------------------------------
 3 files changed, 97 insertions(+), 71 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 0222b1ddb310..ad3594e383e1 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -15,6 +15,7 @@ tpm-y += tpm-sysfs.o
 tpm-y += eventlog/common.o
 tpm-y += eventlog/tpm1.o
 tpm-y += eventlog/tpm2.o
+tpm-y += tpm-buf.o
 
 tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
 tpm-$(CONFIG_EFI) += eventlog/efi.o
diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
new file mode 100644
index 000000000000..96cee41d5b9c
--- /dev/null
+++ b/drivers/char/tpm/tpm-buf.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handling of TPM command and other buffers.
+ */
+
+#include <linux/module.h>
+#include <linux/tpm.h>
+
+int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+	if (!buf->data)
+		return -ENOMEM;
+
+	buf->flags = 0;
+	tpm_buf_reset(buf, tag, ordinal);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init);
+
+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	head->tag = cpu_to_be16(tag);
+	head->length = cpu_to_be32(sizeof(*head));
+	head->ordinal = cpu_to_be32(ordinal);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_reset);
+
+void tpm_buf_destroy(struct tpm_buf *buf)
+{
+	free_page((unsigned long)buf->data);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_destroy);
+
+u32 tpm_buf_length(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return be32_to_cpu(head->length);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_length);
+
+void tpm_buf_append(struct tpm_buf *buf,
+		    const unsigned char *new_data,
+		    unsigned int new_len)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 len = tpm_buf_length(buf);
+
+	/* Return silently if overflow has already happened. */
+	if (buf->flags & TPM_BUF_OVERFLOW)
+		return;
+
+	if ((len + new_len) > PAGE_SIZE) {
+		WARN(1, "tpm_buf: overflow\n");
+		buf->flags |= TPM_BUF_OVERFLOW;
+		return;
+	}
+
+	memcpy(&buf->data[len], new_data, new_len);
+	head->length = cpu_to_be32(len + new_len);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append);
+
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
+{
+	tpm_buf_append(buf, &value, 1);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
+
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
+{
+	__be16 value2 = cpu_to_be16(value);
+
+	tpm_buf_append(buf, (u8 *)&value2, 2);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
+
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
+{
+	__be32 value2 = cpu_to_be32(value);
+
+	tpm_buf_append(buf, (u8 *)&value2, 4);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index d9d645e9c52c..bb0e8718a432 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -326,77 +326,15 @@ struct tpm2_hash {
 	unsigned int tpm_id;
 };
 
-static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	head->tag = cpu_to_be16(tag);
-	head->length = cpu_to_be32(sizeof(*head));
-	head->ordinal = cpu_to_be32(ordinal);
-}
-
-static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
-{
-	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
-	if (!buf->data)
-		return -ENOMEM;
-
-	buf->flags = 0;
-	tpm_buf_reset(buf, tag, ordinal);
-	return 0;
-}
-
-static inline void tpm_buf_destroy(struct tpm_buf *buf)
-{
-	free_page((unsigned long)buf->data);
-}
-
-static inline u32 tpm_buf_length(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be32_to_cpu(head->length);
-}
-
-static inline void tpm_buf_append(struct tpm_buf *buf,
-				  const unsigned char *new_data,
-				  unsigned int new_len)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-	u32 len = tpm_buf_length(buf);
-
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
-		return;
-
-	if ((len + new_len) > PAGE_SIZE) {
-		WARN(1, "tpm_buf: overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
-		return;
-	}
-
-	memcpy(&buf->data[len], new_data, new_len);
-	head->length = cpu_to_be32(len + new_len);
-}
-
-static inline void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
-{
-	tpm_buf_append(buf, &value, 1);
-}
-
-static inline void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
-{
-	__be16 value2 = cpu_to_be16(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 2);
-}
-
-static inline void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
-{
-	__be32 value2 = cpu_to_be32(value);
-
-	tpm_buf_append(buf, (u8 *) &value2, 4);
-}
+int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+void tpm_buf_destroy(struct tpm_buf *buf);
+u32 tpm_buf_length(struct tpm_buf *buf);
+void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
+		    unsigned int new_len);
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.35.3


