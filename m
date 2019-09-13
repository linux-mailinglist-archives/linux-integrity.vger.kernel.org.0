Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70833B28A8
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2019 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404024AbfIMWuS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Sep 2019 18:50:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46644 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404146AbfIMWuR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Sep 2019 18:50:17 -0400
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5ABC020B7187;
        Fri, 13 Sep 2019 15:50:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5ABC020B7187
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc:     arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org, bauerman@linux.ibm.com,
        zohar@linux.ibm.com
Subject: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement log in kexec_file_load
Date:   Fri, 13 Sep 2019 15:50:09 -0700
Message-Id: <20190913225009.3406-2-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913225009.3406-1-prsriva@linux.microsoft.com>
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

During kexec_file_load, carrying forward the ima measurement log allows
a verifying party to get the entire runtime event log since the last
full reboot since that is when PCRs were last reset.

Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
---
 arch/arm64/Kconfig                     |   7 +
 arch/arm64/include/asm/ima.h           |  29 ++++
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/Makefile             |   3 +-
 arch/arm64/kernel/ima_kexec.c          | 213 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   6 +
 6 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..f39b12dbf9e8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -976,6 +976,13 @@ config KEXEC_VERIFY_SIG
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
+config HAVE_IMA_KEXEC
+	bool "Carry over IMA measurement log during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	help
+	  Select this option to carry over IMA measurement log during
+	  kexec_file_load.
+
 config KEXEC_IMAGE_VERIFY_SIG
 	bool "Enable Image signature verification support"
 	default y
diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
new file mode 100644
index 000000000000..e23cee84729f
--- /dev/null
+++ b/arch/arm64/include/asm/ima.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_IMA_H
+#define _ASM_ARM64_IMA_H
+
+struct kimage;
+
+int ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_free_kexec_buffer(void);
+
+#ifdef CONFIG_IMA
+void remove_ima_buffer(void *fdt, int chosen_node);
+#else
+static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
+#endif
+
+#ifdef CONFIG_IMA_KEXEC
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size);
+
+int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
+#else
+static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
+				   int chosen_node)
+{
+	remove_ima_buffer(fdt, chosen_node);
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
+#endif /* _ASM_ARM64_IMA_H */
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 12a561a54128..e8d2412066e7 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -96,6 +96,11 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	void *dtb;
 	unsigned long dtb_mem;
+
+#ifdef CONFIG_IMA_KEXEC
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
+#endif
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 478491f07b4f..580238f2e9a7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -55,7 +55,8 @@ obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
+obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o	\
+					   ima_kexec.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/ima_kexec.c b/arch/arm64/kernel/ima_kexec.c
new file mode 100644
index 000000000000..b14326d541f3
--- /dev/null
+++ b/arch/arm64/kernel/ima_kexec.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Microsoft Corporation.
+ *
+ * Authors:
+ * Prakhar Srivastava <prsriva@linux.microsoft.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+
+
+/**
+ * delete_fdt_mem_rsv - delete memory reservation with given address and size
+ * @fdt - pointer to the fdt.
+ * @start - start address of the memory.
+ * @size - number of cells to be deletd.
+ * 
+ * Return: 0 on success, or negative errno on error.
+ */
+int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
+{
+	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
+
+	for (i = 0; i < num_rsvs; i++) {
+		uint64_t rsv_start, rsv_size;
+
+		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+		if (ret) {
+			pr_err("Malformed device tree\n");
+			return -EINVAL;
+		}
+
+		if (rsv_start == start && rsv_size == size) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret) {
+				pr_err("Error deleting device tree reservation\n");
+				return -EINVAL;
+			}
+
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/**
+ * remove_ima_buffer - remove the IMA buffer property and reservation
+ * @fdt - pointer the fdt.
+ * @chosen_node - node under which property can be found.
+ * 
+ * The IMA measurement buffer is either read by now and freeed or a kexec call
+ * needs to replace the ima measurement buffer, clear the property and memory
+ * reservation.
+ */
+void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	int ret, len;
+	const void *prop;
+	uint64_t tmp_start, tmp_end;
+
+	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
+	if (prop) {
+		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		prop = fdt_getprop(fdt, chosen_node,
+				   "linux,ima-kexec-buffer-end", &len);
+		if (!prop)
+			return;
+
+		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		ret = delete_fdt_mem_rsv(fdt, tmp_start, tmp_end - tmp_start);
+
+		if (ret == 0)
+			pr_debug("Removed old IMA buffer reservation.\n");
+		else if (ret != -ENOENT)
+			return;
+
+		fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+		fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer-end");
+	}
+}
+
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	int len;
+	const void *prop;
+	uint64_t tmp_start, tmp_end;
+
+	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
+	if (!prop)
+		return -ENOENT;
+
+	tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer-end", &len);
+	if (!prop)
+		return -ENOENT;
+
+	tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+	*addr = __va(tmp_start);
+	*size = tmp_end - tmp_start;
+
+	return 0;
+}
+
+/**
+ * ima_free_kexec_buffer - free memory used by the IMA buffer
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int ima_free_kexec_buffer(void)
+{
+	int ret;
+	void *propStart, *propEnd;
+	uint64_t tmp_start, tmp_end;
+
+	propStart = of_find_property(of_chosen, "linux,ima-kexec-buffer",
+				     NULL);
+	if (propStart) {
+		tmp_start = fdt64_to_cpu(*((const fdt64_t *) propStart));
+		ret = of_remove_property(of_chosen, propStart);
+		if (!ret) {
+			return ret;
+		}
+
+		propEnd = of_find_property(of_chosen,
+					   "linux,ima-kexec-buffer-end", NULL);
+		if (!propEnd) {
+			return -EINVAL;
+		}
+
+		tmp_end = fdt64_to_cpu(*((const fdt64_t *) propEnd));
+
+		ret = of_remove_property(of_chosen, propEnd);
+		if (!ret) {
+			return ret;
+		}
+
+		return memblock_free(tmp_start, tmp_end - tmp_start);
+	}
+	return 0;
+}
+
+#ifdef CONFIG_IMA_KEXEC
+/**
+ * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA
+ * 	measurement log.
+ * @image: - pointer to the kimage, to store the address and size of the 
+ *	 IMA measurement log.
+ * @load_addr: - the address where the IMA measurement log is stored.
+ * @size - size of the IMA measurement log.
+ * 
+ * Return: 0 on success, negative errno on error.
+ */
+int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
+			      size_t size)
+{
+	image->arch.ima_buffer_addr = load_addr;
+	image->arch.ima_buffer_size = size;
+	return 0;
+}
+
+/**
+ * setup_ima_buffer - update the fdt to contain the ima mesasurement log
+ * @image: - pointer to the kimage, containing the address and size of
+ *	     the IMA measurement log.
+ * @fdt: - pointer to the fdt.
+ * @chosen_node: - node under which property is to be defined.
+ *  
+ * Return: 0 on success, negative errno on error.
+ */
+int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
+{
+	int ret;
+
+	remove_ima_buffer(fdt, chosen_node);
+
+	if (!image->arch.ima_buffer_size)
+		return 0;
+
+	ret = fdt_setprop_u64(fdt, chosen_node, "linux,ima-kexec-buffer",
+			      image->arch.ima_buffer_addr);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_u64(fdt, chosen_node, "linux,ima-kexec-buffer-end",
+			      image->arch.ima_buffer_addr +
+			      image->arch.ima_buffer_size);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
+			      image->arch.ima_buffer_size);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 58871333737a..de5452539c67 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 #include <asm/byteorder.h>
+#include <asm/ima.h>
 
 /* relevant device tree properties */
 #define FDT_PROP_INITRD_START	"linux,initrd-start"
@@ -85,6 +86,11 @@ static int setup_dtb(struct kimage *image,
 			goto out;
 	}
 
+	/* add ima measuremnet log buffer */
+	ret = setup_ima_buffer(image, dtb, off);
+	if (ret)
+		goto out;
+
 	/* add kaslr-seed */
 	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
 	if  (ret == -FDT_ERR_NOTFOUND)
-- 
2.17.1

