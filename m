Return-Path: <linux-integrity+bounces-5299-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D4A66493
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 02:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602987AA5C1
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554617A30D;
	Tue, 18 Mar 2025 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jbwYYcq3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB114900F;
	Tue, 18 Mar 2025 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259919; cv=none; b=eEbjaOhE4tXjdPqIuzwNe+YztUL8SsHEKzCiO3tNYsLa9LDwJu0JkgCThTZo1Yej7tenq9hniJ0oWt+Fs4QLckm+hBKFwgoCQ5Hm0amltBTPzZzqDOtKafTRmFVFkfREUl0orSTg1el2BWIzQOTUccSqGdLXKmzHXqJJKSS5jAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259919; c=relaxed/simple;
	bh=5nZEY0j7i8mG4u8/1CGV9wSIM5zPgjiJtsL7mh9u+14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heDk5UYLluHmNSFxFr1XQD4M6cB9bkyta7ufzck+PpUVlBVogxKjlQRjTJtk0epcYY8k4NqpPcZfJsAg2600kH4RPD+xSj3PyjXyAXAu8bOZ5QtdOrxFm7D4q/sldxbVtDD59F/OLTP+Crn2O4BuGEnaG7tgRMV3fntS8xo9yVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jbwYYcq3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9CBC420DEACD;
	Mon, 17 Mar 2025 18:05:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CBC420DEACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742259916;
	bh=IW0Tu0Ypw9GySYV1UEKgWFwAzFcQAPCZdi7ximAPf+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbwYYcq3e97cftHkYSAVt3lU/Dj/B8sjz4cZGM2uYIqNGl2qNuFCtIeTHHXgPIRaZ
	 IKNJclGefNBl9okI8i70sKcBeolZid1rXmm9hIBVDNU+vAlfF9w3aeV+47qbMRt65E
	 PeadlIkzXZQO4H0N4liWWeS75PH0MXgyJQlXZfo0=
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
Subject: [PATCH v10 5/8] ima: kexec: define functions to copy IMA log at soft boot
Date: Mon, 17 Mar 2025 18:04:43 -0700
Message-ID: <20250318010448.954-6-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318010448.954-1-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMA log is currently copied to the new kernel during kexec 'load' 
using ima_dump_measurement_list(). However, the log copied at kexec 
'load' may result in loss of IMA measurements that only occurred after
kexec "load'. Therefore, the log needs to be copied during kexec 
'execute'. Setup the needed infrastructure to move the IMA log copy from
kexec 'load' to 'execute'.

Define a new IMA hook ima_update_kexec_buffer() as a stub function.
It will be used to call ima_dump_measurement_list() during kexec 'execute'.

Implement ima_kexec_post_load() function to be invoked after the new 
Kernel image has been loaded for kexec. ima_kexec_post_load() maps the 
IMA buffer to a segment in the newly loaded Kernel.  It also registers 
the reboot notifier_block to trigger ima_update_kexec_buffer() at 
kexec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 include/linux/ima.h                |  3 ++
 security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0bae61a15b60..8e29cb4e6a01 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 34020b1513b0..9336c4f60650 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,10 +12,14 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
+static void *ima_kexec_buffer;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
 {
@@ -191,6 +195,49 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
 }
+
+/*
+ * Called during kexec execute so that IMA can update the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
+	return NOTIFY_OK;
+}
+
+static struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+	.priority = 1,
+};
+
+/*
+ * Create a mapping for the source pages that contain the IMA buffer
+ * so we can update it later.
+ */
+void ima_kexec_post_load(struct kimage *image)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+
+	if (!image->ima_buffer_addr)
+		return;
+
+	ima_kexec_buffer = kimage_map_segment(image,
+					      image->ima_buffer_addr,
+					      image->ima_buffer_size);
+	if (!ima_kexec_buffer) {
+		pr_err("Could not map measurements buffer.\n");
+		return;
+	}
+
+	if (!ima_kexec_update_registered) {
+		register_reboot_notifier(&update_buffer_nb);
+		ima_kexec_update_registered = true;
+	}
+}
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1


