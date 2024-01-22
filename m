Return-Path: <linux-integrity+bounces-849-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9D83719A
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 20:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D5E291758
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCBD54BD6;
	Mon, 22 Jan 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Oe8BZj6h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721754BD1
	for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948697; cv=none; b=clK5dkl5vzBzWSanRJhMu37rh8vN5LkGiKMI1xHR/B6ZAeD/tnrIQLEBT0eckGUUzQk6/eOFZ+eXs4+IsI0LHiIDYUVidmTxOVYZHmIkH41CsMITM4qtw2Y4+zWBz0pxTT5uWJiGI8YO5rLe9U5DdUDkWnySb8hy8ghkVE1RJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948697; c=relaxed/simple;
	bh=rzlEfH4BH1sgznC/UhwvS8OYQKnfy6TxLTON8TxS9zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FarGRIzPqs0TPFR9MiE/xz7wjkWiQ9Cgi2ckN/I5zPEdtgJWqW9GCxR9KT8MprvI9ozF7qlb1irnyxgEBwmPvQf+KckwJF9nXHXEqbohXeSPk8MtYmLeQev+LW4NCaEI6eHVZN/IlbIxGQbp+VYSw7IsLEPrloQEdXT9roAF+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Oe8BZj6h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D11820E2C0A;
	Mon, 22 Jan 2024 10:38:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D11820E2C0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948695;
	bh=qJHN560TUZe/5m2Gya0jv8CgnkhIqfBUCJMwNbKONAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oe8BZj6hMBvY5o1xChVYXTZ58hlM5FZ1WkPHd6CmU76c37WMkBJMuHaS6r1AlLa4E
	 cFLEsSo4gkeJGI0Ozgo0IyGtqNMFy1xpsxKaTchsKKnFdZsYkusfDzyDrS6LrJ+tT+
	 AdBEZhp5IZCpFMI3NL4G6AYEiwc9FlQgxHENtYtA=
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
Subject: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
Date: Mon, 22 Jan 2024 10:37:58 -0800
Message-Id: <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
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

Refactor ima_dump_measurement_list() to move the memory allocation part
to a separate function ima_alloc_kexec_file_buf() which allocates buffer
of size 'kexec_segment_size' at kexec 'load'.  Make the local variable
ima_kexec_file in function ima_dump_measurement_list() as local static to
the file, so that it can be accessed from ima_alloc_kexec_file_buf().
Make necessary changes to the function ima_add_kexec_buffer() to call the
above two functions.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 96 +++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 29 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..99daac355c70 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -15,62 +15,93 @@
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
+	/*
+	 * kexec 'load' may be called multiple times.
+	 * Free and realloc the buffer only if the segment_size is
+	 * changed from the previous kexec 'load' call.
+	 */
+	if (ima_kexec_file.buf &&
+	    ima_kexec_file.size == segment_size &&
+	    ima_kexec_file.read_pos == 0 &&
+	    ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
+		return 0;
+
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
 	struct ima_queue_entry *qe;
-	struct seq_file file;
 	struct ima_kexec_hdr khdr;
-	int ret = 0;
 
-	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
-		ret = -ENOMEM;
-		goto out;
+	if (!ima_kexec_file.buf) {
+		*buffer_size = 0;
+		*buffer = NULL;
+		pr_err("%s: Kexec file buf not allocated\n", __func__);
+		return -EINVAL;
 	}
 
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
+		if (ima_kexec_file.count < ima_kexec_file.size) {
 			khdr.count++;
-			ima_measurements_show(&file, qe);
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
-			ret = -EINVAL;
+			pr_err("%s: IMA log file is too big for Kexec buf\n",
+			       __func__);
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
-	return ret;
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
+
+	return 0;
 }
 
 /*
@@ -108,13 +139,20 @@ void ima_add_kexec_buffer(struct kimage *image)
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
+		pr_err("%s: Failed to dump IMA measurements. Error:%d.\n",
+		       __func__, ret);
+		return;
+	}
+
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
-- 
2.25.1


