Return-Path: <linux-integrity+bounces-5406-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CE0A6D88B
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D3516C6D8
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08D25DCF6;
	Mon, 24 Mar 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELTsJj9n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82325E445
	for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813233; cv=none; b=Sk5506oWL7CDGU59VQxigMEWpM412rn6O7A2pI3fjS5HsiedH2ztwWOXxh1v0CK4ORJjg72cNbU8tKALVhQEWBsPoQv7Mmm4SUIlGnxVLRAIm7S85N9UDCiYPHGKhqEV2XLOj90A4+XzUsr5FkCao/D4ON3dZszqqd18lDlXaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813233; c=relaxed/simple;
	bh=VGky2X7R0BqRkgR/rmPA6Zn9o6b4Oc0GAhRciwiCiGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzYDjhPbMN9FkTAGO+4ZICObGUZcrnbU3MN2iZwPFQjwrWe1QT4KhSAHB8E0038qxBz38yH5RBFzOIXGr+THsHl2Jt/Xz/MwEqd9XCoNfFjKOmMO1G39Z/cVRjRt4NGWrpRP8/EHRhQGS+lECrvHR+/u205FSsmSeUeta08tDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELTsJj9n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742813230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3ofNKkLlwWze0oEt1bz6Y5Zm/5JtrpuEhbONzfCg84=;
	b=ELTsJj9ncYYMIAXJBQ0foLXTJp4kwwKlGiX2xwKDqN5+fe8Gm8aFJTjbkO1ftcDgJut3B7
	COguOudgNtRMBba33SqDml/TQF0EL4uI9+PPe3oR5JeQ2OFL06S6Fqqw6pqYm7CMnp98AD
	ZSG18w7euJWO/xqRuP+ERK+wIPn+udM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-alZB5jOVNYG56-IwzqLnTw-1; Mon, 24 Mar 2025 06:47:08 -0400
X-MC-Unique: alZB5jOVNYG56-IwzqLnTw-1
X-Mimecast-MFC-AGG-ID: alZB5jOVNYG56-IwzqLnTw_1742813228
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39abdadb0f0so542924f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 03:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813227; x=1743418027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3ofNKkLlwWze0oEt1bz6Y5Zm/5JtrpuEhbONzfCg84=;
        b=JXe1mh0MSecJ6XGGYvIPOqwiy6t+fTK7PppykaDYpiXNYyaInJonq+87nrg25p/q/+
         LcGkhqSst74sk9mz/elCGpIM5C3FjWBLliVKKgJFxUJxxHFG0QUvCT1zi+GSUkWh4jo3
         HddekOikMijGSSfEI8oSZsZ2gjLUSfl961Re3MCKlCWJ31YzTwPRAyEj9FIU4XRJW9aB
         nY5evXOoI7OSR6C/6l17eGgEEXAXTiFiHCoUe3I/XczoWrnA7uBeY1J9lR49j/ZzuLKd
         RJdGMZMGimDH2WgVXu7vKtIU7i1Jzq3YZCzfpKjSJuNugFYApNzsyWYzE82L01y4GU9V
         leDg==
X-Forwarded-Encrypted: i=1; AJvYcCXTcz6e0dZoD8lcvybbxawzaNBsMcHbIu1W0H+yprosV1HqVRRWR3Hxy7P6dBAodepTyJgC64D5yHQjP6ntRxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzhtx1NhhIk8ZaGarBQdKhDYYDVE38OA8I8Ddk24AmmPmCBRDF
	c4hJqZDeaAO0hViavt9Wj5H4XD18IIWt1I0p0VjJ6LTQXliKyJyB7tfcHbQKl8uBADLFniEZUyj
	1xCzbrtvXma+p6a+S9iIKEOupOTU3fe9bKDg01114XT3p17dDi8rhFKrK+/Pt1KZh/w==
