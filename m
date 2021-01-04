Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672D92E9E1B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jan 2021 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbhADT06 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 14:26:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36532 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhADT0z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 14:26:55 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1536420B6C41;
        Mon,  4 Jan 2021 11:26:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1536420B6C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609788372;
        bh=Z6Cm2+YAwgzWCFuLj1tB/Nt5T4HXk25Xxu4vYbH79u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJlIfbrj7SX6iU6cqTxU/jPeWVGPqVoOU0t5taIHHeCsORtctCr4q3EVYJM1m70ZU
         0FdAuOixG9EiRFynoaWOBTF1LXI/bw2FKrB61BQLHK+cp+Ewpq0BUHgfJulc1k2zjT
         y7cgLV8ifpRkJR9o9OUwmqjHwrBR/xkG0LZZQvgw=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
Subject: [PATCH v14 2/6] powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c
Date:   Mon,  4 Jan 2021 11:25:58 -0800
Message-Id: <20210104192602.10131-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104192602.10131-1-nramas@linux.microsoft.com>
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The functions defined in "arch/powerpc/kexec/ima.c" handle setting up
and freeing the resources required to carry over the IMA measurement
list from the current kernel to the next kernel across kexec system call.
These functions do not have architecture specific code, but are
currently limited to powerpc.

Move setup_ima_buffer() call into of_kexec_setup_new_fdt() defined in
"drivers/of/kexec.c".

Move the remaining architecture independent functions from
"arch/powerpc/kexec/ima.c" to "drivers/of/kexec.c".
Delete "arch/powerpc/kexec/ima.c" and "arch/powerpc/include/asm/ima.h".
Remove references to the deleted files in powerpc and in ima.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/Kconfig               |   2 +-
 arch/powerpc/include/asm/ima.h     |  27 ----
 arch/powerpc/kexec/Makefile        |   7 -
 arch/powerpc/kexec/file_load.c     |   7 -
 arch/powerpc/kexec/ima.c           | 202 ------------------------
 drivers/of/kexec.c                 | 240 +++++++++++++++++++++++++++++
 include/linux/of.h                 |   2 +
 security/integrity/ima/ima.h       |   4 -
 security/integrity/ima/ima_kexec.c |   1 +
 9 files changed, 244 insertions(+), 248 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/ima.h
 delete mode 100644 arch/powerpc/kexec/ima.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5181872f9452..7fce3034e44a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -549,7 +549,7 @@ config KEXEC
 config KEXEC_FILE
 	bool "kexec file based system call"
 	select KEXEC_CORE
-	select HAVE_IMA_KEXEC
+	select HAVE_IMA_KEXEC if IMA
 	select BUILD_BIN2C
 	select KEXEC_ELF
 	depends on PPC64
diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
deleted file mode 100644
index 51f64fd06c19..000000000000
--- a/arch/powerpc/include/asm/ima.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_IMA_H
-#define _ASM_POWERPC_IMA_H
-
-struct kimage;
-
-int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
-
-#ifdef CONFIG_IMA
-void remove_ima_buffer(void *fdt, int chosen_node);
-#else
-static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
-#endif
-
-#ifdef CONFIG_IMA_KEXEC
-int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
-#else
-static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
-				   int chosen_node)
-{
-	remove_ima_buffer(fdt, chosen_node);
-	return 0;
-}
-#endif /* CONFIG_IMA_KEXEC */
-
-#endif /* _ASM_POWERPC_IMA_H */
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 4aff6846c772..b6c52608cb49 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -9,13 +9,6 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
 
 obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
 
-ifdef CONFIG_HAVE_IMA_KEXEC
-ifdef CONFIG_IMA
-obj-y				+= ima.o
-endif
-endif
-
-
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_core_$(BITS).o := n
 KCOV_INSTRUMENT_core_$(BITS).o := n
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index 956bcb2d1ec2..9f3ec0b239ef 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -20,7 +20,6 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <asm/setup.h>
-#include <asm/ima.h>
 
 #define SLAVE_CODE_SIZE		256	/* First 0x100 bytes */
 
@@ -163,12 +162,6 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
 	if (ret)
 		goto err;
 
