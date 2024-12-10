Return-Path: <linux-integrity+bounces-4329-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B59EB37B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA02825BA
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7911B4F04;
	Tue, 10 Dec 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSTSfWwj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B81AA1D0
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841301; cv=none; b=usgprRxB/Brc+wF0B9JspusNXUf6KPmehKgIKW4VRLdKHLvSC0UXf6Xmq8R34RzpSHbzd993ThMOiS4plUYkVqBcBJyP+9AgPpgDcWCjj1k94i45mfcVzUw2TbNFpNLKTZtcKi9c5X2P9lBatfnwbvlExFNBuS/uq+FwBswhadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841301; c=relaxed/simple;
	bh=I3+OgVND3ovs3EabmzXGFURX+i4WzYcd0zLU7C8kE5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svsFAHVZDTufhNzFoYPa0zhXfwOqy3d8a0P/8Ei0OVTiYydUInv2Mc6BzITVXHQbpaEtHhPmSIRZoCTh69LxNREt5Xb7rOqs3/TNgjkO1bum1yFtkNxmrUl3M8wgYe/1QIX7/joRGeveBzk+euwb3ztgaaV9x3AQpzMFoXepyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSTSfWwj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHZJG01hNeaIMCFXcC4aAtIq9wGcVNYKpI5sbt4iaAs=;
	b=GSTSfWwjz6mW6gDvawFrDVdyVn988gg5ba3vTjeRIK3v1CNB1bfMaCbf4tX+6IAZVVh96D
	5K0N0oTGxy/YVaxbYUJRwrDZv8oF3JdFOJB66mfSvgmDfW29boD+aFtTmPf+sHSOKuelMu
	KAEx3BVxqOfp/3ZmlDE7cpc7qxBrCPY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-lGwS65ZkP5aPwgkc77m6Aw-1; Tue, 10 Dec 2024 09:34:57 -0500
X-MC-Unique: lGwS65ZkP5aPwgkc77m6Aw-1
X-Mimecast-MFC-AGG-ID: lGwS65ZkP5aPwgkc77m6Aw
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46692410a9aso72580441cf.2
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 06:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841297; x=1734446097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHZJG01hNeaIMCFXcC4aAtIq9wGcVNYKpI5sbt4iaAs=;
        b=FQ3IGke9B2tpa/9aPttcMecqYJmJ6X48c2wFst6MFHIGQ064fmHzoIq7PHHS1aiNRI
         btR14t8kRw5DmklluveyOSoi/hZsaP3cPJ6yLwSeIqNGi6Q+8A2qd8W0DrqhQgSA65b4
         AEfO3F5XQvFhdFvh7djT2lyAqBVZiTzy6j1FuRH92nPi7EwF0aIl53lcnl//LjvKZ2VP
         Ec8Pw6yp2G/xt58LfznEddsFQoCEyzlmK4Yx6wXmYtorz4wOdE+8JzA6tK/J8uy5FsN5
         GGODvfMHMhYqP9ORtcPQcRDvS2E5XP2GsbliYFpibwOnQ7uwTsh0N3ILhF9ThL3vA4GU
         j9mw==
X-Forwarded-Encrypted: i=1; AJvYcCWdPt63bDbsW80yy9BAXspMeQhf0BxQBT/ppEj8WOmUmj3PktAKI2R3gy719Q4WuV2Qt/lpOy0fVHSFgIMOWeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxqgC1JazH+daMce4j06yJJN/TakDpuw76HtK+/wEE7dBv8+n
	UjEJ+w36FcYUDgDQ3zrVXM+U3Ts/gIjj2dPrFly4nL+Dt4wmAUDvwlxwuCZLUlnh682OrAkwTU2
	0ct5U2/VhcHleHtcTqBDPYC7gBgsZyRmWV/FwviNx1Lq6HpC7V0ZZXven3UYVmq6ZJg==
