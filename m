Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06007AD8BF
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfIIMSA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:18:00 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48084 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730794AbfIIMSA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:18:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B38BE8EE180;
        Mon,  9 Sep 2019 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031479;
        bh=MWUNnERm5i1CVlopl+5tSxOD3H2Wjx0IaGal5OJVhf0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aOV86vBN5cGMW4480Ipd8EqAnntktT9f28HGoFiH184RknHvtbfMAo/AfRFfaD7nJ
         dim2LWkYVVphwuhaCxLZ0l5OcGCna8MDbQxRXGe3qlZvclpEAyIw64mBJa7h2Oc2LR
         j7aydnVMcO4Yim+mjTzgs4kmh5Av3QTMBpQS3jHE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ELS4fnvkfj38; Mon,  9 Sep 2019 05:17:59 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 741C88EE105;
        Mon,  9 Sep 2019 05:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031479;
        bh=MWUNnERm5i1CVlopl+5tSxOD3H2Wjx0IaGal5OJVhf0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aOV86vBN5cGMW4480Ipd8EqAnntktT9f28HGoFiH184RknHvtbfMAo/AfRFfaD7nJ
         dim2LWkYVVphwuhaCxLZ0l5OcGCna8MDbQxRXGe3qlZvclpEAyIw64mBJa7h2Oc2LR
         j7aydnVMcO4Yim+mjTzgs4kmh5Av3QTMBpQS3jHE=
Message-ID: <1568031476.6613.30.camel@HansenPartnership.com>
Subject: [PATCH v6 01/12] tpm-buf: move from static inlines to real functions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:17:56 +0100
In-Reply-To: <1568031408.6613.29.camel@HansenPartnership.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This separates out the old tpm_buf_... handling functions from static
inlines in tpm.h and makes them their own tpm-buf.c file.  This is a
precursor so we can add new functions for other TPM type handling

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: added this patch to separate out the API changes
v3: added tpm_buf_reset_cmd()
v6: extract first then add functions
---
 drivers/char/tpm/Makefile  |   1 +
 drivers/char/tpm/tpm-buf.c | 118 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h     |  90 ++++------------------------------
 3 files changed, 129 insertions(+), 80 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index a01c4cab902a..78bd025b808a 100644
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
index 000000000000..9fa8a9cb0fdf
--- /dev/null
+++ b/drivers/char/tpm/tpm-buf.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Handing for tpm_buf structures to facilitate the building of commands
+ */
+
+#include "tpm.h"
+
+#include <linux/module.h>
+
+static int __tpm_buf_init(struct tpm_buf *buf)
+{
+	buf->data_page = alloc_page(GFP_HIGHUSER);
+	if (!buf->data_page)
+		return -ENOMEM;
+
+	buf->flags = 0;
+	buf->data = kmap(buf->data_page);
+
+	return 0;
+}
+
+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	struct tpm_header *head;
+
+	head = (struct tpm_header *) buf->data;
+
+	head->tag = cpu_to_be16(tag);
+	head->length = cpu_to_be32(sizeof(*head));
+	head->ordinal = cpu_to_be32(ordinal);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_reset);
+
+int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+{
+	int rc;
+
+	rc = __tpm_buf_init(buf);
+	if (rc)
+		return rc;
+
+	tpm_buf_reset(buf, tag, ordinal);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init);
+
+void tpm_buf_destroy(struct tpm_buf *buf)
+{
+	kunmap(buf->data_page);
+	__free_page(buf->data_page);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_destroy);
+
+u32 tpm_buf_length(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 len;
+
+	len = be32_to_cpu(head->length);
+	if (buf->flags & TPM_BUF_2B)
+		len -= sizeof(*head);
+	return len;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_length);
+
+u16 tpm_buf_tag(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return be16_to_cpu(head->tag);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_tag);
+
+void tpm_buf_append(struct tpm_buf *buf,
+		    const unsigned char *new_data,
+		    unsigned int new_len)
+{
+	struct tpm_header *head = (struct tpm_header *) buf->data;
+	u32 len = be32_to_cpu(head->length);
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
+	tpm_buf_append(buf, (u8 *) &value2, 2);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
+
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
+{
+	__be32 value2 = cpu_to_be32(value);
+
+	tpm_buf_append(buf, (u8 *) &value2, 4);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index a7fea3e0ca86..8c5b8bba60d2 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -281,6 +281,7 @@ enum tpm_sub_capabilities {
 
 enum tpm_buf_flags {
 	TPM_BUF_OVERFLOW	= BIT(0),
+	TPM_BUF_2B		= BIT(1),
 };
 
 struct tpm_buf {
@@ -289,86 +290,15 @@ struct tpm_buf {
 	u8 *data;
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
-	buf->data_page = alloc_page(GFP_HIGHUSER);
-	if (!buf->data_page)
-		return -ENOMEM;
-
-	buf->flags = 0;
-	buf->data = kmap(buf->data_page);
-	tpm_buf_reset(buf, tag, ordinal);
-	return 0;
-}
-
-static inline void tpm_buf_destroy(struct tpm_buf *buf)
-{
-	kunmap(buf->data_page);
-	__free_page(buf->data_page);
-}
-
-static inline u32 tpm_buf_length(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be32_to_cpu(head->length);
-}
-
-static inline u16 tpm_buf_tag(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be16_to_cpu(head->tag);
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
 
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
-- 
2.16.4

