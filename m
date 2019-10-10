Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06610D1D3C
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2019 02:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbfJJANB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Oct 2019 20:13:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43756 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbfJJANB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Oct 2019 20:13:01 -0400
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2A03120B7116;
        Wed,  9 Oct 2019 17:13:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A03120B7116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570666380;
        bh=p9+2DKMH93kDaxiSJOjH/uArEBB549sAk7ZJZ5Mzjgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahvOIPiS8IQ9Cd4glw0AYfyBCXvcUlxpzFTQeTauwTsF/NkrDbxbCBRePczL7OW/d
         OjDQMy6tOvjE8VpD0ec3IfkYvpI7Kl/zFN2H9fF+Mj5Sv87LLJXLCOaI98ba9C21PA
         kzqAEDLJv7izm7pqbiQ8gwq0OO/Kx8tZTai2FvUk=
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc:     arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org, bauerman@linux.ibm.com,
        zohar@linux.ibm.com
Subject: [PATCH v3 1/2] Add support for arm64 to carry ima measurement log in kexec_file_load
Date:   Wed,  9 Oct 2019 17:12:50 -0700
Message-Id: <20191010001251.22746-2-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010001251.22746-1-prsriva@linux.microsoft.com>
References: <20191010001251.22746-1-prsriva@linux.microsoft.com>
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
 arch/arm64/include/asm/ima.h           |  24 +++
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/Makefile             |   3 +-
 arch/arm64/kernel/ima_kexec.c          |  78 ++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   6 +
 arch/powerpc/Kconfig                   |   6 +
 drivers/of/Kconfig                     |   6 +
 drivers/of/Makefile                    |   1 +
 drivers/of/of_ima.c                    | 204 +++++++++++++++++++++++++
 include/linux/of.h                     |  31 ++++
 11 files changed, 370 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c
 create mode 100644 drivers/of/of_ima.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..017eb73b9c69 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -988,6 +988,13 @@ comment "Support for PE file signature verification disabled"
 	depends on KEXEC_VERIFY_SIG
 	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
 
+config HAVE_IMA_KEXEC
+	bool "Carry over IMA measurement log during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	help
+	  Select this option to carry over IMA measurement log during
+	  kexec_file_load
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
new file mode 100644
index 000000000000..287dbcefd15e
--- /dev/null
+++ b/arch/arm64/include/asm/ima.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_IMA_H
+#define _ASM_ARM64_IMA_H
+
+struct kimage;
+
+int ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_free_kexec_buffer(void);
+void remove_ima_buffer(void *fdt, int chosen_node);
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
index 000000000000..c2450aaa42c8
--- /dev/null
+++ b/arch/arm64/kernel/ima_kexec.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Microsoft Corporation.
+ *
+ * Authors:
+ * Prakhar Srivastava <prsriva@linux.microsoft.com>
+ */
+
+#include <linux/kexec.h>
+#include <linux/of.h>
+
+/**
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
+ * The IMA measurement buffer once read needs to be freed.
+ */
+void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	fdt_remove_ima_buffer(fdt, chosen_node);
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
+	return of_get_ima_buffer(addr, size);
+}
+
+/**
+ * ima_free_kexec_buffer - free memory used by the IMA buffer
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int ima_free_kexec_buffer(void)
+{
+	return of_remove_ima_buffer();
+}
+
+#ifdef CONFIG_IMA_KEXEC
+/**
+ * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA
+ *	measurement log.
+ * @image: - pointer to the kimage, to store the address and size of the
+ *	IMA measurement log.
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
+	return fdt_setup_ima_buffer(image->arch.ima_buffer_addr,
+				    image->arch.ima_buffer_size,
+				    fdt, chosen_node);
+
+}
+#endif /* CONFIG_IMA_KEXEC */
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 58871333737a..86d57198d739 100644
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
+	if (ret < 0)
+		goto out;
+
 	/* add kaslr-seed */
 	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
 	if  (ret == -FDT_ERR_NOTFOUND)
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d8dcd8820369..961dd4e220a2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -506,6 +506,12 @@ config KEXEC
 	  interface is strongly in flux, so no good recommendation can be
 	  made.
 
+config HAVE_IMA_KEXEC
+	bool "Carry over IMA measurement log during kexec_file_load() syscall"
+	help
+	  Select this option to carry over IMA measurement log during
+	  kexec_file_load.
+
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 37c2ccbefecd..167c6ecb64aa 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -103,4 +103,10 @@ config OF_OVERLAY
 config OF_NUMA
 	bool
 
+config OF_IMA
+	def_bool y
+	help
+	  IMA related wrapper functions to add/remove ima measurement logs during
+	  kexec_file_load call.
+
 endif # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 663a4af0cccd..b4caf083df4e 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
 obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 obj-$(CONFIG_OF_NUMA) += of_numa.o
