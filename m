Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A56648638
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Dec 2022 17:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLIQIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 11:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLIQIM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 11:08:12 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280D2AD3;
        Fri,  9 Dec 2022 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670602091;
        bh=fRU/5tkj5hSyjein7ZOe18eXz7wQbqGj+RoDgHzE7K8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=sJuH7HEyUn7zkrZBUa6gDq+XSB6Ahk42MTE16qhWGWIR4S+EHt+5Wvt4gJsCsf+Cv
         60+lNZn4ZoT4UqUrJ23VC+gYdgPc+wMq0hi5VoklBjLOlUn92vm7kBfEW+Wg+1dkXB
         Q1uOSqLj4NKOWREkuOTfRYMEXMePqocjph44BeyI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 522A11286318;
        Fri,  9 Dec 2022 11:08:11 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dPlwnz8dVlRH; Fri,  9 Dec 2022 11:08:11 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B4D5E1286316;
        Fri,  9 Dec 2022 11:08:10 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: [PATCH 02/11] tpm: add buffer handling for TPM2B types
Date:   Fri,  9 Dec 2022 11:06:02 -0500
Message-Id: <20221209160611.30207-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Most complex TPM commands require appending TPM2B buffers to the
command body.  Since TPM2B types are essentially variable size arrays,
it makes it impossible to represent these complex command arguments as
structures and we simply have to build them up using append primitives
like these.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 71 +++++++++++++++++++++++++++++++++++---
 include/linux/tpm.h        |  3 ++
 2 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 4e6e8b281f6a..f1d48f22d4b4 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -7,17 +7,16 @@
 #include <linux/module.h>
 #include <linux/tpm.h>
 
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
 
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
@@ -29,17 +28,60 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
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
 void tpm_buf_destroy(struct tpm_buf *buf)
 {
 	free_page((unsigned long)buf->data);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_destroy);
 
+static void *tpm_buf_data(struct tpm_buf *buf)
+{
+	if (buf->flags & TPM_BUF_2B)
+		return buf->data + TPM_HEADER_SIZE;
+	return buf->data;
+}
+
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
 
@@ -56,7 +98,7 @@ void tpm_buf_append(struct tpm_buf *buf,
 		    unsigned int new_len)
 {
 	struct tpm_header *head = (struct tpm_header *) buf->data;
-	u32 len = tpm_buf_length(buf);
+	u32 len = be32_to_cpu(head->length);
 
 	/* Return silently if overflow has already happened. */
 	if (buf->flags & TPM_BUF_OVERFLOW)
@@ -94,3 +136,22 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
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
index 150b39b6190e..f2d4dab6d832 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -300,6 +300,7 @@ struct tpm_header {
 
 enum tpm_buf_flags {
 	TPM_BUF_OVERFLOW	= BIT(0),
+	TPM_BUF_2B		= BIT(1),
 };
 
 struct tpm_buf {
@@ -324,6 +325,7 @@ struct tpm2_hash {
 
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_2b(struct tpm_buf *buf);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
@@ -332,6 +334,7 @@ void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.35.3

