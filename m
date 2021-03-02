Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D032B30C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Mar 2021 04:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhCCB2S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Mar 2021 20:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835384AbhCBE5G (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Mar 2021 23:57:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDC9660238;
        Tue,  2 Mar 2021 04:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614660188;
        bh=VO/ybizvK8GgrGUKEsnjwa7WEw7b6nZvpUw+0sSbNNI=;
        h=From:To:Cc:Subject:Date:From;
        b=dwsKS/DsTXTVBOFeQw2mm7zswcX8LRx8dPSZoYJYqDAVDjpXKQgNjBs9slcURMbo6
         bYkp5iSyjGZdI3yc1qcK6LSQ3Yrz7y6+PBzqJjJIe/bP8AREYQKY0x+QUhcEjHD66D
         PC0r6Rt3/HRUq/KiZn0/fVvrvQUeWrqFT2fdiZolStrf3G7dq8gWyojbWUnpQAEm/C
         epIpiCD5GlyxnQjfBB8TDS0IXViz5t50g7xFsvM0atOBikREHpsWvJyFXHM7uMBRyh
         RzP5JWfaGIJSIK63+ofi9Zcje0qfO6WqkV5KZov3xFFXJcuJC+Z+RdxPRdAHhD/rwY
         l5gnSS8fUntBQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
Subject: [PATCH] x86/sgx: Replace section->init_laundry_list with a temp list
Date:   Tue,  2 Mar 2021 06:42:41 +0200
Message-Id: <20210302044241.457507-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Build a local laundry list in sgx_init(), and transfer its ownsership to
ksgxd for sanitization, thus getting rid of useless member in struct
sgx_epc_section.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/main.c | 64 ++++++++++++++++++----------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  7 ----
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 52d070fb4c9a..f4633a2b7685 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -30,35 +30,33 @@ static DEFINE_SPINLOCK(sgx_reclaimer_lock);
  * Reset dirty EPC pages to uninitialized state. Laundry can be left with SECS
  * pages whose child pages blocked EREMOVE.
  */
-static void sgx_sanitize_section(struct sgx_epc_section *section)
+static void sgx_sanitize_section(struct list_head *laundry)
 {
 	struct sgx_epc_page *page;
 	LIST_HEAD(dirty);
 	int ret;
 
 	/* init_laundry_list is thread-local, no need for a lock: */
-	while (!list_empty(&section->init_laundry_list)) {
+	while (!list_empty(laundry)) {
 		if (kthread_should_stop())
 			return;
 
-		/* needed for access to ->page_list: */
-		spin_lock(&section->lock);
-
-		page = list_first_entry(&section->init_laundry_list,
-					struct sgx_epc_page, list);
+		page = list_first_entry(laundry, struct sgx_epc_page, list);
 
 		ret = __eremove(sgx_get_epc_virt_addr(page));
-		if (!ret)
-			list_move(&page->list, &section->page_list);
-		else
+		if (!ret) {
+			/* The page is clean - move to the free list. */
+			list_del(&page->list);
+			sgx_free_epc_page(page);
+		} else {
+			/* The page is not yet clean - move to the dirty list. */
 			list_move_tail(&page->list, &dirty);
-
-		spin_unlock(&section->lock);
+		}
 
 		cond_resched();
 	}
 
-	list_splice(&dirty, &section->init_laundry_list);
+	list_splice(&dirty, laundry);
 }
 
 static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
@@ -405,6 +403,7 @@ static bool sgx_should_reclaim(unsigned long watermark)
 
 static int ksgxd(void *p)
 {
+	struct list_head *laundry = p;
 	int i;
 
 	set_freezable();
@@ -413,16 +412,13 @@ static int ksgxd(void *p)
 	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
-	for (i = 0; i < sgx_nr_epc_sections; i++)
-		sgx_sanitize_section(&sgx_epc_sections[i]);
+	sgx_sanitize_section(laundry);
+	sgx_sanitize_section(laundry);
 
-	for (i = 0; i < sgx_nr_epc_sections; i++) {
-		sgx_sanitize_section(&sgx_epc_sections[i]);
+	if (!list_empty(laundry))
+		WARN(1, "EPC section %d has unsanitized pages.\n", i);
 
-		/* Should never happen. */
-		if (!list_empty(&sgx_epc_sections[i].init_laundry_list))
-			WARN(1, "EPC section %d has unsanitized pages.\n", i);
-	}
+	kfree(laundry);
 
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
@@ -441,11 +437,11 @@ static int ksgxd(void *p)
 	return 0;
 }
 
-static bool __init sgx_page_reclaimer_init(void)
+static bool __init sgx_page_reclaimer_init(struct list_head *laundry)
 {
 	struct task_struct *tsk;
 
-	tsk = kthread_run(ksgxd, NULL, "ksgxd");
+	tsk = kthread_run(ksgxd, laundry, "ksgxd");
 	if (IS_ERR(tsk))
 		return false;
 
@@ -619,7 +615,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 					 unsigned long index,
-					 struct sgx_epc_section *section)
+					 struct sgx_epc_section *section,
+					 struct list_head *laundry)
 {
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	unsigned long i;
@@ -637,13 +634,12 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	section->phys_addr = phys_addr;
 	spin_lock_init(&section->lock);
 	INIT_LIST_HEAD(&section->page_list);
-	INIT_LIST_HEAD(&section->init_laundry_list);
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
-		list_add_tail(&section->pages[i].list, &section->init_laundry_list);
+		list_add_tail(&section->pages[i].list, laundry);
 	}
 
 	section->free_cnt = nr_pages;
@@ -661,7 +657,7 @@ static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
 	       ((high & GENMASK_ULL(19, 0)) << 32);
 }
 
