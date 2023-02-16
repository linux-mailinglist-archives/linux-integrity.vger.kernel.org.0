Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB98699D7A
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 21:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBPUQy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 15:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBPUQx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 15:16:53 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE554C6D7;
        Thu, 16 Feb 2023 12:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676578612;
        bh=C0MGC7VsBgPg+6qRsvVHZVK5AN1MRr55IgymOILL5+Q=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=s0+rxjSe0at5zBxQevZPRXNeImNm0rUv+KFLA/KHRx2B8b6/LtJJqxAKcQmywQrUb
         Liix325QLbPU+MerVFkdeHTc8+lq5g9f1w3ECwQu4KwmCQxmMCpOqo+SPWIe2AC5WJ
         5IzwEHUovwwalBdRon0dwDkoJ10XUwqhXdN/vjBI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A8EA91286F45;
        Thu, 16 Feb 2023 15:16:52 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fDXLGMWlVVjB; Thu, 16 Feb 2023 15:16:52 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2F0311286E47;
        Thu, 16 Feb 2023 15:16:52 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 05/12] tpm: add buffer function to point to returned parameters
Date:   Thu, 16 Feb 2023 15:14:03 -0500
Message-Id: <20230216201410.15010-6-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
References: <20230216201410.15010-1-James.Bottomley@HansenPartnership.com>
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

Introducing encryption sessions changes where the return parameters
are located in the buffer because if a return session is present
they're 4 bytes beyond the header with those 4 bytes showing the
parameter length.  If there is no return session, then they're in the
usual place immediately after the header.  The tpm_buf_parameters()
encapsulates this calculation and should be used everywhere
&buf.data[TPM_HEADER_SIZE] is used now

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 10 ++++++++++
 include/linux/tpm.h        |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index b76158f9bcd0..2518b675e866 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -183,3 +183,13 @@ u32 tpm_get_inc_u32(const u8 **ptr)
 	return val;
 }
 EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
+
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
index f7cff1d114b0..fa8d1f932c0f 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -339,6 +339,8 @@ u8 tpm_get_inc_u8(const u8 **ptr);
 u16 tpm_get_inc_u16(const u8 **ptr);
 u32 tpm_get_inc_u32(const u8 **ptr);
 
+u8 *tpm_buf_parameters(struct tpm_buf *buf);
+
 /*
  * Check if TPM device is in the firmware upgrade mode.
  */
-- 
2.35.3

