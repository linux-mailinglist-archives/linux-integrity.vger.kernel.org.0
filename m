Return-Path: <linux-integrity+bounces-5770-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC68A84568
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50EF8A2D71
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD16328C5BE;
	Thu, 10 Apr 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gfi3aRmW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFC28CF59
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293106; cv=none; b=YVxf8lVKkSGn569/p5Ukp/786fdBigIfKZExG2L7SiHfhXhBd2Wlkvkpi/hy7YxR3drRpstKn3G10kyXD+stcPJQn9FwN+K/e0D6S8B3duagODucwIj1lvcPTmdx2FxH8r3GTHSoZw8Q62f+lY6f9LKOs+A4LrCY1VoQmxKEVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293106; c=relaxed/simple;
	bh=jjdOFFgqlMZcJK0ENY0EeRcZvGY/PqG+Cg3KwCJxajM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT+SkUwTtLi/m9pRKX42rJqvpZGDXOD0JP9ClqPOI9azNjTcU1FNJg3Oh8A6iy4Ur284RVMYsm7PUp6EmyBRIQNmUzjB5dIxWZmrkGasY7gCIPf6afTpCvoBFPwDDioHXyzRYM1Xl9zYYfI5C0Vat1VWMmS/bVSnCSnFFnMb+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gfi3aRmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744293103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hirGwPCk5S8fr8wcRk+QWxpexKbLzBx8zDafwqq8PVw=;
	b=Gfi3aRmWaU2PwbOF4asO/LZwJwQ3yoD6Ai2dh0rwLCpC+xBsFMcsrHHneAS2kG2GI11RIi
	+k+65vkXvROTYRENdNzbAisILkI4egOfSl2KC8J+xB4aQaBzOHcBGitgS/URgz3zdPBYaE
	BSzqUr+dC1W+DOFfBRbxwEslYuqfO1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-QMlbOU8lNzi_oVBk0iq7cA-1; Thu, 10 Apr 2025 09:51:42 -0400
X-MC-Unique: QMlbOU8lNzi_oVBk0iq7cA-1
X-Mimecast-MFC-AGG-ID: QMlbOU8lNzi_oVBk0iq7cA_1744293101
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so7108965e9.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 06:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293101; x=1744897901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hirGwPCk5S8fr8wcRk+QWxpexKbLzBx8zDafwqq8PVw=;
        b=kSjtjQ7V4qsvUfMbGLHzf6dTxRN+fLjScITF5JUoRpqYik+RFDLBieto2n9PWb+D1A
         w6FHTGfyTpjA+E49uANrDTpeKS1PdYsAJEBV7nwLMcKbHnwX9Bv8hKI2TRYzxO9X6dhR
         rFfiN/JmbF+NUGpRbxoHTbgV6XsCVzfYi6vUBIm5zuPt5XBdm7FeONb6yfoYaBCu17DD
         0721IYpzVegnZ35DQUwObsDPqce9MDDQ7fajgAUpyxAqAPpoGsmEl9PiOq+LAY36XGpB
         e4hNTtwJlmecyNHr3sD8idGVjjLZQ/CuAkfzQQYrBXcwt/dBSglWd85sbGRZ5OdNxCVJ
         vUbA==
X-Forwarded-Encrypted: i=1; AJvYcCVNVABqrbISVWVIonsIYc2dURMK5NmS+xA12tDatwhM8H6xZhE5uhlHGk1RYUWVdcy2CMVZFasWTAr1X4ZiRaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMG01M5vaEeJ6gWBmfil2ueK2cLdLj5H+O/JtoLIFwdquBOb8
	Q8+mLjkIFBTD9i4M7lL/vduFNasbz/li7Huu8ML6I/d/D8X0CyLY2veu9MOIZctMKFGFjJWAwOb
	aLBaq7p6UaqLUiyAU3U9Pv2ammRQUEr03lhXNR6UhtB2ZprKE7vPE3ArZQSvl8V3iNw==
X-Gm-Gg: ASbGncv/BVqTubCSKJoJdgW9pQAikdsxbIhq4MzlphsNOj21nO1x1koYZp+BA6hi0xT
	gcA1bOavqf6DH4L7NQ4nT9Spwk3542GSG65VqJvQlxbmR7Dk+9p/ghKbPw7RjIU1LyQJR01DF5y
	NaPiLjTBE2KmKCucQWhLb/UMlu1LYvyQm5As12O3ALPdpkytrQkWrou6i+qcb+jqEAMVrqnMlD6
	3QauYHZVQNWtwDiubyPBgAzBQgUspUWrdfZIGTpMqTYfca5yUR7TXKWjUKbiyWVH8pRrbtYRndi
	u88URiZuDzNUrX7HCBUderB13DZu9i3v77aTgqY1M+I+9HY9KmDVTGh+skTVQA==
X-Received: by 2002:a05:600c:1e21:b0:43c:fa0e:471a with SMTP id 5b1f17b1804b1-43f2fdcece5mr23351915e9.5.1744293101427;
        Thu, 10 Apr 2025 06:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW/+UygbSs3rimVhsZR25l1U5u5O39Yy7PeRlqUDpdrrg1Z1uyMNvSAu+c2o2wo8JQdf6sGQ==
X-Received: by 2002:a05:600c:1e21:b0:43c:fa0e:471a with SMTP id 5b1f17b1804b1-43f2fdcece5mr23351565e9.5.1744293100851;
        Thu, 10 Apr 2025 06:51:40 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdfbesm4768782f8f.88.2025.04.10.06.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:51:40 -0700 (PDT)
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
Subject: [PATCH v7 4/4] x86/sev: register tpm-svsm platform device
Date: Thu, 10 Apr 2025 15:51:16 +0200
Message-ID: <20250410135118.133240-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410135118.133240-1-sgarzare@redhat.com>
References: <20250410135118.133240-1-sgarzare@redhat.com>
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

Register the platform device only when SVSM is available and it
supports vTPM commands as checked by snp_svsm_vtpm_probe().

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v7:
- added Jarkko's R-b
- call snp_svsm_vtpm_probe() before registering the device [Borislav]
- s/device/devices in pr_info [Tom]
- updated commit description
v6:
- added Tom's R-b
v4:
- explained better why we register it anyway in the commit message
---
 arch/x86/coco/sev/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 3bc5b47e7304..54272c9777cf 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2688,6 +2688,11 @@ static struct platform_device sev_guest_device = {
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
@@ -2696,7 +2701,11 @@ static int __init snp_init_platform_device(void)
 	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
-	pr_info("SNP guest platform device initialized.\n");
+	if (snp_svsm_vtpm_probe() &&
+	    platform_device_register(&tpm_svsm_device))
+		return -ENODEV;
+
+	pr_info("SNP guest platform devices initialized.\n");
 	return 0;
 }
 device_initcall(snp_init_platform_device);
-- 
2.49.0


