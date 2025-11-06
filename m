Return-Path: <linux-integrity+bounces-7585-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E5C394F1
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 07:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB39D4E1817
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 06:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EFA2745C;
	Thu,  6 Nov 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1xkw3BF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91C26E143
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412368; cv=none; b=Z4pBwpVjuIy8CqN4C949r8gVUhcwReFFmjQpIdIFnquwynoz9MuwqexBLk033Qs9HXCquEAIp/Po+USnvwg56hwnNDBBNpv853rp1YP7ou1q2fb1Ij34PRmlNPbju/FcR5G7l2nWkHCYdGvIFr5MPS3FF5kT3BpJL2irRQ7Xz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412368; c=relaxed/simple;
	bh=s6Sw7awMb0w+8EKb6S/cTDLwbwxSB9T9N52bqhhhVCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdYwmHe8ge9+OpSE4hHOPBjE8cGBLMO6Xgh/Kf7unpVOiRImtjzd6/oTAo4aHKdmjeXE4KjMJz2FZibYy035ITKz75ZNJIJjFTRc+JhTEsZLMKpB0Ttl7Rya9RWT6X8qEjNSWbh+HUQT5beet/A6oY0nRGRceXf3WfT3dY30Cqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1xkw3BF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762412366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AR8zCu9He0hr0Ps1/Yt7ZPdaD105dTYO/pQr3EZq3BI=;
	b=K1xkw3BFOGwLb3YqRnVtIyaqXMAalOwCyv6kE7zcVSGiDQNx6jWu8vyTyTuyTzwYkgnLad
	65KVNp1qJf66nm4pPtrJBBEUJCTP9PWG8VK36s7i4vljmRqLMV52tmq4JUtsqm69TPKaDp
	rCx9MmrRgNR7bi/Oh6YP+oA1t47Od0g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-iYaUPKAfPv6_RvXWSa6UDQ-1; Thu,
 06 Nov 2025 01:59:23 -0500
X-MC-Unique: iYaUPKAfPv6_RvXWSa6UDQ-1
X-Mimecast-MFC-AGG-ID: iYaUPKAfPv6_RvXWSa6UDQ_1762412361
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B35E81800358;
	Thu,  6 Nov 2025 06:59:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4D92196B8F6;
	Thu,  6 Nov 2025 06:59:14 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 1/2] kernel/kexec: Change the prototype of kimage_map_segment()
Date: Thu,  6 Nov 2025 14:59:03 +0800
Message-ID: <20251106065904.10772-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The kexec segment index will be required to extract the corresponding
information for that segment in kimage_map_segment(). Additionally,
kexec_segment already holds the kexec relocation destination address and
size. Therefore, the prototype of kimage_map_segment() can be changed.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Steven Chen <chenste@linux.microsoft.com>
Cc: <stable@vger.kernel.org>
To: kexec@lists.infradead.org
To: linux-integrity@vger.kernel.org
---
 include/linux/kexec.h              | 4 ++--
 kernel/kexec_core.c                | 9 ++++++---
 security/integrity/ima/ima_kexec.c | 4 +---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ff7e231b0485..8a22bc9b8c6c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
 #define kexec_dprintk(fmt, arg...) \
         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
-extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
+extern void *kimage_map_segment(struct kimage *image, int idx);
 extern void kimage_unmap_segment(void *buffer);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
@@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
-static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
+static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..9a1966207041 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int idx)
 	return result;
 }
 
-void *kimage_map_segment(struct kimage *image,
-			 unsigned long addr, unsigned long size)
+void *kimage_map_segment(struct kimage *image, int idx)
 {
+	unsigned long addr, size, eaddr;
 	unsigned long src_page_addr, dest_page_addr = 0;
-	unsigned long eaddr = addr + size;
 	kimage_entry_t *ptr, entry;
 	struct page **src_pages;
 	unsigned int npages;
 	void *vaddr = NULL;
 	int i;
 
+	addr = image->segment[idx].mem;
+	size = image->segment[idx].memsz;
+	eaddr = addr + size;
+
 	/*
 	 * Collect the source pages and map them in a contiguous VA range.
 	 */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7362f68f2d8b..5beb69edd12f 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
 	if (!image->ima_buffer_addr)
 		return;
 
-	ima_kexec_buffer = kimage_map_segment(image,
-					      image->ima_buffer_addr,
-					      image->ima_buffer_size);
+	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
 	if (!ima_kexec_buffer) {
 		pr_err("Could not map measurements buffer.\n");
 		return;
-- 
2.49.0


