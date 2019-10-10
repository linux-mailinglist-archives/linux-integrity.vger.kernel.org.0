Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81426D1D3D
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2019 02:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfJJANB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Oct 2019 20:13:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43792 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbfJJANB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Oct 2019 20:13:01 -0400
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F5A420B711B;
        Wed,  9 Oct 2019 17:13:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F5A420B711B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570666380;
        bh=7P5k7YwpHfvQvOjglsK2XRSZ86bDHXhQgf/q8X1TJq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtLpIgrgQHHeH/omv+a/geHEkjWdXHwUhu5mh4sLGItcDPRhhl6SxfdHGhiyJrQS/
         +Rj4NRUqY8pnQBE1lcaRZH8+dNmm7BKefdEC6qVGxHEGcTgaioxXWh0mowFCEmhUJe
         ACjpBImAgalZSnXh4IajORsQJQF/gpWsjgMKNT5M=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc:     arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org, bauerman@linux.ibm.com,
        zohar@linux.ibm.com
Subject: [PATCH v3 2/2] update powerpc implementation to call into of_ima*
Date:   Wed,  9 Oct 2019 17:12:51 -0700
Message-Id: <20191010001251.22746-3-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010001251.22746-1-prsriva@linux.microsoft.com>
References: <20191010001251.22746-1-prsriva@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

update powerpc ima buffer pass implementationt to call into
of_ima* for a cross architecture support.

Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h  |   6 --
 arch/powerpc/kernel/Makefile    |   8 +-
 arch/powerpc/kernel/ima_kexec.c | 170 +++-----------------------------
 3 files changed, 16 insertions(+), 168 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..5ecff8896eed 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -6,12 +6,7 @@ struct kimage;
 
 int ima_get_kexec_buffer(void **addr, size_t *size);
 int ima_free_kexec_buffer(void);
-
-#ifdef CONFIG_IMA
 void remove_ima_buffer(void *fdt, int chosen_node);
-#else
-static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
-#endif
 
 #ifdef CONFIG_IMA_KEXEC
 int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
@@ -26,5 +21,4 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 	return 0;
 }
 #endif /* CONFIG_IMA_KEXEC */
-
 #endif /* _ASM_POWERPC_IMA_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 56dfa7a2a6f2..6a3d8fd6f1df 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -126,12 +126,8 @@ obj-$(CONFIG_PCI)		+= pci_$(BITS).o $(pci64-y) \
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o crash.o \
 				   machine_kexec_$(BITS).o
-obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file_$(BITS).o kexec_elf_$(BITS).o
-ifdef CONFIG_HAVE_IMA_KEXEC
-ifdef CONFIG_IMA
-obj-y				+= ima_kexec.o
-endif
-endif
+obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file_$(BITS).o kexec_elf_$(BITS).o \
+				   ima_kexec.o
 
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
diff --git a/arch/powerpc/kernel/ima_kexec.c b/arch/powerpc/kernel/ima_kexec.c
index 720e50e490b6..41f52297de0c 100644
--- a/arch/powerpc/kernel/ima_kexec.c
+++ b/arch/powerpc/kernel/ima_kexec.c
@@ -6,45 +6,21 @@
  * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
  */
 
-#include <linux/slab.h>
 #include <linux/kexec.h>
 #include <linux/of.h>
-#include <linux/memblock.h>
-#include <linux/libfdt.h>
 
-static int get_addr_size_cells(int *addr_cells, int *size_cells)
+/**
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
+ */
+void remove_ima_buffer(void *fdt, int chosen_node)
 {
-	struct device_node *root;
-
-	root = of_find_node_by_path("/");
-	if (!root)
-		return -EINVAL;
-
-	*addr_cells = of_n_addr_cells(root);
-	*size_cells = of_n_size_cells(root);
-
-	of_node_put(root);
-
-	return 0;
+	fdt_remove_ima_buffer(fdt, chosen_node);
+	return;
 }
 