X-Gm-Gg: ASbGncuyxRnycYqHUCg+gKitMjTfzaPg52GevTFimoZGW9WXfH+xzVB+h51fZ4ltLsC
	ZI0M5mfdaJ1kUCcWNc8v5z0aXT5FfpBGDR+Qy3pprj8ZF7IC2x8UZh6oZZw/+tR+VFMPVXvakfg
	s6r865XGdSYf1dutUALW+Q/RYwuIz9oNQDJ0TQZValtBuuWcm4sCLDOdVZF1KxbbEvpzncLkQhi
	2mEqJdP1QyuRKUPZSL48C38XlZhlPS3Da3sNO8UsNHt194s2fqa9Fudjz2yWCfg9Azkf2B41mr4
	D6EbhAl8MiUWW4/8nTyPUy0U2XT364WQ+L7eMbdK+AP/XbBqhH/kNEfeE4WD277EqA==
X-Received: by 2002:a5d:6da1:0:b0:391:31c8:ba58 with SMTP id ffacd0b85a97d-3997f8eefe9mr9222461f8f.10.1742813227534;
        Mon, 24 Mar 2025 03:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeA29Zi2YUeUijn9LA3N9z6ryWBOskTdw0WtG15UsubeQ8FdCLGLqSLeIH79wulVpz8VsxXQ==
X-Received: by 2002:a5d:6da1:0:b0:391:31c8:ba58 with SMTP id ffacd0b85a97d-3997f8eefe9mr9222423f8f.10.1742813226949;
        Mon, 24 Mar 2025 03:47:06 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b4ce9sm10712355f8f.53.2025.03.24.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:47:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 2/4] svsm: add header with SVSM_VTPM_CMD helpers
Date: Mon, 24 Mar 2025 11:46:47 +0100
Message-ID: <20250324104653.138663-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324104653.138663-1-sgarzare@redhat.com>
References: <20250324104653.138663-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by
the AMD SVSM spec [1].

The vTPM protocol follows the Official TPM 2.0 Reference Implementation
(originally by Microsoft, now part of the TCG) simulator protocol.

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- used svsm_vtpm_ prefix consistently [Jarkko]
- removed __packed where not needed [Jarkko]
- expanded headers to avoid obfuscation [Jarkko]
- used `buf` instead of `inbuf`/`outbuf` [Jarkko]
- added more documentation quoting the specification
- removed TPM_* macros since we only use TPM_SEND_COMMAND in one place
  and don't want dependencies on external headers, but put the value
  directly as specified in the AMD SVSM specification
- header renamed in tpm_svsm.h so it will fall under TPM DEVICE DRIVER
  section [Borislav, Jarkko]
v3:
- renamed header and prefix to make clear it's related to the SVSM vTPM
  protocol
- renamed fill/parse functions [Tom]
- removed link to the spec because those URLs are unstable [Borislav]
---
 include/linux/tpm_svsm.h | 149 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 include/linux/tpm_svsm.h

