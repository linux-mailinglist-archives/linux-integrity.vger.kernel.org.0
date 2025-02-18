Return-Path: <linux-integrity+bounces-4883-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB8CA3AC18
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 23:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B90D3A8719
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696DB1DE2CE;
	Tue, 18 Feb 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lV/aK3RH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF61DB92E;
	Tue, 18 Feb 2025 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919312; cv=none; b=LOIVN1I7KnCq7mT2ydtEa1wqm6cpj+vLsNmtxksZVGxRpJc7BRJxzmZ4GrECguNoecNawgHx+uKKPOrin8VbAnCXx43QivCVOKh1gE4bsrT+2/9JEfRztzokIIqnyys6f5p7PLWf6G6Z19lwuLXTz5m22moHBd2DzbNX7ENBNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919312; c=relaxed/simple;
	bh=GJxjZhz46/qgi9xEbXAu0aLCvhuw2uAWnGBPnJrPI3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYM4y9U6UnqZp8Jz0LL2pcvv14U9752YSwFTcNK5zdCjt1ET9Sc5g8Dxm0U8IYEFYOHD66198PBDDYX6sMu/+JnMouTyX3u6tzeMbNn7QiQuHLEQ5q7AcJuL1PT+Z8VdfEJ638QAO/XnmBGZsKTfVkjCt7o34rU81q85vfWE/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lV/aK3RH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2542420376EF;
	Tue, 18 Feb 2025 14:55:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2542420376EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739919310;
	bh=eZuPxuKzh6GIya1FAK/uc/NqhhaYVTOtHG78GCKDMxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lV/aK3RHjmQABFBHbdEifZ0yPFAiTXcX8oQyw/rnPoeuBaK0RJFRySAwDBxEmjxBq
	 jSZHXk03qNLr0PYUu+O+DFGi7Nn866dbgYo+97Ha8/bEQLwQM5WVl8M86DSdX9cW+d
	 wr3ypzrcW3iyDz5ebFDzZEtNpTXnKnCcqDbn6dbU=
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
Subject: [PATCH v8 3/7] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Tue, 18 Feb 2025 14:54:58 -0800
Message-Id: <20250218225502.747963-4-chenste@linux.microsoft.com>
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

kexec_calculate_store_digests() calculates and stores the digest of the
segment at kexec_file_load syscall where the IMA segment is also
allocated.  With this series, the IMA segment will be updated with the
measurement log at kexec execute stage when soft reboot is initiated. 
Therefore, it may fail digest verification in verify_sha256_digest() 
after kexec soft reboot into the new kernel. Therefore, the digest 
calculation/verification of the IMA segment needs to be skipped.

Skip the calculating and storing digest of the IMA segment in
kexec_calculate_store_digests() so that it is not added to the
'purgatory_sha_regions'.

Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
no change is needed in verify_sha256_digest() in this context.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/kexec.h              |  3 +++
 kernel/kexec_file.c                | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_kexec.c |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 4dbf806bccef..bd554ced9fb2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -362,6 +362,9 @@ struct kimage {
 
 	phys_addr_t ima_buffer_addr;
 	size_t ima_buffer_size;
+
+	unsigned long ima_segment_index;
+	bool is_ima_segment_index_set;
 #endif
 
 	/* Core ELF header buffer */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad..606132253c79 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
+		return true;
+	else
+		return false;
+}
+#else
+static bool check_ima_segment_index(struct kimage *image, int i)
+{
+	return false;
+}
+#endif
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */
@@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		if (ksegment->kbuf == pi->purgatory_buf)
 			continue;
 
+		/*
+		 * Skip the segment if ima_segment_index is set and matches
+		 * the current index
+		 */
+		if (check_ima_segment_index(image, i))
+			continue;
+
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 89088f1fa989..704676fa6615 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -160,6 +160,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -170,6 +171,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	/*
 	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-- 
2.25.1


