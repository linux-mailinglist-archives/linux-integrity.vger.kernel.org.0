Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2EF315628
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhBISjR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 13:39:17 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58426 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhBIS1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 13:27:40 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0385420B57A7;
        Tue,  9 Feb 2021 10:22:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0385420B57A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612894955;
        bh=b5T2RSR3QVHqh0Tc/nRuGDGIWn3kbjEDRVdBwp1oOjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFdv2vzZZpjdFBMSDTycP+rDPv8Jvsz9i9ZI/iLnPNRoasYEh1ejzgZIuVkREbU/7
         cbvG9vms5DIpWKkI4zFc0+takXP6ZPiBDJNuXbqMIZvbhGMrW3qfEz4+BqsmFIj6rO
         Pm11t+meepWVDIl+sdvTIu/r1lk97dQOmXb4tewA=
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
Subject: [PATCH v17 09/10] powerpc: Delete unused function delete_fdt_mem_rsv()
Date:   Tue,  9 Feb 2021 10:21:59 -0800
Message-Id: <20210209182200.30606-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209182200.30606-1-nramas@linux.microsoft.com>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
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
index 2b87993f6e66..e543593da1e1 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -119,7 +119,6 @@ char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 int setup_purgatory(struct kimage *image, const void *slave_code,
 		    const void *fdt, unsigned long kernel_load_addr,
 		    unsigned long fdt_load_addr);
-int delete_fdt_mem_rsv(void *fdt, unsigned long start, unsigned long size);
 
 #ifdef CONFIG_PPC64
 struct kexec_buf;
diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
index bd8b956aafc3..6f75a45f14c5 100644
--- a/arch/powerpc/kexec/file_load.c
+++ b/arch/powerpc/kexec/file_load.c
@@ -107,35 +107,3 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
 
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
-- 
2.30.0

