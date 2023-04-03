Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E66D53E3
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Apr 2023 23:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjDCVrC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Apr 2023 17:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjDCVqz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Apr 2023 17:46:55 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B44228;
        Mon,  3 Apr 2023 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1680558391;
        bh=lBk30/nfxjrdxyexVv9SSrkugaHMY83rfNn7hln8PEI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=quqSKaFJXKuX/U3MZ6d4/uwnzPA8991aITY6rjKyPDBv6TbQDoFlyHxpdCFE/7FQR
         Qt4wHlq7AFtbroKwF26KTMfSYt8i4MGYuQTAIQCg1eIOOJlLHoC0obuGaFyYaSulA6
         6nw8Z2qEQJ777jyI0Dp+QjDWBxghHEnTN8xefZf8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F136B128020F;
        Mon,  3 Apr 2023 17:46:31 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id w68Uiq4_DCH2; Mon,  3 Apr 2023 17:46:31 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6F0091280097;
        Mon,  3 Apr 2023 17:46:31 -0400 (EDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 06/13] tpm: add buffer function to point to returned parameters
Date:   Mon,  3 Apr 2023 17:39:56 -0400
Message-Id: <20230403214003.32093-7-James.Bottomley@HansenPartnership.com>
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

Introducing encryption sessions changes where the return parameters
are located in the buffer because if a return session is present
they're 4 bytes beyond the header with those 4 bytes showing the
parameter length.  If there is no return session, then they're in the
usual place immediately after the header.  The tpm_buf_parameters()
encapsulates this calculation and should be used everywhere
&buf.data[TPM_HEADER_SIZE] is used now.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v4: add kdoc
---
 drivers/char/tpm/tpm-buf.c | 27 +++++++++++++++++++++++++++
 include/linux/tpm.h        |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index da0f6e725c3f..d107321bcdff 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -277,3 +277,30 @@ u32 tpm_get_inc_u32(const u8 **ptr)
 	return val;
 }
 EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
+
+static u16 tpm_buf_tag(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return be16_to_cpu(head->tag);
+}
+
+/**
+ * tpm_buf_parameters - return the parameters area of the tpm_buf
+ * @buf: tpm_buf to use
+ *
+ * Where the parameters are located depends on the tag of a TPM
+ * command. Evaluate this and return a pointer to the first byte of
+ * the parameters area.
+ *
+ * @return: pointer to parameters area
+ */
+u8 *tpm_buf_parameters(struct tpm_buf *buf)
+{
+	int offset = TPM_HEADER_SIZE;
+
+	if (tpm_buf_tag(buf) == TPM2_ST_SESSIONS)
+		offset += 4;
+
+	return &buf->data[offset];
+}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 845eadfed715..d2fea2afd37c 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -340,6 +340,8 @@ u8 tpm_get_inc_u8(const u8 **ptr);
 u16 tpm_get_inc_u16(const u8 **ptr);
 u32 tpm_get_inc_u32(const u8 **ptr);
 
+u8 *tpm_buf_parameters(struct tpm_buf *buf);
+
 /*
  * Check if TPM device is in the firmware upgrade mode.
  */
-- 
2.35.3

