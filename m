Return-Path: <linux-integrity+bounces-5574-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD0A7A0B2
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 12:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C4E1897D1C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 10:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D5924BC1A;
	Thu,  3 Apr 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGWnilcY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035924A058
	for <linux-integrity@vger.kernel.org>; Thu,  3 Apr 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675011; cv=none; b=sS9XRVHIm2lz9s/QV4vLMEFLhl9sEMyW/oXxZZm0Bo1GQ2BrXHHSB/sxozZ+KXQbJFUaONmXp3/LpnIcngFXTMNWguf+PJUkFIbbOOgfgxgK5vdSpNR/UQawUmtzZiUUp2GtoVvmDrggGJ8wA7EqUm7eprVQGEyUs/2tLYAKNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675011; c=relaxed/simple;
	bh=95AbKM5/KwL2zVTjvGMvU2UbnZhLAbo6VoxnM/Vc07I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+uI18ZJ9cMbsyCsCqiXO30ScgmWbI7Sf1etW8fUiOwZZ73wKuZHl2eCdjrORVGtJQ4PCvA+AoEqLGGg2yAWTjdx51IdcoPrmQrOsG0Zdz51x0KieUFVmBPHP7qClOBvxBqWrmrhGfqHZPyW9wmtLHdTsubKSfTi+3bg4c3ZcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGWnilcY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743675008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qB/CtSEwcy7NwseWKn2u4Fr2QuPsDAEv+lGIosiLsww=;
	b=dGWnilcY6e6Q4wLc/9BfKyPmm6wst1sylrT4GvYEA6MyXmAnJ35j8a2WNY37Knh+ek+Z+E
	FWTiIg9iMsZ1sDi5pEAqtFepOt/iZuVmVR0CANiLVHzSZ3GJK4fpKQLsJGETNGsP6ol9gr
	Yii1gaGBApxkI6yQMc00gEBiuJAbL/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-wVEFx0wpMl-MqdKyHtLBHw-1; Thu, 03 Apr 2025 06:10:07 -0400
X-MC-Unique: wVEFx0wpMl-MqdKyHtLBHw-1
X-Mimecast-MFC-AGG-ID: wVEFx0wpMl-MqdKyHtLBHw_1743675006
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso567553f8f.2
        for <linux-integrity@vger.kernel.org>; Thu, 03 Apr 2025 03:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743675006; x=1744279806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB/CtSEwcy7NwseWKn2u4Fr2QuPsDAEv+lGIosiLsww=;
        b=pNVQ8JLyZ6PYMwfhQ/PC7yVnGV+RD0VguYGVROBn+eAMAI/dEVDI2Yplq2obYc2av3
         rASoqw9/eGY4oOA/PGcU9gT1vQOEpXa5NWYH38VxNtzGcCJvwTLzLPEx7kQjwfkzi9rO
         EC+v6am5ALPwarFT1xxuIPH6onyKrLVCyoHCzm1YrHQXdFXqy+bki7MAeiJN6yofTcJx
         WOpfGQ8aFjUnx/9W4yA2ByaaFHjWNdV+afwgS8p3s04k01OS6LW6n/utcrYPCNZUVaHP
         Ov92kNE6kKDMtiLl642+2+jAj0OcsT4baHSUsAQxG+PsHnuGamKUaPSKP5dZO4YHQFeV
         qhnA==
X-Forwarded-Encrypted: i=1; AJvYcCVoJcUdNnsnZtDKhkT8d8AXRWepHpM8AIaY97gnSG03NNbgGGozZtDfGgf0gvwRv/0W8pGjWltK/07to2LTxLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZO/zGXGLb1ObovBDk9x+crLlmi+50Dwf2VLwZ5RSl/J8dAmQ
	J59XCUU26hQgc5SnMdcFXXPcATpjdpqW6E2zIi3zyr81w6XMBtnxO0kjYytto8Tj9LbWl/lol7c
	yoOrfa/TJ2vjUyaZSnb959hz2YA3lxbhNrK2PdMRnAcYUvp+PbVM+QHXV4SgyPKTzyw==
X-Gm-Gg: ASbGnctabLGtawkhSdVRMJzz+vaoiz9KILeTw0eaxh9wDFxBjmT3qbsDH6+IlYzInp1
	cz+JXzzZLy6/TBWH/27oQqT0zjiNNwfB26STqr9peT/aMw/CQ2/HLtCtlq5yq8ErBnf0/3/TXE3
	85OUdfcO9o33SQ1oJtVnOH1oVLZhPIwHxLyOr7w9nQDrAPcAkldzUNGdNK8kXFvAJrIbEbtsPXu
	RueCGFca5ZQHRS43XbMoFIiEUsyh+897JBU6ljP8jdp7PI/D+gu8fpFvIoySx5Dkw6AQ4cuUUqh
	gNkXpBvXk2XTC6rV6Gfjzc94X9DIhxBJXCrpjP7ktJXdCoCEamwmc0hSWspa
X-Received: by 2002:a05:6000:144d:b0:39c:268b:8b66 with SMTP id ffacd0b85a97d-39c297e3f7amr4552179f8f.43.1743675006281;
        Thu, 03 Apr 2025 03:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECepLnUWcbOzJjNcNGIqxQwtp6LRHNvjNkwMgWLkILIn8YR8+ktWlYOnrFo0WoqQvUci03UA==
X-Received: by 2002:a05:6000:144d:b0:39c:268b:8b66 with SMTP id ffacd0b85a97d-39c297e3f7amr4552121f8f.43.1743675005738;
        Thu, 03 Apr 2025 03:10:05 -0700 (PDT)
Received: from stex1.redhat.com (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec36691b3sm13702755e9.34.2025.04.03.03.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:10:04 -0700 (PDT)
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
Subject: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Date: Thu,  3 Apr 2025 12:09:42 +0200
Message-ID: <20250403100943.120738-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403100943.120738-1-sgarzare@redhat.com>
References: <20250403100943.120738-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

SNP platform can provide a vTPM device emulated by SVSM.

The "tpm-svsm" device can be handled by the platform driver added
by the previous commit in drivers/char/tpm/tpm_svsm.c

Register the device unconditionally. The support check (e.g. SVSM, cmd)
is in snp_svsm_vtpm_probe(), keeping all logic in one place.
This function is called during the driver's probe along with other
setup tasks like memory allocation.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v6:
- added Tom's R-b
v4:
- explained better why we register it anyway in the commit message
---
 arch/x86/coco/sev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index efb43c9d3d30..acbd9bc526b1 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2689,6 +2689,11 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
+static struct platform_device tpm_svsm_device = {
+	.name		= "tpm-svsm",
+	.id		= -1,
+};
+
 static int __init snp_init_platform_device(void)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
@@ -2697,6 +2702,9 @@ static int __init snp_init_platform_device(void)
 	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
+	if (platform_device_register(&tpm_svsm_device))
+		return -ENODEV;
+
 	pr_info("SNP guest platform device initialized.\n");
 	return 0;
 }
-- 
2.49.0


