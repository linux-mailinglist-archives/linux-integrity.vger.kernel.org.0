Return-Path: <linux-integrity+bounces-5768-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C937A84566
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F10A9A3B7E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE02857C7;
	Thu, 10 Apr 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DE8ir8AY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541928C5C7
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293097; cv=none; b=CkfIXgDtIylTTfExImCX/rbU49jQQX08lwoS8GmfRY8hkrfsDMj4SvC8UuapBxM9EOZEEnnA79PjXPpryJ7aEfF3uZQSl0S7TtcZStwU5wPmkrkoIoyPBuVrM53/KlABxXwHzj91TASTuPZ4poHV507GxjarojeBFKUsrxrC2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293097; c=relaxed/simple;
	bh=JanhuPR/iml68kEFk6VsdfPYwqYcdQYvtjajdTMi5bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0IO+2V1nzuq5iwp4U1KfQWlDsFRJGnxbXoYza0mXbgJh3ZtQeEzXIEAjnjEciimhM7MUX3P/3rGtqr88RSV4ifjGGxu7rNdIZ796zvUwEmNIBYsSX6nEdmoY/QhUZR6q8Sg/yUDk8qTBCJWxlGVE1cAjUOpAkDzTu1J1YQfDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DE8ir8AY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744293094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cwx8PB++1jPTpqj+0lA5MhEHp2F2B5hQ/5H2FoJu9E=;
	b=DE8ir8AY4zQElribE6WB5jfExzlMGS5uqmFtOhh5T4YnapP3OJ0bTmAdmAGEbc6odJKO4L
	Pu9mqsZ+0oza17fLJkjBksGOZnus3RVSMtLV3CsCQTbT/YBxN6bbJeLOrw7n/AaSG+W5DB
	fupe+JntKdw/y59quwn8+O7s147GzDQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-u9zlIOIENYe_MF2RbxciqQ-1; Thu, 10 Apr 2025 09:51:33 -0400
X-MC-Unique: u9zlIOIENYe_MF2RbxciqQ-1
X-Mimecast-MFC-AGG-ID: u9zlIOIENYe_MF2RbxciqQ_1744293092
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso4283395e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293092; x=1744897892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cwx8PB++1jPTpqj+0lA5MhEHp2F2B5hQ/5H2FoJu9E=;
        b=CCKM3VwsQkHh3v+eJB9nvcMzZRcPUCcswB5isVDN7CvzMwJR6ICyTCKmV3s3qNj0pj
         TO385qG/qLSVmDu38SQR4n0h/4eLW76bxbCazMrsErUUocvXoi+UMBhsdomvqwVxKXhV
         jyrjKM+SgRReA6syNV/4SDCd4AZ1jwbYhJtbfhnuIMCUA+OTBjBPjVsLy+/tqOyXF7qG
         R1BGmIOWysYG1GPjpjbGuCWFyOstwSnrqzVkY4mM4DZpsHMS5bKxRNBTnx0x3o0B9zAD
         5BUKXzzqNDczyxGZHxhvzNdIlg4f5iIeme91QevnU9SaG9xpyN9gzIlz8A3TcTeJnWUF
         oKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXCxb5l+bzZFI9VZzmFEGD/nVKagdYbmNS6mh+n/qsK9flz9j99L0jI5FA6k1bHnxoQka6Wxp+jrJ8qbqGNco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJV67dbL9cGmmW/Wfo8VbIYZWxosKo9TnlOxjuTScJeeemBhs
	n7W4ZMl24QgG57IzMH5Q/qyFXLk7e/hPUG+90uP5Z7KUdLiFVz3fLDU7wZUuqYrAW4Q2NBObE5U
	Q+IXHY3lEZrHqFFWvpO5zBYCf8T0OaY7PKH4bmO8xZ0ZMAHrkd29NNz3uMEluzhOL6A==
X-Gm-Gg: ASbGnctnIgIMqPIrQt9cQW0BLb6aqGXHsjMtzNWqx0fiwsrU974NW0ZoEdr+bdxHFjZ
	pxlOxAjW908riqU+lI4Ed1wbab/YmL4FvynseXq1xqiQx4u3iwM/ZQ+OXc0Mpc6rmxEi+G+hQX0
	5dgGniTETHQjpzV4Fjgjvtx6gIy+q/DUZKggeFAtv9J6LCURjg5kke8Nxf8zRgmviCBFH3CAU0S
	if5Xvhj5WerUddMVD5Zko271NVt1VyWH7r7M4mX3cVrYqqyYryDUO/ey+RW8Un/1ZK7kBHq+kCM
	ALcPYkaI1RDA+UR8puVnbDiHxUWcgaXWq7AxVRmmBVRsvveN7VdPiPcZXAghpw==
X-Received: by 2002:a05:600c:1614:b0:43d:fa5f:7d04 with SMTP id 5b1f17b1804b1-43f2edc7c63mr20711435e9.16.1744293091878;
        Thu, 10 Apr 2025 06:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuGhwEkIOIQmV9vyTTjh08E802YQY2NMK9rYdrO7U9thvFq8ZhNT2/VmlP/YCA83my8ZlkmQ==
X-Received: by 2002:a05:600c:1614:b0:43d:fa5f:7d04 with SMTP id 5b1f17b1804b1-43f2edc7c63mr20711175e9.16.1744293091252;
        Thu, 10 Apr 2025 06:51:31 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc83sm57126385e9.26.2025.04.10.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:51:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-coco@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v7 2/4] svsm: add header with SVSM_VTPM_CMD helpers
Date: Thu, 10 Apr 2025 15:51:14 +0200
Message-ID: <20250410135118.133240-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410135118.133240-1-sgarzare@redhat.com>
References: <20250410135118.133240-1-sgarzare@redhat.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
- added Jarkko's R-b
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


