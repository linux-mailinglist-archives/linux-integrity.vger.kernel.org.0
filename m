Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64EB31ACE2
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Feb 2021 17:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBMQLq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Feb 2021 11:11:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35600 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBMQLj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Feb 2021 11:11:39 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 790F920B57A1;
        Sat, 13 Feb 2021 08:10:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 790F920B57A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613232657;
        bh=gCSXMABH1ZAm58V0VPugp0Osj/bcVGxUAEzLtNxQSbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2GDivlaTpzlUMasmYVNZ5dD2/K0/zY3nyBZE/OBOstn7HeUNv7didBZrKVG9iRLd
         T4ORtxhticEesWNHSQyjKR7Bi+D2rMJhKKVL6+PLRFpmopB469wWNGIa746N5zWV99
         vYpPMB5b0EAO+Zhiem3wMNMDGCoXCnsXDLySLnJE=
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
Subject: [PATCH v18 03/11] of: Add a common kexec FDT setup function
Date:   Sat, 13 Feb 2021 08:10:41 -0800
Message-Id: <20210213161049.6190-4-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213161049.6190-1-nramas@linux.microsoft.com>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Both arm64 and powerpc do essentially the same FDT /chosen setup for
kexec.  The differences are either omissions that arm64 should have
or additional properties that will be ignored.  The setup code can be
combined and shared by both powerpc and arm64.

The differences relative to the arm64 version:
 - If /chosen doesn't exist, it will be created (should never happen).
 - Any old dtb and initrd reserved memory will be released.
 - The new initrd and elfcorehdr are marked reserved.
 - "linux,booted-from-kexec" is set.

The differences relative to the powerpc version:
 - "kaslr-seed" and "rng-seed" may be set.
 - "linux,elfcorehdr" is set.
 - Any existing "linux,usable-memory-range" is removed.

Combine the code for setting up the /chosen node in the FDT and updating
the memory reservation for kexec, for powerpc and arm64, in
of_kexec_alloc_and_setup_fdt() and move it to "drivers/of/kexec.c".

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 drivers/of/Makefile |   6 +
 drivers/of/kexec.c  | 265 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h  |   5 +
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/of/kexec.c

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 6e1e5212f058..c13b982084a3 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -14,4 +14,10 @@ obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 obj-$(CONFIG_OF_NUMA) += of_numa.o
 
