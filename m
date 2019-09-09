Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01AAD8C3
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfIIMSj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:18:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48110 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730794AbfIIMSj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:18:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 287C98EE180;
        Mon,  9 Sep 2019 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031519;
        bh=rK7SErmS+u2r4dEqSyXt5VTaa/HKONq5r+UsGRVWlH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VeQV0382xlgI4Q3wm3mUPJzuuToqOknJ+ZnGSCC9jnQVO66JTbjcDPeuusVxFYywE
         dLABLUgqJ3HzuV1ej9NoFTXJnVt3MZwoOYprjEtldvvUXZUcutAcLhIEWP9f5KKZjG
         rI3h+VNbkfIC8g50J4HGzkwhraz5+r5MGl4MrGRg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kmCQNJupF_Gs; Mon,  9 Sep 2019 05:18:39 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E7F4D8EE105;
        Mon,  9 Sep 2019 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031519;
        bh=rK7SErmS+u2r4dEqSyXt5VTaa/HKONq5r+UsGRVWlH8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VeQV0382xlgI4Q3wm3mUPJzuuToqOknJ+ZnGSCC9jnQVO66JTbjcDPeuusVxFYywE
         dLABLUgqJ3HzuV1ej9NoFTXJnVt3MZwoOYprjEtldvvUXZUcutAcLhIEWP9f5KKZjG
         rI3h+VNbkfIC8g50J4HGzkwhraz5+r5MGl4MrGRg=
Message-ID: <1568031515.6613.31.camel@HansenPartnership.com>
Subject: [PATCH v6 02/12] tpm-buf: add handling for TPM2B types
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:18:35 +0100
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

Most complex TPM commands require appending TPM2B buffers to the
command body.  Since TPM2B types are essentially variable size arrays,
it makes it impossible to represent these complex command arguments as
structures and we simply have to build them up using append primitives
like these.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h     |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 9fa8a9cb0fdf..8c1ed8a14e01 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -8,6 +8,8 @@
 
 #include <linux/module.h>
 
+#include <asm/unaligned.h>
+
 static int __tpm_buf_init(struct tpm_buf *buf)
 {
 	buf->data_page = alloc_page(GFP_HIGHUSER);
@@ -46,6 +48,24 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_init);
 
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
 	kunmap(buf->data_page);
@@ -53,6 +73,13 @@ void tpm_buf_destroy(struct tpm_buf *buf)
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
@@ -116,3 +143,23 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
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
+
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 8c5b8bba60d2..7627917db345 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -292,6 +292,7 @@ struct tpm_buf {
 
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+int tpm_buf_init_2b(struct tpm_buf *buf);
 void tpm_buf_destroy(struct tpm_buf *buf);
 u32 tpm_buf_length(struct tpm_buf *buf);
 void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
@@ -299,6 +300,7 @@ void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
 
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
-- 
2.16.4

