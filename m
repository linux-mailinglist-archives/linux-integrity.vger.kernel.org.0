Return-Path: <linux-integrity+bounces-4888-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8714A3AC25
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 23:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D00173A99
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 22:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351CC1DE889;
	Tue, 18 Feb 2025 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jaf7n2OE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776E1DE2C7;
	Tue, 18 Feb 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919314; cv=none; b=n33/FYLJq7SuZnsTB6nG3J4sceonz2NwhscQKyxPvorm8xIcD7XdQRsat3O7NUtCpU7viRcaCX5UYMvDkobmrVbJQKhhnEO8G29IngqUW5AKZXq6hoWJRnnEUe+06jSGmAREsUgwyDGBsEIR78uHQg/ksfhX1OSOKM5/wU9Xg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919314; c=relaxed/simple;
	bh=Dv4dqCeWIFNRcZXncwh8yc/VfbvYmlQqz44ivYyw3aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MkyM3hBC7uiRbNbJYWsSBUgAYx4pnIHt1ZS/9ZqO9RnBiKnYtoltcUUPsmugbGYZWSUCNbshqPW0Tuz4N1b83bJa/mT3VfwnMHPeDp+lgvqMnwHr8s/6Scd+NJJ3anpLaNLvY/Q2WAuN0TMvUjbsFaadvWlfRRlC2KfmDHnsQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jaf7n2OE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08C7220376F3;
	Tue, 18 Feb 2025 14:55:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08C7220376F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739919311;
	bh=05UU21akph705gQ7YuAq8nIHLuxpMVbw0C29P5bQrQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jaf7n2OE3jjjtnDZ7g+f27xoslhx3YrIyo5hOCYIdBlaUS9dH1uKgb2p/5HjGV1Dq
	 ntlbdWK9pceAo6GJn2EmtxVocm96GWkeWsgELZTx5TH+x6q1bDacI6cUcsUzth5lFP
	 jgkllx3WWZFqbO8RcZv/uHe8LaXBjJIjlFTpUAkc=
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
Subject: [PATCH v8 7/7] ima: measure kexec load and exec events as critical data
Date: Tue, 18 Feb 2025 14:55:02 -0800
Message-Id: <20250218225502.747963-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250218225502.747963-1-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
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

The 'kexec_load' event IMA log can be found using the following command:
sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
   grep kexec_load

The 'kexec_load' event IMA log can be found using the following command:
sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
   grep kexec_execute

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  6 ++++++
 security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
 security/integrity/ima/ima_queue.c |  5 +++++
 3 files changed, 32 insertions(+)

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
index 6c8c203ad81e..8d0782e51ffa 100644
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
 
+void ima_measure_kexec_event(const char *event_name)
+{
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size = 0;
+	long len;
+
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+		 "ima_runtime_measurements_count=%ld;",
+		 kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
+				  strlen(ima_kexec_event), false, NULL, 0);
+}
+
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
 	/*
@@ -58,6 +78,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
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


