Return-Path: <linux-integrity+bounces-5405-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98822A6D889
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 11:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102D93A4A53
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151D205E26;
	Mon, 24 Mar 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lqugqeh+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677E25DD02
	for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813227; cv=none; b=EC6Ov8SYQcg06ciAs87towNW+3LECwCsI1zKVKdpyCme+TPlg+JkphpWihqnsqyVxTAVxHxiNFAT/AGqJsTDN0GwsdN56M4WArkWGUiDTLzW503zBSxFBao/2SFG3T+wXIqcnZpBykLQxEcrUYYgkTGMp8z2lKRuEod1JCa+A8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813227; c=relaxed/simple;
	bh=gBGsgkYxSR1LlsmDYsqyNxaFopHRVY2DcTqfkPwuqkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr1ZlLPYxRB344EkPaBHVsbydcMTK/yr83NVm35wFIjMpDubcu71ySQGx4W/dIxIx/vs1JLtneEXxS9OvOhovkerEbNO/nSd2Njb++LInlRq5vbP7d1wasAXpeNqKt2glX66tZLM5simGAkHtc+KeO4YF9x/f8FwukhDAvj0x+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lqugqeh+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742813225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asa3lke4A0956hCElOUU/2LBwaCP9NEWyWZZnZLv9nU=;
	b=Lqugqeh+oVgrkwpU4C1E1/zYwRQUhfnbD6W5eu3CxLxrsrG+HAUto5zYpb/sEsSrcLRw5s
	utezLYCOVmHoGkhMup8LLwXu+OAWUBT/YzST964xcDvFGxaDbu3US/FME9SEPhmRAP5ufx
	y9NyNjB5zAh8kbpdg+1AAaI0kd8u0AA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-IcTjwx7UMaKCr2PGPEuH2g-1; Mon, 24 Mar 2025 06:47:04 -0400
X-MC-Unique: IcTjwx7UMaKCr2PGPEuH2g-1
X-Mimecast-MFC-AGG-ID: IcTjwx7UMaKCr2PGPEuH2g_1742813223
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391492acb59so2574957f8f.3
        for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 03:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813223; x=1743418023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asa3lke4A0956hCElOUU/2LBwaCP9NEWyWZZnZLv9nU=;
        b=j50vQoRctUiCb4m4krmU9FXO5eXs4W6V23T0O/Kr20He3iAedVhSWJvGez6arng6QZ
         LpkidruSdpWJPY/ntEZpbqWQ9cLqEAWBxNQxC+cs6lspMmzS8LjR427iro7hqPC9Sg3l
         u6+kd3mgmiBrcgG/q/rivUImn7vzb/OrUX7N7MIvlrJ2BxHiIjcK4svV/smxAfe/OVCQ
         ZlRaHUoWgusV+Jq0DACTyt+yzK2f6snm8W/T7R2SsjH/o5zqu6NoTYDxlDpKhofwa+Yq
         9CYhhmzmwganM/o7gfFF5DpWkrM3M3MpAeSe+pZj7P7oRqFP8zowMaufDVuxZrC/80g6
         1uMg==
X-Forwarded-Encrypted: i=1; AJvYcCXuu/l/TROzOg8gILTiMRJdibw9B5PbJ6Z6MQP+eFmFzujwPm6Bv3s2F5/MwDcKvoqJFe/D2UKd5ewBmZSb8dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpfRSdFoQ20klwYbwfGd+isnxTcPBepeUZUM+7UGDc2lto/m1
	eHYSckoiUw/5ZPnNqbKHFWM2DloIOyKT8ohkhMK5XhVbqr5e+ACdSKdZnzOGeJI2dFdnU1GTnn6
	PUurTCGqprimjoHsApdFTVALwnrNsVxyZPkvvr7e622TeqLtPyfOTZ809hVT6Sq07ag==
X-Gm-Gg: ASbGncs//GWrdcDXa7QBMw0/wm8GmKGvJ3FYOujYm3tnO/x7JEd0ykRmvQQmqZzP4Rw
	HbccTn5a/dGK5WM4+o/Hijqkyuw+2nXlgbiGD+gSxPQzwuldTjGrMvQetUJucoXI5CSxwyfw5qX
	NpJDPImhPtG1jMs0+wmxIyfI+jtCU01dSpfe0hWIn8lnVxVlvNWFbOoAkx3hW2VW9hJ8/SZ2Iy9
	njiwvqihBu46f0WmMmWHL6WklTuMYU91Z4oCH2PWj/jkNvszcTUNyUDHrTA2Kp3LcxyBZ4H433k
	jOPc5hZq3iiXCGLGImCOixSlrCywlZdpeLbusfVY+GlqlwGmg9xZrNMX+xDP2ey8vQ==
X-Received: by 2002:a05:6000:210e:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-3997f948179mr8809074f8f.55.1742813222872;
        Mon, 24 Mar 2025 03:47:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQQQjWB7MGZTF/Alp9AIGFhaJswe14E9cfG3Bz9+LPf0xUX4SLyvp8rPUkx9+IAagPCdpi+A==
X-Received: by 2002:a05:6000:210e:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-3997f948179mr8809032f8f.55.1742813222274;
        Mon, 24 Mar 2025 03:47:02 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9955c0sm10448152f8f.3.2025.03.24.03.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:47:01 -0700 (PDT)
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
Subject: [PATCH v4 1/4] x86/sev: add SVSM vTPM probe/send_command functions
Date: Mon, 24 Mar 2025 11:46:46 +0100
Message-ID: <20250324104653.138663-2-sgarzare@redhat.com>
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
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
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
 arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

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
index 96c7bc698e6b..034aab7e76d2 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2628,6 +2628,65 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
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