X-Gm-Gg: ASbGncv5jKSTG61xx5ZlVq8WhWtDpVluORgWiLH/HJgYrSTyz8+BQ+73moueAyg1Nhn
	EBIoQF4oRXgPcPdAdQ9A49m0j/wXWc1ngxGbQJKTqegQh8EikY5bDP+g5uPwEu7W8Jy23RqOhb1
	+J7WGaFsw9WjsYNd8B94DA6TkElTUGTC35z3+1GugHjPeSa9RtujMfWVOr0OxXHiu/XWghrD7vc
	1A9ooTTvuSIwhe+/RvamQ6Gv2VW2KKcOZr/8nkVBXC9Wix8Qp8sQN+kQE8Pv1dhevo9uIQvRMY3
	W45wOdtsBzS+2EMY/ergdmXBm/ZVt8I=
X-Received: by 2002:ac8:5fc6:0:b0:467:6505:e3c with SMTP id d75a77b69052e-4676505132dmr138668281cf.24.1733841296844;
        Tue, 10 Dec 2024 06:34:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWTua5aJb1pNQFOVrnxFBRlJAcVPzKgg25Q3AMf1JLy1jJEt2pslYht0E+7saMZCCbUW+bWQ==
X-Received: by 2002:ac8:5fc6:0:b0:467:6505:e3c with SMTP id d75a77b69052e-4676505132dmr138667721cf.24.1733841296367;
        Tue, 10 Dec 2024 06:34:56 -0800 (PST)
Received: from step1.redhat.com (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675d0d9039sm27218631cf.22.2024.12.10.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:34:54 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Date: Tue, 10 Dec 2024 15:34:23 +0100
Message-ID: <20241210143423.101774-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210143423.101774-1-sgarzare@redhat.com>
References: <20241210143423.101774-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

If the SNP boot has a SVSM, probe for the vTPM device by sending a
SVSM_VTPM_QUERY call (function 8). The SVSM will return a bitmap with
the TPM_SEND_COMMAND bit set only if the vTPM is present and it is able
to handle TPM commands at runtime.

If a vTPM is found, register a platform device as "platform:tpm" so it
can be attached to the tpm_platform.c driver.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
[CC] Used SVSM_VTPM_QUERY to probe the TPM
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
[SG] Code adjusted with some changes introduced in 6.11
[SG] Used macro for SVSM_VTPM_CALL
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 arch/x86/coco/sev/core.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c5b0148b8c0a..ec0153fddc9e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -21,6 +21,7 @@
 #include <linux/cpumask.h>
 #include <linux/efi.h>
 #include <linux/platform_device.h>
+#include <linux/tpm_platform.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
 #include <linux/dmi.h>
@@ -2578,6 +2579,51 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
+static struct platform_device tpm_device = {
+	.name		= "tpm",
+	.id		= -1,
+};
+
+static int snp_issue_svsm_vtpm_send_command(u8 *buffer)
+{
+	struct svsm_call call = {};
+
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
+	call.rcx = __pa(buffer);
+
+	return svsm_perform_call_protocol(&call);
+}
+
+static bool is_svsm_vtpm_send_command_supported(void)
+{
+	struct svsm_call call = {};
+	u64 send_cmd_mask = 0;
+	u64 platform_cmds;
+	u64 features;
+	int ret;
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
+	/* No feature supported, it must be zero */
+	if (features)
+		return false;
+
+	/* TPM_SEND_COMMAND - platform command 8 */
+	send_cmd_mask = 1 << 8;
+
+	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
+}
+
 static int __init snp_init_platform_device(void)
 {
 	struct sev_guest_platform_data data;
@@ -2593,6 +2639,24 @@ static int __init snp_init_platform_device(void)
 		return -ENODEV;
 
 	pr_info("SNP guest platform device initialized.\n");
+
+	/*
+	 * The VTPM device is available only if we have a SVSM and
+	 * its VTPM supports the TPM_SEND_COMMAND platform command
+	 */
+	if (IS_ENABLED(CONFIG_TCG_PLATFORM) && snp_vmpl &&
+	    is_svsm_vtpm_send_command_supported()) {
+		struct tpm_platform_ops pops = {
+			.sendrcv = snp_issue_svsm_vtpm_send_command,
+		};
+
+		if (platform_device_add_data(&tpm_device, &pops, sizeof(pops)))
+			return -ENODEV;
+		if (platform_device_register(&tpm_device))
+			return -ENODEV;
+		pr_info("SNP SVSM VTPM platform device initialized\n");
+	}
+
 	return 0;
 }
 device_initcall(snp_init_platform_device);
-- 
2.47.1


