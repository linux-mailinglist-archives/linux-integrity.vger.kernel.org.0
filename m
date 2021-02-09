Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384AE3155E5
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 19:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhBIS0z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 13:26:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57716 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhBISXM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:23:12 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0D4B12020E9E;
        Tue,  9 Feb 2021 10:22:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D4B12020E9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612894950;
        bh=WflOp5qtE/uxr2X9XlYyGOZLtE5UtM9Sb5QFt6ax69I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=by9wusHfgHBCjAxaARM1Sv72lFDtxKLaJfiL4ouob5PKvTLsGrEc3/5MKM1ZmNDxZ
         B5oSmVYWWuXhpt7pSdoYTfdnAwx52iK25CF7gPhuC6brL21tb+FvSM1meQVdk/hO5L
         DI6Sx4a7Mwc1xTmdJ3+c0nuSnq4abCsSsm3QB1uI=
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
Subject: [PATCH v17 02/10] of: Add a common kexec FDT setup function
Date:   Tue,  9 Feb 2021 10:21:52 -0800
Message-Id: <20210209182200.30606-3-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209182200.30606-1-nramas@linux.microsoft.com>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
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
 drivers/of/Makefile |   6 ++
 drivers/of/kexec.c  | 258 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h  |  13 +++
 3 files changed, 277 insertions(+)
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
index 000000000000..469e09613cdd
--- /dev/null
+++ b/drivers/of/kexec.c
@@ -0,0 +1,258 @@
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
+ *
+ * Return: fdt on success, or NULL errno on error.
+ */
+void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
+				   unsigned long initrd_load_addr,
+				   unsigned long initrd_len,
+				   const char *cmdline)
+{
+	void *fdt;
+	int ret, chosen_node;
+	const void *prop;
+	unsigned long fdt_size;
+
+	fdt_size = fdt_totalsize(initial_boot_params) +
+		   (cmdline ? strlen(cmdline) : 0) +
+		   FDT_EXTRA_SPACE;
+
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
+				image->arch.elf_headers_mem,
+				image->arch.elf_headers_sz);
+		if (ret)
+			goto out;
+
+		/*
+		 * Avoid elfcorehdr from being stomped on in kdump kernel by
+		 * setting up memory reserve map.
+		 */
+		ret = fdt_add_mem_rsv(fdt, image->arch.elf_headers_mem,
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
index 4b27c9a27df3..f0eff5e84353 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -560,6 +560,19 @@ int of_map_id(struct device_node *np, u32 id,
 
 phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
 
+/*
+ * Additional space needed for the buffer to build the new FDT
+ * so that we can add initrd, bootargs, kaslr-seed, rng-seed,
+ * userable-memory-range and elfcorehdr.
+ */
+#define FDT_EXTRA_SPACE 0x1000
+
+struct kimage;
+void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
+				   unsigned long initrd_load_addr,
+				   unsigned long initrd_len,
+				   const char *cmdline);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
-- 
2.30.0

