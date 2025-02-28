Return-Path: <linux-integrity+bounces-5016-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A94A49FDE
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 18:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0BD1770F1
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4491280A38;
	Fri, 28 Feb 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVVr/aAL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776D2777FA
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762467; cv=none; b=FIVa52XtiZdfs+NDIcajulSGHZw39jLlQhIpUQUDdK/vTwwUu6sFTp6JipNXmgTdfnvp3GxTFapNI5YJ2aIsWSEq1M3k21DZFODcoEfYVasm3LgVLEJ07D1tkCqXiuwDjdZIsdh/0d/1XyZF8Y3xCu9MC5c4BD47XFt/r95Vx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762467; c=relaxed/simple;
	bh=isgbJApTlCyBGPxQFjLRsJbEwGToiMAg7wsViEvYcmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK401/4I73COhu9HTzNcZ0T1A6Y47qmlafQM1e6w4rN5BzrxSUCsy3YILeJjgoxyEpLj7u0XAFGyPgZkociuJY5oUTnIVI8DfphIUPo22tlGCD705s52v02/1KHXhp+ol24d8BYCT6HxgvGr3y7RZG0Fs6eXomjHUagdlfoU9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVVr/aAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eRRsXwQ9b5BVtkXOCbQvcRoNNZrcFjbeyN4c0+Tojs=;
	b=CVVr/aALEvSXmtQUhS9t/OakErMgsj72vPqIH2ray6IYxHsH56PFeixTttZLze7Kdy7qat
	5rRN0JG0IkLcAvJc3j2g28bEQpcbJKszcsEnvYuTBNBj0mO4RFIzqTOKHZLdjuYlKCgkcU
	RfLabSseSwhQc8QAwvAH+uPRsXL55vo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-qxstVnuUOh-7ccx_xDd4yQ-1; Fri, 28 Feb 2025 12:07:43 -0500
X-MC-Unique: qxstVnuUOh-7ccx_xDd4yQ-1
X-Mimecast-MFC-AGG-ID: qxstVnuUOh-7ccx_xDd4yQ_1740762462
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f55ccb04bso1445158f8f.3
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 09:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762462; x=1741367262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eRRsXwQ9b5BVtkXOCbQvcRoNNZrcFjbeyN4c0+Tojs=;
        b=J/CBrtsihq7qsX23ySc5+zlB4iHZ3c9LXCOEC8Xjw6YhVTgr3JC744wSgOMH68GVMh
         h+BRRlv8mNW4TeCVEVmvMIDkSEmladgFFn133UL3sJfrcVhnP3SehkfcZ6Bic79xeSxw
         r/05+CqRRi/YEc7Rz/m1uRbmLDcNk1XYm851DyxkUuTLECa63/LqV4XqnDNKpYsjO+PL
         CaD7wGohDiSka5b6YxJtrKxIg0cAknlyQPDKap0XX95ytLIqNRtPaiK8J2j5Xp9XN/M4
         3r26gQlwpFM3Ru6v/PXaOVUFPYjZ0IqGFIE3VRMev6L3E9ak8QelUK4hsz7elt7OrGLZ
         M+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWOAN0l3tLq/E1QuU+foQXS74LWAXxWd+vUI6IErkVwWZsfZiaDccobfiongHVTtW+7WZwqDyYEl7KqxAlRxhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjN5S3jMD15Hkyayc9/OcPp7SclfBbpNS0qvlNRTlMcI8ZAvY4
	1JHvKE1sS2XcRJla0lI6VeSQpkSuxPgWrJUxi3KueBH+sEpuO0YZwCsnrswYXV/LqqMuyWND1Na
	kZ5rTZLb+rTsxPk/ZrNjicbZRQJgaeY3Z81JF+t9AGXWc0b5KMjagBclI+FxgbmV9XA==
X-Gm-Gg: ASbGncvVCcsfmpMcuFJQxpERjsnA4WijGM1vdUAAL+BPhVuJIJBg0F5kWFh1rSeBlyY
	1zsG/2+fCkvdZ5GXPRnHYJ3sR/mqg3Pz9FCd8ekSjFQSMW4RvgkHmegazQbRpgkxA0EtdItv5XK
	iubGfMhUq9qcqKPUa1ZGdEnG+o5SroeDZBZCJxbR4h3rG7o4UCMWnuUVf0olne7ieEwMdyrCOxX
	X29T3/zANXT8Dpy4tz4y0uxutti8a9uO810uxOYlmycnizUqe8MbowUsqQIGclpIV2oH3ZMrRj6
	cAAPJZqNumk87gEYUUIx
X-Received: by 2002:a5d:64cf:0:b0:38f:30a3:51fe with SMTP id ffacd0b85a97d-390eca53071mr3032897f8f.42.1740762461825;
        Fri, 28 Feb 2025 09:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUfCkTRPfiaBO1sKSMwjiWtyLlnIdvMfWDewKknFvnz/aj1uQU6OJDIxFqKk7dZj8v3YEtog==
X-Received: by 2002:a5d:64cf:0:b0:38f:30a3:51fe with SMTP id ffacd0b85a97d-390eca53071mr3032826f8f.42.1740762461199;
        Fri, 28 Feb 2025 09:07:41 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bcfdsm62305695e9.40.2025.02.28.09.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:38 -0800 (PST)
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
Subject: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command functions
Date: Fri, 28 Feb 2025 18:07:16 +0100
Message-ID: <20250228170720.144739-3-sgarzare@redhat.com>
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

Add two new functions to probe and send commands to the SVSM vTPM.
They leverage the two calls defined by the AMD SVSM specification
for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.

Expose these functions to be used by other modules such as a tpm
driver.

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
James, Claudio are you fine with the Cdb, Sob?
The code is pretty much similar to what was in the initial RFC, but I
changed the context for that I reset the author but added C-o-b.
Please, let me know if this is okay or if I need to do anything
else (reset the author, etc.)
---
 arch/x86/include/asm/sev.h |  3 +++
 arch/x86/coco/sev/core.c   | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f6ebf4492606..e379bcdddf07 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -485,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
 			   struct snp_guest_request_ioctl *rio);
 
+bool snp_svsm_vtpm_probe(void);
+int snp_svsm_vtpm_send_command(u8 *buffer);
+
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
 
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492efc5d94..4158e447d645 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2628,6 +2628,53 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
 	return ret;
 }
 
+bool snp_svsm_vtpm_probe(void)
+{
+	struct svsm_call call = {};
+	u64 send_cmd_mask = 0;
+	u64 platform_cmds;
+	u64 features;
+	int ret;
+
+	/* The vTPM device is available only if we have a SVSM */
+	if (!snp_vmpl)
+		return false;
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
+
+	ret = svsm_perform_call_protocol(&call);
+
+	if (ret != SVSM_SUCCESS)
+		return false;
+
+	features = call.rdx_out;
+	platform_cmds = call.rcx_out;
+
+	/* No feature supported, it should be zero */
+	if (features)
+		pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
+			features);
+
+	/* TPM_SEND_COMMAND - platform command 8 */
+	send_cmd_mask = 1 << 8;
+
+	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
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


