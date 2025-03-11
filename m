Return-Path: <linux-integrity+bounces-5216-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0185FA5BC85
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F64A3B2ED2
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AF233136;
	Tue, 11 Mar 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rft2EjVv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C722F3A8
	for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686168; cv=none; b=DfgBks+lDpxRbbtEeKXl6f/Iu4699f6XcBMyu/ZVBMmtn4xsxMXXQOWMJuLnANFngLRYp4xtsFhzgAoxf6osjDpiJCRWK/ViQlNVdgwgCtznNJhsanAQ005bZPJpXsFKySv72c0UzH2blEuJeW+6+z5GrKh7VYbz2x4qxAdqGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686168; c=relaxed/simple;
	bh=/A3bynKEsxmf0Y53DPDvuqNqTHcudnSVLkcL8DWcb4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+naXa3PajvWfMjXkiqv5RTy6d6zMJ9j1RdGqCtNO6HUddTA/yJizuIrUg8vpKZHiJ8+LtW/V39In+TVlhhQDm6qsJ96SrhT+1K6zZR5uF74fUE6GDuBi0hu1g/yRrZWpWW29TEzWYyzE9jiYamk1VVunJIKdMUHR6SumLSuZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rft2EjVv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diTiRQ4QEE+DrXrQrQ/ial0maPf28mPhXHy+LSWc3KI=;
	b=Rft2EjVv1f+fytBPC6VP+Xc3/gXraHKRimxCQUgxK6wrwUbBNtF52cM1HuhVE6/d7uW9Zc
	jsYBlj36Lp4Wzve6Gtc5V4czvEEpca2jL4Gnh9pwJyKuqZnCdnrJGdEJLihY8uCb5NzaCL
	TOoWJbXCwV6sg869iNHikZqo74qLUUU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-9UJ58wDbPUmTKmxdHReZvA-1; Tue, 11 Mar 2025 05:42:43 -0400
X-MC-Unique: 9UJ58wDbPUmTKmxdHReZvA-1
X-Mimecast-MFC-AGG-ID: 9UJ58wDbPUmTKmxdHReZvA_1741686163
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf597afe1fso517863566b.1
        for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 02:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686162; x=1742290962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diTiRQ4QEE+DrXrQrQ/ial0maPf28mPhXHy+LSWc3KI=;
        b=FgULvd3O5bKkRNfOOuEhvy9sSOvQPcuxDLI8Ob5acLFRDLLikHbt/PkCbgh+XLT3dH
         b+QnVLlhGFIsiHc5hUZO+S1mpgK9Aaqr0OiK2L1C+C0FNvV8Uwsua1OrARUcpvP8MPTz
         76NHt5+FtPjZncf9t2+XwNT7WD5gC2mMHdlfIh9XEEOHN/orwOPk2D2HClry+NgE74Ec
         QsEujUFaVNLFrEvGi6DJJtCe0mOu1LqWgkvdChhQcoT5yKFWAsmpQgOARVE9eGqeAEKh
         s9FTGtsksf9UhPX5DMgyQGu1TBwQgFdHRE+fNer90DqcXAs4+7xMHIKfvVYgdXIdOXfi
         /Mdw==
X-Forwarded-Encrypted: i=1; AJvYcCVgnlA1b4tGS0ZXlbhUlbpJlNLSypqO0+skNDbn9YPZpd9TXnTt6JvixMACLlNhN06GHMGi+r1mgfhH8/bn788=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8777JWMR6OXctTm0GkaBUdlvTUY5BDinfWk0XqEQojHr5Bfpq
	p6qWDrjfvspSYRCRtMa5fthW2MTbEKEnOTLZ++NHR68ImXe6XJAe1h3/M+D5QXdgLDTPLOoAXRy
	zCQD7j9kol08W6X2PWnY07K8mbRLqElrJVqnYqeTa2ua3vmgXAqwytX/XRcsDvoK/ww==
