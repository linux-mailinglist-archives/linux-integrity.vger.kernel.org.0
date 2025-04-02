Return-Path: <linux-integrity+bounces-5551-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A1A78F11
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B2B3B5AAA
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711EF23C8CD;
	Wed,  2 Apr 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N0z7C6O6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AD23C8AD;
	Wed,  2 Apr 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598065; cv=none; b=Sb+Q454HEick9621piQiddy00F8vfxonnvnvdY8k6APvDnA9krYtGtWtfybBaE9PUZppAMk8zR2ZEsc4enAcv5HmsvJt13npOix2UbrM1g9zhccVsMNrUbQp/LkLy/6o6ikF6YM7tV8pR6FTG/Khxw5MiFJUYN2469woMmwam9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598065; c=relaxed/simple;
	bh=sObjz7SqWq+sFEj3YUzSHtEK4BCJvAAQ5QgRpbWXFCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKP5KAMIwRZdwJ0x7BXJmxanlnJkXO1oEGDLsUGPbSwkqZLgbwpONnkZw/4IjtyOOir4tGsQjQP8p4zX1TM2eJCYAWsfDh2opP19z5PY4dagNPYQ7wTr1Q40xSQYvCdSRPFQ8Dj5NeaWZ+7TzNxTdDTYtnp665zzthIl8G2I5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N0z7C6O6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5AB832041314;
	Wed,  2 Apr 2025 05:47:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AB832041314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598063;
	bh=pL3ZRyfio2uIX3TrzfP4lwxC86hOBPNScu2MCFNBrag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0z7C6O6DQzbIyvrwGX05zSK0RLYv9bQfd7pijoDyzANgXnejWRJlKt7Zw7j2vcG0
	 eIuIPl4SSoThDxG282nMSlyldt5q4hopNmiXM25x6DBtRP2Ws/vMk+V8XZ8dhJT3AV
	 yxXuxieAfDmgkz97+P7odpZ+nSyNBcToweL3PyIg=
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
Subject: [PATCH v11 3/9] kexec: define functions to map and unmap segments
Date: Wed,  2 Apr 2025 05:47:16 -0700
Message-ID: <20250402124725.5601-4-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402124725.5601-1-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the kernel behavior during kexec load is to fetch the IMA
measurements logs and store logs in kernel memory. When a kexec reboot is
triggered, these stored logs in the kernel memory are carried over to the
second kernel. However, the time gap between kexec load and kexec reboot
can be very long. During this time window, new events extended into TPM 
PCRs miss the chance to be carried over to the second kernel. This results 
in a mismatch between TPM PCR quotes and the actual IMA measurements list
after kexec reboot, leading to remote attestation failure.

To solve this problem, the new design defers reading the IMA measurements
logs into the kexec buffer to the kexec reboot phase, while still allocating
the necessary buffer at kexec load time because it is not appropriate to 
allocate memory at the kexec reboot moment.

The content of memory segments carried over to the new kernel during the
kexec system call can be changed at the kexec 'execute' stage, but the size
of the memory segments cannot be changed at the kexec 'execute' stage.

To copy IMA measurement logs during the kexec operation, IMA allocates 
memory at the kexec 'load' stage and map the segments to the kimage 
structure. The mapped address will then be used to copy IMA measurements 
during the kexec 'execute' stage.

Currently, the mechanism to map and unmap segments to the kimage structure
is not available to subsystems outside of kexec.

Implement kimage_map_segment() to enable IMA to map the measurement log 
list to the kimage structure during the kexec 'load' stage. This function
takes a kimage pointer, a memory address, and a size, then gathers the
source pages within the specified address range, creates an array of page
pointers, and maps these to a contiguous virtual address range. The
function returns the start virtual address of this range if successful, 
or NULL on failure.

Implement kimage_unmap_segment() for unmapping segments using vunmap().

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com> 
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  6 +++++
 kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..7d6b12f8b8d0 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
 #define kexec_dprintk(fmt, arg...) \
         do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
+extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
+extern void kimage_unmap_segment(void *buffer);
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
+struct kimage;
 static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 static inline int kexec_crash_loaded(void) { return 0; }
+static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
+{ return NULL; }
+static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0bdc1686154..a5e378e1dc7f 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
 	return result;
 }
 
+void *kimage_map_segment(struct kimage *image,
+			 unsigned long addr, unsigned long size)
+{
+	unsigned long src_page_addr, dest_page_addr = 0;
+	unsigned long eaddr = addr + size;
+	kimage_entry_t *ptr, entry;
+	struct page **src_pages;
+	unsigned int npages;
+	void *vaddr = NULL;
+	int i;
+
+	/*
+	 * Collect the source pages and map them in a contiguous VA range.
+	 */
+	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
+	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
+	if (!src_pages) {
+		pr_err("Could not allocate ima pages array.\n");
+		return NULL;
+	}
+
+	i = 0;
+	for_each_kimage_entry(image, ptr, entry) {
+		if (entry & IND_DESTINATION) {
+			dest_page_addr = entry & PAGE_MASK;
+		} else if (entry & IND_SOURCE) {
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
+		pr_err("Could not map ima buffer.\n");
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


