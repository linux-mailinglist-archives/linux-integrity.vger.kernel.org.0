Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE51AD8CA
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbfIIMTW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:19:22 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48156 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387878AbfIIMTV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:19:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BC08A8EE180;
        Mon,  9 Sep 2019 05:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031561;
        bh=NhdJcH88HXPtKCQlYFRa1Gg4xxlsRdGYmmY7MPRH0nU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cnn4dIOQMm279oJ7reKFRYk9TNKxq7lrSRrpEDhlKfkoZcMtjgEcCJ7hFEao7GDy/
         fbBxMlxqoxOSTNg1VpNcuFrei4Fa431y08y1wgKPOya8hZ6VA+c0qpKQHHN9rPQLB5
         0M69tZul58NaYmOWQZ/zXaRQEuAdMnT7RYu853N4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qcQsd55ZyDDh; Mon,  9 Sep 2019 05:19:21 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8C2B88EE105;
        Mon,  9 Sep 2019 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031561;
        bh=NhdJcH88HXPtKCQlYFRa1Gg4xxlsRdGYmmY7MPRH0nU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cnn4dIOQMm279oJ7reKFRYk9TNKxq7lrSRrpEDhlKfkoZcMtjgEcCJ7hFEao7GDy/
         fbBxMlxqoxOSTNg1VpNcuFrei4Fa431y08y1wgKPOya8hZ6VA+c0qpKQHHN9rPQLB5
         0M69tZul58NaYmOWQZ/zXaRQEuAdMnT7RYu853N4=
Message-ID: <1568031558.6613.32.camel@HansenPartnership.com>
Subject: [PATCH v6 03/12] tpm-buf: add cursor based functions for response
 parsing
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:19:18 +0100
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

It's very convenient when parsing responses to have a cursor you
simply move over the response extracting the data.  Add such cursor
functions for the TPM unsigned integer types.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-buf.c | 26 ++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h     |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 8c1ed8a14e01..553adb84b0ac 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -163,3 +163,29 @@ void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
 
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
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7627917db345..d942188debc9 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -302,6 +302,10 @@ void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
 
+u8 tpm_get_inc_u8(const u8 **ptr);
+u16 tpm_get_inc_u16(const u8 **ptr);
+u32 tpm_get_inc_u32(const u8 **ptr);
+
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
 extern dev_t tpm_devt;
-- 
2.16.4

