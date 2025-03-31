Return-Path: <linux-integrity+bounces-5524-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD30A76466
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 12:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450A1169C49
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5061E04BD;
	Mon, 31 Mar 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPr1WDM/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762381DF738
	for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417554; cv=none; b=RebXv1m2HvjYnvvr5SdbuI5k0BNe2wDTdHjHqaPy/64pe4u0ITAIacZajiY8hWbmevRiPOO2ZM74PTN55oMIFHRcgdO6/ogMBRmeyODf81HRbITdZPRdLLVyy7kM6bFMxgLAIHsOHrKjpIPJzC/9rK18t1EOFdvJktyftn7PON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417554; c=relaxed/simple;
	bh=MzD9Ad6mK9r4fxgZHo9dfRHlp4OQUEWf4LOVIPBSNt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSqH401hd7/JGewqd+2RA3UracUCrPKBpADzbRtTC088OspTIocoraoldYrc2HSxeARJ2M3YvRMOCWl7zAl/8iQSsQHVzkmOUfIX5zLgBYxky8reJgRGs1uvfuOygKQ2SW8kmgmgqoAtYa3v+GU+dqF1QEWZuFK5Nc61aOYeIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPr1WDM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743417551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpoVdmq8NVnUnZOD3EnO3m6uLwgKHTodPmRunL4I+rs=;
	b=HPr1WDM/coCSVfGej/elVwyS0P6GpDqh4w9vtSmxYrLPVqOTURVjg9th2iSOcwqXozwrZZ
	S2VokU4clg+EnN4C6ragDvJWHptjFf5TLqr12WSEuCCTKNUdxiZJC4CobUfRVHzx9pI1f0
	5KoyqBp9uGtEXr9UVN52JMGB9b9hZRk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-CvYK-JBSNe-zAGtXXJ0tBw-1; Mon, 31 Mar 2025 06:39:10 -0400
X-MC-Unique: CvYK-JBSNe-zAGtXXJ0tBw-1
X-Mimecast-MFC-AGG-ID: CvYK-JBSNe-zAGtXXJ0tBw_1743417549
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913f546dfdso2197871f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 03:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743417549; x=1744022349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpoVdmq8NVnUnZOD3EnO3m6uLwgKHTodPmRunL4I+rs=;
        b=il1l3/CUfNZRbwllIcdwKIbdG4KaxUJrmh8nGGwtlSsQTEIF+fvKg7/+xMAWn13+c5
         kuchckGGSDaytY1InvBg6ORDXCI7AfXrsSizRpsclnMStxJlV2YS6G6ftcNhPlWBSsK7
         NEn/DNVrdoS4HzW/vj9snADOTT27y77hKdUoE3Fk2UoYJxoaQN63obCVt10hDkjgwzuJ
         Z2TBJVI33h3aLLGyVVENl1wXwlG1OjVexQTIFh3r8XcUSgCkohaUIPls0J881rL8939I
         HW32cOojEunXyNeIjuXyxDSuDZhQID3iEJXjvELndkXjrlQ/VU2tQrOISYh9fceL16l6
         stgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdLEwWvx0SgTmpydG0Y2mNhE0IPueWSTggAKUglHiGRhVIfvRNiP1GPrq0w8ICtsMEm5HkwC8seVrxc2ydJsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8J/mmYCu0UIBPjMZEEB9XDo/QYnYje6Uvh1cejopOteQR9sPK
	+lfOhHCMxwegvGbkroQgizL/9L5/8C7JRuINeNfajQwMpOgQkvzSKvyIp28KJn7vVW8vP/H5feN
	ZCNTHv9VXML4ae2TTAwVUPzoXCje1yZXLiQ4WPBiZVIKV9t9ZvYam0sH3LaqJBsi3VA==
X-Gm-Gg: ASbGncuTM1DqnSsu5WCNqALzuH/Ih/q3cimq18liAOoY5qI16kv5Edmm5RtC4gpyHmm
	Ehd311YDaQbsQtcvAsT5c769ckRuLiXWA94BGRvOQw+8H2vfolUm/HLoaIiS3wQ11fo/8ugXGcO
	FevELw21NcxludsFtwh9jJ+lgEaCNRKntK9sdcdJGAJRDyumgrVP3QbPK9oWxx3uZthE1X+lGiq
	hQIAhmer3BWXDnUvhtD068QXIWudTg0pVjAc0B0eKA9fl/mF8sMngpS0KlqkpwNXESRD77tsh0l
	DyADdR/ukjrt82knh9topsG4bcjOWHFKVFCvXpMckT4v3bVjGIFBLH4tUIZ4FYZJAA==
X-Received: by 2002:a05:6000:1789:b0:39a:ca59:a61d with SMTP id ffacd0b85a97d-39c1211d6dfmr5299642f8f.47.1743417548863;
        Mon, 31 Mar 2025 03:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnDaOaSL/ZAtEwyINcAEfHHyImiDBDT1PrwoAIb4V41DPAx+sWTZRY3pHU+AggxpwblWc/Rg==
X-Received: by 2002:a05:6000:1789:b0:39a:ca59:a61d with SMTP id ffacd0b85a97d-39c1211d6dfmr5299623f8f.47.1743417548376;
        Mon, 31 Mar 2025 03:39:08 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d900008d8sm116115905e9.33.2025.03.31.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 03:39:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	linux-coco@lists.linux.dev,
	Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <jroedel@suse.de>,
	x86@kernel.org,
	Dionna Glaze <dionnaglaze@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 1/4] x86/sev: add SVSM vTPM probe/send_command functions
Date: Mon, 31 Mar 2025 12:38:54 +0200
Message-ID: <20250331103900.92701-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331103900.92701-1-sgarzare@redhat.com>
References: <20250331103900.92701-1-sgarzare@redhat.com>
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


