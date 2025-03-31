Return-Path: <linux-integrity+bounces-5527-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9575A7646E
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B53AAF63
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D711E282D;
	Mon, 31 Mar 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDTR2abu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9801E2611
	for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417568; cv=none; b=mlqbuxc8WCWlwXRnrSIjuZxNH6qjovXrCXaMKzK7rcnBhNNogNyRGk58JMHA5TIrt+Scye8TZjL5PTVPUR/g3X9r4Ky2izkddqld82+jRtWhrnPca/4RaVcueSq6COjjjyX1WEe3FuVkFcc7p4tz2YD/Za+SftjrxweG9Rn6h64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417568; c=relaxed/simple;
	bh=VSwSVqTTPnbOpmlHq9MOfH3OWqH+XBMIsW4BP4w9E5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5a06MHj7q4K1+rPEC6+hgctRnx10wiciq6H+iEsqHtl8o2LJgPAbbY2+rq0TEBnoAgUeb1czsznc4tZCFS4KkOczmYDmnwIMXDWVX7Ve7FzPpggsFhmFbWyXdxZFUqqB0/rGceH9iEAJz5+7Ey/pSp/eFijhepkzxdKtsQdIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDTR2abu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743417566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fxR3joWDLb15zwEwdHZI3rgw4qmSYJti26bFJQ+VcA=;
	b=dDTR2abuBMhJ7BPvSjBen389FXqRaX8eFKtYaB/wW6VATeN5rchBdhRF15NLNlDpOD5f1S
	NWrkqvYmzCxmMDSuT6kTtkZIqxT8PgsqwLx2V7nVjGftPQQghSx8y5RBefY34zYx5uni7n
	CsneboKOyg5mxm7cS6t3i2cRXLIc+4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-LlPalZp5PVeTGH31KuBOeg-1; Mon, 31 Mar 2025 06:39:24 -0400
X-MC-Unique: LlPalZp5PVeTGH31KuBOeg-1
X-Mimecast-MFC-AGG-ID: LlPalZp5PVeTGH31KuBOeg_1743417563
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so7647125e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 03:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743417563; x=1744022363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fxR3joWDLb15zwEwdHZI3rgw4qmSYJti26bFJQ+VcA=;
        b=hyjuzsEGJu9EKV97G0IYcmK9xMUZs6ZhtesKwLl8aJ0ijPyiwSsIRq8gqye6y5g6Js
         e7uV8WfsVvp68KahM4i/b4ZQVGycHvlV4TdmR+3q5Lydlfir1ma4ENVoXqOxds6f/Q9c
         e52YZG8PrMofFQYUnd7IPilqyFE0VcsIMxlTqoB76ddSrx1dZ5wwd8k+7mdVQJrbi3xz
         b7tS9PIR7wtcsJ9iXtH8gyBhRKgDwJybi3f9ELFO4hBcW/V4VphA0UeHJ8lZyjJ3EUmm
         T2fMUl7DOWw1ELC2PQPjy2Lvzz1vcp33KHl555BRL7rh7yWwOwtOgPIFbziBxHeGYy5j
         Qd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/vwQuhQAlck5Z8rtPsojS2AMPecr2IriXciva7rVomqGHrEVzrj1VDKxdg8YSXqC6xFV1J+yaoXKxSBQEdyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IwMTwNtSyhWIUNq5/ym5wa5HVB7c3kgslP27EGCqpSiXLpa3
	qcHvrN9lBZ+Cmg4O56hDjTfe3xMnjwhirhek3GPQW87bvGZZAOuXhErsILrnQ52kmdN+YokZd2L
	+OZMvXa0M9GcDx/KxI+I5P5ziws8wyzjPqQ9WdNs0TNwkxKLUVe/Zs6sv9KFhePKkug==
X-Gm-Gg: ASbGncuM0GFLuQefWsdcWTagSAarVxXnVRMo+PbHJwS7Cw+nSXaXJDCltfChXXjQCbj
	QlfbIECSOtjZkuWZgqL/txg2yI+NC9VZ+rHekmlX6i4SXTeeDAuftWsjppmMmMMk7Sr9n69caEv
	kK/jVuiwmtotLl3qEK82x28/w/tQTt8v1YBi+50HZP8OEIf5hT18h6MmJ90Uj0B/rMLS1t/TyNF
	9ako+mG1j0ZpfOtskZImgoOZZ16jhC0Xd9AupviLfXJY/Bu0gCnjwfthjHCc1E1mK2brhyThXq1
	soPkV8J/y97BjYjcc9Oh/qM8gEFwCAc52pEiNcs4gqIeeQNmCXhq80dvNEGK0UaeJw==
X-Received: by 2002:a05:600c:1d83:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-43db62bf772mr81331215e9.29.1743417563543;
        Mon, 31 Mar 2025 03:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSEY2IAvMlONrWW/ecIZqpU4KW8seEtaraLsrYv8QTUi3aO8abB8sFiMZjGmzhLkOrU2UPdg==
X-Received: by 2002:a05:600c:1d83:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-43db62bf772mr81330855e9.29.1743417563067;
        Mon, 31 Mar 2025 03:39:23 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66363fsm11273542f8f.36.2025.03.31.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 03:39:22 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	linux-coco@lists.linux.dev,
	Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <jroedel@suse.de>,
	x86@kernel.org,
	Dionna Glaze <dionnaglaze@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 4/4] x86/sev: register tpm-svsm platform device
Date: Mon, 31 Mar 2025 12:38:57 +0200
Message-ID: <20250331103900.92701-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331103900.92701-1-sgarzare@redhat.com>
References: <20250331103900.92701-1-sgarzare@redhat.com>
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