diff --git a/include/linux/tpm_svsm.h b/include/linux/tpm_svsm.h
new file mode 100644
index 000000000000..38e341f9761a
--- /dev/null
+++ b/include/linux/tpm_svsm.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ *
+ * Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by the
+ * AMD SVSM spec [1].
+ *
+ * The vTPM protocol follows the Official TPM 2.0 Reference Implementation
+ * (originally by Microsoft, now part of the TCG) simulator protocol.
+ *
+ * [1] "Secure VM Service Module for SEV-SNP Guests"
+ *     Publication # 58019 Revision: 1.00
+ */
+#ifndef _TPM_SVSM_H_
+#define _TPM_SVSM_H_
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define SVSM_VTPM_MAX_BUFFER		4096 /* max req/resp buffer size */
+
+/**
+ * struct svsm_vtpm_request - Generic request for single word command
+ * @cmd:	The command to send
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 15: vTPM Common Request/Response Structure
+ *     Byte      Size       In/Out    Description
+ *     Offset    (Bytes)
+ *     0x000     4          In        Platform command
+ *                          Out       Platform command response size
+ */
+struct svsm_vtpm_request {
+	u32 cmd;
+};
+
+/**
+ * struct svsm_vtpm_response - Generic response
+ * @size:	The response size (zero if nothing follows)
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 15: vTPM Common Request/Response Structure
+ *     Byte      Size       In/Out    Description
+ *     Offset    (Bytes)
+ *     0x000     4          In        Platform command
+ *                          Out       Platform command response size
+ *
+ * Note: most TCG Simulator commands simply return zero here with no indication
+ * of success or failure.
+ */
+struct svsm_vtpm_response {
+	u32 size;
+};
+
+/**
+ * struct svsm_vtpm_cmd_request - Structure for a TPM_SEND_COMMAND request
+ * @cmd:	The command to send (must be TPM_SEND_COMMAND)
+ * @locality:	The locality
+ * @buf_size:	The size of the input buffer following
+ * @buf:	A buffer of size buf_size
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 16: TPM_SEND_COMMAND Request Structure
+ *     Byte      Size       Meaning
+ *     Offset    (Bytes)
+ *     0x000     4          Platform command (8)
+ *     0x004     1          Locality (must-be-0)
+ *     0x005     4          TPM Command size (in bytes)
+ *     0x009     Variable   TPM Command
+ *
+ * Note: the TCG Simulator expects @buf_size to be equal to the size of the
+ * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is returned.
+ */
+struct svsm_vtpm_cmd_request {
+	u32 cmd;
+	u8 locality;
+	u32 buf_size;
+	u8 buf[];
+} __packed;
+
+/**
+ * struct svsm_vtpm_cmd_response - Structure for a TPM_SEND_COMMAND response
+ * @buf_size:	The size of the output buffer following
+ * @buf:	A buffer of size buf_size
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 17: TPM_SEND_COMMAND Response Structure
+ *     Byte      Size       Meaning
+ *     Offset    (Bytes)
+ *     0x000     4          Response size (in bytes)
+ *     0x004     Variable   Response
+ */
+struct svsm_vtpm_cmd_response {
+	u32 buf_size;
+	u8 buf[];
+};
+
+/**
+ * svsm_vtpm_cmd_request_fill() - Fill a TPM_SEND_COMMAND request to be sent to SVSM
+ * @req: The struct svsm_vtpm_cmd_request to fill
+ * @locality: The locality
+ * @buf: The buffer from where to copy the payload of the command
+ * @len: The size of the buffer
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static inline int
+svsm_vtpm_cmd_request_fill(struct svsm_vtpm_cmd_request *req, u8 locality,
+			   const u8 *buf, size_t len)
+{
+	if (len > SVSM_VTPM_MAX_BUFFER - sizeof(*req))
+		return -EINVAL;
+
+	req->cmd = 8; /* TPM_SEND_COMMAND */
+	req->locality = locality;
+	req->buf_size = len;
+
+	memcpy(req->buf, buf, len);
+
+	return 0;
+}
+
+/**
+ * svsm_vtpm_cmd_response_parse() - Parse a TPM_SEND_COMMAND response received from SVSM
+ * @resp: The struct svsm_vtpm_cmd_response to parse
+ * @buf: The buffer where to copy the response
+ * @len: The size of the buffer
+ *
+ * Return: buffer size filled with the response on success, negative error
+ * code on failure.
+ */
+static inline int
+svsm_vtpm_cmd_response_parse(const struct svsm_vtpm_cmd_response *resp, u8 *buf,
+			     size_t len)
+{
+	if (len < resp->buf_size)
+		return -E2BIG;
+
+	if (resp->buf_size > SVSM_VTPM_MAX_BUFFER - sizeof(*resp))
+		return -EINVAL;  // Invalid response from the platform TPM
+
+	memcpy(buf, resp->buf, resp->buf_size);
+
+	return resp->buf_size;
+}
+
+#endif /* _TPM_SVSM_H_ */
-- 
2.49.0


