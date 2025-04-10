Return-Path: <linux-integrity+bounces-5766-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933BA84561
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927F24A2CA6
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696D428C5AE;
	Thu, 10 Apr 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDfrvNTe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E328C5AA
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293092; cv=none; b=BuwcR66GAZQSar6c3RrZzsUi1NC9P8UYlR5vnuKD7xmT7JZ90yy8xVDz1qAzJTaGem8dL76XTzExd+dWE4wzcx9W+wO7bK/aDbtkmjeMApcnPjFnwdfjXtNDT+6+1QcQvA+xVuW/gb4o4zHHHBhK+iL0tFMEBG3DzK9hMZKPH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293092; c=relaxed/simple;
	bh=RqYMqp3Ujj1yablcXK4m8qctcMpdGLtxgb9YCEHWtfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juCNwbAlf1E4NRLKZ25PnCnyaD1AoNziWArGfftciMFJVLqUHMTne+U8os1kLxIVkgSneqnes6hbrIjGfu2sJ9Hi9sfuiPKbkJDs6s+ZFHTJWtI+G+sI2j444Eq2EeNZODct48ELpB6UOLnWoLM3r5IZuGGL48JNRup41eJI7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDfrvNTe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744293089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hayB2itOF52swyYqnft2InIWkfIXl2u+4tuyLp7J20=;
	b=ZDfrvNTehm32kZ2cAkP0+A9VzODYpxIXD/ZsQAUX+AxdqkZVeo5pQtjrg+3aReLM8bJlJ4
	aMDQvetEzAWm+AMjBPOd9cgtzm1DDy1PIqkQFIQWPYJghUqnzRkkzvdiq4kyYJm4DMs2HM
	DM6MIfVjuWmC2MI4xJUcKCrjhXhJ6oQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-fBbIgTbVN6-dBKA8W5TdnA-1; Thu, 10 Apr 2025 09:51:28 -0400
X-MC-Unique: fBbIgTbVN6-dBKA8W5TdnA-1
X-Mimecast-MFC-AGG-ID: fBbIgTbVN6-dBKA8W5TdnA_1744293087
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-399744f742bso263509f8f.1
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 06:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293087; x=1744897887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hayB2itOF52swyYqnft2InIWkfIXl2u+4tuyLp7J20=;
        b=qw8DUbwkXficXOhnJp8a3VDF6NYAPpdeyDqDNhLGo2namwi+KL3Nh1otmNHsZpjDSD
         a1fuSw8svdmucpfBypK1f4w70yQxKKRCQIvu2XRhNlh5L5D3U8XlPI/wCB15IpNR0E5e
         sSyCA0n218LGW8XmshxLXcOL4C4afROiPpU1YUkd+WF0uRhPydHh1yxclWWq7S8eJJlq
         p9P9zeEkjDuSyREmf/C23vYwsH6LxXTyehmVrjLGP6cDfqjJCZfKzH5v63VJDmdAhCE4
         L+a752vZHaIger/QvEs7+rZdy6KFZbTqeKP5ffdVbaxcXdGrUjm8rXkAsCxnYnDnvpDH
         MhSA==
X-Forwarded-Encrypted: i=1; AJvYcCWK6rgysLDvoUdmxSJsExy6eMnSMaLElCwfPsh2Gwhpx9smw+TCkCP4t0NBLU3d8gSYi3tLRe9Yl88ym3Pz8dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUGlCVF1grD3u3RTWHbiRhkrz1eR4X7DQgmf3Xz//38TgP34v
	k4f8fueVyQoLtqw0XREAUznf68s/4jbob+VAA+U9NzM5eHHC+DDbAhT42IVOZx5jJL9KD06gWCi
	jCX29wBfRtyKPdYpPp3ex8f5UvuPTPtnlQYstcLv/rCSH7+gXInYbjIVHb6WyIzxpJA==
X-Gm-Gg: ASbGncuZva9FjPQ6kmtHnca/vX5A5uKlC1PVLyUmS4AUmF+4AC9kdLt4Gx81P3Y+Kp7
	dFBL8nfdfFtahhGYubZ29vLjwO4RIQ/8R+Ousj9sb1Ne1UKmMxZ7Xp6KZ0ftSLWdhPtSYLM0nu2
	stkdGKYz351/es3vPoMNyDLqRphefXVatwV4L6qKUDrUy1voxhpcgk9laQapkjdWCpnDs+v6Mck
	c4NPE1fLift7LVfi2C78sHWREpuEL/y2/RWYTxNurrdFaIMmkucM7m6PtfmrHSP+Qxzm7do0UVL
	yoaVmiZsKZdvDSZKn9lod9suGRLsjGs3iZxSfFVmBlU+PMmjnamZC4Ys0sSVFQ==
X-Received: by 2002:a05:6000:2cd:b0:39a:ca04:3e4d with SMTP id ffacd0b85a97d-39d8f273573mr2757998f8f.7.1744293087098;
        Thu, 10 Apr 2025 06:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH74r2mCwQMz4b5b40UpkJVX/gWuuE0hyyRu8AvG8fHXAQ9RwrpeFNISL0qnwEahYkR49vqdg==
X-Received: by 2002:a05:6000:2cd:b0:39a:ca04:3e4d with SMTP id ffacd0b85a97d-39d8f273573mr2757948f8f.7.1744293086504;
        Thu, 10 Apr 2025 06:51:26 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938a761sm4932104f8f.51.2025.04.10.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:51:25 -0700 (PDT)
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
Subject: [PATCH v7 1/4] x86/sev: add SVSM vTPM probe/send_command functions
Date: Thu, 10 Apr 2025 15:51:13 +0200
Message-ID: <20250410135118.133240-2-sgarzare@redhat.com>
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

Add two new functions to probe and send commands to the SVSM vTPM.
They leverage the two calls defined by the AMD SVSM specification [1]
for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.

Expose snp_svsm_vtpm_send_command() to be used by a tpm driver.

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
v7:
- avoided exporting snp_svsm_vtpm_probe() because we will only use it
  internally
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
 arch/x86/include/asm/sev.h |  7 +++++
 arch/x86/coco/sev/core.c   | 58 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f66abe..d9ba035d8609 100644
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
@@ -481,6 +485,8 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 			   struct snp_guest_request_ioctl *rio);
 
+int snp_svsm_vtpm_send_command(u8 *buffer);
+
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 
@@ -524,6 +530,7 @@ static inline struct snp_msg_desc *snp_msg_alloc(void) { return NULL; }
 static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
 static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 					 struct snp_guest_request_ioctl *rio) { return -ENODEV; }
+static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a57497..3bc5b47e7304 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2625,6 +2625,64 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
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
+static bool snp_svsm_vtpm_probe(void)
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