-	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
-	if (ret) {
-		pr_err("Error setting up the new device tree.\n");
-		return ret;
-	}
-
 	return 0;
 
 err:
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
deleted file mode 100644
index 7378d59c0c1e..000000000000
--- a/arch/powerpc/kexec/ima.c
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2016 IBM Corporation
- *
- * Authors:
- * Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
- */
-
-#include <linux/slab.h>
-#include <linux/kexec.h>
-#include <linux/of.h>
-#include <linux/memblock.h>
-#include <linux/libfdt.h>
-
-static int get_addr_size_cells(int *addr_cells, int *size_cells)
-{
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
-}
-
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
-
-/**
- * ima_get_kexec_buffer - get IMA buffer from the previous kernel
- * @addr:	On successful return, set to point to the buffer contents.
- * @size:	On successful return, set to the buffer size.
- *
- * Return: 0 on success, negative errno on error.
- */
-int ima_get_kexec_buffer(void **addr, size_t *size)
-{
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
-}
-
-/**
- * ima_free_kexec_buffer - free memory used by the IMA buffer
- */
-int ima_free_kexec_buffer(void)
-{
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
-}
-
-#ifdef CONFIG_IMA_KEXEC
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
-/**
- * setup_ima_buffer - add IMA buffer information to the fdt
- * @image:		kexec image being loaded.
- * @fdt:		Flattened device tree for the next kernel.
- * @chosen_node:	Offset to the chosen node.
- *
- * Return: 0 on success, or negative errno on error.
- */
-int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
-{
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
-}
-#endif /* CONFIG_IMA_KEXEC */
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 66787be081fe..9b1650b5c036 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/memblock.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -59,6 +60,240 @@ static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned lon
 	return -ENOENT;
 }
 
+/**
+ * get_addr_size_cells - Get address and size of root node
+ *
+ * @addr_cells: Return address of the root node
+ * @size_cells: Return size of the root node
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
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
+/**
+ * do_get_kexec_buffer - Get address and size of device tree property
+ *
+ * @prop: Device tree property
+ * @len: Size of @prop
+ * @addr: Return address of the node
+ * @size: Return size of the node
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			       size_t *size)
+{
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
+ * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
+ *
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel, so we always
+ * remove it from the device tree.
+ */
+static void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	int ret, len;
+	unsigned long addr;
+	size_t size;
+	const void *prop;
+
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return;
+
+	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
+	if (!prop)
+		return;
+
+	ret = do_get_kexec_buffer(prop, len, &addr, &size);
+	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+	if (ret)
+		return;
+
+	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_debug("Removed old IMA buffer reservation.\n");
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
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -ENOTSUPP;
+
+	prop = of_get_property(of_chosen, "linux,ima-kexec-buffer", &len);
+	if (!prop)
+		return -ENOENT;
+
+	ret = do_get_kexec_buffer(prop, len, &tmp_addr, &tmp_size);
+	if (ret)
+		return ret;
+
+	*addr = __va(tmp_addr);
+	*size = tmp_size;
+
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
+	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
+		return -ENOTSUPP;
+
+	prop = of_find_property(of_chosen, "linux,ima-kexec-buffer", NULL);
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
+
+}
+
+#ifdef CONFIG_IMA_KEXEC
+/**
+ * write_number - Convert number to big-endian format
+ *
+ * @p:		Buffer to write the number to
+ * @value:	Number to convert
+ * @cells:	Number of cells
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
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
+
+	return 0;
+}
+
+/**
+ * setup_ima_buffer - add IMA buffer information to the fdt
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @chosen_node:	Offset to the chosen node.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int setup_ima_buffer(const struct kimage *image, void *fdt,
+			    int chosen_node)
+{
+	int ret, addr_cells, size_cells, entry_size;
+	u8 value[16];
+
+	if (!image->arch.ima_buffer_size)
+		return 0;
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
+			   size_cells);
+	if (ret)
+		return ret;
+
+	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
+			  entry_size);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
+			      image->arch.ima_buffer_size);
+	if (ret)
+		return -EINVAL;
+
+	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
+		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
+
+	return 0;
+}
+#else /* CONFIG_IMA_KEXEC */
+static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
+				   int chosen_node)
+{
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
+
 /*
  * of_kexec_setup_new_fdt - modify /chosen and memory reservation for the next kernel
  *
@@ -219,6 +454,11 @@ int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
 	}
 
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
+	if (ret)
+		goto out;
+
+	remove_ima_buffer(fdt, chosen_node);
+	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
 
 out:
 	if (ret)
diff --git a/include/linux/of.h b/include/linux/of.h
index 3375f5295875..48eb2d05c0ec 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -562,6 +562,8 @@ struct kimage;
 int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
 			   unsigned long initrd_load_addr, unsigned long initrd_len,
 			   const char *cmdline);
+int ima_get_kexec_buffer(void **addr, size_t *size);
+int ima_free_kexec_buffer(void);
 
 #else /* CONFIG_OF */
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6ebefec616e4..7c3947ad3773 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -24,10 +24,6 @@
 
 #include "../integrity.h"
 
-#ifdef CONFIG_HAVE_IMA_KEXEC
-#include <asm/ima.h>
-#endif
-
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
 enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 95513c97ce8f..c62bbb586d2e 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,6 +10,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/of.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
-- 
2.29.2

