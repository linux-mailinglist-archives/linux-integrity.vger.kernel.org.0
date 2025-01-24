Return-Path: <linux-integrity+bounces-4641-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BCA1BE88
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 23:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FB33AE682
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F51F2366;
	Fri, 24 Jan 2025 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AEm/mO+6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A241EE7B3;
	Fri, 24 Jan 2025 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737758639; cv=none; b=oiHfJ5/AKSApSX34z27w5fK36accJMg3p6dt2spzHneMC8T6gOgoEXUoXLuvoZ+YVG9VHtT8MJozVAeGycUUrVO61v9PLYV3WGU/tP+xm119/OQy4iuxgvOpsTMM+iDU7cJe0KWbLQh/Om7frs0yGctwpz1iiNpqhgZmrAYnQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737758639; c=relaxed/simple;
	bh=XcCYE/P+N1xe2haU4t0///zpxWhVLSW13VRkFoNCq2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rp+33cC+ZTV4z6iVrwaKo3htFYa9n46nUei4OczC11PfQ8WEddkgcv/RzqPg0D9Q3KldgsgGSMTbNPohPulO0ooJN2adkyk5oirWagRKsZEkOWX/juOolZTbWtA+rTuG1kKHCxV7+2WEvezPyfZ+h/UTw2MhMi4ZSAlMunq2jaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AEm/mO+6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 55621210D0CD;
	Fri, 24 Jan 2025 14:43:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55621210D0CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737758636;
	bh=6H+05HlDdwLJYuzzGaRsVd9LIBrCOlgbmTBvfn2uPEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEm/mO+6kketxvjE6PnN0AsHzqZddslTQvpRaKATfKb703GXRzKt5oa9jYFRS7e+y
	 x4LhUt/TZOZ22LnNBGTYvh6cuVZKgEdIBYu4oaJaOjaVz8JC1WnxUokiUG/7Keijx0
	 Vfaxv0+yZqXZLDRo/SzOzb7ZetxHpgGNYfrlApjs=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	petr@tesarici.cz,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Subject: [PATCH 7/7] ima: measure kexec load and exec events as critical data
Date: Fri, 24 Jan 2025 14:42:39 -0800
Message-Id: <20250124224239.22335-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250124224239.22335-1-chenste@linux.microsoft.com>
References: <20250124224239.22335-1-chenste@linux.microsoft.com>
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
index c9c916f69ca7..d416ca0382cb 100644
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
@@ -206,6 +227,8 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 
 	if (ret)
 		pr_err("Dump measurements failed. Error:%d\n", ret);
+	else
+		ima_measure_kexec_event("kexec_execute");
 
 	if (buf_size != 0)
 		memcpy(ima_kexec_buffer, buf, buf_size);
-- 
2.25.1