-static bool __init sgx_page_cache_init(void)
+static bool __init sgx_page_cache_init(struct list_head *laundry)
 {
 	u32 eax, ebx, ecx, edx, type;
 	u64 pa, size;
@@ -684,7 +680,7 @@ static bool __init sgx_page_cache_init(void)
 
 		pr_info("EPC section 0x%llx-0x%llx\n", pa, pa + size - 1);
 
-		if (!sgx_setup_epc_section(pa, size, i, &sgx_epc_sections[i])) {
+		if (!sgx_setup_epc_section(pa, size, i, &sgx_epc_sections[i], laundry)) {
 			pr_err("No free memory for an EPC section\n");
 			break;
 		}
@@ -702,18 +698,25 @@ static bool __init sgx_page_cache_init(void)
 
 static int __init sgx_init(void)
 {
+	struct list_head *laundry;
 	int ret;
 	int i;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SGX))
 		return -ENODEV;
 
-	if (!sgx_page_cache_init()) {
+	laundry = kzalloc(sizeof(*laundry), GFP_KERNEL);
+	if (!laundry)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(laundry);
+
+	if (!sgx_page_cache_init(laundry)) {
 		ret = -ENOMEM;
 		goto err_page_cache;
 	}
 
-	if (!sgx_page_reclaimer_init()) {
+	if (!sgx_page_reclaimer_init(laundry)) {
 		ret = -ENOMEM;
 		goto err_page_cache;
 	}
@@ -733,6 +736,7 @@ static int __init sgx_init(void)
 		memunmap(sgx_epc_sections[i].virt_addr);
 	}
 
+	kfree(laundry);
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 5fa42d143feb..bc8af0428640 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -45,13 +45,6 @@ struct sgx_epc_section {
 	spinlock_t lock;
 	struct list_head page_list;
 	unsigned long free_cnt;
-
-	/*
-	 * Pages which need EREMOVE run on them before they can be
-	 * used.  Only safe to be accessed in ksgxd and init code.
-	 * Not protected by locks.
-	 */
-	struct list_head init_laundry_list;
 };
 
 extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
-- 
2.30.1

