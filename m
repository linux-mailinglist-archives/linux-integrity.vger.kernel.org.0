Return-Path: <linux-integrity+bounces-853-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807B8371A3
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 20:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451212950EB
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B954F80;
	Mon, 22 Jan 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fA3/ssD3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A354BD5
	for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948698; cv=none; b=eOmarQjQZHMUHe8gJXZ5603TR2k63332ZcZtpt7kiXCAvo0fftcw7bMMPxq1i21ef11J2VsuhYzCZOh4VnLZKUCRF8J+/DiGDNRINeJ4GEWA0niJFclPIsoaqpa4RZ1YqhmuWLvJEfPOGdZ71L1FcyXLm4y4JViMVxJFEmuGfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948698; c=relaxed/simple;
	bh=nG78O/3l48VAm0hkSSg8G9IsDmxxMPEZCe8NeDkLU/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtt55eTCXfaorywgoXuJgoxr11poo1JQk0o+IlCIUzhP8clwG1UjZG3jFhpC/vdYMD5XWUM/g+P3y2i3bWuE7VOszu7c7ocUQ3HWlLHuUzt7JvMeaYSCgRDxRBVuJ3+chQcxolgnTFdDsiR/q6EryxOjBdwH6Dks1pka5YeRnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fA3/ssD3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46E7920E2C1E;
	Mon, 22 Jan 2024 10:38:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46E7920E2C1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948696;
	bh=Vioe34zsK0dJO7/3HnBy+QyD5TmI5M0Zcz+q4dbfEKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fA3/ssD3T7v37xzv8e6aMG/kyda4oALnVI+T8J2c4xdDWqHQeGgrV2Vg5E6kwoQ3F
	 PvlOKaL4AABuV+Tk/Ail9HJ6eeBXYcvNqIA3wYIjPhfSIf87hrt70vAOxbjdYTmn5U
	 q1btsjOEBV72BSUUruY2xVpHIkQwq1Qor7Q1zL3w=
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
Subject: [PATCH v4 4/7] ima: kexec: move ima log copy from kexec load to execute
Date: Mon, 22 Jan 2024 10:38:01 -0800
Message-Id: <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
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

ima_dump_measurement_list() is called during kexec 'load', which may
result in loss of IMA measurements during kexec soft reboot.  It needs
to be called during kexec 'execute'.

The below changes need to be part of the same patch to ensure this
patch series remains bisect-safe by ensuring the IMA log gets copied over
during kexec soft reboot both before and after this patch.

Implement ima_update_kexec_buffer() to be called during kexec 'execute'.
Move ima_dump_measurement_list() from ima_add_kexec_buffer() to
ima_update_kexec_buffer().  Make the necessary variables local static to
the file, so that they are accessible during both kexec 'load' - where
the memory is allocated and mapped to a segment in the new Kernel, and
during 'execute' - where the IMA log gets copied over.

Implement kimage_file_post_load() and ima_kexec_post_load() to be invoked
after the new Kernel image has been loaded for kexec.
ima_kexec_post_load() will map the IMA buffer to a segment in the newly
loaded Kernel.  It will also register the reboot notifier_block to trigger
ima_update_kexec_buffer() at exec 'execute'.

Modify kexec_file_load() syscall to call kimage_file_post_load() after the
image has been loaded and prepared for kexec.  Call it only on kexec soft
reboot and not for KEXEC_FILE_ON_CRASH.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h                |  3 ++
 kernel/kexec_file.c                |  8 +++
 security/integrity/ima/ima_kexec.c | 82 ++++++++++++++++++++++++++----
 3 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..006db20f852d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -49,6 +49,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bf758fd5062c..ee38799ff1a3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -399,6 +404,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index d92a48284cc4..25150bfc7129 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,10 +12,15 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
 static struct seq_file ima_kexec_file;
+static void *ima_kexec_buffer;
+static size_t kexec_segment_size;
+static bool ima_kexec_update_registered;
 
 static void ima_free_kexec_file_buf(struct seq_file *sf)
 {
@@ -120,7 +125,6 @@ void ima_add_kexec_buffer(struct kimage *image)
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size;
-	size_t kexec_segment_size;
 	int ret;
 
 	/*
@@ -145,14 +149,6 @@ void ima_add_kexec_buffer(struct kimage *image)
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
@@ -174,6 +170,74 @@ void ima_add_kexec_buffer(struct kimage *image)
 		 kbuf.mem);
 }
 
+/*
+ * Called during kexec execute so that IMA can update the measurement list.
+ */
+static int ima_update_kexec_buffer(struct notifier_block *self,
+				   unsigned long action, void *data)
+{
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
+}
+
+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
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
+		pr_err("%s: Could not map measurements buffer.\n", __func__);
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


