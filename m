Return-Path: <linux-integrity+bounces-5296-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DDA6648B
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 02:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3580818985EE
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77421474CC;
	Tue, 18 Mar 2025 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XGfeZNzG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099861FF2;
	Tue, 18 Mar 2025 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259917; cv=none; b=jYMlTZ6U2oPL702owLK3uDgkp+ySQMUzQJWckKqjrDHOJPqLvwSycO9BZYfbYqPMGhpkTwgbbg4qpP0vlccjfJGlboOXlxkzaRM+OGLb5k+ZTnmDAGbJW3fGZ6ZQI9cIoOX5w2PUlbIgxLCuV7JRA0YgMvYptzNHXBVwW3P3A8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259917; c=relaxed/simple;
	bh=9KWK2FcWXHseT+s0YEdr/0gMrJjOMqYfBNEnnpe5iAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD6jpTmPgM5FouHr7IDWZzHL1KgBi/ahtMhCqzw3TLUIaSuinsbBm1PVwt8vY89DsQevRPuX16b2a3OprtsrYVeD5+YeAQoisWB4KCI7vcuqRmqI7H+qVhL7GVgWGn5TFcCxTini9OsfoKu+OD03pe7xc3nrGG3O8LubsNs8I4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XGfeZNzG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id 882462054907;
	Mon, 17 Mar 2025 18:05:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 882462054907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742259915;
	bh=Hba2DOQnhbvoH4xYJ6tdp7GM4mE8Rz1dOv3r0bEUwkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGfeZNzGJwVw640d4nK+kqVBvm16nM90ndpOCXPTkd1ygw8Rw+iWLpAIcjQMY8V/e
	 V93x3VXF8zS3Nl2wfxcbTQJgz/L/jh6EdeDY1rQIurqbJL3P1LBYO7YaFNq3Qc9t52
	 LCZy8KpkyPyNTsYuMXs2YQeHFaXd6dZKckwzVkSg=
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
Subject: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
Date: Mon, 17 Mar 2025 18:04:40 -0700
Message-ID: <20250318010448.954-3-chenste@linux.microsoft.com>
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

Carrying the IMA measurement list across kexec requires allocating a
buffer and copying the measurement records.  Separate allocating the
buffer and copying the measurement records into separate functions in
order to allocate the buffer at kexec 'load' and copy the measurements
at kexec 'execute'.

This patch includes the following changes:
 - Refactor ima_dump_measurement_list() to move the memory allocation
   to a separate function ima_alloc_kexec_file_buf() which allocates
   buffer of size 'kexec_segment_size' at kexec 'load'.
 - Make the local variable ima_kexec_file in ima_dump_measurement_list()
   a local static to the file, so that it can be accessed from 
   ima_alloc_kexec_file_buf().
 - Make necessary changes to the function ima_add_kexec_buffer() to call
   the above two functions.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 67 +++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 8567619889d1..45170e283272 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,6 +15,48 @@
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
+static struct seq_file ima_kexec_file;
+
+static void ima_reset_kexec_file(struct seq_file *sf)
+{
+	sf->buf = NULL;
+	sf->size = 0;
+	sf->read_pos = 0;
+	sf->count = 0;
+}
+
+static void ima_free_kexec_file_buf(struct seq_file *sf)
+{
+	vfree(sf->buf);
+	ima_reset_kexec_file(sf);
+}
+
+static int ima_alloc_kexec_file_buf(size_t segment_size)
+{
+	/*
+	 * kexec 'load' may be called multiple times.
+	 * Free and realloc the buffer only if the segment_size is
+	 * changed from the previous kexec 'load' call.
+	 */
+	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
+		goto out;
+
+	ima_free_kexec_file_buf(&ima_kexec_file);
+
+	/* segment size can't change between kexec load and execute */
+	ima_kexec_file.buf = vmalloc(segment_size);
+	if (!ima_kexec_file.buf)
+		return -ENOMEM;
+
+	ima_kexec_file.size = segment_size;
+
+out:
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
+
+	return 0;
+}
+
 /*
  * Copy the measurement list to the allocated memory
  * compare the size of IMA measurement list with the size of the allocated memory
@@ -26,23 +68,16 @@
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
@@ -79,8 +114,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	*buffer_size = ima_kexec_file.count;
 	*buffer = ima_kexec_file.buf;
 out:
-	if (ret == -EINVAL)
-		vfree(ima_kexec_file.buf);
 	return ret;
 }
 
@@ -119,6 +152,12 @@ void ima_add_kexec_buffer(struct kimage *image)
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
@@ -140,6 +179,12 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
 
+	/*
+	 * kexec owns kexec_buffer after kexec_add_buffer() is called
+	 * and it will vfree() that buffer.
+	 */
+	ima_reset_kexec_file(&ima_kexec_file);
+
 	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		      kbuf.mem);
 }
-- 
2.25.1


