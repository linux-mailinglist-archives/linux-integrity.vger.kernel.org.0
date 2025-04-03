Return-Path: <linux-integrity+bounces-5571-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF96A7A0AC
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2350C18976B0
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E4242936;
	Thu,  3 Apr 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVHW88wS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361C24A042
	for <linux-integrity@vger.kernel.org>; Thu,  3 Apr 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674997; cv=none; b=A0fpnFHxvbmJPddAGTn5pR0zWSizknQ0pIyIdcbaZvDWco5C3DGYptiOhXj23H58widMSXMHmMVF1TrI0kulupzHugHyUXuUZ6QEPgZJKVEaUC07CEjbGOV9vbl/DZU9zKzpoELPcT30z9NCJqz7bJS+ewxpf9XK1WbgUVZKXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674997; c=relaxed/simple;
	bh=MzD9Ad6mK9r4fxgZHo9dfRHlp4OQUEWf4LOVIPBSNt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBVuKyxM2UptwSduJNvwjeZkFRoLpTqw5P+TTZjPq2bzG+O2N5K/8xHSxVjWqgapKZj6iSP3M2E+b5mHRNYyDIOMGB+AFuEbzqCtxBOLfvN/KljK11MrhT2OrqGHHXsCHFYIgyEBWMCEHShORanoUz0pB6k0n8V1S6Lz2M8MUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVHW88wS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743674994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpoVdmq8NVnUnZOD3EnO3m6uLwgKHTodPmRunL4I+rs=;
	b=YVHW88wStBo8sRtmmnVERR2Xyuhl0lviTRrw6c0mMrcyOnKubf5HSeBu5uw+NTmcPkOzH5
	LV5Tsde0WPblEdMAchQqzBzYWJVMC8YLPSl/RQI7NumKzWq66Kj3KK7zURVLBvuXisd6eU
	RzPiHnilV59NPVBUCgD4jGEhLTBdHZE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-sbU_RqMJO3OygsLiebsZnw-1; Thu, 03 Apr 2025 06:09:53 -0400
X-MC-Unique: sbU_RqMJO3OygsLiebsZnw-1
X-Mimecast-MFC-AGG-ID: sbU_RqMJO3OygsLiebsZnw_1743674992
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d22c304adso8628025e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 03 Apr 2025 03:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743674992; x=1744279792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpoVdmq8NVnUnZOD3EnO3m6uLwgKHTodPmRunL4I+rs=;
        b=D/dxjOYaKyrxTV/Jc3q6YZjPD9F6FHbdOHJCyY5BoSPNRB0HfEb83D9wR4GDSpaYFe
         rDFDJNebBBI0JZpbr3v2WGZIDaNKAQk/CMM34osAprr+y4WdQP9CgYdfATHo7pgpwMlX
         169cx1jM+Nx/djKc4LkkNi/CfML6skyUnjEJniOfPyZ//318AND4chNeLKYijLCAxFdm
         XObZFJfe0KkvzQoYUxj0srrG54eW9sTW/dEm1sq2PCDqLEnT2HIro6Ze342kKDsFG4bF
         syIPpw3FpCXXBCwVj4MOrbI87xH+g9EnuU/q4QI1tkjnYwHR5DxNnZYV+mMEdK3pazdD
         1Oxg==
X-Forwarded-Encrypted: i=1; AJvYcCX+4/2ZqHGIOi++0dSr8a1E4XiLcH2Jjn7HOVzBd5zJ7Pz7dr6BD7bQ6vcx62xRXQvxYAmBcERZas6CJ6d4eyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMzXbBc21tYzcmtNfG+Jh4/g508k2Pml3u7E/wD+acye9bRkZ
	7+obVUwvFOt/sA8pEhgSk67lLG0JT28Lq35StBUSHf/RFFBnblP10i1nEn1XtB+N1oSPzVd4af4
	4MnNVvQPR3UGVJAU2hObR+vfnIeB/I+YAfOETl2PlK60dduFyA4ObqUyHpDVKtBeGsQ==
X-Gm-Gg: ASbGncuc7oQZayyu4d/h8zeSPn1DuMV+MepprJlEZGKsEW8HlRrHSgNOqBJAZXwLrG8
	1FECGnZCyDosWX8dhUzhqDj8TJD4Q2utiYMspSybbLdH5LHQEHfKSbdH09azfSZSS5y1/EA4qLQ
	POd6Pw/RSGauqWxPPU2oh9uADgJIWj7S//lMlMRFLc4WOCkWC77fS/SBhycm/FMG+8mSlw/qiHm
	LfPtD65u/6g6SjAPTij8tA5x1E6lAbmpJuZzWNutim41jngliKUjornMi3u+nXWKKfLqWJnLcKh
	lvcL3bfhkc4dxEEdTmTSXkUQpyzN8dfQn00JalTVYpTiIPi+qv0P9ANdXj5M
