Return-Path: <linux-integrity+bounces-5218-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB23A5BC8A
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B58173D43
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C72234969;
	Tue, 11 Mar 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTLKMVqi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB347233D99
	for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686176; cv=none; b=kXrbA92rP/4/3Iyc1Wf9y0IHcCPrFYcceK4iBBgb+VFjZf7CD3XJxhi0hNFgu3mNk/HElXVVwstXoEivELkQ4FVt2J0YywiRB7QK3xgkt6ZMOayj8NyigoOmFV+LW9CefO+rpkDE77wjihBh9slTLOT058ayduFxQ93qfOcW62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686176; c=relaxed/simple;
	bh=7ofinKFlIYAPL0uFGFVvSScK4HwNUlqf6CGOFX+txk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJfHY8cYBwbMjFM5Ck6OKnMnyyv9RJYhnPH2Z8ScvncEVvKW4JvWTovVm0qpDlJ2MlapgmAGcOtGW5seuSRl61Aop8jNalNgeR3278BcIbRc+8AjoXv0HM81BG1fbWZ9+8YUtOUYgVXBUDRMp3HkYMqDtbVQlcilTmImqc7g8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTLKMVqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hg6I6nIDb7vIFIV7ygI8oxn0FMZLdQaKjCFJAirlRo=;
	b=eTLKMVqiEJ/uM3bfCPoNZuwLUwwX/9QlV2/PEbZNI61cVSlybAVmNOAZ6UqWdzwvpiN+An
	2nuAu+8ezG8X5Z59uccVnhA8B4xdS2EHyI4xwBdROVCB3IrkzJ2P+OL3coFH1RuOHugJkT
	9bZFQSmeAKVIQfipGf6MJrk3W1JtY50=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-sb3OvskeMfeVQpCax2Zmwg-1; Tue, 11 Mar 2025 05:42:52 -0400
X-MC-Unique: sb3OvskeMfeVQpCax2Zmwg-1
X-Mimecast-MFC-AGG-ID: sb3OvskeMfeVQpCax2Zmwg_1741686171
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-abf4c4294b0so562780066b.0
        for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 02:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686171; x=1742290971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hg6I6nIDb7vIFIV7ygI8oxn0FMZLdQaKjCFJAirlRo=;
        b=OHUILyCVhzGIqHB/a7JzFdrf9bJNTHbiGO6XQHNfKC6S+0i/nfP2D/Av6QzEfIuDJQ
         VMKcszq+S9XPaSxiUgd1i2tfjWQpSotfZtUXQtf8oqsCepiRiffWGs9r334tCTaZcI+c
         7HI0aAgWmdn4sgx5S71eyz2WboHcYBCrIs/8LyM0uC3H+EMLrUirZh7yiN+ws4Y1H/+P
         3cmjWalBt8NWGzAIxGqawV/PiCVAN7v6IlYJao+GWEPExEGwNINgn6aZQNGxuZ+zHf16
         3dWzgswNtQ14hF929Ge7syh4HOds0XzAQ8HnNiVvAsYgsZ+foGi+1DXkuLHxWutwkuhb
         j7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXuO7RIo80Yaqrj5kUzsNr6pd1n6W/b/cLszWiimoqkgiWi1svfiYBZbJDNbIVOMqxxZH+X7CzseLop6ydcw8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQ3jBExgBYhxvKF4NmkGlENOrYQ8na7c/MaxPXZ8PKU9dWZJI
	C+IkzyaX7VPuSmAKN/rmDEJS+U8Gff2HQkqbND3cIWPHVeCd4Wp8QrVY368l2ZQFRmg+icdzTas
	trJCR5c5k7SAwfUjKK1PSdt00qJI0UXHlVplPUwqe/EW5C8LQy7VKYKEiiRl0rNpwpA==
X-Gm-Gg: ASbGncsYvMaR97lr+2TypKOwZEBMO95ZQcN6JusRdgJf6PxN9tBzG97ee7bTPBIvZ2X
	vFkCJlOSn58qO9P78Jmumz062IG9InN24131K8/UOdHMAu0aZe6PY0IxrqgMbgO66FexxJR4QYM
	59d43PCxLuXCOvdym2Ib7kSWW0eZaimbHPq9WtP1kd6h1jGIUaKw76IG8/LUgUTHtj4CpQavlYf
	Pa9zpzmzP2rABk0e8PiQixhFt9OfTjz24BLHrIPGquGh41NPg0N0wI2uZ0jnu46Teta7W2qjRzc
	eBRsnrqDS2e+bBuhGU2M99Tsjl0kvEl6OPr0UV4nA5c16P6mGS8uQT6uQoDEicDDkJx2tl4d
X-Received: by 2002:a17:907:a310:b0:ac2:6fc6:b93d with SMTP id a640c23a62f3a-ac2ba473173mr370177866b.1.1741686171317;
        Tue, 11 Mar 2025 02:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkmP0r13TRekW78HkAFefp5cjLkHl6Mq2Ghd/8jrWtGCOF1SbwGI8W62TAbwjYfxllk7Faww==
X-Received: by 2002:a17:907:a310:b0:ac2:6fc6:b93d with SMTP id a640c23a62f3a-ac2ba473173mr370172766b.1.1741686170721;
        Tue, 11 Mar 2025 02:42:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485bf3sm903753666b.63.2025.03.11.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:42:49 -0700 (PDT)
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
Subject: [PATCH v3 4/4] x86/sev: register tpm-svsm platform device
Date: Tue, 11 Mar 2025 10:42:25 +0100
Message-ID: <20250311094225.35129-5-sgarzare@redhat.com>
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

SNP platform can provide a vTPM device emulated by SVSM.

The "tpm-svsm" device can be handled by the platform driver added
by the previous commit in drivers/char/tpm/tpm_svsm.c

The driver will call snp_svsm_vtpm_probe() to check if SVSM is
present and if it's support the vTPM protocol.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 arch/x86/coco/sev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 2166bdff88b7..a2383457889e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2664,6 +2664,11 @@ static struct platform_device sev_guest_device = {
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
@@ -2672,6 +2677,9 @@ static int __init snp_init_platform_device(void)
 	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
+	if (platform_device_register(&tpm_svsm_device))
+		return -ENODEV;
+
 	pr_info("SNP guest platform device initialized.\n");
 	return 0;
 }
-- 
2.48.1


