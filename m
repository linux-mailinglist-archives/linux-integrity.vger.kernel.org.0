Return-Path: <linux-integrity+bounces-5990-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88732A95952
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 00:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD203B86AF
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CC022ACD6;
	Mon, 21 Apr 2025 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HblA7erz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743122A7FD;
	Mon, 21 Apr 2025 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274351; cv=none; b=pi0Q+P3wDF7Kd8TahH/eWSy/rC8BCCzCg/oQCR0qymoBbTECu4fiKtvg/RNt8fUJan86QCEooBDtTapqv+sLkDQ96Lazd5ovbDDugnfc9bH9PEtxJ+snd+Qoy2714k4LzIwVztUvf6oChHU7jaN8q+sahPqVcIfZPuy1JAXlqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274351; c=relaxed/simple;
	bh=dFGYlucEXVkl8DsYbpSy4lEmNV+cAEt2H3cP5S3BbWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+Ob7GIzYjYlY4UsrcQMkc6/4B6QsuEQnd78RO2lM6NnXIi7bHgrU6JkGOR//jT0BaPXsllw66J5PwWIulEFGNgV/PUbMDV2TZ2j7Gyehm8a9jDNfrcQc+75rZORE+P87DNFsLC5kztVm9+HwksGyiBjITPGqV7kTZ6Da8ItH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HblA7erz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id C735B203B86A;
	Mon, 21 Apr 2025 15:25:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C735B203B86A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745274349;
	bh=9dF+KrrSsEWjZm7q8suAuuEUgBlazjWvcfAeNPEq8Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HblA7erzDI/26dTatiIXv7UuD2KDrwSVOzeC94Ab03iJKoqgE/INCVDaAS4XfiDvg
	 St0HHSSJRQ3ehCg6JS3WJVdUzDpa8E5Q6AhrAg+PHun5jgtHFtKq6ocg5D9uuIrtun
	 rvRxVNuNRddib3ziKQk1HXazjWW9ipRjxzAIoTUM=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v13 8/9] ima: make the kexec extra memory configurable
Date: Mon, 21 Apr 2025 15:25:14 -0700
Message-ID: <20250421222516.9830-9-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421222516.9830-1-chenste@linux.microsoft.com>
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Chen <chenste@linux.microsoft.com>

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
Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 security/integrity/ima/Kconfig     | 11 +++++++++++
 security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..976e75f9b9ba 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -321,4 +321,15 @@ config IMA_DISABLE_HTABLE
 	help
 	   This option disables htable to allow measurement of duplicate records.
 
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int "Extra memory for IMA measurements added during kexec soft reboot"
+	range 0 40
+	depends on IMA_KEXEC
+	default 0
+	help
+	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
+	  allocated (in kb) for IMA measurements added during kexec soft reboot.
+	  If set to the default value of 0, an extra half page of memory for those
+	  additional measurements will be allocated.
+
 endif
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index ed867734ee70..d1c9d369ba08 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -118,6 +118,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	unsigned long binary_runtime_size;
+	unsigned long extra_memory;
 
 	/* use more understandable variable names than defined in kbuf */
 	size_t kexec_buffer_size = 0;
@@ -125,15 +126,20 @@ void ima_add_kexec_buffer(struct kimage *image)
 	int ret;
 
 	/*
-	 * Reserve an extra half page of memory for additional measurements
-	 * added during the kexec load.
+	 * Reserve extra memory for measurements added during kexec.
 	 */
-	binary_runtime_size = ima_get_binary_runtime_size();
+	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
+		extra_memory = PAGE_SIZE / 2;
+	else
+		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
+
+	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
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
2.43.0


