Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DAB3155E8
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhBIS1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 13:27:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57818 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhBISXQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:23:16 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B3E020B57A1;
        Tue,  9 Feb 2021 10:22:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B3E020B57A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612894952;
        bh=yVOu+W9Ef2mF4o+uSPjE6GG6o7AdGKWk/90O+6j2zlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spwuPa/gWbjaK5M3ZWk04am4JWFmGG96JxtX/nT9ncTN7aya+72SDVYXfYekzanDe
         b1tUhkmrU/leJpNZNM4GuXWOiQifEImKUMaQK6mQ/49UNHD+rinQnMb/ClY6RuG46O
         gYpRriOdpqa1DLYy3IPdnBCmTDwstfWC/GBRhBII=
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
Subject: [PATCH v17 04/10] powerpc: Use common of_kexec_alloc_and_setup_fdt()
Date:   Tue,  9 Feb 2021 10:21:54 -0800
Message-Id: <20210209182200.30606-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209182200.30606-1-nramas@linux.microsoft.com>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Rob Herring <robh@kernel.org>

The code for setting up the /chosen node in the device tree
and updating the memory reservation for the next kernel has been
moved to of_kexec_alloc_and_setup_fdt() defined in "drivers/of/kexec.c".

Use the common of_kexec_alloc_and_setup_fdt() to setup the device tree
and update the memory reservation for kexec for powerpc.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/kexec.h  |   1 +
 arch/powerpc/kexec/elf_64.c       |  29 ++++---
 arch/powerpc/kexec/file_load.c    | 132 +-----------------------------
 arch/powerpc/kexec/file_load_64.c |   3 +
 4 files changed, 25 insertions(+), 140 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index dbf09d2f36d0..bdd0ddb9ac4d 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -111,6 +111,7 @@ struct kimage_arch {
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
 	void *elf_headers;
+	void *fdt;
 
 #ifdef CONFIG_IMA_KEXEC
 	phys_addr_t ima_buffer_addr;
diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index d0e459bb2f05..bfabd06f99b1 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -29,7 +30,6 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 			unsigned long cmdline_len)
 {
 	int ret;
-	unsigned int fdt_size;
 	unsigned long kernel_load_addr;
 	unsigned long initrd_load_addr = 0, fdt_load_addr;
 	void *fdt;
@@ -102,19 +102,13 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 		pr_debug("Loaded initrd at 0x%lx\n", initrd_load_addr);
 	}
 
