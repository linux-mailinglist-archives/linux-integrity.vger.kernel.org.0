Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041F72A18CA
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Oct 2020 17:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgJaQq3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 31 Oct 2020 12:46:29 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21170 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgJaQq3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 31 Oct 2020 12:46:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604162692; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MuT1H7R1msdEtTGRZf7Utqd5j+mHxR6z8xVZYYyYec9JC+wPObexnW4lX4EEWk4axNFD4mQxRFlAG9nOwnvldiqeApElJCVZBxwtOv7Y4rzIkJQ6owNP7vvWP5xlfs1kiz96sRIzlJTeho/ceXi8u3SAOhyIEJaip1E8fMsIH3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1604162692; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=Ov4HqbVxqz4+uy5z83Tkf03e/irNrqpDalTVQ5s9l34=; 
        b=BNQ2y3MCH1vOf9Qdw1gSJAnOWn0DQ5W+Vbe3pHcHFN9uh0zM+vhsF0lbnnI8fO/wCOhQiUO8jM13A2X8nT5zepmc4kIzN6AjfuhZ7nZCsaburapUPFYzkXcWct8868J0Ma+v/OKPq8Uwc7z9P77DMn7BK3LcOSFVzPtsAeZrHAk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604162692;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=Ov4HqbVxqz4+uy5z83Tkf03e/irNrqpDalTVQ5s9l34=;
        b=mcQP/pAKqX9TkdjycydITvL1uTgPxBZGkBYqJb2ocbkR5E0Hdsk7eDlokYWHjm5y
        9hcbhZbHytk45JWKbtZ78YcfjwjvE3M0bZqHnMDI8NTRFiIpw/gS6YNmdoL5atnqjrK
        gkCi+0A4ccSpwvCG56lghwLuaW8623ajiI36ZvDk=
Received: from sisyou.hme. (c-73-129-147-140.hsd1.md.comcast.net [73.129.147.140]) by mx.zohomail.com
        with SMTPS id 1604162690619341.7567779595297; Sat, 31 Oct 2020 09:44:50 -0700 (PDT)
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        jarkko.sakkinen@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 3/4] tpm: Conditionally use static buffer in TPM buffer management
Date:   Sat, 31 Oct 2020 12:51:21 -0400
Message-Id: <20201031165122.21539-4-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201031165122.21539-1-dpsmith@apertussolutions.com>
References: <20201031165122.21539-1-dpsmith@apertussolutions.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Memory management calls cannot be made in the compressed kernel
environment to dynamically allocate TPM buffer space. For the Secure
Launch early PCR extend code, use a static buffer instead.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/tpm_buffer.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/tpm_buffer.h b/include/linux/tpm_buffer.h
index 8144a52fbc0a..c9482edf6618 100644
--- a/include/linux/tpm_buffer.h
+++ b/include/linux/tpm_buffer.h
@@ -18,6 +18,10 @@
 #ifndef __LINUX_TPM_BUFFER_H__
 #define __LINUX_TPM_BUFFER_H__
 
+#ifdef COMPRESSED_KERNEL
+static u8 _tpm_buffer[PAGE_SIZE] = {0};
+#endif
+
 struct tpm_header {
 	__be16 tag;
 	__be32 length;
@@ -52,7 +56,11 @@ static inline void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
 
 static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 {
+#ifdef COMPRESSED_KERNEL
+	buf->data = _tpm_buffer;
+#else
 	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
+#endif
 	if (!buf->data)
 		return -ENOMEM;
 
@@ -63,7 +71,9 @@ static inline int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
 
 static inline void tpm_buf_destroy(struct tpm_buf *buf)
 {
+#ifndef COMPRESSED_KERNEL
 	free_page((unsigned long)buf->data);
+#endif
 }
 
 static inline u32 tpm_buf_length(struct tpm_buf *buf)
@@ -92,7 +102,9 @@ static inline void tpm_buf_append(struct tpm_buf *buf,
 		return;
 
 	if ((len + new_len) > PAGE_SIZE) {
+#ifndef COMPRESSED_KERNEL
 		WARN(1, "tpm_buf: overflow\n");
+#endif
 		buf->flags |= TPM_BUF_OVERFLOW;
 		return;
 	}
-- 
2.11.0

