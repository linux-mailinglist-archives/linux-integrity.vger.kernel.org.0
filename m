Return-Path: <linux-integrity+bounces-5075-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2AA4ECA8
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8DC67A4AC5
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 19:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E5259C9A;
	Tue,  4 Mar 2025 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aPWmRBFI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C98259C8D;
	Tue,  4 Mar 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115045; cv=none; b=RbPukDGnazesgRGMjjIR4AsCgAWGuMZjiocY7CNU9Cv0dhJquY+6LBUNkgWDVCd9FkEbRvK0hEbcoTstWy7Ptmx3HWGOOJpDMyaVQNsRxyKxcx6IN1efoDoJwh1jFE75g0FtE3bZcl4wCht/lqSeqCrap99+FgZyCHVy2XRZ6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115045; c=relaxed/simple;
	bh=Lo6yu2Z0euXdumXkA3ZF2eyyLZkbqY1Yd3r7gfjAOng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJdj2HDnkks0AiA44lUmzgzh7kDTW2eHpXbWVnCntBE1oKTR7Cf0j4asFpOOvZGC0MT3eADTfLrqP+Yds9vAzXpxw7vQPIKcTW4Bwjzr1LzszDYqZDjT0oLPIESdWtS8qM/IeyR78FE8R/HCwPRSdEgAcytVfAHKBnaPjBSQfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aPWmRBFI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C963210EAF6;
	Tue,  4 Mar 2025 11:03:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C963210EAF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741115038;
	bh=rDwLyG8x98JlAJ3JT4WjH9zB21oyx+c9LLRVfLQwzE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPWmRBFITjcXbcl1gxET8+qChdsH2s0kFGBJeKYeVmBoRPlaVQotLjfreDCfmaF1z
	 TkqFOSKhzqAfL8HX55bOr/DT0mQSUeO9BakMo3MWOT0/FEdUPLCETOPP7mNsbVjbtB
	 NeRCBIfpPry6C7Q2qQlegjT0MrB+9RnSyRnj33v4=
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
Subject: [PATCH v9 3/7] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Tue,  4 Mar 2025 11:03:47 -0800
Message-Id: <20250304190351.96975-4-chenste@linux.microsoft.com>
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

The kexec_calculate_store_digests() function calculates and stores the
digest of the segment during the kexec_file_load syscall, where the 
IMA segment is also allocated.

With this series, the IMA segment will be updated with the measurement 
log at the kexec execute stage when a soft reboot is initiated. 
Therefore, the digests should be updated for the IMA segment in the 
normal case.

The content of memory segments carried over to the new kernel during the
kexec systemcall can be changed at kexec 'execute' stage, but the size
and the location of the memory segments cannot be changed at kexec
'execute' stage.

However, during the kexec execute stage, if kexec_calculate_store_digests()
API is call to update the digest, it does not reuse the same memory segment
allocated during the kexec 'load' stage and the new memory segment required
cannot be transferred/mapped to the new kernel.

As a result, digest verification will fail in verify_sha256_digest() 
after a kexec soft reboot into the new kernel. Therefore, the digest
calculation/verification of the IMA segment needs to be skipped.

To address this, skip the calculation and storage of the digest for the
IMA segment in kexec_calculate_store_digests() so that it is not added 
to the purgatory_sha_regions.

Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
no change is needed in verify_sha256_digest() in this context.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/kexec.h              |  3 +++
 kernel/kexec_file.c                | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_kexec.c |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7d6b12f8b8d0..107e726f2ef3 100644
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
index 6195df128482..0465beca8867 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -169,6 +169,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -179,6 +180,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	/*
 	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-- 
2.25.1


