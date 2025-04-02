Return-Path: <linux-integrity+bounces-5556-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E2A78F08
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 14:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768D61894DA6
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8523F406;
	Wed,  2 Apr 2025 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rNCzdP9d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA3F23F26B;
	Wed,  2 Apr 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598077; cv=none; b=FxnyM6VKZnjZsQet4L/GO1yMOTil0Ude9raKVoqqRiKc+GUAja4WD/VsoVpTSgflXgO+b0KBrnWZ97eX1P0pbMpT7mLXWq5Box3ynxqknfjqwSmrnSpFzy7A7FmzDaSlmiPX3Oj9uGhbJ3KiNx21OY1MSE4AierzPXVO3GDADpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598077; c=relaxed/simple;
	bh=CKWrEBn3PtQ8x/toSXWJ4Dxu6mytJnYkI6qhOJskz78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3LRuoS4q70BM2tdyR+GDtDQY21upW6ojYGu25uduIkVsNDTfefGSgRpnUmWljEFrqn+y0jho9GdHAA0KEfrOhwM0BxeS+FMwxKCtlyh8lho3urIVarUSZollpbL4m4rhSLGwDDTFHYhJMgvUSqi/KEeiorALtZtOlucd4yv9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rNCzdP9d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id D3F0C2041310;
	Wed,  2 Apr 2025 05:47:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3F0C2041310
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598075;
	bh=akIJhi5dOsbPwjFtHYsWPzeWZ2NiSa/DdRwiLCQ9Fbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNCzdP9dHIJ0owIlx8+IhWD9u+n9u7qJfksu7jR/sDVdDhlBaAj9YGY+qIKJu6qe+
	 m0CV0LLATNeXBWXvKHF9nLIIdf6iyPRtCYZBOlSju/5NftIG59OdbEUSwNDpp6HgJ8
	 UlGkVOlj4WuolTyrf5WwPtYeb5Db5uqM8DxwDrec=
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
Subject: [PATCH v11 8/9] ima: make the kexec extra memory configurable
Date: Wed,  2 Apr 2025 05:47:21 -0700
Message-ID: <20250402124725.5601-9-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402124725.5601-1-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
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
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/Kconfig     | 10 ++++++++++
 security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..d73c96c3c1c9 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
 	help
 	   This option disables htable to allow measurement of duplicate records.
 
+config IMA_KEXEC_EXTRA_MEMORY_KB
+	int "Extra memory for IMA measurements added during kexec soft reboot"
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
2.25.1


