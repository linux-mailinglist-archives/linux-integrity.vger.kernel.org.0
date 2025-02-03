Return-Path: <linux-integrity+bounces-4704-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFFEA267C2
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 00:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED1A17A3075
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 23:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F5210F45;
	Mon,  3 Feb 2025 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KRGm4uKa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB425201267;
	Mon,  3 Feb 2025 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624843; cv=none; b=jsgTiX0uGi/ABEiPSZlkatZb0/hE1qP3HofwbaiKRUQFHG+fHKduaPtAGfDXiuoHlQpsDcXU+Z/wgWdZ2fSgAtxXjJnQzkVjqwTw7uQ3IS6cG6I4p3U/u43HdRceb1eOtokkEdJ6bkUgdYa2JdlqZ2+34wnpzS0L2yxsb+1tt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624843; c=relaxed/simple;
	bh=Jf5yLF0QA77l3vRMWJUEaa8p/xUOR3jCWV62rrEDc6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmM1iSO/VHzTLK06ZjWNHz0aL96GhVNWiXFBa0L4WW7QI5+MssO9hhL6nGAijAZwwMf79M3b7UYKDi7duHqqQgect5Z7UkcW8hJ7egWWoDu5qv0+D7Gg6LCkBJIY0PVRzC5gBVlCMCTggcRA7PvD7eIhCH8M0N9n6ObLDtIVPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KRGm4uKa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.59.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 391DE205493E;
	Mon,  3 Feb 2025 15:20:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 391DE205493E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738624841;
	bh=0pLOnkZ3BBhZrWSrqRS0hKDrePzR0/4CteyR8x89gQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRGm4uKa6uwqYp++gYLVkz+w0G7XRLKWZaiSa9r29oDDeni8lIRGaUO621/GkcQqz
	 f4DvTtm91iRY4M/PLDUtRvf74WyB/q92NbJ5YXcU86f8KDZAoOOGX9f9yAU2MBPzAu
	 UUF/xF5N5b0aCSP4671roPFX9K8P9odm+R1FPLSk=
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
	linux-kernel@vger.kernel.org,
	chenste@linux.microsoft.com
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com
Subject: [PATCH v7 3/7] ima: kexec: skip IMA segment validation after kexec soft reboot
Date: Mon,  3 Feb 2025 15:20:28 -0800
Message-Id: <20250203232033.64123-4-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203232033.64123-1-chenste@linux.microsoft.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
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
measurement log at kexec excute stage when soft reboot is initiated. 
Therefore, it may fail digest verification in verify_sha256_digest() 
after kexec soft reboot into the new kernel. Therefore, the digest 
calculation/verification of the IMA segment needs to be skipped.

Skip IMA segment from calculating and storing digest in function
kexec_calculate_store_digests() so that it is not added to the
'purgatory_sha_regions'.

Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
no change is needed in verify_sha256_digest() in this context.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.

Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 include/linux/kexec.h              |  3 +++
 kernel/kexec_file.c                | 23 +++++++++++++++++++++++
 security/integrity/ima/ima_kexec.c |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f8413ea5c8c8..f3246e881ac8 100644
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
index 3eedb8c226ad..a3370a0dce20 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,6 +38,22 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
+#ifdef CONFIG_IMA_KEXEC
+static bool check_ima_segment_index(struct kimage *image, int i) 
+{
+	if (image->is_ima_segment_index_set &&
+			i == image->ima_segment_index)
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
@@ -764,6 +780,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
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
index b60a902460e2..283860d20521 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -162,6 +162,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	kbuf.buffer = kexec_buffer;
 	kbuf.bufsz = kexec_buffer_size;
 	kbuf.memsz = kexec_segment_size;
+	image->is_ima_segment_index_set = false;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
@@ -172,6 +173,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_addr = kbuf.mem;
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
+	image->ima_segment_index = image->nr_segments - 1;
+	image->is_ima_segment_index_set = true;
 
 	/*
 	 * kexec owns kexec_buffer after kexec_add_buffer() is called
-- 
2.25.1


