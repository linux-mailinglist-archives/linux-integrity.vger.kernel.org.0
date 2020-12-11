Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277AD2D81A8
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 23:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406579AbgLKWLa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 17:11:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42050 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406469AbgLKWK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 17:10:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id 11so9663606oty.9;
        Fri, 11 Dec 2020 14:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ8Ccd5snkOKXftEHLmAvtNpaBoEgIct3KMYISqIfxE=;
        b=PqTgSimioWrReDOfzuNXnhtVOASK03wW2o0A5vKzmTownoTRK4ng2Shkd6IlFmujOM
         W6X3mGZRKhf/v058WxoWj6DqQ+/F18WcGZwsHlUrhLfT0ot7soLqtAxpyeXq6mQ3pgUr
         FrYmd5Pp4+7bbJ8jYpx9bD14Hi179fNP30Izyb8UMsNybJ1BZbCL7GycnMrGW4Eyd6fI
         KFkws1UhmBGy7xXL7hXNfOc9T/fsKjVsPqGfU7VArv44Vt6ESuykysL3uzpnDVy159Dc
         ACTWfMOzE4Iy61R/jTOvV/E8Px/6U+8gTgVUI/yjKwAeDtyiI2U4ucvZFgKZt2k/CN5l
         u9lw==
X-Gm-Message-State: AOAM531XOfoAMczQqpZpl407+aINiwpZcAZh6PwXKlciFg4+sObNW6Cm
        VqjXuxGCAPTjhwqZDi1Jdw==
X-Google-Smtp-Source: ABdhPJwJVPw/5LLfEpEuoG30HeiPU10Lb6XWXM9GlwC5aXrEoYtbW7QPoKUg1IdOmF8gEdRml2TS7Q==
X-Received: by 2002:a9d:4c8d:: with SMTP id m13mr9281644otf.229.1607724617904;
        Fri, 11 Dec 2020 14:10:17 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id p3sm2137383otf.3.2020.12.11.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 14:10:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        takahiro.akashi@linaro.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        zohar@linux.ibm.com, james.morse@arm.com, sashal@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: [RFC PATCH 2/4] of: Add a common kexec FDT setup function
Date:   Fri, 11 Dec 2020 16:10:04 -0600
Message-Id: <20201211221006.1052453-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211221006.1052453-1-robh@kernel.org>
References: <20201211221006.1052453-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Both arm64 and powerpc do essentially the same FDT /chosen setup for
kexec. We can simply combine everything each arch does. The differences
are either omissions that arm64 should have or additional properties
that will be ignored.

The differences relative to the arm64 version:
- If /chosen doesn't exist, it will be created (should never happen).
- Any old dtb and initrd reserved memory will be released.
- The new initrd and elfcorehdr are marked reserved.
- "linux,booted-from-kexec" is set.

The differences relative to the powerpc version:
- "kaslr-seed" and "rng-seed" may be set.
- "linux,elfcorehdr" is set.
- Any existing "linux,usable-memory-range" is removed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This could be taken a step further and do the allocation of the new
FDT. The difference is arm64 uses vmalloc and powerpc uses kmalloc. The
arm64 version also retries with a bigger allocation. That seems
unnecessary.
---
 drivers/of/Makefile |   1 +
 drivers/of/kexec.c  | 228 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h  |   5 +
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/of/kexec.c

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 6e1e5212f058..8ce11955afde 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
 obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 obj-$(CONFIG_OF_NUMA) += of_numa.o
+obj-$(CONFIG_KEXEC_FILE) += kexec.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
new file mode 100644
index 000000000000..66787be081fe
--- /dev/null
+++ b/drivers/of/kexec.c
@@ -0,0 +1,228 @@
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
+ * of_kexec_setup_new_fdt - modify /chosen and memory reservation for the next kernel
+ *
+ * @image:		kexec image being loaded.
+ * @fdt:		Flattened device tree for the next kernel.
+ * @initrd_load_addr:	Address where the next initrd will be loaded.
+ * @initrd_len:		Size of the next initrd, or 0 if there will be none.
+ * @cmdline:		Command line for the next kernel, or NULL if there will
+ *			be none.
+ *
+ * Return: 0 on success, or negative errno on error.
+ */
+int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
+			   unsigned long initrd_load_addr, unsigned long initrd_len,
+			   const char *cmdline)
+{
+	int ret, chosen_node;
+	const void *prop;
+
+	/* Remove memory reservation for the current device tree. */
+	ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
+				       fdt_totalsize(initial_boot_params));
+	if (ret == -EINVAL)
+		return ret;
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
+		if (!prop)
+			return -EINVAL;
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
+			return ret;
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
+	if (ret)
+		return (ret == -FDT_ERR_NOSPACE) ? -ENOMEM : -EINVAL;
+
+	return 0;
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index 5d51891cbf1a..3375f5295875 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -558,6 +558,11 @@ int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
+struct kimage;
+int of_kexec_setup_new_fdt(const struct kimage *image, void *fdt,
+			   unsigned long initrd_load_addr, unsigned long initrd_len,
+			   const char *cmdline);
+
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
-- 
2.25.1