X-Received: by 2002:a05:600c:1ca3:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43ebeed6dd4mr24861365e9.7.1743674991885;
        Thu, 03 Apr 2025 03:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhK91zBiijUbCC0j/FPAiwjeqLDEV12HIxEw5TJqrQUqDMe/B3PRBRIv3dfMrFpNdP4Zc8Jg==
X-Received: by 2002:a05:600c:1ca3:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43ebeed6dd4mr24860915e9.7.1743674991373;
        Thu, 03 Apr 2025 03:09:51 -0700 (PDT)
Received: from stex1.redhat.com (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226f2bsm1368623f8f.96.2025.04.03.03.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:09:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Dionna Glaze <dionnaglaze@google.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 1/4] x86/sev: add SVSM vTPM probe/send_command functions
Date: Thu,  3 Apr 2025 12:09:39 +0200
Message-ID: <20250403100943.120738-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403100943.120738-1-sgarzare@redhat.com>
References: <20250403100943.120738-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Add two new functions to probe and send commands to the SVSM vTPM.
They leverage the two calls defined by the AMD SVSM specification [1]
for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.

Expose these functions to be used by other modules such as a tpm
driver.

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
- added stubs when !CONFIG_AMD_MEM_ENCRYPT [Dionna]
- added Jarkko's R-b
v4:
- added Tom's R-b
- added functions documentation [Jarkko]
- simplified TPM_SEND_COMMAND check [Tom/Jarkko]
v3:
- removed link to the spec because those URLs are unstable [Borislav]
- squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
  in this one [Borislav]
- slimmed down snp_svsm_vtpm_probe() [Borislav]
- removed features check and any print related [Tom]
---
 arch/x86/include/asm/sev.h |  9 ++++++
 arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..ba7a0a327afb 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -384,6 +384,10 @@ struct svsm_call {
 #define SVSM_ATTEST_SERVICES		0
 #define SVSM_ATTEST_SINGLE_SERVICE	1
 
+#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
+#define SVSM_VTPM_QUERY			0
+#define SVSM_VTPM_CMD			1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
@@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 			   struct snp_guest_request_ioctl *rio);
 
+bool snp_svsm_vtpm_probe(void);
+int snp_svsm_vtpm_send_command(u8 *buffer);
+
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 
@@ -524,6 +531,8 @@ static inline struct snp_msg_desc *snp_msg_alloc(void) { return NULL; }
 static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
 static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 					 struct snp_guest_request_ioctl *rio) { return -ENODEV; }
+static inline bool snp_svsm_vtpm_probe(void) { return false; }
+static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a57497..efb43c9d3d30 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2625,6 +2625,65 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 	return ret;
 }
 
+/**
+ * snp_svsm_vtpm_probe() - Probe if SVSM provides a vTPM device
+ *
+ * This function checks that there is SVSM and that it supports at least
+ * TPM_SEND_COMMAND which is the only request we use so far.
+ *
+ * Return: true if the platform provides a vTPM SVSM device, false otherwise.
+ */
+bool snp_svsm_vtpm_probe(void)
+{
+	struct svsm_call call = {};
+
+	/* The vTPM device is available only if a SVSM is present */
+	if (!snp_vmpl)
+		return false;
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
+
+	if (svsm_perform_call_protocol(&call))
+		return false;
+
+	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
+	return call.rcx_out & BIT_ULL(8);
+}
+EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
+
+/**
+ * snp_svsm_vtpm_send_command() - execute a vTPM operation on SVSM
+ * @buffer: A buffer used to both send the command and receive the response.
+ *
+ * This function executes a SVSM_VTPM_CMD call as defined by
+ * "Secure VM Service Module for SEV-SNP Guests" Publication # 58019 Revision: 1.00
+ *
+ * All command request/response buffers have a common structure as specified by
+ * the following table:
+ *     Byte      Size       In/Out    Description
+ *     Offset    (Bytes)
+ *     0x000     4          In        Platform command
+ *                          Out       Platform command response size
+ *
+ * Each command can build upon this common request/response structure to create
+ * a structure specific to the command.
+ * See include/linux/tpm_svsm.h for more details.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int snp_svsm_vtpm_send_command(u8 *buffer)
+{
+	struct svsm_call call = {};
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
+	call.rcx = __pa(buffer);
+
+	return svsm_perform_call_protocol(&call);
+}
+EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
+
 static struct platform_device sev_guest_device = {
 	.name		= "sev-guest",
 	.id		= -1,
-- 
2.49.0


