Return-Path: <linux-integrity+bounces-851-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D42837194
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 20:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFA51C2A5B6
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jan 2024 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F6F54BE5;
	Mon, 22 Jan 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sLDas/Ov"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB354BD2
	for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948697; cv=none; b=hniObMcoliq2wm261tlnQ2HgqoDS0H2sX84WJrW3yZnPlpyLl+iacKgHhb+zFQWYfRTFZyvud6AvllTbPchl3RitH5xjkQQgIeYQaqjX1nCZx9PkSLntIbuRez4V9Guys0V4X5yNV+eDTHJBy25/TXY61m+OycNcNsuolEzjuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948697; c=relaxed/simple;
	bh=ZOrdno3y7/KMunBysKdCTRlJ8Eg0zvA6n9pFmmLI6Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSYcqK3dfwD93sdJMBFmdWH10NISQNegvvBQogtpFR0yg9UEG7CYPBHsPxQlvuSVvqI90IS/OpZskGmV4Mw5PPWyaPTvNWGbR3gyiwIEn77DaTlwj9LW3yfs0uvR2/dBqcaS46fsS6EafO69OEtddU9SHnM99fqiJXzVlZAH6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sLDas/Ov; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85C0820E2C12;
	Mon, 22 Jan 2024 10:38:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85C0820E2C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705948695;
	bh=FNPRDHEWO03k36za5OMYpzu6MavkRztENRokb7OKgbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLDas/Ovfnm56v//7NHkSDWoZJ69hjL6uEM6SJsU4X5gSthLlQZIIbpz0ZfZytvzU
	 oU+ZugGE+l4DZ9whVrTD3op0jvIevRAy37vWT7y9CvvZlPR15nRa1WQdIo2aBdIQCe
	 y65EJNTg8FKEJryPYJADJzpvR7MKTnnLMJaaelIQ=
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
Subject: [PATCH v4 2/7] kexec: define functions to map and unmap segments
Date: Mon, 22 Jan 2024 10:37:59 -0800
Message-Id: <20240122183804.3293904-3-tusharsu@linux.microsoft.com>
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

Implement kimage_map_segment() to enable mapping of IMA buffer source
pages to the kimage structure post kexec 'load'.  This function,
accepting a kimage pointer, an address, and a size, will gather the
source pages within the specified address range, create an array of page
pointers, and map these to a contiguous virtual address range.  The
function returns the start of this range if successful, or NULL if
unsuccessful.

Implement kimage_unmap_segment() for unmapping segments
using vunmap().  Relocate 'for_each_kimage_entry()' macro from
kexec_core.c to kexec.h for broader accessibility.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/kexec.h              | 13 +++++++
 kernel/kexec_core.c                | 59 +++++++++++++++++++++++++++---
 security/integrity/ima/ima_kexec.c |  1 +
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..e00b8101b53b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -490,6 +490,15 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#define for_each_kimage_entry(image, ptr, entry) \
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
+		ptr = (entry & IND_INDIRECTION) ? \
+			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
+
+extern void *kimage_map_segment(struct kimage *image,
+				unsigned long addr, unsigned long size);
+extern void kimage_unmap_segment(void *buffer);
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -497,6 +506,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void *kimage_map_segment(struct kimage *image,
+				       unsigned long addr, unsigned long size)
+{ return NULL; }
+static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..26978ad02676 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -594,11 +594,6 @@ void kimage_terminate(struct kimage *image)
 	*image->entry = IND_DONE;
 }
 
-#define for_each_kimage_entry(image, ptr, entry) \
-	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
-		ptr = (entry & IND_INDIRECTION) ? \
-			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
-
 static void kimage_free_entry(kimage_entry_t entry)
 {
 	struct page *page;
@@ -921,6 +916,60 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+void *kimage_map_segment(struct kimage *image,
+			 unsigned long addr, unsigned long size)
+{
+	unsigned long eaddr = addr + size;
+	unsigned long src_page_addr, dest_page_addr;
+	unsigned int npages;
+	struct page **src_pages;
+	int i;
+	kimage_entry_t *ptr, entry;
+	void *vaddr = NULL;
+
+	/*
+	 * Collect the source pages and map them in a contiguous VA range.
+	 */
+	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
+	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
+	if (!src_pages) {
+		pr_err("%s: Could not allocate ima pages array.\n", __func__);
+		return NULL;
+	}
+
+	i = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION)
+			dest_page_addr = entry & PAGE_MASK;
+		else if (entry & IND_SOURCE) {
+			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
+				src_page_addr = entry & PAGE_MASK;
+				src_pages[i++] =
+					virt_to_page(__va(src_page_addr));
+				if (i == npages)
+					break;
+				dest_page_addr += PAGE_SIZE;
+			}
+		}
+	}
+
+	/* Sanity check. */
+	WARN_ON(i < npages);
+
+	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
+	kfree(src_pages);
+
+	if (!vaddr)
+		pr_err("%s: Could not map imap buffer.\n", __func__);
+
+	return vaddr;
+}
+
+void kimage_unmap_segment(void *segment_buffer)
+{
+	vunmap(segment_buffer);
+}
+
 struct kexec_load_limit {
 	/* Mutex protects the limit count. */
 	struct mutex mutex;
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 99daac355c70..4f944c9b4168 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -170,6 +170,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
 }
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1


