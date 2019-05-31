Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F19316E8
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Jun 2019 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaWHg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 May 2019 18:07:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38525 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfEaWHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 May 2019 18:07:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so4757548pgl.5;
        Fri, 31 May 2019 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wwEB+viJtVr8l42IEROtmss+3bJl6sJ6i2svX1dSYLA=;
        b=LCwxuKliMnPPUu9aYGV1RV9VnHz7rHK0HZqosB7Aor204PjvDWWTYEVWZ5K24pn3UY
         0EsHgKBn97IeueC7nnNaN2N2G+56vWD2gWBLE/8amw1+VxHyU4d4l3qqe5/jSD5TwPKX
         Qx1QFLnT3yKKMATXadYrC9sGsf3MZXRvKp+h2/5h7Sw8ssPc/p/4Q0GnZ7VVfhv3qSyF
         B4w7pwYnHHEDGaKH9KWde7vdy8nGMCj/eADnAUVmWp/tdR75FMTwFL0psmpqV9+qMoho
         +U7m2l+vpTey64Y2EKcSEwRlUL4QK958O6FtI9CupdtD2Cc4zmb4zjvZ7Weo843Lhjt1
         1QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wwEB+viJtVr8l42IEROtmss+3bJl6sJ6i2svX1dSYLA=;
        b=HWGO2Gx0ziS7cv/Eq58tlEYKrzX4Ijc8Owv6fvzNcNhEMEOHNNOgf1uCtgMAbSUSOE
         d1Mc4g2613NoYVbQqtJqZS14HBbgoxX79NDd3nP4DHU7cwjMrTtcYNgp/m4tuNo3+DQo
         3C0YuU7rY71N4xDKWHf476sG29YTgE8M9zEDzGVrZVHto7iHWoUj8GDDD4Eyd6AesQoA
         YPxhmQZ6Z0hl7qSXyUrXuAJMkbEmbxm20DblZLcPDf+0EDhsQyWcaDW6IMRKDoFGO2CO
         nsrvYyiaA9hlsLsm4E2prLdIg3qa5ugYpval2N1uQLMCftxZQIo1GKlzNsL6O9jUpyLI
         suvA==
X-Gm-Message-State: APjAAAXSL4j8GO6YtyjBZ6aOF51QD5kiVBe15iI22GyR7Gp2CDsbpL7o
        YH+t+Hv0j5oxBij/knOv1R8iRK25fvg=
X-Google-Smtp-Source: APXvYqygwTb28qHcocSV061ljOkz9ZG+wJvgNdUa80UtzdWv/B8mTPZA5Ol/Kih7GJHYG1bvwuF/CA==
X-Received: by 2002:aa7:8219:: with SMTP id k25mr13441510pfi.38.1559340455223;
        Fri, 31 May 2019 15:07:35 -0700 (PDT)
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com ([2001:4898:80e8:8:18f0:3717:af81:1502])
        by smtp.gmail.com with ESMTPSA id l12sm5680104pgq.26.2019.05.31.15.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 15:07:34 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH] Add support to carry ima buffer to in kexec_file_load for amr64
Date:   Fri, 31 May 2019 15:07:23 -0700
Message-Id: <20190531220723.7368-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch re-uses the code written for powerpc to carry ima buffer
to the next kernel during kexec_file_load for arm64.
https://lore.kernel.org/patchwork/patch/740277/

changes added:
- add new entries in the arch_kimage to contain the memory
address of the kernel segment containing the ima buffer.
- set up the dtb accordingly to contain the address of the
ima buffer.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 arch/arm64/Kconfig                     |   7 +
 arch/arm64/include/asm/ima.h           |  31 ++++
 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/ima_kexec.c          | 217 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  39 +++++
 6 files changed, 299 insertions(+)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e34b9eba5de..586152608d09 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -940,6 +940,13 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
+config HAVE_IMA_KEXEC
+	bool "enable arch specific ima buffer pass"
+	depends on KEXEC_FILE
+	help
+		This adds support to carry ima log to the next kernel in case
+		of kexec_file_load
+
 config KEXEC_VERIFY_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
new file mode 100644
index 000000000000..2c504281028d
--- /dev/null
+++ b/arch/arm64/include/asm/ima.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_IMA_H
+#define _ASM_ARM64_IMA_H
+
+#define FDT_PROP_KEXEC_BUFFER	"linux,ima-kexec-buffer"
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
index 67e4cb75d1fd..2498dc3617a4 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -99,6 +99,8 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	void *dtb;
 	unsigned long dtb_mem;
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
 };
 
 extern const struct kexec_file_ops kexec_image_ops;
@@ -110,6 +112,8 @@ extern int load_other_segments(struct kimage *image,
 		unsigned long kernel_load_addr, unsigned long kernel_size,
 		char *initrd, unsigned long initrd_len,
 		char *cmdline);
+extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
+		unsigned long size);
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index cd434d0719c1..bc4d84266b29 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
+obj-$(CONFIG_HAVE_IMA_KEXEC)		+= ima_kexec.o
 
 obj-y					+= vdso/ probes/
 head-y					:= head.o
