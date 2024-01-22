Return-Path: <linux-integrity+bounces-855-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF0837197
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 20:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933B31C2A6F5
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 19:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6254F9B;
	Mon, 22 Jan 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o7pEkKmy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B254BF8
	for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948698; cv=none; b=sKt0Bjg35qNGzqRLpBB+Rg7ZoTN+gTRtqr9qFso1i1EgVILWNH0Y9y1K35nB30VI5ZrbpSAXF8FZZa2xAaFOX5sZ9Lfk+P1rQnlxJC+UucAWA4BHrtibC1pEELYhg4xJ9/+t9XujM51/8ltSRtMWW4SnRqH+wzmGKWZvG2c32AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948698; c=relaxed/simple;
	bh=91c+43s4KhCEe2Xk8isUeIzI/isagYKoWF4C1zvSgEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F968Aw2VurDJRfuz2iDXn13Q6QAHy3MRF9xSkp8XcP6a5GalEAP9IeJMf4xHZBh2rSR+dJ8Lnyo14i2/WOJYZ6VeMqAV0oBO39NJkkAUJa7PNzF0KdjQiiSCncMS6Rp95QPAkN5EXm6ZV3FsBMGPAXcXjZccUqEXvvgrfvSSeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o7pEkKmy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id E763B20E2C27;
	Mon, 22 Jan 2024 10:38:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E763B20E2C27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948697;
	bh=qWdS8NNgz0MGlGCMbGxri5f+7iqORqYYJwxxs6oaIek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7pEkKmywyPkVQDCSStuFKrnTzeK2SvA6C4NRv28+Fiyhp1DdB5EeAgvp/HKaC1rO
	 PHfMIVtmjKQ2YOq5SCZ22bpbjNCTUEfZNUunNpGa7k/MedP+iYrJ0CdHWF9Qm3RYue
	 NKEN4EwgVWfbr8kaG9RTLrlke8RutyqojgTtTIEA=
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
Subject: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Date: Mon, 22 Jan 2024 10:38:03 -0800
Message-Id: <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra memory allocated for carrying the IMA measurement list across
kexec is hardcoded as half a PAGE.  Make it configurable.

Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
extra memory (in kb) to be allocated for IMA measurements added during
kexec soft reboot.  Ensure the default value of the option is set such
that extra half a page of memory for additional measurements is allocated
to maintain backwards compatibility.

Update ima_add_kexec_buffer() function to allocate memory based on the 
Kconfig option value, rather than the currently hardcoded one.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     | 11 +++++++++++
 security/integrity/ima/ima_kexec.c | 15 ++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583..fc103288852b 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -338,3 +338,14 @@ config IMA_DISABLE_HTABLE
 	default n
 	help
 	   This option disables htable to allow measurement of duplicate records.
+
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int
+	depends on IMA && IMA_KEXEC
+	default 0
+	help
+	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
+	  allocated (in kb) for IMA measurements added during kexec soft reboot.
+	  If set to the default value, an extra half page of memory for
+	  additional measurements will be allocated to maintain backwards
+	  compatibility.
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f26b5b342d84..c126aa6494e9 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -121,6 +121,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 				  .buf_min = 0, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	unsigned long binary_runtime_size;
+	unsigned long extra_size;
 
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
@@ -128,15 +129,19 @@ void ima_add_kexec_buffer(struct kimage *image)
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


