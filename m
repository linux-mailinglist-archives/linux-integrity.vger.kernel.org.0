Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6DA27F3C9
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 23:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgI3VAI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 17:00:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52774 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgI3U7w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 16:59:52 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 099A720B7179;
        Wed, 30 Sep 2020 13:59:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 099A720B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601499591;
        bh=QBwJqaYuIZtLtX/Q0PhWwhcIVCseaX6SEIoVGjcpj1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEzoFIQ73ZN687QzFN5nLLPU4LyHBe1H0+Am/YdRsgXulb10emgbUT2348K9cUI+7
         WvMreMKuXzp1hBtW9Jgh4cpFwFu0jf15h9MWad29O9e///o/ttAJRNVn+XhMY0vSnv
         5slLPxBFtrsvVdbRW37pI+vLkVj6nthJymOuEDNc=
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
Subject: [PATCH v7 1/4] powerpc: Refactor kexec functions to move arch independent code to kernel
Date:   Wed, 30 Sep 2020 13:59:38 -0700
Message-Id: <20200930205941.1576-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930205941.1576-1-nramas@linux.microsoft.com>
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
carrying forward the IMA measurement logs on kexec for powerpc do not
have architecture specific code, but they are currently defined for
powerpc only.

remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
the IMA log entry from the device tree and free the memory reserved
for the log. These functions need to be defined even if the current
kernel does not support carrying forward IMA log across kexec since
the previous kernel could have supported that and therefore the current
kernel needs to free the allocation.

Rename remove_ima_buffer() to remove_ima_kexec_buffer().
Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in kernel.
A later patch in this series will use these functions to free
the allocation, if any, made by the previous kernel for ARM64.

Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
"linux,ima-kexec-buffer", that is added to the DTB to hold
the address and the size of the memory reserved to carry
the IMA measurement log.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reported-by: kernel test robot <lkp@intel.com> error: implicit declaration of function 'delete_fdt_mem_rsv' [-Werror,-Wimplicit-function-declaration]
---
 arch/powerpc/include/asm/ima.h   | 10 ++--
 arch/powerpc/include/asm/kexec.h |  1 -
 arch/powerpc/kexec/file_load.c   | 33 +------------
 arch/powerpc/kexec/ima.c         | 55 +++------------------
 include/linux/kexec.h            | 24 +++++++++
 include/linux/libfdt.h           |  3 ++
 kernel/Makefile                  |  3 +-
 kernel/ima_kexec.c               | 85 ++++++++++++++++++++++++++++++++
 kernel/kexec_file_fdt.c          | 55 +++++++++++++++++++++
 9 files changed, 181 insertions(+), 88 deletions(-)
 create mode 100644 kernel/ima_kexec.c
 create mode 100644 kernel/kexec_file_fdt.c

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..6355a85a3289 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -2,17 +2,13 @@
 #ifndef _ASM_POWERPC_IMA_H
 #define _ASM_POWERPC_IMA_H
 
+#include <linux/kexec.h>
+
 struct kimage;
 
 int ima_get_kexec_buffer(void **addr, size_t *size);
 int ima_free_kexec_buffer(void);
 
-#ifdef CONFIG_IMA
-void remove_ima_buffer(void *fdt, int chosen_node);
-#else
-static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
-#endif
-
 #ifdef CONFIG_IMA_KEXEC
 int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
 			      size_t size);
