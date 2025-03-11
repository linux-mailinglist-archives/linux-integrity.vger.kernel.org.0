Return-Path: <linux-integrity+bounces-5215-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB3A5BC81
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1E91897C5B
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5522F145;
	Tue, 11 Mar 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnQwczqG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9722F177
	for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686163; cv=none; b=tPcoa+VRlc2rt8moN8LRm9+7A/UBSZQHAD/lwF44yFmCFA+hSfYzhGST1DNCwjx78eCL6NIxBB2O+PwyFGTYTFWrGGwpeGjgW4FGtHxSeJ1OLRBZUZ+I052SgXlL+diz77XLScWELlsFlKAdHr/o8wQPzfOJV6ObIHSqH/NxuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686163; c=relaxed/simple;
	bh=s48TuCB7hx4s0XQbfy+bStqom7rSsuzABfR49ZEXiRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhPh6l2ClmC1CyfSDkpCCGUVfWNlmGHiMgRKTVJcJY+cQshvvlu/CpNBpVyY3Rf8nV+XxsVBKg9nKHCDI9gqnxUxkO7T2EKU+UdsETbRlb0NaBQIXwSXYhUCGCH5OB42UQL1K5hPyA0VsD/DZXuvB4VXixKsM08YUAVuDpvedwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnQwczqG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWbgBYfOGia6Jpo6dySuLR4cc3OA1mqpDszmSXqcblw=;
	b=NnQwczqGyvP5vvHiUDrWVQW8hszS5mteCIhlm2kXwgJDOLF0fcufUnnNGCNofMzIRYgAKw
	DYs8nh/ExDB1GYcd0hQZS0oW3cYFAsrUK3iuqm5IfQ/ztNwhDMpvQctoL4c4oZacOq5GAZ
	CymEnDUeVggnoqMZ0PvNePhaKUV04PI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-lzDnYXFNNqCIx3iV7yB2pQ-1; Tue, 11 Mar 2025 05:42:39 -0400
X-MC-Unique: lzDnYXFNNqCIx3iV7yB2pQ-1
X-Mimecast-MFC-AGG-ID: lzDnYXFNNqCIx3iV7yB2pQ_1741686158
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac27ea62032so221323066b.1
        for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 02:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686158; x=1742290958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWbgBYfOGia6Jpo6dySuLR4cc3OA1mqpDszmSXqcblw=;
        b=D1x9h4nA7y6Ap7A6esWg3zGRRj8dvMT0UQNRa9aoCzOG2LL3wAUy42KroyG10PVC1Z
         mKqtHWuDYJb9fz8WSUHV3UkgiAeYTc4M8+BihUq7E55qCRNjKeVq52hvDDgZffELzyU7
         V05QoOZYm2X7Q/qD+QGvRN//SmBxIb5amft68MZTS996tn6B7Ei/CCGlhKdfFT7o1dfa
         O4ypFQCKqeKhXIK1kLJFus5wqxYO7PUX0UsZjfKaVdGIe3XthfGkkbwhAzLJYYo4bke3
         PvhcwADq1dkqJMn8nfQd17by/CRoKqyu9TWyJrZqf+QvIE3a+SQ4gC1caKGkrTeOsfMv
         DReQ==
X-Forwarded-Encrypted: i=1; AJvYcCW46JMifk4qZWN7Y0gUXs8dOwg12ttNJlzJgb/BKopPZog/zbe//hvSu71n3/0v+Wc2oz69v8ppx/UYKEiwtXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznehqFf+8z+yo/YpVE+FsyOYSg1QZO0ZM2i7/PGolj6ECMJWNF
	HA/F71OWXF1ZgN+vmMb8PfK/ifC2MVjVTVMyPVoapY0TfFsApfLKfq9H9yzhLqnmPKAbzuxQngt
	NtjdP5fhJmlVmGKdlprbhBeGjdOZiIfjY7xVKp8QidhNkBNSr0tnQcHjtEPaRGT7jOw==
X-Gm-Gg: ASbGncssm2BqXOoRvkdXV/aUZDDsQobjMnros+pvfYd8F7xv9OA8AiIJ6UBDM5IlkAl
	ofgKzcH9Lx65TTb9kvz3hc23gRCAPoisUVcYXGU+l6YqFCq/A1T9gEADfmDEwe7DJVFhjhXCQ+q
	H52yH+yrAUlph795rVbD8rYDqf+y7SJbj/jfKLd6OpFHvFfxy4yTpdykSWg0/I2VYtfQLM7vzcT
	kUA155lAjpMsd6lmZdqDIUfsVGaSqBq3RAifDKRiUMg1wa7cWGi+Lm99/dIdZ+8yjgoevYzzrTU
	UiwkU/j9id0pmmzSr+NL0m0UM3e0zuN4sZY0WAB0VrDa9gK6mm8s52qoRfSf/CBSP+/qR3Gf
X-Received: by 2002:a05:6402:254a:b0:5e6:1602:bfbb with SMTP id 4fb4d7f45d1cf-5e75f984412mr3427187a12.27.1741686158199;
        Tue, 11 Mar 2025 02:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPkM6rVc1QOWMePtECn1wZste/fTBV6MwarFwJ8JBd8XyGWLzR60WZC4WklV0jI8qfpX5GoA==
X-Received: by 2002:a05:6402:254a:b0:5e6:1602:bfbb with SMTP id 4fb4d7f45d1cf-5e75f984412mr3427137a12.27.1741686157633;
        Tue, 11 Mar 2025 02:42:37 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7472169sm8085277a12.24.2025.03.11.02.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:42:36 -0700 (PDT)
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
Subject: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command functions
Date: Tue, 11 Mar 2025 10:42:22 +0100
Message-ID: <20250311094225.35129-2-sgarzare@redhat.com>
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
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
- removed link to the spec because those URLs are unstable [Borislav]
- squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
  in this one [Borislav]
- slimmed down snp_svsm_vtpm_probe() [Borislav]
- removed features check and any print related [Tom]
---
 arch/x86/include/asm/sev.h |  7 +++++++
 arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..09471d058ce5 100644
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
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 96c7bc698e6b..2166bdff88b7 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 	return ret;
 }
 
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
+	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
+}
+EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
+
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
2.48.1


