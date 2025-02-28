Return-Path: <linux-integrity+bounces-5018-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FADA49FE7
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F35F7A244A
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05327426B;
	Fri, 28 Feb 2025 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuXaXjaU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EE27424E
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762482; cv=none; b=fDXGD2l3YGqHuV+O7dvuGIqZKgbxV3V86+wg36kbvcq50pv4vBi3bRZt/XatyFseRxyYTY6b3zGTjzafJJ4xxf2ZjM49EODZkYfgrtqfUuICR/MOQ3C3oBHExSYh7LY40borA9vRk0n/LBK4keY8HOdqd38BvPST5Xju3bvM3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762482; c=relaxed/simple;
	bh=Ksa1M2URKta/PhoGiy4gircs0cKYJG4eWuTkZ5ZKvjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXXe/Sn4mPRjVzutSEoYwkIPd/ouDnYP1pIA4EgxmNrq1tG1QeVFYfXY6D9qqudL02uLLdLa1esQUdcgrKSCL1TDYj0sBYJDsuaxgkAwwuDEh0htVL/NrfjzHCHIBjtjl5NdNKnJPlN7SsBjvJ/RhZ84qdv4yeiYk0HF77BwdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuXaXjaU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nS7fF8L8t1+avyJ6pviS0kCFZYZceBM1sa3c81ODJY=;
	b=CuXaXjaUzd0AovkzlQyY/ndgwpI7C9YyTJt1YoCNsLIVTD4d5sSSKWe1+7bMpuI+CJRy9r
	pza1kZo1+zyliFeGCTRsMSA/jcDrjyDI6aszTtsRuEMTQ4bx12EHEvtxSq6QkUDnxFewo7
	erXpOy3cOXJJ9HCpt5zg73fif3qmLNU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-prIvXXCBPdmztLnlg0z8Yw-1; Fri, 28 Feb 2025 12:07:57 -0500
X-MC-Unique: prIvXXCBPdmztLnlg0z8Yw-1
X-Mimecast-MFC-AGG-ID: prIvXXCBPdmztLnlg0z8Yw_1740762476
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c489babso13789635e9.1
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 09:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762476; x=1741367276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nS7fF8L8t1+avyJ6pviS0kCFZYZceBM1sa3c81ODJY=;
        b=Bi2GRWzn2V7byTHuqnYywHjsQJl7/PXI+1rcLINQzZD+kCxpqQcxD1nTWTOEBkuQmu
         ps6rLyvYZg15SfaQmxXVhRHqi43G1SJuEIXAhhn0Fu2XP5luosbYzg5mTnDUS9FYolTs
         ZNo/7BarU8FcKsUPAAqyENELhQnT7I0uDjKENV/9L9/0VioLD+8WLY/gOQlTuo12/Rqk
         r7zmAvNy+k38aZffM4180L61VvEqupYkf82zYlxNVVEUQvI/rBecJWTW0C7z+G5att4t
         tHFp5cW1T/IegiGGclrMez2D0K5LOk29xQkv//gYCq2hzWJf6/r8k42bIqSGMmBEl1MT
         AfwA==
X-Forwarded-Encrypted: i=1; AJvYcCWbQ2axrJw4RYHz/+GUI466me58qFH/pff1eCpNO8BFU61wVHovEOYjcHF3PI76Gz9WVzE1FRBUI0FlR7Jnz9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTudL9TOClDfaDWDXKWrjqwaYNFfJs/qXDndCWKIbhApqker51
	9h4KcAdPK8edlJDjX7bi4CYn0mWMLZfKQEzYnL+3Tzj2IC4mmNbyiBH1Olvnreob4hQl2HKppID
	GWxBGca7wSceZeIQwzRiDuBb0E+APvD4P/14v9hZKNAxMs71cTBJJsCGxDZwTZeYlxw==
X-Gm-Gg: ASbGncuDEs71zZhtRsnXp0H3Hz8GhjkzLIrXLCYIroahFKgTH+jHBwvC079XGhF+HlP
	Oc6b7Ow0v+g5Hq+rHJvWUhQt1O/LKnrz2Xz99bQUai2swiH6ewmX8sK1FjyoXha7hCvZd2kbZXk
	Bb0M9ztMSJKo5GbI4UQZjq/JcIZkgPrjWIqHwbR3EcZN5R4kBt0EOKPF4Nd5kUshX0wVxOaIO8D
	h6yHQfxSchEYVUKMzrt82OuiJXcWWMOjmPZBlBGk0Z5RHbBWpy0elUNtZASxTTP7jS3hRLZKYCj
	j8H/lJzTWC6fZH7+7r8e
X-Received: by 2002:a05:600c:1c25:b0:439:8340:637 with SMTP id 5b1f17b1804b1-43ba6774ba2mr41118205e9.30.1740762476032;
        Fri, 28 Feb 2025 09:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT5lVwEvi1NYBOm/4AGf7I1bPtCAZ2aMeaY+YrZA5HnzpATeQRyKTtPTEseLbhxBVQleI/AQ==
X-Received: by 2002:a05:600c:1c25:b0:439:8340:637 with SMTP id 5b1f17b1804b1-43ba6774ba2mr41117315e9.30.1740762475346;
        Fri, 28 Feb 2025 09:07:55 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm5841288f8f.55.2025.02.28.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:52 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ingo Molnar <mingo@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH v2 4/6] tpm: add interface to interact with devices based on TCG Simulator
