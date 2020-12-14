Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161582DA058
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408942AbgLNTUB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 14:20:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58234 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408929AbgLNTTv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 14:19:51 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 509A320B7189;
        Mon, 14 Dec 2020 11:19:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 509A320B7189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607973549;
        bh=lphu/vm9i7VLmKiaUZKTiiSUvsoMdJYInCi5dzGvGNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZGcvUWABJyu3RvIzTwY4lxkWndLjViVpEN/FyxyrAvX491ZhXtZbicgGRPFRkbcK
         OI8d/6QkITwfq5WNUed9Cl4XxAuJahH6FzptOdr9MYfzOE3gI0g+87nFwbr/spHTa0
         nAhdt0l161K+asP/5SYxuF1NxCS0mACiU/d/n3KU=
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v11 4/8] powerpc: Move remove_ima_buffer() to drivers/of/kexec.c
Date:   Mon, 14 Dec 2020 11:18:50 -0800
Message-Id: <20201214191854.9050-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191854.9050-1-nramas@linux.microsoft.com>
References: <20201214191854.9050-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

remove_ima_buffer() removes the chosen node "linux,ima-kexec-buffer"
from the device tree and frees the memory reserved for carrying forward
the IMA measurement logs on kexec. This function does not have
architecture specific code, but is currently limited to powerpc.

When CONFIG_IMA isn't set, remove_ima_buffer() is a NOP. Therefore,
kexec_file_load() will not remove the IMA kexec buffer when creating
the FDT for the next kernel.

Define remove_ima_buffer() when CONFIG_KEXEC_FILE is enabled.
kexec_file_load() will then remove the IMA kexec buffer when creating
the FDT for the next kernel.

Move remove_ima_buffer() to "drivers/of/kexec.c" so that it is
accessible for other architectures as well.

With this change the function delete_fdt_mem_rsv() defined
in arch/powerpc/kexec/file_load.c is no longer used. Remove
delete_fdt_mem_rsv().

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/ima.h   |  8 +-------
 arch/powerpc/include/asm/kexec.h |  1 -
 arch/powerpc/kexec/file_load.c   | 32 --------------------------------
 arch/powerpc/kexec/ima.c         | 26 --------------------------
 drivers/of/kexec.c               | 26 ++++++++++++++++++++++++++
 include/linux/of.h               |  2 +-
 6 files changed, 28 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..fbc0c866b6bc 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -2,17 +2,11 @@
 #ifndef _ASM_POWERPC_IMA_H
 #define _ASM_POWERPC_IMA_H
 
-struct kimage;
+#include <linux/of.h>
 
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
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index dbf09d2f36d0..d4b7d2d6191d 100644
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
index 956bcb2d1ec2..a116f1eb35b5 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -110,38 +110,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
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
index 906e8212435d..68017123b07d 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -61,32 +61,6 @@ int ima_free_kexec_buffer(void)
 	return memblock_free(addr, size);
 }
 
-/**
- * remove_ima_buffer - remove the IMA buffer property and reservation from @fdt
- *
- * @fdt: Flattened Device Tree to update
- * @chosen_node: Offset to the chosen node in the device tree
- *
- * The IMA measurement buffer is of no use to a subsequent kernel, so we always
- * remove it from the device tree.
- */
-void remove_ima_buffer(void *fdt, int chosen_node)
-{
-	int ret;
-	unsigned long addr;
-	size_t size;
-
-	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
-	if (ret)
-		return;
-
-	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
-
-	ret = delete_fdt_mem_rsv(fdt, addr, size);
-	if (!ret)
-		pr_debug("Removed old IMA buffer reservation.\n");
-}
-
 #ifdef CONFIG_IMA_KEXEC
 /**
  * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 9af5371340b1..5939483d3114 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -294,3 +294,29 @@ int get_ima_kexec_buffer(void *fdt, int chosen_node,
 
 	return 0;
 }
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
+void remove_ima_buffer(void *fdt, int chosen_node)
+{
+	int ret;
+	unsigned long addr;
+	size_t size;
+
+	ret = get_ima_kexec_buffer(fdt, chosen_node, &addr, &size);
+	if (ret)
+		return;
+
+	fdt_delprop(fdt, chosen_node, "linux,ima-kexec-buffer");
+
+	ret = fdt_find_and_del_mem_rsv(fdt, addr, size);
+	if (!ret)
+		pr_debug("Removed old IMA buffer reservation.\n");
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index fb2ef274135d..67c1298746dd 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -565,7 +565,7 @@ int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
 int get_root_addr_size_cells(int *addr_cells, int *size_cells);
 int get_ima_kexec_buffer(void *fdt, int chosen_node,
 			 unsigned long *addr, size_t *size);
-
+void remove_ima_buffer(void *fdt, int chosen_node);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
-- 
2.29.2

