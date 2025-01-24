Return-Path: <linux-integrity+bounces-4650-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E7A1BEB4
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 23:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4787516E652
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27451F666B;
	Fri, 24 Jan 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hclP+hYP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5FB1EEA33;
	Fri, 24 Jan 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759361; cv=none; b=ly4hUNcTTzEwA1RJFq0QJuq5x9CHH2vTHb2UYpjecfSFxTjmv3inttUWM5i9rkKCKpb/NCPf3ysd0+adVLj5xZCFzj4oX1JElCz3pBA9H1ggBxEAZOeZYBHg56DHLym/p01KEj9KK7eYSHEIGbih69Et/j5QaRK1gMllyX7u4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759361; c=relaxed/simple;
	bh=jn33izLaF7k8JTTLeThaIMhJzaisLVYTCVaFAQihJ4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEgRFsjbEAYLkATQHrUofUltHs6z918SimMq1JNyKXqkQma49OU6+KFwaB7L4lBCtBntPSIPqLWmKZZtsPe3PPWpbBX1LD7ItqxFCYW/3XCIP2Tmbm9tHMon4KeJ67N/LUaP0Q7MtnWFOo55i1oOJ2XSPGVMEErscGKZTL3OIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hclP+hYP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68750210D0DA;
	Fri, 24 Jan 2025 14:55:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68750210D0DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737759357;
	bh=geSM+tomMYqqRJERm+x35GcWFvYZOAcnOC3d66dp8xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hclP+hYPoyj8XW/nWcBq7fLgSVGucxR0CRqhP1mEID5bUbhwVJ5PAAcjIymWRpwDb
	 bCQnWYqibvGvsk8Yz8MYggbGJl4IG3uGKY4IVhxl99lbuejikpUD3e2KL1WjrfroWQ
	 8ynRjfPMnV8w1+725wWfVG/EfcOcLZ7jhj3+cwdo=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	petr@tesarici.cz,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Subject: [PATCH v6 6/7] ima: make the kexec extra memory configurable
Date: Fri, 24 Jan 2025 14:55:46 -0800
Message-Id: <20250124225547.22684-7-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250124225547.22684-1-chenste@linux.microsoft.com>
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
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

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     | 10 ++++++++++
 security/integrity/ima/ima_kexec.c | 16 ++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..7dd2ed8b2cdc 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
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
+
 endif
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index d5f004cfeaec..c9c916f69ca7 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -128,22 +128,26 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	unsigned long binary_runtime_size;
-
+	unsigned long extra_size;
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
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


