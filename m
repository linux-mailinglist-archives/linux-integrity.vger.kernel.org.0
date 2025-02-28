Return-Path: <linux-integrity+bounces-5020-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51097A49FEE
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AD9175F29
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760EF1F4CB5;
	Fri, 28 Feb 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzOeph8c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC951F4CB2
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762499; cv=none; b=iP5WdQLSL+77BDIZ485rItHX/afrbSmOKpfFzuPd7fHtrj2mdtRsQFKhRsn6WHH69xVjGRMYt4C5BFKkDMFkmpqKMLOzLyw9DGHFEUvm2RQALCfkUnuSuDjsqs4BeiXnncpbbyTGF+XTA61yKK/nWa5d55CGNn93OVahcqyQlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762499; c=relaxed/simple;
	bh=qJd0Z4j/r1sbdRqfPYytxXq2rpI9PhS6oCSmMOfbFOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8tKjUZZM0A5IYEZ5ApcdZ0H7I2qlLgjr5ySGNBhDxWMXd1bG3hwksdcLs3DtIgFsuaBcZv6NnIZFjVwD6JhQirEMJkEJMVMvbOuFpbw231m/SGgSLrwMjF0SGnWs0wSbSDdCHI8MFn1dgN6sNwIvpNxB0CRqik5slBKgxUhRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzOeph8c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnSy+8VlJ8fotBQ+d996WFV/2A3QtkEvLLAc1C6w9D0=;
	b=PzOeph8cxuZG+OqWjsU9Kp7ozJ4LTa2qAQ/mtkP65huM5iAnhIo54EqsAExKaLubs6KdI4
	qXyMR35gmT5wuC8WfDg557EKrWgJ7iYdaM96QAm5mGjDk4+LsxQGtdG3b+vwqQcZxNKL4d
	aY910g7QVGa8Hu0NvRB65T+D3IXE+9Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-I7i-OaIWOQeyFAiv3mzhgQ-1; Fri, 28 Feb 2025 12:08:13 -0500
X-MC-Unique: I7i-OaIWOQeyFAiv3mzhgQ-1
X-Mimecast-MFC-AGG-ID: I7i-OaIWOQeyFAiv3mzhgQ_1740762492
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f628ff78eso1386330f8f.1
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 09:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762492; x=1741367292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnSy+8VlJ8fotBQ+d996WFV/2A3QtkEvLLAc1C6w9D0=;
        b=ubQmzMnvtq4brlxRRkH+NKLcKvsXzjHoH2xS58prr5NomRZQQtlSJluqOw49vYOd7m
         cs9UOJOZC2jeHH6oFkLGkEeCYT7c/LlFbmzDrXEp07N7kJLv7hsKnfVaeH7S0czJUXTe
         nkgYWX44VuJ4TDfGAjtJbP0/+9usIYrfOkzIplBlXg35hPe0BXXaioDwGqrR+9sl4H1R
         GsEzXxe2jnQh7J7xstFTELCCxGJU4+BEe+7CfFLz0+kbISXd4GFR0uCJYHzrscw0OI/W
         SSIr6kVB8EicoD7fBezZlji+okkcxqw/CwZs+MrLFa4cLz0BQygMWe/Bqe3i6KSWZIMU
         +lOw==
X-Forwarded-Encrypted: i=1; AJvYcCWO7898FDCKpQ+JbT1sO/akGbfZEaXtskF0hYpuhb8cPVbql3dOSteKlH4p6xZnaciMQzKfPm0tUuk2tdzMZJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiaAJtzhgTwlxy0KSPtPORZxvlwwo0QWEaoSHnG6KE/pS9HIJ
	ca0psOQ5Si8jtMw46sFY82B3vNZtyOkd67SvBTqcmFoZj+qgAIkwDe9RWspnqfdVrnUdeFiY6Cg
	sasVorUYZCUxSCUXTfHI9giw0BM2v7bF0q94jKB1rr1WsMKhwx0tkGv53JTXJOW6OCg==
X-Gm-Gg: ASbGncudWLSKiaF7osxq9S/ZTak8foU+5LIApWZGV2UOjsLRyym1OKeosWRM7GAsdBy
	HUg9fAfNp4OHIrHNWAYWPRzuYs3aLFdEbxl7Hzjuz6c+48FvqHy2MOQty5hzbE4xXrYCtr4K1TL
	DZs1AkjJ0TJ2rzD1OQtLCFljYUTRLC07FM9m7bafHvZ2sl5wHnLhYB94gr/LTZwrUDGDEO8IV+K
	8AXacZZPaWyT7mplcaDtPJxq+5JheGtqAjOJkxtTA1hI+ENWoySSr+wQEe9TJLroKV8Q0riIvos
	tltwnJJfLuNWjJ+I6X6E
X-Received: by 2002:a5d:5847:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-390ebf7f818mr3864165f8f.0.1740762492228;
        Fri, 28 Feb 2025 09:08:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzR5hk357PFuAqN46Kj8Gt6yD0kfZMjS/ZQgfr804lPGex0gArLFn/VwUHjTCi7DihJcYMUQ==
X-Received: by 2002:a5d:5847:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-390ebf7f818mr3864097f8f.0.1740762491681;
        Fri, 28 Feb 2025 09:08:11 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm5912302f8f.60.2025.02.28.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:08:07 -0800 (PST)
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
Subject: [RFC PATCH v2 6/6] x86/sev: register tpm-svsm platform device
Date: Fri, 28 Feb 2025 18:07:20 +0100
Message-ID: <20250228170720.144739-7-sgarzare@redhat.com>
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
index 4158e447d645..7e91fae7d43a 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2680,6 +2680,11 @@ static struct platform_device sev_guest_device = {
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
@@ -2688,6 +2693,9 @@ static int __init snp_init_platform_device(void)
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


