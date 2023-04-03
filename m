Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37C46D53DA
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Apr 2023 23:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjDCVqT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 17:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjDCVqL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 17:46:11 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5341BE48;
        Mon,  3 Apr 2023 14:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680558323;
        bh=fqRQJCPCrInOn4J/uMc273Fsb1wkuHU5CERf6Db+0b8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=e0DqVAVn1Hm2JQS/GyZHnE9rEkRkDkvO3FpKEnj7BI9hapM7vZ7KdOTMu+g62Q9ws
         3SPQtBmZJaekriccyFrQg12nxxZOer64V1EIRe6nW6jJdvHJXirODHX2EOJNmRuqG0
         m2XX08QJU8SV0EGVxHbW8BZQBIb0TKGRVim3wdRY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C711B1280487;
        Mon,  3 Apr 2023 17:45:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id E-y3149EAEMs; Mon,  3 Apr 2023 17:45:23 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 40F6B1280097;
        Mon,  3 Apr 2023 17:45:23 -0400 (EDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 04/13] tpm: add buffer handling for TPM2B types
Date:   Mon,  3 Apr 2023 17:39:54 -0400
Message-Id: <20230403214003.32093-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Most complex TPM commands require appending TPM2B buffers to the
command body.  TPM2B types are variable size arrays, making it
difficult to represent them as structures.  Introduce primitives to
build them up using in place buffer append operations.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v4: add kernel doc
---
 drivers/char/tpm/tpm-buf.c | 109 ++++++++++++++++++++++++++++++++-----
 include/linux/tpm.h        |   3 +
 2 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 3351db515e6b..b7e42fb6266c 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -6,27 +6,16 @@
 #include <linux/module.h>
 #include <linux/tpm.h>
 
-/**
- * tpm_buf_init - initialize a TPM command buffer
- * @buf: pointer to a tpm_buf structure (usually on stack)
- * @tag: command tag
- * @ordinal: command ordinal
- *
- * Allocates a 4k buffer to hold the command structure.
- *
- * @return: 0 on success or -ENOMEM
- */
-int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
+static int __tpm_buf_init(struct tpm_buf *buf)
 {
 	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
 	if (!buf->data)
 		return -ENOMEM;
 
 	buf->flags = 0;
-	tpm_buf_reset(buf, tag, ordinal);
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tpm_buf_init);
 
 /**
  * tpm_buf_reset - reset an initialized TPM command buffer
@@ -48,6 +37,58 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
+/**
+ * tpm_buf_init - initialize a TPM command buffer
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ * @tag: command tag
+ * @ordinal: command ordinal
+ *
+ * Allocates a 4k buffer to hold the command structure.
+ *
+ * @return: 0 on success or -ENOMEM
+ */
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
+/**
+ * tpm_buf_init_2b - initialize a TPM command buffer for 2B data
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ *
+ * TPM commands are often composed of sets of TPM2B data.  This
+ * function initializes a tpm_buf (@buf) as a holder of TPM2B data,
+ * which allows all the current tpm2_buf_appendX functions to work on it.
+ *
+ * @return: 0 on success or -ENOMEM
+ */
+int tpm_buf_init_2b(struct tpm_buf *buf)
+{
+	struct tpm_header *head;
+	int rc;
+
+	rc = __tpm_buf_init(buf);
+	if (rc)
+		return rc;
+
+	head = (struct tpm_header *) buf->data;
+
+	head->length = cpu_to_be32(sizeof(*head));
+
+	buf->flags = TPM_BUF_2B;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_buf_init_2b);
+
 /**
  * tpm_buf_destroy - destroy an initialized TPM command buffer
  * @buf: pointer to a tpm_buf structure (usually on stack)
@@ -60,6 +101,13 @@ void tpm_buf_destroy(struct tpm_buf *buf)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_destroy);
 
+static void *tpm_buf_data(struct tpm_buf *buf)
+{
+	if (buf->flags & TPM_BUF_2B)
+		return buf->data + TPM_HEADER_SIZE;
+	return buf->data;
+}
+
 /**
  * tpm_buf_length - get the current length of a TPM command
  * @buf: pointer to a tpm_buf structure (usually on stack)
@@ -69,8 +117,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
 u32 tpm_buf_length(struct tpm_buf *buf)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
+	u32 len;
 
-	return be32_to_cpu(head->length);
+	len = be32_to_cpu(head->length);
+	if (buf->flags & TPM_BUF_2B)
+		len -= sizeof(*head);
+	return len;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_length);
 
@@ -88,7 +140,7 @@ void tpm_buf_append(struct tpm_buf *buf,
 		    unsigned int new_len)
 {
 	struct tpm_header *head = (struct tpm_header *) buf->data;
-	u32 len = tpm_buf_length(buf);
+	u32 len = be32_to_cpu(head->length);
 
 	/* Return silently if overflow has already happened. */
 	if (buf->flags & TPM_BUF_OVERFLOW)
@@ -150,3 +202,30 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 	tpm_buf_append(buf, (u8 *) &value2, 4);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
+
+static void tpm_buf_reset_int(struct tpm_buf *buf)
+{
+	struct tpm_header *head;
+
+	head = (struct tpm_header *)buf->data;
+	head->length = cpu_to_be32(sizeof(*head));
+}
+
+/**
+ * tpm_buf_append_2b - append TPM2B data to an initialized TPM command buffer
+ * @tpm2b: pointer to a tpm_buf structure containing the TPM2B data.
+ *
+ * Appends @tpm2b as a correct TPM2B structure (big endian short
+ * length) followed by data of that length.  @tpm2b is then emptied to
+ * allow reuse.
+ */
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
+{
+	u16 len = tpm_buf_length(tpm2b);
+
+	tpm_buf_append_u16(buf, len);
+	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);
+	/* clear the buf for reuse */
+	tpm_buf_reset_int(tpm2b);
+}
+EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 9c9b5760b412..76d495cb5b08 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -301,6 +301,7 @@ struct tpm_header {
 
 enum tpm_buf_flags {
 	TPM_BUF_OVERFLOW	= BIT(0),
+	TPM_BUF_2B		= BIT(1),
 };
 
 struct tpm_buf {
@@ -325,6 +326,7 @@ struct tpm2_hash {
 
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_2b(struct tpm_buf *buf);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
@@ -333,6 +335,7 @@ void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.35.3

