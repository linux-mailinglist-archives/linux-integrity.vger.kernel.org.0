Return-Path: <linux-integrity+bounces-1206-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C55F854D09
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 16:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315001F2189C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30305D733;
	Wed, 14 Feb 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CwcSJxEj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607225D47F
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925118; cv=none; b=iF8S7FoWJgGcHKV8ugoi3NmjYU44aXwKuqxfWQPALLO1xKHPDfD/NY3Lg/Vv/DoswwPTwJdsrXX+qaQnYbXJcxEFmYX2ZDjSsfrwH9/GvjJJvWNxtftih+5D+xlCitLadDnuor4oHevR2RluHf9+ip5ptD1zFPS2gXCTVfNUqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925118; c=relaxed/simple;
	bh=Xz/+z5gr8HifANxnPt07MWN2+HV0YL5BY94izlFqzuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKTRLyz7tiZZPcyMEQke+tS4b76zPWKdu63KNlFd1XVDWgt7MzTtuUpcH+MUGNNjHysU9HEUXaE7BaG1Nc+mytA8D62ct5l8F5SMOWjsNDSaBgzsYMVdG+X2A2BW2hAlQTPJ03s4ehy82Nd1C++dv/mx2nKSh3B3Yt9YVPFK14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CwcSJxEj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A72D720B2008;
	Wed, 14 Feb 2024 07:38:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A72D720B2008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925116;
	bh=S9UPRKSI8CaypUVC1iW3GsRtiy2NP5QedIfKvKIgtkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CwcSJxEjSO3aOk2cfjVq2nAr5tWEi4lkIw/dfuT8gZHa3sgbAQQcspcW9byYZ3ZAN
	 /thdUY/PcC43kJZmltp1yb+WU7yKgbXt3XEaPw3lD0a3CM7JMfia0wVo0QfgaFLlSu
	 4mVXPshTUUh9s1HNZyOwzx9ddDBkkSDZf0msx11A=
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
Subject: [PATCH v5 8/8] ima: measure kexec load and exec events as critical data
Date: Wed, 14 Feb 2024 07:38:27 -0800
Message-Id: <20240214153827.1087657-9-tusharsu@linux.microsoft.com>
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

The amount of memory allocated at kexec load, even with the extra memory
allocated, might not be large enough for the entire measurement list.  The
indeterminate interval between kexec 'load' and 'execute' could exacerbate
this problem.

Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
measured as critical data at kexec 'load' and 'execute' respectively.
Report the allocated kexec segment size, IMA binary log size and the
runtime measurements count as part of those events.

These events, and the values reported through them, serve as markers in
the IMA log to verify the IMA events are captured during kexec soft
reboot.  The presence of a 'kexec_load' event in between the last two
'boot_aggregate' events in the IMA log implies this is a kexec soft
reboot, and not a cold-boot.  And the absence of 'kexec_execute' event
after kexec soft reboot implies missing events in that window which
results in inconsistency with TPM PCR quotes, necessitating a cold boot
for a successful remote attestation.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 34 +++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 50903d4ce880..31495a043959 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 256
+
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
 static size_t kexec_segment_size;
@@ -38,6 +40,10 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size;
+	long len;
+
 	/*
 	 * kexec 'load' may be called multiple times.
 	 * Free and realloc the buffer only if the segment_size is
@@ -47,7 +53,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	    ima_kexec_file.size == segment_size &&
 	    ima_kexec_file.read_pos == 0 &&
 	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
-		return 0;
+		goto out;
 
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
@@ -60,6 +66,18 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
+out:
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+		  "ima_runtime_measurements_count=%ld;",
+		  segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
+				  strlen(ima_kexec_event), false, NULL, 0);
+
 	return 0;
 }
 
@@ -186,10 +204,12 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
 	void *buf = NULL;
 	size_t buf_size;
 	int ret = NOTIFY_OK;
 	bool resume = false;
+	long len;
 
 	if (!kexec_in_progress) {
 		pr_info("%s: No kexec in progress.\n", __func__);
@@ -201,6 +221,18 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+		  "ima_runtime_measurements_count=%ld;",
+		  kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", "kexec_execute",
+				  ima_kexec_event, strlen(ima_kexec_event),
+				  false, NULL, 0);
+
 	ima_measurements_suspend();
 
 	ret = ima_dump_measurement_list(&buf_size, &buf,
-- 
2.25.1


