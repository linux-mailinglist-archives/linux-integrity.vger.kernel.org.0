Return-Path: <linux-integrity+bounces-5906-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE05A8ADED
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 04:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3967AB48D
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7422A7E1;
	Wed, 16 Apr 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QIUb+A9f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BD22A4E9;
	Wed, 16 Apr 2025 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769460; cv=none; b=rK03i1aRLTzYF0CTcsaqKyQIcylrShTouIR5EFhBpW8R6D1fI5J0B7J3yMuCKhzedojHWhWA354DdctgEwIENiDmo/c7C+ThaemBDyk8COaV4XcfgjTshyK4A+y9Wte6opzMtohC9HeHkgLMmoCffoy0/ZPkHHXBLIhe7uvSRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769460; c=relaxed/simple;
	bh=eXrF6JnpwJfPwfzs7q2RnurNJhCBMKGF1xMqb1PJx4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIInkSjrWKD3GCuVNdngSnNaCaUulETZUCzxCYjeOtqxgrf3dZ/pG6XiMQ23nYBzvq6aeJRTM55n6snmzeWHcm0CZ9j6t6VgWDerlys3IxTgnPJTR99yhfGV2gwrrVjCfmlAnhTzXMXVwN4LXE9EXfNK5y6j3v2dHg2GTEqTv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QIUb+A9f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7C47E210C457;
	Tue, 15 Apr 2025 19:10:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C47E210C457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744769458;
	bh=fx+xaZU9e25U64HpKx5SwrfV2Guz44FPpYxs9CSnSsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIUb+A9flx9ZsUEfw8QVvxqfy4E9OmqoHn+ALSNEoXhrY03DrnjJZ8QrvI4XDlJ5O
	 6nAJWozujIWJmHm0f5BWKfNn5AZg41p7lomBX4OyYXV1hJuvdScfNYyjYVO9oxs/rx
	 jyQdHv+3Oh6cCIAtwONjJ698f8uqoucTHcuOSTrA=
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
Subject: [PATCH v12 5/9] ima: kexec: define functions to copy IMA log at soft boot
Date: Tue, 15 Apr 2025 19:10:23 -0700
Message-ID: <20250416021028.1403-6-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416021028.1403-1-chenste@linux.microsoft.com>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Chen <chenste@linux.microsoft.com>

The IMA log is currently copied to the new kernel during kexec 'load' 
using ima_dump_measurement_list(). However, the log copied at kexec 
'load' may result in loss of IMA measurements that only occurred after
kexec "load'. Setup the needed infrastructure to move the IMA log copy 
from kexec 'load' to 'execute'.

Define a new IMA hook ima_update_kexec_buffer() as a stub function.
It will be used to call ima_dump_measurement_list() during kexec 'execute'.

Implement ima_kexec_post_load() function to be invoked after the new 
Kernel image has been loaded for kexec. ima_kexec_post_load() maps the 
IMA buffer to a segment in the newly loaded Kernel.  It also registers 
the reboot notifier_block to trigger ima_update_kexec_buffer() at 
kexec 'execute'.

Set the priority of register_reboot_notifier to INT_MIN to ensure that the
IMA log copy operation will happen at the end of the operation chain, so 
that all the IMA measurement records extended into the TPM are copied

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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
index 7e0a19c3483f..e79f6caf895b 100644
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
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
 {
@@ -162,6 +166,49 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+	.priority = INT_MIN
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
2.43.0


