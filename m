Return-Path: <linux-integrity+bounces-5408-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362DA6D895
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 11:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527A11893E8F
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B825E46E;
	Mon, 24 Mar 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dppOvNLF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBE25E465
	for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813242; cv=none; b=tZWbk3SA3gl/SJlpmfcSvf9/0lb5xctZTl0BAL46na4viKCrZ5QJleJa9th1hFr6cGljx9lbALwMrLs0aiQUnq+czJG+X/eJv1Ex4/RbZLMvRGj2vskCkEOiJYJeKkQWYoaNAzq99SZLeWMPvbyj/PcMoX+SgkRgjODiV9ZkzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813242; c=relaxed/simple;
	bh=9z0RxKjeC8RwUmLb5SarlKv6HJUVpqk+rJh1s528L40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLeNeipVPEhZCBIhljkymk5knCY4Bw7AftOeGByF183OcelthrjL9BObO6Vvar4s8HNX4hChZAHb+AsX8j3OP5P2C8MVNBou69xNWVhPQNBwKobCwFxeltVUsCmh/F3A2ZuyLNuq9mS1P5z9/q5VIBT8LtOCX96p7Stjphh9yWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dppOvNLF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742813239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILxEYoeVE+MpXO0Glj+Y1U0EAxeFxdsejgciRSsrwF8=;
	b=dppOvNLFItHM6qTB60vUOhBgJMsV8FETTb9bV01Ww0ZI82zMbYT5R4f/wJ6IG0yxxFuTn8
	4Rg+lDQ+6JTBZbbcQXoWZQxpawLEVuzdtTLNB6ocBDjW8rS98grEAz6rRf0h4LXOwa0joO
	2yxk7Zi0IypmlxPXpWAjeKtlUOFzSHk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-tVS7VXkEN6Wn7Xb0iQpJxQ-1; Mon, 24 Mar 2025 06:47:18 -0400
X-MC-Unique: tVS7VXkEN6Wn7Xb0iQpJxQ-1
X-Mimecast-MFC-AGG-ID: tVS7VXkEN6Wn7Xb0iQpJxQ_1742813237
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43935e09897so27012705e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 03:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813237; x=1743418037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILxEYoeVE+MpXO0Glj+Y1U0EAxeFxdsejgciRSsrwF8=;
        b=wL44qIZZeM9ZFE53yd8MmarRviR19D3lHcVioMecJbUZ4MNhoObhsqDBeKrYdxH2ql
         isn2beGhD/dJHJY3hqO300jssdF3CTO1sR3kjbKSYJWcuOLxhgydWHVBGmmkQMg0M2GP
         mvOEdfR01eUYq1MKLQEFNEbgdjylqadmEdppleiHmiMFUsRfD+z1ithG5VXSOJrmyJ6u
         NzS965pVtwW+Dn+DSngjmpfjJx4yhQK+ifqvGuHLDVgLrBKisDNScFqkjfa7Mi27vGNF
         q7Bk6eEGT2IhLW8TmJAdiF7wii5LZsAnz46aP60+CeovJnhs5x7wcEM7Em0r2UAQD/01
         9ULw==
X-Forwarded-Encrypted: i=1; AJvYcCVxJN0TbTaVQCYDy2ZUTXiHcppUTuiVagw0ew3WfhUJFLmVxm6N1KMOjs1iLetLEIZURRuFDio0qgMXQ0Op2XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyajqcPQR1/UiRQtI3rHmrMJ6UMI0ePaDvSkN5DE95Fz8LVNakp
	EzIt18g28m7bWsPqS+2yGdxOPtgoPBqxytU/4e6Q0Q1gudWrCgG+Ane7NMHiCYxbvD1jXOc5tXY
	f1jwMQM+6CUAIinkzKcaN/Zgqy+spkw+bhYc8noN/O4oWX2vpgXplKgnWDxQdvzPCTw==
X-Gm-Gg: ASbGnctVifbLvWjP4DIk1+bdDyzdO6EVnwa9YfZt4NmNjqJIrAz1Jz8+P2hPgKZ+80M
	RYB3FT+TY2YTU5kIx2ZnQ2Q8AV9TBZRD7WgNHEjoPBsq3n2nHfefX8n+m/N8gb2ja20f97MbVBc
	OpwjaQdHQejhOdz20ve48kram1xXO9WyutcygjSkE9JxiVGaiasRyp/OY4pzIVfIg3nfBiWQ2VA
	ZdIZbEw4YNfabnnzgLBtYQ4ygVmrh0pM+h6GIjjnRfX4yzLVBUP7YvNV5zrZbEvTfOH0KkrFZ4Y
	IB14KvXGX6pe5qPyaKOU3YLOtOkwRHWEe7WTo6/PSGG8XiboxDeJvpGJvpTw1Y+6dQ==
X-Received: by 2002:a05:600c:1d9f:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d509ec5d7mr113154485e9.12.1742813236964;
        Mon, 24 Mar 2025 03:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWZa9wuN2PTDGpTipt3fq+aoFWpOBqvRgoGNR3/VEGSUJWm0DGpVCjLokA7c7167YRmdsfkw==
X-Received: by 2002:a05:600c:1d9f:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-43d509ec5d7mr113154055e9.12.1742813236335;
        Mon, 24 Mar 2025 03:47:16 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm118452815e9.25.2025.03.24.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:47:15 -0700 (PDT)
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
Subject: [PATCH v4 4/4] x86/sev: register tpm-svsm platform device
Date: Mon, 24 Mar 2025 11:46:49 +0100
Message-ID: <20250324104653.138663-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324104653.138663-1-sgarzare@redhat.com>
References: <20250324104653.138663-1-sgarzare@redhat.com>
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

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- explained better why we register it anyway in the commit message
---
 arch/x86/coco/sev/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 034aab7e76d2..0abcac87af89 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2692,6 +2692,11 @@ static struct platform_device sev_guest_device = {
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
@@ -2700,6 +2705,9 @@ static int __init snp_init_platform_device(void)
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