@@ -22,7 +18,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
 static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 				   int chosen_node)
 {
-	remove_ima_buffer(fdt, chosen_node);
+	remove_ima_kexec_buffer(fdt, chosen_node);
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
index 720e50e490b6..2b790230ea15 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -11,6 +11,8 @@
 #include <linux/of.h>
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
+#include <linux/ima.h>
+#include <asm/ima.h>
 
 static int get_addr_size_cells(int *addr_cells, int *size_cells)
 {
@@ -28,24 +30,6 @@ static int get_addr_size_cells(int *addr_cells, int *size_cells)
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
 /**
  * ima_get_kexec_buffer - get IMA buffer from the previous kernel
  * @addr:	On successful return, set to point to the buffer contents.
@@ -100,37 +84,14 @@ int ima_free_kexec_buffer(void)
 
 }
 
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
  *
+ * @image: kimage struct to set IMA buffer data
+ * @load_addr: Starting address where IMA buffer is loaded at
+ * @size: Number of bytes in the IMA buffer
+ *
  * Architectures should use this function to pass on the IMA buffer
  * information to the next kernel.
  *
@@ -179,7 +140,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	int ret, addr_cells, size_cells, entry_size;
 	u8 value[16];
 
-	remove_ima_buffer(fdt, chosen_node);
+	remove_ima_kexec_buffer(fdt, chosen_node);
 	if (!image->arch.ima_buffer_size)
 		return 0;
 
@@ -201,7 +162,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (ret)
 		return ret;
 
-	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
+	ret = fdt_setprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, value,
 			  entry_size);
 	if (ret < 0)
 		return -EINVAL;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..39a931df6ae4 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -407,6 +407,30 @@ static inline int kexec_crash_loaded(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_HAVE_IMA_KEXEC
+extern void remove_ima_kexec_buffer(void *fdt, int chosen_node);
+extern int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
+			       size_t *size);
+#else
+static inline void remove_ima_kexec_buffer(void *fdt, int chosen_node) {}
+static inline int do_get_kexec_buffer(const void *prop, int len,
+				      unsigned long *addr, size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_HAVE_IMA_KEXEC */
+
+#ifdef CONFIG_KEXEC_FILE
+extern int delete_fdt_mem_rsv(void *fdt, unsigned long start,
+			      unsigned long size);
+#else
+static inline int delete_fdt_mem_rsv(void *fdt, unsigned long start,
+				     unsigned long size)
+{
+	return 0;
+}
+#endif /* CONFIG_KEXEC_FILE */
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
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
diff --git a/kernel/Makefile b/kernel/Makefile
index 9a20016d4900..f20bb423291a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -71,8 +71,9 @@ obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
-obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
+obj-$(CONFIG_KEXEC_FILE) += kexec_file.o kexec_file_fdt.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/ima_kexec.c b/kernel/ima_kexec.c
new file mode 100644
index 000000000000..6fb6e4b862aa
--- /dev/null
+++ b/kernel/ima_kexec.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * ima_kexec.c
+ *	Handle IMA buffer for kexec
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/printk.h>
+#include <linux/libfdt.h>
+#include <linux/of.h>
+#include <linux/kexec.h>
+
+/**
+ * do_get_kexec_buffer - Get address and size of IMA kexec buffer
+ *
+ * @prop: IMA kexec buffer node in the device tree
+ * @len: Size of the given device tree node property
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
+ * remove_ima_kexec_buffer - remove the IMA buffer property and
+ *			     reservation from @fdt
+ *
+ * @fdt: Flattened Device Tree to update
+ * @chosen_node: Offset to the chosen node in the device tree
+ *
+ * The IMA measurement buffer is of no use to a subsequent kernel,
+ * so we always remove it from the device tree.
+ */
+void remove_ima_kexec_buffer(void *fdt, int chosen_node)
+{
+	int ret, len;
+	unsigned long addr;
+	size_t size;
+	const void *prop;
+
+	prop = fdt_getprop(fdt, chosen_node, FDT_PROP_IMA_KEXEC_BUFFER, &len);
+	if (!prop) {
+		pr_debug("Unable to find the ima kexec buffer node\n");
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
+		pr_debug("Removed old IMA buffer reservation.\n");
+}
diff --git a/kernel/kexec_file_fdt.c b/kernel/kexec_file_fdt.c
new file mode 100644
index 000000000000..726e43254892
--- /dev/null
+++ b/kernel/kexec_file_fdt.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Lakshmi Ramasubramanian (nramas@linux.microsoft.com)
+ *
+ * kexec_file_fdt.c
+ *	Handle memory reservation in device tree.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/printk.h>
+#include <linux/libfdt.h>
+#include <linux/kexec.h>
+
+/**
+ * delete_fdt_mem_rsv - delete memory reservation with given address and size
+ *
+ * @fdt: Flattened Device Tree to update
+ * @start: Starting address of the reservation to delete
+ * @size: Size of the reservation to delete
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
+			pr_debug("Freed reserved memory at %lu of size %lu\n",
+				 start, size);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
-- 
2.28.0

