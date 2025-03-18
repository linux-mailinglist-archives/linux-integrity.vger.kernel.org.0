Return-Path: <linux-integrity+bounces-5303-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80620A664A0
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 02:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39191189F0D0
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB719E819;
	Tue, 18 Mar 2025 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N48p2xzf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE3188938;
	Tue, 18 Mar 2025 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259921; cv=none; b=LVo97ApF14KjoKHzKtACb18FaiSEyRx95tX6i9TWv+ab+vEGc98Z3yJJ7jq4hpOA5RFYYUNk7Z2rZLAkKhdzuean1SS7iPLaOtDgV/H0oj7VuYxT83GQZJjWb4p3pj0e75MSHCewH/8AT+ELvtNCAvTjYHzJofW+VA6/wSKN/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259921; c=relaxed/simple;
	bh=Nz9EfW/V4d9vRhXeDuOWLwg3Gd+vG7QqYw7PN1wk/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVSoW/Gpo1ymBJ2klywfeHb3OVZEBE8A8cUvgA6JPk5ic71Pj+I/ZL5tckqlRfCBulNk26YOeyuelDlG2dv+5j8+82etmR5+7epabYZyE7o3LZ/nmobvDB+eL8N+heRUsO1VEkd6HPAEXW9vwMeto/5TLo15baNO7n2uHtTntI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N48p2xzf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9A8AD210731C;
	Mon, 17 Mar 2025 18:05:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A8AD210731C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742259919;
	bh=tSaoksgCpr/zt6e9/PPNt+iQGGb9Nj0ejv7ujQxrg2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N48p2xzfrti8JQnuKF0bQrv/Y3K5akEtb9qJWCLqQKMUgnXU/LMVW56z20Wi5IoGI
	 f/rmkFKEw+Y5TIT0xKl3hSijwJ9ohRrPFEX8Q0Ks2uFVZquGyTypX9oUZoD5wY678S
	 qLIhxtBA3SFrut3HuQEjpDHYjTagY0KC3VuczkSs=
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
Subject: [PATCH v10 8/8] ima: measure kexec load and exec events as critical data
Date: Mon, 17 Mar 2025 18:04:46 -0700
Message-ID: <20250318010448.954-9-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318010448.954-1-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
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
 security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
 security/integrity/ima/ima_queue.c |  5 +++++
 3 files changed, 32 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 24d09ea91b87..34815baf5e21 100644
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
index 0f214e41dd33..43223eb99046 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 256
+
 static bool ima_kexec_update_registered;
 static struct seq_file ima_kexec_file;
 static size_t kexec_segment_size;
@@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 	ima_reset_kexec_file(sf);
 }
 
+void ima_measure_kexec_event(const char *event_name)
+{
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+	size_t buf_size = 0;
+	long len;
+	int n;
+
+	buf_size = ima_get_binary_runtime_size();
+	len = atomic_long_read(&ima_htable.len);
+
+	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
+		      "ima_runtime_measurements_count=%ld;",
+		      kexec_segment_size, buf_size, len);
+
+	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
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
index 83d53824aa98..590637e81ad1 100644
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


