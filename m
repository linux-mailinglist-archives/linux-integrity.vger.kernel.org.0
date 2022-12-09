Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A6F64863C
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Dec 2022 17:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLIQIi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 11:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLIQIh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 11:08:37 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08E2AD3;
        Fri,  9 Dec 2022 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670602116;
        bh=9alCt9sYrJcIcOuKqquVluEHMVh9XpoaIC4jh4q33MQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=cngxIJvfAQcFEacNQjdVavqUdQq88Z32nSFCEogasmkD7kWZjN1YIbVMEmUj56+yt
         c87dXINuKmu4XB9IM+TqcHSxNQKicgRLSCtTyVl0vsmaOKf00bl0ZPlhrOGbepNabc
         SUvx8Oda4E+RCChPlQ2lRZCnHQ/wpDdyqUiXXdF0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 421CB1286318;
        Fri,  9 Dec 2022 11:08:36 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8wpl4B6vd4Zt; Fri,  9 Dec 2022 11:08:36 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AFAAA1286316;
        Fri,  9 Dec 2022 11:08:35 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: [PATCH 03/11] tpm: add cursor based buffer functions for response parsing
Date:   Fri,  9 Dec 2022 11:06:03 -0500
Message-Id: <20221209160611.30207-4-James.Bottomley@HansenPartnership.com>
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

It's very convenient when parsing responses to have a cursor you
simply move over the response extracting the data.  Add such cursor
functions for the TPM unsigned integer types.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 29 +++++++++++++++++++++++++++++
 include/linux/tpm.h        |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index f1d48f22d4b4..046b00bf7a81 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/tpm.h>
 
+#include <asm/unaligned.h>
+
 static int __tpm_buf_init(struct tpm_buf *buf)
 {
 	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
@@ -155,3 +157,30 @@ void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
 	tpm_buf_reset_int(tpm2b);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
+
+/* functions for unmarshalling data and moving the cursor */
+u8 tpm_get_inc_u8(const u8 **ptr)
+{
+	return *((*ptr)++);
+}
+EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
+
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
index f2d4dab6d832..f7cff1d114b0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -335,6 +335,9 @@ void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
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