Date: Fri, 28 Feb 2025 18:07:18 +0100
Message-ID: <20250228170720.144739-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is primarily designed to support an enlightened driver for the
AMD SVSM based vTPM, but it could be used by any TPM driver which
communicates with a TPM device implemented through the TCG TPM reference
implementation (https://github.com/TrustedComputingGroup/TPM)

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
James, Claudio are you fine with the Cdb, Sob?
The code is based to what was in the initial RFC, but I removed the
tpm_platform module, moved some code in the header, changed some names,
etc.
For these reasons I reset the author but added C-o-b.
Please, let me know if this is okay or if I need to do anything
else (reset the author, etc.)
---
 include/linux/tpm_tcgsim.h | 136 +++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 include/linux/tpm_tcgsim.h

diff --git a/include/linux/tpm_tcgsim.h b/include/linux/tpm_tcgsim.h
new file mode 100644
index 000000000000..bd5b123c393b
--- /dev/null
+++ b/include/linux/tpm_tcgsim.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ *
+ * Generic interface usable by TPM drivers interacting with devices
+ * implemented through the TCG Simulator.
+ */
+#ifndef _TPM_TCGSIM_H_
+#define _TPM_TCGSIM_H_
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+/*
+ * The current TCG Simulator TPM commands we support.  The complete list is
+ * in the TcpTpmProtocol header:
+ *
+ * https://github.com/TrustedComputingGroup/TPM/blob/main/TPMCmd/Simulator/include/TpmTcpProtocol.h
+ */
+
+#define TPM_SEND_COMMAND		8
+#define TPM_SIGNAL_CANCEL_ON		9
+#define TPM_SIGNAL_CANCEL_OFF		10
+/*
+ * Any platform specific commands should be placed here and should start
+ * at 0x8000 to avoid clashes with the TCG Simulator protocol.  They should
+ * follow the same self describing buffer format below.
+ */
+
+#define TPM_TCGSIM_MAX_BUFFER		4096 /* max req/resp buffer size */
+
+/**
+ * struct tpm_req - generic request header for single word command
+ *
+ * @cmd:	The command to send
+ */
+struct tpm_req {
+	u32 cmd;
+} __packed;
+
+/**
+ * struct tpm_resp - generic response header
+ *
+ * @size:	The response size (zero if nothing follows)
+ *
+ * Note: most TCG Simulator commands simply return zero here with no indication
+ * of success or failure.
+ */
+struct tpm_resp {
+	u32 size;
+} __packed;
+
+/**
+ * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND request
+ *
+ * @hdr:	The request header whit the command (must be TPM_SEND_COMMAND)
+ * @locality:	The locality
+ * @inbuf_size:	The size of the input buffer following
+ * @inbuf:	A buffer of size inbuf_size
+ *
+ * Note that TCG Simulator expects @inbuf_size to be equal to the size of the
+ * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is
+ * returned.
+ */
+struct tpm_send_cmd_req {
+	struct tpm_req hdr;
+	u8 locality;
+	u32 inbuf_size;
+	u8 inbuf[];
+} __packed;
+
+/**
+ * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND response
+ *
+ * @hdr:	The response header whit the following size
+ * @outbuf:	A buffer of size hdr.size
+ */
+struct tpm_send_cmd_resp {
+	struct tpm_resp hdr;
+	u8 outbuf[];
+} __packed;
+
+/**
+ * tpm_tcgsim_fill_send_cmd() - fill a struct tpm_send_cmd_req to be sent to the
+ * TCG Simulator.
+ * @req: The struct tpm_send_cmd_req to fill
+ * @locality: The locality
+ * @buf: The buffer from where to copy the payload of the command
+ * @len: The size of the buffer
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static inline int
+tpm_tcgsim_fill_send_cmd(struct tpm_send_cmd_req *req, u8 locality,
+			 const u8 *buf, size_t len)
+{
+	if (len > TPM_TCGSIM_MAX_BUFFER - sizeof(*req))
+		return -EINVAL;
+
+	req->hdr.cmd = TPM_SEND_COMMAND;
+	req->locality = locality;
+	req->inbuf_size = len;
+
+	memcpy(req->inbuf, buf, len);
+
+	return 0;
+}
+
+/**
+ * tpm_tcgsim_parse_send_cmd() - Parse a struct tpm_send_cmd_resp received from
+ * the TCG Simulator
+ * @resp: The struct tpm_send_cmd_resp to parse
+ * @buf: The buffer where to copy the response
+ * @len: The size of the buffer
+ *
+ * Return: buffer size filled with the response on success, negative error
+ * code on failure.
+ */
+static inline int
+tpm_tcgsim_parse_send_cmd(const struct tpm_send_cmd_resp *resp, u8 *buf,
+			  size_t len)
+{
+	if (len < resp->hdr.size)
+		return -E2BIG;
+
+	if (resp->hdr.size > TPM_TCGSIM_MAX_BUFFER - sizeof(*resp))
+		return -EINVAL;  // Invalid response from the platform TPM
+
+	memcpy(buf, resp->outbuf, resp->hdr.size);
+
+	return resp->hdr.size;
+}
+
+#endif /* _TPM_TCGSIM_H_ */
-- 
2.48.1