-static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
-			       size_t *size)
-{
-	int ret, addr_cells, size_cells;
-
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
-	if (ret)
-		return ret;
-
-	if (len < 4 * (addr_cells + size_cells))
-		return -ENOENT;
-
-	*addr = of_read_number(prop, addr_cells);
-	*size = of_read_number(prop + 4 * addr_cells, size_cells);
-
-	return 0;
-}
 
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
@@ -55,23 +31,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  */
 int ima_get_kexec_buffer(void **addr, size_t *size)
 {
-	int ret, len;
-	unsigned long tmp_addr;
-	size_t tmp_size;
-	const void *prop;
-
-	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return -ENOENT;
-
-	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
-	if (ret)
-		return ret;
-
-	*addr = __va(tmp_addr);
-	*size = tmp_size;
-
-	return 0;
+	return of_get_ima_buffer(addr, size);
 }
 
 /**
@@ -79,52 +39,7 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
  */
 int ima_free_kexec_buffer(void)
 {
-	int ret;
-	unsigned long addr;
-	size_t size;
-	struct property *prop;
-
-	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
-	if (!prop)
-		return -ENOENT;
-
-	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
-	if (ret)
-		return ret;
-
-	ret = of_remove_property(of_chosen, prop);
-	if (ret)
-		return ret;
-
-	return memblock_free(addr, size);
-
-}
-
-/**
- * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
- *
- * The IMA measurement buffer is of no use to a subsequent kernel, so we always
- * remove it from the device tree.
- */
-void remove_ima_buffer(void *fdt, int chosen_node)
-{
-	int ret, len;
-	unsigned long addr;
-	size_t size;
-	const void *prop;
-
-	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
-	if (!prop)
-		return;
-
-	ret = do_get_kexec_buffer(prop, len, &addr, &size);
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
-	if (ret)
-		return;
-
-	ret = delete_fdt_mem_rsv(fdt, addr, size);
-	if (!ret)
-		pr_debug("Removed old IMA buffer reservation.\n");
+	return of_remove_ima_buffer();
 }
 
 #ifdef CONFIG_IMA_KEXEC
@@ -145,27 +60,6 @@ int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
 	return 0;
 }
 
-static int write_number(void *p, u64 value, int cells)
-{
-	if (cells == 1) {
-		u32 tmp;
-
-		if (value > U32_MAX)
-			return -EINVAL;
-
-		tmp = cpu_to_be32(value);
-		memcpy(p, &tmp, sizeof(tmp));
-	} else if (cells == 2) {
-		u64 tmp;
-
-		tmp = cpu_to_be64(value);
-		memcpy(p, &tmp, sizeof(tmp));
-	} else
-		return -EINVAL;
-
-	return 0;
-}
-
 /**
  * setup_ima_buffer - add IMA buffer information to the fdt
  * @image:		kexec image being loaded.
@@ -176,44 +70,8 @@ static int write_number(void *p, u64 value, int cells)
  */
 int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 {
-	int ret, addr_cells, size_cells, entry_size;
-	u8 value[16];
-
-	remove_ima_buffer(fdt, chosen_node);
-	if (!image->arch.ima_buffer_size)
-		return 0;
-
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
-	if (ret)
-		return ret;
-
-	entry_size = 4 * (addr_cells + size_cells);
-
-	if (entry_size > sizeof(value))
-		return -EINVAL;
-
-	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
-	if (ret)
-		return ret;
-
-	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
-			   size_cells);
-	if (ret)
-		return ret;
-
-	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
-			  entry_size);
-	if (ret < 0)
-		return -EINVAL;
-
-	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
-			      image->arch.ima_buffer_size);
-	if (ret)
-		return -EINVAL;
-
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
-
-	return 0;
+	return fdt_setup_ima_buffer(image->arch.ima_buffer_addr,
+				    image->arch.ima_buffer_size,
+				    fdt, chosen_node);
 }
 #endif /* CONFIG_IMA_KEXEC */
-- 
2.17.1

