Return-Path: <linux-integrity+bounces-516-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6788155DB
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Dec 2023 02:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE05B23EFC
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Dec 2023 01:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50B615B0;
	Sat, 16 Dec 2023 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="C8hPoGvc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359FB1106
	for <linux-integrity@vger.kernel.org>; Sat, 16 Dec 2023 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E6402076F97;
	Fri, 15 Dec 2023 17:07:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E6402076F97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702688859;
	bh=WRUE4Clb8fnKLP41fDDCg3tM3zzmPHm2nOglKL89s2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8hPoGvcmAnBn++ieHTbpOQi8WiRDANFkxuC2zvc0wbxcd+pHIU9RpDL0K9lL6FvN
	 FIwCj/750LoXesQrLZ1cBtVsdRJPFVToTL3VQm7i1EF9tgazve89DbozeYRCYgx6VM
	 24wCySciVx69P/jqROjokQ2xhvT4tmpC6uQkjxLM=
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
Subject: [PATCH v3 3/7] ima: kexec: map IMA buffer source pages to image after kexec load
Date: Fri, 15 Dec 2023 17:07:25 -0800
Message-Id: <20231216010729.2904751-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement kimage_map_segment() to enable mapping of IMA buffer source
pages to the kimage structure post kexec 'load'. This function, accepting
a kimage pointer, an address, and a size, will gather the source pages
within the specified address range, create an array of page pointers, and
map these to a contiguous virtual address range. The function returns the
start of this range if successful, or NULL if unsuccessful.

Additionally, introduce kimage_unmap_segment() for unmapping segments
using vunmap().

Introduce ima_kexec_post_load(), to be invoked by IMA following the kexec
'load' of the new Kernel image. This function will map the IMA buffer,
allocated during kexec 'load', to a segment in the loaded image.

Lastly, relocate the for_each_kimage_entry() macro from kexec_core.c to
kexec.h for broader accessibility.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 include/linux/ima.h                |  3 ++
 include/linux/kexec.h              | 13 +++++++
 kernel/kexec_core.c                | 59 +++++++++++++++++++++++++++---
 security/integrity/ima/ima_kexec.c | 32 ++++++++++++++++
 4 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 86b57757c7b1..006db20f852d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -49,6 +49,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
+extern void ima_kexec_post_load(struct kimage *image);
+#else
+static inline void ima_kexec_post_load(struct kimage *image) {}
 #endif
 
 #else
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index fd94404acc66..eb98aca7f4c7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -493,6 +493,15 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
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
@@ -500,6 +509,10 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
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
index 0063d5e7b634..55bd5362262e 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -12,12 +12,15 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/ima.h>
+#include <linux/reboot.h>
+#include <asm/page.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
 struct seq_file ima_kexec_file;
 static void *ima_kexec_buffer;
 static size_t kexec_segment_size;
+static bool ima_kexec_update_registered;
 
 void ima_free_kexec_file_buf(struct seq_file *sf)
 {
@@ -201,6 +204,7 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 	}
 	memcpy(ima_kexec_buffer, buf, buf_size);
 out:
+	kimage_unmap_segment(ima_kexec_buffer);
 	ima_kexec_buffer = NULL;
 
 	if (resume)
@@ -213,6 +217,34 @@ struct notifier_block update_buffer_nb = {
 	.notifier_call = ima_update_kexec_buffer,
 };
 
+/*
+ * Create a mapping for the source pages that contain the IMA buffer
+ * so we can update it later.
+ */
+void ima_kexec_post_load(struct kimage *image)
+{
+	if (ima_kexec_buffer) {
+		kimage_unmap_segment(ima_kexec_buffer);
+		ima_kexec_buffer = NULL;
+	}
+
+	if (!image->ima_buffer_addr)
+		return;
+
+	ima_kexec_buffer = kimage_map_segment(image,
+					      image->ima_buffer_addr,
+					      image->ima_buffer_size);
+	if (!ima_kexec_buffer) {
+		pr_err("%s: Could not map measurements buffer.\n", __func__);
+		return;
+	}
+
+	if (!ima_kexec_update_registered) {
+		register_reboot_notifier(&update_buffer_nb);
+		ima_kexec_update_registered = true;
+	}
+}
+
 #endif /* IMA_KEXEC */
 
 /*
-- 
2.25.1


