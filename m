Return-Path: <linux-integrity+bounces-515-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D858155DA
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Dec 2023 02:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C972B23B33
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Dec 2023 01:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A788015A8;
	Sat, 16 Dec 2023 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cdQR0bvD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558061363
	for <linux-integrity@vger.kernel.org>; Sat, 16 Dec 2023 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6C6B20B3CC5;
	Fri, 15 Dec 2023 17:07:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6C6B20B3CC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688861;
	bh=VKCDyBNAtLzbD9bEYAgMrB8Tn92NT5hA4Th4n1dFxBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdQR0bvDJq65Ivx9V//Qq2WtnEIs6ohMgKh94PMilADBuAeUy8PdApbWOxODqIRFo
	 rhD1z0Bd0D+qw2p+F7h9BB41F02JRpNm0mWcKJXPHUtJjFLFxAoC6VG/huAG1qQw7K
	 /m+G5NRuwatrFtPtcDMeAskde90Y2UfxIBPkwNjM=
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
Subject: [PATCH v3 7/7] ima: measure kexec load and exec events as critical data
Date: Fri, 15 Dec 2023 17:07:29 -0800
Message-Id: <20231216010729.2904751-8-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There could be a potential mismatch between IMA measurements and TPM PCR
quotes caused by the indeterminate interval between kexec 'load' and
'execute'.  Memory allocated at kexec 'load' for IMA log buffer may run
out. It can lead to missing events in the IMA log after a soft reboot to
the new Kernel, resulting in TPM PCR quotes mismatch and remote
attestation failures.

Define two new IMA events, 'kexec_load' and 'kexec_execute', to be 
measured as critical data at kexec 'load' and 'execute' respectively.

These events serve as markers in the IMA log to verify the IMA events are
captured between kexec 'load' and 'execute' window.  The presence of a
'kexec_load' event in between the last two 'boot_aggregate' events in the
IMA log implies this is a kexec soft reboot, and not a cold-boot. And the
absence of 'kexec_execute' event after kexec soft reboot implies missing
events in that window which results in inconsistency with TPM PCR quotes,
necessitating a cold boot for further successful remote attestation.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 063da9c834a0..47da41a66dcc 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -17,6 +17,8 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+#define IMA_KEXEC_EVENT_LEN 128
+
 struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
 static size_t kexec_segment_size;
@@ -33,6 +35,8 @@ void ima_free_kexec_file_buf(struct seq_file *sf)
 
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
+
 	/*
 	 * kexec 'load' may be called multiple times.
 	 * Free and realloc the buffer only if the segment_size is
@@ -42,7 +46,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	    ima_kexec_file.size == segment_size &&
 	    ima_kexec_file.read_pos == 0 &&
 	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
-		return 0;
+		goto out;
 
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
@@ -55,6 +59,13 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
+out:
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;", segment_size);
+
+	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
+				  strlen(ima_kexec_event), false, NULL, 0);
+
 	return 0;
 }
 
@@ -179,6 +190,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 static int ima_update_kexec_buffer(struct notifier_block *self,
 				   unsigned long action, void *data)
 {
+	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
 	void *buf = NULL;
 	size_t buf_size;
 	bool resume = false;
@@ -194,6 +206,15 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
+	buf_size = ima_get_binary_runtime_size();
+	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
+		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
+		  kexec_segment_size, buf_size);
+
+	ima_measure_critical_data("ima_kexec", "kexec_execute",
+				  ima_kexec_event, strlen(ima_kexec_event),
+				  false, NULL, 0);
+
 	ima_measurements_suspend();
 
 	ret = ima_dump_measurement_list(&buf_size, &buf,
-- 
2.25.1


