Return-Path: <linux-integrity+bounces-5082-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3DA4ED4B
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 20:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A0880986
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 19:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3A2620EF;
	Tue,  4 Mar 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T7HQWhU3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC225BAC9;
	Tue,  4 Mar 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115048; cv=none; b=WpvpwzYbSse9QFbGb5uZCaWBSwOqB9IhXCCWtdbtS1u9ACmTN1IKn2pHXPiaXcxzjzTW4PXZG/s5irasl0th5NYpgynUxd+X+01OPZVjCmmS7QrztIBZUq8B0RkeX9KHMrNECRRmwwtr8noMEslRbuHRnP8n+KbZLT2ZOrWMcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115048; c=relaxed/simple;
	bh=ld5Rzt7U3U9kNdPpbYABrBhw8UfYLCmfCpfAmqEgxjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzRhoKufIcpeoAz4W3nlX+3qJlfwuEFZgd2GnnduVjkyLte1nzBU+EDoRmH0sqfHMy7efOidZgVaSdXJnXF7EtYAKuA6YEcXmTUA1b5mZfNSgVIZ9O+6TtEgViWMVvmN4DAwaZUgzvg9Gacd1lUtgy8Nqv1/48Fh/7kFDfAqre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T7HQWhU3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE7E9210EAFB;
	Tue,  4 Mar 2025 11:03:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE7E9210EAFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741115039;
	bh=7bpzaKJMyV3E8E00HZMPQxpAdeDwOCI+jQV79Yt99/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7HQWhU3oXeIve/XuPEpI9rVt6c4VCA0J5gVMNjF5zkIri2rqUHhNsOqrqPZ6qke+
	 z5Dagl0YGKTiyXy0EG3B/B7uYI7v1nsQgcgnI5LQSi4TcSWbjqbdlYJChjdzXpNZg7
	 UD1WWd3Rit7W/1KNg6nq0FoV0buVSnfiH0koAUFw=
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
Subject: [PATCH v9 7/7] ima: measure kexec load and exec events as critical data
Date: Tue,  4 Mar 2025 11:03:51 -0800
Message-Id: <20250304190351.96975-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250304190351.96975-1-chenste@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
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

These critical data events are displayed as hex encoded ascii in the
ascii_runtime_measurement_list.  Verifying the critical data hash requires 
calculating the hash of the decoded ascii string.  

For example, to verify the 'kexec_load' data hash:

sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements 
| grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum


To verify the 'kexec_execute' data hash:

sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements 
| grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h       |  6 ++++++
 security/integrity/ima/ima_kexec.c | 20 ++++++++++++++++++++
 security/integrity/ima/ima_queue.c |  5 +++++
 3 files changed, 31 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4428fcf42167..1452c98242a4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create);
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+void ima_measure_kexec_event(const char *event_name);
+#else
+static inline void ima_measure_kexec_event(const char *event_name) {}
+#endif
+
 /*
  * The default binary_runtime_measurements list format is defined as the
  * platform native format.  The canonical format is defined as little-endian.
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9fb1bf5a592a..e40c6da4504c 100644
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
@@ -36,6 +38,23 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 	ima_reset_kexec_file(sf);
 }
 
+void ima_measure_kexec_event(const char *event_name)
+{
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size = 0;
+	long len;
+
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	int n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+					"kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+					"ima_runtime_measurements_count=%ld;",
+					kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
+}
+
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
 	/*
@@ -58,6 +77,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 out:
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+	ima_measure_kexec_event("kexec_load");
 
 	return 0;
 }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 3dfd178d4292..6afb46989cf6 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
 			       unsigned long action,
 			       void *data)
 {
+#ifdef CONFIG_IMA_KEXEC
+	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
+		ima_measure_kexec_event("kexec_execute");
+#endif
+
 	ima_measurements_suspend();
 
 	return NOTIFY_DONE;
-- 
2.25.1


