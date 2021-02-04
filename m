Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A96630F853
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbhBDQn5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 11:43:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52915 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbhBDQnf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 11:43:35 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C73E620B6C4A;
        Thu,  4 Feb 2021 08:42:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C73E620B6C4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612456926;
        bh=eteQoM8TsJLZTpLH4UcJUMfvK8vuu3EMwdBLJt4y9+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCYMWduI56a6WnVybP/MH51bcFWObfPHsX3LqZ74EnxNMZrULXgh05QMEZYrNkcS5
         FwpXUdTmapdyezPwl1/M0kJpgnLz6juQecFOl7RdGUJ19OHiUL3z3XfeV+2RCTqjU2
         06x0mMRFKkbicN4XYXDoU0l5PspNBtA0z5lT+KGA=
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
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v16 10/12] arm64: Use OF alloc and free functions for FDT
Date:   Thu,  4 Feb 2021 08:41:33 -0800
Message-Id: <20210204164135.29856-11-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204164135.29856-1-nramas@linux.microsoft.com>
References: <20210204164135.29856-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

of_alloc_and_init_fdt() and of_free_fdt() have been defined in
drivers/of/kexec.c to allocate and free memory for FDT.

Use of_alloc_and_init_fdt() and of_free_fdt() to allocate and
initialize the FDT, and to free the FDT respectively.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/kernel/machine_kexec_file.c | 37 +++++++-------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 7da22bb7b9d5..7d6cc478f73c 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -29,7 +29,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	vfree(image->arch.dtb);
+	of_free_fdt(image->arch.dtb);
 	image->arch.dtb = NULL;
 
 	vfree(image->arch.elf_headers);
@@ -57,36 +57,19 @@ static int create_dtb(struct kimage *image,
 	cmdline_len = cmdline ? strlen(cmdline) : 0;
 	buf_size = fdt_totalsize(initial_boot_params)
 			+ cmdline_len + DTB_EXTRA_SPACE;
-
-	for (;;) {
-		buf = vmalloc(buf_size);
-		if (!buf)
-			return -ENOMEM;
-
-		/* duplicate a device tree blob */
-		ret = fdt_open_into(initial_boot_params, buf, buf_size);
-		if (ret)
-			return -EINVAL;
-
-		ret = of_kexec_setup_new_fdt(image, buf, initrd_load_addr,
+	buf = of_alloc_and_init_fdt(buf_size);
+	if (!buf)
+		return -ENOMEM;
+	ret = of_kexec_setup_new_fdt(image, buf, initrd_load_addr,
 					     initrd_len, cmdline);
-		if (ret) {
-			vfree(buf);
-			if (ret == -ENOMEM) {
-				/* unlikely, but just in case */
-				buf_size += DTB_EXTRA_SPACE;
-				continue;
-			} else {
-				return ret;
-			}
-		}
-
+	if (!ret) {
 		/* trim it */
 		fdt_pack(buf);
 		*dtb = buf;
+	} else
+		of_free_fdt(buf);
 
-		return 0;
-	}
+	return ret;
 }
 
 static int prepare_elf_headers(void **addr, unsigned long *sz)
@@ -224,6 +207,6 @@ int load_other_segments(struct kimage *image,
 
 out_err:
 	image->nr_segments = orig_segments;
-	vfree(dtb);
+	of_free_fdt(dtb);
 	return ret;
 }
-- 
2.30.0

