Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E31262371
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Sep 2020 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgIHXJd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 19:09:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43098 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgIHXJK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 19:09:10 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 21FAC2094290;
        Tue,  8 Sep 2020 16:09:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21FAC2094290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599606547;
        bh=pnT6g5VzPf9z9jiXgQj+GJSAYuYEt8ZiYUzjrtrBpdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q60OJoT0v1cpwLycu2NkuUbJ0QEu0doTCmBlTIqMcimWmXWQpIOLQQWaBemn7ScWO
         DTar6yv8LITMY9RQLRvRpGJh3TDw9YR4Jv9l8X73z0D64g5X88nW9spJ9bAr8oByUF
         K/6f0g61QFihCON9LJJNLjEXfdJd77bEqFZZM8W0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [PATCH v6 1/3] powerpc: Refactor kexec functions to move arch independent code to IMA
Date:   Tue,  8 Sep 2020 16:08:54 -0700
Message-Id: <20200908230856.9799-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908230856.9799-1-nramas@linux.microsoft.com>
References: <20200908230856.9799-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The functions ima_get_kexec_buffer(), ima_free_kexec_buffer(),
remove_ima_buffer(), and delete_fdt_mem_rsv() that handle carrying
forward the IMA measurement logs on kexec for powerpc do not have
architecture specific code, but they are currently defined for
powerpc only.

Move these functions to IMA subsystem so that it can be used for other
architectures as well. A later patch in this series will use these
functions for carrying forward the IMA measurement log for ARM64.
Rename remove_ima_buffer() to ima_remove_kexec_buffer().

Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
"linux,ima-kexec-buffer", that is added to the DTB to hold
the address and the size of the memory reserved to carry
the IMA measurement log.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h          |  11 +--
 arch/powerpc/include/asm/kexec.h        |   1 -
 arch/powerpc/kexec/file_load.c          |  33 +-------
 arch/powerpc/kexec/ima.c                | 104 +-----------------------
 include/linux/ima.h                     |   2 +
 include/linux/kexec.h                   |  11 +++
 include/linux/libfdt.h                  |   3 +
 security/integrity/ima/Makefile         |   3 +-
 security/integrity/ima/ima.h            |   2 +
 security/integrity/ima/ima_fdt.c        |  80 ++++++++++++++++++
 security/integrity/ima/ima_kexec.c      |  58 +++++++++++++
 security/integrity/ima/ima_kexec_file.c |  51 ++++++++++++
 12 files changed, 214 insertions(+), 145 deletions(-)
 create mode 100644 security/integrity/ima/ima_fdt.c
 create mode 100644 security/integrity/ima/ima_kexec_file.c

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..188146ecbfaf 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -4,15 +4,6 @@
 
 struct kimage;
 
-int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
-
-#ifdef CONFIG_IMA
-void remove_ima_buffer(void *fdt, int chosen_node);
-#else
-static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
-#endif
-
 #ifdef CONFIG_IMA_KEXEC
 int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
 			      size_t size);
@@ -22,7 +13,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
 static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 				   int chosen_node)
 {
-	remove_ima_buffer(fdt, chosen_node);
+	ima_remove_kexec_buffer(fdt, chosen_node);
 	return 0;
 }
 #endif /* CONFIG_IMA_KEXEC */
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 55d6ede30c19..7c223031ecdd 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -126,7 +126,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 int setup_new_fdt(const struct kimage *image, void *fdt,
 		  unsigned long initrd_load_addr, unsigned long initrd_len,
 		  const char *cmdline);
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 
 #ifdef CONFIG_PPC64
 struct kexec_buf;
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index 9a232bc36c8f..7a17655c530e 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -18,6 +18,7 @@
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/kexec.h>
 #include <asm/setup.h>
 #include <asm/ima.h>
 
@@ -109,38 +110,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 	return 0;
 }
 
-/**
- * delete_fdt_mem_rsv - delete memory reservation with given address and size
- *
- * Return: 0 on success, or negative errno on error.
- */
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size)
-{
-	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
-
-	for (i = 0; i < num_rsvs; i++) {
-		uint64_t rsv_start, rsv_size;
-
-		ret = fdt_get_mem_rsv(fdt, i, &rsv_start, &rsv_size);
-		if (ret) {
-			pr_err("Malformed device tree.\n");
-			return -EINVAL;
-		}
-
-		if (rsv_start == start && rsv_size == size) {
-			ret = fdt_del_mem_rsv(fdt, i);
-			if (ret) {
-				pr_err("Error deleting device tree reservation.\n");
-				return -EINVAL;
-			}
-
-			return 0;
-		}
-	}
-
-	return -ENOENT;
-}
-
 /*
  * setup_new_fdt - modify /chosen and memory reservation for the next kernel
  * @image:		kexec image being loaded.
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 720e50e490b6..467647886064 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/kexec.h>
 #include <linux/of.h>
+#include <linux/ima.h>
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
 
@@ -28,105 +29,6 @@ static int get_addr_size_cells(int *addr_cells, int *size_cells)
 	return 0;
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
 #ifdef CONFIG_IMA_KEXEC
 /**
  * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
@@ -179,7 +81,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	int ret, addr_cells, size_cells, entry_size;
 	u8 value[16];
 
-	remove_ima_buffer(fdt, chosen_node);
+	ima_remove_kexec_buffer(fdt, chosen_node);
 	if (!image->arch.ima_buffer_size)
 		return 0;
 
@@ -201,7 +103,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (ret)
 		return ret;
 
-	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
+	ret = fdt_setprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, value,
 			  entry_size);
 	if (ret < 0)
 		return -EINVAL;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index d15100de6cdd..e8e0afdfe783 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,6 +26,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
+extern void ima_remove_kexec_buffer(void *fdt, int chosen_node);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -104,6 +105,7 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
+static inline void ima_remove_kexec_buffer(void *fdt, int chosen_node) {}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..00a60dcc7075 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -223,8 +223,19 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mend);
 extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 				       void **addr, unsigned long *sz);
+
+extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
+			      unsigned long size);
 #endif /* CONFIG_KEXEC_FILE */
 
