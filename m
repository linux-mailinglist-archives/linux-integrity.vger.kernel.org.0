Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A142DAD8DB
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfIIMVr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:21:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48268 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfIIMVr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:21:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ECDC48EE180;
        Mon,  9 Sep 2019 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031706;
        bh=gqf6WgGq84ztgJ7EfhZXjh7m/VKvK9/wTfvOmBw2jeU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vGz2DLk7e1YbwHo12r8IJxFdbiuxfknWweuwVOantB4NQWifustgUAlpSr+H7VUn7
         pXYyiJO6IEQLRjy9YUBmN/WZNNScYGCebKnvCQPuf+yJSzm6Q96L6/b67QEPFfbW0S
         aPFkXAKJWxm3CW72MdbwNXedOy9Nd22hg6UqOEGk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fVOnH2bKexWG; Mon,  9 Sep 2019 05:21:46 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BC7B68EE105;
        Mon,  9 Sep 2019 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568031706;
        bh=gqf6WgGq84ztgJ7EfhZXjh7m/VKvK9/wTfvOmBw2jeU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vGz2DLk7e1YbwHo12r8IJxFdbiuxfknWweuwVOantB4NQWifustgUAlpSr+H7VUn7
         pXYyiJO6IEQLRjy9YUBmN/WZNNScYGCebKnvCQPuf+yJSzm6Q96L6/b67QEPFfbW0S
         aPFkXAKJWxm3CW72MdbwNXedOy9Nd22hg6UqOEGk=
Message-ID: <1568031703.6613.35.camel@HansenPartnership.com>
Subject: [PATCH v6 06/12] tpm-buf: add tpm_buf_parameters()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Sep 2019 13:21:43 +0100
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
 drivers/char/tpm/tpm.h     |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index f56350123a08..a5d793d8180d 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -190,3 +190,13 @@ u32 tpm_get_inc_u32(const u8 **ptr)
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
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index ebead8e4c3fe..c88eee6376e4 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -311,6 +311,8 @@ u8 tpm_get_inc_u8(const u8 **ptr);
 u16 tpm_get_inc_u16(const u8 **ptr);
 u32 tpm_get_inc_u32(const u8 **ptr);
 
+u8 *tpm_buf_parameters(struct tpm_buf *buf);
+
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-- 
2.16.4

