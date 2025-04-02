Return-Path: <linux-integrity+bounces-5554-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2175A78F03
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 14:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75A11894DEC
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A8D23E34B;
	Wed,  2 Apr 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GtRTizlI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABE623A9BB;
	Wed,  2 Apr 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598072; cv=none; b=At+bhczFbqPqToJV4+Z9809ZeyB+Y+Bz/RwCBpd2/IOBbj/eZ0URBViAQprYDwKFMmVNKQqYrb9lNwcT4vadFl2iPiV/VxOW0Uhr/sXssi1F1vjE3MwlaHE3SPn9XgLB8PgOJU+WB+KsumGhec8EIEQ7ZFHuxwPoE3ChS3DhVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598072; c=relaxed/simple;
	bh=UJARWayehLsjZgGqf0RmGLlvGyEW1VUvommtCqeX4Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSQyYGzNXqzplFPN8mMq1dhLT3F4hu9IOaTCDb4LazFF9bvcegLTGj+XhmjAzJ9/VHoz1kg2QtBaw1E8unF5YOFZcbx2VCJ2ZLRGNndwIXBzf5oLtq/N0F9/4p9T0bu39/RjASncIYGvAPN7ZmPZgFHlSQ5x6Qw8B6d1nJLSi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GtRTizlI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id D4A412041304;
	Wed,  2 Apr 2025 05:47:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4A412041304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598070;
	bh=vEw/LreqQOxRk2U8fSqzR4thwxp7A3QOtHmi4q7KOMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GtRTizlIYLiPu/gEQNWmihR/pySHx3nmYZ4ceLusbrt3hTu79kPiO3ZEhNoVY1l/F
	 gwibjdMU9ojf1gSoope+Up2tNXS+wzmwkZl5KDK/RVzcVpxgFubtvGqdAj7uJUTlh5
	 r+8O74/ReycP1R6AIAhUH6H4Y3XqLPWUrk+sJlck=
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
Subject: [PATCH v11 6/9] ima: kexec: move IMA log copy from kexec load to execute
Date: Wed,  2 Apr 2025 05:47:19 -0700
Message-ID: <20250402124725.5601-7-chenste@linux.microsoft.com>
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

ima_dump_measurement_list() is called during kexec 'load', which may
result in loss of IMA measurements during kexec soft reboot. Due to 
missed measurements that only occurred after kexec 'load', this function 
needs to be called during kexec 'execute'.

Make the kexec_segment_size variable a local static variable within the 
file, so it can be accessed during both kexec 'load' and 'execute'.
 
Implement the kexec_post_load() function to be invoked after the new kernel
image has been loaded for kexec. Instead of calling machine_kexec_post_load()
directly from the kexec_file_load() syscall, call kexec_post_load(), which in
turn calls machine_kexec_post_load() to maintain the original image processing.
 
Invoke ima_kexec_post_load() within the kexec_post_load() API only for kexec 
soft reboot scenarios, excluding KEXEC_FILE_ON_CRASH.
 
Register a reboot notifier for the ima_update_kexec_buffer() API within 
ima_kexec_post_load() to ensure it is called upon receiving a reboot 
notification.
 
Move the ima_dump_measurement_list() call from ima_add_kexec_buffer() to 
ima_update_kexec_buffer() to copy the IMA log at the kexec 'execute' stage.
 
When there is insufficient memory to copy all the measurement logs, copy as
much of the measurement list as possible.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 kernel/kexec_file.c                | 11 +++++++-
 security/integrity/ima/ima_kexec.c | 43 ++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 606132253c79..b3eb515ca051 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -201,6 +201,15 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+static int kexec_post_load(struct kimage *image, unsigned long flags)
+{
+#ifdef CONFIG_IMA_KEXEC
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		ima_kexec_post_load(image);
+#endif
+	return machine_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -428,7 +437,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
-	ret = machine_kexec_post_load(image);
+	ret = kexec_post_load(image, flags);
 	if (ret)
 		goto out;
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e79f6caf895b..5c3b3e0b2186 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_IMA_KEXEC
 static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
+static size_t kexec_segment_size;
 static void *ima_kexec_buffer;
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
@@ -72,9 +73,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 		}
 	}
 
-	if (ret < 0)
-		goto out;
-
 	/*
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
@@ -94,7 +92,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	*buffer_size = ima_kexec_file.count;
 	*buffer = ima_kexec_file.buf;
-out:
+
 	return ret;
 }
 
@@ -112,9 +110,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	unsigned long binary_runtime_size;
 
 	/* use more understandable variable names than defined in kbuf */
+	size_t kexec_buffer_size = 0;
 	void *kexec_buffer = NULL;
-	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -139,13 +136,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
-		pr_err("Not enough memory for the kexec measurement buffer.\n");
-		return;
-	}
-
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -173,7 +163,32 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
-	return NOTIFY_OK;
+	size_t buf_size = 0;
+	int ret = NOTIFY_OK;
+	void *buf = NULL;
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
+	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
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
 
 static struct notifier_block update_buffer_nb = {
-- 
2.25.1


