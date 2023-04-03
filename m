Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D46D53D5
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Apr 2023 23:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDCVpu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjDCVpr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 17:45:47 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D30E3C00;
        Mon,  3 Apr 2023 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680558284;
        bh=xhGaZB4YFV6zC6SGThVeuIUNKTAptkmhvTsqa4x9xn8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=MHBFP9SQyJhrHzUGZuH3By2AeoV56QbAnSfbxkPXg1NdvSH+sWG3IWaDNKHAZiONN
         EDUUO1VjB8Pr+G0t7XEWsZzJqgAPrCHfX1j2n6j+SvmHMIgwDT3VoU94a46PXRL6Ny
         H56E+SQtzXCiZrhRnjTEahwdpYz8vcuGGQcJsM+8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 32D5F128020F;
        Mon,  3 Apr 2023 17:44:44 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PPiXsT5CcwJH; Mon,  3 Apr 2023 17:44:44 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 929F11280097;
        Mon,  3 Apr 2023 17:44:43 -0400 (EDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 03/13] tpm: add kernel doc to buffer handling functions
Date:   Mon,  3 Apr 2023 17:39:53 -0400
Message-Id: <20230403214003.32093-4-James.Bottomley@HansenPartnership.com>
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

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index baa4866d53a9..3351db515e6b 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -6,6 +6,16 @@
 #include <linux/module.h>
 #include <linux/tpm.h>
 
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
 int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
 	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
@@ -18,6 +28,16 @@ int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_init);
 
+/**
+ * tpm_buf_reset - reset an initialized TPM command buffer
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ * @tag: command tag
+ * @ordinal: command ordinal
+ *
+ * Repurposes an already allocated @buf for a new command.
+ * Identical to calling tpm_buf_destroy/tpm_buf_init except it keeps
+ * the 4k allocated page and cannot fail.
+ */
 void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
 	struct tpm_header *head = (struct tpm_header *) buf->data;
@@ -28,12 +48,24 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_reset);
 
+/**
+ * tpm_buf_destroy - destroy an initialized TPM command buffer
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ *
+ * Frees the memory allocated to @buf.
+ */
 void tpm_buf_destroy(struct tpm_buf *buf)
 {
 	free_page((unsigned long)buf->data);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_destroy);
 
+/**
+ * tpm_buf_length - get the current length of a TPM command
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ *
+ * @return: the current length of the @buf.
+ */
 u32 tpm_buf_length(struct tpm_buf *buf)
 {
 	struct tpm_header *head = (struct tpm_header *)buf->data;
@@ -42,6 +74,15 @@ u32 tpm_buf_length(struct tpm_buf *buf)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_length);
 
+/**
+ * tpm_buf_append - append data to an initialized TPM command buffer
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ * @new_data: pointer to the added data
+ * @new_len: length of the added data
+ *
+ * Appends @new_data to the end of the current @buf and updates the
+ * length.
+ */
 void tpm_buf_append(struct tpm_buf *buf,
 		    const unsigned char *new_data,
 		    unsigned int new_len)
@@ -64,12 +105,28 @@ void tpm_buf_append(struct tpm_buf *buf,
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append);
 
+/**
+ * tpm_buf_append_u8 - append u8 data to an initialized TPM command buffer
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ * @value: the value of the data to append
+ *
+ * Appends @value as a byte to the end of the current @buf and updates
+ * the length.
+ */
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value)
 {
 	tpm_buf_append(buf, &value, 1);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u8);
 
+/**
+ * tpm_buf_append_u16 - append u16 data to an initialized TPM command buffer
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ * @value: the value of the data to append
+ *
+ * Appends @value as a big endian short to the end of the current @buf
+ * and updates the length.
+ */
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
 {
 	__be16 value2 = cpu_to_be16(value);
@@ -78,6 +135,14 @@ void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_u16);
 
+/**
+ * tpm_buf_append_u32 - append u32 data to an initialized TPM command buffer
+ * @buf: pointer to a tpm_buf structure (usually on stack)
+ * @value: the value of the data to append
+ *
+ * Appends @value as a big endian word to the end of the current @buf
+ * and updates the length.
+ */
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
 {
 	__be32 value2 = cpu_to_be32(value);
-- 
2.35.3