+obj-$(CONFIG_OF_IMA) += of_ima.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/of_ima.c b/drivers/of/of_ima.c
new file mode 100644
index 000000000000..cfc3cb4522b0
--- /dev/null
+++ b/drivers/of/of_ima.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Microsoft Corporation.
+ */
+
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+
+/**
+ * delete_fdt_mem_rsv - delete memory reservation with given address and size
+ * @fdt - pointer to the fdt.
+ * @start - start address of the memory.
+ * @size - number of cells to be deletd.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int fdt_delete_mem_rsv(void *fdt, unsigned long start, unsigned long size)
+{
+	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
+
+	for (i = 0; i < num_rsvs; i++) {
+		uint64_t rsv_start, rsv_size;
+
+		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
+		if (ret < 0) {
+			pr_err("Malformed device tree\n");
+			return ret;
+		}
+
+		if (rsv_start == start && rsv_size == size) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret < 0) {
+				pr_err("Error deleting device tree reservation\n");
+				return ret;
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
+ * of_get_ima_buffer_properties - get the properties for ima buffer
+ * @ima_buf_start - start of the ima buffer
+ * @ima_buf_end - end of the ima buffer
+ *	If any one of the properties is not found. The device tree
+ *	is malformed or something went wrong.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int of_get_ima_buffer_properties(void **ima_buf_start, void **ima_buf_end)
+{
+	struct property *pproperty;
+
+	pproperty = of_find_property(of_chosen, "linux,ima-kexec-buffer",
+				    NULL);
+	*ima_buf_start = pproperty ? pproperty->value : NULL;
+
+	pproperty = of_find_property(of_chosen, "linux,ima-kexec-buffer-end",
+				    NULL);
+	*ima_buf_end = pproperty ? pproperty->value : NULL;
+
+	if (!*ima_buf_start || !*ima_buf_end)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * of_remove_ima_buffer - free memory used by the IMA buffer
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int of_remove_ima_buffer(void)
+{
+	int ret;
+	void *ima_buf_start, *ima_buf_end;
+	uint64_t buf_start, buf_end;
+
+	ret = of_get_ima_buffer_properties(&ima_buf_start, &ima_buf_end);
+	if (ret < 0)
+		return ret;
+
+	buf_start = fdt64_to_cpu(*((const fdt64_t *) ima_buf_start));
+	buf_end = fdt64_to_cpu(*((const fdt64_t *) ima_buf_end));
+
+	ret = of_remove_property(of_chosen, ima_buf_start);
+	if (ret < 0)
+		return ret;
+
+	ret = of_remove_property(of_chosen, ima_buf_end);
+	if (ret < 0)
+		return ret;
+
+	return memblock_free(buf_start, buf_end - buf_start);
+}
+
+/**
+ * of_get_ima_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int of_get_ima_buffer(void **addr, size_t *size)
+{
+	int ret;
+	void *ima_buf_start, *ima_buf_end;
+	uint64_t buf_start, buf_end;
+
+	ret = of_get_ima_buffer_properties(&ima_buf_start, &ima_buf_end);
+	if (ret < 0)
+		return ret;
+
+	buf_start = fdt64_to_cpu(*((const fdt64_t *) ima_buf_start));
+	buf_end = fdt64_to_cpu(*((const fdt64_t *) ima_buf_end));
+
+	*addr = __va(buf_start);
+	*size = buf_end - buf_start;
+
+	return 0;
+}
+
+/**
+ * fdt_remove_ima_buffer - remove the IMA buffer property and reservation
+ * @fdt - pointer the fdt.
+ * @chosen_node - node under which property can be found.
+ *
+ * The IMA measurement buffer is either read by now and freeed or a kexec call
+ * needs to replace the ima measurement buffer, clear the property and memory
+ * reservation.
+ */
+void fdt_remove_ima_buffer(void *fdt, int chosen_node)
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
+		ret = fdt_delete_mem_rsv(fdt, tmp_start, tmp_end - tmp_start);
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
+ * fdt_setup_ima_buffer - update the fdt to contain the ima mesasurement log
+ * @image: - pointer to the kimage, containing the address and size of
+ *	     the IMA measurement log.
+ * @fdt: - pointer to the fdt.
+ * @chosen_node: - node under which property is to be defined.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int fdt_setup_ima_buffer(const phys_addr_t ima_buffer_addr,
+	const size_t ima_buffer_size,
+	void *fdt, int chosen_node)
+{
+	int ret;
+
+	fdt_remove_ima_buffer(fdt, chosen_node);
+
+	if (!ima_buffer_addr)
+		return 0;
+
+	ret = fdt_setprop_u64(fdt, chosen_node, "linux,ima-kexec-buffer",
+			      ima_buffer_addr);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_u64(fdt, chosen_node, "linux,ima-kexec-buffer-end",
+			      ima_buffer_addr +
+			      ima_buffer_size);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_add_mem_rsv(fdt, ima_buffer_addr,
+			      ima_buffer_size);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index 844f89e1b039..c24baca43f18 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1477,4 +1477,35 @@ static inline int of_overlay_notifier_unregister(struct notifier_block *nb)
 
 #endif
 
+#ifdef CONFIG_OF_IMA
+int of_remove_ima_buffer(void);
+int of_get_ima_buffer(void **addr, size_t *size);
+void fdt_remove_ima_buffer(void *fdt, int chosen_node);
+int fdt_setup_ima_buffer(const phys_addr_t ima_buffer_addr,
+	const size_t ima_buffer_size,
+	void *fdt, int chosen_node);
+#else
+static inline int of_remove_ima_buffer(void)
+{
+	return -ENOTSUPP;
+};
+
+static inline int of_get_ima_buffer(void **addr, size_t *size)
+{
+	return -ENOTSUPP;
+};
+
+static inline void fdt_remove_ima_buffer(void *fdt, int chosen_node)
+{
+	return;
+};
+
+static inline int fdt_setup_ima_buffer(const phys_addr_t ima_buffer_addr,
+	const size_t ima_buffer_size, void *fdt, int chosen_node)
+{
+	return -ENOTSUPP;
+};
+
+#endif
+
 #endif /* _LINUX_OF_H */
-- 
2.17.1