+#ifndef CONFIG_KEXEC_FILE
+static inline int delete_fdt_mem_rsv(void *fdt, unsigned long start,
+				     unsigned long size)
+{
+	return 0;
+}
+#endif /* ifndef CONFIG_KEXEC_FILE */
+
 #ifdef CONFIG_KEXEC_ELF
 struct kexec_elf_info {
 	/*
diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
index 90ed4ebfa692..75fb40aa013b 100644
--- a/include/linux/libfdt.h
+++ b/include/linux/libfdt.h
@@ -5,4 +5,7 @@
 #include <linux/libfdt_env.h>
 #include "../../scripts/dtc/libfdt/libfdt.h"
 
+/* Common device tree properties */
+#define FDT_PROP_IMA_KEXEC_BUFFER	"linux,ima-kexec-buffer"
+
 #endif /* _INCLUDE_LIBFDT_H_ */
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca670e2..05719fd28aec 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -7,10 +7,11 @@
 obj-$(CONFIG_IMA) += ima.o
 
 ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
-	 ima_policy.o ima_template.o ima_template_lib.o
+	 ima_policy.o ima_template.o ima_template_lib.o ima_fdt.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_KEXEC_FILE) += ima_kexec_file.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 38043074ce5e..0d2bfe53be69 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -167,6 +167,8 @@ void ima_init_template_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
+int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			size_t *size);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_fdt.c b/security/integrity/ima/ima_fdt.c
new file mode 100644
index 000000000000..8c4cb580b772
--- /dev/null
+++ b/security/integrity/ima/ima_fdt.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * ima_fdt.c
+ *	Implements functions to handle IMA buffer in device tree
+ */
+
+#include <linux/libfdt.h>
+#include <linux/kexec.h>
+#include <linux/ima.h>
+#include "ima.h"
+
+/**
+ * do_get_kexec_buffer - Get address and size of IMA kexec buffer
+ *
+ * @prop: IMA kexec buffer node in the device tree
+ * @addr: Return address of the node
+ * @size: Return size of the node
+ */
+int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			size_t *size)
+{
+	int addr_cells, size_cells;
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	addr_cells = of_n_addr_cells(root);
+	size_cells = of_n_size_cells(root);
+
+	of_node_put(root);
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
+ * ima_remove_kexec_buffer - remove the IMA buffer property and
+ *			     reservation from @fdt
+ *
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel,
+ * so we always remove it from the device tree.
+ */
+void ima_remove_kexec_buffer(void *fdt, int chosen_node)
+{
+	int ret, len;
+	unsigned long addr;
+	size_t size;
+	const void *prop;
+
+	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, &len);
+	if (!prop) {
+		pr_err("Unable to find the ima kexec buffer node\n");
+		return;
+	}
+
+	ret = do_get_kexec_buffer(prop, len, &addr, &size);
+	fdt_delprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER);
+	if (ret) {
+		pr_err("Unable to delete the ima kexec buffer node\n");
+		return;
+	}
+
+	ret = delete_fdt_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_err("Removed old IMA buffer reservation.\n");
+}
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..ed70f99aeedc 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,8 +10,66 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/of.h>
+#include <linux/memblock.h>
+#include <linux/libfdt.h>
+#include <linux/ima.h>
 #include "ima.h"
 
+/**
+ * ima_get_kexec_buffer - get IMA buffer from the previous kernel
+ * @addr:	On successful return, set to point to the buffer contents.
+ * @size:	On successful return, set to the buffer size.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ima_get_kexec_buffer(void **addr, size_t *size)
+{
+	int ret, len;
+	unsigned long tmp_addr;
+	size_t tmp_size;
+	const void *prop;
+
+	prop = of_get_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, &len);
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
+static int ima_free_kexec_buffer(void)
+{
+	int ret;
+	unsigned long addr;
+	size_t size;
+	struct property *prop;
+
+	prop = of_find_property(of_chosen, FDT_PROP_IMA_KEXEC_BUFFER, NULL);
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
 #ifdef CONFIG_IMA_KEXEC
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
diff --git a/security/integrity/ima/ima_kexec_file.c b/security/integrity/ima/ima_kexec_file.c
new file mode 100644
index 000000000000..225e913e6ef2
--- /dev/null
+++ b/security/integrity/ima/ima_kexec_file.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * ima_kexec_file.c
+ *	Implements functions to handle device tree operations
+ */
+
+#include <linux/libfdt.h>
+#include <linux/kexec.h>
+#include <linux/types.h>
+
+/**
+ * delete_fdt_mem_rsv - delete memory reservation with given address and size
+ *
+ * @fdt: Flattened Device Tree to update
+ * @start: Starting address of the property to update
+ * @size: Size of the buffer corresponding to the given property
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
+			pr_err("Freed the reserved memory at %lu of size %lu\n",
+				start, size);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
-- 
2.28.0

