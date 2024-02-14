Return-Path: <linux-integrity+bounces-1207-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF0854D0A
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 16:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48551F2183D
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE35D73C;
	Wed, 14 Feb 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YuVe+QzZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495C5D489
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925118; cv=none; b=l7QoJRorLB1PqYFAYdWq0VIh0LD+203wnorOZelMWcB8M1Pqgc7CqH3aUjaiHiki/4DPNn49TSVGT3NmjkcUWVxXvmpYkPD0bDrlzM1I1uHvYjMsxqTtbuCDkQ1Qh5vHxbhU4C0GiFkeGS/vldcHGNAwrfR+f0V5bg0GXFIBObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925118; c=relaxed/simple;
	bh=LFOE4QfHLCoZdqDBOYLliesLUmy3zpjFlCHbtirdXv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cD6HrcZ4qR93K57F9zk+e/ItbPE8DrTY4z4iccySgl6tUOkQ2EgR2GNOGTOToXfIIi86OCiXfUAG1qngxgCpoxIwuq59zVnt7jlOFU1TU3cI4e0zIGPqyB1On3RpfFb6GO/Obo2ExtYAmyByc30ivL7WFAtqYqkfmmjgCtn3WM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YuVe+QzZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BF4D20B2007;
	Wed, 14 Feb 2024 07:38:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BF4D20B2007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925116;
	bh=CcMxEE00BfbxjifOUQ879ZZ/YFkEWU5bGzGcN0fH3v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuVe+QzZsWcw/2ZScAxIBKZeRZXUJEP0aDYGy/VTZgW1CRMx+XpsRt+2nUDQZT4+B
	 9opK1/PJ9+bPqAK4CFP7CmQBkLfkCW91yj6oqqBu18v3brCrmVKpvBPBkkzEo69ght
	 1J+XwhAXIRR/lIFPMwZq7NuSpfeGOas/V3LA33W4=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	stefanb@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v5 7/8] ima: make the kexec extra memory configurable
Date: Wed, 14 Feb 2024 07:38:26 -0800
Message-Id: <20240214153827.1087657-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra memory allocated for carrying the IMA measurement list across
kexec is hard-coded as half a PAGE.  Make it configurable.

Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
extra memory (in kb) to be allocated for IMA measurements added during
kexec soft reboot.  Ensure the default value of the option is set such
that extra half a page of memory for additional measurements is allocated
for the additional measurements.

Update ima_add_kexec_buffer() function to allocate memory based on the
Kconfig option value, rather than the currently hard-coded one.

Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     |  9 +++++++++
 security/integrity/ima/ima_kexec.c | 15 ++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b98bfe9efd0c..4c0fc53d6aa3 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -320,4 +320,13 @@ config IMA_DISABLE_HTABLE
 	help
 	   This option disables htable to allow measurement of duplicate records.
 
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int
+	depends on IMA_KEXEC
+	default 0
+	help
+	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
+	  allocated (in kb) for IMA measurements added during kexec soft reboot.
+	  If set to the default value, an extra half a page of memory for those
+	  additional measurements will be allocated.
 endif
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index dbeeb7f1355e..50903d4ce880 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -126,6 +126,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	unsigned long binary_runtime_size;
+	unsigned long extra_size;
 
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
@@ -133,15 +134,19 @@ void ima_add_kexec_buffer(struct kimage *image)
 	int ret;
 
 	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
+	 * Reserve extra memory for measurements added during kexec.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
+		extra_size = PAGE_SIZE / 2;
+	else
+		extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
+	binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
+
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
 	else
-		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
-					   PAGE_SIZE / 2, PAGE_SIZE);
+		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
+
 	if ((kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
 		pr_err("Binary measurement list too large.\n");
-- 
2.25.1


