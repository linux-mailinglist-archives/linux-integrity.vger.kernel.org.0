Return-Path: <linux-integrity+bounces-5903-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4B4A8ADE3
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 04:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4FD3B7B4B
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Apr 2025 02:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9527228CB2;
	Wed, 16 Apr 2025 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dT9qaqCj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C022838F;
	Wed, 16 Apr 2025 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769452; cv=none; b=CyKWJFlxOQrFiNZhIjiMO5+IY7yPNzKtpQPk/Hh/XpESfvcVHD0qgRACKkfTrNtSAHVQENfbElnpXvjFR9LnCIvq14Y1NS2+2czhALIOyrLCkx3pAIkDwbOPvnpLhRgyUOhojRi6PNhCBTz1QeEqfpdPq4oI8/h3m8iCa/d5OE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769452; c=relaxed/simple;
	bh=qqa0Nmr96rpBxmqNGNFIKptPy/uiPKWnqKGGWnrfuic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2U1lxDEzuYCq/as43FccxDJm5ZVBY2O81OMzAPI+5QTRsrQ8JJosfD4YdddD9woYIoNR0PwmQfhYmaKsdr6ETVShLyMgPziias0XZCB+fZ2cSCxiD/9qCREW40wtLowd3SD72bWCQFRdWxFXuEWqUCRSDF6vwS5QTCra16mR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dT9qaqCj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id A4F72210C453;
	Tue, 15 Apr 2025 19:10:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4F72210C453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744769450;
	bh=RebYXe6I1Y9VSO4KhCv3di0vL04EHE0LyJCCIybOssI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dT9qaqCj86WydKlVe01ANUSfjEGakwwS1qFfTq9MIPJZRXwqtS7H4b0mPHSbWOizL
	 cl6VY2U7F2uogZX9hJmDN3KtjDvS5L8yhU7cwWE1FfbNTv7AoShX6/tQI6CpOpoiir
	 Uee4h+g1+57xKWtjSwGWXJ2T9y8dZA3CC9tLwtWM=
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
Subject: [PATCH v12 2/9] ima: define and call ima_alloc_kexec_file_buf()
Date: Tue, 15 Apr 2025 19:10:20 -0700
Message-ID: <20250416021028.1403-3-chenste@linux.microsoft.com>
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

In the current implementation, the ima_dump_measurement_list() API is 
called during the kexec "load" phase, where a buffer is allocated and 
the measurement records are copied. Due to this, new events added after
kexec load but before kexec execute are not carried over to the new kernel
during kexec operation

Carrying the IMA measurement list across kexec requires allocating a
buffer and copying the measurement records.  Separate allocating the
buffer and copying the measurement records into separate functions in
order to allocate the buffer at kexec 'load' and copy the measurements
at kexec 'execute'.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 650beb74346c..b12ac3619b8f 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,26 +15,46 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+static struct seq_file ima_kexec_file;
+
+static void ima_free_kexec_file_buf(struct seq_file *sf)
+{
+	vfree(sf->buf);
+	sf->buf = NULL;
+	sf->size = 0;
+	sf->read_pos = 0;
+	sf->count = 0;
+}
+
+static int ima_alloc_kexec_file_buf(size_t segment_size)
+{
+	ima_free_kexec_file_buf(&ima_kexec_file);
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(segment_size);
+	if (!ima_kexec_file.buf)
+		return -ENOMEM;
+
+	ima_kexec_file.size = segment_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
-	struct seq_file ima_kexec_file;
 	struct ima_queue_entry *qe;
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
 	/* segment size can't change between kexec load and execute */
-	ima_kexec_file.buf = vmalloc(segment_size);
 	if (!ima_kexec_file.buf) {
-		ret = -ENOMEM;
-		goto out;
+		pr_err("Kexec file buf not allocated\n");
+		return -EINVAL;
 	}
 
-	ima_kexec_file.file = NULL;
-	ima_kexec_file.size = segment_size;
-	ima_kexec_file.read_pos = 0;
-	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
-
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/* This is an append-only list, no need to hold the RCU read lock */
@@ -71,8 +91,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	*buffer_size = ima_kexec_file.count;
 	*buffer = ima_kexec_file.buf;
 out:
-	if (ret == -EINVAL)
-		vfree(ima_kexec_file.buf);
 	return ret;
 }
 
@@ -111,6 +129,12 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
+	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
+	if (ret < 0) {
+		pr_err("Not enough memory for the kexec measurement buffer.\n");
+		return;
+	}
+
 	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
 				  kexec_segment_size);
 	if (!kexec_buffer) {
-- 
2.43.0


