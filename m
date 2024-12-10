Return-Path: <linux-integrity+bounces-4328-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E69EB37A
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 15:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FB91888B26
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B41AF0A3;
	Tue, 10 Dec 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxgMOsZF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF11BCA0F
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841292; cv=none; b=tf0G/aAy70LxgAJnkxvp8hlz+R3OzjangBukejcgU/jS5nLqb12clw39kMjrBTe3FRDb2P8Y1n66+ytZey0llOjO8Bm8Z4yFLeIB+W0gXujsy8WfPkzzUsifq/9MvMwtHVKOZpVLJEJuYqHmkLTp1EvJrxoKt1M9xyYIXklV+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841292; c=relaxed/simple;
	bh=hKVfthvsa17ETqwzM+IPunkLwW1BQ0tuuiDhl+vst78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0Go1odDxW5K8+j9xYse/LEl6H7ranUvvfUCR9C8bnEU9BnZ8uE+qdI3I1cVv+oFH3wwloMe3Qu97NaQp1z2Z3+GtH9Zl3PALuWqh1yW7rU42LPvUzuTp0bmi9vWUw77XauM93wlXg7iiek7Kq18Ajs6M8ln5ugmO76E8RA3oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxgMOsZF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkig53CpkMCs8xZ5GQefN+G8yQyR6/dGUcen+HDOvno=;
	b=SxgMOsZFrRk8YnC7YJIl5DBBmlXfH3wqwjhLOwNp5s6MjUQ6sW1W1ybjjKhtLYDty86Wej
	7c1GR3Eovd8vDR4EAyAvdr+X5dMCVFjygLZb9TSxA5rCQkPXEqpZEtiXdPvxy0mnxUUN91
	u9+tyz+XrWJsK9384eMuF0HixuzwgXs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-EeLB0WxoOAmsI9IiQRZ_Vg-1; Tue, 10 Dec 2024 09:34:48 -0500
X-MC-Unique: EeLB0WxoOAmsI9IiQRZ_Vg-1
X-Mimecast-MFC-AGG-ID: EeLB0WxoOAmsI9IiQRZ_Vg
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d889fd0fd6so103892546d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 06:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841288; x=1734446088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkig53CpkMCs8xZ5GQefN+G8yQyR6/dGUcen+HDOvno=;
        b=Xz7RTdeI9nb6lD8c3pgM3FggPSYZO80rfvbHIq0QTH9PTsSLsTaypjflBCcOUzgvJa
         +M3wjhiHFu/aVfrbWFHYAvPV4jC9Rsr5yBMI64SAgaf5hvVUn88ScklGo30tG6K1gUJn
         k1N7ddByvVZzawpkn9h8AcwrsCFUxYnCwENlluDfAiXJJUXxWHs9BXO2ueD6wvkyIlQw
         mjX6aSIzpqcVw8nItAc5oeCbMxKiL25c4HDE+HzQSrhXPQQlKjzO2RJLPyfjkijvBitl
         x9RhuRRXzb5VUL/LCmwnycGnxBWrafIxr2wPuAj8uk4QJSFAGeabpNNG3dS0ivBXI5hE
         44Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWbE5TlmUwCDwmQDh8VdAplARSSIaYmcgijsrCDQUkvj7vI0KpB7tV3d6cvXk48HZGiso+6zSLSAC79iz37YaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPKMU9xpUFWvHHFj97tBbSlPTIjGcP7c6QB1keDs2+oYTrjZe
	nYK+9/Z8sD/RzRIdmVa2+Mhz5mW1mpmicZOpemxoCHQALNDpehc1kHWkkgYTnZwV/dselwIlTXD
	1lLr2lhzc9CTahw5pRRreRAJPLkVO0dMqPqAQB34sG5T1AmejHALiKGiMpxBsr0YBGw==
X-Gm-Gg: ASbGncvkIAwj+CT+kXfWzCA4XCvtjwlm1XAdsuh2dcEYLAuQJBEt1j6K7bl0C7LvbOU
	ySKAhOhnOk4ebl1AZTKWsP5zekW/IdWhIEnu+WeDYEdLgqNK23SQnT+yvgKnGH1CGt937iEoPej
	cGC8uS03yv+KsXBujq9abAGy4XUtkDt6cvhSsfLhI/dqqUJzVKhcKdDtRrAjHn5SAoBMza/hS0a
	8bnQIC6tueuhH4phF97UmerI2zr8s/O9up77/XlpM6jjbCJ2jO5PN3FhaKSi7zthPcQ9KQOYzAg
	D2FS0vNSIco3H+sML2MzDsRGq/t3qzc=
X-Received: by 2002:a05:6214:5087:b0:6d8:f50e:8036 with SMTP id 6a1803df08f44-6d9213ba859mr65685806d6.20.1733841288302;
        Tue, 10 Dec 2024 06:34:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSop28FY6IektnPFRQjQ8gA1PitVY9Yf0WUJf69W1zgtjztC/5xoivV4T26/rVtmO6MIg6TA==
X-Received: by 2002:a05:6214:5087:b0:6d8:f50e:8036 with SMTP id 6a1803df08f44-6d9213ba859mr65685226d6.20.1733841287948;
        Tue, 10 Dec 2024 06:34:47 -0800 (PST)
Received: from step1.redhat.com (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dac1434esm60163516d6.124.2024.12.10.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:34:46 -0800 (PST)
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
Subject: [PATCH 2/3] x86/sev: add SVSM call macros for the vTPM protocol
Date: Tue, 10 Dec 2024 15:34:22 +0100
Message-ID: <20241210143423.101774-3-sgarzare@redhat.com>
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

Add macros for SVSM_VTPM_QUERY and SVSM_VTPM_CMD calls as defined
in the "Secure VM Service Module for SEV-SNP Guests"
Publication # 58019 Revision: 1.00

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 arch/x86/include/asm/sev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 91f08af31078..97dcc8d938a6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -365,6 +365,10 @@ struct svsm_call {
 #define SVSM_ATTEST_SERVICES		0
 #define SVSM_ATTEST_SINGLE_SERVICE	1
 
+#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
+#define SVSM_VTPM_QUERY			0
+#define SVSM_VTPM_CMD			1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
-- 
2.47.1


