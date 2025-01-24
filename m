Return-Path: <linux-integrity+bounces-4649-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1129DA1BEB3
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 23:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924C27A3458
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 22:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FE21F4710;
	Fri, 24 Jan 2025 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FbSTWpys"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122AC1EEA43;
	Fri, 24 Jan 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759360; cv=none; b=RtZ0i5+W9QljPm5a2c9h04l9EC6ZrKST3NFp0HDF/2olplE1VkNlpZBk7P9Z35ahd4R4BwuKUYg0Awkw0IwlFV0/6LpjCtr2fv89pZT9Uoax5lK1p+hlBB6QHojyRoUfJ9i6foJv1BkT47MtamToeeImlJH0sSvH/QZ4NN6beSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759360; c=relaxed/simple;
	bh=Pxre783PzACACeV34ZisP2a76BNcKKtQ+N5YCrzjsfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qLtF43Q6iZY32U1lWOGqPgFYfVIY0ESuQgZCvf/o46nqzC2JFr4KUtUWjpyFafcDFxrSkqgEdfdLZwae29E+eQPNAp8zNrPWpKUKTZpd8ob8uny+WoaEQYboqxb1ogNtn1cEPtX24fAwuug1bf4NfJxYP1jrBEAlsxgJmCmFyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FbSTWpys; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 35433210D0D8;
	Fri, 24 Jan 2025 14:55:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35433210D0D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737759357;
	bh=SToxeWWYWW6LWJe1NQgF6XwKRGWLZYBJcF4B7FrieaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbSTWpysH5IZGaxG2nIWAj17VFWOJEM+rzPr2XTkuwbKrd8kaWJXPTtI70i/Ag8iB
	 Mrs30XiGb6bALgfqq4x47ZFIgqn1tLN1OJ+d64VTqr7RXV6NKJeR5+TMSjitw4rxgO
	 x3S4BY9Xy0qU1CYifPUGe6tHUSb92zdFlmKrCSOk=
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
Subject: [PATCH v6 5/7] ima: kexec: move IMA log copy from kexec load to execute
Date: Fri, 24 Jan 2025 14:55:45 -0800
Message-Id: <20250124225547.22684-6-chenste@linux.microsoft.com>
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

ima_dump_measurement_list() is called during kexec 'load', which may
result in loss of IMA measurements during kexec soft reboot.  It needs
to be called during kexec 'execute'.

This patch includes the following changes:
 - Implement kimage_file_post_load() function to be invoked after the new
   Kernel image has been loaded for kexec.
 - Call kimage_file_post_load() from kexec_file_load() syscall only for
   kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
   map the IMA segment, and register reboot notifier for the function
   ima_update_kexec_buffer() which would copy the IMA log at kexec soft
   reboot.
 - Make kexec_segment_size variable local static to the file, for it to be
   accessible both during kexec 'load' and 'execute'.
 - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
   to ima_update_kexec_buffer().
 - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
   that the buffer is being copied at kexec 'execute', and resetting the
   file at kexec 'load' will corrupt the buffer.

Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Tyler Hicks <code@tyhicks.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 kernel/kexec_file.c                |  8 ++++++
 security/integrity/ima/ima_kexec.c | 43 +++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 4ff3ba0f3e8e..d05ce3ee2e53 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -186,6 +186,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+static void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -413,6 +418,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 854b90d34e2d..d5f004cfeaec 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_IMA_KEXEC
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
+static size_t kexec_segment_size;
 static bool ima_kexec_update_registered;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
@@ -131,7 +132,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -156,13 +156,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-					kexec_segment_size);
-	if (ret < 0) {
-		pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
-		return;
-	}
-
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -180,12 +173,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_segment_index = image->nr_segments - 1;
 	image->is_ima_segment_index_set = true;
 
-	/*
-	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-	 * and it will vfree() that buffer.
-	 */
-	ima_reset_kexec_file(&ima_kexec_file);
-
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
 }
@@ -196,7 +183,33 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
-	return NOTIFY_OK;
+	void *buf = NULL;
+	size_t buf_size = 0;
+	int ret = NOTIFY_OK;
+
+	if (!kexec_in_progress) {
+		pr_info("No kexec in progress.\n");
+		return ret;
+	}
+
+	if (!ima_kexec_buffer) {
+		pr_err("Kexec buffer not set.\n");
+		return ret;
+	}
+
+	ret = ima_dump_measurement_list(&buf_size, &buf,
+					kexec_segment_size);
+
+	if (ret)
+		pr_err("Dump measurements failed. Error:%d\n", ret);
+
+	if (buf_size != 0)
+		memcpy(ima_kexec_buffer, buf, buf_size);
+
+	kimage_unmap_segment(ima_kexec_buffer);
+	ima_kexec_buffer = NULL;
+
+	return ret;
 }
 
 struct notifier_block update_buffer_nb = {
-- 
2.25.1


