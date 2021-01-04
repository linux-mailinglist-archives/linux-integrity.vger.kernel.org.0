Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403222E9E15
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jan 2021 20:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbhADT06 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 14:26:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36618 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhADT0z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 14:26:55 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7BD5720B6C44;
        Mon,  4 Jan 2021 11:26:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BD5720B6C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609788374;
        bh=QtA5ZG9+mfQLbU0zgq3RW/Zfvthx1wqVNrJpmA5Xovg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UO/aVBhfFcBbT+AIh8/ntP4BHIxr/pFExVVhnY+M2txpeCr72xP/MUyMKH6DpfMvV
         TMyLdKl6+i6Lkfv6SY9mpCTvlSvEn21MJB/jHk/hXJj8ap6XoyGekraeFlC8kwZi5X
         VYiY+fyWQ40F1m52YpleadWVCKNt0OuPgIDAbPxE=
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
Subject: [PATCH v14 4/6] powerpc: Delete unused functions
Date:   Mon,  4 Jan 2021 11:26:00 -0800
Message-Id: <20210104192602.10131-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104192602.10131-1-nramas@linux.microsoft.com>
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

delete_fdt_mem_rsv() defined in "arch/powerpc/kexec/file_load.c"
has been renamed to fdt_find_and_del_mem_rsv(), and moved to
"drivers/of/kexec.c".

Remove delete_fdt_mem_rsv() in "arch/powerpc/kexec/file_load.c".

Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
remove setup_new_fdt() in "arch/powerpc/kexec/file_load.c".

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/kexec.h  |  4 ---
 arch/powerpc/kexec/file_load.c    | 60 -------------------------------
 arch/powerpc/kexec/file_load_64.c |  4 ++-
 3 files changed, 3 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index dbf09d2f36d0..b8c270e08481 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -123,10 +123,6 @@ char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 int setup_purgatory(struct kimage *image, const void *slave_code,
 		    const void *fdt, unsigned long kernel_load_addr,
 		    unsigned long fdt_load_addr);
-int setup_new_fdt(const struct kimage *image, void *fdt,
-		  unsigned long initrd_load_addr, unsigned long initrd_len,
-		  const char *cmdline);
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 
 #ifdef CONFIG_PPC64
 struct kexec_buf;
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index 9f3ec0b239ef..036c8fb48fc3 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -108,63 +108,3 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 
 	return 0;
 }
-
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
-/*
- * setup_new_fdt - modify /chosen and memory reservation for the next kernel
- * @image:		kexec image being loaded.
- * @fdt:		Flattened device tree for the next kernel.
- * @initrd_load_addr:	Address where the next initrd will be loaded.
- * @initrd_len:		Size of the next initrd, or 0 if there will be none.
- * @cmdline:		Command line for the next kernel, or NULL if there will
- *			be none.
- *
- * Return: 0 on success, or negative errno on error.
- */
-int setup_new_fdt(const struct kimage *image, void *fdt,
-		  unsigned long initrd_load_addr, unsigned long initrd_len,
-		  const char *cmdline)
-{
-	int ret;
-
-	ret = of_kexec_setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
-	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-	pr_err("Error setting up the new device tree.\n");
-	return -EINVAL;
-}
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index a05c19b3cc60..3cab318aa3b9 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -17,6 +17,7 @@
 #include <linux/kexec.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
@@ -944,7 +945,8 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 	struct crash_mem *umem = NULL, *rmem = NULL;
 	int i, nr_ranges, ret;
 
-	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len, cmdline);
+	ret = of_kexec_setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,
+				     cmdline);
 	if (ret)
 		goto out;
 
-- 
2.29.2

