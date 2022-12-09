Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4764863E
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Dec 2022 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLIQI4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Dec 2022 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIQIz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Dec 2022 11:08:55 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485995FBD;
        Fri,  9 Dec 2022 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670602133;
        bh=qofRxaNJD3RRJqDlfi5G8exduyfqEZhmC9bEyj3GaRw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=hWhQDhHbaWRr76RzGFDbdQPPNx3/HiQMTRTgf1gaN34GjgCG/wxz0rCCHn4IKHlJI
         3Vt22Jzp7bBqL61kZa/MfQfVUs9fIMjOwsoZPCBsFz5S75urhxnSJWHjmib7l6MXin
         lUnGTLTlsN8gvVMknKAA35DM/n1cY9Kzqt0YwI/g=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD94C128631F;
        Fri,  9 Dec 2022 11:08:53 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m_2GeTIuwY8p; Fri,  9 Dec 2022 11:08:53 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2E9B1128631C;
        Fri,  9 Dec 2022 11:08:53 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: [PATCH 04/11] tpm: add buffer function to point to returned parameters
Date:   Fri,  9 Dec 2022 11:06:04 -0500
Message-Id: <20221209160611.30207-5-James.Bottomley@HansenPartnership.com>
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
index 046b00bf7a81..b054aa2fc84b 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -184,3 +184,13 @@ u32 tpm_get_inc_u32(const u8 **ptr)
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