X-Gm-Gg: ASbGncvlvH6IWPJEr2pfohS2PhT8nbS6XI2AgVeNQkA6lcDYt9Z96JEImgPrOb+Iotm
	R8qA74wnP0aEceZRcivp7Xmp6zZLIrpn0+bNNtuYgYi71SrFD/f3aXkhGwF73ex2GknjMrGTO5w
	enrkzW/EcZyl+30RF2nIbXI1OI+ELqQTnQlX7CGEyKhvBxMEYRF7Mjl6IC5VwG8Zq0MSt0og8lZ
	z838RuT6hI89QpXHqTPHqlundtfv9JFQj4QEA3QTOoBaPx8sqJIatYEkPjK5Acsi767Y6fDDz3A
	MaZgET4VbrxSIzlJf1Hp93nTL9KMRIB1brcsSJzXZHZ729QnhZ62DOLyWIOrPDeCShvGcb/y
X-Received: by 2002:a17:907:7d9f:b0:ac2:97b2:1d3f with SMTP id a640c23a62f3a-ac297b22079mr1114323766b.33.1741686162495;
        Tue, 11 Mar 2025 02:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUcxLn6TcACG5q0J+lrMTI7KwpBjie28By2PFquAKqewgotRjAJtSnPnu+qLJ4qo42XwLXVg==
X-Received: by 2002:a17:907:7d9f:b0:ac2:97b2:1d3f with SMTP id a640c23a62f3a-ac297b22079mr1114316766b.33.1741686161827;
        Tue, 11 Mar 2025 02:42:41 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a27d2613sm298483166b.12.2025.03.11.02.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:42:41 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 2/4] svsm: add header with SVSM_VTPM_CMD helpers
Date: Tue, 11 Mar 2025 10:42:23 +0100
Message-ID: <20250311094225.35129-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311094225.35129-1-sgarzare@redhat.com>
References: <20250311094225.35129-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v3:
- renamed header and prefix to make clear it's related to the SVSM vTPM
  protocol
- renamed fill/parse functions [Tom]
- removed link to the spec because those URLs are unstable [Borislav]
---
 include/linux/svsm_vtpm.h | 141 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 include/linux/svsm_vtpm.h

diff --git a/include/linux/svsm_vtpm.h b/include/linux/svsm_vtpm.h
new file mode 100644
index 000000000000..2ce9b1cb827e
--- /dev/null
+++ b/include/linux/svsm_vtpm.h
@@ -0,0 +1,141 @@
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
+#ifndef _SVSM_VTPM_H_
+#define _SVSM_VTPM_H_
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
+#define SVSM_VTPM_MAX_BUFFER		4096 /* max req/resp buffer size */
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
+ * svsm_vtpm_fill_cmd_req() - fill a struct tpm_send_cmd_req to be sent to SVSM
+ * @req: The struct tpm_send_cmd_req to fill
+ * @locality: The locality
+ * @buf: The buffer from where to copy the payload of the command
+ * @len: The size of the buffer
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static inline int
+svsm_vtpm_fill_cmd_req(struct tpm_send_cmd_req *req, u8 locality,
+		       const u8 *buf, size_t len)
+{
+	if (len > SVSM_VTPM_MAX_BUFFER - sizeof(*req))
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
+ * svsm_vtpm_parse_cmd_resp() - Parse a struct tpm_send_cmd_resp received from
+ * SVSM
+ * @resp: The struct tpm_send_cmd_resp to parse
+ * @buf: The buffer where to copy the response
+ * @len: The size of the buffer
+ *
+ * Return: buffer size filled with the response on success, negative error
+ * code on failure.
+ */
+static inline int
+svsm_vtpm_parse_cmd_resp(const struct tpm_send_cmd_resp *resp, u8 *buf,
+			 size_t len)
+{
+	if (len < resp->hdr.size)
+		return -E2BIG;
+
+	if (resp->hdr.size > SVSM_VTPM_MAX_BUFFER - sizeof(*resp))
+		return -EINVAL;  // Invalid response from the platform TPM
+
+	memcpy(buf, resp->outbuf, resp->hdr.size);
+
+	return resp->hdr.size;
+}
+
+#endif /* _SVSM_VTPM_H_ */
-- 
2.48.1


