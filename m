Return-Path: <linux-integrity+bounces-1205-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3EB854D08
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 16:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A41B1F21A4D
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCD5D729;
	Wed, 14 Feb 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X36gxMzU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286445D467
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925118; cv=none; b=ngCmj1fOnBEWxNBRo6WPX0Qn6epyfSHWAw/NgK8RP5YpKMdYXzvMcpe+Uq7fNb0RbxILMxE4JsPQ2JPm2mAy3ts5ijDMLaeXe3DVFV4ILdzdEa+jA/G06spQdTVNXFIRj1931hB7FM/QDHX4plGj3Gz9Fq7+E7DyPRdps4xqnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925118; c=relaxed/simple;
	bh=2FUau0fiARE/5o6MdioIQEDQ2ej6OVBys6g2KKA9RZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q44cio9wk2Bq4BFL4TtC2UD+giQUoBhuNiDUxX7uJA4jdlBTrqinkHLsi0IKwKt1tDLs+7tCO8/yy6X8J/7tx2gjONZdUYhkPKZlZs1n2xMYs1ebMrcfEdTKN8WzkvESNyRWf1e4/MdvzysBwCughEDxJC2/9/0am/jsegFsbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X36gxMzU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF2F120B2005;
	Wed, 14 Feb 2024 07:38:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF2F120B2005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925115;
	bh=ZlIccf7Ox9/YKL2es1yXhbAiKARAN1cP73a//eRxN5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X36gxMzUPc70JtXNRuKZiHxPx50rW99EylvQtZD3RWl+bRX+tsTbjn+LjZ7HUbx0G
	 xhBnsOojVkxrp3OgqaL9nXPxm8cK1wvt4lqGA6+q02kR3zucWoOOn8sUqW+cHQQ+Ji
	 2yji3N+cGifW/1Y+syvRgjjsR1pm7SpdSbdZiKZU=
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
Subject: [PATCH v5 5/8] ima: kexec: move IMA log copy from kexec load to execute
Date: Wed, 14 Feb 2024 07:38:24 -0800
Message-Id: <20240214153827.1087657-6-tusharsu@linux.microsoft.com>
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

ima_dump_measurement_list() is called during kexec 'load', which may
result in loss of IMA measurements during kexec soft reboot.  It needs
to be called during kexec 'execute'.

This patch includes the following changes:
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

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c                |  3 ++
 security/integrity/ima/ima_kexec.c | 45 +++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index fe59cb7c179d..2d5df320c34f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -410,6 +410,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 1d4d6c122d82..98fc9b9782a2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -19,6 +19,7 @@
 #ifdef CONFIG_IMA_KEXEC
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
+static size_t kexec_segment_size;
 static bool ima_kexec_update_registered;
 
 static void ima_reset_kexec_file(struct seq_file *sf)
@@ -129,7 +130,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -154,14 +154,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-					kexec_segment_size);
-	if (ret < 0) {
-		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
-		       __func__, ret);
-		return;
-	}
-
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -179,12 +171,6 @@ void ima_add_kexec_buffer(struct kimage *image)
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
@@ -195,7 +181,34 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
-	return NOTIFY_OK;
+	void *buf = NULL;
+	size_t buf_size;
+	int ret = NOTIFY_OK;
+
+	if (!kexec_in_progress) {
+		pr_info("%s: No kexec in progress.\n", __func__);
+		return ret;
+	}
+
+	if (!ima_kexec_buffer) {
+		pr_err("%s: Kexec buffer not set.\n", __func__);
+		return ret;
+	}
+
+	ret = ima_dump_measurement_list(&buf_size, &buf,
+					kexec_segment_size);
+
+	if (!buf) {
+		pr_err("%s: Dump measurements failed. Error:%d\n",
+		       __func__, ret);
+		goto out;
+	}
+	memcpy(ima_kexec_buffer, buf, buf_size);
+out:
+	kimage_unmap_segment(ima_kexec_buffer);
+	ima_kexec_buffer = NULL;
+
+	return ret;
 }
 
 struct notifier_block update_buffer_nb = {
-- 
2.25.1


