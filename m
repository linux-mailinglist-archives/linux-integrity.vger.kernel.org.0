Return-Path: <linux-integrity+bounces-4709-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E93A267D2
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 00:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932DA1885CE3
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B89211A23;
	Mon,  3 Feb 2025 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aIMrI5P5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80C211464;
	Mon,  3 Feb 2025 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624845; cv=none; b=ilCjabFr4L9elR7Qsn7vTU+hQQKYNy1Wngxdq2VbkSxkgglxjgq7GX/H1rHb1ClyWrOrXP5f9FejiTLsjzB6OO76FO9XSK1TJ4fZCmOX/E1t+Kol7vCerAQcn3qCQHPyHEF3Z7Vm2yXjigoPP3Ee9XlDr2/GB1VNJyvvko9Yom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624845; c=relaxed/simple;
	bh=JMiCI7oEWpaNyaUwMo7rDIzjwYonTLm5E0qBtBtW4bU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+zOOS20uFbfRtkLwtD2kAWUHP5uS4nVRKVwT9Z84H6ygI37GHx24jb8+cQvTzrqPwLHvQXDI6Cd/mFvsnsM/dfegETW8z15A6Roqa4PyYRl8YmS4N8fBjPdOyodIyfrrVPzOy4eIKkvaGoiPT/LQtOhlIhq0pQ6MVP4nhtVSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aIMrI5P5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F1E3206AB6B;
	Mon,  3 Feb 2025 15:20:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F1E3206AB6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738624842;
	bh=0df9k6YmLXTRB5Kdzk0atr6aQfh11G9ejUhwNmP0edM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIMrI5P5jQFp3SkWuLFZoU4xQssnDnYZMmGVGLK5Y6MwYdla9BBM1z2oTeboFqy04
	 zux3/HPx6IuzMy0AIBkJJ83Pc+5gqMCW5vLyIUwBJDXXo397B8JPb/2fq9Wtkq8Pa+
	 srXK1Ps8JsG8cE//Axb8kd195BfPqDuZLNyyHLiU=
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
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com
Subject: [PATCH v7 7/7] ima: measure kexec load and exec events as critical data
Date: Mon,  3 Feb 2025 15:20:33 -0800
Message-Id: <20250203232033.64123-9-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203232033.64123-1-chenste@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
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
reboot, and not a cold-boot. And the absence of 'kexec_execute' event
after kexec soft reboot implies missing events in that window which
results in inconsistency with TPM PCR quotes, necessitating a cold boot
for a successful remote attestation.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index c9c916f69ca7..0342ddfa9342 100644
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
@@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 	ima_reset_kexec_file(sf);
 }
 
+static void ima_measure_kexec_event(const char *event_name)
+{
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size = 0;
+	long len;
+
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+			"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+			"ima_runtime_measurements_count=%ld;",
+				kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
+					strlen(ima_kexec_event), false, NULL, 0);
+}
+
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
 	/*
@@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 out:
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+	ima_measure_kexec_event("kexec_load");
 
 	return 0;
 }
@@ -201,6 +222,8 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	ima_measure_kexec_event("kexec_execute");
+
 	ret = ima_dump_measurement_list(&buf_size, &buf,
 					kexec_segment_size);
 
-- 
2.25.1


