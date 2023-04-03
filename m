Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FDC6D53E1
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Apr 2023 23:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjDCVqf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 17:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjDCVq3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 17:46:29 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BE5274;
        Mon,  3 Apr 2023 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680558360;
        bh=XQXN2ZEyIuYVXiWQNjgjx2wbH+r4xDxTAczIzP3mGQo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=w262dazJxRVKnNZHet1TFbv5sw7f/QqCYdNQcmjDPCpVAg3LyIxe4rpNCNq4LTFO1
         gLlzeloKqadyyf1ZoZ6V/Qj2W1xt8WEHlwtq+qmbvhs5qdK6IC/4aSqsZmeGoHzGCb
         AxLVKLkG1HXT7uyn4mGQoya9L3Ia88y2pPFTxdpc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 16C341280097;
        Mon,  3 Apr 2023 17:46:00 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PCU0XsZzyen4; Mon,  3 Apr 2023 17:46:00 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 85505128020F;
        Mon,  3 Apr 2023 17:45:59 -0400 (EDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 05/13] tpm: add cursor based buffer functions for response parsing
Date:   Mon,  3 Apr 2023 17:39:55 -0400
Message-Id: <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
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

Extracting values from returned TPM buffers can be hard.  Add cursor
based (moving poiner) functions that make it easier to extract TPM
returned values from a buffer.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v4: add kernel doc and reword commit
---
 drivers/char/tpm/tpm-buf.c | 48 ++++++++++++++++++++++++++++++++++++++
 include/linux/tpm.h        |  3 +++
 2 files changed, 51 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index b7e42fb6266c..da0f6e725c3f 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -6,6 +6,8 @@
 #include <linux/module.h>
 #include <linux/tpm.h>
 
+#include <asm/unaligned.h>
+
 static int __tpm_buf_init(struct tpm_buf *buf)
 {
 	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
@@ -229,3 +231,49 @@ void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
 	tpm_buf_reset_int(tpm2b);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
+
+/* functions for unmarshalling data and moving the cursor */
+
+/**
+ * tpm_get_inc_u8 - read a u8 and move pointer beyond it
+ * @ptr: pointer to pointer
+ *
+ * @return: value read
+ */
+u8 tpm_get_inc_u8(const u8 **ptr)
+{
+	return *((*ptr)++);
+}
+EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
+
+/**
+ * tpm_get_inc_u16 - read a u16 and move pointer beyond it
+ * @ptr: pointer to pointer
+ *
+ * @return: value read (converted from big endian)
+ */
+u16 tpm_get_inc_u16(const u8 **ptr)
+{
+	u16 val;
+
+	val = get_unaligned_be16(*ptr);
+	*ptr += sizeof(val);
+	return val;
+}
+EXPORT_SYMBOL_GPL(tpm_get_inc_u16);
+
+/**
+ * tpm_get_inc_u32 - read a u32 and move pointer beyond it
+ * @ptr: pointer to pointer
+ *
+ * @return: value read (converted from big endian)
+ */
+u32 tpm_get_inc_u32(const u8 **ptr)
+{
+	u32 val;
+
+	val = get_unaligned_be32(*ptr);
+	*ptr += sizeof(val);
+	return val;
+}
+EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 76d495cb5b08..845eadfed715 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -336,6 +336,9 @@ void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
+u8 tpm_get_inc_u8(const u8 **ptr);
+u16 tpm_get_inc_u16(const u8 **ptr);
+u32 tpm_get_inc_u32(const u8 **ptr);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.35.3

