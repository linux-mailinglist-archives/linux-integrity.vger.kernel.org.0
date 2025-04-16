Return-Path: <linux-integrity+bounces-5907-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA82A8ADEF
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 04:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145C044237D
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 02:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CDC22ACD3;
	Wed, 16 Apr 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A2CxHgyf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090322A7F8;
	Wed, 16 Apr 2025 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769463; cv=none; b=iB9R21+8p8x2uROwdtaFGc1otgTiWAFCvFRL2SvLjmVSqGqD3nKEsc4KdhxEJB/u5AVr2j3Vr+8OygbAyVA67D3h2utxI3tl7g4samJlwDEsVhPjkUUfxVqmUq0KHhYvHaEp7v6mAPSm8cVmBlrix3Ow0TELLRl3qGIr0pnUH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769463; c=relaxed/simple;
	bh=D+7b8WFZHomqKHY9Upv77AJy6l1+/aw2jq2Vx6fN/rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjOjPY/C690+pNWwUUgx3JuKtq6xP7kduQkl4NSs+s2A/NsHG2AeJRvdeYiJeLtBt7GfkFoiJOjiHbEgHuyf9yoBkrYwTfCsi1OuD0jWTHvUTafVAmw+Km8/EJzCiL8p5y08nbNMXfYX/KlKx8bQFutxZGx8yMmrppIfKXt5wEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A2CxHgyf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4C93C210C452;
	Tue, 15 Apr 2025 19:10:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C93C210C452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744769461;
	bh=cUYWDbQEz58/KBMdDmHtCxHfBj5IMnuJkOLEhvyrmx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2CxHgyfPQWjBZZo55Ahh/r3xRjYejGmXI7gEgRnDwYhJljPUw4mSDpoMCc1EK/rx
	 IsuhdCOjq5Z1ObXQ/3Ff39C/5OxVl0fTM2hisxLL09JSijnymRFyyDaNk4SYRwOJbQ
	 sSF3ISgy5hjlsAyoSjiWUqDXomtXGe8gBJAe3KYQ=
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
Subject: [PATCH v12 6/9] ima: kexec: move IMA log copy from kexec load to execute
Date: Tue, 15 Apr 2025 19:10:24 -0700
Message-ID: <20250416021028.1403-7-chenste@linux.microsoft.com>
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

The IMA log is currently copied to the new kernel during kexec 'load' using
ima_dump_measurement_list(). However, the IMA measurement list copied at 
kexec 'load' may result in loss of IMA measurements records that only 
occurred after the kexec 'load'. Move the IMA measurement list log copy 
from kexec 'load' to 'execute'

Make the kexec_segment_size variable a local static variable within the 
file, so it can be accessed during both kexec 'load' and 'execute'.
 
Define kexec_post_load() as a wrapper for calling ima_kexec_post_load() and
machine_kexec_post_load().  Replace the existing direct call to
machine_kexec_post_load() with kexec_post_load().
 
When there is insufficient memory to copy all the measurement logs, copy as
much of the measurement list as possible.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
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
2.43.0