-	fdt_size = fdt_totalsize(initial_boot_params) * 2;
-	fdt = kmalloc(fdt_size, GFP_KERNEL);
+	fdt = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
+					   initrd_len, cmdline);
 	if (!fdt) {
 		pr_err("Not enough memory for the device tree.\n");
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = fdt_open_into(initial_boot_params, fdt, fdt_size);
-	if (ret < 0) {
-		pr_err("Error setting up the new device tree.\n");
-		ret = -EINVAL;
-		goto out;
-	}
 
 	ret = setup_new_fdt_ppc64(image, fdt, initrd_load_addr,
 				  initrd_len, cmdline);
@@ -124,13 +118,17 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	fdt_pack(fdt);
 
 	kbuf.buffer = fdt;
-	kbuf.bufsz = kbuf.memsz = fdt_size;
+	kbuf.bufsz = kbuf.memsz = fdt_totalsize(fdt);
 	kbuf.buf_align = PAGE_SIZE;
 	kbuf.top_down = true;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
 		goto out;
+
+	/* FDT will be freed in arch_kimage_file_post_load_cleanup */
+	image->arch.fdt = fdt;
+
 	fdt_load_addr = kbuf.mem;
 
 	pr_debug("Loaded device tree at 0x%lx\n", fdt_load_addr);
@@ -145,8 +143,15 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	kfree(modified_cmdline);
 	kexec_free_elf_info(&elf_info);
 
-	/* Make kimage_file_post_load_cleanup free the fdt buffer for us. */
-	return ret ? ERR_PTR(ret) : fdt;
+	/*
+	 * Once FDT buffer has been successfully passed to kexec_add_buffer(),
+	 * the FDT buffer address is saved in image->arch.fdt. In that case,
+	 * the memory cannot be freed here in case of any other error.
+	 */
+	if (ret && !image->arch.fdt)
+		kvfree(fdt);
+
+	return ret ? ERR_PTR(ret) : NULL;
 }
 
 const struct kexec_file_ops kexec_elf64_ops = {
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index e452b11df631..d23e2969395c 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -156,135 +156,11 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
 		  unsigned long initrd_load_addr, unsigned long initrd_len,
 		  const char *cmdline)
 {
-	int ret, chosen_node;
-	const void *prop;
-
-	/* Remove memory reservation for the current device tree. */
-	ret = delete_fdt_mem_rsv(fdt, __pa(initial_boot_params),
-				 fdt_totalsize(initial_boot_params));
-	if (ret == 0)
-		pr_debug("Removed old device tree reservation.\n");
-	else if (ret != -ENOENT)
-		return ret;
-
-	chosen_node = fdt_path_offset(fdt, "/chosen");
-	if (chosen_node == -FDT_ERR_NOTFOUND) {
-		chosen_node = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
-					      "chosen");
-		if (chosen_node < 0) {
-			pr_err("Error creating /chosen.\n");
-			return -EINVAL;
-		}
-	} else if (chosen_node < 0) {
-		pr_err("Malformed device tree: error reading /chosen.\n");
-		return -EINVAL;
-	}
-
-	/* Did we boot using an initrd? */
-	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
-	if (prop) {
-		uint64_t tmp_start, tmp_end, tmp_size;
-
-		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
-
-		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
-		if (!prop) {
-			pr_err("Malformed device tree.\n");
-			return -EINVAL;
-		}
-		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
-
-		/*
-		 * kexec reserves exact initrd size, while firmware may
-		 * reserve a multiple of PAGE_SIZE, so check for both.
-		 */
-		tmp_size = tmp_end - tmp_start;
-		ret = delete_fdt_mem_rsv(fdt, tmp_start, tmp_size);
-		if (ret == -ENOENT)
-			ret = delete_fdt_mem_rsv(fdt, tmp_start,
-						 round_up(tmp_size, PAGE_SIZE));
-		if (ret == 0)
-			pr_debug("Removed old initrd reservation.\n");
-		else if (ret != -ENOENT)
-			return ret;
-
-		/* If there's no new initrd, delete the old initrd's info. */
-		if (initrd_len == 0) {
-			ret = fdt_delprop(fdt, chosen_node,
-					  "linux,initrd-start");
-			if (ret) {
-				pr_err("Error deleting linux,initrd-start.\n");
-				return -EINVAL;
-			}
-
-			ret = fdt_delprop(fdt, chosen_node, "linux,initrd-end");
-			if (ret) {
-				pr_err("Error deleting linux,initrd-end.\n");
-				return -EINVAL;
-			}
-		}
-	}
-
-	if (initrd_len) {
-		ret = fdt_setprop_u64(fdt, chosen_node,
-				      "linux,initrd-start",
-				      initrd_load_addr);
-		if (ret < 0)
-			goto err;
-
-		/* initrd-end is the first address after the initrd image. */
-		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-end",
-				      initrd_load_addr + initrd_len);
-		if (ret < 0)
-			goto err;
-
-		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
-		if (ret) {
-			pr_err("Error reserving initrd memory: %s\n",
-			       fdt_strerror(ret));
-			return -EINVAL;
-		}
-	}
-
-	if (cmdline != NULL) {
-		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
-		if (ret < 0)
-			goto err;
-	} else {
-		ret = fdt_delprop(fdt, chosen_node, "bootargs");
-		if (ret && ret != -FDT_ERR_NOTFOUND) {
-			pr_err("Error deleting bootargs.\n");
-			return -EINVAL;
-		}
-	}
-
-	if (image->type == KEXEC_TYPE_CRASH) {
-		/*
-		 * Avoid elfcorehdr from being stomped on in kdump kernel by
-		 * setting up memory reserve map.
-		 */
-		ret = fdt_add_mem_rsv(fdt, image->arch.elf_headers_mem,
-				      image->arch.elf_headers_sz);
-		if (ret) {
-			pr_err("Error reserving elfcorehdr memory: %s\n",
-			       fdt_strerror(ret));
-			goto err;
-		}
-	}
-
-	ret = setup_ima_buffer(image, fdt, chosen_node);
-	if (ret) {
-		pr_err("Error setting up the new device tree.\n");
-		return ret;
-	}
+	int ret;
 
-	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
+	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
 	if (ret)
-		goto err;
-
-	return 0;
+		pr_err("Error setting up the new device tree.\n");
 
-err:
-	pr_err("Error setting up the new device tree.\n");
-	return -EINVAL;
+	return ret;
 }
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index a05c19b3cc60..dac3d29c7c77 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -1111,5 +1111,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	image->arch.elf_headers = NULL;
 	image->arch.elf_headers_sz = 0;
 
+	kvfree(image->arch.fdt);
+	image->arch.fdt = NULL;
+
 	return kexec_image_post_load_cleanup_default(image);
 }
-- 
2.30.0

