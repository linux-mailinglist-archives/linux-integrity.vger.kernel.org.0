Return-Path: <linux-integrity+bounces-1200-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C700854D03
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 16:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E0928160F
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9955C91F;
	Wed, 14 Feb 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="glvPVa/T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68D5CDD1
	for <linux-integrity@vger.kernel.org>; Wed, 14 Feb 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925117; cv=none; b=HXRi4J6WnmWo3oJbed6cH5YXq2MGTImgnC/6GKUDnW7gBF9g/OPnljWxA1cRStfEgxMtWG9KbmxiUiFTmN+Pq7wwSlofzikQj81maPuI20JyYfgY7zPLrHlx45eGGgzI2FCWwMQLneqx1lZZ1Dy8eid5m7TwGKlVcIGdskzAe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925117; c=relaxed/simple;
	bh=zs/KuCw6ct70oTbY1eooDG1TbcwAYr82QH362DGDqWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfEbHuiU+YOimGGSg5r47KKh1lVlDwwouut1LtUcKzxkaIjVAwB2fbVSFew//CkRFRgtLcwy8joQ+dMpnYVlNq4uE1mEglI+vi0yTz+Ng+l6e34vXQwEwW4FvSv0Y22CCQ/bUU2TmY9Hh0Cl3LIPLcw57R0iMCPmoi5j7hiTaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=glvPVa/T; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 15EB520B2002;
	Wed, 14 Feb 2024 07:38:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15EB520B2002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707925115;
	bh=LcTxsTc0b07a3hDiMEx1iG60zRqK/2o70VjBYmhDdOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glvPVa/TGtuDhEkFVwkKEi0Q1Qkf14az1akcGyEfTWaMQe7uhhAiGP/bQD5a555OC
	 Odh4zVp4Uabf3N3DwFvfEnU3L2C6eXDBgUnW1zLs/EcFJKuxn5m8IA2IWfQJ1Vdoox
	 XqZqLMN+4QZxxMEDAXkVsHo1qRSeDdVyK+p/0osg=
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
Subject: [PATCH v5 2/8] kexec: define functions to map and unmap segments
Date: Wed, 14 Feb 2024 07:38:21 -0800
Message-Id: <20240214153827.1087657-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the mechanism to map and unmap segments to the kimage
structure is not available to the subsystems outside of kexec.  This
functionality is needed when IMA is allocating the memory segments
during kexec 'load' operation.  Implement functions to map and unmap
segments to kimage.

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
 include/linux/kexec.h | 13 ++++++++++
 kernel/kexec_core.c   | 59 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 400cb6c02176..3145447eb77a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -486,6 +486,11 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#define for_each_kimage_entry(image, ptr, entry) \
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE); \
+		ptr = (entry & IND_INDIRECTION) ? \
+			boot_phys_to_virt((entry & PAGE_MASK)) : ptr + 1)
+
 int crash_check_update_elfcorehdr(void);
 
 #ifndef crash_hotplug_cpu_support
@@ -507,6 +512,10 @@ extern bool kexec_file_dbg_print;
 	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
 	       ##__VA_ARGS__)
 
+extern void *kimage_map_segment(struct kimage *image,
+				unsigned long addr, unsigned long size);
+extern void kimage_unmap_segment(void *buffer);
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
@@ -514,6 +523,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
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
index d08fc7b5db97..612ad8783bab 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -582,11 +582,6 @@ void kimage_terminate(struct kimage *image)
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
@@ -909,6 +904,60 @@ int kimage_load_segment(struct kimage *image,
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
+		pr_err("%s: Could not map ima buffer.\n", __func__);
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
-- 
2.25.1