+ifdef CONFIG_KEXEC_FILE
+ifdef CONFIG_OF_FLATTREE
+obj-y	+= kexec.o
+endif
+endif
+
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
new file mode 100644
index 000000000000..264cac0fd4cd
--- /dev/null
+++ b/drivers/of/kexec.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Arm Limited
+ *
+ * Based on arch/arm64/kernel/machine_kexec_file.c:
+ *  Copyright (C) 2018 Linaro Limited
+ *
+ * And arch/powerpc/kexec/file_load.c:
+ *  Copyright (C) 2016  IBM Corporation
+ */
+
+#include <linux/kernel.h>
+#include <linux/kexec.h>
+#include <linux/libfdt.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/random.h>
+#include <linux/types.h>
+
+/* relevant device tree properties */
+#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
+#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
+#define FDT_PROP_INITRD_START	"linux,initrd-start"
+#define FDT_PROP_INITRD_END	"linux,initrd-end"
+#define FDT_PROP_BOOTARGS	"bootargs"
+#define FDT_PROP_KASLR_SEED	"kaslr-seed"
+#define FDT_PROP_RNG_SEED	"rng-seed"
+#define RNG_SEED_SIZE		128
+
+/*
+ * Additional space needed for the FDT buffer so that we can add initrd,
+ * bootargs, kaslr-seed, rng-seed, useable-memory-range and elfcorehdr.
+ */
+#define FDT_EXTRA_SPACE 0x1000
+
+/**
+ * fdt_find_and_del_mem_rsv - delete memory reservation with given address and size
+ *
+ * @fdt:	Flattened device tree for the current kernel.
+ * @start:	Starting address of the reserved memory.
+ * @size:	Size of the reserved memory.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+static int fdt_find_and_del_mem_rsv(void *fdt, unsigned long start, unsigned long size)
+{
+	int i, ret, num_rsvs = fdt_num_mem_rsv(fdt);
+
+	for (i = 0; i < num_rsvs; i++) {
+		u64 rsv_start, rsv_size;
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
+/*
+ * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
+ *
+ * @image:		kexec image being loaded.
+ * @initrd_load_addr:	Address where the next initrd will be loaded.
+ * @initrd_len:		Size of the next initrd, or 0 if there will be none.
+ * @cmdline:		Command line for the next kernel, or NULL if there will
+ *			be none.
+ * @extra_fdt_size:	Additional size for the new FDT buffer.
+ *
+ * Return: fdt on success, or NULL errno on error.
+ */
+void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
+				   unsigned long initrd_load_addr,
+				   unsigned long initrd_len,
+				   const char *cmdline, size_t extra_fdt_size)
+{
+	void *fdt;
+	int ret, chosen_node;
+	const void *prop;
+	size_t fdt_size;
+
+	fdt_size = fdt_totalsize(initial_boot_params) +
+		   (cmdline ? strlen(cmdline) : 0) +
+		   FDT_EXTRA_SPACE +
+		   extra_fdt_size;
+	fdt = kvmalloc(fdt_size, GFP_KERNEL);
+	if (!fdt)
+		return NULL;
+
+	ret = fdt_open_into(initial_boot_params, fdt, fdt_size);
+	if (ret < 0) {
+		pr_err("Error %d setting up the new device tree.\n", ret);
+		goto out;
+	}
+
+	/* Remove memory reservation for the current device tree. */
+	ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
+				       fdt_totalsize(initial_boot_params));
+	if (ret == -EINVAL) {
+		pr_err("Error removing memory reservation.\n");
+		goto out;
+	}
+
+	chosen_node = fdt_path_offset(fdt, "/chosen");
+	if (chosen_node == -FDT_ERR_NOTFOUND)
+		chosen_node = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
+					      "chosen");
+	if (chosen_node < 0) {
+		ret = chosen_node;
+		goto out;
+	}
+
+	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_KEXEC_ELFHDR);
+	if (ret && ret != -FDT_ERR_NOTFOUND)
+		goto out;
+	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_MEM_RANGE);
+	if (ret && ret != -FDT_ERR_NOTFOUND)
+		goto out;
+
+	/* Did we boot using an initrd? */
+	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
+	if (prop) {
+		u64 tmp_start, tmp_end, tmp_size;
+
+		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
+		if (!prop) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+
+		/*
+		 * kexec reserves exact initrd size, while firmware may
+		 * reserve a multiple of PAGE_SIZE, so check for both.
+		 */
+		tmp_size = tmp_end - tmp_start;
+		ret = fdt_find_and_del_mem_rsv(fdt, tmp_start, tmp_size);
+		if (ret == -ENOENT)
+			ret = fdt_find_and_del_mem_rsv(fdt, tmp_start,
+						       round_up(tmp_size, PAGE_SIZE));
+		if (ret == -EINVAL)
+			goto out;
+	}
+
+	/* add initrd-* */
+	if (initrd_load_addr) {
+		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_START,
+				      initrd_load_addr);
+		if (ret)
+			goto out;
+
+		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_INITRD_END,
+				      initrd_load_addr + initrd_len);
+		if (ret)
+			goto out;
+
+		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
+		if (ret)
+			goto out;
+
+	} else {
+		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_START);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+
+		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_INITRD_END);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+	}
+
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* add linux,elfcorehdr */
+		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+				FDT_PROP_KEXEC_ELFHDR,
+				image->arch.elf_load_addr,
+				image->arch.elf_headers_sz);
+		if (ret)
+			goto out;
+
+		/*
+		 * Avoid elfcorehdr from being stomped on in kdump kernel by
+		 * setting up memory reserve map.
+		 */
+		ret = fdt_add_mem_rsv(fdt, image->arch.elf_load_addr,
+				      image->arch.elf_headers_sz);
+		if (ret)
+			goto out;
+
+		/* add linux,usable-memory-range */
+		ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+				FDT_PROP_MEM_RANGE,
+				crashk_res.start,
+				crashk_res.end - crashk_res.start + 1);
+		if (ret)
+			goto out;
+	}
+
+	/* add bootargs */
+	if (cmdline) {
+		ret = fdt_setprop_string(fdt, chosen_node, FDT_PROP_BOOTARGS, cmdline);
+		if (ret)
+			goto out;
+	} else {
+		ret = fdt_delprop(fdt, chosen_node, FDT_PROP_BOOTARGS);
+		if (ret && (ret != -FDT_ERR_NOTFOUND))
+			goto out;
+	}
+
+	/* add kaslr-seed */
+	ret = fdt_delprop(fdt, chosen_node, FDT_PROP_KASLR_SEED);
+	if (ret == -FDT_ERR_NOTFOUND)
+		ret = 0;
+	else if (ret)
+		goto out;
+
+	if (rng_is_initialized()) {
+		u64 seed = get_random_u64();
+
+		ret = fdt_setprop_u64(fdt, chosen_node, FDT_PROP_KASLR_SEED, seed);
+		if (ret)
+			goto out;
+	} else {
+		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
+				FDT_PROP_KASLR_SEED);
+	}
+
+	/* add rng-seed */
+	if (rng_is_initialized()) {
+		void *rng_seed;
+
+		ret = fdt_setprop_placeholder(fdt, chosen_node, FDT_PROP_RNG_SEED,
+				RNG_SEED_SIZE, &rng_seed);
+		if (ret)
+			goto out;
+		get_random_bytes(rng_seed, RNG_SEED_SIZE);
+	} else {
+		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
+				FDT_PROP_RNG_SEED);
+	}
+
+	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
+
+out:
+	if (ret) {
+		kvfree(fdt);
+		fdt = NULL;
+	}
+
+	return fdt;
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index 4b27c9a27df3..d66c915df910 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -560,6 +560,11 @@ int of_map_id(struct device_node *np, u32 id,
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
+struct kimage;
+void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
+				   unsigned long initrd_load_addr,
+				   unsigned long initrd_len,
+				   const char *cmdline, size_t extra_fdt_size);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
-- 
2.30.0

