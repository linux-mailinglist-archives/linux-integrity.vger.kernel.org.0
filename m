Return-Path: <linux-integrity+bounces-4644-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59882A1BEA3
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 23:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D703AEB63
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jan 2025 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4AC1E98FC;
	Fri, 24 Jan 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aLZYwb9c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A01E7C34;
	Fri, 24 Jan 2025 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759358; cv=none; b=cTri860XSJ0i1+IXWkGQpcslZh5EAOA+sHcEP1VUNy8WLFlwLI0MB5JkLzCymdnmSeM0VOdwZMKe54B8b2lFmoxQ1of8ANSZTpXX3XIoGQlqjrDzUhoXqTlsLwA9QiUMZDXl8xQB1wUCKJqntGxzEhcYx0mOMxDAHDI2JFgWK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759358; c=relaxed/simple;
	bh=Ckw2SdcMshoLK5M1DqU4ul3lnClo0tYVfVa1/aedS14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlW/glFqc1qaw3Wt6okc2CN0JZmIplwYeMlDH6iJMrLtu5mpJYralVLBjxaXgx3K+WRfgw8L02805fioXIjjJiWMcVebVAeoc3K7qF3lby286hqQGhb/+rSEMzNSzVVYyBE1LA1N02wBVAadTJjmkrnRkH/R6/mwooTzKx0m2MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aLZYwb9c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6C2C0210D0D1;
	Fri, 24 Jan 2025 14:55:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C2C0210D0D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737759356;
	bh=DwTIiVhUQSRukvrNOWSPzDC+an9T5YM/JpQkQduIjo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLZYwb9cch5FjZkouYXvOyeZ4WqLi7DI6qcnZP0rG2Fb/Cjf90iy8++YO+j9g8Zyq
	 J2NT9yOzko27UcZbkI9XloiF+PYclgUt2Jr+8HSN13KctxXDXqytC95WzaPHGtzYUs
	 6L0lJzYjc1jdJicEK26RNnlqkAc7KNEyPWDSZCr8=
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
Subject: [PATCH v6 1/7] ima: define and call ima_alloc_kexec_file_buf
Date: Fri, 24 Jan 2025 14:55:41 -0800
Message-Id: <20250124225547.22684-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250124225547.22684-1-chenste@linux.microsoft.com>
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
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
   ima_alloc_kexec_file_buf(). Compare actual memory required to ensure 
   there is enough memory for the entire measurement record.
 - Copy as many measurement events as possible.
 - Make necessary changes to the function ima_add_kexec_buffer() to call
   the above two functions.
 - Compared the memory size allocated with memory size of the entire 
   measurement record. If there is not enough memory, it will copy as many
   IMA measurement records as possible, and this situation will result
   in a failure of remote attestation.

Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |   1 +
 security/integrity/ima/ima_kexec.c | 105 +++++++++++++++++++++--------
 security/integrity/ima/ima_queue.c |   4 +-
 3 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3c323ca213d4..447a6eb07c2d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 52e00332defe..b60a902460e2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,62 +15,99 @@
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
+	if (ima_kexec_file.buf &&
+		(ima_kexec_file.size == segment_size)) {
+		goto out;
+	}
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
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
 	struct ima_queue_entry *qe;
-	struct seq_file file;
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
+	size_t entry_size = 0;
 
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
+	if (!ima_kexec_file.buf) {
+		pr_err("Kexec file buf not allocated\n");
+		return -EINVAL;
 	}
 
-	file.file = NULL;
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
-
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
+
+	/* Copy as many IMA measurements list records as possible */
 	list_for_each_entry_rcu(qe, &ima_measurements, later) {
-		if (file.count < file.size) {
+		entry_size += ima_get_binary_runtime_entry_size(qe->entry);
+		if (entry_size <= segment_size) {
 			khdr.count++;
-			ima_measurements_show(&file, qe);
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
 			ret = -EINVAL;
+			pr_err("IMA log file is too big for Kexec buf\n");
 			break;
 		}
 	}
 
-	if (ret < 0)
-		goto out;
-
 	/*
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
 	 */
-	khdr.buffer_size = file.count;
+	khdr.buffer_size = ima_kexec_file.count;
 	if (ima_canonical_fmt) {
 		khdr.version = cpu_to_le16(khdr.version);
 		khdr.count = cpu_to_le64(khdr.count);
 		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
 	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
+	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
 
 	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
-			     file.buf, file.count < 100 ? file.count : 100,
+			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
+			     ima_kexec_file.count : 100,
 			     true);
 
-	*buffer_size = file.count;
-	*buffer = file.buf;
-out:
-	if (ret == -EINVAL)
-		vfree(file.buf);
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
+
 	return ret;
 }
 
@@ -89,7 +126,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 
 	/* use more understandable variable names than defined in kbuf */
 	void *kexec_buffer = NULL;
-	size_t kexec_buffer_size;
+	size_t kexec_buffer_size = 0;
 	size_t kexec_segment_size;
 	int ret;
 
@@ -109,13 +146,19 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
-				  kexec_segment_size);
-	if (!kexec_buffer) {
+	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
+	if (ret < 0) {
 		pr_err("Not enough memory for the kexec measurement buffer.\n");
 		return;
 	}
 
+	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
+					kexec_segment_size);
+	if (ret < 0) {
+		pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
+		return;
+	}
+
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
@@ -130,6 +173,12 @@ void ima_add_kexec_buffer(struct kimage *image)
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
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 532da87ce519..a3559bae251f 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -71,7 +71,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
  * binary_runtime_measurement list entry, which contains a
  * couple of variable length fields (e.g template name and data).
  */
-static int get_binary_runtime_size(struct ima_template_entry *entry)
+int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry)
 {
 	int size = 0;
 
@@ -115,7 +115,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	if (binary_runtime_size != ULONG_MAX) {
 		int size;
 
-		size = get_binary_runtime_size(entry);
+		size = ima_get_binary_runtime_entry_size(entry);
 		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
 		     binary_runtime_size + size : ULONG_MAX;
 	}
-- 
2.25.1


