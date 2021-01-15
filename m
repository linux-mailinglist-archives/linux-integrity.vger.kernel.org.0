Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060882F8279
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbhAORbH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 12:31:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56516 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387452AbhAORbH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 12:31:07 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5E52B20B6C43;
        Fri, 15 Jan 2021 09:30:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E52B20B6C43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610731826;
        bh=Sd8T0e6P8u+loATpNeokWfqgEz2Z/zfdEmJ6vGkoVO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktUyR6WfaUt3tm6L1bWQ7aEaN75ohK6Vy3cFhF9qh2P/nDpZ1cqHHI6Chl5xnxb+0
         J6n53fRktOiFEmPUfaMCBCKHBprjN5TyV3uEod1uTgFWZ4QPY2VcSqtzGs49ikj/Z8
         XFxb1OIMj9HZMEp8zMm2Tvr8kr5Pwysb7cGvuq18=
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
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 04/10] powerpc: Use common of_kexec_setup_new_fdt()
Date:   Fri, 15 Jan 2021 09:30:11 -0800
Message-Id: <20210115173017.30617-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115173017.30617-1-nramas@linux.microsoft.com>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Rob Herring <robh@kernel.org>

The code for setting up the /chosen node in the device tree
and updating the memory reservation for the next kernel has been
moved to of_kexec_setup_new_fdt() defined in "drivers/of/kexec.c".

Use the common of_kexec_setup_new_fdt() to setup the device tree
and update the memory reservation for kexec for powerpc.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/kexec/file_load.c | 125 ++-------------------------------
 1 file changed, 6 insertions(+), 119 deletions(-)

diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index e452b11df631..956bcb2d1ec2 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/kexec.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <asm/setup.h>
@@ -156,132 +157,18 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
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
+	int ret;
 
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
+	ret = of_kexec_setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
+	if (ret)
+		goto err;
 
-	ret = setup_ima_buffer(image, fdt, chosen_node);
+	ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
 	if (ret) {
 		pr_err("Error setting up the new device tree.\n");
 		return ret;
 	}
 
-	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
-- 
2.30.0