diff --git a/arch/arm64/kernel/ima_kexec.c b/arch/arm64/kernel/ima_kexec.c
new file mode 100644
index 000000000000..41d6721861c9
--- /dev/null
+++ b/arch/arm64/kernel/ima_kexec.c
@@ -0,0 +1,217 @@
+/*
+ * Copyright (C) 2016 IBM Corporation
+ *
+ * Authors:
+ * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/slab.h>
+#include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+#include <asm/kexec.h>
+#include <asm/ima.h>
+
+static int get_addr_size_cells(int *addr_cells, int *size_cells)
+{
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	*addr_cells = of_n_addr_cells(root);
+	*size_cells = of_n_size_cells(root);
+
+	of_node_put(root);
+
+	return 0;
+}
+
+static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			       size_t *size)
+{
+
+	int ret, addr_cells, size_cells;
+
+	ret = get_addr_size_cells(&addr_cells, &size_cells);
+	if (ret)
+		return ret;
+
+	if (len < 4 * (addr_cells + size_cells))
+		return -ENOENT;
+
+	*addr = of_read_number(prop, addr_cells);
+	*size = of_read_number(prop + 4 * addr_cells, size_cells);
+
+	return 0;
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
+	int ret, len;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+	const void *prop;
+
+	prop = of_get_property(of_chosen, FDT_PROP_KEXEC_BUFFER, &len);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
+	*addr = __va(tmp_addr);
+	*size = tmp_size;
+	return 0;
+}
+
+/**
+ * ima_free_kexec_buffer - free memory used by the IMA buffer
+ */
+int ima_free_kexec_buffer(void)
+{
+	int ret;
+	unsigned long addr;
+	size_t size;
+	struct property *prop;
+
+	prop = of_find_property(of_chosen, FDT_PROP_KEXEC_BUFFER, NULL);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop->value, prop->length, &addr, &size);
+	if (ret)
+		return ret;
+
+	ret = of_remove_property(of_chosen, prop);
+	if (ret)
+		return ret;
+
+	return memblock_free(addr, size);
+}
+
+/**
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
+ */
+void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	int ret, len;
+	unsigned long addr;
+	size_t size;
+	const void *prop;
+
+	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_KEXEC_BUFFER, &len);
+	if (!prop)
+		return;
+
+	ret = do_get_kexec_buffer(prop, len, &addr, &size);
+	fdt_delprop(fdt, chosen_node, FDT_PROP_KEXEC_BUFFER);
+	if (ret)
+		return;
+
+	ret = delete_fdt_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_debug("Removed old IMA buffer reservation.\n");
+}
+
+#ifdef CONFIG_IMA_KEXEC
+/**
+ * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
+ *
+ * Architectures should use this function to pass on the IMA buffer
+ * information to the next kernel.
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
+static int write_number(void *p, u64 value, int cells)
+{
+	if (cells == 1) {
+		u32 tmp;
+
+		if (value > U32_MAX)
+			return -EINVAL;
+
+		tmp = cpu_to_be32(value);
+		memcpy(p, &tmp, sizeof(tmp));
+	} else if (cells == 2) {
+		u64 tmp;
+
+		tmp = cpu_to_be64(value);
+		memcpy(p, &tmp, sizeof(tmp));
+	} else
+		return -EINVAL;
+	return 0;
+}
+
+/**
+ * setup_ima_buffer - add IMA buffer information to the fdt
+ * @image:		kexec image being loaded.
+ * @dtb:		Flattened device tree for the next kernel.
+ * @chosen_node:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int setup_ima_buffer(const struct kimage *image, void *dtb, int chosen_node)
+{
+	int ret, addr_cells, size_cells, entry_size;
+	u8 value[16];
+
+	remove_ima_buffer(dtb, chosen_node);
+
+	ret = get_addr_size_cells(&addr_cells, &size_cells);
+	if (ret)
+		return ret;
+
+	entry_size = 4 * (addr_cells + size_cells);
+
+	if (entry_size > sizeof(value))
+		return -EINVAL;
+
+	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
+	if (ret)
+		return ret;
+
+	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
+			size_cells);
+	if (ret)
+		return ret;
+
+	ret = fdt_setprop(dtb, chosen_node, FDT_PROP_KEXEC_BUFFER, value,
+			  entry_size);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = fdt_add_mem_rsv(dtb, image->segment[0].mem,
+			      image->segment[0].memsz);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 58871333737a..c05ad6b74b62 100644
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
 
+	/* add ima_buffer */
+	ret = setup_ima_buffer(image, dtb, off);
+	if (ret)
+		goto out;
+
 	/* add kaslr-seed */
 	ret = fdt_delprop(dtb, off, FDT_PROP_KASLR_SEED);
 	if  (ret == -FDT_ERR_NOTFOUND)
@@ -114,6 +120,39 @@ static int setup_dtb(struct kimage *image,
  */
 #define DTB_EXTRA_SPACE 0x1000
 
+
+/**
+ * delete_fdt_mem_rsv - delete memory reservation with given address and size
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
+			pr_err("Malformed device tree.\n");
+			return -EINVAL;
+		}
+
+		if (rsv_start == start && rsv_size == size) {
+			ret = fdt_del_mem_rsv(fdt, i);
+			if (ret) {
+				pr_err("Error deleting device tree reservation.\n");
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
 static int create_dtb(struct kimage *image,
 		      unsigned long initrd_load_addr, unsigned long initrd_len,
 		      char *cmdline, void **dtb)
-- 
2.17.1

