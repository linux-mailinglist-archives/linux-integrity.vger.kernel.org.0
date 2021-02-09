Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9BC31562A
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 19:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBISjv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 13:39:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58442 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbhBIS1l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:27:41 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 315AE20B57A2;
        Tue,  9 Feb 2021 10:22:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 315AE20B57A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612894952;
        bh=gAtuZsBcO2vXqFiI6uHmbmNO+jCXKZYLafO4CGNYZ8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNCsLI29Bgk+GW590E/SBoknj9Nt1Pgt3YriZ50tnmyndfbu295SSbQBFW8TW+/d2
         RlMGxwCjlj6ranFsa8tjATmsRMgMPxdrAZBwKiuMTBFh7nCKFFE5eKv425xI3Xzaac
         xoJGUbWjH3cEab1mf7AuSn8D71lAto177pH8QgPI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v17 05/10] powerpc: Move ima buffer fields to struct kimage
Date:   Tue,  9 Feb 2021 10:21:55 -0800
Message-Id: <20210209182200.30606-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209182200.30606-1-nramas@linux.microsoft.com>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The fields ima_buffer_addr and ima_buffer_size in "struct kimage_arch"
for powerpc are used to carry forward the IMA measurement list across
kexec system call.  These fields are not architecture specific, but are
currently limited to powerpc.

arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
sets ima_buffer_addr and ima_buffer_size for the kexec system call.
This function does not have architecture specific code, but is
currently limited to powerpc.

Move ima_buffer_addr and ima_buffer_size to "struct kimage".
Rename arch_ima_add_kexec_buffer() to of_ima_add_kexec_buffer()
and move it in drivers/of/kexec.c.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Will Deacon <will@kernel.org>
---
 arch/powerpc/include/asm/ima.h     |  3 ---
 arch/powerpc/include/asm/kexec.h   |  5 -----
 arch/powerpc/kexec/ima.c           | 29 ++++++-----------------------
 drivers/of/kexec.c                 | 23 +++++++++++++++++++++++
 include/linux/kexec.h              |  3 +++
 include/linux/of.h                 |  5 +++++
 security/integrity/ima/ima_kexec.c |  3 ++-
 7 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/ima.h b/arch/powerpc/include/asm/ima.h
index ead488cf3981..51f64fd06c19 100644
--- a/arch/powerpc/include/asm/ima.h
+++ b/arch/powerpc/include/asm/ima.h
@@ -14,9 +14,6 @@ static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
 #endif
 
 #ifdef CONFIG_IMA_KEXEC
-int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
-			      size_t size);
-
 int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
 #else
 static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index bdd0ddb9ac4d..ecf88533d6b4 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -112,11 +112,6 @@ struct kimage_arch {
 	unsigned long elf_headers_sz;
 	void *elf_headers;
 	void *fdt;
-
-#ifdef CONFIG_IMA_KEXEC
-	phys_addr_t ima_buffer_addr;
-	size_t ima_buffer_size;
-#endif
 };
 
 char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
diff --git a/arch/powerpc/kexec/ima.c b/arch/powerpc/kexec/ima.c
index 720e50e490b6..ed38125e2f87 100644
--- a/arch/powerpc/kexec/ima.c
+++ b/arch/powerpc/kexec/ima.c
@@ -128,23 +128,6 @@ void remove_ima_buffer(void *fdt, int chosen_node)
 }
 
 #ifdef CONFIG_IMA_KEXEC
-/**
- * arch_ima_add_kexec_buffer - do arch-specific steps to add the IMA buffer
- *
- * Architectures should use this function to pass on the IMA buffer
- * information to the next kernel.
- *
- * Return: 0 on success, negative errno on error.
- */
-int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
-			      size_t size)
-{
-	image->arch.ima_buffer_addr = load_addr;
-	image->arch.ima_buffer_size = size;
-
-	return 0;
-}
-
 static int write_number(void *p, u64 value, int cells)
 {
 	if (cells == 1) {
@@ -180,7 +163,7 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	u8 value[16];
 
 	remove_ima_buffer(fdt, chosen_node);
-	if (!image->arch.ima_buffer_size)
+	if (!image->ima_buffer_size)
 		return 0;
 
 	ret = get_addr_size_cells(&addr_cells, &size_cells);
@@ -192,11 +175,11 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (entry_size > sizeof(value))
 		return -EINVAL;
 
-	ret = write_number(value, image->arch.ima_buffer_addr, addr_cells);
+	ret = write_number(value, image->ima_buffer_addr, addr_cells);
 	if (ret)
 		return ret;
 
-	ret = write_number(value + 4 * addr_cells, image->arch.ima_buffer_size,
+	ret = write_number(value + 4 * addr_cells, image->ima_buffer_size,
 			   size_cells);
 	if (ret)
 		return ret;
@@ -206,13 +189,13 @@ int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node)
 	if (ret < 0)
 		return -EINVAL;
 
-	ret = fdt_add_mem_rsv(fdt, image->arch.ima_buffer_addr,
-			      image->arch.ima_buffer_size);
+	ret = fdt_add_mem_rsv(fdt, image->ima_buffer_addr,
+			      image->ima_buffer_size);
 	if (ret)
 		return -EINVAL;
 
 	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->arch.ima_buffer_addr, image->arch.ima_buffer_size);
+		 image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 469e09613cdd..9f33d215b9f2 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -63,6 +63,29 @@ static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned lon
 	return -ENOENT;
 }
 
+#ifdef CONFIG_IMA_KEXEC
+/**
+ * of_ima_add_kexec_buffer - Add IMA buffer for next kernel
+ *
+ * @image: kimage struct to set IMA buffer data
+ * @load_addr: Starting address where IMA buffer is loaded at
+ * @size: Number of bytes in the IMA buffer
+ *
+ * Use this function to pass on the IMA buffer information to
+ * the next kernel across kexec system call.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int of_ima_add_kexec_buffer(struct kimage *image,
+			    unsigned long load_addr, size_t size)
+{
+	image->ima_buffer_addr = load_addr;
+	image->ima_buffer_size = size;
+
+	return 0;
+}
+#endif /* CONFIG_IMA_KEXEC */
+
 /*
  * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5f61389f5f36..75c670f0dfbb 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -304,6 +304,9 @@ struct kimage {
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
+
+	phys_addr_t ima_buffer_addr;
+	size_t ima_buffer_size;
 #endif
 };
 
diff --git a/include/linux/of.h b/include/linux/of.h
index f0eff5e84353..03e0e694be29 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -573,6 +573,11 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   unsigned long initrd_len,
 				   const char *cmdline);
 
+#ifdef CONFIG_IMA_KEXEC
+int of_ima_add_kexec_buffer(struct kimage *image,
+			    unsigned long load_addr, size_t size);
+#endif /* CONFIG_IMA_KEXEC */
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index e29bea3dd4cc..d346eed2d236 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -10,6 +10,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmalloc.h>
 #include <linux/kexec.h>
+#include <linux/of.h>
 #include "ima.h"
 
 #ifdef CONFIG_IMA_KEXEC
@@ -123,7 +124,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 		return;
 	}
 
-	ret = arch_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
+	ret = of_ima_add_kexec_buffer(image, kbuf.mem, kexec_segment_size);
 	if (ret) {
 		pr_err("Error passing over kexec measurement buffer.\n");
 		return;
-- 
2.30.0

