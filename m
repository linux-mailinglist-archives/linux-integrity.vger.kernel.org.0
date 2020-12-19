Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF142DF0E0
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Dec 2020 18:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgLSR6f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 19 Dec 2020 12:58:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51190 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLSR6U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 19 Dec 2020 12:58:20 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9703720B83F8;
        Sat, 19 Dec 2020 09:57:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9703720B83F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608400660;
        bh=S1gZLw99awaQRS7NJkvSEk2nmr83hjctOQA+vcCw1Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDLXS3DDr8ScMen8XwFjU50tCHdXtR4UYvkZvjnsAkGdoIkjEBXbvQLHzS/1w1vrh
         13FZRwfh3Ypvk0dsodjTtQOQ6s8YIbpxWovntW0oBSHQyREgPumBhUDl/bGQ5KyvAX
         f8hLZIx6uIc8mLIAjvvx8yXGHXjgCEUp+bsYySlA=
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
Subject: [PATCH v13 4/6] powerpc: Delete unused function delete_fdt_mem_rsv()
Date:   Sat, 19 Dec 2020 09:57:11 -0800
Message-Id: <20201219175713.18888-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201219175713.18888-1-nramas@linux.microsoft.com>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

delete_fdt_mem_rsv() defined in "arch/powerpc/kexec/file_load.c"
has been renamed to fdt_find_and_del_mem_rsv(), and moved to
"drivers/of/kexec.c".

Remove delete_fdt_mem_rsv() in "arch/powerpc/kexec/file_load.c".

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 arch/powerpc/include/asm/kexec.h |  1 -
 arch/powerpc/kexec/file_load.c   | 32 --------------------------------
 2 files changed, 33 deletions(-)

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
index 9f3ec0b239ef..f37652ccb8a1 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -109,38 +109,6 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
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
-- 
2.29.2

