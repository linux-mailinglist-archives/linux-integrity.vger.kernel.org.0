Return-Path: <linux-integrity+bounces-856-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A95837199
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 20:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579591F31C48
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DA54FA1;
	Mon, 22 Jan 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i6bZdDnO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF41EEE6
	for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948699; cv=none; b=cTvYYDHnmfs1G9vB9gKS/RMmrzWCYi2wbXrY5PS6VNuzq/3XuuoKQ0SkzVKu26mGNyRQ7ADRbAiRMXZZ6XjIapgssQagbCTx4q/6Mfmjc6CWoBZzIvn0MTMnITlc4wOWjZE3BxkeoNaWqxAlIsi8qUt0ats4WA6V/H50IXjxl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948699; c=relaxed/simple;
	bh=1n1MKNgcuPRuU7/9FcH1bapvw/KyXKCCKQ04Iq1awwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVBr1nqUtRjbEDy6p7HMUrIDVNYyPEBohOcTZcdR4hZpxZ7/VDL9AWEZXDcz5DxaGR2X3hleauKQLH/00u06/bUvruLjtB59IUvBJSbb1iv1Cjrr/YjQbSKdzZyZ/m7NTOkTQkvfnLwOZgGAZhwvAk3/nBkBnv2dqXRXPKzkp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i6bZdDnO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5ECEE20E2C2D;
	Mon, 22 Jan 2024 10:38:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ECEE20E2C2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948697;
	bh=5BIJyIqOWqL1PpqhjQ9R7fLK9sgsyoZbpX8td5qK1ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6bZdDnOIAkXP/YVHYOVijxEWyMpuiKNZGcrV4nQgSHoDzDLAEEFjASjVM+/TtNao
	 I8jH2mM41aTPrIAF1Arf+sKUUjlLr2qfzsBRQ8KlrUNUrWG/zKuPnOUuN+Euj1P8Sp
	 0tu8a2epnV4WJ6K4gdbWkEl78ESP1/Mqws4VRSZw=
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
Subject: [PATCH v4 7/7] ima: measure kexec load and exec events as critical data
Date: Mon, 22 Jan 2024 10:38:04 -0800
Message-Id: <20240122183804.3293904-8-tusharsu@linux.microsoft.com>
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

There could be a potential mismatch between IMA measurements and TPM PCR
quotes caused by the indeterminate interval between kexec 'load' and
'execute'.  The extra memory allocated at kexec 'load' for IMA log buffer
may run out.  It can lead to missing events in the IMA log after a soft
reboot to the new Kernel, resulting in TPM PCR quotes mismatch and remote
attestation failures.

Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
measured as critical data at kexec 'load' and 'execute' respectively.
Report the allocated kexec segment size, IMA binary log size and the
runtime measurements count as part of those events.

These events, and the values reported through them, serve as markers in
the IMA log to verify the IMA events are captured during kexec soft
reboot.  The presence of a 'kexec_load' event in between the last two
'boot_aggregate' events in the IMA log implies this is a kexec soft
reboot, and not a cold-boot. And the absence of 'kexec_execute' event
after kexec soft reboot implies missing events in that window which
results in inconsistency with TPM PCR quotes, necessitating a cold boot
for a successful remote attestation.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 34 +++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index c126aa6494e9..1f8b697f4ed0 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 128
+
 static struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
 static size_t kexec_segment_size;
@@ -33,6 +35,10 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size;
+	long len;
+
 	/*
 	 * kexec 'load' may be called multiple times.
 	 * Free and realloc the buffer only if the segment_size is
@@ -42,7 +48,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	    ima_kexec_file.size == segment_size &&
 	    ima_kexec_file.read_pos == 0 &&
 	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
-		return 0;
+		goto out;
 
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
@@ -55,6 +61,18 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
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
 
@@ -181,10 +199,12 @@ void ima_add_kexec_buffer(struct kimage *image)
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
@@ -196,6 +216,18 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
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


